/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'

// Cookies
import VueCookies from 'vue3-cookies';

const app = createApp(App)
app.use(VueCookies);

registerPlugins(app)

app.mount('#app')
