<template>
  <div class="">
    <h2>비디오 리스트</h2>
      <b-tabs class="" content-class="mt-3" align="center">
        <b-tab title="전체" @click="getVideo" active></b-tab>
        <b-tab title="전신" @click="getPartVideo(100)"></b-tab>
        <b-tab title="상체" @click="getPartVideo(200)"></b-tab>
        <b-tab title="하체" @click="getPartVideo(300)"></b-tab>
        <b-tab title="복부" @click="getPartVideo(400)"></b-tab>
      </b-tabs>
    <div class="overflow-auto vh-100">
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
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      part: "",
      partVideos:[]
    };
  },
  computed: {
    ...mapState(["videos", "logonMember"]),
  },
  created() {
    this.$store.dispatch("getVideos");   
  },
  beforeMount(){
    this.partVideos = this.$store.state.videos;
  },
  methods: {
    getVideo() {
      this.partVideos = this.videos;
    },
    getPartVideo(partCode) {
      this.partVideos = [];
      this.videos.forEach((element) => {
        if (element.partCode == partCode) {
          this.partVideos.push(element);
        }
      });
    },
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
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