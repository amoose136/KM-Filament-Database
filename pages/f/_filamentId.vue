<template>
    <div class="box-border md:box-content align-center">
        <filamentImagePlaceholder v-if="filamentData === null ? false : true" />
        <h1>
            Url number corresponds to filament name:
            {{
                filamentData === null ? 'Filament Not Found' : filamentData.name
            }}
        </h1>

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
            :to="previous"
            >Previous page</nuxt-link
        >
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

<script lang="ts">
import { Filament, PrismaClient } from '@prisma/client'
// import Context from '@nuxt/types/app/index'

import type { Context } from '@nuxt/types/app/index'
const prisma = new PrismaClient()
export default {
    async asyncData({ params }: Context) {
        const filamentId: String = params.filamentId
        const next: String = String(Number(filamentId) + 1)
        const previous: String = String(Number(filamentId) - 1)
        const filamentData: Filament | null = await prisma.filament.findUnique({
            where: {
                id: Number(filamentId),
            },
        })
        return { filamentId, next, previous, filamentData }
    },
}
</script>
