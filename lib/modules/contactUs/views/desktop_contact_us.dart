import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/modules/contactUs/controllers/contact_us_controller.dart';
import 'package:tgm/modules/contactUs/widgets/contact_us_rows.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'dart:html' as html;

class DesktopContactUs extends StatelessWidget {
  const DesktopContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactUsController contactUsController = Get.put(
      ContactUsController(),
    );
    final meta = MetaSEO();

    html.document.title = "Contact Us | The Germane Media";

    meta.description(
      description:
          "Contact us at The Germane Media to explore advertising and monetization solutions. Connect with our experts to grow your business and maximize results.",
    );

    meta.keywords(keywords: "Contact Us");

    meta.ogTitle(ogTitle: "Contact Us | The Germane Media");

    meta.ogDescription(
      ogDescription:
          "Connect with The Germane Media experts to grow your business.",
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.w),
            SelectableText.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  TextSpan(
                    text: "Get in",
                    style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
                  ),
                  TextSpan(
                    text: " Touch with Us Today!",

                    style: AppTextStyles.h1.copyWith(
                      color: AppColors.kTextColor1,
                      fontSize: 48.spMin,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 20.w),
              child: SelectableText(
                "At The Germane Media, we believe every conversation is an opportunity to unlock value, build transparency, and drive growth. Reach out to us, and one of our experts will guide you through our solutions, insights, or partnership opportunities.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
              ),
            ),

            SizedBox(height: 120.w),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(height: 1, color: AppColors.kBorderColor),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.kBorderColor),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: SelectableText(
                    "Feel free to contact us through any of the following channels",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3,
                  ),
                ),

                Expanded(
                  child: Container(height: 1, color: AppColors.kBorderColor),
                ),
              ],
            ),
            SizedBox(height: 80.w),

            SelectableText(
              "Contact Us Via Email or Phone",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3,
            ),

            SizedBox(height: 50.w),

            ContactUsRows(
              title: "For General Inquiries",
              email: "social@thegermanemedia.com",
              phoneNumber: "+91-8919341615",
            ),

            SizedBox(height: 50.w),

            ContactUsRows(
              title: "For Business Collaborations",
              email: "abhishek.singh@thegermanemedia.com",
              phoneNumber: "+91-7632814293",
            ),

            SizedBox(height: 50.w),

            ContactUsRows(
              title: "For Job Opportunities",
              email: "tarang@thegermanemedia.com",
              phoneNumber: "+91-8445537704",
            ),

            SizedBox(height: 50.w),

            SelectableText(
              "Online Inquiry Form",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3,
            ),

            SizedBox(height: 20.w),

            SelectableText(
              "Please fill in the following details, and we'll get back to you within 24 hours.",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
            ),

            SizedBox(height: 50.w),

            Container(
              padding: EdgeInsets.all(80.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xff262626),
                border: Border.all(color: Color(0xff595959), width: 1),
              ),

              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ContactFormFields(
                          title: "Name",
                          controller:
                              contactUsController.nameTextEditingController,
                          helpText: "Enter your Name",
                        ),
                      ),
                      SizedBox(width: 50.w),
                      Expanded(
                        child: ContactFormFields(
                          controller:
                              contactUsController.emailTextEditingController,
                          title: "Email",
                          helpText: "Enter your Email",
                        ),
                      ),
                      SizedBox(width: 50.w),

                      Expanded(
                        child: ContactFormFields(
                          title: "Phone Number",
                          controller:
                              contactUsController.phoneTextEditingController,
                          helpText: "Enter your Phone Number",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50.w),

                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return ContactFormDropdown(
                            title: "Select Service",
                            hintText: "Select Your Service",

                            selectedValue:
                                contactUsController.selectedServiceId.value,
                            items: contactUsController.servicesDropdownList
                                .map(
                                  (service) => DropdownMenuItem<String>(
                                    value: service.id.toString(),
                                    child: Text(service.name.toString()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              contactUsController.selectedServiceId.value =
                                  value ?? "";
                            },
                          );
                        }),
                      ),
                      SizedBox(width: 50.w),
                      Expanded(
                        child: ContactFormFields(
                          title: "Company/Organization Name",
                          controller:
                              contactUsController.companyTextEditingController,
                          helpText: "Enter Name",
                        ),
                      ),
                      SizedBox(width: 50.w),

                      Expanded(
                        child: ContactFormFields(
                          title: "Subject",
                          controller:
                              contactUsController.subjectTextEditingController,
                          helpText: "Enter your Subject",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50.w),
                  Row(
                    children: [
                      Expanded(
                        child: ContactFormFields(
                          title: "Message",
                          controller:
                              contactUsController.messageTextEditingController,
                          maxLines: 4,
                          helpText: "Enter your Message",
                          height: 153.w,
                          borderRadius: 20.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => contactUsController.isSubmittingEnquiry.value
                            ? Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : InkWell(
                                onTap: () {
                                  contactUsController.handleSubmitEnquiry(
                                    context,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.lg,
                                    vertical: AppSpacing.md,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.kBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(74.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Send your Inquiry",
                                        style: AppTextStyles.h3,
                                      ),
                                      SizedBox(width: 6.w),
                                      SvgPicture.asset(
                                        IconUrls.kRightArrowIcon,
                                        height: 28.w,
                                        width: 28.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 100.w),

            DesktopFooter(),
          ],
        ),
      ),
    );
  }
}

class ContactFormFields extends StatelessWidget {
  const ContactFormFields({
    super.key,
    required this.title,
    required this.helpText,
    this.height,
    this.maxLines,
    this.borderRadius,
    required this.controller,
  });
  final String title, helpText;
  final double? height;
  final int? maxLines;
  final double? borderRadius;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(title, style: AppTextStyles.h3),
        SizedBox(height: 14.w),
        SizedBox(
          height: height ?? 67.w,

          child: TextField(
            maxLines: maxLines,
            controller: controller,
            style: AppTextStyles.body.copyWith(fontSize: 16),
            decoration: InputDecoration(
              hintText: helpText,
              hintStyle: AppTextStyles.body.copyWith(
                fontSize: 16,
                color: Color(0xff666666),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide: BorderSide(color: Color(0xff595959)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide: BorderSide(color: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactFormDropdown extends StatelessWidget {
  const ContactFormDropdown({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.height,
    this.borderRadius,
  });

  final String title;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(title, style: AppTextStyles.h3),
        SizedBox(height: 14.w),
        SizedBox(
          height: height ?? 67.w,
          child: DropdownButtonFormField<String>(
            initialValue: selectedValue,
            items: items,
            onChanged: onChanged,
            style: AppTextStyles.body.copyWith(fontSize: 16.spMin),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.body.copyWith(
                fontSize: 16.spMin,
                color: AppColors.kTextColor2,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide: const BorderSide(color: Color(0xff595959)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide: const BorderSide(color: AppColors.whiteColor),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ),

            dropdownColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
