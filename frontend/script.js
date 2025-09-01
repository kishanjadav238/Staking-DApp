(async function(){
  const log = (m)=>document.getElementById('log').textContent += m + "\n";
  let signer, contract;
  document.getElementById('connect').onclick = async ()=>{
    await window.ethereum.request({method:"eth_requestAccounts"});
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    signer = provider.getSigner();
    log("Connected: " + await signer.getAddress());
  };
  async function getAbi(){ return fetch('../abi/Staking.json').then(r=>r.json()); }
  async function ensureContract(){
    if(!contract){
      const addr = document.getElementById('addr').value.trim();
      contract = new ethers.Contract(addr, await getAbi(), signer);
    }
  }
  document.getElementById('stake').onclick = async ()=>{
    await ensureContract();
    const tx = await contract.stake({value: ethers.utils.parseEther("0.1")});
    log("Stake tx: " + tx.hash); await tx.wait(); log("Confirmed.");
  };
  document.getElementById('claim').onclick = async ()=>{
    await ensureContract();
    const tx = await contract.claim(); log("Claim tx: " + tx.hash); await tx.wait(); log("Claimed.");
  };
})();
