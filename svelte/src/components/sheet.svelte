<script lang="ts">
	import { onMount } from 'svelte';
	import { writable, derived } from 'svelte/store';
	import { metricsStore } from '../store/metrics';
	import type { Metrics } from '../types/metrics';
	import { sendMessage, closeWebSocket } from '../lib/websocket';

	let data = writable<Metrics[]>([]);
	let groupingLevels = writable<number[]>([1, 0]);

	let selectedProduct = writable<string | null>(null);
	let selectedCustomer = writable<string | null>(null);
	let selectedSalesperson = writable<string | null>(null);

	const unsubscribe = metricsStore.subscribe((metrics) => {
		console.log('Received metrics:', metrics);
		if (Array.isArray(metrics)) {

      console.log('Metrics:', metrics);

      
			const formattedMetrics = metrics.map((metric: [string, string, string, number, number]) => ({
        product: metric[0],
				customer: metric[1],
				salesperson: metric[2],
				amount: metric[3],
				groupingLevel: metric[4]
			}));

			data.set(formattedMetrics);
			console.log('Formatted metrics:', formattedMetrics);
		}
	});

	const filteredData = derived(
		[data, selectedProduct, selectedCustomer, selectedSalesperson, groupingLevels],
		([$data, $selectedProduct, $selectedCustomer, $selectedSalesperson, $groupingLevels]) => {
			let filtered: Metrics[] = [];
			if ($selectedProduct) {
				const groupingLevelOne = $data.filter(
					(metric) => metric.groupingLevel === 1 || metric.groupingLevel === 0
				);
				const productIndex = groupingLevelOne.findIndex(
					(metric) => metric.product === $selectedProduct
				);

				if (productIndex !== -1) {
					const beforeProduct = groupingLevelOne.slice(0, productIndex + 1);
					const afterProduct = groupingLevelOne.slice(productIndex + 1);
					const productFiltered = $data.filter(
						(metric) => metric.product === $selectedProduct && metric.groupingLevel === 4
					);
					filtered = beforeProduct.concat(productFiltered, afterProduct);
				} else {
					filtered = groupingLevelOne;
				}
			} else if ($selectedCustomer) {
				filtered = $data.filter(
					(metric) =>
						metric.customer === $selectedCustomer && $groupingLevels.includes(metric.groupingLevel)
				);
			} else if ($selectedSalesperson) {
				filtered = $data.filter(
					(metric) =>
						metric.salesperson === $selectedSalesperson &&
						$groupingLevels.includes(metric.groupingLevel)
				);
			} else {
				filtered = $data.filter((metric) => $groupingLevels.includes(metric.groupingLevel));
			}

			const firstElement = filtered.shift();
			if (firstElement) {
				filtered.push(firstElement);
			}

			return filtered;
		}
	);


  function clearFilters() {
    selectedProduct.set(null);
    selectedCustomer.set(null);
    selectedSalesperson.set(null);
    groupingLevels.set([1, 0]);
  }
	function filterByProduct(product: string) {
		console.log('Filtering by product:', product);
		selectedProduct.set(product);
		selectedCustomer.set(null);
		selectedSalesperson.set(null);
		groupingLevels.set([1, 4]);
	}

	function filterByCustomer(customer: string) {
		console.log('Filtering by customer:', customer);
		selectedCustomer.set(customer);
		selectedProduct.set(null);
    selectedSalesperson.set(null);
		groupingLevels.set([2, 3, 4]);
	}

	function filterBySalesperson(salesperson: string) {
		console.log('Filtering by salesperson:', salesperson);
		selectedSalesperson.set(salesperson);
		selectedCustomer.set(null);
		selectedProduct.set(null);
		groupingLevels.set([3, 4, 5]);
	}

	onMount(() => {
		return () => {
			unsubscribe();
		};
	});
</script>

