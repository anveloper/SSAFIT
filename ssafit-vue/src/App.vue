<template>
  <div id="app">
    <header-nav></header-nav>
    <b-container class="mt-3">
      <router-view />
    </b-container>
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

#app {
  font-family: "OTWelcomeRA", Helvetica, Arial, sans-serif;
  color: #2c3e50;
}
</style>
