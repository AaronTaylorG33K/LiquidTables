<script>
	import { onMount } from 'svelte';
	import { getConnectionStatus } from '../lib/websocket';

	let isConnected = false;

	onMount(() => {
		const status = getConnectionStatus();
		if (status === 'connected') {
			isConnected = true;
		} else {
			isConnected = false;
		}
		setInterval(() => {
			const status = getConnectionStatus();
			if (status === 'connected') {
				isConnected = true;
			} else {
				isConnected = false;
			}
		}, 1000);

		if (status === 'connected') {
			isConnected = true;
		} else {
			isConnected = false;
		}

		return () => {
			isConnected = false;
		};
	});
</script>

<div class="fixed bottom-0 right-0">
	<div
		class={isConnected
			? 'bg-green-500 text-white p-4 rounded-tl'
			: 'bg-gray-500 text-white p-4 rounded-tl'}
	>
		<p>Websocket {isConnected ? 'Connected' : 'Disconnected'}</p>
	</div>
</div>
