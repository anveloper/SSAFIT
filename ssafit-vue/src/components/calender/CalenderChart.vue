<template>
  <div>
    <LineChartGenerator
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :plugins="plugins"
    :css-classes="cssClasses"
    :styles="styles"
    :width="width"
    :height="height"
    />
  </div>
</template>

<script>
import { Line as LineChartGenerator } from 'vue-chartjs/legacy'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  CategoryScale,
  PointElement
} from 'chart.js'
import{ mapState } from "vuex"
ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  CategoryScale,
  PointElement
)
export default {
name: 'LineChart',
  components: {
    LineChartGenerator
  },
  props: {
    chartId: {
      type: String,
      default: 'line-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 400
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
      chartOptions : {
        responsive: true,
        maintainAspectRatio: false
      }
    }
  },
  computed: {
    ...mapState(["exRecords"]),
    chartData(){
      var dates = [];
      var volumes = [];
      for(var i = 0; i < this.exRecords.length; i++){
        dates.push(this.exRecords[i].date)
        volumes.push(this.exRecords[i].volume)
      }
      const labels = dates;
      const datasets=[
        {
          label: this.exRecords[0].exName,
          backgroundColor: '#007bff',
          data: volumes
        }
      ]
      return{ labels , datasets}
    }
  },
}
</script>

<style>

</style>