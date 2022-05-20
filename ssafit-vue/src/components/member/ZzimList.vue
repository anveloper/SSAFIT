<template>
  <div>
    <h3>찜 리스트</h3>
    <div>
      <b-card-group columns>
        <b-card
          v-for="video in zzimList"
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
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "zzimView",
  data() {
    return {};
  },
  computed: {
    ...mapState(["zzimList"]),
  },
  mounted() {
    this.$store.dispatch("getZzim", this.$route.params.userId);
  },
};
</script>

<style>
</style>