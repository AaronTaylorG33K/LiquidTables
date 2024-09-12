<script lang="ts">
	import Selectable from './ColumnFilter.svelte';
	export let columns: string[] = [];
	

</script>

<thead class="uppercase  sticky top-0 bg-white shadow-md  z-30">
	<tr class="">
		{#each $columns as column}
			<th class="text-left justify-between font-light whitespace-nowrap">
				<div class="p-2 pl-4 uppercase">{column.replace(/_/g, ' ')}</div>
				<div class="pl-2"></div>
			</th>
		{/each}
	</tr>
</thead>

<style>
	tr > th {
		border:none
	}
	tr > th {
		padding:0.75rem;
	}
	tr > th:last-child {
		text-align: right;

	}
	/* thead > tr > th:first-child {
		border-left: 1px solid rgba(229, 231, 235, 1);
	} */
</style>
