<!-- src/App.svelte -->
<script lang="ts">
    
    import { onMount } from 'svelte';	
    import '../lib/websocket'; // Import the WebSocket module to initialize it
    import ws from '../lib/websocket';
    import '../tailwind.css';
    import Sheet from '../components/sheet.svelte'

   

    onMount(() => {
        console.log('onMount!')
        // WebSocket is initialized on import, but you can also add cleanup logic here if needed
        return () => {
            ws.close()
        };
    });
</script>

<Sheet/>