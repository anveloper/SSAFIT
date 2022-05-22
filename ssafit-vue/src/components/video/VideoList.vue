<template>
  <div class="">
    <h2>비디오 리스트</h2>
    <b-tabs class="" content-class="mt-3" align="center">
      <b-tab title="전체" @click="SET_VIDEOS" active></b-tab>
      <b-tab title="전신" @click="getPartVideo(100)"></b-tab>
      <b-tab title="상체" @click="getPartVideo(200)"></b-tab>
      <b-tab title="하체" @click="getPartVideo(300)"></b-tab>
      <b-tab title="복부" @click="getPartVideo(400)"></b-tab>
      <b-tab title="미분류" @click="getPartVideo(0)"></b-tab>
      <b-tab title="YouTube" @click="getYoutubeApi"></b-tab>
    </b-tabs>
    <div class="overflow-auto vh-100" v-if="isTube">
      <div>
        <b-card-group columns>
          <b-card
            v-for="video in partVideos"
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
            <div class="d-flex justify-content-between">
              <span>
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </span>
              <button
                class="btn btn-success ml-2 zzim-btn"
                @click="zzimVideo(video.youtubeId)"
                v-if="logonMember.userId"
              >
                찜
              </button>
            </div>
          </b-card>
        </b-card-group>
      </div>
    </div>
    <div class="overflow-auto vh-100" v-else>
      <div>
        <b-card-group columns>
          <b-card
            v-for="(video, index) in youtubeList"
            :key="index"
            :img-src="`https://img.youtube.com/vi/${video.id.videoId}/0.jpg`"
            img-alt="Card image"
            img-top
          >
            <b-card-text>
              <b-link
                @click="newVideo(video.id.videoId, video.snippet.title)"
                >{{ video.snippet.title }}</b-link
              >
            </b-card-text>
            <!-- <div class="d-flex justify-content-between">
              <span>
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </span>
              <button
                class="btn btn-success ml-2 zzim-btn"
                @click="zzimVideo(video.youtubeId)"
                v-if="logonMember.userId"
              >
                찜
              </button>
            </div> -->
          </b-card>
        </b-card-group>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
export default {
  data() {
    return {
      part: "",
      isTube: true,
    };
  },
  computed: {
    ...mapState(["videos", "partVideos", "logonMember", "youtubeList"]),
  },
  created() {
    this.$store.dispatch("getVideos");
  },
  methods: {
    ...mapMutations(["SET_VIDEOS"]),
    getPartVideo(partCode) {
      this.isTube = true;
      this.$store.dispatch("getPartVideo", partCode);
    },
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
    },
    getYoutubeApi() {
      this.isTube = false;
      this.$store.dispatch("getYoutubeApi");
    },
    newVideo(youtubeId, title) {
      this.$store.dispatch("createVideo",{youtubeId, title})
    },
  },
};
</script>

<style scoped>
.nav-item .nav-link {
  color: rgb(155, 155, 155);
}
.nav-item .nav-link:hover {
  color: rgb(58, 58, 58);
}
.nav-item .nav-link:active {
  color: rgb(49, 50, 68);
}
.zzim-btn {
  padding: 0.2rem;
  font-size: 0.8rem;
}
</style>