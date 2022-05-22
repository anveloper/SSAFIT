<template>
  <div>
    <div class="h2">마이 페이지</div>
    <div class="row">
      <div class="col">
        <b-tabs class="" content-class="mt-3" align="center">
          <b-tab
            title="내 정보"
            @click="move(`/member/${userId}`)"
            active
          ></b-tab>
          <b-tab
            title="팔로우"
            @click="move(`/member/${userId}/follow`)"
          ></b-tab>
          <b-tab
            title="찜 목록"
            @click="move(`/member/${userId}/zzim`)"
          ></b-tab>
        </b-tabs>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "memberView",
  data() {
    return {
      userId: this.$route.params.userId,
    };
  },
  components: {},
  methods: {
    move(url) {
      this.$router.push(url);
    },
  },
};
</script>

<style>
#mem-card {
  height: 80%;
}
</style>