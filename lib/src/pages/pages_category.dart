import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'pages-category',
  styleUrls: const ['pages_category.css'],
  templateUrl: 'pages_category.html',
  directives: const [materialDirectives, formDirectives, CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class PagesCategoryComponent {
  @Input()
  PagesCategory category;
}

class PagesCategory {
  PagesCategory(this.id, this.parentId, this.title, this.cls, this.answers);
  PagesCategory.good(this.id, this.title, this.answers) : this.parentId = 'accordion-good', this.cls = 'success';
  PagesCategory.bad(this.id, this.title, this.answers) : this.parentId = 'accordion-bad', this.cls = 'danger';
  String id;
  String parentId;
  String title;
  String cls;
  List<String> answers;
}