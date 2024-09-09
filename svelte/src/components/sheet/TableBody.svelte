<!-- TableBody.svelte -->
<script lang="ts">
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
</script>

<tbody>
	{#each $filteredData as row, index}
		<tr
			class={`p-4 group-${row.groupingLevel} index-${index} [&>td]:p-4  last:font-bold  odd:bg-gray-50  border [&>td]:border-t
        ${$selectedProduct === row.product && row.groupingLevel !== 0 && 'selected'}`}
		>
			{#if $show_id && row.groupingLevel > 3}
				<td class="text-center border-l">{row.invoice_id}</td>
			{/if}
			{#if row.product}
				<td
					width="40%"
					class={`border-l`}
					colspan={$selectedProduct && row.groupingLevel === 1 ? 5 : 1}
				>
					<a
						href="#"
						on:click|preventDefault={() => filterByProduct(row.product)}
						class={`underline hover:no-underline hover:text-blue-500 
              ${$selectedProduct === row.product && row.groupingLevel !== 1 && 'text-gray-300 no-underline hover:text-gray-300 hover:underline'}
              ${$selectedProduct === row.product && row.groupingLevel === 1 && 'font-bold'}`}
					>
						{row.product && (row.groupingLevel === 1 || row.groupingLevel === 2)
							? row.product
							: row.product}
					</a>
				</td>
			{/if}

			{#if row.customer}
				<td
					width="15%"
					class={`border-l text-center ${$selectedCustomer && 'selected'}`}
					colspan={$selectedCustomer && row.groupingLevel === 2 ? 5 : 1}
				>
					<a
						href="#"
						on:click|preventDefault={() => filterByCustomer(row.customer)}
						class="underline hover:no-underline hover:text-blue-500"
						>{(row.product && row.customer) ?? ''}</a
					>
				</td>
			{/if}
			{#if row.salesperson}
				<td
					width="15%"
					class={`border-l text-center ${$selectedSalesperson && 'selected'}`}
					colspan={$selectedSalesperson && row.groupingLevel === 3 ? 5 : 1}
				>
					<a
						href="#"
						on:click|preventDefault={() => filterBySalesperson(row.salesperson)}
						class="underline hover:no-underline hover:text-blue-500"
						>{row.salesperson && row.groupingLevel !== 3 ? row.salesperson : ''}</a
					>
				</td>
			{/if}
			{#if row.groupingLevel > 3 && (row.salesperson || row.customer || row.product)}
				<td class="text-center border-l p-0" width="15%">
					<input
						class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none placeholder-gray-400"
						type="number"
						placeholder="1"
						value={row.product_quantity}
					/>
				</td>
			{/if}

			<td
				width="15%"
				class={`text-right border-r border-l
          ${$selectedProduct === row.product && row.groupingLevel === 1 && 'font-bold'}
          `}
				colspan={row.groupingLevel === 0 ? 6 : 1}>${row.amount ?? ''}</td
			>
		</tr>
	{/each}
</tbody>

<style>
	.selected {
		background-color: #eef8fe;
		transition: background-color 0.3s ease;
	}

	.tr.selected > td:first-child {
		border-top: 1px solid rgb(30, 116, 170);
	}
</style>
