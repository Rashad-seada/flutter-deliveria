import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatedRestaurantCard extends StatelessWidget {
  final dynamic restaurant;
  const RatedRestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            SizedBox(
              width: 162.w,
              height: 137.h,
              child: CachedNetworkImage(
            imageUrl:     restaurant.photo != null
                    ? restaurant.photo.toString().startsWith('http')
                        ? restaurant.photo
                        : "${ApiConstants.baseUrl}/${restaurant.photo ?? ''}"
                    : '',
                width: 162,
                height: 137.h,
                fit: BoxFit.cover,
                errorWidget:
                    (context, error, stackTrace) =>
                        Image.asset('assets/images/burger.png'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.superCategory?.nameEn ?? "",
                        style: TextStyles.bimini16W400Body.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_border,
                            color: Colors.deepOrange,
                            size: 20.sp,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            (restaurant.rate != null)
                                ? restaurant.rate.toString().isNotEmpty
                                    ? restaurant.rate.toString().substring(0, 1)
                                    : "0"
                                : "0",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(restaurant.name ?? "", style: TextStyles.bimini16W700),
                  const SizedBox(height: 8),
                  Text(
                    restaurant.aboutUs ?? "",
                    style: TextStyles.bimini13W400Grey,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
