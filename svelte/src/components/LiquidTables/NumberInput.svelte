<script lang="ts">
	import { sendMessage } from '../../lib/websocket';

    export let value: number;
    export let id: number;

    function qtyChange(event: Event, row: { id: number; value: number }) {
		const target = event.target as HTMLInputElement;
		sendMessage({ data: { invoice_id:id, new_quantity: parseInt(target.value) } });
	}
</script>


<!--- tailwind example -->
<input
    class="w-full px-4 py-2 border shadow-sm rounded-md border-gray-300 placeholder-gray-400 text-gray-700 
    focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none "
    type="number"
    placeholder="1"
    value={value}
    on:input={(event) => qtyChange(event, { id, value })}
/>