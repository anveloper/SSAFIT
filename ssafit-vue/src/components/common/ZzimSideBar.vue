<template>
  <span class="fixed-top mt-5" v-if="logonMember.userId">
    <div class="justify-content-end mt-4 row">
      <button id="zbtn" class="btn btn-secondary mr-1" @click="sideOn">
        찜
      </button>
      <div id="sideBar" class="overflow-auto col ml-1 mr-4 d-none d-lg-block" v-if="isOn">
        <div >
          <b-card-group columns class="row justify-content-center">
            <b-card
              v-for="video in zzimList"
              :key="`${video.videoSeq}`"
              :img-src="`https://img.youtube.com/vi/${video.youtubeId}/0.jpg`"
              img-alt="Card image"
              img-top
              style="max-width:300px;"
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
  methods: {
    sideOn() {
      this.$store.dispatch("getZzim", this.logonMember.userId);
      this.isOn = !this.isOn;
    },
  },
  computed: {
    ...mapState(["logonMember", "zzimList"]),
  },
  mounted() {
    this.$store.dispatch("getZzim", this.logonMember.userId);
  },
};
</script>

<style>
#zbtn {
  max-height: 40px;
}
#sideBar {
  background: #343a4099;
  border-radius: 5px;
  height: 80vh;
  max-width: 300px;
}
</style>