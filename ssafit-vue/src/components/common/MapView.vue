<template>
  <span id="mapSpan">
    <button id="map-btn" class="btn btn-warning" @click="mapOn()">
      <img id="btn-img" src="@/assets/map-icon.svg" />
    </button>
    <!-- v-if로 부를 경우 오류남. 랜더된 div에 입히는 것. -->
    <span v-show="isMap">
      <div class="map_wrap">
        <div id="map" ref="map" style="width: 30vw; height: 30vh"></div>
        <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
        <div class="custom_zoomcontrol radius_border">
          <span @click="zoomIn()"><i class="bi bi-plus"></i></span>
          <span @click="zoomOut()"><i class="bi bi-dash"></i></span>
        </div>
      </div>
    </span>
  </span>
</template>

<script>
export default {
  name: "mapView",
  data() {
    return {
      isMap: false,
      map: null,
      infowindow: null,
      ps: null,
      width: 0,
      height: 0,
    };
  },
  methods: {
    mapOn() {
      this.isMap = !this.isMap;
      // this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
      // this.ps = new kakao.maps.services.Places();
      // this.ps.keywordSearch("헬스장", this.placesSearchCB);
    },
    addScript() {
      const script = document.createElement("script");
      script.src = `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=${process.env.VUE_APP_KAKAO_MAP_KEY}`;
      /* global kakao */
      script.addEventListener("load", () => {
        kakao.maps.load(this.initMap);
      });
      document.head.appendChild(script);
    },
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(36.355354, 127.298593),
        level: 7,
      };
      this.map = new kakao.maps.Map(container, options);
    },
    zoomIn() {
      this.map.setLevel(this.map.getLevel() - 1);
    },
    zoomOut() {
      this.map.setLevel(this.map.getLevel() + 1);
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
    displayMarker(place) {
      var marker = new kakao.maps.Marker({
        map: this.map,
        position: new kakao.maps.LatLng(place.y, place.x),
      });

      kakao.maps.event.addListener(marker, "click", function () {
        this.infowindow.setContent(
          '<div style="padding:5px;font-size:12px;">' +
            place.place_name +
            "</div>"
        );
        this.infowindow.open(this.map, marker);
      });
    },
    placesSearchCB(data, status, pagination) {
      pagination;
      if (status === kakao.maps.services.Status.OK) {
        var bounds = new kakao.maps.LatLngBounds();

        for (var i = 0; i < data.length; i++) {
          this.displayMarker(data[i]);
          bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }
        this.map.setBounds(bounds);
      }
    },
  },
  mounted() {
    window.kakao && window.kakao.maps ? this.initMap() : this.addScript();
    window.addEventListener("resize", this.handleResize);
  },
  beforeDestroy() {
    window.addEventListener("resize", this.handleResize);
  },
};
</script>

<style scoped>
#map {
  margin-top: 4px;
  position: relative;
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
  width: 2.2rem;
  height: 2.2rem;
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