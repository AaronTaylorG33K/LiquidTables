<script lang="ts">
	import { formatMoney, sanitize, reString } from '../../lib/format';
	import { sendMessage } from '../../lib/websocket';
	import type { Metrics } from '../../types/metrics';


	import { get } from 'svelte/store';

	export let filteredData: Metrics[] = [];
	export let columns: string[] = [];



	function qtyChange(event: Event, row: { invoice_id: number; quantity: number }) {
		const target = event.target as HTMLInputElement;
		row.quantity = parseInt(target.value);
		sendMessage({ data: { invoice_id: row.invoice_id, new_quantity: row.quantity } });
	}
</script>

<tbody>
	{#each $filteredData as row, index}
		<tr class={`p-4 group-${row.groupingLevel} index-${index} last:font-bold  odd:bg-gray-50 `}>
			
			{#each $columns as column}
				{#if column === 'amount'}
					<td width="5%" class="text-right border-r">
						{formatMoney(Number(row[column])) ?? ''}
					</td>
				{:else if column === 'customer' || column === 'product' || column === 'salesperson' }
					<td class="text-left">
						<a href={`/${column}/${sanitize(row[column] ?? '')}`}
						class="text-gray-800 underline hover:no-underline"
						>{row[column]}</a>
					</td>

				{:else if column === 'invoice_id'}
				<td class="text-left">
					<a href={`/${column.replace('_id','')}/${row[column]}`}
					class="text-gray-800 underline hover:no-underline"
					>{row[column]}</a>
				</td>
				{:else if column === 'quantity'  && row.groupingLevel !== 0}
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
				{:else if (column === 'total')}
					<td class="text-right border-r">
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

	tr > td {
		border: 1px solid #ededf4;
		padding: 1rem;
	}

	tr.group-0 > td {
		border: none;
	}



</style>
