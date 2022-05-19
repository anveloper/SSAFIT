import Vue from 'vue'
import Vuex from 'vuex'
import router from '@/router'
// import apiVideo from "@/api/video.js"
// import apiMember from "@/api/member.js"
import axiosService from '@/api'
import apiMember from "@/api/indexmember.js"


Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    logonMember: {
      memberSeq: '',
      userId: '',
      password: '',
      username: ''
    },
    savedId: '',
  },
  getters: {
  },
  mutations: {
    MEMBER_LOGOUT(state) {
      state.logonMember = { memberSeq: '', userId: '', password: '', username: '' }
      sessionStorage.removeItem("auth-token")
      router.push('/video').catch(() => { })
    },
    MEMBER_LOGIN(state, { logonMember, token }) {
      state.logonMember = logonMember;
      sessionStorage.setItem("auth-token", token);
      axiosService.headers["auth-token"] = token;
    }
  },
  actions: {
    memberLogin({ commit }, { member, call }) {
      let loginMember = { userId: member.id, password: member.pw }
      if (member.saveId) {
        this.savedId = member.id
        var today = new Date();
        today.setDate(today.getDate() + 7);
        document.cookie = "savedId=" + member.id + "; path=/; expires=" + today.toGMTString() + ";"
      } else {
        document.cookie = "savedId=" + "; path=/; expires=" + -1 + ";"
      }
      apiMember.loginMember(loginMember)
        .then((res) => {
          console.log(res.data.logonMember)
          commit('MEMBER_LOGIN', { logonMember: res.data.logonMember, token: res.data["auth-token"] })
          if (call) router.push(call)
          else router.push({ name: 'video' })
        }).catch((err) => { console.log(err) })
    }
  },
  modules: {
  }
})
