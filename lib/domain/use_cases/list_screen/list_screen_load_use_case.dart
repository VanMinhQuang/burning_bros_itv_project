import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/repositories/list_screen_repository.dart';

class ListDataLoadUseCase {
  final ListDataRepository listDataRepository;

  ListDataLoadUseCase({required this.listDataRepository});

  Future<List<Product>?> call({required int skip, required int pageSize}) async{
    try {
      var data = await listDataRepository.getProducts(skip: skip, pageSize: pageSize);
      return data;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
