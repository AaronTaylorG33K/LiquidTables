<!-- src/routes/__layout.svelte -->
<script>
  import Header from '../components/header.svelte';
  import Footer from '../components/footer.svelte';
  import '../tailwind.css';
</script>

<title>
  LiquidTables
</title>
<Header />

<main class="flex flex-col min-h-screen">
  <slot /> <!-- This is where the page content will be injected -->
</main>

<Footer />