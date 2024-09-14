<script lang="ts">
	import { page } from '$app/stores';
	let { column, column_value } = $page.params;
	import LiquidTables from '../../../components/LiquidTables.svelte';
	$: ({ column, column_value } = $page.params);
	$: filterByColumn = column === 'invoice' ? 'invoice_id' : column;
</script>

<div class="container">
	<div class="primaryTable">
		<LiquidTables
			groupingLevels={[1, 2, 3, 4, 5]}
			{filterByColumn}
			filterByColumnValue={column_value}
		/>
	</div>

  <!--- little bit of tailwind magic -->
	<div class="subTables flex flex-col lg:flex-row w-full [&>div]:w-full lg:[&>div]:w-1/3 ">
		<div>
			<LiquidTables groupingLevels={[0, 1]} filterByColumnValue={column_value} />
		</div>
		<div>
			<LiquidTables groupingLevels={[0, 2]} filterByColumnValue={column_value} />
		</div>
		<div>
			<LiquidTables groupingLevels={[0, 3]} filterByColumnValue={column_value} />
		</div>
	</div>
</div>

<style>
	.container {
		display: flex;
		flex-direction: column;
		gap: 1rem;
		margin-left: auto;
		margin-right: auto;
	}
	.primaryTable {
		display: flex;
		flex-direction: column;
		gap: 1rem;
		margin-top: 1rem;
    max-height: 50vh;
    min-height: 24vh;
    overflow: auto;
    border: 1px solid #e2e8f0;
	}
	.subTables {
		gap: 1rem;
    width:100%;
	}
	.subTables > div {
		height: 34vh;
		overflow: auto;
		border: 1px solid #e2e8f0;
	}
</style>
