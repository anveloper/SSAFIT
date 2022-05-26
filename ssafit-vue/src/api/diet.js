import { axiosService } from "@/api";

export default{
  getDietList(memberSeq){
    return axiosService.get(`/diet/${memberSeq}`)
  },
  setNewFood(newFood){
    return axiosService.post(`/diet`,newFood)
  },
  deleteFood(foodSeq){
    return axiosService.delete(`/diet/${foodSeq}`)
  }
}