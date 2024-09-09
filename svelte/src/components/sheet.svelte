<script lang="ts">
  import { onMount } from 'svelte';
  import { metricsStore } from '../store/metrics';
  import type { Metrics } from '../types/metrics';
  import { sendMessage, closeWebSocket } from '../lib/websocket';
  import {
    data,
    groupingLevels,
    selectedProduct,
    selectedCustomer,
    selectedSalesperson,
    filteredData,
    show_id,
    clearFilters,
    filterByProduct,
    filterByCustomer,
    filterBySalesperson
  } from '../lib/filtering';
  import TableHeader from './sheet/TableHeader.svelte';
  import TableBody from './sheet/TableBody.svelte';
  const unsubscribe = metricsStore.subscribe((metrics) => {
    if (Array.isArray(metrics)) {

      console.log(metrics);
      const formattedMetrics = metrics.map(
        (metric: [string, string, string, number, number, number, number, number, number]) => ({
          product: metric[0],
          customer: metric[1],
          salesperson: metric[2],
          invoice_id: metric[3],
          customer_id: metric[4],
          salesperson_id: metric[5],
          quantity: metric[6],
          amount: metric[7],
          groupingLevel: metric[8]
        })
      );

      console.log(formattedMetrics);
      data.set(formattedMetrics);
    }
  });

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
	  <TableHeader/>
      <TableBody />
    </table>
  {/if}
</div>
<style>
    .selected {
      background-color: #eef8fe;
      transition: background-color 0.3s ease;
    }
  
    table > thead > tr > th:first-child {
      border-left: 1px solid rgba(229, 231, 235, 1);
      border-top-left-radius: 8px;
    }
  
    .tr.selected > td:first-child {
      border-top: 1px solid rgb(30, 116, 170);
    }
  </style>