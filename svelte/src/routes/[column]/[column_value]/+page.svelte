<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../../components/LiquidTables.svelte';
	$: ({ column, column_value } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;
</script>

<!-- Since we're in a route lets set the grouping level to the all data -->
<div class="border-t-2 border-gray-800">
	<LiquidTables groupingLevels={[1, 2, 3, 4, 5]} {filterByColumn} filterByColumnValue={column_value} />
</div>
