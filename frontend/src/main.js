import { createApp } from 'vue/dist/vue.esm-bundler.js';
import App from './App.vue'


// createApp(App).use(router).mount('#app')
const app = createApp(App)

app.mount('#app')