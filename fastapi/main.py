from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
from typing import List
from pydantic import BaseModel
from enum import Enum
import json
import duckdb

app = FastAPI()

class ConnectionManager:
    def __init__(self) -> None:
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        self.active_connections.append(websocket)

    async def disconnect(self, websocket: WebSocket):
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
    await websocket.accept()
    await manager.connect(websocket)
    conn = None
    try:
        conn = duckdb.connect(database='/var/lib/duckdb/mydatabase.db')
        while True:
            result = conn.execute('SELECT * FROM invoice').fetchall()
            
            json_data = [
                {
                    "id": row[0],
                    "date": row[1].strftime("%Y-%m-%d %H:%M:%S"),  # Convert date to full datetime stamp
                    "product": row[2],
                    "customer": row[3],
                    "salesperson": row[4],
                    "amount": float(row[5])  # Convert Decimal to float
                }
                for row in result
            ]
            message_data = {"success": True, "data": json_data}
            try:
                message_json = json.dumps(message_data)
                await manager.broadcast(message_json)
            except Exception as e: 
                await manager.broadcast(str(e))
            finally:
                await manager.broadcast(str(result))
            
            # Wait for data from the client
            data = await websocket.receive_text()
            response_data = {"success": True, "data": data}
            response_json = json.dumps(response_data)
            await manager.broadcast(response_json)
    
    except WebSocketDisconnect:
        manager.disconnect(websocket)
        error_message = {"error": "Connection dropped"}
        error_json = json.dumps(error_message)
        await manager.broadcast(error_json)
    
    finally:
        await manager.disconnect(websocket)
        if conn:
            conn.close()