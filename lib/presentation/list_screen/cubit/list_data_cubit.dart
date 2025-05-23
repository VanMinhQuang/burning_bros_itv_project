import 'package:burning_bros/data/model/product.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/use_cases/list_screen/list_screen_favorite_use_case.dart';
import 'package:burning_bros/domain/use_cases/list_screen/list_screen_load_use_case.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataCubit extends Cubit<ListDataState> {
  final ListDataLoadUseCase _listDataLoadUseCase;
  final ListDataFavoriteUseCase _listDataFavoriteUseCase;

  ListDataCubit({
    required ListDataLoadUseCase listDataLoadUseCase,
    required ListDataFavoriteUseCase listDataFavoriteUseCase
  })
      : _listDataLoadUseCase = listDataLoadUseCase,
        _listDataFavoriteUseCase = listDataFavoriteUseCase,
        super(ListDataEmpty());

  Future<List<ProductModel>?> getProduct(
      {required int skip, required int pageSize, String? search}) async {
    try {
      if (skip > 0) {
        emit(ListDataUnderLoadingState());
      } else {
        emit(ListDataLoadingState());
      }

      var data = await _listDataLoadUseCase(
          skip: skip, pageSize: pageSize, search: search ?? '');
      emit(ListDataLoadedState(data: data ?? []));
    } catch (e) {
      emit(ListDataErrorState(error: e.toString()));
    }
  }

  Future<void> addFavorite({required Product item}) async {
    try {
      emit(ListDataEmpty());
      await _listDataFavoriteUseCase.call(item);
      emit(ListDataFavoriteState());
    } catch (e) {
      emit(ListDataErrorState(error: e.toString()));
    }
  }

}