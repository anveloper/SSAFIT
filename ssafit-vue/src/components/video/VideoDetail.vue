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
        @keyup.enter="createReply"
      ></b-form-input>
      <b-input-group-append>
        <b-button variant="info" @click="createReply">댓글 등록</b-button>
      </b-input-group-append>
      <button
        class="btn btn-success ml-2"
        @click="zzimVideo(video.youtubeId)"
        v-if="logonMember.userId"
      >
        찜
      </button>
    </b-input-group>
    <h4 v-else style="padding-top: 10px">댓글을 작성하려면 로그인 하세요!</h4>
    <b-list-group>
      <b-list-group-item
        v-for="(repl, index) in reply"
        :key="repl.replySeq"
        class="flex-column align-items-start"
      >
        <div class="d-flex w-100 justify-content-between">
          <span>
            <span style="font-size: 1rem">{{ repl.writer }}</span>
            <button
              class="btn btn-warning btn-sm ml-2 follow-btn"
              @click="followMember(repl.writer)"
              v-if="
                logonMember.userId != '' && repl.writer != logonMember.userId
              "
            >
              팔로우
            </button>
          </span>
          <b-button-group size="sm" v-if="repl.writer == logonMember.userId">
            <b-button variant="warning" @click="updateReply(index, repl)"
              >수정</b-button
            >
            <b-button variant="danger" @click="deleteReply(repl.replySeq)"
              >삭제</b-button
            >
          </b-button-group>
        </div>
        <b-input-group
          class="mt-3"
          v-if="index == updateComment"
          style="font-family: initial"
        >
          <b-form-input
            v-model="newComment"
            @keyup.enter="update(repl)"
            autofocus
          ></b-form-input>
          <b-input-group-append>
            <b-button variant="info" @click="update(repl)" >등록</b-button>
          </b-input-group-append>
        </b-input-group>
        <p class="mb-1" :id="`repl${index}`" v-else>{{ repl.content }}</p>
        <b-button
          variant="info"
          v-if="logonMember.userId"
          size="sm"
          v-b-toggle="`collapse-${index}`"
          @click="setReComIdx(index)"
          >답글</b-button
        >
        <b-collapse :id="`collapse-${index}`" v-if="index == reCommentIdx">
          <b-card>
            <b-input-group class="mt-3" style="font-family: initial">
              <b-form-input
                :placeholder="`${repl.writer}에게 답글쓰기...`"
                v-model="reComment"
                @keyup.enter="createReReply(repl)"
                autofocus
              ></b-form-input>
              <b-input-group-append>
                <b-button variant="info" @click="createReReply(repl)"
                  >등록</b-button
                >
              </b-input-group-append>
            </b-input-group>
          </b-card>
        </b-collapse>
        <b-list-group>
          <b-list-group-item
            v-for="rerepl in rereply"
            :key="rerepl.replySeq"
            v-show="repl.replySeq == rerepl.reSeq"
          >
            <div class="d-flex w-100 justify-content-between">
              <span>
                <span style="font-size: 0.8rem">{{ rerepl.writer }}</span>
                <button
                  class="btn btn-warning btn-sm ml-2 follow-btn"
                  @click="followMember(rerepl.writer)"
                  v-if="
                    logonMember.userId != '' &&
                    rerepl.writer != logonMember.userId
                  "
                >
                  팔로우
                </button>
              </span>
              <b-button-group
                size="sm"
                v-if="rerepl.writer == logonMember.userId"
              >
                <b-button variant="warning" @click="setRereplyIdx(rerepl)"
                  >수정</b-button
                >
                <b-button variant="danger" @click="deleteReply(rerepl.replySeq)"
                  >삭제</b-button
                >
              </b-button-group>
            </div>

            <div v-if="rereCommentIdx != rerepl.replySeq">{{rerepl.content}}</div>
            <b-input-group
              class="mt-3"
              v-else
              style="font-family: initial"
            >
              <b-form-input
                v-model="newreComment"
                @keyup.enter="updatere(rerepl)"
                autofocus
              ></b-form-input>
              <b-input-group-append>
                <b-button variant="info" @click="updatere(rerepl)"
                  >등록</b-button
                >
              </b-input-group-append>
            </b-input-group>
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
      reComment: "",
      reCommentIdx: "-1",
      updateComment: "-1",
      rereCommentIdx: "-1",
      writer: "",
      youtubeId: "",
      newComment: "",
      newreComment: "",
    };
  },
  computed: {
    ...mapState(["video", "logonMember", "zzimList"]),
    reply() {
      return this.$store.getters.rootReply;
    },
    rereply() {
      return this.$store.getters.reReply;
    },
  },
  created() {
    const pathName = new URL(document.location).pathname.split("/");
    const id = pathName[pathName.length - 1];
    this.$store.dispatch("getVideo", id);
    this.$store.dispatch("getReply", id);
  },
  mounted() {
    this.$store.dispatch("getMember", this.logonMember.userId);
    this.$store.dispatch("getZzim", this.logonMember.userId);
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
    createReReply(repl) {
      let newReply = {
        content: this.reComment,
        writer: this.logonMember.userId,
        youtubeId: this.video.youtubeId,
        reSeq: repl.replySeq,
      };
      if (newReply.content) {
        this.$store.dispatch("createReply", newReply);
        this.comment = "";
      } else {
        alert("내용을 입력하세요");
      }
      this.reComment = "";
      this.reCommentIdx="-1";
    },
    setReComIdx(index) {
      this.reCommentIdx = index;
    },
    setRereplyIdx(repl) {
      this.rereCommentIdx = repl.replySeq;
      this.newreComment = repl.content;
    },
    deleteReply(replySeq) {
      console.log(replySeq);
      if (confirm("정말 삭제하시겠습니까??") == true){
        this.$store.dispatch("deleteReply", replySeq);
      }
    },
    updateReply(index, repl) {
      if (repl.reSeq == 0) {
        this.updateComment = index;
        this.newComment = repl.content;
      }
    },
    update(repl) {
      let newrepl = repl;
      newrepl.content = this.newComment;
      this.$store.dispatch("updateReply", newrepl);
      this.updateComment = "-1";
      this.reComment = "";
    },
    updatere(rerepl) {
      let newrepl = rerepl;
      newrepl.content = this.newreComment;
      this.$store.dispatch("updateReply", newrepl);
      this.rereCommentIdx = "-1";
      this.newreComment = "";
    },
    zzimVideo(youtubeId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("zzimVideo", { userId, youtubeId });
    },
    followMember(followId) {
      let userId = this.logonMember.userId;
      this.$store.dispatch("followMember", { userId, followId });
    },
  },
};
</script>

<style>
.follow-btn {
  padding: 0.01rem 0.03rem !important;
  font-size: 0.7rem !important;
  line-height: 0.7rem !important;
}
</style>