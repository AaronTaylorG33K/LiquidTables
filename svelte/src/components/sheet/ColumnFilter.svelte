<script lang="ts">
    import { onMount, onDestroy } from 'svelte';
    import {
        selectedProduct,
        selectedCustomer,
        selectedSalesperson,
        filterByProduct,
        filterByCustomer,
        filterBySalesperson,
    } from '../../lib/filtering';
    import { get } from 'svelte/store';

    export let options: string[] = [];
    export let type: string = '';
    export let visible: boolean = false;
    export let open: boolean = false;
    export let selected: boolean = false;
    export let value: string = '';

    let container: HTMLDivElement;

    function selectOption(option: string) {
        switch (type) {
            case 'product':
                filterByProduct(option);
                break;
            case 'customer':
                filterByCustomer(option);
                break;
            case 'salesperson':
                filterBySalesperson(option);
                break;
        }
        selected = option;
        open = false;
    }

    function handleClickOutside(event: MouseEvent) {
        if (container && !container.contains(event.target as Node)) {
            open = false;
        }
    }


    // function getSelected() {
    //     switch (type) {
    //         case 'product':
    //             return get(selectedProduct);
    //         case 'customer':
    //             return get(selectedCustomer);
    //         case 'salesperson':
    //             return get(selectedSalesperson);
    //         default:
    //             return '';
    //     }
    // }

    $: console.log(selected, type);
    

    onMount(() => {
        if (typeof window !== 'undefined') {
            document.addEventListener('click', handleClickOutside);
        }
    });

    onDestroy(() => {
        if (typeof window !== 'undefined') {
            document.removeEventListener('click', handleClickOutside);
        }
    });
</script>

{#if visible}
    <div bind:this={container} class="relative z-40">
        <button type="button" class="option cursor-pointer p-2 w-full flex uppercase font-light justify-between cursor-pointer hover:bg-gray-100 border border-gray-100 rounded-lg" on:click={() => { open = !open }} aria-haspopup="listbox" aria-expanded={open}>
            <span class="flex-1 text-center" class:font-bold={selected === true}>{type === 'product' ? 'Vendor' : type}</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 inline-block ml-auto" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 15a1 1 0 01-.707-.293l-4-4a1 1 0 011.414-1.414L10 12.586l3.293-3.293a1 1 0 011.414 1.414l-4 4A1 1 0 0110 15z" clip-rule="evenodd" />
            </svg>
        </button>
        {#if open}
            <div class="absolute flex flex-col z-30 bg-white w-full shadow-md p-2 capitalize min-w-[120px]" role="listbox">
                {#each options as option}
                    <button type="button" class="option text-left bg-white hover:bg-gray-100 cursor-pointer text-gray-800 font-light p-1" on:click={() => selectOption(option)} role="option" aria-selected={selected === option}>
                        {option}
                    </button>
                {/each}
            </div>
        {/if}
    </div>
{/if}