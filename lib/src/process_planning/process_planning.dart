import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'process-planning',
  templateUrl: 'process_planning.html',
  directives: const [materialDirectives, formDirectives, CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class ProcessPlanningComponent {
  List<ProcessPlanningRow> rows = []..addAll([
    new ProcessPlanningRow(90, 1, 240, 'P0'),
    new ProcessPlanningRow(60, 3, 900, 'P1'),
    new ProcessPlanningRow(60, 1, 180, 'P2'),
    new ProcessPlanningRow(10, 2, 600, 'P3'),
  ]);
  List<ProcessPlanningRow> rowsCopy;
  num timePerWindow = 20;
  num availableThreads = 4;

  void addRow() {
    rows.add(new ProcessPlanningRow.empty());
  }

  void _initRows() {
    for(var row in rows) {
      row.init();
    }
//    rows.forEach((ProcessPlanningRow row) {
//      row.init();
//    });
    _sortRows();
    rows.forEach((ProcessPlanningRow row) {
      row.printRow();
    });
  }

  void _sortRows() {
    rows.sort((ProcessPlanningRow a, ProcessPlanningRow b) {
      if(a.priority == b.priority) {
        return a.timePerThread.compareTo(b.timePerThread);
      }
      return a.priority.compareTo(b.priority) * -1;
    });
  }

  void calculate() {
    rowsCopy = rows;
    _calculate(0);
    rows = rowsCopy;
  }

  Map<String, dynamic> _subCalculate(num priority, num availThreads) {
    Map<String, dynamic> res = {};
    res['sectorTime'] = 0;
    res['toDel'] = new List<ProcessPlanningRow>();

    priority = priority ?? rows[0].priority;
    availThreads = availThreads ?? availableThreads;

    num threadsInterested = 0;
    num lowestTime = 0;
    for(var row in rows) {
      if(priority == null) {
        priority = row.priority;
        lowestTime = row.timePerThread;
      }
      if(priority == row.priority) {
        threadsInterested += row.threadCount;
      } else {
        break;
      }
    }

    if(threadsInterested >= availThreads) {
      res['sectorTime'] = (lowestTime*threadsInterested)/availThreads;
      res['toDel'].add(rows[0]);
      for(var row in rows) {
        if(priority == row.priority) {
          row.time -= lowestTime*row.threadCount;
        } else {
          break;
        }
      }
    } else {
      for(var row in rows) {
        if(priority == row.priority) {
          res['sectorTime'] = row.timePerThread > res['sectorTime'] ? row.timePerThread : res['sectorTime'];
          res['toDel'].add(row);
        } else {
          break;
        }
      }
      _subCalculate(priority-1, availableThreads-threadsInterested);
    }

    return res;
  }

  void _calculate(num overallTime) {
    if(rows.length == 0) {
      print("all processes ended after $overallTime");
      return;
    }
    _initRows();



    _calculate(overallTime);
  }

  dynamic trackByFn(num index, dynamic val) {
    return index;
  }

}

class ProcessPlanningRow {
  ProcessPlanningRow(this.priority, this.threadCount, this.time, this.name);
  ProcessPlanningRow.empty() : priority = 0, threadCount = 0, time = 0;

  void init() {
    timePerThread = time/threadCount;
  }

  void printRow() {
    print("$priority | $threadCount | $time | $timePerThread");
  }

  num priority;
  num threadCount;
  num time;
  String name;
  num timePerThread;
}