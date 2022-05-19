<template>
  <div>
    <h2>비디오 리스트</h2>
    <div>
      <b-tabs content-class="mt-3" align="center">
        <b-tab title="전체" active>
          <div>
            <b-card-group columns>
              <b-card
                v-for="video in videos"
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
        </b-tab>
        <b-tab title="전신" @click="getPartVideo(100)">
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
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </b-card>
            </b-card-group>
          </div>
        </b-tab>
        <b-tab title="상체" @click="getPartVideo(200)">
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
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </b-card>
            </b-card-group>
          </div>
        </b-tab>
        <b-tab title="하체" @click="getPartVideo(300)">
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
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </b-card>
            </b-card-group>
          </div>
        </b-tab>
        <b-tab title="복부" @click="getPartVideo(400)">
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
                <b-badge variant="danger">조회수 : {{ video.viewCnt }}</b-badge>
              </b-card>
            </b-card-group>
          </div>
        </b-tab>
      </b-tabs>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      part: "",
      partVideos: [],
    };
  },
  computed: {
    ...mapState(["videos"]),
  },
  created() {
    this.$store.dispatch("getVideos");
  },
  methods: {
    getPartVideo(partCode) {
      this.partVideos = [];
      this.videos.forEach((element) => {
        if (element.partCode == partCode) {
          this.partVideos.push(element);
        }
      });
    },
  },
};
</script>

<style >
#__BVID__55___BV_tab_button__ {
  color: rgb(99, 99, 99) !important;
}
#__BVID__55___BV_tab_button__ {
  color: rgb(48, 48, 48);
}
</style>