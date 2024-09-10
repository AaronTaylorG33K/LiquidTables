<script lang="ts">
    import { onMount } from 'svelte';
    import { data } from '../../lib/filtering';
    import { get } from 'svelte/store';

    let supported = true;
    let listening = false;
    let searchText = '';
    let annyang;
    let isPressed = false;

    const filteredData = [
        { type: 'vendor', name: 'Vendor 1' },
        { type: 'customer', name: 'Customer 1' },
        { type: 'salesperson', name: 'Salesperson 1' }
    ];

    function generateCommands(data) {
        const commands = {};
        data.forEach(item => {
            const command = `show me ${item.type}s`;
            commands[command] = () => console.log(`Showing ${item.type}s...`);
        });
        return commands;
    }

    onMount(async () => {
        if (typeof window !== 'undefined' && (window.SpeechRecognition || window.webkitSpeechRecognition)) {
            try {
                annyang = await import('annyang'); // Dynamic import

                if (!annyang) {
                    console.log('annyang is not available');
                    supported = false;
                }
            } catch (error) {
                console.error('Error loading annyang:', error);
                supported = false;
            }
        } else {
            console.error('Speech Recognition is not supported in this browser.');
            supported = false;
        }
    });

    function handleSearch() {
        const allData = get(data);
        const searchWords = searchText.toLowerCase().split(' ').filter(word => word.length > 0);
        const searchResults = allData.filter(item => {
            return searchWords.every(word =>
                Object.values(item).some(value =>
                    value?.toString().toLowerCase().includes(word)
                )
            );
        });
    }

    function startVoiceSearch() {
        if (annyang && !listening) {
            const commands = generateCommands(filteredData);
            annyang.addCommands(commands);
            annyang.start();
            listening = true;
            isPressed = true;
            console.log('Voice search activated');
        }
    }

    function stopVoiceSearch() {
        if (annyang && listening) {
            annyang.abort();
            listening = false;
            isPressed = false;
            console.log('Voice search deactivated');
        }
    }
</script>

<div class="search-bar w-2/5">
   
    <input class="search-input" type="text" bind:value={searchText} placeholder="Search..." on:keypress={handleSearch}/>
    <button class="microphone-icon" 
    on:mousedown={startVoiceSearch} 
    on:mouseup={stopVoiceSearch} 
    class:is-pressed={isPressed}>
<svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M19 10V12C19 15.866 15.866 19 12 19M5 10V12C5 15.866 8.13401 19 12 19M12 19V22M8 22H16M12 15C10.3431 15 9 13.6569 9 12V5C9 3.34315 10.3431 2 12 2C13.6569 2 15 3.34315 15 5V12C15 13.6569 13.6569 15 12 15Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
</button>
</div>
<div class="text-gray-400 text-xs mt-2">
{#if supported && listening}
    <p>Say "show me vendors", "show me customers", or "show me salespersons".</p>
{:else}
    <p>Press and hold the microphone icon to say a command.</p>
{/if}
</div>
<style>
    .search-bar {
        display: flex;
        align-items: center;
        border: 1px solid #ccc;
        border-radius: 10px;
        padding: 8px;
        margin-top: 4rem;
    }

    .search-input {
        flex: 1;
        border: none;
        outline: none;
        padding: 0 8px;
    }

    .microphone-icon {
        margin-right: 8px;
        padding: 5px;
        border-radius: 100%;
    }

    .is-pressed {
        box-shadow: 0 0 0px 2px rgba(3, 139, 251, 0.5);
    }
</style>