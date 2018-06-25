import 'package:osy/src/pages/pages_category.dart';


List<PagesCategory> goodPagesCategories = [
  new PagesCategory.good('general-good', 'Obecné', [
    'Při překladu adresy lze použít rozptylovací funkci k urychlení překladu',
    'Pro různě velké stránky/rámce je velikost offsetu různá',
    'Offset definuje pozici dat uvnitř rámce/stránky',
    'Při překladu adresy hledáme v tabulce řádku, ve které je záznam o dané stránce',
    'Při překladu hledáme číslo rámce, do kterého se stránka nahrála',
    'Při překladu adresy se číslo stránky používá jako index do klasické tabulky stránek',
    'Cache hit ratio TLB se může ZVÝŠIT, pokud systém bude používat pro proces VĚTŠÍ stránky',
    'Současné serverové a desktopové procesory umožňují používat růyně velké stránky pro růyné procesy',
  ]),
  new PagesCategory.good('core-good', 'Jádro systému', [
    'Jádro systému si musí pamatovat jenom jednu tabulku stránek (pouze pokud používá INVERTOVANOU tabulku stránek)',
    'Jádro systému si musí pamatovat alespoň x (počet již běžících procesů uživatele) tabulek stránek (pouze pokud používá KLASICKOU JEDNOÚROVŇOVOU tabulku stránek)',
    'Jádro systému si musí pamatovat pro každý proces právě jednu tabulku (pouze pokud používá KLASICKOU JEDNOÚROVŇOVOU tabulku stránek)',
  ]),
  new PagesCategory.good('classic-good', 'Řádek klasické tabulky obsahuje', [
    'Číslo rámce',
    'Reference bit',
    'Modify bit',
    'Present bit',
  ]),
  new PagesCategory.good('inverted-good', 'Řádek invertované tabulky obsahuje', [
    'Číslo stránky',
    'Číslo procesu',
    'Reference bit',
    'Modify bit',
    'Present bit',
  ]),
  new PagesCategory.good('tlb-good', 'Řádek TLB obsahuje', [
    'Číslo rámce',
    'Číslo stránky',
    'Reference bit',
    'Modify bit',
  ]),
];


List<PagesCategory> badPagesCategories = [
  new PagesCategory.bad('general-bad', 'Obecné', [
    'Cache hit ratio TLB se může ZVÝŠIT, pokud systém bude používat pro proces MENŠÍ stránky',
    'Současné serverové a desktopové procesory umožňují aplikacím za běhu měnít velikost TLB podle potřeby',
  ]),
  new PagesCategory.bad('core-bad', 'Jádro systému', [
    'Nothing here, yet',
  ]),
  new PagesCategory.bad('classic-bad', 'Řádek klasické tabulky obsahuje', [
    'Nothing here, yet',
  ]),
  new PagesCategory.bad('inverted-bad', 'Řádek invertované tabulky obsahuje', [
    'Nothing here, yet',
  ]),
  new PagesCategory.bad('tlb-bad', 'Řádek TLB obsahuje', [
    'Nothing here, yet',
  ]),
];
