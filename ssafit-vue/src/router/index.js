import Vue from 'vue'
import VueRouter from 'vue-router'

import VideoDetail from '../components/VideoDetail.vue'
import VideoView from '@/views/VideoView.vue'
import MemberView from '@/views/MemberView.vue'
import LoginMember from '@/components/member/LoginMember.vue'
import JoinMember from '@/components/member/JoinMember.vue'


Vue.use(VueRouter)

const routes = [
  {
    path: '/video',
    name: 'video',
    component: VideoView,
    childen: [

    ]
  },
  {
    path: '/member',
    name: 'member',
    component: MemberView,
    childen: [

    ]
  },
  {
    path: '/video',
    component: VideoView,
    children: [
      {
        path: ":id",
        name: "videoDetail",
        component: VideoDetail
      }
    ]
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
