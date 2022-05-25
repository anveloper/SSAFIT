<template>
  <span id="sideSpan" v-if="logonMember.userId">
    <span class="justify-content-end mt-4 row">
      <button id="zbtn" class="btn btn-secondary mr-1" @click="sideOn">
        찜
      </button>
      <div
        id="sideBar"
        class="overflow-auto col ml-1 mr-4 d-none d-md-block"
        v-if="isOn"
      >
        <div>
          <b-card-group columns class="row justify-content-center">
            <b-card
              v-for="video in zzimList"
              :key="`${video.videoSeq}`"
              :img-src="`https://img.youtube.com/vi/${video.youtubeId}/0.jpg`"
              img-alt="Card image"
              img-top
              style="max-width: 300px"
            >
              <b-card-text class="title-box">
                <b-link
                  class="title"
                  :to="`/video/${video.youtubeId}`"
                  @click="goVideo(video.youtubeId)"
                  >{{ video.videoTitle }}</b-link
                >
              </b-card-text>
              <div class="d-flex justify-content-between">
                <span class="view-cnt">
                  <i class="bi bi-eye"></i> {{ video.viewCnt }}
                </span>
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
    </span>
  </span>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "zzimSideBar",
  data() {
    return {
      isOn: false,
    };
  },
  computed: {
    ...mapState(["zzimList", "logonMember"]),
  },
  methods: {
    sideOn() {
      this.$store.dispatch("getZzim", this.logonMember.userId);
      this.isOn = !this.isOn;
    },
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
    },
    goVideo(youtubeId) {
      this.$store.dispatch("getVideo", youtubeId);
    },
  },
  mounted() {
    this.$store.dispatch("getZzim", this.logonMember.userId);
  },
};
</script>

<style>
#sideSpan {
  position: fixed;
  right: 0px;
  top: 40px;
  z-index: 99;
}

#zbtn {
  max-height: 40px;
}

#sideBar {
  background: #343a4099;
  border-radius: 5px;
  height: 90vh;
  max-width: 300px;
}

.view-cnt,
.zzim-btn {
  padding: 0.2rem !important;
  font-size: 0.8rem !important;
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