import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/domain/use_cases/list_screen/list_screen_load_use_case.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataCubit extends Cubit<ListDataState>{
  final ListDataLoadUseCase _listDataLoadUseCase;
  ListDataCubit({required ListDataLoadUseCase listDataLoadUseCase}) : _listDataLoadUseCase = listDataLoadUseCase, super(ListDataEmpty());

  Future<List<Product>?> getProduct({required int skip, required int pageSize}) async {
      try{
        if(skip > 0){
          emit(ListDataUnderLoadingState());
        }else{
          emit(ListDataLoadingState());
        }

        var data = await _listDataLoadUseCase(skip: skip, pageSize: pageSize);
        emit(ListDataLoadedState(data: data ?? []));
      }catch(e){
        emit(ListDataErrorState(error: e.toString()));
      }
  }
}