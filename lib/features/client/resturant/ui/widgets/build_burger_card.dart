import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/add_icon_container.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBurgerCard(
  String sortType,
  BuildContext context, {
  SortByPriceItem? item,
  bool? edit = false,
  ItemModel? itemsModel,
}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 84.h,

          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: CachedNetworkImage(
            imageUrl:
                itemsModel?.photo?.isNotEmpty == true
                    ? "${ApiConstants.baseUrl}/${itemsModel?.photo}"
                    : "${ApiConstants.baseUrl}/${item?.photo}",
            placeholder: (context, url) => Center(child: CustomLoading()),
            errorWidget: (context, url, error) {
              return Center(child: CustomLoading());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemsModel?.name?.isNotEmpty == true
                    ? itemsModel?.name ?? ""
                    : item?.name ?? "",
                style: TextStyles.bimini16W700,
              ),
              const SizedBox(height: 4),
              Text(
                itemsModel?.description?.isNotEmpty == true
                    ? itemsModel?.description ?? ""
                    : item?.description ?? "",
                style: TextStyles.bimini16W400Body.copyWith(
                  color: AppColors.grey,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sortType == "selling"
                      ? Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.star_border, color: AppColors.primary),
                          Text("5.0", style: TextStyles.bimini16W700),
                        ],
                      )
                      : Text(
                        itemsModel?.sizes?.first.priceAfter
                                    .toString()
                                    .isNotEmpty ==
                                true
                            ? "${itemsModel?.sizes?.first.priceAfter.toString()} L. E "
                            : '${item?.sizes.first.priceAfter} L.E',
                        style: TextStyles.bimini16W700,
                      ),
                  GestureDetector(
                    onTap: () {
                      edit == true
                          ? context.pushNamed(
                            Routes.editItemScreen,
                            arguments: false,
                          )
                          : context.pushNamed(Routes.addItemScreen);
                    },
                    child: AddIconContainer(edit: edit),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ],
    ),
  );
}
