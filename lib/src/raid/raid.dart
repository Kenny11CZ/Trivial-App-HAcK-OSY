import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:osy/src/raid/raid_type.dart';
import 'package:osy/src/raid/raid_definitions.dart';

@Component(
  selector: 'raid',
  templateUrl: 'raid.html',
  directives: const [materialDirectives, formDirectives, CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class RaidComponent {
  final List<RaidType> raidTypes = raidTypeList;
  final List<num> multipliers = [1, pow(1000, 1), pow(1000, 2), pow(1000, 3), pow(1024, 1), pow(1024, 2), pow(1024, 3)];
  RaidType selectedRaidType = raid0;

  num discCapacity = 0, discCount = 0, busSpeed = 0, discSpeed = 0, userLoad = 0, multiplier = 1, mtfb = 0, months = 0;
  num capacity = 0, writeSpeed = 0, readSpeed = 0, restoreTime = 0, reliability = 0;
  String durability = '0';

  void calculate() {
    RaidType r = selectedRaidType;
    capacity = r.capacityCalculation(discCapacity, discCount);
    var dur = r.durabilityCalculation(discCapacity, discCount);
    durability = '${dur.item1} (${dur.item2})';
    writeSpeed = r.writeSpeedCalculation(busSpeed, discSpeed, discCount);
    readSpeed = r.readSpeedCalculation(busSpeed, discSpeed, discCount);
    restoreTime = r.restoreSpeedCalculation(discCapacity, discCount, busSpeed, discSpeed, userLoad, multiplier);
    reliability = r.reliabilityCalculation(discCount, mtfb, months);
  }
}




