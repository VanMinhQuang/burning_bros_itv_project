import 'dart:async';

import 'package:burning_bros/core/styles/color.dart';
import 'package:burning_bros/core/styles/text_style.dart';
import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:burning_bros/data/model/product.dart';
import 'package:burning_bros/domain/entities/product.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_cubit.dart';
import 'package:burning_bros/presentation/list_screen/cubit/list_data_state.dart';
import 'package:burning_bros/presentation/widgets/bar/main_app_bar.dart';
import 'package:burning_bros/presentation/widgets/components/custom_box_search.dart';
import 'package:burning_bros/presentation/widgets/dialog/alert_dialog.dart';
import 'package:burning_bros/presentation/widgets/mixin/base_mixin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController searchController =
      TextEditingController(text: '');
  bool isBottomLoader = false;
  bool reachMax = false;
  bool? isLoading = true;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMealAppBar(),
      body: BlocListener<ListDataCubit, ListDataState>(
        listener: (context, state) {
          if (state is ListDataLoadingState) {
            isLoading = true;
            showProgressDialog(message: '');
          } else if (state is ListDataLoadedState) {
            _hideDialog();
            if (state.data.isEmpty || state.data.length < pageSize) {
              reachMax = true;
            }
            if (skip == 0) {
              _lstProduct = state.data;
            } else {
              _lstProduct.addAll(state.data);
            }
          } else if (state is ListDataUnderLoadingState) {
            isBottomLoader = true;
          } else if (state is ListDataErrorState) {
            _hideDialog();
            CustomDialog.showErrorAlert(
                context: context, content: 'Error occured');
          }
        },
        child: BlocBuilder<ListDataCubit, ListDataState>(
            builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: CustomSearchBox(
                  controller: searchController,
                  hintText: 'Enter your item here',
                  onChange: (text) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      _searchEvent(search: text);
                    });
                  },
                  onClear: (text) => _searchEvent(search: ''),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  edgeOffset: 0,
                  displacement: 50,
                  strokeWidth: 5,
                  color: mainColor,
                  onRefresh: _refreshHandle,
                  child: Skeletonizer(
                    enabled: isLoading ?? false,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: isBottomLoader
                          ? _lstProduct.length + 1
                          : _lstProduct.length,
                      itemBuilder: (context, index) {
                        if (index >= _lstProduct.length) {
                          // This is the loader item
                          return isBottomLoader
                              ? BotLoader()
                              : const SizedBox(height: 1);
                        }

                        final item = _lstProduct[index];
                        return (index >= _lstProduct.length
                            ? (isBottomLoader
                                ? BotLoader()
                                : const SizedBox(height: 1))
                            : productListItem(item: item));
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  void _hideDialog() {
    isLoading = false;
    hideProgressDialog();
    isBottomLoader = false;
  }

  void _searchEvent({required String search}) {
    skip = 0;
    reachMax = false;
    context
        .read<ListDataCubit>()
        .getProduct(skip: skip, pageSize: pageSize, search: search);
  }

  Widget productListItem({required Product item}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 40, 12),
            // extra right padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70.sp,
                  height: 70.sp,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: item.thumbnail ?? '',
                          width: 70.sp,
                          height: 70.sp,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => defaultImage,
                          placeholder: (context, url) => defaultImage,
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                item.rating?.toStringAsFixed(1) ??
                                    '0.0',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 4),
                      item.tags != null
                          ? Wrap(
                              children: item.tags!
                                  .map(
                                    (e) => _buildTag(e),
                                  )
                                  .toList(),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            (item.discountPercentage != 0)
                                ? '\$${_calculateNewPrice(item.price ?? 0, item.discountPercentage ?? 0).toStringAsFixed(2)}'
                                : '\$${(item.price ?? 0.0).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          if (item.discountPercentage != 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '\$${(item.price ?? 0.0).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocSelector<ListDataCubit, ListDataState, bool>(
              selector: (state) => state is ListDataFavoriteState,
              builder: (context, state) => Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => context.read<ListDataCubit>().addFavorite(item: item),
                        icon: Icon(
                          (item.isFavorite ?? false) ? Icons.favorite : Icons.favorite_border,
                          color: Colors.redAccent,
                          size: 16.sp, // smaller icon
                        ),
                        padding: EdgeInsets.zero, // no default padding
                        constraints: BoxConstraints(), // remove default size constraints
                      ),
                    )

              )),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(tag ?? '',
            style: TextThemeStyle.textBoxCustomSize(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 9.sp,
            )),
      ),
    );
  }

  double _calculateNewPrice(double oldPrice, double percentage) {
    return oldPrice * (1 - percentage / 100);
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
      context.read<ListDataCubit>().getProduct(
          skip: skip, pageSize: pageSize, search: searchController.text);
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
