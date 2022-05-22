import { axiosService } from '@/api'

export default {
  getVideoList() {
    return axiosService.get(`/video`);
  },
  getVideo(youtubeId) {
    return axiosService.get(`/video/${youtubeId}`);
  },
  createVideo(video) {
    return axiosService.post(`/video`, video);
  },
  getZzim(userId) {
    return axiosService.get(`/video/zzim/${userId}`);
  },
  insertZzim(userId, youtubeId) {
    return axiosService.post(`/video/zzim/${userId}/${youtubeId}`);
  },
  deleteZzim(userId, youtubeId) {
    return axiosService.delete(`/video/zzim/${userId}/${youtubeId}`);
  }
}