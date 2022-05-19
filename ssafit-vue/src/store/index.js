import Vue from 'vue'
import Vuex from 'vuex'
import videoApi from '@/api/video.js'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    video:{},
    reply:[],
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
    }
  },
  modules: {
  }
})
