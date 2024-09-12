import { writable, type Writable } from 'svelte/store';
import { data } from './filtering';
import { metricsStore } from '../store/metrics';
import type { Metrics } from '../types/metrics';
import { formatData } from './format';

let ws: WebSocket | null = null;
const retryInterval = 10000; // 10 seconds
const status: Writable<string> = writable('disconnected');

const websocketStore = writable<WebSocket | null>(null);


function initializeWebSocket() {
	ws = new WebSocket('ws://localhost:8000/ws');
	websocketStore.set(ws);

	ws.onopen = () => {
		status.set('connected');
	};

	ws.onmessage = (event: MessageEvent) => {
		status.set('connected');
		try {
			const response: { data: Partial<Metrics> } = JSON.parse(event.data);
			try {
				const data = response.data;
				//TODO: debug typescript issue
				


				metricsStore.set(data);
			} catch (error) {
				console.error('Error updating local store:', error);
			}
		} catch (error) {
			console.warn('Error parsing metrics:', error);
		}
	};

	ws.onclose = () => {
		status.set('disconnected');
		retryConnection();
	};

	ws.onerror = (error: Event) => {
		console.warn('WebSocket error:', error);
	};
}

function retryConnection() {
	setTimeout(() => {
		console.log('Attempting to reconnect...');
		initializeWebSocket();
	}, retryInterval);
}

export function sendMessage(message: object) {
	if (ws?.readyState === WebSocket.OPEN) {
		ws.send(JSON.stringify(message));
	}
}

export function updateQuantity(invoice_id: number, new_quantity: number) {
	const payload = {
		data: {
			invoice_id: invoice_id,
			new_quantity: new_quantity
		}
	};
	sendMessage(payload);
}

export function subscribe(callback: (message: Partial<Metrics>) => void) {
	const unsubscribe = metricsStore.subscribe(callback);
	return unsubscribe;
}

export function closeWebSocket() {
	if (ws?.readyState === WebSocket.OPEN || ws?.readyState === WebSocket.CONNECTING) {
		ws.close();
	}
}

export function getConnectionStatus() {
	return status;
}


// export function formatData(metrics: (Partial<Metrics> | [string, string, string, number, number, number, number, number, number])[]): Metrics[] {
//     if (Array.isArray(metrics)) {
//         return metrics.map(
//             (metric: Partial<Metrics> | [string, string, string, number, number, number, number, number, number]) => {
//                 if (Array.isArray(metric)) {
//                     return {
//                         product: metric[0],
//                         customer: metric[1],
//                         salesperson: metric[2],
//                         invoice_id: metric[3],
//                         customer_id: metric[4],
//                         salesperson_id: metric[5],
//                         quantity: metric[6],
//                         amount: metric[7],
//                         groupingLevel: metric[8]
//                     };
//                 } else {
//                     return metric as Metrics;
//                 }
//             }
//         );
//     } else {
//         console.error('metrics is not an array:', metrics);
//         return [];
//     }
// }

metricsStore.subscribe((metrics: (Partial<Metrics> | [string, string, string, number, number, number, number, number, number])[]) => {
    const formattedMetrics = formatData(metrics);
    data.set(formattedMetrics);
});



initializeWebSocket();

export { status };
export default websocketStore;
