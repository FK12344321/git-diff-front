<template>
  <div class="repo-url">
    <h3 class="options">Options</h3>
    <div>
      <b-container fluid>
        <b-row>
          <b-col sm="9">
            <b-form-input
              id="repoUrlInput"
              class="repo-url-input"
              v-model="repoUrl"
              placeholder="Enter the repo URL"
            ></b-form-input>
          </b-col>
          <b-col>
            <b-button
              squared
              variant="outline-primary"
              @click="submitRepoUrl"
              class="load-btn"
              >Load</b-button
            >
          </b-col>
        </b-row>
      </b-container>
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
.load-btn {
  margin-left: 10px;
}

.options {
  margin-left: 13px;
}
</style>
