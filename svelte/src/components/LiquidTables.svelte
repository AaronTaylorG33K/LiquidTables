<script lang="ts">
	import { page } from '$app/stores';
	import type { Metrics } from '../types/metrics';
	import { writable } from 'svelte/store';
	import { metricsStore } from '../store/metrics';
	import { filterData } from '../lib/filtering';
	import { formatData } from '../lib/format';
	import TableHeader from './LiquidTables/TableHeader.svelte';
	import TableBody from './LiquidTables/TableBody.svelte';

	export const filteredData = writable<Metrics[]>([]);

	export const columns = writable<string[]>([]);
	export let groupingLevels: number[] = [];
	export let filterByColumn: string = '';
	export let filterByColumnValue: string = '';

	let hideColumns = ['customer_id', 'salesperson_id'];

	function getColumns(data: Metrics[]): string[] {
		if (!data || data.length === 0) return [];
		const keys = Object.keys(data[0]);
		return keys.filter((key) => key !== 'groupingLevel' && data.some((row) => row[key] !== null));
	}

	function applyFilter() {
		metricsStore.subscribe((metrics: Partial<Metrics>[]) => {
			if (Array.isArray(metrics)) {
				let formattedMetrics = formatData(metrics);
				const filtered = filterData(
					formattedMetrics,
					groupingLevels,
					filterByColumn,
					filterByColumnValue
				);
				filteredData.set(filtered);
				let column_keys = getColumns(filtered);
				column_keys = getColumns(filtered).filter((key) => !hideColumns.includes(key));
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

	$: {
		// I'm using the page routing to filter the data
		// This makes easy to navigate nested levels of data
		const { params } = $page;
		const filterByColumn = params.column as keyof Metrics;
		const filterByColumnValue = params.column_value;
		applyFilter(filterByColumn, filterByColumnValue);
	}
</script>

<table class="w-full">
	<TableHeader {columns} {filterByColumn} />
	<TableBody {filteredData} {columns} {filterByColumn} {filterByColumnValue} />
</table>
