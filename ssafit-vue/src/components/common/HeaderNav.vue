<template>
  <header>
    <b-navbar type="dark" variant="secondary">
      <div class="container-fluid">
        <div>
          <b-navbar-brand :to="{ name: 'video' }">SSAFIT</b-navbar-brand>
        </div>
        <div v-if="logonMember.userId != ''">
          <b-nav pills>
            <b-nav-item @click="logout">로그아웃</b-nav-item>
            <b-nav-item :to="{ name: 'member' }">마이페이지</b-nav-item>
          </b-nav>
        </div>
        <div v-else>
          <b-nav pills>
            <b-nav-item :to="{ name: 'login' }">로그인</b-nav-item>
            <b-nav-item :to="{ name: 'join' }">회원가입</b-nav-item>
          </b-nav>
        </div>
      </div>
    </b-navbar>
  </header>
</template>

<script>
import { mapState, mapMutations } from "vuex";

export default {
  name: "headerNav",
  data() {
    return {
    };
  },
  methods: {
    ...mapMutations(["MEMBER_LOGOUT"]),
    logout() {
      this.MEMBER_LOGOUT();
    },
  },
  computed: {
    ...mapState(["logonMember"]),
  },
  mounted() {},
};
</script>

<style>
.nav-item > a {
  color: whitesmoke;
}
.nav-item > a:hover {
  color: rgb(141, 141, 141);
}
.nav-item > a:active {
  color: rgb(187, 188, 255);
}
</style>
