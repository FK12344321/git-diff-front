<template>
  <div class="repo-url">
    <div>
      <div class="mt-2">Value: {{ text }}</div>
      <b-form-input v-model="text" placeholder="Enter the repo URL"></b-form-input>
    </div>
    <label for="repoUrlInput">Repo URL:</label>
    <div class="input-container">
      <input
        type="text"
        id="repoUrlInput"
        class="repo-url-input"
        v-model="repoUrl"
        placeholder="Enter the repository URL"
      />
      <button class="btn-light-green" @click="submitRepoUrl">Submit</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      repoUrl: "", // Initialize with an empty string
    };
  },
  methods: {
    submitRepoUrl() {
      // Emit an event with the repoUrl value
      this.$emit("repo-url-submitted", this.repoUrl);
    },
  },
};
</script>

<style scoped>

</style>
