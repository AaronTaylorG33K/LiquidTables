<script lang="ts">
    import { onMount } from 'svelte';
    import { writable } from 'svelte/store';
  
    type CellData = string | number;
    type RowData = CellData[];
  
    // let data = writable<RowData[]>([]);
    let ws: WebSocket | null = null;
  
    let numRows: number = 20;
    let numCols: number = 4;
    let cellSize: string = '';


     // Data store for the spreadsheet
    // Initialize data with empty strings as placeholders
  const initializeData = (rows: number, cols: number): RowData[] => {
    return Array.from({ length: rows }, () => Array.from({ length: cols }, () => ''));
  };

  let data = writable<RowData[]>(initializeData(numRows, numCols));

    // Initialize WebSocket connection
    onMount(() => {
      ws = new WebSocket('ws://localhost:8080');
  
      ws.onmessage = (event: MessageEvent) => {
        const message = JSON.parse(event.data);
        if (message.type === 'update') {
        data.update(currentData => {
          const newData = [...currentData];
          newData[message.row][message.col] = message.value;
          return newData;
        });
      }
      };
  
      return () => {
        if (ws) ws.close();
      };
    });
  
    // Handle cell change
    function handleCellChange(rowIndex: number, colIndex: number, value: CellData) {
      if (ws) {
        ws.send(JSON.stringify({ type: 'update', row: rowIndex, col: colIndex, value }));
      }
    }
  
    // TypeScript event handler function
    function onCellChange(event: Event, rowIndex: number, colIndex: number) {
      const input = event.target as HTMLInputElement;
      handleCellChange(rowIndex, colIndex, input.value);
    }
  </script>
  
  <style>
    /* Add your custom styles here */
  </style>
  
  <table class=" border-collapse ">
    <thead class="sticky top-0 bg-white shadow-lg  uppercase">
      <tr>
        <th class="p-2"></th>
        <th class="p-2 font-light">Product</th>
        <th class="p-2 font-light">Customer</th>
        <th class="p-2 font-light">Salesperson</th>
        <th class="p-2 font-light">Amount</th>
      </tr>
    </thead>
    <tbody class="">
      {#each $data as row, rowIndex}
        <tr>
          <td class="text-center  p-2 bg-gray-800 text-white">{rowIndex + 1}</td>
          {#each row as cell, colIndex}
            <td class="border">
              <input
                type="text"
                value={cell}
                class="w-full h-full min-h-12 rounded-none bg-white focus:border-blue-200 "
                on:change="{(event) => onCellChange(event, rowIndex, colIndex)}"
              />
            </td>
          {/each}
        </tr>
      {/each}
    </tbody>
  </table>
  