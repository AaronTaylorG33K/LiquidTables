<script lang="ts">
	import { formatMoney, sanitize, reString } from '../../lib/format';
	import { sendMessage } from '../../lib/websocket';
	import type { Metrics } from '../../types/metrics';

	import { get } from 'svelte/store';

	export let filteredData: Metrics[] = [];
	export let columns: string[] = [];
	export let filterByColumn: string = '';
	export let filterByColumnValue: string = '';

	const colConfig = [
		{ type: 'invoice_id', input: '' },
		{ type: 'total', input: '' }
	];

	function qtyChange(event: Event, row: { invoice_id: number; quantity: number }) {
		const target = event.target as HTMLInputElement;
		row.quantity = parseInt(target.value);
		sendMessage({ data: { invoice_id: row.invoice_id, new_quantity: row.quantity } });
	}

	console.log(filterByColumn, filterByColumnValue);
</script>

<tbody>
	{#each $filteredData as row, index}
		<tr class={`p-4 group-${row.groupingLevel} index-${index}  odd:bg-gray-50 `}>
			{#each $columns as column}
				{#if column === 'amount'}
					<td width="2%" class={`text-right border-r ${column}`}>
						{formatMoney(Number(row[column])) ?? ''}
					</td>
				{:else if column !== 'quantity' && column !== 'total' && column !== 'invoice_id'}
					<td
						class={`text-left ${column}`}
						class:font-medium={column === filterByColumn ||
							String(row[column]).toLowerCase() === filterByColumnValue.replace('+', ' ')}
						class:font-light={column !== filterByColumn &&
							!(String(row[column]).toLowerCase() === filterByColumnValue.replace('+', ' '))}
					>
						{#if row.groupingLevel !== 0 && !((row.groupingLevel === 1 || row.groupingLevel === 2 || row.groupingLevel === 3) && column === filterByColumn && filterByColumnValue !== '')}
							<a
								href={`/${column}/${sanitize(row[column] ?? '')}`}
								class="whitespace-nowrap text-gray-800 underline hover:no-underline"
								>{row[column] ?? ''}</a
							>
						{/if}
					</td>
				{:else if column === 'invoice_id'}
					<td class="text-center invoice_id">
						<a
							href={`/${column.replace('_id', '')}/${row[column]}`}
							class="text-gray-800 underline hover:no-underline text-center w-full"
							>{row[column] ?? ''}</a
						>
					</td>
				{:else if column === 'quantity' && row.groupingLevel === 4}
					<td class="text-center p-0" width="10%">
						<input
							class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none placeholder-gray-400"
							type="number"
							placeholder="1"
							value={row.quantity}
							on:input={(event) =>
								qtyChange(event, { invoice_id: row.invoice_id, quantity: row.quantity })}
						/>
					</td>
				{:else if column === 'total'}
					<td class={`text-right border-r ${column} whitespace-nowrap`}>
						{#if row.groupingLevel < 1}
							<span
								class="
						text-gray-400 font-light mr-2">Total</span
							>
						{/if}
						{formatMoney(Number(row[column])) ?? ''}
					</td>
				{:else}
					<td class="text-left">
						{row[column] ?? ''}
					</td>
				{/if}
			{/each}
		</tr>
	{/each}
</tbody>

<style>
	td {
		border: 1px solid #ededf4;
		padding: 0.75rem;
		text-align: center;
	}

	tr:last-child {
		position: sticky;
		bottom: 0;
		background-color: #fff;
		font-weight: 500;

		box-shadow: 0px -4px 6px rgba(0, 0, 0, 0.05);
	}

	tr:last-child > td {
		border: none;
		padding: 1rem;
	}

	td.invoice_id {
		text-align: center;
	}
	td.product {
		text-align: left;
		width: 40vw;
	}
	td.total {
		text-align: right;
	}
	td.customer,
	td.salesperson {
		text-align: center;
		width: 15vw;
	}

	td:first-child.customer,
	td:first-child.salesperson {
		text-align: left;
	}
</style>
