import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const String _termsAr = '''
شروط وأحكام الاستخدام – دلفيريا
تحكم هذه الاتفاقية شروط وأحكام استخدامك لتطبيق دلفيريا وخدماته. باستخدامك لتطبيق دلفيريا، فإنك تقرّ بموافقتك الكاملة على هذه الشروط. إذا لم توافق، يُرجى عدم استخدام التطبيق.

١. نظرة عامة على الخدمة
"دلفيريا" هو تطبيق رقمي يربط المستخدمين بالمطاعم والمتاجر، ويتيح لهم تصفح القوائم، تقديم الطلبات، وطلب التوصيل. يقوم دلفيريا بتسهيل العملية ولا يتحمل مسؤولية إعداد أو جودة المنتجات المقدمة من البائعين.

٢. التزامات المستخدم
يجب على المستخدم إدخال بيانات شخصية دقيقة وكاملة عند التسجيل.
يتحمل المستخدم مسؤولية الحفاظ على سرية حسابه وكلمة مروره.
أي إساءة استخدام، مثل الطلبات الوهمية أو انتحال الشخصية، تؤدي إلى إيقاف أو إلغاء الحساب.

٣. عملية الطلب والتوصيل
يتم إرسال الطلبات التي يتم إجراؤها عبر "دلفيريا" إلى البائع المعني لتحضيرها وتوصيلها.
بعد تأكيد الطلب، قد لا يكون من الممكن تعديله أو إلغاؤه.
لا يتحمل "دلفيريا" مسؤولية التأخير أو نفاد العناصر أو أخطاء البائع، ولكنه سيساعد في حل المشكلات عند الإمكان.

٤. شروط الدفع
يمكن الدفع نقدًا عند الاستلام أو باستخدام وسائل الدفع الإلكتروني المعتمدة.
تتم معالجة المدفوعات الإلكترونية عبر مزودي خدمة خارجيين، ويجب أن تتم باستخدام حسابات أو بطاقات مصرّح بها.

٥. سياسة الإلغاء والاسترداد
لا يمكن إلغاء الطلب بعد تأكيده إلا إذا تعذر على البائع تنفيذه.
في حال وجود عناصر ناقصة أو خاطئة، قد يتم استرداد كامل أو جزئي للمبلغ وفقًا لتقدير "دلفيريا".
تتم عمليات الاسترداد خلال ٧ إلى ١٤ يوم عمل حسب مزود الدفع أو البنك.

٦. محتوى المستخدم والتقييمات
يحق للمستخدمين نشر مراجعات وتقييمات تعكس تجاربهم الحقيقية.
تحتفظ "دلفيريا" بحق حذف أي محتوى يحتوي على ألفاظ غير لائقة أو تعليقات مسيئة أو محتوى ترويجي غير مصرح به.

٧. الاستخدامات المحظورة
يُمنع على المستخدمين:
نشر محتوى غير قانوني أو مضلل أو ضار.
استخدام التطبيق لأغراض تجارية غير مصرح بها.
التلاعب بالخدمة أو الوصول إلى بيانات دون إذن.

٨. حقوق الملكية الفكرية
جميع محتويات تطبيق دلفيريا، بما في ذلك النصوص والتصاميم والشعارات والبرمجيات، مملوكة أو مرخصة لدلفيريا ومحميّة بموجب قوانين الملكية الفكرية. لا يجوز نسخها أو إعادة استخدامها دون إذن.

٩. إخلاء المسؤولية
يعمل دلفيريا كوسيط فقط بين المستخدم والبائع. ولا يتحمل مسؤولية جودة الطعام أو النظافة أو سلوك البائع. تقتصر مسؤوليتنا على الدعم الفني والمساعدة في الحالات الطارئة.

١٠. إيقاف الحساب
تحتفظ دلفيريا بحق إيقاف أو حذف أي حساب ينتهك الشروط أو يظهر عليه نشاط مشبوه، دون إشعار مسبق.

١١. تعديل الشروط
يحق لدلفيريا تعديل هذه الشروط في أي وقت. ويُعتبر استمرار استخدامك للتطبيق موافقة ضمنية على التعديلات.

١٢. القانون المختص والاختصاص القضائي
تخضع هذه الاتفاقية لأحكام قوانين جمهورية مصر العربية، وتُحل أي نزاعات في نطاق اختصاص المحاكم المصرية.
''';

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Directionality.of(context) == TextDirection.rtl ||
        Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isArabic ? "شروط وأحكام الاستخدام" : "Terms and Conditions",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child:
            isArabic
                ? Text(
                  _termsAr,
                  style: TextStyles.bimini14W700,
                  textDirection: TextDirection.rtl,
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms and Conditions of Use – Delveria",
                      style: TextStyles.bimini18W700.copyWith(
                        color: AppColors.primaryDeafult,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "This Terms of Use Agreement (“Agreement”) governs your use of the Delveria application and services. By accessing or using Delveria, you agree to be legally bound by this Agreement. If you do not agree, please refrain from using the platform.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("1. Service Overview"),
                    const SizedBox(height: 8),
                    Text(
                      "Delveria is a digital platform that connects users with restaurants and shops, allowing them to browse menus, place orders, and request delivery. Delveria facilitates the process but is not responsible for the preparation or quality of the items provided by vendors.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("2. User Obligations"),
                    const SizedBox(height: 8),
                    _bullet(
                      "Users must register using accurate and complete personal data.",
                    ),
                    _bullet(
                      "Users are responsible for maintaining the confidentiality of their accounts.",
                    ),
                    _bullet(
                      "Any misuse, including false orders, impersonation, or inappropriate conduct, will lead to suspension or termination of access.",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("3. Order and Delivery Process"),
                    const SizedBox(height: 8),
                    _bullet(
                      "Orders placed through Delveria are sent to the vendor for preparation and delivery.",
                    ),
                    _bullet(
                      "Once an order is confirmed, cancellation or modification may not be possible.",
                    ),
                    _bullet(
                      "Delveria is not responsible for delays, item unavailability, or vendor errors but may assist in resolving disputes.",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("4. Payment Terms"),
                    const SizedBox(height: 8),
                    _bullet(
                      "Payments can be made via cash on delivery or approved electronic payment methods.",
                    ),
                    _bullet(
                      "Electronic payments are processed by third-party providers and must be made using authorized bank accounts or cards.",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("5. Refund and Cancellation Policy"),
                    const SizedBox(height: 8),
                    _bullet(
                      "Orders cannot be canceled after confirmation unless the vendor is unable to fulfill them.",
                    ),
                    _bullet(
                      "In the case of missing or incorrect items, partial or full refunds may apply at Delveria’s discretion.",
                    ),
                    _bullet(
                      "Refunds are processed within 7 to 14 business days depending on the user’s bank/payment provider.",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("6. User Content and Reviews"),
                    const SizedBox(height: 8),
                    _bullet(
                      "Users may post reviews and feedback based on genuine experiences.",
                    ),
                    _bullet(
                      "Delveria reserves the right to hide or remove content that includes inappropriate language, defamatory comments, or promotional material.",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("7. Prohibited Uses"),
                    const SizedBox(height: 8),
                    _bullet("Users must not:"),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bullet(
                            "Post illegal, misleading, or harmful content.",
                          ),
                          _bullet(
                            "Use the app for unauthorized commercial purposes.",
                          ),
                          _bullet(
                            "Disrupt the platform’s services or access data through unauthorized means.",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("8. Intellectual Property"),
                    const SizedBox(height: 8),
                    Text(
                      "All content on Delveria, including text, graphics, logos, and software, is owned or licensed by Delveria and protected by intellectual property laws. Any reproduction or reuse without permission is prohibited.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("9. Liability Disclaimer"),
                    const SizedBox(height: 8),
                    Text(
                      "Delveria acts only as a mediator between the user and vendor. We are not liable for food quality, hygiene, or vendor actions. Our responsibility is limited to support and technical assistance.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("10. Account Suspension"),
                    const SizedBox(height: 8),
                    Text(
                      "Delveria reserves the right to suspend or terminate accounts that violate the terms of use or display suspicious activity without prior notice.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("11. Changes to Terms"),
                    const SizedBox(height: 8),
                    Text(
                      "Delveria may revise these terms from time to time. Continued use of the service after such changes constitutes your acceptance of the new terms.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("12. Jurisdiction and Applicable Law"),
                    const SizedBox(height: 8),
                    Text(
                      "This agreement shall be governed by the laws of the Arab Republic of Egypt. Any disputes arising shall be subject to the exclusive jurisdiction of Egyptian courts.",
                      style: TextStyles.bimini14W700,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
      ),
    );
  }

  static Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyles.bimini16W700,
    );
  }

  static Widget _bullet(String text) {
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