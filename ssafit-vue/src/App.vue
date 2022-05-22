<template>
  <div id="app">
    <header-nav></header-nav>
    <div id="pageTop" />
    <div >      
      <b-container class="mt-1 overflow-auto">
        <router-view />        
      </b-container>
      <zzim-side-bar></zzim-side-bar>
    </div>
  </div>
</template>

<script>
import HeaderNav from "@/components/common/HeaderNav.vue";
import ZzimSideBar from "@/components/common/ZzimSideBar.vue";

export default {
  name: "App",
  components: {
    HeaderNav,
    ZzimSideBar,
  },
  data() {
    return {
      logonUser: null,
    };
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
  height: 100vh;
}
#app .nav-link {
  color: #343a40;
}
#app .nav-link:active {
  color: #596b86;
}
</style>
