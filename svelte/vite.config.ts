import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [sveltekit()],
  build: {
    outDir: 'dist', // Ensure this matches the directory in your Dockerfile
  },
  test: {
    include: ['src/**/*.{test,spec}.{js,ts}']
  }
});
