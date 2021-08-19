import { wrapFunctional } from './utils'

export { default as SmallHexTile } from '../..\\components\\SmallHexTile.vue'

export const LazySmallHexTile = import('../..\\components\\SmallHexTile.vue' /* webpackChunkName: "components/small-hex-tile" */).then(c => wrapFunctional(c.default || c))
