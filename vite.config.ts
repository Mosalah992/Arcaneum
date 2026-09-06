import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    target: 'es2022',
    // three.js is a 500KB chunk on its own and that is the intended shape:
    // it is dynamically imported by the chamber and nothing else pulls it in.
    // The warning would fire on every build for a split that is working.
    chunkSizeWarningLimit: 700,
    // three.js is reached only through a dynamic import in src/chamber/,
    // so rollup emits it as its own chunk. A visitor who never opens the
    // chamber (reduced-motion, repeat visit, phone) never downloads it.
    rollupOptions: {
      output: {
        chunkFileNames: 'assets/[name]-[hash].js',
      },
    },
  },
  server: {
    port: 5173,
  },
});
