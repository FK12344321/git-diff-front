<template>
  <div class="branches-dropdown">
    <label>Branches:</label>
    <select v-model="selectedBranch">
      <option v-for="branch in branches" :key="branch" :value="branch">
        {{ branch }}
      </option>
    </select>
    <p>Selected Repo URL: {{ selectedRepoUrl }}</p>
  </div>
</template>

<script>
import axios from "axios"; // Import Axios for making HTTP requests

export default {
  props: {
    selectedRepoUrl: String, // Define the prop to receive the selectedRepoUrl value
  },
  data() {
    return {
      branches: [], // Initialize branches as an empty array
      selectedBranch: "", // Initialize with an empty string
    };
  },
  async computed() {
    if (this.selectedRepoUrl) {
      try {
        // Fetch the list of branches from the selectedRepoUrl
        const response = await axios.get(this.selectedRepoUrl);
        if (response.status === 200) {
          this.branches = response.data; // Set the branches data with the fetched data
        }
      } catch (error) {
        console.error("Error fetching branches:", error);
      }
    }
  },
  watch: {
    selectedRepoUrl(newRepoUrl) {
      // When selectedRepoUrl changes, re-fetch the branches
      this.fetchBranches(newRepoUrl);
    },
    selectedBranch(newBranch) {
      // When selectedBranch changes, emit an event to notify App.vue
      this.$emit("branch-selected", newBranch);
    },
  },
  methods: {
    async fetchBranches(repoUrl) {
      if (repoUrl) {
        try {
          // Fetch the list of branches from the repoUrl
          const response = await axios.get(repoUrl);
          if (response.status === 200) {
            this.branches = response.data; // Set the branches data with the fetched data
          }
        } catch (error) {
          console.error("Error fetching branches:", error);
        }
      }
    },
  },
};
</script>

<style scoped>
/* Styles remain the same */
</style>
