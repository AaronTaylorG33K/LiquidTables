<script lang="ts">
	import { writable } from 'svelte/store';
	import { formatMoney, sanitize } from '../../lib/format';
	import type { Metrics } from '../../types/metrics';
	import NumberInput from './NumberInput.svelte';

	export let filteredData = writable<Metrics[]>([]);
	export let columns = writable<string[]>([]);
	export let filterByColumn: string = '';
	export let filterByColumnValue: string = '';
</script>

<tbody>
	{#each $filteredData as row, index (row.invoice_id || row.salesperson || row.customer || row.product || row.total || index)}
		{@const { groupingLevel: level, invoice_id, quantity, total } = row}
		{@const isLastRow = index === $filteredData.length - 1}
		{@const isCategory = filterByColumn === ''}
		{@const activeCategoryRow = isCategory
			? $filteredData.findIndex((row) =>
					Object.values(row).some(
						(value) =>
							String(value).toLowerCase() === filterByColumnValue.toLowerCase().replace('+', ' ')
					)
				)
			: -1}
		<tr>
			{#each $columns as column}
				{@const columnValue = row[column]}
				{@const columnString = String(columnValue).toLowerCase()}
				{@const columnTotal = formatMoney(Number(columnValue))}
				{@const columnFilter = filterByColumnValue.toLowerCase().replace('+', ' ')}

				{@const isDataRow = level >= 1}
				{@const isSelected =
					(column === filterByColumn && columnFilter === columnString) ||
					activeCategoryRow === index}

				<td
					class={column}
					class:font-medium={isLastRow || isSelected}
					class:font-light={!isLastRow || !isSelected}
					class:selected={isSelected && !isLastRow}
				>
					{#if column === 'quantity' && level === 4}
						<NumberInput value={quantity} id={invoice_id} />
					{:else if column === 'total'}
						{columnTotal ?? ''}
					{:else if column === 'invoice_id'}
						{columnValue ?? ''}
					{:else if isDataRow && !isLastRow}
						<a href={`/${column}/${sanitize(columnValue ?? '')}`}>{columnValue ?? ''}</a>
					{/if}
				</td>
			{/each}
		</tr>
	{/each}
</tbody>

<style>
	a {
		white-space: nowrap;
		color: rgb(31 41 55, 1);
		text-decoration: underline;
	}
	a:hover {
		color: rgb(31 41 55, 1);
		text-decoration: none;
	}

	tr {
		padding: 1rem;
	}

	tr:nth-child(odd) {
		background-color: #f9f9f9;
	}

	td {
		border: 1px solid #ededf4;
		padding: 0.75rem;
		text-align: center;
	}

	tr:last-child {
		position: sticky;
		bottom: 0;
		background-color: #fff;

		box-shadow: 0px -4px 6px rgba(0, 0, 0, 0.05);
	}

	tr:hover {
		background-color: #dfefff50;
		transition: all 0.2s;
	}

	tr:last-child:hover {
		background-color: #ffffff;
	}

	td.selected {
		background-color: #dfefff50;
		font-weight: 500;
		transition: all 0.2s;
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
	td.quantity {
		text-align: center;
		padding: 0.5rem;
		width: 10%;
	}
	td.total {
		text-align: right;
		white-space: nowrap;
		border-right: 1px;
		
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

	tr:last-child td.total {
		position: sticky;
		right:0;
	}
</style>
