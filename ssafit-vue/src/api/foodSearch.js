import axios from 'axios';
const baseURL = "http://openapi.foodsafetykorea.go.kr/api/"
+ process.env.VUE_APP_FOOD_KEY
+"/I2790/json/1/5/DESC_KOR="

export default{
  searchFood(key){
    return axios.get(baseURL+key);
  }
}