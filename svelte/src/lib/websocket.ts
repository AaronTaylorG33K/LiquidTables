import { writable } from 'svelte/store';
import { metricsStore } from '../store/metrics';
import type { Metrics } from '../types/metrics';

const ws = new WebSocket('ws://localhost:8000/ws');
const websocketStore = writable(ws);

export let status = 'disconnected';
ws.onopen = () => {
    console.log('WebSocket connection established');
    status = 'connected';
};

ws.onmessage = (event: MessageEvent) => {
    status = 'connected'
    try {

        const response: { data: Partial<Metrics> } = JSON.parse(event.data);
        metricsStore.set(response.data);
        
    } catch (error) {
        console.error('Error parsing message:', error);
    }
};

ws.onclose = () => {
    console.log('WebSocket connection closed');
    status = 'disconnected';
};

ws.onerror = (error: Event) => {
    console.error('WebSocket error:', error);
    status = 'disconnected';
};

export function sendMessage(message: Partial<Metrics>) {
    if (ws.readyState === WebSocket.OPEN) {
        ws.send(JSON.stringify(message));
    } else {
        console.error('WebSocket is not open. Ready state:', ws.readyState);
    }
}

export function subscribe(callback: (message: Partial<Metrics>) => void) {
    const unsubscribe = metricsStore.subscribe(callback);
    return unsubscribe;
}

export function closeWebSocket() {
    if (ws.readyState === WebSocket.OPEN || ws.readyState === WebSocket.CONNECTING) {
        ws.close();
    }
}

export function getConnectionStatus() {
    return status;
}

export default websocketStore;
