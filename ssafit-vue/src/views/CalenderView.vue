<template>
  <div>
    <b-row>
      <b-col md="auto">
        <b-calendar v-model="value" :date-info-fn="dateClass" @context="onContext" locale="en-US"></b-calendar>
      </b-col>
      <b-col>
      </b-col>
    </b-row>
        <p>Value: <b>'{{ value }}'</b></p>
        <p class="mb-0">Context:</p>
        <pre class="small" style="color:red">{{ context }}</pre>
  </div>
</template>

<script>
export default {
    data() {
      return {
        value: '',
        context: null,
        done: []
      }
    },
    methods: {
      onContext(ctx) {
        this.context = ctx
      },
      dateClass(ymd, date) {
        const day = date.getDate()
        return day == 10  && day <= 20 ? 'table-info' : ''
      }
    },
    created: {

    }
}
</script>

<style>

</style>