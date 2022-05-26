<template>
  <div id="welPage">
    <iframe
      width="100%"
      height="100%"
      src="https://www.youtube.com/embed/wSQaGTRkxIA?autoplay=1&mute=1&rel=0&controls=0&modestbranding=1&amp;playlist=wSQaGTRkxIA&loop=1"
      title="YouTube video player"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen
    ></iframe>
    <span class="fixed-bottom d-flex justify-content-center">
      <!-- <img src="@/assets/scroll.gif" /> -->
      <img id="scrimg" src="@/assets/scroll.svg" @click="goMain()"/>
    </span>
  </div>
</template>

<script>
export default {
  name: "homeView",
  data() {
    return {};
  },
  methods: {
    goMain(){
      this.$emit("goMain")
    }
  },
};
</script>

<style>
#welPage {
  height: 100vh; /* 넓이 값은 조정해서 사용 */
  width: 100vw;
}
#scrimg {
  width: 33vw;
  z-index: 99;
  animation: watch 1s linear infinite both;
}


@keyframes watch {
  0% {
    transform: translate(0);
  }
  50% {
    transform: translate(0, -30px);
  }
  100% {
    transform: translate(0);
  }
}
#scrimg:hover {
  animation-play-state: paused;
}
</style>