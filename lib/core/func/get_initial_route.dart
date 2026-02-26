import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/routing/routes.dart';

Future<({String route, Object? arguments})> getInitialRouteWithArgs() async {
  final token = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  final userType = await SharedPrefHelper.getString(SharedPrefKeys.userType);
  final resturantId = await SharedPrefHelper.getString(SharedPrefKeys.resId);
  final finishOnBoarding = await SharedPrefHelper.getBool(
    SharedPrefKeys.finishOnBoarding,
  );
  final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);

  // Check finishOnBoarding first
  if (finishOnBoarding != true) {
    return (route: Routes.onBoarding, arguments: null);
  }

  if ((token != null && token.toString().isNotEmpty) || isGuest) {
    if (userType == "user" || isGuest) {
      return (route: Routes.bottomBarScreen, arguments: 0);
    } else if (userType == "restaurant") {
      return (route: Routes.resturantBottomBar, arguments: resturantId);
    } else if (userType == "agent") {
      return (route: Routes.deliveryAgentHomeScreen, arguments: null);
    } else {
      return (route: Routes.adminBottomBarScreen, arguments: [0, false, false]);
    }
  }
  return (route: Routes.loginScreen, arguments: null);
}
