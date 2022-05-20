<template>
  <div class="container">
    <h2>{{ video.videoTitle }}</h2>
    <b-embed
      type="iframe"
      aspect="16by9"
      :src="`https://www.youtube.com/embed/${video.youtubeId}`"
      allowfullscreen
    ></b-embed>
    <b-input-group
      :prepend="`${logonMember.userId}`"
      class="mt-3"
      v-if="logonMember.userId"
    >
      <b-form-input
        style="font-family: initial"
        v-model="comment"
        placeholder="댓글 추가..."
      ></b-form-input>
      <b-input-group-append>
        <b-button variant="info" @click="createReply">댓글 등록</b-button>
      </b-input-group-append>
    </b-input-group>
    <h4 v-else style = "padding-top: 10px ">댓글을 작성하려면 로그인 하세요!</h4>
    <b-list-group>
      <b-list-group-item
        v-for="(repl,index) in reply"
        :key="repl.replySeq"
        class="flex-column align-items-start"
      >
        <div class="d-flex w-100 justify-content-between">
          <h5 class="mb-1">{{ repl.writer }}</h5>
          <b-button-group size="sm" v-if="repl.writer == logonMember.userId">
            <b-button variant="warning" @click="updateReply(index, repl)">수정</b-button>
            <b-button variant="danger" @click="deleteReply(repl.replySeq)"
              >삭제</b-button
            >
          </b-button-group>
        </div>
        <b-input-group class="mt-3" v-if="index==updateComment" style="font-family: initial">
          <b-form-input :placeholder="`${repl.content}`" v-model="newComment"></b-form-input>
          <b-input-group-append>
            <b-button variant="info" @click="update(repl)">등록</b-button>
          </b-input-group-append>
        </b-input-group>
        <p class="mb-1" :id="`repl${index}`" v-else>{{ repl.content }}</p>
        <b-button variant="info" v-if="logonMember.userId" size="sm"  v-b-toggle="`collapse-${index}`" @click="setReComIdx(index)">답글</b-button>
        <b-collapse :id="`collapse-${index}`" v-if="index==reCommentIdx">
          <b-card>
            <b-input-group class="mt-3" style="font-family: initial">
              <b-form-input :placeholder="`${repl.writer}에게 답글쓰기...`" v-model="reComment"></b-form-input>
              <b-input-group-append>
                <b-button variant="info" @click="createReReply(repl)">등록</b-button>
              </b-input-group-append>
            </b-input-group>
          </b-card>
        </b-collapse>
        <b-list-group>
          <b-list-group-item v-for="rerepl in rereply" :key="rerepl.replySeq"  v-show="repl.replySeq == rerepl.reSeq">
            <h5 style="font-size:0.8rem" class="mb-1">{{ rerepl.writer }}</h5>
            <div>{{rerepl.content}}</div>
          </b-list-group-item>
        </b-list-group>
      </b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      items: [],
      comment: "",
      reComment:"",
      reCommentIdx:"-1",
      writer: "",
      youtubeId: "",
      updateComment: "-1",
      newComment: ""
    };
  },
  computed: {
    ...mapState(["video", "logonMember"]),
    reply () {
      return this.$store.getters.rootReply
    },
    rereply (){
      return this.$store.getters.reReply
    }
  },
  created() {
    const pathName = new URL(document.location).pathname.split("/");
    const id = pathName[pathName.length - 1];
    this.$store.dispatch("getVideo", id);
    this.$store.dispatch("getReply", id);
  },
  methods: {
    createReply() {
      let newReply = {
        content: this.comment,
        writer: this.logonMember.userId,
        youtubeId: this.video.youtubeId,
      };
      if (newReply.content) {
        this.$store.dispatch("createReply", newReply);
        this.comment = "";
      } else {
        alert("내용을 입력하세요");
      }
    },
    createReReply(repl){
      let newReply = {
        content: this.reComment,
        writer: this.logonMember.userId,
        youtubeId: this.video.youtubeId,
        reSeq: repl.replySeq
      };
      if (newReply.content) {
        this.$store.dispatch("createReply", newReply);
        this.comment = "";
      } else {
        alert("내용을 입력하세요");
      }
      this.reComment = ""
    },
    setReComIdx(index){
      this.reCommentIdx = index
    },
    deleteReply(replySeq) {
      console.log(replySeq)
      this.$store.dispatch("deleteReply", replySeq);
    },
    updateReply(index,repl){
      this.updateComment = index
      this.newComment = repl.content
    },
    update(repl){
      let newrepl = repl
      newrepl.content = this.newComment
      this.$store.dispatch("updateReply",newrepl);
      this.updateComment = "-1"
    }
  },
};
</script>

<style>
</style>