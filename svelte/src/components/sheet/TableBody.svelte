<!-- TableBody.svelte -->
<script lang="ts">
	import { formatMoney } from '../../lib/format';
	import {
		filteredData,
		filterByProduct,
		filterByCustomer,
		filterBySalesperson,
		show_id,
		selectedProduct,
		selectedCustomer,
		selectedSalesperson
	} from '../../lib/filtering';
	import { sendMessage } from '../../lib/websocket';

	function qtyChange(event: Event, row: { invoice_id: number; quantity: number }) {
		const target = event.target as HTMLInputElement;
		row.quantity = parseInt(target.value);
		sendMessage({ data: { invoice_id: row.invoice_id, new_quantity: row.quantity } });
	}
</script>

<tbody>
	{#each $filteredData as { invoice_id, quantity, groupingLevel: level, product, customer, salesperson, amount }, index}
		<tr
			class={`p-4 group-${level} index-${index} last:font-bold  odd:bg-gray-50  border [&>td]:border-t [&>td]:border-l 
				${$selectedProduct === product && level !== 0 && 'selected'}`}
		
		>
			{#if $show_id && level > 3}
				<td class="text-center">{invoice_id}</td>
			{/if}

			{#if product}
				<td width="40%" colspan={$selectedProduct && level === 1 ? 5 : 1}>
					<button
						on:click|preventDefault={() => filterByProduct(product)}
						class={`underline hover:no-underline hover:text-blue-500 ${$selectedProduct === product && level === 1 && 'font-bold'}`}
					>
						{product && (level === 1 || level === 2) ? product : product}

						{level > 3 ? ` Case @ ${formatMoney(amount / quantity)}` : ''}
					</button>
				</td>
			{/if}

			{#if customer}
				<td
					width="15%"
					class={`text-center ${$selectedCustomer && 'selected'}`}
					colspan={$selectedCustomer && level === 2 ? 5 : 1}
				>
					<button
						on:click|preventDefault={() => filterByCustomer(customer)}
						class="underline hover:no-underline hover:text-blue-500"
						>{(product && customer) ?? ''}</button
					>
				</td>
			{/if}

			{#if salesperson}
				<td
					width="15%"
					class={` text-center ${$selectedSalesperson && 'selected'}`}
					colspan={$selectedSalesperson && level === 3 ? 5 : 1}
				>
					<button
						on:click|preventDefault={() => filterBySalesperson(salesperson)}
						class="underline hover:no-underline hover:text-blue-500"
						>{salesperson && level !== 3 ? salesperson : ''}</button
					>
				</td>
			{/if}

			{#if level > 3 && (salesperson || customer || product)}
				<td class="text-center p-0" width="15%">
					<input
						class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none placeholder-gray-400"
						type="number"
						placeholder="1"
						value={quantity}
						on:input={(event) => qtyChange(event, { invoice_id, quantity })}
					/>
				</td>
			{/if}

			<td
				width="15%"
				class={`text-right border-r ${$selectedProduct === product && level === 1 && 'font-bold'} `}
				colspan={level === 0 ? 6 : 1}
				>{formatMoney(Number(amount)) ?? ''}
			</td>
		</tr>
	{/each}
</tbody>

<style>
	.selected {
		background-color: #eef8fe;
		transition: background-color 0.3s ease;
	}

	.selected.group-1 {
		box-shadow: 0px 0px 7px 4px rgba(0, 0, 0, 0.05);
		position: relative;
		z-index: 10;
		border-bottom: 1px solid #ccc;
	}
	.selected.group-1 > td {
		border-top: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
		background-color: #fff;
	}

	.selected > td {
		border-color: #e5e7eb;
	}


	.selected.group-2 > td {
		border-top: 1px solid #e5e7eb;
		border-bottom: 1px solid #e5e7eb;
	}
	.selected.group-4 > td {
		border-top: none;
		border-bottom: 1px solid #e5e7eb;
	}

	td.selected {
		border-color: #e5e7eb;
	}

	td {
		padding: 1rem;
	}
	.tr.selected > td:first-child {
		border-top: 1px solid rgb(30, 116, 170);
	}


</style>
