<script lang="ts">
	import { writable } from 'svelte/store';
	import { Metrics } from '../../types/metrics';
	export let columns = writable<string[]>([]);
	export let filterByColumn: keyof Metrics | undefined = undefined;
</script>

<thead class="uppercase sticky top-0 bg-white shadow-md z-30">
	<tr>
		{#each $columns as column}
		{@const selected = column === filterByColumn}
			<th
				class={column}
				class:font-medium={selected}
				class:font-light={!selected}
			>
				{#if column === 'invoice_id'}
					<a href="../"
					class="underline"
					>Invoice</a> 
				{:else}
					{column}
				{/if}
			</th>
		{/each}
	</tr>
</thead>

<style>
	th {
		white-space: nowrap;
		padding: 1rem;
	}
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
