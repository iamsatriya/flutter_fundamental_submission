enum NavigationRoute {
  home('/home'),
  detail('/detail'),
  search('/search'),
  favorite('/favorite');

  const NavigationRoute(this.name);
  final String name;
}
