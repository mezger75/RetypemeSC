import { parseEther } from "ethers";
import { ethers, expect, loadFixture } from "./setup";

describe("GamingContract", function () {
  async function deployContract() {
    const GamingContractFactory = await ethers.getContractFactory(
      "GamingContract"
    );
    const [owner, player1, player2] = await ethers.getSigners();

    const game = await GamingContractFactory.deploy();
    await game.waitForDeployment();

    return { game, owner, player1, player2 };
  }

  it("allows to deposit into contract and updates the balance correctly", async function () {
    const { game, owner, player1, player2 } = await loadFixture(deployContract);

    const depositAmount1 = parseEther("0.001");
    const depositAmount2 = parseEther("0.002");
    await game.connect(player1).deposit({ value: depositAmount1 });
    await game.connect(player2).deposit({ value: depositAmount2 });
    await game.connect(player2).deposit({ value: depositAmount2 });

    const player1GameBalance = await game.getBalance(player1);
    const player1GameBalanceInMapping = await game.inGameUserBalances(player1);
    const player2GameBalance = await game.getBalance(player2);
    const player2GameBalanceInMapping = await game.inGameUserBalances(player2);

    expect(player1GameBalance).to.eq(depositAmount1);
    expect(player1GameBalanceInMapping).to.eq(depositAmount1);
    expect(player2GameBalance).to.eq(depositAmount2 + depositAmount2);
    expect(player2GameBalanceInMapping).to.eq(depositAmount2 + depositAmount2);
  });
});
