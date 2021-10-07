import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteenbucks/bloc/category_products_cubit/category_products_cubit.dart';
import 'package:fifteenbucks/bloc/products_cubit/products_cubit.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/product_review.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final String type;
  const ProductsScreen({Key? key, required this.type}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CategoryProductsCubit()..getProducts(widget.type),
      child: BlocConsumer<CategoryProductsCubit, CategoryProductsState>(
        listener: (context, state) {
          if (state is ProductsFailedState) {
            showSnackBarFailed(context, 'Server error');
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CategoryProductsSuccessState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Products',
                  style: TextStyle(),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    child: Expanded(
                      child: GridView.builder(
                        itemCount: state.productModel.products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 1.0,
                                crossAxisSpacing: 5.0,
                                childAspectRatio: .6),
                        itemBuilder: (context, index) {
                          print(
                              '${state.productModel.products![0].productImage}');
                          return InkWell(
                            onTap: () {
                              screenPush(
                                  context,
                                  ProductViewScreen(
                                    image:
                                        'https:${state.productModel.products![index].productImage.toString()}',
                                    price: state.productModel.products![index]
                                        .productPrice
                                        .toString(),
                                    name: state.productModel.products![index]
                                        .productName
                                        .toString(),
                                    productUrl: state.productModel
                                        .products![index].productUrl
                                        .toString(),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.6,
                                    height: size.height * 0.26,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https:${state.productModel.products![index].productImage.toString()}'),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Text(
                                    '${state.productModel.products![index].productName}',
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Price: ',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${state.productModel.products![index].productPrice}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Scaffold(body: Center(child: Text('Server error')));
          }
        },
      ),
    );
  }
}
