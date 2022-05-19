import { axiosService } from '@/api'

const ROOT_URL = process.env.VUE_APP_API_SERVER;

export default {
  getVideoList(params) {
    return axiosService.get(ROOT_URL + `/video`, { params });
  },
  getVideo(youtubeId) {
    return axiosService.get(ROOT_URL + `/video/${youtubeId}`);
  },
  createVideo(video) {
    return axiosService.post(ROOT_URL + `/video`, video);
  },
}