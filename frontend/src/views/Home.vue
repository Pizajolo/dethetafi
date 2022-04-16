<template>
  <!-- Send token  -->
  <div class="send-token">
    <!-- Process -->
    <div class="process">
      <h2 style="font-weight: bold;">All Pools</h2>
      <Pool :pool="pool" :tfuel="tFuelPrice"></Pool>
<!--      <Pool :pool="pool"></Pool>-->
    </div>
  </div>
</template>

<script>
// Importing things we need
import { ref } from "@vue/reactivity";
import { useRouter } from "vue-router";
import {ethers} from 'ethers';
import Pool from '../components/Pool.vue';
import axios from "axios";
// Images
import metaMaskGr from "../assets/images/metamask-gr.svg";
import shareGr from "../assets/images/share-gr.svg";
import uploadGr from "../assets/images/upload-gr.svg";

import metaMask from "../assets/images/metamask.svg";
import share from "../assets/images/share.svg";
import upload from "../assets/images/upload.svg";
import Navbar from "@/components/Navbar";
export default {
  name: "SendToken",
  components: { Pool },
  data() {
    return {
      tFuelPrice: 0,
      pool: {
        img: "https://arweave.net/4oWnJ-MzCz87aNWy7kn36Jz5R_l7Vs_FgWkswekU5g0",
        name: "Community/TBILL-TFuel",
        contract: "0xb84d8b22d3d0f38723e9e0805ead0bce982260b9"
      }
    };
  },
  methods: {
  },
  watch: {
  },
  mounted() {
    axios.get(`https://explorer.thetatoken.org:8443/api/price/all`)
        .then(response => {
          let data = response.data.body
          for(let i=0; i<data.length; i++){
            if(data[i]._id === "TFUEL"){
              this.tFuelPrice = data[i].price
            }
          }
        })
  }
};
</script>

