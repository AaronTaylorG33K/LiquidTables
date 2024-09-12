<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../../components/LiquidTables.svelte';
	$: ({ column, column_value } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;
</script>

<div class="flex flex-col gap-4 container mx-auto mt-4">
	<div class="flex flex-row">
		<div class=" max-h-[50vh] overflow-auto border-gray-200 border">
			<LiquidTables
				groupingLevels={[1, 2, 3, 4, 5]}
				{filterByColumn}
				filterByColumnValue={column_value}
			/>
		</div>
	</div>

	<div class="flex flex-row gap-4">
		<div class="w-1/3 h-[34vh] overflow-auto border border-gray-200">
			<LiquidTables groupingLevels={[0, 1]} filterByColumnValue={column_value} />
		</div>
		<div class="w-1/3 h-[34vh] overflow-auto border border-gray-200">
			<LiquidTables groupingLevels={[0, 2]} filterByColumnValue={column_value} />
		</div>
		<div class="w-1/3 h-[34vh] overflow-auto border border-gray-200">
			<LiquidTables groupingLevels={[0, 3]} filterByColumnValue={column_value} />
		</div>
	</div>
</div>
