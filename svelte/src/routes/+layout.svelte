<!-- src/routes/__layout.svelte -->
<script>
	import { onMount } from 'svelte';
	import Header from '../components/header.svelte';
	import Connection from '../components/connection.svelte';
	import '../tailwind.css';
  import {closeWebSocket} from '../lib/websocket';

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

<main class="flex flex-col min-h-screen">
	<slot />
</main>

<Connection />
