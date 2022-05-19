import Vue from 'vue'
import store from '@/store'
import VueRouter from 'vue-router'

import VideoView from '@/views/VideoView.vue'
import VideoList from '@/components/video/VideoList.vue'
import VideoDetail from '../components/video/VideoDetail.vue'

import MyPage from '@/components/member/MyPage.vue'

import LoginMember from '@/components/member/LoginMember.vue'
import JoinMember from '@/components/member/JoinMember.vue'



Vue.use(VueRouter)

const checkLogin = () => (from, to, next) => {
  if (store.state.logonMember.userId.length > 0) {
    next();
  } else {
    if (confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
      console.dir()
      next(`/login?call=${from.fullPath}`);
    }
  }
};

const routes = [
  {
    path: '/video',
    component: VideoView,
    children: [
      {
        path: "",
        name: "video",
        component: VideoList
      },
      {
        path: ":id",
        name: "videoDetail",
        component: VideoDetail
      },
    ]
  },
  {
    path: '/member/:userId',
    name: 'myPage',
    component: MyPage,
    beforeEnter: checkLogin(),
  },
  {
    path: '/login',
    name: 'login',
    component: LoginMember,
  },
  {
    path: '/join',
    name: 'join',
    component: JoinMember,
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
