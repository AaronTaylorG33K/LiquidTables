<script lang="ts">
	import LiquidTables from '../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->

<div class="flex flex-row">
	<div class="w-3/5 border-r-2 border-gray-800">
		<LiquidTables groupingLevels={[0, 2]} />
	</div>
	<div class="w-2/5">
		<LiquidTables groupingLevels={[0, 3]} />
	</div>
</div>

<div class="border-t-2 border-gray-800 ">
     <LiquidTables groupingLevels={[0,4]} />
</div>
