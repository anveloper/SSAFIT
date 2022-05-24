<template>
<div>
  <b-button block variant="primary" to="list">운동 기록보기</b-button>
    <b-row align-h="between" style="margin-top:10px">
        <b-col>
            <label for="datepicker">Choose a date</label>
              <b-form-datepicker id="datepicker" v-model="date" class="mb-2" readonly></b-form-datepicker>
            <b-row>
              <b-col>
                <label for="weight" >Weight</label>
                <b-form-input  style="font-family: initial" type="number" v-model="weight"></b-form-input>
              </b-col>
              <b-col>
                <label for="reps">reps</label>
                <b-form-input style="font-family: initial" type="number" v-model="reps"></b-form-input>
              </b-col>
              <b-col>
                <label for="sets">sets</label>
                <b-form-input type="number" style="font-family: initial" v-model="sets"></b-form-input>
              </b-col>
            </b-row>
            <b-row align-h="end" style="margin-top:10px" >
              <b-col >
                <b-button type="submit" variant="primary" @click="regist">등록</b-button>
              </b-col>
            </b-row>
        </b-col>
        <b-col>
          <b-tabs class="" content-class="mt-3" align="center">
            <b-tab title="하체" @click="getPartEx(1)"></b-tab>
            <b-tab title="가슴" @click="getPartEx(2)"></b-tab>
            <b-tab title="등" @click="getPartEx(3)"></b-tab>
            <b-tab title="어깨" @click="getPartEx(4)"></b-tab>
            <b-tab title="팔" @click="getPartEx(5)"></b-tab>
          </b-tabs>
          <b-list-group>
              <b-form-group >
                <b-list-group-item v-for="ex in partEx" :key="ex.exNo">
                  <b-form-radio v-model="selected" :value="`${ex.exNo}/${ex.exName}`">{{ex.exName}}</b-form-radio>
                </b-list-group-item>
              </b-form-group>
            </b-list-group>
      </b-col>
    </b-row>
</div>
</template>

<script>
import {mapState} from "vuex";
export default {
  data(){
    return{
      partEx:[],
      selected:"",
      weight:"",
      reps:"",
      sets:"",
    }
  },
  computed:{
    ...mapState(["excercises", "date", "logonMember"])
  },
  created() {
    this.$store.dispatch("getExcercises")
  },
  mounted(){
    this.partEx=this.excercises.filter(ex => ex.partNo==1)
  },
  methods: {
    getPartEx(part_no){
      this.partEx=[];
      this.partEx=this.excercises.filter(ex => ex.partNo==part_no)
      
    },
    regist() {
      const record = {
        "userSeq" : this.logonMember.memberSeq,
        "date" : this.date,
        "exNo" : this.selected.split("/")[0],
        "exName" : this.selected.split("/")[1],
        "weight" : this.weight,
        "reps" : this.reps,
        "sets" : this.sets,
        "volume" : this.sets*this.weight*this.reps
      }
      console.log(record)
      this.$store.dispatch("writeRecord", record)
    }
  }
}
</script>

<style>

</style>