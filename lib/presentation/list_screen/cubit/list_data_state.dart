import 'package:burning_bros/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ListDataState extends Equatable {
  const ListDataState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListDataEmpty extends ListDataState {}

class ListDataLoadedState extends ListDataState {
  List<Product> data;

  ListDataLoadedState({required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ListDataErrorState extends ListDataState {
  String error;

  ListDataErrorState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class ListDataLoadingState extends ListDataState {
  const ListDataLoadingState();
}

class ListDataUnderLoadingState extends ListDataState {
  const ListDataUnderLoadingState();
}
