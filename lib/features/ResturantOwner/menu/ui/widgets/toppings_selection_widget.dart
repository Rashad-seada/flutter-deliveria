import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToppingsSelectionWidget extends StatefulWidget {
  const ToppingsSelectionWidget({
    super.key,
    this.onToppingsChanged,
    this.initialToppings,
  });

  final Function(List<ToppingItem>)? onToppingsChanged;
  final List<ToppingModel>? initialToppings;

  @override
  State<ToppingsSelectionWidget> createState() =>
      _ToppingsSelectionWidgetState();
}

class _ToppingsSelectionWidgetState extends State<ToppingsSelectionWidget> {
  late List<ToppingItem> toppings;

  @override
  void initState() {
    super.initState();

    if (widget.initialToppings != null && widget.initialToppings!.isNotEmpty) {
      toppings =
          widget.initialToppings!
              .map(
                (item) => ToppingItem(
                  nameController: TextEditingController(
                    text: item.topping?.toString() ?? '',
                  ),
                  priceController: TextEditingController(
                    text: item.price?.toString() ?? '',
                  ),
                ),
              )
              .toList();
    } else {
      toppings = [];
    }

    // Add listeners to existing items
    _addListenersToAllItems();

    // Trigger initial callback if we have initial data
    if (toppings.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onToppingsChanged?.call(toppings);
      });
    }
  }

  void _addListenersToAllItems() {
    for (var topping in toppings) {
      _addListenersToItem(topping);
    }
  }

  void _addListenersToItem(ToppingItem topping) {
    topping.nameController.addListener(() {
      widget.onToppingsChanged?.call(toppings);
    });
    topping.priceController.addListener(() {
      widget.onToppingsChanged?.call(toppings);
    });
  }

  void addTopping() {
    setState(() {
      final newTopping = ToppingItem(
        nameController: TextEditingController(),
        priceController: TextEditingController(),
      );
      _addListenersToItem(newTopping);
      toppings.add(newTopping);
    });
    widget.onToppingsChanged?.call(toppings);
  }

  void removeTopping(int index) {
    setState(() {
      toppings[index].nameController.dispose();
      toppings[index].priceController.dispose();
      toppings.removeAt(index);
    });
    widget.onToppingsChanged?.call(toppings);
  }

  List<ToppingItem> get currentToppings => toppings;

  @override
  void dispose() {
    for (var topping in toppings) {
      topping.nameController.dispose();
      topping.priceController.dispose();
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
            Text(AppStrings.toppings.tr(), style: TextStyles.bimini16W700),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: addTopping,
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
        if (toppings.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ...toppings.asMap().entries.map((entry) {
            int index = entry.key;
            ToppingItem topping = entry.value;

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: topping.nameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.toppingsNameExample.tr(),
                        hintStyle: TextStyles.bimini13W400Grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.stepsGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.stepsGrey),
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
                    flex: 1,
                    child: TextFormField(
                      controller: topping.priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Price",
                        hintStyle: TextStyles.bimini13W400Grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.stepsGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.stepsGrey),
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
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => removeTopping(index),
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDeafult,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
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

class ToppingItem {
  final TextEditingController nameController;
  final TextEditingController priceController;

  ToppingItem({required this.nameController, required this.priceController});
}
