import axios from 'axios'

const ROOT_URL = process.env.VUE_APP_API_SERVER;

export default {
  getVideoList(params) {
    return axios.get(ROOT_URL + `/video`, { params });
  },
  getVideo(youtubeId) {
    return axios.get(ROOT_URL + `/video/${youtubeId}`);
  },
  createVideo(video) {
    return axios.post(ROOT_URL + `/video/`, video);
  }
}