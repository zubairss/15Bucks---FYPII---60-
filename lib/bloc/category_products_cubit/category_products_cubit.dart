import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:fifteenbucks/server_interaction/get_products.dart';

part 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(CategoryProductsInitial());

  getProducts(String type) async {
    emit(CategoryProductsLoadingState());
    ProductModel productModel = await Server().getProducts(type);
    if (productModel.products != null) {
      emit(CategoryProductsSuccessState(productModel));
    } else {
      emit(CategoryProductsFailedState());
    }
  }
}
