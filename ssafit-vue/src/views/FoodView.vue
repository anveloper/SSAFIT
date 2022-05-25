<template>
  <div>
    <h2>식단관리 페이지</h2>
    <b-card bg-variant="light" v-if="!totalCal" >
      <b-form-group
        label-cols-lg="3"
        label="칼로리 정보를 등록해주세요!"
        label-size="lg"
        label-class="font-weight-bold pt-0"
        class="mb-0"
      >
      <b-form-group
          label="성별 : "
          label-cols-sm="3"
          label-align-sm="right"
          class="mb-0"
          v-slot="{ ariaDescribedby }"
        >
          <b-form-radio-group
            class="pt-2"
            :options="['Male', 'Female',]"
            :aria-describedby="ariaDescribedby"
            v-model="sex"
          ></b-form-radio-group>
        </b-form-group>
      
        <b-form-group
          label="키 :"
          label-for="nested-height"
          label-cols-sm="3"
          label-align-sm="right"
        >
          <b-form-input type="number" id="nested-height" v-model="height"></b-form-input>
        </b-form-group>

        <b-form-group
          label="나이 :"
          label-for="nested-age"
          label-cols-sm="3"
          label-align-sm="right"
        >
          <b-form-input id="nested-age" type="number" v-model="age"></b-form-input>
        </b-form-group>

        <b-form-group
          label="체중 :"
          label-for="nested-weight"
          label-cols-sm="3"
          label-align-sm="right"
        >
          <b-form-input id="nested-weight" type="number" v-model="weight"></b-form-input>
        </b-form-group>

        <b-form-group
          label="활동량 :"
          label-cols-sm="3"
          label-align-sm="right"
          class="mb-0"
          v-slot="{ ariaDescribedby }"
        >
          <b-form-radio-group
            class="pt-2"
            :options="actOptions"
            :aria-describedby="ariaDescribedby"
            v-model="activity"
          ></b-form-radio-group>
        </b-form-group> 

        <b-form-group
          label="목적 :"
          label-cols-sm="3"
          label-align-sm="right"
          class="mb-0"
          v-slot="{ ariaDescribedby }"
        >
          <b-form-radio-group
            class="pt-2"
            :options="purOptions"
            :aria-describedby="ariaDescribedby"
            v-model="purpose"
          ></b-form-radio-group>
        </b-form-group> 
      </b-form-group>
      <b-row align-h="end">
        <b-button @click="calCal">등록</b-button>
      </b-row>
    </b-card>
    <food-list v-else></food-list>

  </div>
</template>

<script>
import { mapState } from "vuex"
import foodList from "@/components/food/FoodList.vue"
export default {
  components:{
    foodList
  },
  data(){
    return{
      sex:"",
      height : '',
      age : '',
      weight : '',
      activity : '',
      purpose : '',
      actOptions:[
        {text : '거의 없다 (좌식 생활)', value : 1.2},
        {text : '조금 있다 (주 1 ~ 3회 운동)', value : 1.375},
        {text : '보통 (주 5 ~ 6회 운동)', value : 1.55},
        {text : '많다. (주 6 ~ 7회 운동)', value : 1.725},
      ],
      purOptions:[
        {text : '다이어트', value : 0.8},
        {text : '벌크업', value : 1.2}
      ]
    }
  },
  created(){
    this.$store.dispatch("getCalorie", this.logonMember.memberSeq)
  },
  computed:{
    ...mapState(['totalCal', 'logonMember'])
  },
  methods:{
    calCal() {
      var totalCal
      if(this.sex == 'Male'){
        totalCal = 66 + (13.7 * this.weight) + (5 * this.height) - (6.8 * this.age)
      } else{
        totalCal = 655 + (9.6 * this.weight) + (1.7 * this.height) - (4.7 * this.age)
      }
      totalCal = totalCal * this.activity * this.purpose
      this.$store.dispatch("setCalories", { "memberSeq":this.logonMember.memberSeq, "cal":totalCal})
    }
  }
}
</script>

<style>

</style>