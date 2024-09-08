from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
from typing import List
from pydantic import BaseModel
from enum import Enum
import json
import duckdb
import asyncio

app = FastAPI()


# In-memory data to simulate sales and inventory


# Simple HTML page to test the WebSocket

class ConnectionManager:
    def __init__(self) -> None:
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        # Add the WebSocket to the list of active connections
        self.active_connections.append(websocket)

    async def disconnect(self, websocket: WebSocket):
        # Remove the WebSocket from the list of active connections
        self.active_connections.remove(websocket)

    async def send_personal_message(self, msg: str, websocket: WebSocket):
        await websocket.send_text(msg)

    async def broadcast(self, msg: str):
        for connection in self.active_connections:
            await connection.send_text(msg)


manager = ConnectionManager()

@app.get("/")
async def get():
    return HTMLResponse(content='Im not the docs! /docs for more...', status_code=200)


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()  # Accept the WebSocket connection
    await manager.connect(websocket)
    conn = None
    try:
        # Open DuckDB connection
        conn = duckdb.connect(database='/var/lib/duckdb/mydatabase.db')
        while True:
            # Poll data from DuckDB and send to clients every 5 seconds
            result = conn.execute('SELECT * FROM invoice').fetchall()
            # Convert the 'date' object to a string representation
            message_data = {"success": True, "data": result}
            try:
                message_json = json.dumps(message_data)
                await manager.broadcast(message_json)
            except Exception as e: 
                await manager.broadcast(str(e))
            finally:
                await manager.broadcast(str(result))
            
            # message_data = {"success": True, "data": result}
            # message_json = json.dumps(message_data)
            # await manager.broadcast(str(result))
            
            # Wait for data from the client
            data = await websocket.receive_text()
            response_data = {"success": True, "data": data}
            response_json = json.dumps(response_data)
            await manager.broadcast(response_json)
            
            # Optional: Add a delay between updates
            await asyncio.sleep(2)
    
    except WebSocketDisconnect:
        manager.disconnect(websocket)
        error_message = {"error": "Connection dropped"}
        error_json = json.dumps(error_message)
        await manager.broadcast(error_json)
    
    finally:
        await manager.disconnect(websocket)
        if conn:
            conn.close()