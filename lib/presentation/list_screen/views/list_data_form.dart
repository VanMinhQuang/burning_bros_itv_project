import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_cubit.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_state.dart';
import 'package:burning_bros/presentation/widgets/mixin/base_mixin.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/components/bottom_loader.dart';

class ListDataForm extends StatefulWidget {
  const ListDataForm({super.key});

  @override
  State<ListDataForm> createState() => _ListDataFormState();
}

class _ListDataFormState extends State<ListDataForm> with BaseMixin {
  int skip = 0;
  int pageSize = 20;
  List<Product> _lstProduct = [];
  final ScrollController scrollController = ScrollController();
  bool isBottomLoader = false;
  bool reachMax = false;
  bool? isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 0,
      displacement: 50,
      strokeWidth: 5,
      onRefresh: _refreshHandle,
      child: Scaffold(
        body: BlocListener<ListDataCubit, ListDataState>(
          listener: (context, state) {
            if(state is ListDataLoadingState){
              isLoading = true;
              showProgressDialog(message: '');
            }
            else if (state is ListDataLoadedState) {
              if (state.data.isEmpty || state.data.length < pageSize) {
                reachMax = true;
              }
              isLoading = false;
              hideProgressDialog();
              _lstProduct.addAll(state.data);
              isBottomLoader = false;
            }
            else if (state is ListDataUnderLoadingState){
              isBottomLoader = true;
            }
          },
          child: BlocBuilder<ListDataCubit, ListDataState>(
              builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Skeletonizer(
                    enabled: isLoading ?? false,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: isBottomLoader ? _lstProduct.length + 1 : _lstProduct.length,
                      itemBuilder: (context, index) {
                        return (index >= _lstProduct.length
                            ? (isBottomLoader
                            ? BotLoader()
                            : const SizedBox(height: 1))
                            : _buildItemList(
                            _lstProduct[index]));
                      },
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildItemList(Product item){
    return ListTile(
        title: Text(item.title ?? ''));
  }

  Future<Null> _refreshHandle() async {
    pageSize = 20;
    skip = 0;
    _lstProduct = [];
    reachMax = false;
    await checkConnect();
  }

  void _handleScroll() {
    var maxScroll = scrollController.position.maxScrollExtent;
    var currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll && !isBottomLoader && !reachMax) {
      skip += pageSize;
      context
          .read<ListDataCubit>()
          .getProduct(skip: skip, pageSize: pageSize);
    }
  }

  @override
  void onConnectedNetwork([bool? isConnect]) {
    if (isConnect ?? false) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
        (timeStamp) {
          context
              .read<ListDataCubit>()
              .getProduct(skip: skip, pageSize: pageSize);
        },
      );
    } else {}
  }
}
