<template>
  <div class="page-sea">
    <div v-if="isShowAttraction">
      <div class="attraction-section">
        <div :style="attractionThumbnail"></div>
        <div class="attraction-text">
          <div class="attraction-name">
            {{ selectedAttraction.name }}
          </div>
          <div class="attraction-condition">
            {{ selectedAttraction.condition }}分待ち
          </div>
        </div>
      </div>
    </div>
    <div v-else class="blank-section" />
    <Dropdown
      v-model="waitTimeLimit"
      :options="waitTimeOptions"
      v-on:selected="validateSelection"
      name="waittime"
      :maxItem="30"
      :placeholder="timePlaceholder"
    >
    </Dropdown>
    <button
      type="button"
      name="button"
      class="sea-spin-gacha-button"
      @click="spinGacha"
    >
      {{ buttonText }}
    </button>
    <NuxtLink class="another-park-link" to="/park/land">ディズニーランドに行く</NuxtLink>
  </div>
</template>

<script>
export default {
  head () {
    return {
      bodyAttrs: {
        class: 'reset-body'
      }
    }
  },
  data () {
    return {
      attractions: [],
      isShowAttraction: false,
      selectedAttraction: {},
      selectedAttractionImagePath: "",
      intervalId: null,
      waitTimeLimit: 300,
    }
  },
  created() {
    // 待ち時間初期化
    this.waitTimeLimit = 300; 
    // アトラクションの情報を取得
    this.$axios.$get('/api/v1/spin_gacha',{
      params: {
        park: this.park
      }
    })
    .then(res => 
      this.attractions = res
    )
  },
  methods: {
    validateSelection(selectedObject) {
      this.waitTimeLimit = selectedObject.name
    },
    spinGacha () {
      // ランダムでガチャを回す
      // 待ち時間制限でアトラクションをフィルタリングする
      const filterdAttraction = this.filteredAttractions

      // 営業終了していてアトラクションが稼働していない時
      if (filterdAttraction.length === 0) {
        // return this.$router.push('/sorry');
      }

      // 既存のルーレットのインターバルをクリア
      if (this.intervalId) {
        clearInterval(this.intervalId); 
      }

      this.intervalId = setInterval(() => {
        // ランダムなアトラクションを選択
        this.isShowAttraction = true;
        const selectedId = Math.floor( Math.random() * filterdAttraction.length)
        this.selectedAttraction = filterdAttraction[selectedId]
        this.selectedAttractionImagePath = this.generateAssetPath
      }, 120); // 120ミリ秒ごとに切り替え
      
      setTimeout(() => {
        // 3秒後にルーレットを停止
        clearInterval(this.intervalId);
      }, 3000);
    }
  },
  computed: {
    park() {
      return 'sea'
    },
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
        width: '350px',
        height: '290px',
        borderRadius: '50%',
        backgroundImage: `url(${this.generateAssetPath})`,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        border: 'solid 4px #0000CD',
        margin: '5px auto 20px'

      }
    },
    buttonText() {
      if(this.isShowAttraction === false){
        return 'ガチャを回す'
      }else {
        return 'もう一度回す'
      }
    }, 
    timePlaceholder() {
      return '待ち時間の上限値を選択してください'
    },
    waitTimeOptions() {

      let waitTimeList = []
      // 10分から200分までのリストを作成する
      // 指定なしも入れる
      const countLimit = 20
      const waitTimeWeighting = 10
      let count = 1

      for (count ; count <= countLimit; count++) {
        let waitTime = count * waitTimeWeighting
        waitTimeList.push(
          {id: count, name: waitTime.toString() }
        )
      }
      waitTimeList.unshift({id: count,name: '指定なし'})
      return waitTimeList
    },
    filteredAttractions()  {
      return this.attractions.filter(attraction => 
        attraction.condition <= 60
      )
    },
  }
}
</script>
<style>
.page-sea {
  background-color: #99CCFF;
  height: 100vh;
}
.blank-section {
  min-height: 448.09px;
}
.sea-spin-gacha-button {
  display: block;
  margin: 18px auto;
  height: 44px;
  width: 190px;
  color: #fff;
  background: #0066CC;
  border-radius: 16px;
  border-color: #F0E68C;
  border-width: medium;
  font-family: Verdana;
  font-size: 16px;
}
.attraction-section {
  padding-top: 20px;
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
.reset-body {
  margin: 0
}
.another-park-link {
  padding-left: 8px
}
.dropdown {
  margin-left: 10px
}
</style>