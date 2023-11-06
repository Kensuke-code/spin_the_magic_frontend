<template>
  <div class="page-all">
    <div v-if="isShowAttraction">
      <div class="attraction-section">
        <div :style="attractionThumbnail"></div>
        <div class="attraction-text">
          <div class="attraction-name">
            {{ selectedAttraction.name }}
          </div>
          <div class="attraction-condition">
            {{ selectedAttraction.condition }}
          </div>
        </div>
      </div>
    </div>
    <button
      type="button"
      name="button"
      class="spin-gacha-button"
      @click="spinGacha"
    >
      ガチャを回す
    </button>    
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

      // 営業終了していてアトラクションが稼働していない時
      if (max === 0) {
        return this.$router.push('/sorry');
      }
      const selectedId = Math.floor( Math.random() * (max + 1 - min) ) + min ;

      // 決定したIDのアトラクション情報を取得する
      this.selectedAttraction = this.attractions.find(e => e.sort_id === selectedId)
      this.selectedAttractionImagePath = this.generateAssetPath

      this.isShowAttraction = true
    }
  },
  computed: {
    thumbnailId() {
      return ( '000' + this.selectedAttraction.id).slice( -3);
    },
    generateAssetPath() {
      // FIXME: idの0の桁数によって変える必要がある
      return `https://d1hhvvlrb2g6r9.cloudfront.net/attractions/img/thumbnail/${this.thumbnailId}_thum_name.jpg`
    },
    attractionThumbnail() {
      // computedのgenerateAssetPathの値がstyleからだと参照できないのでcomputedに記載
      return {
        width: '320px',
        height: '320px',
        borderRadius: '50%',
        backgroundImage: `url(${this.generateAssetPath})`,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        border: 'solid 4px #0000CD',
        margin: '5px auto 20px'

      }
    }
  }
}
</script>
<style>
html {
  background-color: #99CCFF;
}
body {
  margin: 0;
  padding: 20px;
}
.page-all {
  height: 100vh;
}
.spin-gacha-button {
  display: block;
  margin: 18px auto;
  height: 44px;
  width: 154px;
  color: #fff;
  background: #0066CC;
  border-radius: 16px;
  border-color: #F0E68C;
  border-width: medium;
  font-family: Verdana;
  font-size: 16px;
}
.attraction-text {
  text-align: center;
}
.attraction-name {
  font-family: Verdana;
  font-size: 19px;
  font-weight: bold;
  line-height: 1.3;
  color: #333333;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
  letter-spacing: 0.3px;
  height: 78px;
}
.attraction-condition {
  margin-top: 5px;
  font-family: Verdana;
  font-size: 17px;
  line-height: 1.3;
  color: #333333;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
  letter-spacing: 0.5px;
}
</style>