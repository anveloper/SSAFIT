<template>
  <div>
    <h3>{{ $route.params.userId }} 님의 정보</h3>
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
            v-model="logonMember.userId"
            trim
            @blur="checkUserId"
            @keyup.13="checkUserId"
            @keydown.tab="checkUserId"
            ref="inId"
          />
          <span
            class="badge badge-danger mt-1"
            v-if="!availale.id"
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
            v-model="logonMember.password"
            trim
            :disabled="availale.id == false"
            @blur="inputPass"
            @keyup.13="inputPass"
            @keydown.tab="inputPass"
            ref="inPw"
          />
        </div>
        <!-- password-c input -->
        <div class="form-outline mb-2" hidden>
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
            v-model="logonMember.username"
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
  </div>
</template>

<script>
import {mapState} from 'vuex'

export default {
  name: "myPage",
  data() {
    return {

    };
  },
  computed:{
    ...mapState(['logonMember', 'available']),
  },
  created(){

  }
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