import 'dart:convert';

import 'package:fifteenbucks/model/product_model.dart';
import 'package:http/http.dart' as http;

class Server {
  Future<ProductModel> getProducts(String endPoint) async {
    http.Response response = await http.get(
        Uri.parse('https://fyp-87.herokuapp.com/getdata/$endPoint'),
        headers: {'Accept': 'Application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode);
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      return ProductModel(success: json.decode(response.body)['success']);
    }
  }

  Future<bool>  sendOrder(Map map)async{
     http.Response response = await http.post( Uri.parse('https://fyp-87.herokuapp.com/order/create/2'),
     body:map,
     headers: {'Accept': 'Application/json'});

     if(response.statusCode == 200){
       print(response.body);
       return  true;
     }else{
       return false;
     }
  }
}
