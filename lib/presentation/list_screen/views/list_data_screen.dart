import 'package:burning_bros/presentation/list_screen/cubit/list_data_cubit.dart';
import 'package:burning_bros/presentation/list_screen/views/list_data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataScreen extends StatelessWidget {
  const ListDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ListDataCubit(),
    child: ListDataForm(),);
  }
}
