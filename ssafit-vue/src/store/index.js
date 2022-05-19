import Vue from 'vue'
import Vuex from 'vuex'

import videoApi from '@/api/video.js'
import router from '@/router'
// import apiBoard from "@/api/board.js"
import apiMember from "@/api/member.js"

Vue.use(Vuex)

export default new Vuex.Store({
  state: {

    video:{},
    reply:[],
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

    GET_VIDEO(state, payload){
      state.video = payload;
    },
    GET_REPLY(state, payload){
      state.reply = payload
    }
  },
  actions: {
    getVideo({commit}, id){
      videoApi.getVideo(id)
      .then((res) => {
        console.log(res);
        commit('GET_VIDEO', res.data)
      }).catch((err) => {
        console.log(err);
      })
    },
    getReply({commit}, id){
      videoApi.getReplyList(id)
      .then((res)=>{
        commit('GET_REPLY', res.data)
      }).catch((err)=>{
        console.log(err)
      })
    LOGOUT(state) {
      state.logonMember = {
        memberSeq: '',
        userId: '',
        password: '',
        username: ''
      }
    },
    MEMBER_LOGON(state, payload) {
      state.logonMember = payload
    }
  },
  actions: {
    logout({ commit }) {
      commit('LOGOUT');
    },
    memberLogin({ commit }, member) {
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
          commit('MEMBER_LOGON', { logonMember: res.data.logonMember, })
          sessionStorage.setItem("auth-token", res.data["auth-token"])
          router.push({ name: 'video' })
        }).catch((err) => { console.log(err) })
    }
  },
  modules: {
  }
})
