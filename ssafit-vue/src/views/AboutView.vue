<template>
  <div class="about container text-center">
    <h1>This is an about page</h1>
    <div id="map" style="width: 500px; height: 400px"></div>
  </div>
</template>
<script>
export default {
  name: "AboutView",
  data() {
    return {
      map: null,
    };
  },
  mounted() {
    const script = document.createElement("script");
    script.src = `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=${process.env.VUE_APP_KAKAO_MAP_KEY}`;
    /* global kakao */
    script.addEventListener("load", () => {
      kakao.maps.load(this.initMap);
    });
    document.head.appendChild(script);
  },
  methods: {
    initMap() {
      var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스
      var options = {
        //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
        level: 3, //지도의 레벨(확대, 축소 정도)
      };

      this.map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    },
  },
};
</script>

<style>
</style>