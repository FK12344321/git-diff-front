<template>
  <div class="commits-dropdown">
    <label>{{ title }}:</label>
    <select v-model="selectedCommit">
      <option v-for="commit in commits" :key="commit">{{ commit }}</option>
    </select>
    <p>Selected Commit: {{ selectedCommit }}</p>
  </div>
</template>

<script>
import axios from "axios"; // Import Axios for making HTTP requests

export default {
  props: {
    selectedRepoUrl: String, // Define the prop to receive the selectedRepoUrl value
    selectedBranch: String, // Define the prop to receive the selectedBranch value
    title: String, // Define the prop to receive the title value
    commitNumber: Number, // Define the prop to receive the commit number
  },
  data() {
    return {
      commits: [], // Initialize commits as an empty array
      selectedCommit: {}, // Initialize with an empty string
    };
  },
  computed: {
    // Computed property to generate the commits URL
    commitsUrl() {
      if (this.selectedRepoUrl && this.selectedBranch) {
        // Extract the base URL from selectedRepoUrl
        const baseUrl = this.selectedRepoUrl.split("/branches")[0];

        // Construct the commits URL
        return `${baseUrl}/commits?branch=${this.selectedBranch}`;
      }
      return ""; // Return an empty string if either value is missing
    },
  },
  async mounted() {
    // Fetch commits when the component is mounted
    this.fetchCommits();
  },
  watch: {
    commitsUrl(newUrl) {
      // When commitsUrl changes, fetch the commits
      this.fetchCommits(newUrl);
    },
    selectedCommit(newCommit) {
      // Emit the selected commit along with its commitNumber
      this.$emit("commit-selected", JSON.parse(newCommit), this.commitNumber);
    },
  },
  methods: {
    async fetchCommits(url) {
      if (url) {
        try {
          // Fetch the list of commits from the constructed URL
          const response = await axios.get(url);
          if (response.status === 200) {
            this.commits = response.data; // Set the commits data with the fetched data
            console.log(this.commits);
          }
        } catch (error) {
          console.error("Error fetching commits:", error);
        }
      }
    },
  },
};
</script>

<style scoped>
/* Styles remain the same */
</style>
