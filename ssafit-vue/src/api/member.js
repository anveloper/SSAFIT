import { axiosService } from '@/api'

export default {
  getMember(userId) {
    return axiosService.get(`/member/${userId}`);
  },
  loginMember(member) {
    return axiosService.post(`/member/login`, member);
  }
}