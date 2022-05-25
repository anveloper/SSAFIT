import { axiosService } from "@/api";

export default{
  getCal(userSeq){
    return axiosService.get(`/food/${userSeq}`)
  },
  setCal(calInfo){
    return axiosService.post(`/food`,calInfo)
  }
}