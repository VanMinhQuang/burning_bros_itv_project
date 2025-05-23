import 'package:burning_bros/presentation/list_screen/cubit/list_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataCubit extends Cubit<ListDataState>{
  ListDataCubit() : super(ListDataEmpty());

}