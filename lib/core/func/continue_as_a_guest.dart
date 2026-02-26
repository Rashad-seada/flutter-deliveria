import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/constants.dart';

bool isContinueAsGuest = false;

Future<void> loadContinueAsGuest() async {
  final value = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
  isContinueAsGuest = value is bool ? value : false;
}
