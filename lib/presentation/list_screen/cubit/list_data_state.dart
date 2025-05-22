import 'package:equatable/equatable.dart';

class ListDataState extends Equatable{
  const ListDataState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListDataEmpty extends ListDataState{}

class ListDataLoadedState extends ListDataState{
  const ListDataLoadedState();
}

class ListDataLoadingState extends ListDataState{
  const ListDataLoadingState();
}

class ListDataUnderLoadingState extends ListDataState{
  const ListDataUnderLoadingState();
}