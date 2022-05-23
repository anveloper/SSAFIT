<template>
  <div>
    <h3>찜 리스트</h3>
    <div class="overflow-auto vh-100">
      <div>
        <b-card-group columns>
          <b-card
            v-for="video in zzimList"
            :key="`${video.videoSeq}`"
            :img-src="`https://img.youtube.com/vi/${video.youtubeId}/0.jpg`"
            img-alt="Card image"
            img-top
          >
            <b-card-text class="title-box">
              <b-link class="title" :to="`/video/${video.youtubeId}`">{{
                video.videoTitle
              }}</b-link>
            </b-card-text>
            <div class="d-flex justify-content-between">
              <span class="view-cnt"
                ><i class="bi bi-eye"></i> {{ video.viewCnt }}</span
              >
              <button
                class="btn btn-danger ml-2 zzim-btn"
                @click="zzimVideo(video.youtubeId)"
                v-if="logonMember.userId"
              >
                해제
              </button>
            </div>
          </b-card>
        </b-card-group>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "zzimView",
  data() {
    return {};
  },
  computed: {
    ...mapState(["zzimList", "logonMember"]),
  },
  methods: {
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
    },
  },
  mounted() {
    this.$store.dispatch("getZzim", this.$route.params.userId);
  },
};
</script>

<style>
.view-cnt,
.zzim-btn {
  padding: 0.2rem;
  font-size: 0.8rem;
}

.title-box {
  max-height: 1.2rem;
  font-size: 1.1rem;
  position: relative;
  overflow-x: hidden;
  overflow-y: hidden;
}
.title {
  color: #343a40;
}
</style>