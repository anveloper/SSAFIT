import axios from 'axios'

const ROOT_URL = "http://localhost:8888/api/";

export default {
  getVideoList(params) {
    return axios.get(ROOT_URL + `video`, { params });
  },
  getVideo(youtubeId) {
    return axios.get(ROOT_URL + `video/${youtubeId}`);
  },
  createVideo(video) {
    return axios.post(ROOT_URL + `video/`, video);
  },
  getReplyList(youtubeId){
    return axios.get(ROOT_URL+`reply/${youtubeId}`);
  }
}