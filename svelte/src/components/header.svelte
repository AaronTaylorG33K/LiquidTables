<!-- src/components/header.svelte -->
<script>
	// Any script logic for the header can go here
    import '../tailwind.css';
</script>

<header class="bg-gray-800 text-white p-4 shadow-lg h-[100px] flex items-center">
    <div class="container mx-auto flex justify-center items-center">
      <!-- Logo -->
      <img src="/logo.svg" alt="Logo" class="h-10 w-auto" />
  
      <!-- Title and Navigation -->
      <div class="flex flex justify-between items-center">

        <!-- <nav>
          <a href="/" class="text-white hover:text-gray-400 mx-2">Home</a>
          <a href="/about" class="text-white hover:text-gray-400 mx-2">About</a>
          <a href="/contact" class="text-white hover:text-gray-400 mx-2">Contact</a>
        </nav> -->
      </div>
    </div>
  </header>
  