import 'package:burning_bros/domain/entities/product.dart';
import 'package:hive/hive.dart';

part '../model_adapter/product.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject {
    @HiveField(0)
    int product;

    @HiveField(1)
    bool isFavorite;

    ProductModel({
        required this.product,
        this.isFavorite = false,
    });
}
