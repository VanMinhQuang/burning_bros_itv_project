import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:burning_bros/data/model/product.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListDataFavoriteUseCase{
  const ListDataFavoriteUseCase();

  Future<void> call(Product item) async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    item.isFavorite = !(item.isFavorite ?? false);
    if (box.containsKey(item.id)) {
      await box.delete(item.id);

    } else {
      await box.put(item.id, ProductModel(product: item.id ?? 0,isFavorite: item.isFavorite ?? false));
    }

    await box.close();
  }

  Future<List<ProductModel>> getFavorites() async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    final favorites = box.values.toList();
    await box.close();
    return favorites;
  }
}