<template>
  <div>
  <b-button block variant="primary" to="regist">운동 기록하기</b-button>
  <b-list-group>
    <b-list-group-item v-for="(record,index) in dailyRecords" :key="index" button @click="getExRecord(record)">
      <div>{{record.exName}} {{record.sets}}세트</div>
      <b-row align-h="between">
        <b-col >{{record.weight}}kg X {{record.reps}}회</b-col>
        <b-col style="text-align:right">{{record.volume}}kg</b-col>
      </b-row>
      
      </b-list-group-item>
  </b-list-group>
  </div>
</template>

<script>
import {mapState} from "vuex"; 
export default {
  computed:{
    ...mapState(["dailyRecords"])
  },
  methods:{
    getExRecord(record) {
      this.$store.dispatch("getExRecord",record)
    }
  }
}
</script>

<style>

</style>