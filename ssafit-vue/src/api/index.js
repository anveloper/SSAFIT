import axios from 'axios';

const axiosService = axios.create({
  baseURL: process.env.VUE_APP_API_SERVER,
  headers: {
    "Content-Type": "application/json",
    "auth-token": ''
  }
});

export { axiosService }