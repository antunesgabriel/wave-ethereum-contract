const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("Hello World!");
    await waveTxn.wait();

    await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave("Another world");
    await waveTxn.wait();

    waveTxn = await waveContract.connect(randomPerson).wave("Another world");
    await waveTxn.wait();

    await waveContract.getTotalWaves();

    const addressWaves = await waveContract.getStats(randomPerson.address);

    console.log("address: %s -> %d", randomPerson.address, addressWaves)

    const wavesData = await waveContract.getAllWaves()

    console.log("waves ->", wavesData)
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();