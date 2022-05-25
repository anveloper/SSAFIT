<template>
  <span id="mapSpan">
    <button id="map-btn" class="btn btn-warning" @click="mapOn()">
      <img id="btn-img" src="@/assets/map-icon.svg" />
    </button>
    <!-- v-if로 부를 경우 오류남. 랜더된 div에 입히는 것. -->
    <span v-show="isMap">
      <div class="map_wrap col p-1">
        <div id="map" ref="map" :style="{ width, height }"></div>
        <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
        <div class="custom_zoomcontrol radius_border">
          <span @click="zoom(-1)"><i class="bi bi-plus"></i></span>
          <span @click="zoom(1)"><i class="bi bi-dash"></i></span>
        </div>
      </div>
    </span>
  </span>
</template>

<script>
// let kakao = window.kakao;
export default {
  name: "mapView",
  data() {
    return {
      BASE_URL: `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&libraries=services&appkey=${process.env.VUE_APP_KAKAO_MAP_KEY}`,
      mapOption: {
        center: {
          lat: 36.3504567,
          lng: 127.3848187,
        },
        level: 7,
      },
      isMap: true,
      map: null,
      infowindow: null,
      ps: null,
      markers: [],
      width: 30 + "vw",
      height: 30 + "vh",
    };
  },
  methods: {
    mapOn() {
      this.isMap = !this.isMap;
      this.map.setCenter(
        new kakao.maps.LatLng(
          this.mapOption.center.lat,
          this.mapOption.center.lng
        )
      );
      this.map.setLevel(this.mapOption.level);
    },
    zoom(delta) {
      this.map.setLevel(this.map.getLevel() + delta);
    },
    handleResize() {
      this.width = window.innerWidth;
      this.height = window.innerHeight;
      if (this.width > this.height) {
        this.$refs.map.style.width = 30 + "vw";
        this.$refs.map.style.height = 30 + "vh";
      } else {
        this.$refs.map.style.width = 95 + "vw";
        this.$refs.map.style.height = 30 + "vh";
      }
    },
    addScript() {
      const script = document.createElement("script");
      script.src = this.BASE_URL;
      /* global kakao */
      script.addEventListener("load", () => {
        window.kakao.maps.load(this.initMap);
      });
      document.head.appendChild(script);
    },
    initMap() {
      this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
      const container = this.$refs.map;

      const { center, level } = this.mapOption;

      this.map = new kakao.maps.Map(container, {
        center: new kakao.maps.LatLng(center.lat, center.lng),
        level,
      });
      this.ps = new kakao.maps.services.Places();
      this.ps.keywordSearch("대전 헬스", this.placesSearchCB);
    },
    placesSearchCB(data, status, pagination) {
      console.log(pagination);
      if (status === kakao.maps.services.Status.OK) {
        let bounds = new kakao.maps.LatLngBounds();

        for (var i = 0; i < data.length; i++) {
          this.displayMarker(data[i]);
          bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }
        this.map.setBounds(bounds);
      }
    },
    displayMarker(place) {
      let marker = new kakao.maps.Marker({
        map: this.map,
        position: new kakao.maps.LatLng(place.y, place.x),
      });

      kakao.maps.event.addListener(marker, "click", () => {
        this.infowindow.setContent(
          '<div style="padding:5px;font-size:12px;">' +
            place.place_name +
            "</div>"
        );
        this.infowindow.open(this.map, marker);
      });
    },
  },
  mounted() {
    window.kakao && window.kakao.maps ? this.initMap() : this.addScript();

    window.addEventListener("resize", this.handleResize);
  },
  beforeDestroy() {
    this.map.setCenter(
      new kakao.maps.LatLng(
        this.mapOption.center.lat,
        this.mapOption.center.lng
      )
    );
    this.map.setLevel(this.mapOption.level);
    window.addEventListener("resize", this.handleResize);
  },
  watch: {
    "options.level"(cur, prev) {
      console.log(`${prev} => ${cur}`);
      this.map.setLevel(cur);
    },
    "options.center"(cur) {
      this.map.panTo(new kakao.maps.LatLng(cur.lat, cur.lng));
    },
  },
};
</script>

<style scoped>
#map {
  margin-top: 4px;
  overflow: hidden;
  border-radius: 5px;
}
#mapSpan {
  position: fixed;
  left: 2%;
  bottom: 2%;
  z-index: 99;
}

#map-btn {
  width: 10vh;
  height: 10vh;
  max-width: 2.2rem;
  max-height: 2.2rem;
  padding: 0;
  transition: all 0.3s ease-in-out;
}

#map-btn:hover {
  transform: scale(1.3);
}

#btn-img {
  width: 100%;
  height: 100%;
}

/* kakao map controll css */
.map_wrap {
  position: relative;
  overflow: hidden;
}
.radius_border {
  border: 1px solid #919191;
  border-radius: 5px;
}
.custom_zoomcontrol {
  position: absolute;
  top: 10px;
  right: 10px;
  width: 36px;
  height: 80px;
  overflow: hidden;
  z-index: 1;
  background-color: #f5f5f5;
}
.custom_zoomcontrol span {
  display: block;
  width: 36px;
  height: 40px;
  text-align: center;
  cursor: pointer;
}
.custom_zoomcontrol span .bi-plus,
.custom_zoomcontrol span .bi-dash {
  font-size: 2rem;
  padding: 12px 0;
  border: none;
}
.custom_zoomcontrol span:first-child {
  border-bottom: 1px solid #bfbfbf;
}
</style>