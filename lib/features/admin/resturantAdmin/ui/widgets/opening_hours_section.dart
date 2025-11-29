import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/section_label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpeningHoursSection extends StatefulWidget {
  const OpeningHoursSection({super.key, required this.cubit});
  final AllresturantsadminCubit cubit;

  @override
  State<OpeningHoursSection> createState() => _OpeningHoursSectionState();
}

class _OpeningHoursSectionState extends State<OpeningHoursSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel(AppStrings.openingHours.tr()),
        verticalSpace(26),
        Row(
          children: [
            Text('From', style: TextStyles.bimini16W400Body),
            horizontalSpace(16),
            GestureDetector(
              onTap: () => _selectTime(context, true),
              child: Container(
                width: 128.w,
                height: 32.h,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    _formatTime(widget.cubit.fromTime),
                    textAlign: TextAlign.left,

                    style: TextStyles.bimini13W400Grey,
                  ),
                ),
              ),
            ),
            horizontalSpace(12),
            const Text(
              'to',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            horizontalSpace(12),
            GestureDetector(
              onTap: () => _selectTime(context, false),
              child: Container(
                width: 128.w,
                height: 32.h,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    _formatTime(widget.cubit.toTime),
                    textAlign: TextAlign.left,

                    style: TextStyles.bimini13W400Grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? widget.cubit.fromTime :widget.cubit. toTime,
    );
    if (picked != null) {
      setState(() {
        if (isFromTime) {
        widget.cubit.  fromTime = picked;
        } else {
         widget.cubit. toTime = picked;
        }
      });
    }
  }
}
