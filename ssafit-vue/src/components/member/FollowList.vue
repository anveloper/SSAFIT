<template>
  <div>
    <h3>FOLLOW LIST</h3>
    <div class="d-flex flex-wrap">
      <div class="col">
        <label for="followListTable"
          >내가 follow하는 사람 {{ 0 + followList.length }}명</label
        >
        <b-table
          id="followListTable"
          class="w-100 va-middle text-center"
          sticky-header
          :items="followList"
          :fields="columns"
          :fixed="false"
          @row-clicked="detail"
        >
          <template v-slot:cell(detail)="{ item }">
            <span
              ><button class="btn btn-secondary" @click="unfollow(item)">
                <i class="bi bi-heart-arrow"></i></button
            ></span>
          </template>
        </b-table>
      </div>
      <div class="col">
        <label for="LeadListTable"
          >나를 follow하는 사람 {{ 0 + leadList.length }}명</label
        >
        <b-table
          id="LeadListTable"
          class="w-100 mx-auto va-middle text-center"
          sticky-header
          :items="leadList"
          :fields="columns"
          :dark="false"
          :fixed="false"
          @row-clicked="detail"
        >
          <template v-slot:cell(detail)="{ item }">
            <span
              ><button class="btn btn-secondary" @click="block(item)">
                <i class="bi bi-heart-arrow"></i></button
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
  name: "followView",
  data() {
    return {
      columns: [
        { key: "userId", label: "아이디", thClass: "w40" },
        { key: "username", label: "닉네임", thClass: "w40" },
        { key: "detail", label: "해제", thClass: "w20" },
      ],
      perPage: 10,
    };
  },
  computed: {
    ...mapState(["followList", "leadList", "logonMember"]),
  },
  created() {
    this.$store.dispatch("getMember", this.$route.params.userId);
  },
  methods: {
    detail(item) {
      console.log(item);
      this.$router.push(`/member/other/${item.userId}`);
    },
    unfollow(followId) {
      this.$store.dispatch("followMember", {
        userId: this.logonMember.userId,
        followId: followId.userId,
      });
    },
    block(otherId) {
      this.$store.dispatch("blockMember", {
        userId: this.logonMember.userId,
        followId: otherId.userId,
      });
    },
  },
};
</script>

<style>
</style>