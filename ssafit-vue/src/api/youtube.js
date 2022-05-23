import axios from 'axios';

const baseURL = "https://www.googleapis.com/youtube/v3/search?"
  + "&key=" + process.env.VUE_APP_YOUTUBE_KEY
  + "&part=snippet"
  + "&maxResults=10"
  + "&regionCode=KR&q="

// const axiosService = axios.create({
//   baseURL: "https://www.googleapis.com/youtube/v3/videos?&key=" + process.env.VUE_APP_YOUTUBE_KEY
//     + "& part=snippet&maxResults=10&q=",
//   headers: {
//     "Content-Type": "application/json",
//   }
// });

export default {
  getYoutubeApi(key) {
    let value = encodeURI(key);
    return axios.get(baseURL + value);
  }
}