import Vue from 'vue'
import Vuex from 'vuex'
import router from '@/router'

import { axiosService } from '@/api/index.js'
import apiVideo from '@/api/video.js'
import apiMember from "@/api/member.js"
import apiReply from "@/api/reply.js"

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    videos:[],
    video: {},
    reply: [],
    logonMember: {
      memberSeq: '',
      userId: '',
      password: '',
      username: ''
    },
    savedId: '',
    availale: { id: false, pw: false, nick: false, },
    page: 1,
    followList: [],
    leadList: [],
    zzimList: []
  },
  getters: {
  },
  mutations: {
    GET_VIDEO(state, payload) {
      state.video = payload;
    },
    GET_VIDEOS(state, payload){
      state.videos = payload;  
    },
    GET_REPLY(state, payload) {
      state.reply = payload
    },
    CREATE_REPLY(state, payload){
      state.reply = payload
    },
    DELETE_REPLY(state, payload){
      state.reply.forEach((repl, index)=>{
        if(repl.replySeq == payload) {
          state.reply.splice(index,1);
        } 
      })
    },
    MEMBER_LOGOUT(state) {
      state.logonMember = { memberSeq: '', userId: '', password: '', username: '' }
      sessionStorage.removeItem("auth-token")
      router.push('/video').catch(() => { })
    },
    MEMBER_LOGIN(state, { logonMember, token }) {
      state.logonMember = logonMember;
      sessionStorage.setItem("auth-token", token);
      axiosService.defaults.headers["auth-token"] = token;
    },
    JOIN_INIT(state) {
      state.availale.id = false;
      state.availale.pw = false;
      state.availale.nick = false;
    },
    CHECK_USER_ID(state, ok) {
      if (ok == 'ok') state.availale.id = true;
      else state.availale.id = false;
    },
    INPUT_PASS(state, bool) {
      if (bool) state.availale.pw = true;
      else state.availale.pw = false;
    },
    CHECK_USER_NAME(state, ok) {
      if (ok == 'ok') state.availale.nick = true;
      else state.availale.nick = false;
    },
    GET_MEMBER(state, payload) {
      state.followList = payload.followList;
      state.leadList = payload.leadList;
      state.zzimList = payload.zzimList;
    }
  },
  actions: {
    getVideo({ commit }, id) {
      apiVideo.getVideo(id)
        .then((res) => {
          commit('GET_VIDEO', res.data)
        }).catch((err) => {
          console.log(err);
        })
    },
    getVideos(){
      apiVideo.getVideoList()
      .then((res)=>{
        this.commit('GET_VIDEOS', res.data)
      }).catch((err)=>{
        console.log(err);
      })
    },
    getReply({ commit }, id) {
      apiReply.getReplyList(id)
        .then((res) => {
          commit('GET_REPLY', res.data)
        }).catch((err) => {
          console.log(err)
        })
    },
    createReply({commit}, reply) {
      apiReply.createReply(reply)
      .then((res)=>{
        commit('CREATE_REPLY', res.data)
      })
    },
    deleteReply({commit}, replySeq){
      apiReply.deleteReply(replySeq)
      .then(()=>{
        commit('DELETE_REPLY',replySeq)
      }).catch((err) => {
        console.log(err)
      })
    },
    updateReply({commit}, reply){
      apiReply.updateReply(reply)
      .then(()=>{
        commit
      }).catch((err)=>{
        console.log(err)
      })
    },
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
        commit('MEMBER_LOGIN', { logonMember: res.data.logonMember, token: res.data["auth-token"] })
        if (call) router.push(call)
        else router.push({ name: 'video' })
      }).catch((err) => { console.log(err) })
    },
    joinInit({ commit }) {
        commit("JOIN_INIT");
      },
      join({ commit }, payload) {
      commit;
      apiMember.joinMember(payload).then(() => {
        router.push({ name: 'login' })
      }).catch((err) => {
        if (err)
          console.log(err)
      });
    },
    checkUserId({ commit }, userId) {
      apiMember.checkUserId(userId)
        .then((res) => {
          commit('CHECK_USER_ID', res.data);
        }).catch((err) => { console.log(err) });
    },
    inputPass({ commit }, password) {
      if (password != '')
        commit('INPUT_PASS', true);
      else
        commit('INPUT_PASS', false);
    },
    checkUserName({ commit }, userId) {
      apiMember.checkUserName(userId)
        .then((res) => {
          commit('CHECK_USER_NAME', res.data);
        }).catch((err) => { console.log(err) });
    },
    getMember({ commit }, userId) {
      apiMember.getMember(userId).then((res) => {
        commit("GET_MEMBER",res.data);
      }).catch((err) => {console.log(err) });
    }
  },
  modules: {
  }
})
