import 'package:burning_bros/domain/entities/product.dart';

abstract class ListDataRepository{
  Future<List<Product>?> getProducts({required int pageIndex, required int pageSize});
}