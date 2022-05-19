import { axiosService } from '@/api'

const ROOT_URL = process.env.VUE_APP_API_SERVER;

export default {
  getReplyList(youtubeId) {
    return axiosService.get(ROOT_URL + `/reply/${youtubeId}`);
  }
}