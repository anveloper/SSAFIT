<template>
  <div id="app">
    <home-view v-if="welcome"></home-view>
    <div v-else>
      <header-nav></header-nav>
      <div id="pageTop" />
      <div>
        <b-container class="mt-1">
          <router-view />
        </b-container>
        <zzim-side-bar></zzim-side-bar>
        <map-view></map-view>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderNav from "@/components/common/HeaderNav.vue";
import ZzimSideBar from "@/components/common/ZzimSideBar.vue";
import MapView from "./components/common/MapView.vue";
import { mapState } from "vuex";
import HomeView from "./views/HomeView.vue";

export default {
  name: "App",
  components: {
    HeaderNav,
    ZzimSideBar,
    MapView,
    HomeView,
  },
  data() {
    return {
      welcome: true,
    };
  },
  methods: {
    goMain() {
      this.welcome = false;
      this.$router.push("/video").catch(()=>{});
    },
    onScoll() {
      const currentScrollPosition =
        window.pageYOffset || document.documentElement.scrollTop;
      if (currentScrollPosition < 0) return;
      if (this.welcome) this.goMain();
    },
  },
  computed: {
    ...mapState(["logonMember"]),
  },
  mounted() {
    window.addEventListener("scroll", this.onScoll);
  },
  beforeDestroy() {
    window.removeEventListener("scroll", this.onScoll);
  },
};
</script>

<style>
@import "/src/common/font/font.css";

* {
  font-family: "GangwonEduPowerExtraBoldA", Helvetica, Arial, sans-serif;
}

#pageTop {
  margin-top: 80px;
}

*::-webkit-scrollbar {
  display: none; /* Chrome, Safari, Opera */
}

#app {
  background-image: url("@/assets/back.svg");
  background-repeat: no-repeat;
  background-size: 110%;
  background-attachment: fixed;
  background-position: bottom;
  min-height: 980px;
  height: 100%;
}

#app .nav-link {
  color: #343a40;
}

#app .nav-link:active {
  color: #596b86;
}
</style>
