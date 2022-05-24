import { axiosService } from "@/api";

export default{
  getExcerciseList(){
    return axiosService.get(`/ex/`)
  }
}