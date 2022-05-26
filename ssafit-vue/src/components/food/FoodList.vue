<template>
  <div id="fooddiv">
    <h2>총 칼로리:  {{totalCal.cal}} 
      <Strong v-if="eatenCal"> 남은 칼로리: {{totalCal.cal - eatenCal}}   </Strong>
      <b-button @click="resetCal">칼로리 정보 재설정</b-button>
    </h2>
    <b-row style="margin-bottom:20px">
      <b-col>
        <Doughnut
        :chart-options="chartOptions"
        :chart-data="carbData"
        :chart-id="chartId"
        :dataset-id-key="datasetIdKey"
        :plugins="plugins"
        :css-classes="cssClasses"
        :styles="styles"
        :width="width"
        :height="height"
        />
      </b-col>
      <b-col>
        <Doughnut
          :chart-options="chartOptions"
          :chart-data="proData"
          :chart-id="chartId"
          :dataset-id-key="datasetIdKey"
          :plugins="plugins"
          :css-classes="cssClasses"
          :styles="styles"
          :width="width"
          :height="height"
        />
      </b-col>
      <b-col>
        <Doughnut
          :chart-options="chartOptions"
          :chart-data="fatData"
          :chart-id="chartId"
          :dataset-id-key="datasetIdKey"
          :plugins="plugins"
          :css-classes="cssClasses"
          :styles="styles"
          :width="width"
          :height="height"
        />
      </b-col>
    </b-row>

  <b-row align-h="around">
  <b-col cols="5">
    <b-row>
      <h2>섭취한 음식</h2>
    </b-row>

      <!-- <b-card-group columns class="mb-3">
        <b-card
          border-variant="secondary"
          :header="`${food.foodName}`"
          header-border-variant="secondary"
          align="center"
          v-for="(food, index) in eattenFoods" :key="index"
        >
          <b-card-text>
            <div> Serving-Size : {{food.servingSize}}g </div>
            탄수화물 : {{food.carb}}g , 단백질 : {{food.protein}}g,  지방 : {{food.fat}}g
            <div>
              <b-button size="sm" variant='outline-warning' @click="spitFood(index)">-</b-button>
            </div>
          </b-card-text>
        </b-card>
      </b-card-group> -->
      <div class="accordion" role="tablist" v-for="(food, index) in eattenFoods" :key="index">
        <b-card no-body class="mb-1" >
          <b-card-header header-tag="header" class="p-1" role="tab">
            <b-button block v-b-toggle="`accordion-${index}`" variant="outline-info">{{food.foodName}}</b-button>
          </b-card-header>
          <b-collapse :id="`accordion-${index}`" accordion="my-accordion" role="tabpanel">
            <b-card-body>
              <b-card-text>
                <div> Serving-Size : {{food.servingSize}}g </div>
                탄수화물 : {{food.carb}}g , 단백질 : {{food.protein}}g,  지방 : {{food.fat}}g
                <div>
                  <b-button size="sm" variant='outline-warning' @click="spitFood(index)">-</b-button>
                </div>
              </b-card-text>
            </b-card-body>
          </b-collapse>
        </b-card>
      </div>
  </b-col>
  <b-col cols="5">
    <b-row align-h="start">
      <b-col cols="4"><h2>음식 목록</h2></b-col>
      <b-col>
        <b-button style="margin-right:10px" v-b-toggle.regist-collapse>음식 등록하기</b-button>
        <b-button v-b-toggle.search-collapse>검색</b-button>
      </b-col>
    </b-row>
        <b-collapse id="regist-collapse" style="margin-bottom : 10px">
          <b-card bg-variant="dark" text-variant="white" title="직접 입력하기">
            <b-card-text>
              <b-row>
                <b-row style="margin-bottom:10px">
                <b-col>음식 이름 <b-form-input v-model="foodName" ></b-form-input></b-col>
                <b-col>제공량 <b-form-input v-model="servingSize"></b-form-input></b-col>
                <b-col>칼로리 <b-form-input v-model="cal"></b-form-input></b-col>
                </b-row>
                <b-row>
                <b-col>탄수화물 <b-form-input v-model="carb"></b-form-input></b-col>
                <b-col>단백질 <b-form-input v-model="protein"></b-form-input></b-col>
                <b-col>지방 <b-form-input v-model="fat"></b-form-input></b-col>
                </b-row>
              </b-row>
            </b-card-text>
            <b-button @click="setNewFood" variant="primary">등록</b-button>
          </b-card>
        </b-collapse>
        <b-collapse id="search-collapse" style="margin-bottom : 10px">
          <b-card bg-variant="dark" text-variant="white" title="음식 검색">
            <b-card-text>
                <b-row style="margin-bottom:10px">
                  <b-col>음식 이름 
                  <b-button @click="search" size="sm" variant="primary">검색</b-button>
                  <b-form-input v-model="foodName" ></b-form-input>
                  </b-col>
                </b-row>
                <b-row>
                  <b-list-group>
                    <b-list-group-item variant="dark" v-for="(food,index) in searchedFoods" :key="index">
                      <div>{{food.foodName}}</div>
                      <b-row align-h="between">
                        <b-col >칼로리 {{food.cal}}</b-col>
                        <b-col >CARB {{food.carb}}</b-col>
                        <b-col >PROTEIN {{food.protein}}</b-col>
                        <b-col >FAT {{food.fat}}</b-col>
                      </b-row>
                    </b-list-group-item>
                  </b-list-group>
                </b-row>
            </b-card-text>
          </b-card>
        </b-collapse>
    <b-row style="margin-bottom : 10px">
      <b-card-group columns>
        <b-card
          border-variant="secondary"
          :header="`${food.foodName}`"
          header-border-variant="secondary"
          align="center"
          v-for="(food, index) in foodList" :key="index"
          style="width: 30vh"
        >
          <b-card-text>
            <div> Serving-Size : {{food.servingSize}}g </div>
            <div>탄수화물 : {{food.carb}}g</div>
            <div>단백질 : {{food.protein}}g</div>
            <div>지방 : {{food.fat}}g</div>
            <div>
              <b-button size="sm" variant='outline-primary' @click="eatFood(food)">+</b-button>
              <b-button size="sm" variant='outline-danger' @click="deleteFood(food.foodSeq)"><i class=" bi bi-trash"></i></b-button>
            </div>
          </b-card-text>
        </b-card>
      </b-card-group>
    </b-row>
  </b-col>
  </b-row>
  </div>
