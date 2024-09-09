from fastapi import WebSocket, FastAPI, WebSocketDisconnect
from fastapi.responses import HTMLResponse
import duckdb
import json
from scripts.queries import query
from util.connection_manager import ConnectionManager
from decimal import Decimal
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
        cursor.execute(query)
        result = cursor.fetchall()
        initial_message = {
            "data":result
        }
        await websocket.send_text(json.dumps(initial_message, default=str))
        while True:
            try:
                data = await websocket.receive_text()
                received_data = json.loads(data, parse_float=Decimal)
                invoice_id = received_data.get("data").get("invoice_id")
                new_quantity = received_data.get("data").get("new_quantity")
                
                if invoice_id is not None and new_quantity is not None:
                    update_query = "UPDATE invoice SET product_quantity = ? WHERE invoice_id = ?"
                    cursor.execute(update_query, (new_quantity, invoice_id))    
                    conn.commit()
                    cursor.execute(query)
                    updated_result = cursor.fetchall()
                    message_data = {
                        "data": updated_result,
                    }
                    await manager.broadcast(json.dumps(message_data, default=str))
                else:
                    error_message = {"success": False, "error": "Invalid data received"}
                    await websocket.send_text(json.dumps(error_message, default=str))
            except WebSocketDisconnect:
                print("Client disconnected")
                break
            except Exception as e:
                error_message = {"success": False, "error": str(e)}
                await websocket.send_text(json.dumps(error_message))

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        error_message = {"success": False, "error": str(e)}
        await manager.broadcast(json.dumps(error_message))
    finally:
        if conn:
            conn.close()
        await manager.disconnect(websocket)
