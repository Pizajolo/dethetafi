<template>
  <VueCollapsiblePanel class="pool" :expanded="false">
    <template #title>
      <div class="pool-title">
        <div style="display: flex;">
          <img :src="pool.image" alt="">
          <div class="pool-name">
            <h4>{{pool.name}}/TBILL-TFuel</h4>
            <p>TVL: ${{tvl}}</p>
            <!--        <p><span>Bid 1 ETH </span>{{Histo.Date}}</p>-->
          </div>
        </div>
        <div class="pool-name">
          <h4>My Stake</h4>
          <p>${{poolBalance}} ({{Math.round(poolBalance/tvl*10000)/100}}%)</p>
          <!--        <p><span>Bid 1 ETH </span>{{Histo.Date}}</p>-->
        </div>
        <div class="pool-name">
          <h4>Pool stats</h4>
          <a :href="statsLink" target="_blank">tbillstats.io</a>
          <!--        <p><span>Bid 1 ETH </span>{{Histo.Date}}</p>-->
        </div>
        <button class="compound-btn" @click.stop="compound()" :disabled="loadingCompound">
          <h4 v-if="!loadingCompound">Compound</h4>
          <p v-if="!loadingCompound">{{reward}}TBILL Reward</p>
          <pulse-loader :loading="loadingCompound" color="#18E5E7"></pulse-loader>
        </button>
      </div>
    </template>
    <template #content>
      <div style="display: flex">
        <div class="pool-interaction">
          <div class="pool-title">
            <h3>In Wallet:</h3>
            <h3>{{ walletBalanceLP }} LP (${{walletBalance}})</h3>
          </div>
          <div class="pool-title" >
            <input class="amount-input" v-model="amountToApprove" placeholder="0" type="number">
            <button class="max-btn" @click="setMax('approve')">Max</button>
          </div>
          <button v-if="!isApproved" class="btn" @click="approve" :disabled="loadingApprove">
            <span v-if="!loadingApprove">Approve</span>
            <pulse-loader :loading="loadingApprove" color="#18E5E7"></pulse-loader>
          </button>
          <button v-else-if="isApproved" class="btn" @click="deposit">
            <span v-if="!loadingApprove">Deposit</span>
            <pulse-loader :loading="loadingApprove" color="#18E5E7"></pulse-loader>
          </button>
        </div>
        <div class="pool-interaction">
          <div class="pool-title">
            <h3>In Pool:</h3>
            <h3>{{ poolBalanceLP }} LP (${{poolBalance}})</h3>
          </div>
          <div class="pool-title" >
            <input class="amount-input" v-model="amountToWithdraw" placeholder="0" type="number">
            <button class="max-btn" @click="setMax('withdraw')">Max</button>
          </div>
          <button class="btn" @click="withdraw" :disabled="loadingWithdraw">
            <span v-if="!loadingWithdraw">Withdraw</span>
            <pulse-loader :loading="loadingWithdraw" color="#18E5E7"></pulse-loader>
          </button>
        </div>
      </div>
      <div style="display: flex">
        <div class="pool-interaction">
          <div class="pool-title">
            <h3>Info access token:</h3>
          </div>
          <div class="pool-title">
            <h4>Name:</h4>
            <h4>{{accessName}}</h4>
          </div>
          <div class="pool-title">
            <h4>Address:</h4>
            <h5>{{accessToken}}</h5>
          </div>
          <div class="pool-title">
            <h4>Amount needed:</h4>
            <h4>{{accessTokenAmount}}</h4>
          </div>
          <div class="pool-title">
            <h4>Pool TBILL balance:</h4>
            <h4>{{balanceTBILL}}</h4>
          </div>
        </div>
        <div class="pool-interaction">
          <div class="pool-title">
            <h3>Multipliers:</h3>
          </div>
          <div class="pool-title">
            <h4>1.25x:</h4>
            <h4>{{multiplier125}}</h4>
          </div>
          <div class="pool-title">
            <h4>1.5x:</h4>
            <h4>{{multiplier150}}</h4>
          </div>
          <div class="pool-title">
            <h4>2x:</h4>
            <h4>{{multiplier200}}</h4>
          </div>

        </div>
      </div>
    </template>
  </VueCollapsiblePanel>

