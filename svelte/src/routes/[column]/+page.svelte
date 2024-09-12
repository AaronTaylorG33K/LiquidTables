<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../components/LiquidTables.svelte';
	$: ({ column } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;

	let levels = (() => {
		switch (column) {
			case 'invoice': return [5, 0];
			case 'customer': return [2, 0];
			case 'product': return [1, 0];
			case 'salesperson': return [3, 0];
			default: return [5, 0];
		}
	})();


</script>

<!-- Since we're in a route lets set the grouping level to the all data -->
<div class="border-t-2 border-gray-800">
	<LiquidTables groupingLevels={levels} {filterByColumn}  />
</div>
