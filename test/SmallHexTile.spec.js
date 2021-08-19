import { mount } from '@vue/test-utils'
import SmallHexTile from '@/components/SmallHexTile.vue'

describe('SmallHexTile', () => {
  test('is a Vue instance', () => {
    const wrapper = mount(SmallHexTile)
    expect(wrapper.vm).toBeTruthy()
  });
  test('is still a Vue instance', () => {
    const wrapper = mount(SmallHexTile)
    expect(wrapper.vm).toBeTruthy()
  });
})
