<template>
  <div>
    <div class="container col-md-8 col-lg-6 col-xl-6">
      <h3 class="mt-4">회원가입</h3>
      <!-- userId input -->
      <div class="form-outline mb-2">
        <label class="form-label" for="input-uid">아이디</label>
        <input
          type="text"
          id="input-uid"
          class="form-control"
          v-model="newMember.userId"
          trim
          @blur="checkUserId"
          @keyup.13="checkUserId"
          @keydown.tab="checkUserId"
          ref="inId"
        />
        <span
          class="badge badge-danger mt-1"
          v-if="!available.id"
          v-text="imsg"
        >
        </span>
      </div>
      <!-- password input -->
      <div class="form-outline mb-2">
        <label class="form-label" for="input-pw">비밀번호</label>
        <input
          type="password"
          id="input-pw"
          class="form-control"
          v-model="newMember.password"
          trim
          :disabled="available.id == false"
          @blur="inputPass"
          @keyup.13="inputPass"
          @keydown.tab="inputPass"
        />
      </div>
      <!-- password-c input -->
      <div class="form-outline mb-2">
        <label class="form-label" for="input-pwc">비밀번호 재확인</label>
        <input
          type="password"
          id="input-pwc"
          class="form-control"
          v-model="passconfirm"
          trim
          :disabled="available.pw == false || available.id == false"
        />
        <span
          class="badge badge-danger mt-1"
          v-if="newMember.password != passconfirm && passconfirm != ''"
          v-text="pmsg"
        >
        </span>
      </div>

      <!-- username input -->
      <div class="form-outline mb-2">
        <label class="form-label" for="input-nick">닉네임</label>
        <input
          type="text"
          id="input-nick"
          class="form-control"
          v-model="newMember.username"
          trim
          @blur="checkUserName"
          :disabled="
            passconfirm == '' ||
            newMember.password != passconfirm ||
            available.id == false
          "
        />
        <span
          class="badge badge-danger mt-1"
          v-if="!available.nick"
          v-text="nmsg"
        >
        </span>
      </div>
      <button
        type="button"
        class="btn btn-primary btn-block mt-4"
        @click="join"
      >
        회원가입
      </button>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "joinView",
  data() {
    return {
      newMember: {
        memberSeq: 0,
        userId: "",
        password: "",
        username: "",
      },
      passconfirm: "",
      imsg: "",
      pmsg: "비밀번호가 일치하지 않습니다.",
      nmsg: "",
    };
  },
  computed: {
    ...mapState(["available"]),
  },
  created() {
    this.$store.dispatch("joinInit");
  },
  mounted() {
    this.$refs.inId.focus();
  },
  methods: {
    checkUserId() {
      if (this.newMember.userId != "") {
        this.$store.dispatch("checkUserId", this.newMember.userId);
        this.imsg = "이미 사용중인 아이디입니다.";
        if (!this.available.id) {
          this.$refs.inId.focus();
        }
      } else {
        this.imsg = "아이디를 입력해 주세요.";
          this.$refs.inId.focus();
      }
      if (this.available.id && this.newMember.password == "") {
        this.$refs.inPw.focus();
      }
    },
    inputPass() {
      this.$store.dispatch("inputPass", this.newMember.password);
    },
    checkUserName() {
      if (this.newMember.username != "") {
        this.$store.dispatch("checkUserName", this.newMember.username);
        this.nmsg = "이미 사용중인 닉네임입니다.";
      } else {
        this.nmsg = "닉네임을 입력해 주세요.";
      }
    },
    join() {
      if (
        this.available.id &&
        this.newMember.password == this.passconfirm &&
        this.available.nick
      ) {
        this.$store.dispatch("join", this.newMember);
      } else {
        if (!this.available.id) document.getElementById("input-uid").focus();
        else if (this.newMember.password != this.passconfirm)
          document.getElementById("input-pw").focus();
        else if (!this.available.nick)
          document.getElementById("input-nick").focus();
      }
    },
  },
};
</script>

<style>
</style>