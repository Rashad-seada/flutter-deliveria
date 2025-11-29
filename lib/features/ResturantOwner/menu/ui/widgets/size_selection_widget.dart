import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeSelectionWidget extends StatefulWidget {
  const SizeSelectionWidget({
    super.key,
    this.onSizesChanged,
    this.initialSizes,
  });

  final Function(List<SizeItem>)? onSizesChanged;
  final List<SizeModel>? initialSizes;

  @override
  State<SizeSelectionWidget> createState() => _SizeSelectionWidgetState();
}

class _SizeSelectionWidgetState extends State<SizeSelectionWidget> {
  late List<SizeItem> sizes;

  @override
  void initState() {
    super.initState();

    if (widget.initialSizes != null && widget.initialSizes!.isNotEmpty) {
      sizes =
          widget.initialSizes!
              .map(
                (item) => SizeItem(
                  sizeController: TextEditingController(text: item.size),
                  priceBeforeController: TextEditingController(
                    text: item.priceBefore.toString(),
                  ),
                  priceAfterController: TextEditingController(
                    text: item.priceAfter.toString(),
                  ),
                ),
              )
              .toList();
    } else {
      sizes = [];
    }

    // Add listeners to existing items
    _addListenersToAllItems();

    // Trigger initial callback if we have initial data
    if (sizes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSizesChanged?.call(sizes);
      });
    }
  }

  void _addListenersToAllItems() {
    for (var size in sizes) {
      _addListenersToItem(size);
    }
  }

  void _addListenersToItem(SizeItem size) {
    size.sizeController.addListener(() {
      widget.onSizesChanged?.call(sizes);
    });
    size.priceBeforeController.addListener(() {
      widget.onSizesChanged?.call(sizes);
    });
    size.priceAfterController.addListener(() {
      widget.onSizesChanged?.call(sizes);
    });
  }

  void addSize() {
    setState(() {
      final newSize = SizeItem(
        sizeController: TextEditingController(),
        priceBeforeController: TextEditingController(),
        priceAfterController: TextEditingController(),
      );
      _addListenersToItem(newSize);
      sizes.add(newSize);
    });
    widget.onSizesChanged?.call(sizes);
  }

  void removeSize(int index) {
    if (sizes.isNotEmpty) {
      setState(() {
        sizes[index].sizeController.dispose();
        sizes[index].priceBeforeController.dispose();
        sizes[index].priceAfterController.dispose();
        sizes.removeAt(index);
      });
      widget.onSizesChanged?.call(sizes);
    }
  }

  List<SizeItem> get currentSizes => sizes;

  @override
  void dispose() {
    for (var size in sizes) {
      size.sizeController.dispose();
      size.priceBeforeController.dispose();
      size.priceAfterController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(AppStrings.sizes.tr(), style: TextStyles.bimini16W700),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: addSize,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 16.sp),
              ),
            ),
          ],
        ),
        if (sizes.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ...sizes.asMap().entries.map((entry) {
            int index = entry.key;
            SizeItem size = entry.value;

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: size.sizeController,
                          decoration: InputDecoration(
                            hintStyle: TextStyles.bimini13W400Grey,
                            hintText: "e.g., Small, Medium, Large",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryDeafult,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (sizes.length > 1) ...[
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () => removeSize(index),
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDeafult,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: size.priceBeforeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Original price",
                            hintStyle: TextStyles.bimini13W400Grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryDeafult,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextFormField(
                          controller: size.priceAfterController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyles.bimini13W400Grey,
                            hintText: "Discounted price",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.stepsGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryDeafult,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

class SizeItem {
  final TextEditingController sizeController;
  final TextEditingController priceBeforeController;
  final TextEditingController priceAfterController;

  SizeItem({
    required this.sizeController,
    required this.priceBeforeController,
    required this.priceAfterController,
  });
}
