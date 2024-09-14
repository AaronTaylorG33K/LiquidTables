<!-- src/routes/__layout.svelte -->
<script>
	import { onMount } from 'svelte';
	import Header from '../components/header.svelte';
	import '../tailwind.css';
	import { closeWebSocket } from '../lib/websocket';
	import Connection from '../components/connection.svelte';

	onMount(() => {
		return () => {
			closeWebSocket();
		};
	});
</script>

<svelte:head>
	<title>LiquidTables</title>
</svelte:head>
<Header />

<main>
	<slot />
</main>

<Connection />
