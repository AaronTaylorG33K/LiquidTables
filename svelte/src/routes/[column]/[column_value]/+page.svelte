<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../../components/LiquidTables.svelte';
	$: ({ column, column_value } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;
</script>




<div class="container mx-auto my-4 mb-12 mt-12">
	<h1 class="text-4xl">Filtered Column View</h1>
	<p class="text-gray-500">
	
    View records that match the filtered value <span class="font-bold capitalize">{column_value.replace('+',' ')}</span> in the column <span class="font-bold capitalize">{column}</span> 
	</p>
	<div class="flex flex-row gap-4">
		<div class="w-full overflow-auto border border-gray-200 mt-12">
			<LiquidTables groupingLevels={[1, 2, 3, 4, 5]} {filterByColumn} filterByColumnValue={column_value} />
		</div>
	</div>
</div>
