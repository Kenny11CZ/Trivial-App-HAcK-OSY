import 'package:tuple/tuple.dart';

typedef num capacityFun(num discCapacity, num discCount);
typedef Tuple2<num, num> durabilityFun(num discCapacity, num discCount);
typedef num readWriteFun(num busSpeed, num discSpeed, num discCapacity);
typedef num restoreFun(num discCapacity, num discCount, num busSpeed, num discSpeed, num userLoad, num multiplier);
typedef num reliabilityFun(num discCount, num mtfb, num months);

class RaidType {
  RaidType(this.name, this.capacityCalculation, this.durabilityCalculation, this.writeSpeedCalculation,
      this.readSpeedCalculation, this.restoreSpeedCalculation, this.reliabilityCalculation);
  String name;
  capacityFun capacityCalculation;
  durabilityFun durabilityCalculation;
  readWriteFun writeSpeedCalculation;
  readWriteFun readSpeedCalculation;
  restoreFun restoreSpeedCalculation;
  reliabilityFun reliabilityCalculation;
}