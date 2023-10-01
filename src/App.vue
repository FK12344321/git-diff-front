<template>
  <div id="app">
    <HeaderDisplay />
    <!-- <HeaderDisplay /> -->
    <RepoURL @repo-url-submitted="handleRepoUrlSubmitted" />
    <BranchMenu
      :selectedRepoUrl="selectedRepoUrl"
      @compareCommits="updateSelectedCommits"
    />
    <GitDiff
      :selectedCommits="selectedCommits"
      :selectedRepoUrl="selectedRepoUrl"
    />
  </div>
</template>

<script>
import GitDiff from "./components/GitDiff.vue";
import RepoURL from "./components/RepoURL.vue";
import HeaderDisplay from "./components/HeaderDispaly.vue";
import BranchMenu from "./components/BranchMenu.vue";
export default {
  name: "App",
  components: {
    RepoURL,
    GitDiff,
    HeaderDisplay,
    BranchMenu,
  },
  data() {
    return {
      selectedRepoUrl: "", // Initialize with an empty string
      selectedCommits: {}, // Initialize with an empty object
    };
  },

  methods: {
    handleRepoUrlSubmitted(repoUrl) {
      this.selectedRepoUrl = repoUrl;
    },
    updateSelectedCommits(commits) {
      this.selectedCommits = commits;
    },
  },
};
</script>

<style>
#app {
  margin: 20px;
}
</style>
