<template>
  <div id="app">
    <HeaderDisplay />
    <!-- <HeaderDisplay /> -->
    <RepoURL @repo-url-submitted="handleRepoUrlSubmitted" />
    <BranchMenu
      :selectedRepoUrl="selectedRepoUrl"
      @compareCommits="updateSelectedCommits"
      @getFiles="updateFiles"
    />
    <div class="file-container">
      <b-button
        variant="outline-dark"
        :class="visible ? null : 'collapsed'"
        :aria-expanded="visible ? 'true' : 'false'"
        aria-controls="collapse-4"
        @click="visible = !visible"
      >
        {{ visible ? "Hide Files" : "Show Files" }}
      </b-button>
      <b-collapse
        id="collapse-4"
        v-model="visible"
        class="mt-2 collapse-container"
      >
        <FilesList
          :files="this.files"
          :selectedCommits="this.selectedCommits"
          @getDiff="updateDiff"
        />
      </b-collapse>

      <FileDiff
        v-for="file in files"
        :key="file"
        :selectedCommits="this.selectedCommits"
        :filePath="file"
      />
    </div>
  </div>
</template>

<script>
import RepoURL from "./components/RepoURL.vue";
import HeaderDisplay from "./components/HeaderDispaly.vue";
import BranchMenu from "./components/BranchMenu.vue";
import FileDiff from "./components/FileDiff.vue";
import FilesList from "./components/FilesList.vue";
export default {
  name: "App",
  components: {
    RepoURL,
    FileDiff,
    FilesList,
    HeaderDisplay,
    BranchMenu,
  },
  data() {
    return {
      selectedRepoUrl: "", // Initialize with an empty string
      selectedCommits: {}, // Initialize with an empty object
      visible: true,
      files: [],
      diff: "",
    };
  },

  methods: {
    handleRepoUrlSubmitted(repoUrl) {
      this.selectedRepoUrl = repoUrl;
    },
    updateSelectedCommits(commits) {
      this.selectedCommits = commits;
    },
    updateFiles(files) {
      this.files = files;
    },
    updateDiff(diff) {
      this.diff = diff;
    },
  },
};
</script>

<style>
#app {
  margin: 20px;
}

.file-container {
  margin-top: 30px;
  margin-left: 8px;
}
</style>
