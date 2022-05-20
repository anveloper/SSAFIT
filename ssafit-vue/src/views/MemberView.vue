<template>
  <div>
    <div class="h3">마이 페이지</div>
    <div class="row">
      <div class="col">
        <ul class="nav nav-pills d-flex justify-content-center" >
          <li class="nav-item">
            <router-link class="nav-link" :to="`/member/${userId}`"
              >내 정보</router-link
            >
          </li>
          <li class="nav-item">
            <router-link class="nav-link" :to="`/member/${userId}/follow`"
              >팔로우</router-link
            >
          </li>
          <li class="nav-item">
            <router-link class="nav-link" :to="`/member/${userId}/zzim`"
              >찜 목록</router-link
            >
          </li>
        </ul>
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
  methods: {},
};
</script>

<style>
#mem-card {
  height: 80%;
}
</style>