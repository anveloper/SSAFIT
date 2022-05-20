import { axiosService } from '@/api'

export default {
  getMember(userId) {
    return axiosService.get(`/member/${userId}`);
  },
  getOtherMember(userId) {
    return axiosService.get(`/member/other/${userId}`);
  },
  loginMember(member) {
    return axiosService.post(`/member/login`, member);
  },
  joinMember(member) {
    return axiosService.post(`/member/join`, member)
  },
  checkUserId(userId) {
    return axiosService.post(`/member/join/checkId`, userId);
  },
  checkUserName(username) {
    return axiosService.post(`/member/join/checkName`, username);
  },
}