</template>

<script>
import { VueCollapsiblePanelGroup, VueCollapsiblePanel } from '@dafcoe/vue-collapsible-panel';
import '@dafcoe/vue-collapsible-panel/dist/vue-collapsible-panel.css'
import { PulseLoader } from 'vue-spinner/dist/vue-spinner.min.js'
import {ethers} from 'ethers';
import axios from 'axios';
import API_URL, {ABI_TNT20, WTFUEL_ADDRESS} from "@/Config";
import {ABI_LP_POOL, ABI_TNT721} from "@/Config";
import eventBus from "@/module/eventBus";

export default {
  name: "pool",
  props: ["pool","tfuel"],
  components: {VueCollapsiblePanelGroup, VueCollapsiblePanel, PulseLoader},
  data() {
    return {
      statsLink: '',
      loadingApprove: false,
      loadingWithdraw:false,
      loadingCompound:false,
      addressLP: '',
      userAccount: '',
      tvl: 0,
      reward: 0.0,
      walletBalance: 0.0,
      amountToApprove: null,
      accessToken: "",
      accessTokenAmount: 0,
      multiplier125: 0,
      multiplier150: 0,
      multiplier200: 0,
      accessName: '',
      balanceTBILL: 0,
      valueLPToken: 0,
      walletBalanceLP: 0,
      amountToWithdraw: 0,
      poolBalance:0,
      poolBalanceLP:0,
      isApproved: false
    };
  },
  methods: {
    async compound() {
      this.loadingCompound = true
      let provider = new ethers.providers.Web3Provider(window.ethereum);
      let signer = provider.getSigner()
      const contractPoolObject = new ethers.Contract(
          this.pool.contractAddress,
          ABI_LP_POOL,
          signer
      );
      contractPoolObject.compoundRewarded().catch((error) => {
        this.loadingCompound = false
        console.log(error);
      });
      let topic = ethers.utils.id("Compound(uint256,uint256)");

      let filter = {
        address: this.pool.contractAddress,
        topics: [topic]
      }

      provider.on(filter, () => {
        this.loadingCompound = false
        this.getData()
      });
    },

    setMax(type) {
      if(type === 'approve') {
        this.amountToApprove = this.walletBalanceLP;
      }
      if(type === 'withdraw') {
        this.amountToWithdraw = this.poolBalanceLP;
      }
    },

    async approve() {
      if(this.amountToApprove === 0 || !this.amountToApprove) return;
      this.loadingApprove = true
      let provider = new ethers.providers.Web3Provider(window.ethereum);
      let signer = provider.getSigner()
      const contractLPObject = new ethers.Contract(
          this.addressLP,
          ABI_TNT20,
          signer
      );
      contractLPObject.approve(this.pool.contractAddress, ethers.BigNumber.from(this.amountToApprove*1000000).mul(1000000000000)).catch((error) => {
        this.loadingApprove = false;
        console.log(error);
      });

      let topic = ethers.utils.id("Approval(address,address,uint256)");

      let filter = {
        address: this.addressLP,
        topics: [topic]
      }

      provider.on(filter, () => {
        this.loadingApprove = false;
        this.isApproved = true;
      });
    },

    async deposit() {
      this.loadingApprove = true
      let provider = new ethers.providers.Web3Provider(window.ethereum);
      let signer = provider.getSigner()
      const contractPoolObject = new ethers.Contract(
          this.pool.contractAddress,
          ABI_LP_POOL,
          signer
      );
      contractPoolObject.stake(ethers.BigNumber.from(this.amountToApprove*10000000).mul(100000000000)).catch((error) => {
        this.loadingApprove = false;
        console.log(error);
      });

      let topic = ethers.utils.id("Deposit(uint256,address)");

      let filter = {
        address: this.pool.contractAddress,
        topics: [topic]
      }

      provider.on(filter, () => {
        this.loadingApprove = false;
        this.isApproved = false;
        this.amountToApprove = 0;
        this.getData()
      });
    },

    async withdraw() {
      if(this.amountToWithdraw === 0) return;
      this.loadingWithdraw = true
      let provider = new ethers.providers.Web3Provider(window.ethereum);
      let signer = provider.getSigner()
      const contractPoolObject = new ethers.Contract(
          this.pool.contractAddress,
          ABI_LP_POOL,
          signer
      );
      contractPoolObject.withdraw(ethers.BigNumber.from(this.amountToWithdraw*10000000).mul(100000000000)).catch((error) => {
        this.loadingWithdraw = false
        console.log(error);
      });

      let topic = ethers.utils.id("Withdraw(uint256,address)");

      let filter = {
        address: this.pool.contractAddress,
        topics: [topic]
      }

      provider.on(filter, () => {
        this.loadingWithdraw = false;
        this.amountToWithdraw = 0;
        this.getData()
      });
    },

    async getLPData(token, provider) {
      const contractWTFuelObject = new ethers.Contract(
          WTFUEL_ADDRESS,
          ABI_TNT20,
          provider
      );
      let wTFuelBalance = await contractWTFuelObject.balanceOf(token);
      const contractLPObject = new ethers.Contract(
          token,
          ABI_TNT20,
          provider
      );
      let LPSupply = await contractLPObject.totalSupply();
      this.valueLPToken = ethers.BigNumber.from(wTFuelBalance).mul(2).div(LPSupply).toNumber()*this.tfuel;
      this.tvl = Math.round((await contractLPObject.balanceOf(this.pool.contractAddress)).div(ethers.BigNumber.from("10000000000")).toNumber()/1000000 * this.valueLPToken)/100;
      if(this.userAccount !== '') {
        this.walletBalanceLP = (await contractLPObject.balanceOf(this.userAccount)).div(ethers.BigNumber.from("1000000000000")).toNumber()/1000000
        this.walletBalance = Math.round(this.walletBalanceLP*this.valueLPToken);
      }
      // this.walletBalanceLP = (await contractLPObject.balanceOf(this.$store.userAddres)).div(ethers.BigNumber.from("10000000000")).toNumber()
    },

    async getMultiplierData(multiplier, provider) {
      this.multiplier125 = 0;
      this.multiplier150 = 0;
      this.multiplier200 = 0;
      const contractNFTObject = new ethers.Contract(
          multiplier,
          ABI_TNT721,
          provider
      );
      let balance = await contractNFTObject.balanceOf(this.pool.contractAddress);
      if(balance>0) {
        let promises = [];
        for(let i=0; i<balance;i++) {
          promises.push(contractNFTObject.tokenOfOwnerByIndex(this.pool.contractAddress, i))
        }
        let tokenIds = await Promise.all(promises);
        promises = []
        for(let i=0; i<tokenIds.length;i++) {
          promises.push(contractNFTObject.tokenURI(tokenIds[i]));
        }
        let tokenURIs = await Promise.all(promises);
        promises = []
        for(let i=0; i<tokenURIs.length;i++) {
          if (tokenURIs[i].slice(0,4) === 'ipfs') {
            tokenURIs[i] = 'https://ipfs.io/ipfs/' + tokenURIs[i].substring(7)
          }
          promises.push(axios.get(tokenURIs[i]));
        }
        let metadata = await Promise.all(promises);
        for(let i=0; i<metadata.length;i++) {
          let type = 0
          let amount = 0
          for(let j=0; j<metadata[i].data.attributes.length; j++) {
            if(metadata[i].data.attributes[j].trait_type === "Multiplier" && metadata[i].data.attributes[j].display_type === "boost_percentage") {
              type = metadata[i].data.attributes[j].value;
            }
            if(metadata[i].data.attributes[j].trait_type === "TBILL") {
              amount = metadata[i].data.attributes[j].value;
            }
          }
          switch (type) {
            case 25:
              this.multiplier125 += amount;
              break;
            case 50:
              this.multiplier150 += amount;
              break;
            case 100:
              this.multiplier200 += amount;
              break;
          }
        }
      }
    },

    async getData() {
      // let response = await axios.get(`https://explorer.thetatoken.org:8443/api/account/${this.pool.contract}`);
      // console.log(response.data)
      try{
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        this.userAccount = accounts[0];
      } catch {
        console.log("Couldn't get wallet")
      }

      let provider = new ethers.providers.Web3Provider(window.ethereum);
      const contractPoolObject = new ethers.Contract(
          this.pool.contractAddress,
          ABI_LP_POOL,
          provider
      );
      this.addressLP = await contractPoolObject.LPToken();
      await this.getLPData(this.addressLP, provider);
      let multiplier = await contractPoolObject.MultiplierNFT();
      this.getMultiplierData(multiplier, provider);

      if(this.userAccount !== '') {
        this.poolBalanceLP = (await contractPoolObject.balanceOfLP(this.userAccount)).div(ethers.BigNumber.from("1000000000000")).toNumber()/1000000
        this.poolBalance = Math.round(this.poolBalanceLP*this.valueLPToken*100)/100;
      }

      this.accessToken  = await contractPoolObject.accessToken();
      this.accessTokenAmount  = await contractPoolObject.accessTokenAmount();
      this.balanceTBILL  = Math.round((ethers.BigNumber.from(await contractPoolObject.getTBillBalance()).div(ethers.BigNumber.from("1000000"))).toNumber()/10)/100;
      this.reward = Math.round((ethers.BigNumber.from(await contractPoolObject.getCompoundReward()).div(ethers.BigNumber.from("10000000"))).toNumber())/100;

      const contractNFTObject = new ethers.Contract(
          this.accessToken,
          ABI_TNT721,
          provider
      );
      this.accessName  = await contractNFTObject.name();
      // let data = await axios.post("https://tbillstats.io/api/getNFTforWallet/",{walletAddress: this.pool.contractAddress});
      // console.log(data.data)
    }
  },
  mounted() {
    this.statsLink = "https://tbillstats.io/MyWallet?wallet="+this.pool.contractAddress;
    this.getData()
  },
  created() {
    eventBus.$on("walletConnected", () => {
      this.getData();
    });
  }
}
</script>

