<template>
  <div>
    <h1>{{ this.filePath }}</h1>
    <div v-html="prettyHtml" />
  </div>
</template>

<script>
import * as Diff2Html from "diff2html";
import "diff2html/bundles/css/diff2html.min.css";
import axios from "axios";
export default {
  props: {
    filePath: String,
    selectedCommits: {},
  },

  data() {
    return {
      diffs: "",
    };
  },

  async mounted() {
    await this.fetchDiffData();
  },

  computed: {
    prettyHtml() {
      return Diff2Html.html(this.diffs, {
        drawFileList: false,
        matching: "lines",
        outputFormat: "side-by-side",
      });
    },
  },
  methods: {
    async fetchDiffData() {
      try {
        console.log("Commits: ", this.selectedCommits);
        const URL = `http://10.90.136.100:3000/filediff?originalHash=${this.selectedCommits["First Commit"].sha}&updatedHash=${this.selectedCommits["Second Commit"].sha}&filePath=${this.filePath}`;
        console.log("URL: ", URL);
        const response = await axios.get(`${URL}`);
        if (response.status === 200) {
          console.log("Data is: ", response.data);
          this.diffs = response.data.rawDiff;
        }
      } catch (error) {
        console.log("Error fetching data");
      }
    },
  },
};
</script>
