import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:burning_bros/data/model/product.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/repositories/list_screen_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListDataLoadUseCase {
  final ListDataRepository listDataRepository;

  ListDataLoadUseCase({required this.listDataRepository});

  Future<List<Product>?> call({required int skip, required int pageSize, required String search}) async{
    try {
      var data = await listDataRepository.getProducts(skip: skip, pageSize: pageSize,name: search);
      final box = await Hive.openBox<ProductModel>(favoritesBoxName);
      final productModels = data?.map((product) {
        product.isFavorite = box.containsKey(product.id);
        return product;
      }).toList();
      return productModels;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }


}
