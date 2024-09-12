<script lang="ts">
	import LiquidTables from '../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->

<div class="container mx-auto my-4 mt-12">
<h1 class="text-gray-800">Invoice View</h1>
<p>Tables are bound to routes for improved UX of being able to bookmark and share datasets</p>
<div class="flex flex-row ">
<div class=" h-[50vh]  overflow-auto border-gray-200 border ">
     <LiquidTables groupingLevels={[0,4]} />
</div>
</div>
</div>

<div class="container mx-auto my-4 mb-12">
<h1>Reusable & Connected</h1>
<p>Just set groupingLevels to your DuckDB grouping levels, ex. 0, 2. All tables listen to the same metrics store</p>
<div class="flex flex-row gap-4">
	
	<div class="w-1/3 h-[40vh] overflow-auto border border-gray-200">
		<LiquidTables groupingLevels={[0, 1]} />
	</div>
	<div class="w-1/3  h-[40vh] overflow-auto border border-gray-200 ">
		<LiquidTables groupingLevels={[0, 2]} />
	</div>
	<div class="w-1/3 h-[40vh] overflow-auto border border-gray-200">
		<LiquidTables groupingLevels={[0, 3]} />
	</div>
	
</div>
</div>

<style>
	h1 {
		font-size: 2rem;
	}

	p {
		color: lightgray
	}
</style>