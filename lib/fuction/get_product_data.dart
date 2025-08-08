import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_e_shop/model/product_model.dart';



class GetProduct{
 static const String apiUrl="https://fakestoreapi.in/api/products";

  static Future <ProductModel> fetchProduct()async{
    try{
      
       final response= await http.get(Uri.parse(apiUrl));
       if (response.statusCode==200) {
         final Map<String,dynamic>jsonData=json.decode(response.body);
         print(response.body);
         return ProductModel.fromJson(jsonData);
       }else{
        throw Exception("Failed to load product. Status cpde: ${response.statusCode}");
       }
    }catch(e){
      throw Exception("Error fatching product:$e");
    }
  }
}