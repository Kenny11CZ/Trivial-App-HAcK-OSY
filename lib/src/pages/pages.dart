import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:osy/src/pages/pages_category.dart';
import 'package:osy/src/pages/pages_category_definitions.dart';

num naiveLog2(num n) {
  num res = 0;
  num i = 1;
  while(i < n) {
    i *= 2;
    ++res;
  }
  return res;
}

@Component(
  selector: 'pages',
  styleUrls: const ['pages.css'],
  templateUrl: 'pages.html',
  directives: const [materialDirectives, formDirectives, CORE_DIRECTIVES, PagesCategoryComponent],
  providers: const [materialProviders],
)
class PagesComponent {
  final List<PagesCategory> goodCategories = goodPagesCategories;
  final List<PagesCategory> badCategories = badPagesCategories;


  num pageSize = 0, logAddressSize = 0, physAddressSize = 0;
  num offsetSize = 0, pageNumber = 0, frameNumber = 0;
  String pageNumberInverted = '0', pageNumberClassical = '0';


  void calculate() {
    if(pageSize <= 0) {
      return;
    }
    offsetSize = naiveLog2(pageSize);
    pageNumber = logAddressSize - offsetSize;
    frameNumber = physAddressSize - offsetSize;
    pageNumberInverted = '2^($physAddressSize-$offsetSize)';
    pageNumberClassical = '2^($logAddressSize-$offsetSize)';
  }
}