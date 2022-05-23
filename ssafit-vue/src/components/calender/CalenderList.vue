<template>
  <div>
  <b-button block variant="primary" to="regist">운동 기록하기</b-button>
  <b-list-group>
    <b-list-group-item v-for="(record,index) in dailyRecords" :key="index">
      <div>{{record.exName}} {{record.sets}}세트</div>
      {{record.weight}}kg X {{record.reps}}회
      </b-list-group-item>
  </b-list-group>
  </div>
</template>

<script>
import {mapState} from "vuex"; 
export default {
  computed:{
    ...mapState(["dailyRecords"])
  }
}
</script>

<style>

</style>