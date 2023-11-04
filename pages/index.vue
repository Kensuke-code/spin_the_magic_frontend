<template>
  <div class="page-all">
    <button
      type="button"
      name="button"
      class="spin-gacha-button"
      @click="spinGacha"
    >
      ガチャを回す
    </button>
    <div v-if="isShowAttraction">
      <div class="attraction-section">
        <img class="attraction-thumbnail" v-bind:src="selectedAttractionImagePath"/>
        <div >
          {{ selectedAttraction.name }}
        </div>
        <div >
          {{ selectedAttraction.condition }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      attractions: [],
      isShowAttraction: false,
      selectedAttraction: {},
      selectedAttractionImagePath: ""
    }
  },
  created() {
    // アトラクションの情報を取得
    this.$axios.$get('/api/v1/spin_gacha')
    .then(res => 
      this.attractions = res
    )
  },
  methods: {
    spinGacha () {
      // ランダムでガチャを回す
      const min = 1
      const max = this.attractions.length
      const selectedId = Math.floor( Math.random() * (max + 1 - min) ) + min ;

      // 決定したIDのアトラクション情報を取得する
      this.selectedAttraction = this.attractions.find(e => e.sort_id === selectedId)
      this.selectedAttractionImagePath = this.generateAssetPath

      this.isShowAttraction = true
    }
  },
  computed: {
    thumbnailPrefix() {
      return ( '000' + this.selectedAttraction.id).slice( -3);
    },
    generateAssetPath() {
      // FIXME: idの0の桁数によって変える必要がある
      return `https://d1hhvvlrb2g6r9.cloudfront.net/attractions/img/thumbnail/${this.thumbnailPrefix}_thum_name.jpg`
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
.attraction-section {
  margin: auto
}
.attraction-thumbnail {
  width:300px;
  height:300px;
  border-radius:50%;
}
</style>