<style scoped>
.pool-title {
  width: 100%;
  display: flex;
  justify-content: space-between;
  flex-direction: row;
}
img {
  width: 40px;
  height: 40px;
  border-radius: 100%;
}
.pool {
  border: 1px solid #222;
  border-radius: 15px;
  margin: 10px;
}
.pool-name{
  padding-left: 10px;
}
.compound-btn {
  /*padding: 5px 10px;*/
  /*border-radius: 5px;*/
  /*border: 1px solid #222;*/
  padding: 6px 10px;
  background: transparent;
  border-radius: 20px;
  font-style: normal;
  font-weight: bold;
  /*line-height: 32px;*/
  border: 2px solid #18E5E7;
  color: #18E5E7;
  margin-right: 10px;
}
.compound-btn:hover {
  cursor: pointer;
  background: #222;
  border-color: #222;
  color: white;
  /*background-color: lightslategray;*/
}
.pool-interaction  {
  width: 50%;
  /*max-width: 300px;*/
  padding: 10px;
  margin: 10px;
  border: 1px solid #222;
  border-radius: 15px;
}
.amount-input {
  width: 70%;
  padding: 3px;
  border-radius: 5px;
  border: 1px solid #222;
}
.max-btn {
  padding: 3px 5px;
  border-radius: 10px;
  border: 1px solid #888;
  color: #888;
  background: transparent;
}
.max-btn:hover {
  cursor: pointer;
  color: #222;
  border: 1px solid #222;
}
.btn {
  border-radius: 5px;
  background: transparent;
  border: 1px solid #222;
  margin: 10px 5px 5px 0;
  padding: 5px;
  width: 100%;
  max-width: 200px;
}
.btn:hover {
  cursor: pointer;
  background: #222;
  color: white;
}
</style>