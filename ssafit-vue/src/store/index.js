import Vue from 'vue'
import Vuex from 'vuex'
import router from '@/router'
// import apiBoard from "@/api/board.js"
import apiMember from "@/api/member.js"

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    logonMember: {
      memberSeq: '',
      userId: '',
      password: '',
      username: ''
    }
  },
  getters: {
  },
  mutations: {
    LOGOUT(state) {
      state.logonMember = {
        memberSeq: '',
        userId: '',
        password: '',
        username: ''
      }
    }
  },
  actions: {
    logout({ commit }) {
      commit('LOGOUT');
    },
    memberLogin({ commit }, member) {
      apiMember.loginMember(member)
        .then((res) => {
          commit('USER_LOGIN', res.data.logonMember)
          sessionStorage.setItem("auth-token", res.data["auth-token"])
          router.push({ name: 'video' })
        }).catch((err) => { console.log(err) })
    }
  },
  modules: {
  }
})