<div class="p-16 pb-0">
	<h1 class="text-2xl">LiquidTables Prototype</h1>
	<p class="text-gray-500">
		Multi-dimensional roll up table built on WebSockets using Svelte, FastAPI & DuckDB
	</p>
	{#if $filteredData.length > 0}
		<table class="border-separate border-spacing-0 w-full mt-16 border-gray-200 border-b">
			<thead class="sticky top-0 uppercase bg-white shadow-lg">
				<tr class="[&>*]:p-4 [&>*]:text-slate-800 [&>*]:text-sm  [&>th]:border-t">
          {#if $filteredData.some((row) => row.product)}
            <th class={`text-left border-l rounded-tl-lg flex justify-between ${$selectedProduct ? 'font-bold' : 'font-light'}`}> 
              
              Product 

                {#if (!$selectedProduct && ($selectedCustomer || $selectedSalesperson))}
                <a href="#" on:click|preventDefault={() => clearFilters()} class="underline hover:no-underline hover:text-blue-500 text-xs text-blue-500">Show All</a>
                {/if}

            </th>
          {/if}
          {#if $filteredData.some((row) => row.customer)}
            <th class={`text-center ${$selectedCustomer ? 'font-bold' : 'font-light'}`}> Customer </th>
          {/if}
          {#if $filteredData.some((row) => row.salesperson)}
            <th class={`text-center ${$selectedSalesperson ? 'font-bold' : 'font-light'}`}> Sales Person </th>
          {/if}
            {#if $filteredData.some((row) => row.groupingLevel !== 1 && row.groupingLevel !== 0)}
            <th class="text-center font-light">Qty</th>
          {/if}
					<th class="text-black text-right border-r rounded-tr-lg font-light">Amount</th>
				</tr>
			</thead>
			<tbody class="">
				{#each $filteredData as row, index}
					<tr
            groupingLevel={row.groupingLevel}
						class={`p-2 [&>td]:p-2  last:font-bold  odd:bg-gray-50  border [&>td]:border-t
            ${$selectedProduct === row.product && row.groupingLevel !== 0 && 'selected'}`}
					>
						{#if row.product}
							<td  class={`border-l`} colspan={$selectedProduct && row.groupingLevel === 1 ? 4 : 1}>
								<a
									href="#"
									on:click|preventDefault={() => filterByProduct(row.product)}
									class={`underline hover:no-underline hover:text-blue-500 
                  ${$selectedProduct === row.product && row.groupingLevel !== 1 && 'text-gray-300 no-underline hover:text-gray-300 hover:underline'}
                  ${$selectedProduct === row.product && row.groupingLevel === 1 && 'font-bold'}`}
									>
                  
                  {(row.product && row.groupingLevel === 1) ? row.product : 'Invoice no. 1234'}
                  
                </a>
							</td>
						{/if}
						{#if row.customer}
							<td
                width="20%"
								class={`border-l text-center ${$selectedCustomer && 'selected'}`}
								colspan={$selectedCustomer && row.groupingLevel === 2 ? 3 : 1}
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
              width="20%"
              class={`border-l text-center ${$selectedSalesperson && 'selected'}`}
								colspan={$selectedSalesperson && row.groupingLevel === 3 ? 3 : 1}
							>
								<a
									href="#"
									on:click|preventDefault={() => filterBySalesperson(row.salesperson)}
									class="underline hover:no-underline hover:text-blue-500"
									>{row.salesperson && row.groupingLevel !== 3 ? row.salesperson : ''}</a
								>
							</td>
						{/if}
            {#if ((row.groupingLevel !== 1) && (row.salesperson || row.customer || row.product))}

            <td class="text-center border-l p-0" width="15%">
              <input 
              class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none placeholder-gray-400"

              type="number" placeholder="1">
            </td>

            {/if}

              
						<td width="15%" class={`text-right border-r border-l
            ${$selectedProduct === row.product && row.groupingLevel === 1 && 'font-bold'}
            `} colspan={row.groupingLevel === 0 ? 5 : 1}
							>${row.amount ?? ''}</td
						>
					</tr>
				{/each}
			</tbody>
		</table>
	{/if}
</div>

<style>
	.selected {
		background-color: #eef8fe;
    transition: background-color 0.3s ease;
	}
 
  .tr.selected > td:first-child {
    border-top: 1px solid rgb(30, 116, 170);  
  }
</style>
