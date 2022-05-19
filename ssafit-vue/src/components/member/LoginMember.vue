<template>
  <div class="mt-4">
    <div class="mt-4">
      <div class="container col-md-8 col-lg-6 col-xl-4">
        <h3 class="mt-4">로그인</h3>
        <!-- userId input -->
        <div class="form-outline mb-4">
          <input
            type="text"
            id="input-id"
            class="form-control"
            v-model="user.id"
            trim
          />
          <label class="form-label" for="input-id">User ID</label>
        </div>

        <!-- Password input -->
        <div class="form-outline mb-4">
          <input
            type="password"
            id="input-pw"
            class="form-control"
            v-model="user.pw"
          />
          <label class="form-label" for="input-pw">Password</label>
        </div>

        <!-- 2 column grid layout for inline styling -->
        <div class="row mb-4">
          <div class="col d-flex justify-content-center">
            <!-- Checkbox -->
            <div class="form-check">
              <input
                class="form-check-input"
                type="checkbox"
                v-model="user.saveId"
                id="save-id"
              />
              <label class="form-check-label" for="save-id">
                아이디 저장
              </label>
            </div>
          </div>

          <div class="col">
            <!-- Simple link -->
            <a href="#!">비밀번호 찾기</a>
          </div>
        </div>
        <!-- Submit button -->
        <button
          type="button"
          class="btn btn-primary btn-block mb-4"
          @click="login"
        >
          로그인
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "loginView",
  data() {
    return {
      user: {
        id: "",
        pw: "",
        saveId: false,
      },
    };
  },
  methods: {
    login() {
      this.$store.dispatch("memberLogin", {
        member: this.user,
        call: this.$route.query.call,
      });
    },
  },
  created() {
    let savedId = document.cookie.match(
      "(^|;) ?" + "savedId" + "=([^;]*)(;|$)"
    );
    if (savedId[2]) {
      this.user.saveId = true;
      this.user.id = savedId[2];
    }
  },
};
</script>

<style>
</style>