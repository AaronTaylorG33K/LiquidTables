<script>
	import { onMount } from 'svelte';
	import { getConnectionStatus } from '../lib/websocket';

    let status = "disconnected"

	onMount(() => {
		status = getConnectionStatus();
		
		setInterval(() => {
			status = getConnectionStatus();
		}, 1000);


		return () => {
			status = "disconnected";
		};
	});
</script>

<div class="pl-12 pr-16">
	<div
		class={status === "connected"
			? ' text-gray-200 p-4 rounded-tl'
			: ' text-slate-500 p-4 rounded-tl'}
	>
		Websocket {status}
	</div>
</div>
