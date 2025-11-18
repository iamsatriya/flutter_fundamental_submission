enum NavigationRoute {
  main('/main'),
  detail('/detail'),
  search('/search');

  const NavigationRoute(this.name);
  final String name;
}
