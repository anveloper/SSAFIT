<template>
  <div>
    <h3>마이 페이지 {{ $route.params.userId }}</h3>
    <div class="d-flex row">
      <div class="col">
        <label for="followListTable"
          >내가 follow하는 사람 {{ followList.length }}명</label
        >
        <b-table
          id="followListTable"
          class="w-100 mx-auto va-middle text-center"
          sticky-header
          :items="followList"
          :fields="columns"
          :dark="false"
          :fixed="false"
        >
          <template v-slot:cell(detail)="{ item }">
            <span
              ><b-bnt @click="detail(item)"
                ><i class="bi bi-heart-arrow"></i></b-bnt
            ></span>
          </template>
        </b-table>
      </div>
      <div class="col">
        <label for="LeadListTable"
          >나를 follow하는 사람 {{ leadList.length }}명</label
        >
        <b-table
          id="LeadListTable"
          class="w-100 mx-auto va-middle text-center"
          sticky-header
          :items="leadList"
          :fields="columns"
          :dark="false"
          :fixed="false"
        >
          <template v-slot:cell(detail)="{ item }">
            <span
              ><b-bnt @click="detail(item)"
                ><i class="bi bi-heart-arrow"></i></b-bnt
            ></span>
          </template>
        </b-table>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "myPage",
  data() {
    return {
      columns: [
        { key: "userId", label: "아이디", thClass: "w40" },
        { key: "username", label: "닉네임", thClass: "w40" },
        { key: "detail", label: "상세보기", thClass: "w20" },
      ],
      perPage: 10,
    };
  },
  computed: {
    ...mapState(["logonMember", "followList", "leadList", "zzimList"]),
  },
  created() {
    this.$store.dispatch("getMember", this.$route.params.userId);
  },
  methods: {
    detail(item) {
      alert(item);
    },
  },
};
</script>

<style>
table.b-table thead th.w20 {
  width: 20%;
}
table.b-table thead th.w40 {
  width: 40%;
}
</style>