import { axiosService } from '@/api'

export default {
  getVideoList() {
    return axiosService.get(`/video`);
  },
  getVideoPartList(partCode) {
    return axiosService.post(`/video/partCode/${partCode}`);
  },
  getVideo(youtubeId) {
    return axiosService.get(`/video/${youtubeId}`);
  },
  createVideo(youtubeId, title) {    
    return axiosService.post(`/video/create`, { youtubeId: youtubeId, title: title });
  },
  updatePartCode(youtubeId, partCode ) {
    return axiosService.put(`/video/${youtubeId}/${partCode}`);
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