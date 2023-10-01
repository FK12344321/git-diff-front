<template>
  <div id="menu">
    <b-dropdown
      id="branches-left"
      :text="this.selectedBranchLeft"
      variant="primary"
      class="m-2"
      @click="handleBranch1"
    >
      <b-dropdown-item
        v-for="branch in branches"
        :key="branch"
        @click="handleBranchLeft(branch)"
        >{{ branch }}</b-dropdown-item
      >
    </b-dropdown>

    <b-dropdown
      id="commits-left"
      :text="
        this.selectedCommitLeft == 'Commit'
          ? 'Commit'
          : this.truncateCommitMessage(this.selectedCommitLeft)
      "
      variant="primary"
      class="ml-5 d2"
    >
      <b-dropdown-item
        v-for="commit in commitsLeft"
        :key="commit"
        @click="handleCommitLeft(commit)"
        >{{ this.truncateCommitMessage(commit) }}</b-dropdown-item
      >
    </b-dropdown>

    <b-dropdown
      id="branches-right"
      :text="this.selectedBranchRight"
      variant="primary"
      class="m-2 d3"
    >
      <b-dropdown-item
        v-for="branch in branches"
        :key="branch"
        @click="handleBranchRight(branch)"
        >{{ branch }}</b-dropdown-item
      >
    </b-dropdown>

    <b-dropdown
      id="commits-right"
      right
      :text="
        this.selectedCommitLeft == 'Commit'
          ? 'Commit'
          : this.truncateCommitMessage(this.selectedCommitLeft)
      "
      variant="primary"
      class="ml-5 d2"
    >
      <b-dropdown-item
        v-for="commit in commitsLeft"
        :key="commit"
        @click="handleCommitRight(commit)"
        >{{ this.truncateCommitMessage(commit) }}</b-dropdown-item
      >
    </b-dropdown>

    <b-button variant="outline-success" @click="handleComparison"
      >Compare</b-button
    >
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    selectedRepoUrl: String, // Define the prop to receive the selectedRepoUrl value
  },

  data() {
    return {
      branches: [],
      commitsLeft: [],
      commitsRight: [],
      selectedCommitLeft: "Commit",
      selectedBranchLeft: "Branch 1",
      selectedCommitRight: "Commit",
      selectedBranchRight: "Branch 2",
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
    selectedBranchLeft(newBranch) {
      // Watch for changes in the selected branch and fetch commits
      this.fetchCommits(this.selectedRepoUrl, newBranch, "commitsLeft");
    },
    selectedBranchRight(newBranch) {
      // Watch for changes in the selected branch and fetch commits
      this.fetchCommits(this.selectedRepoUrl, newBranch, "commitsRight");
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

    handleBranchLeft(branch) {
      this.selectedBranchLeft = branch;
    },
    handleCommitLeft(commit) {
      this.selectedCommitLeft = commit;
    },
    handleBranchRight(branch) {
      this.selectedBranchRight = branch;
    },
    handleCommitRight(commit) {
      this.selectedCommitRight = commit;
    },

    async getFiles(firstHash, secondHash) {
      const URL = `http://10.90.136.100:3000/files?originalHash=${firstHash}&updatedHash=${secondHash}`;

      try {
        const response = await axios.get(`${URL}`);
        if (response.status === 200) {
          this.$emit("getFiles", response.data);
        }
      } catch (error) {
        console.log("Error fetching data");
      }
    },

    handleComparison() {
      this.getFiles(this.selectedCommitLeft.sha, this.selectedCommitRight.sha);
      this.$emit("compareCommits", {
        "First Commit": this.selectedCommitLeft,
        "Second Commit": this.selectedCommitRight,
      });
    },

    async fetchCommits(repoUrl, branch, target) {
      if (repoUrl && branch) {
        try {
          const baseUrl = this.selectedRepoUrl.split("/branches")[0];
          const URL = `${baseUrl}/commits?branch=${branch}`;
          // Fetch commits based on repoUrl and branch
          // Adjust the API endpoint and data structure as per your API
          const response = await axios.get(`${URL}`);
          if (response.status === 200) {
            this[target] = response.data;
          }
        } catch (error) {
          console.error(`Error fetching ${target} commits:`, error);
        }
      }
    },
    truncateCommitMessage(commit) {
      return commit.message.slice(0, 20);
    },
  },
};
</script>

<style scoped>
#menu {
  margin-top: 50px;
}

.d2 {
  margin-left: 50px;
  margin-right: 50px;
}
</style>
