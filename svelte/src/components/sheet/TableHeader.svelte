<script lang="ts">
	import Selectable from './ColumnFilter.svelte';
	export let columns: string[] = [];
	export let filterByColumn: string = '';
</script>

<thead class="uppercase sticky top-0 bg-white shadow-md z-30">
	<tr class="">
		{#each $columns as column}
			<th
				class="text-left justify-between whitespace-nowrap"
				class:font-bold={column === filterByColumn}
				class:font-light={column !== filterByColumn}
			>
				<div class="p-2 uppercase">
					{#if column !== 'invoice_id' && column !== 'total' && column !== 'quantity'}
						<a href={`/${column}/`} class="text-gray-800 underline hover:no-underline">
							{column.replace(/_/g, ' ')}
						</a>
					{:else}
						{column.replace(/_/g, ' ')}
					{/if}
				</div>
			</th>
		{/each}
	</tr>
</thead>

<style>
	tr > th {
		border: none;
		text-align: center;
	}
	tr > th:first-child {
		text-align: left;
		width: 10vw;
	}
	tr > th:nth-child(2) {
		width: 40vw;
		text-align: left;
	}
	tr > th {
		padding: 0.5rem;
	}

	tr > th:last-child {
		text-align: right;
		width: 10vw;
	}
</style>
