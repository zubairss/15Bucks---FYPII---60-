import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:fifteenbucks/server_interaction/get_products.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  getProducts(String type) async {
    emit(ProductsLoading());
    print("get Products");
    ProductModel productModel = await Server().getProducts(type);
    if (productModel.products != null) {
      emit(ProductsSuccessState(productModel));
    } else {
      emit(ProductsFailedState());
    }
  }
}
