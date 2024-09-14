<script lang="ts">
    import { status } from '../lib/websocket.ts'  
</script>

<div class="text-xs p-1 text-gray-400 text-center">
    {#if $status === 'connected'}
        <p>WS Connected</p>
    {:else if $status === 'disconnected'}
        <p>WS Disconnected</p>
    {:else}
        <p>WS Connecting...</p>
    {/if}
</div>