<script lang="ts">
	import { onMount, createEventDispatcher } from 'svelte';
	import { writable } from 'svelte/store';
	import { metricsStore } from '../store/metrics';
	import { filterData } from '../lib/filtering';
	import { formatData } from '../lib/format';
	import TableHeader from './sheet/TableHeader.svelte';
	import TableBody from './sheet/TableBody.svelte';
	import type { Metrics } from '../types/metrics';

	export const filteredData = writable<Metrics[]>([]);
	export let groupingLevels: number[] = [];
	export const columns = writable<string[]>([]);

	// prevent certain columns from showing
	let notColumns = ['customer_id', 'salesperson_id'];

	const dispatch = createEventDispatcher();

	function getColumns(data: Metrics[]): string[] {
		if (!data || data.length === 0) return [];
		const keys = Object.keys(data[0]);
		return keys.filter((key) => key !== 'groupingLevel' && data.some((row) => row[key] !== null));
	}
	function applyFilter() {
		metricsStore.subscribe((metrics: Partial<Metrics>[]) => {
			if (Array.isArray(metrics)) {
				const formattedMetrics = formatData(metrics);
				const filtered = filterData(formattedMetrics, groupingLevels);
				filteredData.set(filtered);
				let column_keys = getColumns(filtered);
				column_keys = getColumns(filtered).filter((key) => !notColumns.includes(key));
				columns.set(column_keys);
			} else {
				console.error('metrics is not an array:', metrics);
			}

			filteredData.update((data) => {
				if (data.length > 0) {
					const firstRow = data.shift();
					data.push(firstRow);
				}
				return data;
			});
		});
	}

	onMount(() => {
		applyFilter();
		// console.log('LiquidTables mounted', $filteredData);
	});
</script>

<!-- <SearchBar /> in development -->
{#if $filteredData.length > 0}
	<table class="w-full border-b border-separate border-spacing-0 border-gray-200 overflow-y-auto">
		<TableHeader {columns} />
		<TableBody {filteredData} {columns} />
	</table>
{/if}

<style>
	.w-full {
		width: 100%;
	}
	.border-b {
		border-bottom: 1px solid #e5e7eb; /* Tailwind's border-gray-200 */
	}
	.border-separate {
		border-collapse: separate;
	}
	.border-spacing-0 {
		border-spacing: 0;
	}
	.overflow-y-auto {
		overflow-y: auto;
	}
</style>
