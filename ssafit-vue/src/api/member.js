import axios from 'axios'

const ROOT_URL = "http://localhost:8888/api/";

export default {
  getMember(userId) {
    return axios.get(ROOT_URL + `member/${userId}`);
  },
  loginMember() {
    return axios.post(ROOT_URL + `member/`);
  }
}