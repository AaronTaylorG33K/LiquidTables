<script lang="ts">
	import { onMount } from 'svelte';
	import { writable } from 'svelte/store';
	import { metricsStore } from '../store/metrics';
	import type { Metrics } from '../types/metrics';
	import { sendMessage, closeWebSocket } from '../lib/websocket';

	let data = writable<any[]>([]);

	// Subscribe to metricsStore to get initial data and updates
	const unsubscribe = metricsStore.subscribe((metrics) => {
		console.log('Received metrics', metrics);
		if (Array.isArray(metrics)) {
			metrics.sort((a, b) => b[4] - a[4]);
      metrics.push(metrics.shift());
			data.set(metrics);
		} else {
			console.error('Received metrics is not an array:', metrics);
		}
	});

	onMount(() => {
		return () => {
			unsubscribe();
		};
	});

	function handleCellChange(rowIndex: number, columnIndex: number, value: string | number | null) {
		// data.update((currentData) => {
		// 	const newData = [...currentData];
		// 	newData[rowIndex][columnIndex] = value;
		// 	return newData;
		// });
		// sendMessage({ type: 'update', row: rowIndex, column: columnIndex, value });
	}

	function onCellChange(event: Event, rowIndex: number, columnIndex: number) {
		const input = event.target as HTMLInputElement;
		handleCellChange(rowIndex, columnIndex, input.value);
	}
</script>

<div class="p-16">
<h1 class="text-2xl">LiquidTables Prototype</h1>
<p class="text-gray-500">Multi-dimensional roll up table built on WebSockets using Svelte, FastAPI & DuckDB</p>
<table class="border-collapse w-full mt-16 border border-gray-100 ">
	<thead class="sticky top-0  uppercase bg-white shadow-lg">
		<tr>
			<th class="p-2 font-light">Product</th>
			<th class="p-2 font-light">Customer</th>
			<th class="p-2 font-light">Salesperson</th>
			<th class="p-2 font-light">Amount</th>
		</tr>
	</thead>
	<tbody>
		{#each $data as row}
      <tr class="p-2 [&>*]:p-2 [&>*]:border [&>*]:border-gray-100">
				<td>{row[0] ?? 'Total Sales'}</td>
				<td>{row[1] ?? ''}</td>
				<td>{row[2] ?? ''}</td>
				<td class="text-right">${row[3] ?? ''}</td>
				<!-- <td>{row[4] ?? 'N/A'}</td> -->
			</tr>
		{/each}
	</tbody>
</table>
</div>