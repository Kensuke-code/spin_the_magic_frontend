<template>
  <div class="page-all">
    <button
      type="button"
      name="button"
      class="spin-gacha-button"
      @click="getMsg"
    >
      ガチャを回す
    </button>
    <div v-if="msgs.length > 0">
      <div v-for="msg in msgs">
        {{ msg }}
      </div>
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
        this.msgs = res
      )
    }
  }
}
</script>
<style>
.page-all {
  background-color: #99CCFF;
  height: 100vh;
}
.spin-gacha-button {
  display: block;
  margin: 18px auto;
  height: 36px;
  width: 147px;
  color: #fff;
  background: #0066CC;
  border-radius: 16px;
  border-color: #F0E68C;
  border-width: medium;


}
</style>