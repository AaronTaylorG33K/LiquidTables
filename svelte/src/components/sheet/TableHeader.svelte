<script lang="ts">
	import Selectable from './ColumnFilter.svelte';
	export let columns: string[] = [];
	export let filterByColumn: string = '';
</script>

<thead class="uppercase sticky top-0 bg-white shadow-md z-30">
	<tr>
		{#each $columns as column}
			<th
				class={`whitespace-nowrap p-4 ${column}`}
				class:font-bold={column === filterByColumn}
				class:font-light={column !== filterByColumn}
			>
				
					{#if column !== 'invoice_id' && column !== 'total' && column !== 'quantity'}
						<a href={`/${column}/`} class="text-gray-800 underline hover:no-underline">
							{column.replace(/_/g, ' ')}
						</a> 

					{:else if column === 'invoice_id'}
						<a href={`../`} class="p- text-gray-800 underline hover:no-underline text-center">
							{column.replace(/_/g, ' ')}
						</a>
					{:else}
						{column.replace(/_/g, ' ')}
					{/if}
			</th>
		{/each}
	</tr>
</thead>

<style>
	th.product {
		text-align: left;
		width: 40vw;
	}
	th.total {
		text-align: right;
	}
	th.invoice_id {
		text-align: center;
	}

	th:first-child.customer,
	th:first-child.salesperson {
		text-align: left;
		width: 40vw;
	}
	
</style>
