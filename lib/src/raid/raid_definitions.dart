import 'dart:math';
import 'package:tuple/tuple.dart';
import 'package:osy/src/raid/raid_type.dart';

final List<RaidType> raidTypeList = [
  raid0,
  raid0Striped,
  raid1,
  raid1e,
  raid5,
  raid6,
];

num reliability(num mtfb, num months) {
  num res = pow(E, -(24 * 365 * months / 12) / mtfb);
  return res;
}

int factorial(int n, [int stop = 0]) {
  if(n == stop) {
    return 1;
  }
  return n * factorial(n - 1, stop);
}

num combinatoryNumber(num n, num k) {
  return factorial(n, n-k) / factorial(k);
}

capacityFun fullCapacity = (num capacity, num count) => capacity * count;
capacityFun halfCapacity = (num capacity, num count) => (capacity * count / 2).floor();
capacityFun thirdCapacity = (num capacity, num count) => (capacity * count / 3).floor();

durabilityFun zeroDurability = (num capacity, num count) => new Tuple2<num, num>(0, 0);

readWriteFun lowerOfTwoRW =
    (num busSpeed, num discSpeed, num discCapacity) => discSpeed < busSpeed ? discSpeed : busSpeed;

restoreFun zeroRestore =
    (num discCapacity, num discCount, num busSpeed, num discSpeed, num userLoad, num multiplier) => 0;
restoreFun restoreSpeedRaid1 =
    (num discCapacity, num discCount, num busSpeed, num discSpeed, num userLoad, num multiplier) {
  num actualDiscSpeed = discSpeed - userLoad;
  num totalSpeed = actualDiscSpeed * 2;
  totalSpeed = totalSpeed > busSpeed ? busSpeed : totalSpeed;
  num res = discCapacity * 2 * multiplier / totalSpeed;
  return res.isFinite ? res.ceil() : 0;
};
restoreFun restoreSpeedRaid5 =
    (num discCapacity, num discCount, num busSpeed, num discSpeed, num userLoad, num multiplier) {
  num totalSpeed = (busSpeed - discCount * userLoad) / discCount;
  totalSpeed = totalSpeed > discSpeed ? discSpeed : totalSpeed;
  num res = discCapacity * multiplier / totalSpeed;
  return res.isFinite ? res.ceil() : 0;
};
restoreFun restoreSpeedRaid6 =
    (num discCapacity, num discCount, num busSpeed, num discSpeed, num userLoad, num multiplier) {
  num totalSpeed = (busSpeed - discCount * userLoad) / (discCount - 1);
  totalSpeed = totalSpeed > discSpeed ? discSpeed : totalSpeed;
  num res = discCapacity * multiplier / totalSpeed;
  return res.isFinite ? res.ceil() : 0;
};

final RaidType raid0 = new RaidType(
  'Raid 0 JBOD',
  fullCapacity,
  zeroDurability,
  lowerOfTwoRW,
  lowerOfTwoRW,
  zeroRestore,
  (num discCount, num mtfb, num months) => pow(reliability(mtfb, months), discCount),
);
final RaidType raid0Striped = new RaidType(
  'Raid 0 Striped',
  fullCapacity,
  zeroDurability,
  (num busSpeed, num discSpeed, num discCount) => discSpeed * discCount < busSpeed ? discSpeed * discCount : busSpeed,
  (num busSpeed, num discSpeed, num discCount) => discSpeed * discCount < busSpeed ? discSpeed * discCount : busSpeed,
  zeroRestore,
  (num discCount, num mtfb, num months) => pow(reliability(mtfb, months), discCount),
);

final RaidType raid1 = new RaidType(
  'Raid 1',
  halfCapacity,
  (num capacity, num count) => new Tuple2<num, num>(1, (count / 2).floor()),
  lowerOfTwoRW,
  (num busSpeed, num discSpeed, num discCount) => discSpeed * 2 < busSpeed ? discSpeed * 2 : busSpeed,
  restoreSpeedRaid1,
  (num discCount, num mtfb, num months) {
    num pairFail = pow((1 - reliability(mtfb, months)), 2);
    num pairOk = 1 - pairFail;
    return pow(pairOk, discCount / 2);
  },
);

final RaidType raid1e = new RaidType(
  'Raid 1e (3 mirrored)',
  thirdCapacity,
  (num capacity, num count) => new Tuple2<num, num>(2, (count / 3 * 2).floor()),
  (num busSpeed, num discSpeed, num discCount) => discSpeed * 3 < busSpeed ? discSpeed : busSpeed / 3,
  (num busSpeed, num discSpeed, num discCount) => discSpeed * 3 < busSpeed ? discSpeed * 3 : busSpeed,
  restoreSpeedRaid1,
  (num discCount, num mtfb, num months) {
    num tripletFail = pow((1 - reliability(mtfb, months)), 3);
    num tripletOk = 1 - tripletFail;
    return pow(tripletOk, discCount / 3);
  },
);

final RaidType raid5 = new RaidType(
  'Raid 5',
  (num capacity, num count) => capacity * (count - 1),
  (num capacity, num count) => new Tuple2<num, num>(1, 1),
  (num busSpeed, num discSpeed, num discCount) =>
      discSpeed * (discCount - 1) < busSpeed ? discSpeed * (discCount - 1) : busSpeed,
  (num busSpeed, num discSpeed, num discCount) =>
      discSpeed * (discCount - 1) < busSpeed ? discSpeed * (discCount - 1) : busSpeed,
  restoreSpeedRaid5,
  (num discCount, num mtfb, num months) {
    num nOk = pow(reliability(mtfb, months), discCount);
    num nMinusOneOk = combinatoryNumber(discCount, 1) *
        pow(reliability(mtfb, months), discCount - 1) *
        (1 - reliability(mtfb, months));
    return nOk + nMinusOneOk;
  },
);

final RaidType raid6 = new RaidType(
  'Raid 6',
  (num capacity, num count) => capacity * (count - 2),
  (num capacity, num count) => new Tuple2<num, num>(2, 2),
  (num busSpeed, num discSpeed, num discCount) =>
      discSpeed * (discCount - 1) < busSpeed ? discSpeed * (discCount - 2) : busSpeed,
  (num busSpeed, num discSpeed, num discCount) =>
      discSpeed * (discCount - 1) < busSpeed ? discSpeed * (discCount - 2) : busSpeed,
  restoreSpeedRaid6,
  (num discCount, num mtfb, num months) {
    num nOk = pow(reliability(mtfb, months), discCount);
    num nMinusOneOk = combinatoryNumber(discCount, 1) *
        pow(reliability(mtfb, months), discCount - 1) *
        (1 - reliability(mtfb, months));
    num nMinusTwoOk = combinatoryNumber(discCount, 2) *
        pow(reliability(mtfb, months), discCount - 2) *
        pow((1 - reliability(mtfb, months)), 2);
    return nOk + nMinusOneOk + nMinusTwoOk;
  },
);
