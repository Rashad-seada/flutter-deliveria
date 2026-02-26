import 'package:delveria/core/func/url_launcher.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/social_btn.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const String _phoneAr = "الهاتف: 01122858576";
  static const String _emailAr = "البريد: Qena@Delveria.com";
  static const String _footerAr =
      "دلفيريا أكثر من مجرد تطبيق – إنه شريكك المحلي الموثوق في توصيل الطعام.";

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isArabic ? _aboutUsTitleAr : "About Us",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Header Image/Logo representation
            Center(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.storefront_rounded,
                  size: 64.sp,
                  color: AppColors.primaryDeafult,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Who we are Card
            _buildSectionCard(
              children: [
                _buildSectionTitle(isArabic ? 'من نحن' : 'Who We Are', isArabic),
                SizedBox(height: 12.h),
                Text(
                  isArabic
                      ? _welcomeAr
                      : 'Welcome to Delveria – the first platform that brings together restaurant offers and food delivery in Upper Egypt.',
                  style: TextStyles.bimini14W500.copyWith(height: 1.5),
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                ),
                SizedBox(height: 16.h),
                Text(
                  isArabic
                      ? _missionAr
                      : 'Our mission is simple: to connect you with your favorite restaurants, exclusive deals, and a fast, reliable delivery service – all in one app.',
                  style: TextStyles.bimini14W500.copyWith(height: 1.5),
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                ),
                SizedBox(height: 16.h),
                Text(
                  isArabic
                      ? _aboutAr
                      : 'At Delveria, we make dining easier, more affordable, and closer to you. Whether it’s a quick snack or discovering new restaurants, we’re here to deliver happiness right to your door.',
                  style: TextStyles.bimini14W500.copyWith(height: 1.5),
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                ),
              ],
            ),

            // Availability & Working Hours Card
            _buildSectionCard(
              children: [
                _buildInfoRow(
                  icon: Icons.location_on,
                  color: AppColors.primaryDeafult,
                  text: isArabic
                      ? _availableAr
                      : 'Currently Available: Qena, Egypt (expanding soon)',
                  isArabic: isArabic,
                ),
                SizedBox(height: 16.h),
                _buildInfoRow(
                  icon: Icons.access_time_filled,
                  color: Colors.green,
                  text: isArabic ? _workingHoursAr : 'Working Hours: 24/7',
                  isArabic: isArabic,
                ),
              ],
            ),

            // Contact Us Card
            _buildSectionCard(
              children: [
                _buildSectionTitle(isArabic ? _connectWithUsAr : 'Connect with us:', isArabic),
                SizedBox(height: 20.h),
                
                _buildContactButton(
                  label: isArabic ? _phoneAr : 'Phone: 01122858576',
                  icon: FontAwesomeIcons.phone,
                  color: Colors.teal,
                  onTap: () => launchUrl(Uri.parse('tel:01122858576')),
                ),
                SizedBox(height: 16.h),
                
                _buildContactButton(
                  label: isArabic ? _emailAr : 'Email: Qena@Delveria.com',
                  icon: FontAwesomeIcons.solidEnvelope,
                  color: Colors.redAccent,
                  onTap: () => launchUrl(Uri.parse('mailto:Qena@Delveria.com')),
                ),
                SizedBox(height: 16.h),
                
                _buildContactButton(
                  label: isArabic ? _whatsappAr : 'WhatsApp Support',
                  icon: FontAwesomeIcons.whatsapp,
                  color: const Color(0xFF25D366),
                  onTap: () => launchUrlHelper('https://wa.me/message/2CXIY5TFVUZ6O1?src=qr', mode: LaunchMode.externalApplication),
                ),
                SizedBox(height: 16.h),
                
                _buildContactButton(
                  label: isArabic ? _facebookAr : 'Facebook',
                  icon: FontAwesomeIcons.facebook,
                  color: const Color(0xFF1877F3),
                  onTap: () => launchUrlHelper('https://www.facebook.com/share/1C629ujGwN/', mode: LaunchMode.externalApplication),
                ),
                SizedBox(height: 16.h),
                
                _buildContactButton(
                  label: isArabic ? _instagramAr : 'Instagram',
                  icon: FontAwesomeIcons.instagram,
                  color: const Color(0xFFE1306C),
                  onTap: () => launchUrlHelper('https://www.instagram.com/delveria_app?igsh=MW9zajQwcHB6MTFxcw==', mode: LaunchMode.externalApplication),
                ),
                SizedBox(height: 16.h),
                
                _buildContactButton(
                  label: isArabic ? _websiteAr : 'Website: Delveria.com',
                  icon: FontAwesomeIcons.globe,
                  color: Colors.blue,
                  onTap: () => launchUrlHelper('https://Delveria.com', mode: LaunchMode.externalApplication),
                ),
              ],
            ),

            // Footer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
              child: Text(
                isArabic
                    ? _footerAr
                    : 'Delveria is more than just an app – it’s your trusted local partner in food delivery.',
                style: TextStyles.bimini14W500.copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              ),
            ),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isArabic) {
    return Text(
      title,
      style: TextStyles.bimini18W700.copyWith(
        color: AppColors.primaryDeafult,
      ),
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color color,
    required String text,
    required bool isArabic,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              text,
              style: TextStyles.bimini14W700,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: FaIcon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: TextStyles.bimini14W700.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}