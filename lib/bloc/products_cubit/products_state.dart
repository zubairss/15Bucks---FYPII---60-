part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];

}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState{}

class ProductsSuccessState extends ProductsState{
 final ProductModel productModel;
  const ProductsSuccessState(this.productModel);
}

class ProductsFailedState extends ProductsState{}


