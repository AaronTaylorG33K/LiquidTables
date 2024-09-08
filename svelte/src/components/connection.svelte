<script>
    export let isConnected = false;
</script>

<div class="fixed bottom-0 right-0">
    {#if isConnected}
        <div class={isConnected ? "bg-green-500 text-white p-4 rounded-tl" : "bg-gray-500 text-white p-4 rounded-tl"}>
            <p>Websocket {isConnected ? 'Connected' : 'Disconnected'}</p>
        </div>
    {/if}
</div>
