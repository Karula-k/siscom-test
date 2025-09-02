abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const items = _Paths.items;
  static const categories = _Paths.categories;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const items = '/items';
  static const categories = '/categories';
}
