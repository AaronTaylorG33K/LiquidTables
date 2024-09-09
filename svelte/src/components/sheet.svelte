<script lang="ts">
	import { onMount } from 'svelte';
	import { metricsStore } from '../store/metrics';
	import { data, filteredData } from '../lib/filtering';
	import TableHeader from './sheet/TableHeader.svelte';
	import TableBody from './sheet/TableBody.svelte';
	const unsubscribe = metricsStore.subscribe((metrics) => {
		if (Array.isArray(metrics)) {
			const formattedMetrics = metrics.map(
				(metric: [string, string, string, number, number, number, number, number, number]) => ({
					product: metric[0],
					customer: metric[1],
					salesperson: metric[2],
					invoice_id: metric[3],
					customer_id: metric[4],
					salesperson_id: metric[5],
					quantity: metric[6],
					amount: metric[7],
					groupingLevel: metric[8]
				})
			);
			data.set(formattedMetrics);
		}
	});

	onMount(() => {
		return () => {
			unsubscribe();
		};
	});
</script>

<div class="p-16 pb-0">
	<h1 class="text-2xl">LiquidTables Prototype</h1>
	<p class="text-gray-500">
		Multi-dimensional roll up table built on WebSockets using Svelte, FastAPI & DuckDB
	</p>
	{#if $filteredData.length > 0}
		<table class="border-separate border-spacing-0 w-full mt-16 border-gray-200 border-b">
			<TableHeader />
			<TableBody />
		</table>
	{/if}
</div>
