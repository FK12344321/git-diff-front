<template>
  <div id="app">
    <RepoURL @repo-url-submitted="handleRepoUrlSubmitted" />
    <BranchesDropdown
      :selectedRepoUrl="selectedRepoUrl"
      @branch-selected="handleBranchSelected"
    />
    <!-- First Commit Dropdown -->
    <CommitsDropdown
      :selectedRepoUrl="selectedRepoUrl"
      :selectedBranch="selectedBranch"
      title="First Commit"
      :commitNumber="1"
      @commit-selected="handleCommitSelected"
    />
    <!-- Second Commit Dropdown -->
    <CommitsDropdown
      :selectedRepoUrl="selectedRepoUrl"
      :selectedBranch="selectedBranch"
      title="Second Commit"
      :commitNumber="2"
      @commit-selected="handleCommitSelected"
    />
    <GitDiff
      :selectedCommits="selectedCommits"
      :selectedRepoUrl="selectedRepoUrl"
    />
  </div>
</template>

<script>
import GitDiff from "./components/GitDiff.vue";
import BranchesDropdown from "./components/BranchesDropdown.vue";
import CommitsDropdown from "./components/CommitsDropdown.vue";
import RepoURL from "./components/RepoURL.vue";

export default {
  name: "App",
  components: {
    RepoURL,
    GitDiff,
    BranchesDropdown,
    CommitsDropdown, // Register the CommitsDropdown component
  },
  data() {
    return {
      selectedRepoUrl: "", // Initialize with an empty string
      selectedBranch: "", // Initialize with an empty string
      selectedCommit1: "", // Initialize with an empty string for the first commit
      selectedCommit2: "", // Initialize with an empty string for the second commit
    };
  },
  computed: {
    selectedCommits() {
      // Create an object containing the selected commits
      return {
        "First Commit": this.selectedCommit1,
        "Second Commit": this.selectedCommit2,
      };
    },
  },
  methods: {
    handleRepoUrlSubmitted(repoUrl) {
      // Handle the submitted repoUrl value
      this.selectedRepoUrl = repoUrl;
    },
    handleBranchSelected(branch) {
      // Handle the selected branch from BranchesDropdown
      this.selectedBranch = branch;
    },
    handleCommitSelected(commit, commitNumber) {
      // Handle the selected commit from CommitsDropdown
      if (commitNumber === 1) {
        this.selectedCommit1 = commit;
      } else if (commitNumber === 2) {
        this.selectedCommit2 = commit;
      }
    },
  },
};
</script>

<style>
/* Styles remain the same */
</style>
