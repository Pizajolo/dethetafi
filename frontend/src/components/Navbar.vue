<template>
  <!-- Header  -->
  <header class="header">
    <!-- Nav  -->
    <nav class="nav">
      <!-- Nav-ul  -->
      <ul class="nav-ul">
        <!-- Nav-item | Logo  -->
        <li class="nav-item">
          <!-- Router-link | a tag  -->
          <h1 class="logo" to="/"> DeThetaFi</h1>
<!--          <h4 class="opentheta">powered by OpenTheta</h4>-->
        </li>
        <!-- Nav-link | Send tokens  -->
        <li>
          <button class="nav-item wallet" type="button" @click="connectButtonClicked()">
            <img src="../assets/images/wallet.svg" alt="icon" />
            <span v-if="address !== ''" style="padding-top: 3px;font-weight: bold;">{{address.slice(0,5)}}...{{address.slice(-3)}}</span>
            <span v-else style="padding-top: 3px;font-weight: bold;">Connect</span>
          </button>
        </li>
      </ul>
    </nav>
  </header>
  <!-- Header  -->
</template>

<script>
// Importing things we need
import { ref, watch } from "vue";
// Image
// import walletImg from "../assets/images/wallet.svg";
import {NETWORK_OPTIONS} from "@/Config";
import eventBus from "@/module/eventBus";

export default {
  name: "Navbar",
  emits: ["setWallet"],
  data() {
    return {
      address: '',
    };
  },
  methods: {
    async connectButtonClicked(){
      try {
        let chainId = await window.ethereum.request({ method: 'eth_chainId' })
        if(chainId !== NETWORK_OPTIONS.chainId) {
          window.ethereum.request({
            method: "wallet_addEthereumChain",
            params: [NETWORK_OPTIONS],
          });
        }
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        // this.$store.commit('SetUserAddress', accounts[0]);
        // let provider = new ethers.providers.Web3Provider(window.ethereum);
        // this.nextStep()
        this.address = accounts[0]
        eventBus.$emit('walletConnected');
      } catch (e) {
        this.metamask = false
        alert("No Metamask installed");
      }
    }
  }
};
</script>

<style lang="scss">
// header styles
.header {
  padding: 30px 20px;
  // nav styles
  .nav {
    // nav-ul styles
    .nav-ul {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      list-style: none;
      color: #fff;
      max-width: 80%;
      margin: auto;
      // nav-item styles
      .nav-item {
        .logo {
          font-size: 3rem;
          text-transform: capitalize;
          font-weight: bold;
          text-decoration: none;
          background: transparent
            linear-gradient(90deg, #03b3e7 0%, #02e9b5 100%) 0% 0% no-repeat
            padding-box;
          color: transparent;
          background-clip: text;
        }
        .opentheta {
          padding-top: -5px;
          background: transparent
          linear-gradient(90deg, #03b3e7 0%, #02e9b5 100%) 0% 0% no-repeat
          padding-box;
          color: transparent;
          background-clip: text;
        }
        // nav-link styles
        .nav-link {
          font-size: 1.2rem;
          font-weight: bold;
          text-decoration: none;
          text-transform: capitalize;
          //background: transparent
          //  linear-gradient(90deg, #30cfd0 0%, #c43ad6 100%) 0% 0% no-repeat
          //  padding-box;
          background: transparent linear-gradient(90deg, #03b3e7 0%, #02e9b5 100%)
          0% 0% no-repeat padding-box;
          color: #fff;
          padding: 12px 40px;
          border-radius: 10px;
        
        }
      }
      .wallet {
        display: flex;
        gap: 10px;
        font-size: 1.2rem;
        font-weight: bold;
        text-decoration: none;
        text-transform: capitalize;
        background: transparent linear-gradient(90deg, #03b3e7 0%, #02e9b5 100%)
          0% 0% no-repeat padding-box;
        color: #fff;
        padding: 12px 30px;
        border-radius: 10px;
        border: 0;
        img {
          width: 30px;
        }
      }
      .wallet:hover {
        cursor: pointer;
        /*background-color: lightslategray;*/
      }
    }
  }
}

// Media queries starting from here
@media only screen and (max-width: 655px) {
  // header styles
  .header {
    // nav styles
    .nav {
      // nav-ul styles
      .nav-ul {
        max-width: 100%;
      }
    }
  }
}

@media only screen and (max-width: 550px) {
  // header styles
  .header {
    // nav styles
    .nav {
      // nav-ul styles
      .nav-ul {
        // nav-item styles
        .nav-item {
          // nav-link styles
          .nav-link {
            display: none;
          }
          .logo {
            font-size: 2rem;
          }
        }
        .wallet {
          padding: 5px 10px;
        }
      }
    }
  }
}
</style>
