<script lang="ts">
	import { writable } from 'svelte/store';
	export let columns = writable<string[]>([]);
	export let filterByColumn: string = '';
</script>

<thead class="uppercase sticky top-0 bg-white shadow-md z-30">
	<tr>
		{#each $columns as column}
			<th
				class={`whitespace-nowrap p-4 ${column}`}
				class:font-medium={column === filterByColumn}
				class:font-light={column !== filterByColumn}
			>
				{column.replace(/_/g, ' ')}
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
