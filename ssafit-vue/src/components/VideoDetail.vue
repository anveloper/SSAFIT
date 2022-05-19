<template>
  <div class="container">
    <h2>{{video.videoTitle}}</h2>
    <b-embed
      type="iframe"
      aspect="16by9"
      :src="`https://www.youtube.com/embed/${video.youtubeId}`"
      allowfullscreen
    ></b-embed>
    <b-input-group prepend="Username" class="mt-3">
    <b-form-input v-model="comment" placeholder="댓글 추가..."></b-form-input>
    <b-input-group-append>
      <b-button variant="info">댓글 등록</b-button>
    </b-input-group-append>
    </b-input-group>   
    <b-table
      id="my-table"
      :items="reply"
      small
      stacked 
    ></b-table>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
  data(){
    return{
      items: [{
        "userId" : '김우원',
        "comment" : '댓글'
      },
      {
        "userId" : '김우원',
        "comment" : '댓글'
    }
    ]
    }
  },
  computed: {
    ...mapState(['video','reply']),
  },
  created(){
    const pathName = new URL(document.location).pathname.split("/");
    const id = pathName[pathName.length-1];
    this.$store.dispatch("getVideo",id);
    this.$store.dispatch("getReply",id);
  },
  methods:{
    //댓글 추가 기능
    //댓글 삭제 기능
  }
}
</script>

<style>

</style>