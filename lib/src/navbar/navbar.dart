import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'navbar',
  styleUrls: const ['navbar.css'],
  templateUrl: 'navbar.html',
  directives: const [materialDirectives, ROUTER_DIRECTIVES],
  providers: const [materialProviders],
)
class NavbarComponent {
  final String title = 'Trivial App HAcK';
}