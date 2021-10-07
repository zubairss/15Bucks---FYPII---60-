part of 'category_products_cubit.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();
  @override
  List<Object> get props => [];
}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoadingState extends CategoryProductsState {}

class CategoryProductsSuccessState extends CategoryProductsState {
  final ProductModel productModel;
  const CategoryProductsSuccessState(this.productModel);
}

class CategoryProductsFailedState extends CategoryProductsState {}
