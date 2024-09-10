<script lang="ts">
	import {
		data,
		filteredData,
		show_id,
		selectedProduct,
		selectedCustomer,
		selectedSalesperson,
		clearFilters
	} from '../../lib/filtering';
	import Selectable from './ColumnFilter.svelte';

	data.subscribe((value) => {
	});

	let vendors = $data.filter((row) => row.groupingLevel === 1).map((row) => row.product);
	let customers = $data.filter((row) => row.groupingLevel === 2).map((row) => row.customer);
	let salespersons = $data.filter((row) => row.groupingLevel === 3).map((row) => row.salesperson);
</script>

<thead class="uppercase bg-white shadow-lg z-30">
	<tr class="[&>*]:p-2 [&>*]:pl-0 [&>*]:text-slate-800 [&>*]:text-sm [&>th]:border-t">
		{#if ($selectedCustomer || $selectedSalesperson)}
			<th class="text-center font-light">
				<div class="pl-2">ID</div></th>
	
		{/if}

		{#if $filteredData.some((row) => row.product)}
			<th
				class="text-left justify-between"
				class:font-bold={$selectedProduct}
				class:font-light={!$selectedProduct}
				colspan={$selectedProduct ? 2 : 1}
			>
				{#if !$selectedCustomer && !$selectedSalesperson && !$selectedProduct}
					<div class="p-2 pl-4 uppercase">Vendor</div>
				{/if}

				<div class="pl-2">
				<Selectable
					options={vendors}
					visible={$selectedProduct || $selectedCustomer || $selectedSalesperson}
					type="product"
					selected={$selectedProduct}
				/>
				</div>
			</th>
		{/if}

		{#if $filteredData.some((row) => row.customer)}
			<th
				class="relative text-center"
				class:font-bold={$selectedCustomer}
				class:font-light={!$selectedCustomer}
			>
				{#if !$filteredData.some((row) => row.customer) || !$filteredData.some((row) => row.salesperson)}
					Customer
				{/if}
				<Selectable
					options={customers}
					visible={$filteredData.some((row) => row.customer) ||
						$filteredData.some((row) => row.salesperson)}
					type="customer"
					selected={$selectedCustomer !== ''}
				/>
			</th>
		{/if}

		{#if $filteredData.some((row) => row.salesperson)}
			<th
				class="text-center"
				class:font-bold={$selectedSalesperson}
				class:font-light={!$selectedSalesperson}
			>
				{#if !$filteredData.some((row) => row.customer) || !$filteredData.some((row) => row.salesperson)}
					Salesperson
				{/if}
				<Selectable
					options={salespersons}
					visible={$filteredData.some((row) => row.customer) ||
						$filteredData.some((row) => row.salesperson)}
					type="salesperson"
					selected={$selectedSalesperson}
				/>
			</th>
		{/if}

		<!-- Quantity  -->
		{#if $filteredData.some((row) => row.groupingLevel !== 1 && row.groupingLevel !== 0)}
			<th class="text-center font-light">Qty</th>
		{/if}

		<!-- Total -->
		<th class="text-black text-right border-r rounded-tr-lg font-light"
			><div class="p-2">Total</div></th
		>
	</tr>
</thead>

<style>
	thead > tr > th:first-child {
		border-left: 1px solid rgba(229, 231, 235, 1);
		border-top-left-radius: 8px;
	}
</style>
