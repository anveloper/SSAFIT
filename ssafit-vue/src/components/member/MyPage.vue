<template>
  <div>
    <h3>{{ $route.params.userId }} 님의 정보</h3>
    <div>
      <div class="container col-md-8 col-lg-6 col-xl-6">
        <!-- userId input -->
        <div class="form-outline mb-2">
          <label class="form-label" for="input-uid">아이디</label>
          <input
            type="text"
            id="input-uid"
            class="form-control"
            v-model="logonMember.userId"
            trim
            disabled
          />
        </div>
        <!-- password input -->
        <div class="form-outline mb-2">
          <label class="form-label" for="input-pw">비밀번호</label>
          <input
            type="password"
            id="input-pw"
            class="form-control"
            v-model="logonMember.password"
            trim
            :disabled="!isModi"
          />
        </div>
        <!-- password-c input -->
        <div class="form-outline mb-2" :hidden="!isModi">
          <label class="form-label" for="input-pwc">비밀번호 재확인</label>
          <input
            type="password"
            id="input-pwc"
            class="form-control"
            v-model="passconfirm"
            trim
          />
          <span
            class="badge badge-danger mt-1"
            v-if="logonMember.password != passconfirm && passconfirm != ''"
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
            v-model="logonMember.username"
            trim
            @blur="checkUserName"
            :disabled="!isModi"
            ref="inNick"
          />
          <span
            class="badge badge-danger mt-1"
            v-if="!available.nick"
            v-text="nmsg"
          >
          </span>
        </div>
        <div v-if="this.logonMember">
          <div v-if="!isModi">
            <button
              type="button"
              class="btn btn-success btn-block mt-4"
              @click="modify"
            >
              수정
            </button>
          </div>
          <div v-else>
            <button
              type="button"
              class="btn btn-danger btn-block mt-4"
              @click="modify"
            >
              취소</button
            ><button
              type="button"
              class="btn btn-primary btn-block mt-4"
              @click="update"
            >
              완료
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "myPage",
  data() {
    return {
      isModi: false,
      passconfirm: "",
      nmsg: "",
      pmsg: "비밀번호가 일치하지 않습니다.",
    };
  },
  computed: {
    ...mapState(["logonMember", "available"]),
  },
  created() {},
  methods: {
    modify() {
      this.isModi = !this.isModi;
      this.passconfirm = "";
    },
    update() {
      if (this.logonMember.password == this.passconfirm && this.available.nick) {
        this.$store.dispatch("updateMember", this.logonMember);
        this.modify();
      } else {
        if (this.logonMember.password != this.passconfirm)
          document.getElementById("input-pw").focus();
        else if (!this.available.nick)
          document.getElementById("input-nick").focus();
      }
    },
    checkUserName() {
      if (this.logonMember.username != "") {
        this.$store.dispatch("checkUserName", this.logonMember.username);
        this.$refs.inNick.focus();
        this.nmsg = "이미 사용중인 닉네임입니다.";
      } else {
        this.$refs.inNick.focus();
        this.nmsg = "닉네임을 입력해 주세요.";
      }
    },
  },
};
</script>

<style>
table.b-table thead th.w20 {
  width: 20%;
}
table.b-table thead th.w40 {
  width: 40%;
}
</style>