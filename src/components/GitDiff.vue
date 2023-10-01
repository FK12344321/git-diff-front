<template>
  <div>
    <!-- Your existing HTML for displaying the diff content -->
    <div v-html="prettyHtml" />
  </div>
</template>

<script>
import axios from "axios"; // Import Axios for making HTTP requests
import * as Diff2Html from "diff2html";
import "diff2html/bundles/css/diff2html.min.css";

export default {
  props: {
    selectedCommits: Object, // Object containing selected commits
    selectedRepoUrl: String, // Define the prop to receive the selectedRepoUrl value
  },
  data() {
    return {
      diffs: "",
    };
  },
  computed: {
    prettyHtml() {
      return Diff2Html.html(this.diffs, {
        drawFileList: true,
        matching: "lines",
        outputFormat: "side-by-side",
      });
    },
  },
  watch: {
    selectedCommits: {
      handler: "generateDiff",
      immediate: true, // Generate diff when the component is created
    },
  },
  methods: {
    generateDiff() {
      const { "First Commit": firstCommit, "Second Commit": secondCommit } =
        this.selectedCommits;

      if (this.selectedRepoUrl && firstCommit && secondCommit) {
        // Extract the sha part from the selected commits
        const firstCommitSha = firstCommit.sha;
        const secondCommitSha = secondCommit.sha;
        // Extract the base URL from selectedRepoUrl
        const baseUrl = this.selectedRepoUrl.split("/branches")[0];

        // Construct the diff URL with the sha values
        const diffUrl = `${baseUrl}/diff?originalHash=${firstCommitSha}&updatedHash=${secondCommitSha}`;

        // Fetch the diff content
        this.fetchDiff(diffUrl);
      }
    },
    async fetchDiff(url) {
      if (url) {
        try {
          // Fetch the diff content from the constructed URL
          const response = await axios.get(url);
          if (response.status === 200) {
            this.diffs = response.data.rawDiff; // Set the diffs data with the fetched data
          }
        } catch (error) {
          console.error("Error fetching diff:", error);
        }
      }
    },
  },
};
</script>