</template>

<script>
import {mapState} from "vuex"
import { Doughnut } from 'vue-chartjs/legacy'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  CategoryScale
} from 'chart.js'
ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

export default {
  name: 'foodList',
  components: {
    Doughnut
  },
  props: {
    chartId: {
      type: String,
      default: 'doughnut-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 250
    },
    height: {
      type: Number,
      default: 400
    },
    cssClasses: {
      default: '',
      type: String
    },
    styles: {
      type: Object,
      default: () => {}
    },
    plugins: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false
      },
      foodName : '',
      servingSize : '',
      cal : '',
      carb : '',
      protein : '',
      fat : ''
    }
  },
  computed: {
    ...mapState(['totalCal', 'foodList', 'nutri', 'logonMember', 'eattenFoods', 'eatenCal', 'searchedFoods']),
    carbData() {
      return {
        labels: ['탄수화물(g)', '남은 양(g)'],
        datasets: [
          {
            backgroundColor: ['#41B883', '#ffe4b5'],
            data: [this.nutri.carb, (this.totalCal.cal*0.5)/4-this.nutri.carb > 0 ? (this.totalCal.cal*0.5)/4-this.nutri.carb : 0]
          }
        ]
      }
    },
    proData(){
      return {      
        labels: ['단백질', '남은 양(g)'],
        datasets: [
          {
            backgroundColor: ['#007bff', '#ffe4b5'],
            data: [this.nutri.pro, (this.totalCal.cal*0.3)/4-this.nutri.pro > 0? (this.totalCal.cal*0.3)/4-this.nutri.pro : 0]
          }
        ]
      }
    },
    fatData(){
      return {
        labels: ['지방', '남은 양(g)'],
        datasets: [
          {
            backgroundColor: ['#E46651', '#ffe4b5'],
            data: [this.nutri.fat, (this.totalCal.cal*0.2)/9-this.nutri.fat > 0?  (this.totalCal.cal*0.2)/9-this.nutri.fat : 0]
          }
        ]
      }
    }
  },
  created(){
    this.$store.dispatch("getDietList",this.logonMember.memberSeq)
  }, 
  methods :{
    eatFood(food) {
      this.$store.dispatch("eatFood", food)
    },
    spitFood(index){
      this.$store.dispatch("spitFood", index)
    },
    setNewFood(){
      const newFood = {
        memberSeq : this.logonMember.memberSeq,
        foodName : this.foodName,
        servingSize : this.servingSize,
        cal : this.cal,
        carb : this.carb,
        protein : this.protein,
        fat : this.fat
      }
      this.$store.dispatch("setNewFood", newFood)
    },
    deleteFood(foodSeq){
      this.$store.dispatch("deleteFood",foodSeq)
    },
    resetCal(){
      this.$store.dispatch("deleteCal",this.logonMember.memberSeq)
    },
    search() {
      this.$store.dispatch("searchFood",this.foodName)
    }
  }
}
</script>

<style scoped>
.card-columns {
    column-count: 2;    
}

#fooddiv{
  height:250%;
}
</style>