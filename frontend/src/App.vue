<template>
  <!-- Container  -->
  <div class="container">
    <!-- Navbar  -->
    <Navbar/>
    <!-- View  -->
    <Home/>
  </div>
  <!-- Container  -->
</template>

<script>
// Importing thing we need
import { ref, watch } from "vue";
import { useRoute } from "vue-router";
// Components
import Navbar from "./components/Navbar.vue";
import Home from "./views/Home.vue";

export default {
  name: "App",
  components: { Navbar, Home },
};
</script>

<style lang="scss">
// Importing font family
@font-face {
  font-family: InterFace;
  src: url("./assets/fonts/InterFace-Regular.woff");
  font-weight: normal;
  font-style: normal;
  font-display: fallback;
}
// Importing font family
@font-face {
  font-family: InterFace;
  src: url("./assets/fonts/InterFace-Bold.woff2");
  font-weight: bold;
  font-style: normal;
  font-display: fallback;
}

* {
  // Changing default styles
  padding: 0;
  margin: 0;
  box-sizing: border-box;
  font-family: InterFace;
  font-weight: normal;
}
// body styles
body {
  background: #000;
}
// container styles
.container {
  min-height: 100vh;
}
</style>
