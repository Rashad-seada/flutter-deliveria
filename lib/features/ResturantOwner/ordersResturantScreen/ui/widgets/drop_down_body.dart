import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:styled_drop_down/styled_drop_down.dart';

class DropDownBody extends StatefulWidget {
  const DropDownBody({super.key, this.isDeliveryAgent});
  final bool? isDeliveryAgent;

  @override
  State<DropDownBody> createState() => _DropDownBodyState();
}

class _DropDownBodyState extends State<DropDownBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: StyledDropDown(
        dropDownBodyColor: AppColors.lightGrey,
        itemBuilder: (context, item, selected) {
          return Row(
            children: [
              Text(item),
              Spacer(),
              selected
                  ? Icon(Icons.check, color: AppColors.primaryDeafult)
                  : SizedBox(),
            ],
          );
        },
        itemContainerColor: AppColors.lightGrey,
        value:
            widget.isDeliveryAgent == true
                ? AppLists.selectedOrderStatusAgent
                : AppLists.selectedStatus,
        items:
            widget.isDeliveryAgent == true
                ? AppLists.agentdeliveryList
                : AppLists.orderStatusList,
        onChanged: (value) async {
          await SharedPrefHelper.setData(SharedPrefKeys.agentStatus, value);
          setState(() {
            widget.isDeliveryAgent == true
                ? AppLists.selectedOrderStatusAgent = value
                : AppLists.selectedStatus = value;
          });
        },
      ),
    );
  }
}
