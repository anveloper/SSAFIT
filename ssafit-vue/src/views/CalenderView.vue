<template>
  <div>
    <h2>Calender</h2>
    <b-row>
      <b-col cols="4">
        <b-calendar  v-model="value" :date-info-fn="dateClass" @selected="onContext" locale="en-US"></b-calendar>
      </b-col>
      <b-col>
        <router-view></router-view>
      </b-col>
    </b-row>
    <ex-chart v-if="chartShow"></ex-chart>
  </div>
</template>

<script>
import { mapState } from "vuex";
import  exChart from "@/components/calender/CalenderChart.vue"
export default {
  components:{
    exChart,
  },
  data() {
    return {
      value: '',
      context: null,
      dailyRecords:[],
    }
  },
  methods: {
    onContext(ymd) {
      this.dailyRecords = []
      for(const i in this.records){
        if(this.records[i].date == ymd){
          this.dailyRecords.push(this.records[i])
        }
      }
      this.$store.dispatch("setDailyRecords", [this.dailyRecords, ymd])
    },
    dateClass(ymd) { 
      this.$store.dispatch("setWorkedDates");
      return this.workedDates.includes(ymd) ? 'table-info' : ''
    },
  },
  computed: {
    ...mapState(["logonMember", "records", "workedDates", "chartShow"]),
  },
  created() {
    console.log( this.logonMember.userId)
    this.$store.dispatch("getRecord", this.logonMember.userId);
    this.$store.dispatch("setDailyRecords", this.dailyRecords);
  },
  destroyed(){
    this.$store.state.chartShow=false
  }
}
</script>

<style>

</style>