<script lang="ts">
	import LiquidTables from '../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->



<div class=" h-[50vh]  overflow-auto ">
     <LiquidTables groupingLevels={[0,4]} />
</div>

<div class="flex flex-row border-t-2 border-gray-700">
	<div class="w-1/2  h-[40vh] overflow-auto ">
		<LiquidTables groupingLevels={[0, 2]} />
	</div>
	<div class="w-1/2 h-[40vh] overflow-auto border-l-2 border-gray-700">
		<LiquidTables groupingLevels={[0, 3]} />
	</div>
</div>