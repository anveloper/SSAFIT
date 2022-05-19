import axios from 'axios'

const ROOT_URL = process.env.VUE_APP_API_SERVER;

export default {
  getMember(userId) {
    return axios.get(ROOT_URL + `/member/${userId}`);
  },
  loginMember(member) {
    return axios.post(ROOT_URL + `/member/login`, member);
  }
}