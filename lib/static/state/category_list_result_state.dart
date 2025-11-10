sealed class CategoryListResultState {}

class CategoryListNoneState extends CategoryListResultState {}

class CategoryListLoadingState extends CategoryListResultState {}

class CategoryListErrorState extends CategoryListResultState {
  final String error;

  CategoryListErrorState(this.error);
}

class CategoryListSuccessState extends CategoryListResultState {
  final List<String> data;

  CategoryListSuccessState(this.data);
}
