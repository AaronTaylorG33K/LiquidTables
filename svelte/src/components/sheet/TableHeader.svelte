<!-- TableHeader.svelte -->
<script lang="ts">
	import {
		filteredData,
		show_id,
		selectedProduct,
		selectedCustomer,
		selectedSalesperson,
		clearFilters
	} from '../../lib/filtering';
</script>

<thead class="sticky top-0 uppercase bg-white shadow-lg">
	<tr class="[&>*]:p-4 [&>*]:text-slate-800 [&>*]:text-sm [&>th]:border-t">
		<!-- Invoice_id -->
		{#if $show_id}
			<th class="text-center font-light">ID</th>
		{/if}

		<!-- Vendor -->
		{#if $filteredData.some((row) => row.product)}
			<th class={`text-left flex justify-between ${$selectedProduct ? 'font-bold' : 'font-light'}`}>
				Vendor
				{#if !$selectedProduct && ($selectedCustomer || $selectedSalesperson)}
					<a
						href="#"
						on:click|preventDefault={() => clearFilters()}
						class="underline hover:no-underline hover:text-blue-500 text-xs text-blue-500"
						>Show All</a
					>
				{/if}
			</th>
		{/if}

		<!-- Customer -->
		{#if $filteredData.some((row) => row.customer)}
			<th class={`text-center ${$selectedCustomer ? 'font-bold' : 'font-light'}`}> Customer </th>
		{/if}
        
		<!-- Salesperson-->
		{#if $filteredData.some((row) => row.salesperson)}
			<th class={`text-center ${$selectedSalesperson ? 'font-bold' : 'font-light'}`}>
				Sales Person
			</th>
		{/if}

		<!-- Quantity  -->
		{#if $filteredData.some((row) => row.groupingLevel !== 1 && row.groupingLevel !== 0)}
			<th class="text-center font-light">Qty</th>
		{/if}
        
		<!-- Total -->
		<th class="text-black text-right border-r rounded-tr-lg font-light">Total</th>
	</tr>
</thead>

<style>
	thead > tr > th:first-child {
		border-left: 1px solid rgba(229, 231, 235, 1);
		border-top-left-radius: 8px;
	}
</style>
