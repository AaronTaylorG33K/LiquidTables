<script lang="ts">
	import LiquidTables from '../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->
<div class="flex flex-col gap-4 container mx-auto mt-4">

<div class="flex flex-row">
<div class=" h-[50vh]  overflow-auto border-gray-200 border ">
     <LiquidTables groupingLevels={[0,4]} />
</div>
</div>

<div class="">
<div class="flex flex-row gap-4">
	
	<div class="w-1/3 h-[34vh] overflow-auto border border-gray-200">
		<LiquidTables groupingLevels={[0, 1]} />
	</div>
	<div class="w-1/3  h-[34vh] overflow-auto border border-gray-200 ">
		<LiquidTables groupingLevels={[0, 2]} />
	</div>
	<div class="w-1/3 h-[34vh] overflow-auto border border-gray-200">
		<LiquidTables groupingLevels={[0, 3]} />
	</div>
	
</div>
</div>
</div>
