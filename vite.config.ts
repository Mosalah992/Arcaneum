import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    target: 'es2022',
    // Nothing here is code-split any more: with three.js gone the whole
    // archive is a single small bundle.
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
