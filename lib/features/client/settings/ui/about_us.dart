import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/social_btn.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const String _aboutUsTitleAr = "من نحن";
  static const String _welcomeAr =
      "مرحبًا بك في دلفيريا – أول منصة تجمع بين عروض المطاعم وتوصيل الطعام في صعيد مصر.";
  static const String _missionAr =
      "مهمتنا بسيطة: ربطك بمطاعمك المفضلة، وعروض حصرية، وخدمة توصيل سريعة وموثوقة – كل ذلك في تطبيق واحد.";
  static const String _aboutAr =
      "في دلفيريا، نجعل تناول الطعام أسهل، وأكثر توفيرًا، وأقرب إليك. سواء كانت وجبة خفيفة سريعة أو اكتشاف مطاعم جديدة، نحن هنا لنوصّل السعادة إلى بابك.";
  static const String _availableAr = "متوفر حاليًا: قنا، مصر (وسنوسع قريبًا)";
  static const String _workingHoursAr = "ساعات العمل: 24/7";
  static const String _connectWithUsAr = "تواصل معنا:";
  static const String _websiteAr = "الموقع الإلكتروني: Delveria.com";
  static const String _facebookAr = "فيسبوك";
  static const String _instagramAr = "انستجرام";
  static const String _whatsappAr = "دعم العملاء (واتساب)";
  static const String _footerAr =
      "دلفيريا أكثر من مجرد تطبيق – إنه شريكك المحلي الموثوق في توصيل الطعام.";


  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isArabic ? _aboutUsTitleAr : "About Us ",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic
                  ? _welcomeAr
                  : 'Welcome to Delveria – the first platform that brings together restaurant offers and food delivery in Upper Egypt.',
              style: TextStyles.bimini16W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            const SizedBox(height: 16),
            Text(
              isArabic
                  ? _missionAr
                  : 'Our mission is simple: to connect you with your favorite restaurants, exclusive deals, and a fast, reliable delivery service – all in one app.',
              style: TextStyles.bimini14W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            const SizedBox(height: 16),
            Text(
              isArabic
                  ? _aboutAr
                  : 'At Delveria, we make dining easier, more affordable, and closer to you. Whether it’s a quick snack or discovering new restaurants, we’re here to deliver happiness right to your door.',
              style: TextStyles.bimini14W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primaryDeafult),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isArabic
                        ? _availableAr
                        : 'Currently Available: Qena, Egypt (expanding soon)',
                    style: TextStyles.bimini13W700Deafult,
                    textDirection:
                        isArabic ? TextDirection.rtl : TextDirection.ltr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.green, size: 20.sp),
                const SizedBox(width: 8),
                Text(
                  isArabic ? _workingHoursAr : 'Working Hours: 24/7',
                  style: TextStyles.bimini13W700Deafult,
                  textDirection:
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              isArabic ? _connectWithUsAr : 'Connect with us:',
              style: TextStyles.bimini16W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            const SizedBox(height: 16),
            socialButton(
              label: isArabic ? _websiteAr : 'Website: Delveria.com',
              icon: const FaIcon(FontAwesomeIcons.globe, color: Colors.blue, size: 28),
              url: 'https://Delveria.com',
            ),
            const SizedBox(height: 12),
            socialButton(
              label: isArabic ? _facebookAr : 'Facebook',
              icon: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F3), size: 28),
              url: 'https://www.facebook.com/share/1C629ujGwN/',
              color: const Color(0xFF1877F3),
            ),
            const SizedBox(height: 12),
            socialButton(
              label: isArabic ? _instagramAr : 'Instagram',
              icon: const FaIcon(FontAwesomeIcons.instagram, color: Color(0xFFE1306C), size: 28),
              url:
                  'https://www.instagram.com/delveria_app?igsh=MW9zajQwcHB6MTFxcw==',
              color: const Color(0xFFE1306C),
            ),
            const SizedBox(height: 12),
            socialButton(
              label: isArabic ? _whatsappAr : 'Customer Support (WhatsApp)',
              icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 28),
              url: 'https://wa.me/message/2CXIY5TFVUZ6O1?src=qr',
              color: const Color(0xFF25D366),
            ),
            const SizedBox(height: 32),
            Text(
              isArabic
                  ? _footerAr
                  : 'Delveria is more than just an app – it’s your trusted local partner in food delivery.',
              style: TextStyles.bimini14W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}