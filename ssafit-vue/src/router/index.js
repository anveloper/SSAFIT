import Vue from 'vue'
import store from '@/store'
import VueRouter from 'vue-router'

import VideoView from '@/views/VideoView.vue'
import VideoList from '@/components/video/VideoList.vue'
import VideoDetail from '../components/video/VideoDetail.vue'

import MemberView from '@/views/MemberView.vue'
import MyPage from '@/components/member/MyPage.vue'
import SomeonePage from '@/components/member/SomeonePage.vue'
import FollowList from '@/components/member/FollowList.vue'
import ZzimList from '@/components/member/ZzimList.vue'

import LoginMember from '@/components/member/LoginMember.vue'
import JoinMember from '@/components/member/JoinMember.vue'

import CalenderView from '@/views/CalenderView.vue'
import CalenderList from '@/components/calender/CalenderList.vue'
import CalenderRegist from '@/components/calender/CalenderRegist.vue'
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
    path: '/calender/',
    name: 'calender',
    component: CalenderView,
    children: [
      {
        path: ":id/list",
        name: "CalenderList",
        component: CalenderList
      },
      {
        path: ":id/regist",
        name: "CalenderRegist",
        component: CalenderRegist
      }
    ],
    beforeEnter: checkLogin(),
  },
  {
    path: '/member',
    name: 'member',
    component: MemberView,
    children: [
      {
        path: ":userId",
        name: "myPage",
        component: MyPage
      },
      {
        path: ":userId/follow",
        name: "follow",
        component: FollowList
      },
      {
        path: ":userId/zzim",
        name: "zzim",
        component: ZzimList
      },
      {
        path: "other/:userId",
        name: "other",
        component: SomeonePage
      },
    ],
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
  routes,
  scrollBehavior(to, from, savedPosition) {
    to
    from
    savedPosition
    return { x: 0, y: 0 }
  }
})

export default router
