import { getCreateBondInput } from '../../utils/businessFixtures';
import { InstrumentType } from '@castframework/models';
import { Env, ScenarioData } from '../types';
import { expect } from 'chai';
import { isoDateToSecond } from '../../../src/ethUtils/typeUtils';
import { expectFroRegistryNotification } from '../helpers/expectEvent';
import { RegistryNotificationName } from '../../../src/shared/env-constant/notificationNames';

export async function createBondStep(
  env: Env,
  scenarioData: ScenarioData<InstrumentType.Bond>,
): Promise<void> {
  scenarioData.instrumentInput = getCreateBondInput(scenarioData.ledger);

  const { transactionHash, instrumentAddress } = await env.froClient.createBond(
    scenarioData.instrumentInput,
  );

  const notifications = await expectFroRegistryNotification(env, {
    transactionHash,
    notificationName: RegistryNotificationName.InstrumentListed,
  });

  if (notifications === null || notifications === undefined) {
    return;
  }

  scenarioData.instrumentAddress = instrumentAddress;
}

export async function validateBondDetailsStep(
  env: Env,
  scenarioData: ScenarioData<InstrumentType.Bond>,
): Promise<void> {
  const instrumentDetails = await env.froClient.getInstrumentDetails(
    scenarioData.instrumentAddress,
    scenarioData.ledger,
  );

  expect(instrumentDetails.issuer.toLowerCase()).to.equal(
    scenarioData.instrumentInput.issuerAddress?.toLowerCase(),
  );
  expect(instrumentDetails.registrarAgentAddress.toLowerCase()).to.equal(
    scenarioData.instrumentInput.registrarAgentAddress?.toLowerCase(),
  );
  expect(instrumentDetails.settlerAgentAddress.toLowerCase()).to.equal(
    scenarioData.instrumentInput.settlerAgentAddress?.toLowerCase(),
  );
  expect(instrumentDetails.initialSupply).to.equal(
    Math.floor(
      (scenarioData.instrumentInput.nominalAmount as number) /
        (scenarioData.instrumentInput.denomination as number),
    ),
  );
  expect(instrumentDetails.isinCode).to.equal(
    scenarioData.instrumentInput.isinCode,
  );
  expect(instrumentDetails.name).to.equal(scenarioData.instrumentInput.symbol);
  expect(instrumentDetails.symbol).to.equal(
    scenarioData.instrumentInput.symbol,
  );
  expect(instrumentDetails.denomination).to.equal(
    scenarioData.instrumentInput.denomination,
  );
  expect(instrumentDetails.divisor).to.equal(
    10 ** (scenarioData.instrumentInput.decimals as number),
  );
  expect(instrumentDetails.startDate).to.equal(
    isoDateToSecond(scenarioData.instrumentInput.startDate as Date),
  );
  expect(instrumentDetails.maturityDate).to.equal(
    isoDateToSecond(scenarioData.instrumentInput.maturityDate as Date),
  );
  expect(instrumentDetails.firstCouponDate).to.equal(
    isoDateToSecond(scenarioData.instrumentInput.firstCouponDate as Date),
  );
  expect(instrumentDetails.couponFrequencyInMonths).to.equal(
    scenarioData.instrumentInput.couponFrequencyInMonths,
  );
  expect(instrumentDetails.interestRateInBips).to.equal(
    scenarioData.instrumentInput.couponRateInBips,
  );
  expect(instrumentDetails.callable).to.equal(
    scenarioData.instrumentInput.isCallable,
  );
  expect(instrumentDetails.isSoftBullet).to.equal(
    scenarioData.instrumentInput.isSoftBullet,
  );
  expect(instrumentDetails.softBulletPeriodInMonths).to.equal(
    scenarioData.instrumentInput.softBulletPeriodInMonths,
  );
}
