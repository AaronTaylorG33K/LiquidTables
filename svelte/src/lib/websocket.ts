// src/lib/websocket.ts
import { metrics } from '../store/metrics';
import type { Metrics } from '../types/metrics';

const ws = new WebSocket('ws://localhost:8000/ws');

ws.onopen = () => {
    console.log('WebSocket connection established');

    // const data: Partial<Metrics> = JSON.parse();
    // console.log('--->', data)
};

ws.onmessage = (event: MessageEvent) => {
    try {
        // const data: Partial<Metrics> = JSON.parse(event.data);

        console.log(event.data);
    } catch (error) {
        console.error('Error parsing message:', error);
    }
};

ws.onclose = () => {
    console.log('WebSocket connection closed');
};

ws.onerror = (error: Event) => {
    console.error('WebSocket error:', error);
};

export default ws