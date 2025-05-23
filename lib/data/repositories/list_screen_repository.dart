import 'dart:convert';
import 'dart:io';

import 'package:burning_bros/core/service/service.dart';
import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/repositories/list_screen_repository.dart';
import 'package:http/http.dart' as http;

class ListDataRepositoryImplement extends Service implements ListDataRepository{
  @override
  Future<List<Product>?> getProducts({required int pageIndex, required int pageSize}) async {
      var urlString = '$api_url/products?limit=$pageSize&skip=$pageIndex';
      var url = Uri.parse(urlString);

      var createRequestHeader = await createHeaderAuthorization();
    try{
      var response = await http.get(url,headers: createRequestHeader).timeout(Duration(seconds: Service.serviceTimeOut));
      var responseRaw = responseBody(response);
      var product = (jsonDecode(responseRaw) as List).map((e) => Product.fromJson(e),).toList();
      return product;
    }catch(e){
      rethrow;
    }

  }

}