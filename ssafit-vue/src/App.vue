<template>
  <div id="app">
    <header-nav></header-nav>
    <div id="pageTop" />
    <div>
      <b-container class="mt-5">
        <router-view />
      </b-container>
    </div>
  </div>
</template>

<script>
import HeaderNav from "@/components/common/HeaderNav.vue";

export default {
  name: "App",
  components: {
    HeaderNav,
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
</style>
