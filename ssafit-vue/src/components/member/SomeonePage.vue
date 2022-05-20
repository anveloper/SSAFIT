<template>
  <div>
    <div>
      <h4>'{{ this.$route.params.userId }}' 님의 FOLLOW LIST</h4>
      <div class="d-flex flex-wrap">
        <div class="col">
          <label for="followListTable"
            >'{{ this.$route.params.userId }}'님이 follow하는 사람
            {{ otherMember.followList.length }}명</label
          >
          <b-table
            id="followListTable"
            class="w-100 va-middle text-center"
            sticky-header
            :items="otherMember.followList"
            :fields="columns"
            :dark="false"
            :fixed="false"
            @row-clicked="detail"
          >
          </b-table>
        </div>
        <div class="col">
          <label for="LeadListTable"
            >'{{ this.$route.params.userId }}'님을 follow하는 사람
            {{ otherMember.leadList.length }}명</label
          >
          <b-table
            id="LeadListTable"
            class="w-100 mx-auto va-middle text-center"
            sticky-header
            :items="otherMember.leadList"
            :fields="columns"
            :dark="false"
            :fixed="false"
            @row-clicked="detail"
          >
          </b-table>
        </div>
      </div>
    </div>
    <div>
      <h4>'{{ this.$route.params.userId }}' 님의 찜 리스트</h4>
      <div>
        <b-card-group columns>
          <b-card
            v-for="video in otherMember.zzimList"
            :key="`${video.videoSeq}`"
            :img-src="`https://img.youtube.com/vi/${video.youtubeId}/0.jpg`"
            img-alt="Card image"
            img-top
          >
            <b-card-text>
              <b-link :to="`/video/${video.youtubeId}`">{{
                video.videoTitle
              }}</b-link>
            </b-card-text>
            <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
          </b-card>
        </b-card-group>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "someonePage",
  data() {
    return {
      columns: [
        { key: "userId", label: "아이디", thClass: "w40" },
        { key: "username", label: "닉네임", thClass: "w40" },
      ],
    };
  },
  computed: {
    ...mapState(["otherMember", "logonMember"]),
  },
  mounted() {
    this.$store.dispatch("getOtherMember", this.$route.params.userId);
    this.$store.dispatch("getOtherZzim", this.$route.params.userId);
  },
  methods: {
    detail(item) {
      let rootId = this.logonMember.userId;
      if (item.userId == rootId)
        this.$router.push(`/member/${rootId}/follow`);
      else {
        this.$router.push(`/member/other/${item.userId}`);
        this.$store.dispatch("getOtherMember", item.userId);
        this.$store.dispatch("getOtherZzim", item.userId);
      }
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
td:hover {
  cursor: pointer;
}
</style>