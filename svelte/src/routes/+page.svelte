<script lang="ts">
	import LiquidTables from '../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->
<div class="container">
	<div class="primaryTable">
		<LiquidTables groupingLevels={[0, 4]} />
	</div>

	<div class="subTables">
		<div>
			<LiquidTables groupingLevels={[0, 1]} />
		</div>
		<div>
			<LiquidTables groupingLevels={[0, 2]} />
		</div>
		<div>
			<LiquidTables groupingLevels={[0, 3]} />
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
		min-height: 20vh;
		overflow: auto;
		border: 1px solid #e2e8f0;
	}
	.subTables {
		display: flex;
		flex-direction: row;
		gap: 1rem;
	}
	.subTables > div {
		width: 33.3333%;
		height: 34vh;
		overflow: auto;
		border: 1px solid #e2e8f0;
	}
</style>
