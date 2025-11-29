import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:delveria/features/client/resturant/ui/widgets/build_burger_card.dart';
import 'package:delveria/features/client/resturant/ui/widgets/title_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantFilterationScreen extends StatefulWidget {
  final String title;
  final String sortType;
  final bool? edit;
  final List<SortByPriceItem>? sortedPriceItems;

  const RestaurantFilterationScreen({
    super.key,
    required this.title,
    required this.sortType,
    this.edit,
    this.sortedPriceItems,
  });

  @override
  _RestaurantFilterationScreenState createState() =>
      _RestaurantFilterationScreenState();
}

class _RestaurantFilterationScreenState
    extends State<RestaurantFilterationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedItems = List.from(AppLists.burgerItems);
    if (widget.sortType == 'price') {
      sortedItems.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (widget.sortType == 'rating') {
      sortedItems.sort((a, b) => b['rating'].compareTo(a['rating']));
    }

    final hasSortedPriceItems =
        widget.sortedPriceItems != null && widget.sortedPriceItems!.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              SearchRow(showButton: false, showIosArrow: true),
              verticalSpace(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleRichText(
                        title: widget.title,
                        sortType: widget.sortType,
                      ),
                      verticalSpace(20),
                      hasSortedPriceItems
                          ? SizedBox(
                            height: widget.sortedPriceItems!.length * 150.h,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 25.w,
                                    mainAxisSpacing: 15.h,
                                    childAspectRatio: 0.7,
                                  ),
                              itemCount: widget.sortedPriceItems!.length,
                              itemBuilder: (context, index) {
                                final item = widget.sortedPriceItems![index];
                                return buildBurgerCard(
                                  widget.sortType,
                                  context,
                                  item: item,
                                  edit: widget.edit,
                                );
                              },
                            ),
                          )
                          : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Text(
                                "No items found.",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
