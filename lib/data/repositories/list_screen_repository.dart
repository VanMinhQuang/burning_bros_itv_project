import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:burning_bros/core/service/service.dart';
import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/repositories/list_screen_repository.dart';
import 'package:http/http.dart' as http;

class ListDataRepositoryImplement extends Service
    implements ListDataRepository {
  @override
  Future<List<Product>?> getProducts(
      {required int skip, required int pageSize, required String name}) async {
    var urlString =
        '$api_url/products/search?q=$name&limit=$pageSize&skip=$skip';
    var url = Uri.parse(urlString);

    var createRequestHeader = await createHeaderAuthorization();
    try {
      var response = await http
          .get(url, headers: createRequestHeader)
          .timeout(Duration(seconds: Service.serviceTimeOut));
      var responseRaw = responseBody(response);
      var data = jsonDecode(responseRaw)['products'] as List;
      var product = data
          .map(
            (e) => Product.fromJson(e),
          )
          .toList();
      return product;
    } on TimeoutException catch (err) {
      throw 'Request time out';
    } on SocketException catch (err) {
      throw 'No Internet connection';
    } catch (e) {
      rethrow;
    }
  }
}
