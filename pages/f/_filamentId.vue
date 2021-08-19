<template>
  <div class="box-border md:box-content align-center">
    <h1>Url currently has this number at end: {{ this.filamentId }}</h1>
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
      :to="this.next"
      >Next page</nuxt-link
    >
  </div>
</template>

<script>
export default {
  async asyncData({ params }) {
    const sId = params.filamentId // When calling /abc the filamentId will be "abc"
    const filamentId = String(Number(sId))
    const next = String(Number(sId) + 1)
    return { filamentId, next }
  },
}
</script>