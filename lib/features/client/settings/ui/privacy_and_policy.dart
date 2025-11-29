import 'package:delveria/core/func/url_launcher.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  static const String _privacyPolicyAr = '''
سياسة الخصوصية – تطبيق وموقع دلفيريا

في دلفيريا، نحن ملتزمون بحماية خصوصيتك وضمان التعامل مع بياناتك الشخصية بأمان ومسؤولية. توضح هذه السياسة كيفية جمعنا لمعلوماتك، واستخدامها، وحمايتها أثناء استخدامك للتطبيق أو الموقع.

1. البيانات التي نقوم بجمعها
البيانات الشخصية: الاسم، رقم الهاتف، البريد الإلكتروني، عنوان التوصيل.

بيانات الاستخدام: نوع الجهاز، نوع المتصفح، عنوان الـ IP، إحصائيات الاستخدام.

الموقع الجغرافي: في حال منح الإذن، قد نجمع موقعك لتحسين دقة التوصيل.

2. كيفية استخدام المعلومات
معالجة الطلبات وتوصيلها.

التواصل معك (مثل إشعارات الطلب أو الدعم الفني).

تحسين تجربتك والخدمات المقدمة.

الحماية من الاحتيال وضمان الأمان.

3. مشاركة البيانات
لا نقوم ببيع أو تأجير بياناتك. قد نشاركها فقط مع:

شركاء التوصيل لتنفيذ الطلبات.

مزودي الخدمات التقنية (مثل الاستضافة أو التحليلات) ضمن اتفاقيات سرية.

4. حماية البيانات
نطبق إجراءات أمان صارمة لحماية بياناتك، مثل التشفير والاستضافة الآمنة للخوادم.

5. حقوقك
يمكنك طلب الوصول إلى بياناتك أو حذفها في أي وقت.

الحق في استلام الطلب بأمان – لك الحق في استلام طلبك كما تم تأكيده وفي الوقت المحدد.

الحق في تقديم شكوى – يمكنك الإبلاغ عن أي مشكلة في الخدمة أو التوصيل أو جودة الطعام أو سلوك المندوب من خلال قنوات الدعم لدينا.

الحق في السرية – لا يتم مشاركة أي إيصالات دفع أو تفاصيل مصروفاتك مع أي طرف ثالث أو عرضها علنًا.

6. التعديلات على السياسة
قد نقوم بتحديث سياسة الخصوصية من وقت لآخر، وسيتم إعلامك بأي تغييرات مهمة من خلال التطبيق أو الموقع.

للاستفسارات أو الشكاوى، يرجى التواصل عبر: support@delveria.com
''';

  static const String _supportEmail = 'support@delveria.com';

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isArabic ? "سياسة الخصوصية" : "Privacy Policy",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child:
            isArabic
                ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: _arabicPolicyWithEmailLauncher(context),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy Policy – Delveria App & Website",
                      style: TextStyles.bimini18W700.copyWith(
                        color: AppColors.primaryDeafult,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "At Delveria, we are committed to protecting your privacy and ensuring your personal data is handled safely and responsibly. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile app and website.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "1. Information We Collect",
                      style: TextStyles.bimini16W700,
                    ),
                    const SizedBox(height: 8),
                    _bullet(
                      "Personal Information: Name, phone number, email address, delivery address.",
                    ),
                    _bullet(
                      "Usage Data: Device type, browser type, IP address, app usage statistics.",
                    ),
                    _bullet(
                      "Location: If permitted, we may collect your location to deliver orders more accurately.",
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "2. How We Use Your Information",
                      style: TextStyles.bimini16W700,
                    ),
                    const SizedBox(height: 8),
                    _bullet("To process and deliver your orders."),
                    _bullet(
                      "To communicate with you (e.g., order updates, support).",
                    ),
                    _bullet("To improve our services and user experience."),
                    _bullet("For security and fraud prevention."),
                    const SizedBox(height: 24),
                    Text("3. Data Sharing", style: TextStyles.bimini16W700),
                    const SizedBox(height: 8),
                    Text(
                      "We do not sell or rent your data. We may share it only with:",
                      style: TextStyles.bimini14W700,
                    ),
                    _bullet("Delivery partners to fulfill your order."),
                    _bullet(
                      "Technical service providers (e.g., hosting or analytics) under confidentiality agreements.",
                    ),
                    const SizedBox(height: 24),
                    Text("4. Data Protection", style: TextStyles.bimini16W700),
                    const SizedBox(height: 8),
                    Text(
                      "We apply strict security measures to protect your data, including encryption and secure server hosting.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    Text("5. Your Rights", style: TextStyles.bimini16W700),
                    const SizedBox(height: 8),
                    _bullet(
                      "You can request access to your data or ask us to delete it at any time.",
                    ),
                    _bullet(
                      "Right to Safe Orders – You have the right to receive your order in the condition it was confirmed and within the estimated time.",
                    ),
                    _bullet(
                      "Right to File a Complaint – You can report any issue regarding service, delivery, food quality, or behavior through our support channels.",
                    ),
                    _bullet(
                      "Right to Confidentiality – Your receipts, payments, and delivery notes will never be shared with third parties or shown publicly.",
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "6. Updates to This Policy",
                      style: TextStyles.bimini16W700,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We may update this policy from time to time. We will notify you of any significant changes via the app or website.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "If you have questions or concerns, please contact us at: ",
                          style: TextStyles.bimini14W700.copyWith(
                            color: AppColors.primaryDeafult,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final url = 'mailto:$_supportEmail';
                            final canLaunchResult = await canLaunchUrl(
                              Uri.parse(url),
                            );
                            if (canLaunchResult) {
                              await launchUrlHelper(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Could not open email client. Please send an email to $_supportEmail.",
                                      style: TextStyles.bimini14W700,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            _supportEmail,
                            style: TextStyles.bimini14W700.copyWith(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _arabicPolicyWithEmailLauncher(BuildContext context) {
    const email = 'support@delveria.com';
    final parts = _privacyPolicyAr.split(email);
    return RichText(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: TextStyles.bimini14W700.copyWith(color: Colors.black),
        children: [
          TextSpan(text: parts[0]),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: InkWell(
              onTap: () async {
                
                
                
                
                
                
                final url =
                    email.startsWith('mailto:') ? email : 'mailto:$email';
                final canLaunchResult = await canLaunchUrl(Uri.parse(url));
                if (canLaunchResult) {
                  await launchUrlHelper(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "تعذر فتح تطبيق البريد الإلكتروني. يرجى إرسال بريد إلى $email.",
                          style: TextStyles.bimini14W700,
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(
                email,
                style: TextStyles.bimini14W700.copyWith(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyles.bimini14W700,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyles.bimini14W700,
            ),
          ),
        ],
      ),
    );
  }
}