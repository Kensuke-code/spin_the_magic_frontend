<template>
  <div>
    <button
      type="button"
      name="button"
      @click="getMsg"
    >
      RailsからAPIを取得する
    </button>
    <div>
      {{ msgs }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      msgs: []
    }
  },
  methods: {
    getMsg () {
      this.$axios.$get('/api/v1/spin_gacha').then(console.log('fetched')).catch(e => console.log(e))
    // .then(res => this.msgs.push(res))
    }
  }
}
</script>
