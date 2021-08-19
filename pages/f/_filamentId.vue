<template>
  <div class="box-border md:box-content align-center">
    <h1>Url currently has this number at end: {{ filamentId }}</h1>
    <br />
    <nuxt-link
      class="
        text-emerald-500
        background-transparent
        font-bold
        uppercase
        px-3
        py-1
        text-xs
        outline-none
        focus:outline-none
        mr-1
        mb-1
        ease-linear
        transition-all
        duration-150
        shadow
      "
      type="button"
      :to="next"
      >Next page</nuxt-link
    >
  </div>
</template>

<script lang='ts'>
import type { Context } from '@nuxt/types/app/index'
export default {
  async asyncData({ params }: Context) {
    const filamentId: String = params.filamentId
    const next: String = String(Number(filamentId) + 1)
    return { filamentId, next }
  },
}
</script>