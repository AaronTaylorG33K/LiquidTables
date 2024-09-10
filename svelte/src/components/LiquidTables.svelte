<script lang="ts">
	import { onMount } from 'svelte';
	import { metricsStore } from '../store/metrics';
	import { data, filteredData } from '../lib/filtering';
	import TableHeader from './sheet/TableHeader.svelte';
	import TableBody from './sheet/TableBody.svelte';
	import type { Metrics } from '../types/metrics';
	import SearchBar from './search/index.svelte';

	onMount(() => {
		return () => {
		};
	});
</script>

<div class="p-16 pb-0">
	<h1 class="text-2xl">LiquidTables Prototype</h1>
	<p class="text-gray-500">
		Multi-dimensional roll up table built on WebSockets using Svelte, FastAPI & DuckDB
	</p>
	<!-- <SearchBar /> in development -->
	{#if $filteredData.length > 0}
		<table class="border-separate border-spacing-0 w-full mt-16 border-gray-200 border-b mb-16">
		<TableHeader />
		<TableBody />
		</table>
	{/if}
</div>
