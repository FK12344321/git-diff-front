<template>
  <div>
    <b-card
      v-for="file in this.files"
      :key="file"
      @click="handleClick(file)"
      id="file"
      >{{ file }}</b-card
    >
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: {
    files: [],
    selectedCommits: {},
  },

  methods: {
    async handleClick(file) {
      const URL = `http://10.90.136.100:3000/filediff?originalHash=${this.selectedCommits["First Commit"]}&updatedHash=${this.selectedCommits["Second Commit"]}&filePath=${file}`;
      try {
        const response = await axios.get(`${URL}`);
        if (response.status === 200) {
          this.diff = response.data;
          this.$emit("getDiff", response.data);
        }
      } catch (error) {
        console.log("Error fetching data");
      }
    },
  },
};
</script>

<style scoped>
#file {
  margin-bottom: 10px;
}
</style>
