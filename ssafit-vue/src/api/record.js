import { axiosService } from "@/api";

export default{
  getRecordList(userId){
    return axiosService.get(`/record/${userId}`)
  },
  writeRecord(record){
    return axiosService.post(`/record`,record)
  },
  getExRecord(record){
    return axiosService.post(`/record/ex`,record)
  },
  deleteRecord(recordSeq){
    return axiosService.delete(`/record/${recordSeq}`)
  }
}