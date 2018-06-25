import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'disc-speed',
  templateUrl: 'disc_speed.html',
  directives: const [materialDirectives, formDirectives, CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class DiscSpeedComponent {
  num dataSize = 0, cylinderCount = 0, headerCount = 0, sectorSize = 0, rpm = 0, averageSectorsPerCylinder = 0, averageHeaderWaitTime = 0, nextCylinderWaitTime = 0;
  num firstCylinder = 0, totalTime = 0, sectorCountForData = 0, cylinderCountForData = 0;

  void calculate() {
    if(sectorSize == 0 || rpm == 0 || averageSectorsPerCylinder == 0) {
      return;
    }
    sectorCountForData = (dataSize/sectorSize).ceil();
    cylinderCountForData = (sectorCountForData / averageSectorsPerCylinder).ceil();
    num cylinderReadTime = 60/rpm * 1000;
    num rotationDelay = cylinderReadTime/2;
    firstCylinder = averageHeaderWaitTime + rotationDelay + cylinderReadTime;
    totalTime = firstCylinder + (cylinderCountForData - 1) * (nextCylinderWaitTime + rotationDelay + cylinderReadTime);
  }
}




