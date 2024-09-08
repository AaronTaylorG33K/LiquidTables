<script lang="ts">
    import { onMount } from 'svelte';
    import { writable, derived } from 'svelte/store';
    import { metricsStore } from '../store/metrics';
    import type { Metrics } from '../types/metrics';
    import { sendMessage, closeWebSocket } from '../lib/websocket';

    let data = writable<Metrics[]>([]);
    let groupingLevels = writable<number[]>([1,0]);

    let selectedProduct = writable<string | null>(null);
    let selectedCustomer = writable<string | null>(null);
    let selectedSalesperson = writable<string | null>(null);

    // Subscribe to metricsStore to get initial data and updates
    const unsubscribe = metricsStore.subscribe((metrics) => {
        console.log('Received metrics:', metrics);
        if (Array.isArray(metrics)) {
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

    // Derived store to filter data based on selected product, customer, salesperson, and grouping levels
    const filteredData = derived(
        [data, selectedProduct, selectedCustomer, selectedSalesperson, groupingLevels],
        ([$data, $selectedProduct, $selectedCustomer, $selectedSalesperson, $groupingLevels]) => {
            let filtered: Metrics[] = [];
            if ($selectedProduct) {
                // Filter for groupingLevel 1
                const groupingLevelOne = $data.filter(
                    (metric) => metric.groupingLevel === 1 || metric.groupingLevel === 0
                );

                // Find the index of the clicked product
                const productIndex = groupingLevelOne.findIndex(
                    (metric) => metric.product === $selectedProduct
                );

                if (productIndex !== -1) {
                    // Split the original list at the clicked product position
                    const beforeProduct = groupingLevelOne.slice(0, productIndex + 1);
                    const afterProduct = groupingLevelOne.slice(productIndex + 1);

                    // Filter for groupingLevel 4 for the selected product
                    const productFiltered = $data.filter(
                        (metric) =>
                            metric.product === $selectedProduct && metric.groupingLevel === 4
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

            // filtered.push(filtered.shift());
            const firstElement = filtered.shift()
            if(firstElement){
                filtered.push(firstElement)
            }

            return filtered;
        }
    );

    function filterByProduct(product: string) {
        console.log('Filtering by product:', product);
        selectedProduct.set(product);
        selectedCustomer.set(null); // Clear customer filter
        selectedSalesperson.set(null); // Clear salesperson filter
        groupingLevels.set([1, 4]);
    }

    function filterByCustomer(customer: string) {
        console.log('Filtering by customer:', customer);
        selectedCustomer.set(customer);
        selectedProduct.set(null);
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

<div class="p-16">
    <h1 class="text-2xl">LiquidTables Prototype</h1>
    <p class="text-gray-500">
        Multi-dimensional roll up table built on WebSockets using Svelte, FastAPI & DuckDB
    </p>
    {#if $filteredData.length > 0}
        <table class="border-collapse w-full mt-16 border border-gray-100">
            <thead class="sticky top-0 uppercase bg-white shadow-lg">
                <tr class="[&>*]:p-2 [&>*]:text-slate-800 [&>*]:text-sm [&>*]:font-light">
                    {#if $filteredData.some(row => row.product)}
                        <th class="text-left">
                            Product
                        </th>
                    {/if}
                    {#if $filteredData.some(row => row.customer)}
                        <th>
                            Customer
                        </th>
                    {/if}
                    {#if $filteredData.some(row => row.salesperson)}
                        <th>
                            Sales Person
                        </th>
                    {/if}
                    <th class="text-black text-right">Amount</th>
                </tr>
            </thead>
            <tbody>
                {#each $filteredData as row}
                    <tr class="p-2 [&>*]:p-2 [&>*]:border [&>*]:border-gray-100 odd:bg-gray-50">
                        {#if row.product}
                            <td class={$selectedProduct === row.product ? 'border-t border-l border-r border-2 border-slate-600 ' :''}>
                                <a
                                    href="#"
                                    on:click|preventDefault={() => filterByProduct(row.product)}
                                    class={`underline hover:no-underline hover:text-slate-600 ${($selectedProduct === row.product && row.groupingLevel !== 1) ? 'text-gray-300':''}`}>{(row.product) ? row.product :  row.customer }</a>
                            </td>
                        {:else}
                            <td></td>
                        {/if}
                            <td >
                                <a
                                    href="#"
                                    on:click|preventDefault={() => filterByCustomer(row.customer)}
                                    class="underline hover:no-underline hover:text-slate-600">{(row.product && row.customer) ?? ''}</a>
                            </td>
                    
                            <td>
                                <a
                                    href="#"
                                    on:click|preventDefault={() => filterBySalesperson(row.salesperson)}
                                    class="underline hover:no-underline hover:text-slate-600">{row.salesperson ?? ''}</a>
                            </td>
                     
                        <td class="text-right">${row.amount ?? ''}</td>
                    </tr>
                {/each}
            </tbody>
        </table>
    {/if}
</div>