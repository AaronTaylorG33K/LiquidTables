<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../components/LiquidTables.svelte';
	$: ({ column } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;

	let levels = (() => {
		switch (column) {
			case 'invoice':
				return [5, 0];
			case 'customer':
				return [2, 0];
			case 'product':
				return [1, 0];
			case 'salesperson':
				return [3, 0];
			default:
				return [5, 0];
		}
	})();
</script>

<!-- Since we're in a route lets set the grouping level to the all data -->

<div class="container mx-auto my-4 mb-12 mt-12">
	<h1 class="text-3xl">Column View</h1>
	<p class="text-gray-500">
	View all the values of a single column, in this case <b>{column}</b>
	</p>
	<div class="flex flex-row gap-4">
		<div class="w-full h-[40vh] overflow-auto border border-gray-200 mt-12">
			<LiquidTables groupingLevels={levels} {filterByColumn} />
		</div>
	</div>
</div>

