<template>
  <div>
    <h2>Calender</h2>
    <b-row>
      <b-col md="auto">
        <b-calendar v-model="value" :date-info-fn="dateClass" @selected="onContext" locale="en-US"></b-calendar>
      </b-col>
      <b-col>
        <router-view></router-view>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
    data() {
      return {
        value: '',
        context: null,
        workedDates:[],
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
        this.$store.dispatch("setDailyRecords", this.dailyRecords)
      },
      dateClass(ymd) {  
        return this.workedDates.includes(ymd) ? 'table-info' : ''
      },
    },
    computed: {
      ...mapState(["logonMember", "records"]),
    },
    created() {
      this.$store.dispatch("getRecord", this.logonMember.userId);
      this.workedDates = [];
      for(const i in this.records){
          this.workedDates.push(this.records[i].date)
        }
    },
    beforeMount() {
        
    }
}
</script>

<style>

</style>