import { axiosService } from '@/api'

const ROOT_URL = process.env.VUE_APP_API_SERVER;

export default {
  getReplyList(youtubeId) {
    return axiosService.get(ROOT_URL + `/reply/${youtubeId}`);
  },
  createReply(reply){
    return axiosService.post(ROOT_URL+`/reply`, reply)
  },
  deleteReply(replySeq){
    return axiosService.delete(ROOT_URL+`/reply/${replySeq}`)
  },
  updateReply(reply){
    return axiosService.put(ROOT_URL+`/reply`, reply)
  }
}