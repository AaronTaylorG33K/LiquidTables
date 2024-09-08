import json
from fastapi import WebSocket, FastAPI
from fastapi.responses import HTMLResponse
import duckdb

app = FastAPI()

class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    async def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)

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
            query = """
             SELECT 
                product.product_name,
                customer.customer_name,
                salesperson.salesperson_name,
                SUM(invoice.amount) AS total_sales,
                GROUPING(product.product_name, customer.customer_name, salesperson.salesperson_name) AS grouping_level
            FROM 
                invoice
            JOIN 
                product ON invoice.product_id = product.product_id
            JOIN 
                customer ON invoice.customer_id = customer.customer_id
            JOIN 
                salesperson ON invoice.salesperson_id = salesperson.salesperson_id
            WHERE 
                invoice.invoice_date >= '2023-01-01'
            GROUP BY 
                ROLLUP(product.product_name, customer.customer_name, salesperson.salesperson_name)
            ORDER BY 
                product.product_name, customer.customer_name, salesperson.salesperson_name
            """
            cursor.execute(query)
            result = cursor.fetchall()
            
            
            message_data = {"success": True, "dir": "out", "data": result}
            message_json = json.dumps(message_data, default=str)
            await manager.broadcast(message_json)
            
            # Wait for data from the client
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
            pass  # Ignore if the connection is already closed