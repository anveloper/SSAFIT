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
        <span class="badge badge-danger mt-1" v-if="!availale.id" v-text="imsg">
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
          :disabled="availale.id == false"
          @blur="inputPass"
          @keyup.13="inputPass"
          @keydown.tab="inputPass"
          ref="inPw"
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
          :disabled="availale.pw == false || availale.id == false"
          ref="inPwc"
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
            availale.id == false
          "
          ref="inNick"
        />
        <span
          class="badge badge-danger mt-1"
          v-if="!availale.nick"
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
    ...mapState(["availale"]),
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
        this.$refs.inId.focus();
        this.imsg = "이미 사용중인 아이디입니다.";
      } else {
        this.$refs.inId.focus();
        this.imsg = "아이디를 입력해 주세요.";
      }
    },
    inputPass() {
      this.$store.dispatch("inputPass", this.newMember.password);
    },
    checkUserName() {
      if (this.newMember.username != "") {
        this.$store.dispatch("checkUserName", this.newMember.username);
        this.$refs.inNick.focus();
        this.nmsg = "이미 사용중인 닉네임입니다.";
      } else {
        this.$refs.inNick.focus();
        this.nmsg = "닉네임을 입력해 주세요.";
      }
    },
    join() {
      if (
        this.availale.id &&
        this.newMember.password == this.passconfirm &&
        this.availale.nick
      ) {
        this.$store.dispatch("join", this.newMember);
      } else {
        if (!this.availale.id) document.getElementById("input-uid").focus();
        else if (this.newMember.password != this.passconfirm)
          document.getElementById("input-pw").focus();
        else if (!this.availale.nick)
          document.getElementById("input-nick").focus();
      }
    },
  },
};
</script>

<style>
</style>