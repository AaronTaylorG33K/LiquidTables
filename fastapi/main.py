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
            result = conn.execute('''
            SELECT
                product.product_name,
                customer.customer_name,
                salesperson.salesperson_name,
                SUM(invoice.amount) AS total_amount
            FROM invoice
            JOIN product ON invoice.product_id = product.product_id
            JOIN customer ON invoice.customer_id = customer.customer_id
            JOIN salesperson ON invoice.salesperson_id = salesperson.salesperson_id
            GROUP BY GROUPING SETS (
                (product.product_name, customer.customer_name, salesperson.salesperson_name),
                (product.product_name, customer.customer_name),
                (product.product_name, salesperson.salesperson_name),
                (customer.customer_name, salesperson.salesperson_name),
                (product.product_name),
                (customer.customer_name),
                (salesperson.salesperson_name),
            );''').fetchall()
            
            
            json_data = [
                {
                    "product": row[0],
                    "customer": row[1],
                    "salesperson": row[2],
                    "amount": float(row[3])  # Convert Decimal to float
                }
                for row in result
            ]
            message_data = {"success": True, "data": json_data}
            try:
                message_json = json.dumps(message_data)
                await manager.broadcast(message_json)
            except Exception as e: 
                await manager.broadcast(str(e))
            
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