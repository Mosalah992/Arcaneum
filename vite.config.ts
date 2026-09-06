import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    target: 'es2022',
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
