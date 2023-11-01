<template>
  <div>
    <button
      type="button"
      name="button"
      @click="getMsg"
    >
      ガチャを回す
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
      this.$axios.$get('/api/v1/spin_gacha')
      .then(res => 
        this.msgs.push(res)
      )
      console.log(this.msgs)
    }
  }
}
</script>
