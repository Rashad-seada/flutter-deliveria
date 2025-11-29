import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/upload_photo_container.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/section_label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadLogoSection extends StatefulWidget {
  const UploadLogoSection({super.key});

  @override
  State<UploadLogoSection> createState() => _UploadLogoSectionState();
}

class _UploadLogoSectionState extends State<UploadLogoSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        final cubit = context.watch<AllresturantsadminCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionLabel(AppStrings.uploadResturantLogo.tr()),
            verticalSpace(10),
            UploadPhotoContainer(
              isLogo: true,
              onTap: () async {
                await cubit.pickLogo();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
