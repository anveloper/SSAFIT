<template>
  <div>
    <h2>Total Calorie:  {{totalCal.cal}}</h2>
    <b-row>
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
      default: 300
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
      }
    }
  },
  computed: {
    ...mapState(['totalCal']),
    carbData() {
      return {
        labels: ['탄수화물(g)', '남은 양(g)'],
        datasets: [
          {
            backgroundColor: ['#41B883', '#ffe4b5'],
            data: [200, (this.totalCal.cal*0.5)/4-150]
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
            data: [80, (this.totalCal.cal*0.3)/4-80]
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
            data: [12, (this.totalCal.cal*0.2)/9-12]
          }
        ]
      }
    }
  }
}
</script>

<style>

</style>