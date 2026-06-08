import test from "node:test";
import assert from "node:assert/strict";

import {
  beijingLocalToIso,
  campaignStatus,
  isoToBeijingLocal,
  normalizeBillingType,
  rangesOverlap,
  ratioDeviation,
  shouldWarnRatio,
} from "../src/ad-model.js";

test("campaignStatus uses left-closed right-open time ranges", () => {
  const campaign = {
    enabled: true,
    start_at: "2026-06-08T00:00:00.000Z",
    end_at: "2026-06-09T00:00:00.000Z",
    activated_at: "2026-06-07T00:00:00.000Z",
  };

  assert.equal(campaignStatus(campaign, "2026-06-08T00:00:00.000Z"), "running");
  assert.equal(campaignStatus(campaign, "2026-06-09T00:00:00.000Z"), "expired");
});

test("campaignStatus separates draft from disabled", () => {
  assert.equal(campaignStatus({ enabled: false, activated_at: "" }, "2026-06-08T00:00:00.000Z"), "draft");
  assert.equal(campaignStatus({ enabled: false, activated_at: "2026-06-07T00:00:00.000Z" }, "2026-06-08T00:00:00.000Z"), "disabled");
});

test("rangesOverlap allows adjacent campaigns", () => {
  assert.equal(rangesOverlap("2026-06-08T00:00:00.000Z", "2026-06-09T00:00:00.000Z", "2026-06-09T00:00:00.000Z", "2026-06-10T00:00:00.000Z"), false);
  assert.equal(rangesOverlap("2026-06-08T00:00:00.000Z", "2026-06-09T00:00:00.000Z", "2026-06-08T12:00:00.000Z", "2026-06-10T00:00:00.000Z"), true);
});

test("ratioDeviation reports percentage difference from suggested ratio", () => {
  assert.equal(ratioDeviation(1080, 1440, "3:4"), 0);
  assert.equal(shouldWarnRatio(1000, 1000, "3:4"), true);
});

test("Beijing datetime helpers convert without using browser timezone", () => {
  assert.equal(beijingLocalToIso("2026-06-08T10:30"), "2026-06-08T02:30:00.000Z");
  assert.equal(isoToBeijingLocal("2026-06-08T02:30:00.000Z"), "2026-06-08T10:30");
});

test("normalizeBillingType allows yearly billing", () => {
  assert.equal(normalizeBillingType("yearly"), "yearly");
  assert.equal(normalizeBillingType("unknown"), "one_time");
});
