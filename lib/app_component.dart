import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'package:osy/src/navbar/navbar.dart';

import 'package:osy/src/dashboard/dashboard.dart';
import 'package:osy/src/raid/raid.dart';
import 'package:osy/src/pages/pages.dart';
import 'package:osy/src/disc_speed/disc_speed.dart';
import 'package:osy/src/process_planning/process_planning.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, NavbarComponent, ROUTER_DIRECTIVES],
  providers: const [materialProviders],
)
@RouteConfig(const [
  const Route(path: '/', name: 'Dashboard', component: DashboardComponent, useAsDefault: true),
  const Route(path: '/raid', name: 'Raid', component: RaidComponent),
  const Route(path: '/disc-speed', name: 'DiscSpeed', component: DiscSpeedComponent),
  const Route(path: '/pages', name: 'Pages', component: PagesComponent),
  const Route(path: '/process-planning', name: 'ProcessPlanning', component: ProcessPlanningComponent),
])
class AppComponent {}