<style lang="scss" scoped>
// send-token styles
.send-token {
  // process styles
  min-height: 80vh;
  display: flex;
  justify-content: center;
  align-content: center;
  flex-direction: column;
  margin: 10px;
  position: relative;
  .process {
    max-width: 1000px;
    margin: auto;
    background: #fff;
    border-radius: 10px;
    padding: 20px;
    min-height: 500px;
    width: 100%;
    // process-ul
    .process-ul {
      display: flex;
      align-items: center;
      list-style: none;
      justify-content: space-evenly;
      padding: 25px;
      list-style: none;
      gap: 10px;
      // process-item
      .process-item {
        text-align: center;
        display: block;
        width: 50%;
        .process-title {
          font-weight: bold;
          padding: 10px 0px;
          font-size: 1.2rem;
          color: rgb(173, 169, 169);
        }
        span {
          font-size: 1rem;
          text-transform: capitalize;
          color: #000;
          display: block;
          text-align: center;
        }
        img {
          width: 20%;
        }
      }
      hr {
        width: 100%;
        background: transparent linear-gradient(90deg, #03b3e7 0%, #02e9b5 100%)
        0% 0% no-repeat padding-box;
        height: 3px;
        border: 0px;
      }
    }
  }
  .success-modal {
    display: grid;
    place-items: center;
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    .wraper {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      background: #fff;
      padding: 20px;
      min-width: 250px;
      min-height: 300px;
      max-width: 400px;
      border: 1px solid #000;
      margin: 10px;
      border-radius: 10px;
      .heading,
      .sub-heading {
        text-align: center;
        font-size: 1.5rem;
        font-weight: bold;
        padding: 10px;
      }
      .see-btn {
        background: #30d0a5;
        padding: 10px 20px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: capitalize;
        color: #fff;
        border: 0px;
        border-radius: 15px;
        cursor: pointer;
        margin-top: 40px;
      }
    }
  }
}

.ZoneSpinner {
  text-align: center;
}

.ZoneSpinner .spinner-border {
  width: 5rem;
  height: 5rem;
  color: #18E5E7;
}
.form {
  max-width: 640px;
  margin: auto;
  padding: 0px 10px;
  min-height: 400px;
  // form-control styles
  .form-control {
    min-width: 100%;
    // label styles
    label {
      display: block;
      font-size: 1rem;
      font-weight: bold;
      padding: 5px 10px;
    }

    // select styles
    .select {
      min-width: 100%;
      padding: 6px 10px;
      border: 1px solid #222;
      border-radius: 5px;
      text-transform: uppercase;
      font-weight: bold;
      cursor: pointer;
    }

    // textarea styles
    textarea {
      min-width: 100%;
      padding: 5px 5px;
      border: 1px solid #222;
      border-radius: 5px;
      min-height: 60px;
    }

    // form-groups styles
    .form-groups {
      display: flex;
      justify-content: space-between;
      align-items: center;
      min-width: 100%;
      gap: 20px;

      // success style
      .success {
        min-width: 50%;
        margin-top: 35px;
        color: #30d0a5;
        h2 {
          height: 25px;
        }
      }

      // error style
      .error {
        min-width: 50%;
        margin-top: 35px;
        color: red;
        h2 {
          height: 25px;
        }
      }

      // group-two style
      .group-two {
        min-width: 50%;
        // input styles
        input {
          min-width: 100%;
          padding: 5px 0px;
          border: 1px solid #222;
          border-radius: 5px;
          text-transform: capitalize;
          text-indent: 10px;
        }
        // div styles
        div {
          //min-width: 93%;
          padding: 5px 0px;
          border: 1px solid #222;
          border-radius: 5px;
          min-height: 30px;
        }
      }
    }

    // sub-heading styles
    .sub-heading {
      text-align: center;
      font-size: 1.2rem;
      font-weight: bold;
      padding: 10px;

      a {
        color: #000;
        font-weight: bold;
      }
    }

    // input-message styles
    .input-message {
      padding: 10px;
      border: 1px solid #222;
      border-radius: 5px;
      min-height: 150px;
      width: 100%;
      input {
        //display: none;
      }
    }

    // next-btn styles
    .next-btn {
      background: #30d0a5;
      padding: 5px 40px;
      font-size: 1.2rem;
      font-weight: bold;
      text-transform: capitalize;
      color: #fff;
      margin: 30px 0px;
      border: 0px;
      border-radius: 10px;
      cursor: pointer;
    }

    // table style
    .table-border {
      display: grid;
      overflow-y: auto;
      //place-items: top;
      padding: 0;
      border: 1px solid #222;
      border-radius: 5px;
      height: 200px;
    }

    .token-table {
      border-collapse: collapse;
      margin: 0;
      font-size: 0.9em;
      width: 100%;

      thead tr {
        background-color: #222;
        color: #ffffff;
        text-align: left;
        font-weight: bold;
      }

      th, td {
        padding: 8px 10px;
      }

      tbody {
        overflow-y: scroll;
        max-height: 200px;
      }

      tbody tr {
        border-bottom: 1px solid #dddddd;
      }
      tbody tr:nth-of-type(even) {
        background-color: #f3f3f3;
      }
    }
  }
}

@media only screen and(max-width: 500px) {
  // send-token styles
  .send-token {
    // process styles
    .process {
      .form {
        // form-control styles
        .form-control {
          // form-groups styles
          .form-groups {
            flex-direction: column;
            // group-one style
            .group-one {
              min-width: 100%;
            }

            // group-two style
            .group-two {
              min-width: 100%;
              // input styles
              input {
                width: 100%;
              }
            }
          }
        }
      }
    }
  }
}

@media only screen and(max-width:640px) {
  // send-token styles
  .send-token {
    // process styles
    .process {
      padding: 20px 0px;

      // process-ul
      .process-ul {
        display: flex;
        align-items: center;
        list-style: none;
        justify-content: space-evenly;
        padding: 10px;
        list-style: none;
        // process-item
        .process-item {
          img {
            width: 30px;
          }
        }
      }
    }
  }
}

.active {
  color: #000 !important;
}
</style>
