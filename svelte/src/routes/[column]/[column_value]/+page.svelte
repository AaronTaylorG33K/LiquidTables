<script lang="ts">

  import { page } from '$app/stores';
  let { column, column_value } = $page.params;
	import LiquidTables from '../../../components/LiquidTables.svelte';
</script>

<!--- the tables are controllable by passing them an array of the groupin_lists you want to display-->

<div class="border-t-2 border-gray-800 ">
     <LiquidTables groupingLevels={[0,4]} />
</div>
