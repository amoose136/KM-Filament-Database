import Vue from 'vue'
import { wrapFunctional } from './utils'

const components = {
  SmallHexTile: () => import('../..\\components\\SmallHexTile.vue' /* webpackChunkName: "components/small-hex-tile" */).then(c => wrapFunctional(c.default || c))
}

for (const name in components) {
  Vue.component(name, components[name])
  Vue.component('Lazy' + name, components[name])
}
