import Vue from 'vue'
import Vuex from 'vuex'
import router from '@/router'

import { axiosService } from '@/api/index.js'
import apiVideo from '@/api/video.js'
import apiMember from "@/api/member.js"
import apiReply from "@/api/reply.js"
import apiYoutube from "@/api/youtube.js"
import apiRecord from "@/api/record.js"
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    videos: [],
    video: {},
    reply: [],
    logonMember: {
      memberSeq: '',
      userId: '',
      password: '',
      username: ''
    },
    followList: [],
    leadList: [],
    zzimList: [],
    youtubeList: [],
    savedId: '',
    available: { id: false, pw: false, nick: false, },
    page: 1,
    otherMember: {
      followList: [],
      leadList: [],
      zzimList: [],
    },
    records:[],
    dailyRecords:[],
  },
  getters: {
    rootReply: state => {
      return state.reply.filter(repl => repl.reSeq == 0)
    },
    reReply: (state) => {
      return state.reply.filter(repl => repl.reSeq != 0)
    }
  },
  mutations: {
    GET_VIDEO(state, payload) {
      state.video = payload;
    },
    GET_VIDEOS(state, payload) {
      state.videos = payload;
    },
    PART_VIDEO(state, payload) {
      state.partVideos = payload;
    },
    SET_YOUTUBE_VIDEO(state, payload) {
      state.youtubeList = payload;
    },
    GET_ZZIM(state, payload) {
      state.zzimList = payload;
    },
    GET_OTHER_ZZIM(state, payload) {
      state.otherMember.zzimList = payload;
    },
    GET_REPLY(state, payload) {
      state.reply = payload
    },
    CREATE_REPLY(state, payload) {
      state.reply = payload
    },
    DELETE_REPLY(state, payload) {
      state.reply.forEach((repl, index) => {
        if (repl.replySeq == payload) {
          state.reply.splice(index, 1);
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
      state.available.id = false;
      state.available.pw = false;
      state.available.nick = false;
    },
    CHECK_USER_ID(state, ok) {
      if (ok == 'ok') state.available.id = true;
      else state.available.id = false;
    },
    INPUT_PASS(state, bool) {
      if (bool) state.available.pw = true;
      else state.available.pw = false;
    },
    CHECK_USER_NAME(state, ok) {
      if (ok == 'ok') state.available.nick = true;
      else state.available.nick = false;
    },
    GET_MEMBER(state, payload) {
      state.followList = payload.followList;
      state.leadList = payload.leadList;
    },
    GET_OTHER_MEMBER(state, payload) {
      state.otherMember.followList = payload.followList;
      state.otherMember.leadList = payload.leadList;
    },
    GET_RECORD(state, payload){
      state.records = payload
    }, 
    SET_DAILY_RECORDS(state, payload){
      state.dailyRecords = payload
    }
  },
  actions: {
    getVideo({ commit }, id) {
      apiVideo.getVideo(id)
        .then((res) => {
          commit('GET_VIDEO', res.data)
        }).catch((err) => { console.log(err) })
    },
    getVideos({ commit }) {
      apiVideo.getVideoList()
        .then((res) => {
          commit('GET_VIDEOS', res.data)
        }).catch((err) => {
          console.log(err);
        })
    },
    getPartVideo({ commit }, partCode) {
      apiVideo.getVideoPartList(partCode)
        .then((res) => {
          commit('GET_VIDEOS', res.data)
        }).catch((err) => {
          console.log(err);
        })
    },
    updatePartCode({ commit }, { youtubeId, partCode }) {
      apiVideo.updatePartCode(youtubeId, partCode).then((res) => {
        commit('GET_VIDEOS', res.data)
      }).catch(() => { });
    },
    getYoutubeApi({ commit }) {
      apiYoutube.getYoutubeApi().then((res) => {
        console.log(res.data.items)
        commit("SET_YOUTUBE_VIDEO", res.data.items);
      }).catch((err) => { console.log(err) });
    },
    createVideo({ commit }, { youtubeId, title }) {
      apiVideo.createVideo(youtubeId, title).then((res) => {
        commit('GET_VIDEO', res.data)
      }).then(() => {
        router.push(`/video/${youtubeId}`)
      }).catch((err) => { console.log(err) });
    },
    getZzim({ commit }, userId) {
      apiVideo.getZzim(userId).then((res) => {
        commit('GET_ZZIM', res.data.zzimList)
      }).catch((err) => { console.log(err) });
    },
    getOtherZzim({ commit }, userId) {
      apiVideo.getZzim(userId).then((res) => {
        commit('GET_OTHER_ZZIM', res.data.zzimList)
      }).catch((err) => { console.log(err) });
    },
    getReply({ commit }, id) {
      apiReply.getReplyList(id)
        .then((res) => {
          commit('GET_REPLY', res.data)
        }).catch((err) => {
          console.log(err)
        })
    },
    createReply({ commit }, reply) {
      apiReply.createReply(reply)
        .then((res) => {
          commit('CREATE_REPLY', res.data)
        })
    },
    deleteReply({ commit }, replySeq) {
      apiReply.deleteReply(replySeq)
        .then(() => {
          commit('DELETE_REPLY', replySeq)
        }).catch((err) => {
          console.log(err)
        })
    },
    updateReply({ commit }, reply) {
      apiReply.updateReply(reply)
        .then(() => {
          commit
        }).catch((err) => {
          console.log(err)
        })
    },
    zzimVideo({ commit }, { userId, youtubeId }) {
      let flag = true;
      let arr = this.state.zzimList;
      if (arr)
        for (let i = 0; i < arr.length; i++) {
          if (arr[i].youtubeId == youtubeId) {
            flag = false;
            console.log(arr[i].youtubeId);
            break;
          }
        }
      if (flag) {
        if (confirm("'찜' 하시겠습니까?"))
          apiVideo.insertZzim(userId, youtubeId).then((res) => {
            commit('GET_ZZIM', res.data);
          }).catch((err) => { console.log(err) });
      } else {
        if (confirm("'찜'을 해제하시겠습니까?"))
          apiVideo.deleteZzim(userId, youtubeId).then((res) => {
            commit('GET_ZZIM', res.data);
          }).catch((err) => { console.log(err) });
      }
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
        commit("GET_MEMBER", res.data);
      }).catch((err) => { console.log(err) });
    },
    getOtherMember({ commit }, userId) {
      apiMember.getOtherMember(userId).then((res) => {
        commit("GET_OTHER_MEMBER", res.data);
      }).catch((err) => { console.log(err) });
    },
    followMember({ commit }, { userId, followId }) {
      let flag = true;
      let arr = this.state.followList;
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].userId == followId) {
          flag = false;
          break;
        }
      }
      if (flag) {
        if (confirm("'팔로우' 하시겠습니까?"))
          apiMember.followMember(userId, followId).then((res) => {
            commit('GET_MEMBER', res.data);
          }).catch((err) => { console.log(err) });
      } else {
        if (confirm("'언팔로우'하시겠습니까?"))
          apiMember.unfollowMember(userId, followId).then((res) => {
            commit('GET_MEMBER', res.data);
          }).catch((err) => { console.log(err) });
      }
    },
    blockMember({ commit }, { userId, followId }) {
      let sto = this;
      if (confirm("상대방의 '팔로우'를 해제하시겠습니까?"))
        apiMember.unfollowMember(followId, userId).then(() => {
          commit;
          sto.dispatch("getMember", this.state.logonMember.userId);
        }).catch((err) => { console.log(err) });
    },
    getRecord({commit}, userId){
      commit;
      apiRecord.getRecordList(userId)
      .then((res)=>{
        commit("GET_RECORD", res.data)
      }).catch((err)=>{console.log(err)})
    },
    setDailyRecords({commit}, dailyRecords){
      commit("SET_DAILY_RECORDS", dailyRecords)
    }
  },
  modules: {
  }
})
