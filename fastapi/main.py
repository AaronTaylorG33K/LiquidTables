import json
from fastapi import WebSocket, FastAPI
from fastapi.responses import HTMLResponse
import duckdb
from scripts.queries import query
from util.connection_manager import ConnectionManager

app = FastAPI()
manager = ConnectionManager()

@app.get("/")
async def get():
    return HTMLResponse(content='Im not the docs! /docs for more...', status_code=200)

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await manager.connect(websocket)
    conn = None
    try:
        conn = duckdb.connect(database='/var/lib/duckdb/mydatabase.db')
        cursor = conn.cursor()
        while True:
            
            # Work in progress
            
            # Data out
            cursor.execute(query)
            result = cursor.fetchall()
            message_data = {"success": True, "dir": "out", "data": result}
            message_json = json.dumps(message_data, default=str)
            await manager.broadcast(message_json)
            
            # Data in
            data = await websocket.receive_text()
            response_data = {"success": True, "dir": "in", "data": data}
            response_json = json.dumps(response_data, default=str)
            await manager.broadcast(response_json)
            
    except Exception as e:
        error_message = {"success": False, "error": str(e)}
        await manager.broadcast(json.dumps(error_message))
    finally:
        if conn:
            conn.close()
        await manager.disconnect(websocket)
        try:
            await websocket.close()
        except RuntimeError:
            pass