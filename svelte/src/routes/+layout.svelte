<!-- src/routes/__layout.svelte -->
<script>
	import { onMount } from 'svelte';
	import Header from '../components/header.svelte';
	import Connection from '../components/connection.svelte';
	import '../lib/websocket';
	import ws from '../lib/websocket';
	import '../tailwind.css';

	onMount(() => {
		return () => {
			ws.close();
		};
	});
</script>

<svelte:head>
	<title>LiquidTables</title>
</svelte:head>
<Header />

<main class="flex flex-col min-h-screen">
	<slot />
</main>

<Connection isConnected={true} />
