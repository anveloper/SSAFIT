<template>
  <div class="">
    <div class="d-flex justify-content-between">
      <span style="font-size: 1.8rem"> 비디오 리스트 </span>
      <span>
        <input
          style="width: 4rem; text-align: center"
          v-model="key"
          name="key"
          v-if="!isTube"
        />
      </span>
    </div>
    <b-tabs class="" content-class="mt-3" align="center">
      <b-tab title="전체" @click="getVideos" active></b-tab>
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
            v-for="video in videos"
            :key="`${video.videoSeq}`"
            :img-src="`https://img.youtube.com/vi/${video.youtubeId}/0.jpg`"
            img-alt="Card image"
            img-top
          >
            <b-card-text class="title-box">
              <b-link
                class="title"
                :to="`/video/${video.youtubeId}`"
                >{{ video.videoTitle | truncate(25, "...") }}</b-link
              >
            </b-card-text>
            <div class="d-flex justify-content-between">
              <span class="view-cnt"
                ><i class="bi bi-eye"></i> {{ video.viewCnt }}</span
              >
              <span v-if="!isUnknown || logonMember.userId != 'admin'">
                <button
                  class="btn btn-success ml-2 zzim-btn"
                  @click="zzimVideo(video.youtubeId)"
                  v-if="logonMember.userId"
                >
                  찜
                </button>
              </span>
              <span
                class="d-flex"
                v-if="isUnknown && logonMember.userId == 'admin'"
              >
                <b-form-select
                  class="update-value"
                  v-model="video.partCode"
                  :options="options"
                  :ref="`${video.youtubeId}`"
                ></b-form-select>
                <button
                  class="btn btn-success update-btn"
                  @click="updatePartCode(video.youtubeId, video.partCode)"
                >
                  수정
                </button>
              </span>
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
            <b-card-text class="title-box">
              <b-link
                class="title"
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
import { mapState } from "vuex";
export default {
  data() {
    return {
      key: "헬스",
      isTube: true,
      isUnknown: false,
      partCode: [],
      options: [
        { value: 0, text: "미분류" },
        { value: 100, text: "전신" },
        { value: 200, text: "상체" },
        { value: 300, text: "하체" },
        { value: 400, text: "복부" },
      ],
    };
  },
  computed: {
    ...mapState(["videos", "logonMember", "youtubeList"]),
  },
  created() {
    this.$store.dispatch("getVideos");
  },
  methods: {
    getVideos() {
      this.$store.dispatch("getVideos");
    },
    getPartVideo(partCode) {
      this.isTube = true;
      this.isUnknown = partCode == 0 ? true : false;
      this.$store.dispatch("getPartVideo", partCode);
    },
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
    },
    getYoutubeApi() {
      this.isTube = false;
      this.$store.dispatch("getYoutubeApi", this.key);
    },
    newVideo(youtubeId, title) {
      this.$store.dispatch("createVideo", { youtubeId, title });
    },
    updatePartCode(youtubeId, partCode) {
      // let partCode = this.$refs[youtubeId][0].value;
      this.$store.dispatch("updatePartCode", { youtubeId, partCode });
    },
  },
  filters: {
    truncate: function (text, length, suffix) {
      if (text.length > length) {
        return text.substring(0, length) + suffix;
      } else {
        return text;
      }
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
.view-cnt,
.zzim-btn,
.update-value,
.update-btn {
  height: 1.5rem;
  padding: 0.2rem;
  font-size: 0.8rem;
}
.update-value {
  min-width: 3.8rem;
}
.update-btn {
  min-width: 2rem;
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