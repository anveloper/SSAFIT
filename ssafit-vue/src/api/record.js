import { axiosService } from "@/api";

export default{
  getRecordList(userId){
    return axiosService.get(`/record/${userId}`)
  },
  writeRecord(record){
    return axiosService.post(`/record`,record)
  }
}