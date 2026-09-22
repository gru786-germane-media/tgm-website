import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/company/views/desktop_company.dart';
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
          "Contact us at The Germane Media to explore advertising and monetization solutions. Connect with our experts to grow your business and maximize results.",
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageUrls.kBackgroundTextureBig,
            fit: BoxFit.cover,
            width: double.maxFinite,
            excludeFromSemantics: true,
          ),
          SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 200.w,
                    vertical: 20.w,
                  ),
                  child: SelectableText(
                    "At The Germane Media, we believe every conversation is an opportunity to unlock value, build transparency, and drive growth. Reach out to us, and one of our experts will guide you through our solutions, insights, or partnership opportunities.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                ),

                SizedBox(height: 120.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.kBorderColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 14.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.kBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: SelectableText(
                        "Feel free to contact us through any of the following channels",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h3,
                      ),
                    ),

                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.kBorderColor,
                      ),
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
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.kTextColor2,
                  ),
                ),

                SizedBox(height: 50.w),

                Container(
                  padding: EdgeInsets.all(80.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Color.fromARGB(13, 255, 255, 255),
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
                              maxLength: 50,
                            ),
                          ),
                          SizedBox(width: 50.w),
                          Expanded(
                            child: ContactFormFields(
                              controller: contactUsController
                                  .emailTextEditingController,
                              title: "Email",
                              maxLength: 50,
                              helpText: "Enter your Email",
                            ),
                          ),
                          SizedBox(width: 50.w),

                          Expanded(
                            child: ContactFormFields(
                              title: "Phone Number",
                              maxLength: 15,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: contactUsController
                                  .phoneTextEditingController,
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
                              controller: contactUsController
                                  .companyTextEditingController,
                              helpText: "Enter Name",
                              maxLength: 50,
                            ),
                          ),
                          SizedBox(width: 50.w),

                          Expanded(
                            child: ContactFormFields(
                              title: "Subject",
                              controller: contactUsController
                                  .subjectTextEditingController,
                              helpText: "Enter your Subject",
                              maxLength: 80,
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
                              controller: contactUsController
                                  .messageTextEditingController,
                              maxLines: 4,
                              helpText: "Enter your Message",
                              maxLength: 200,
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
                                ? Center(child: AppLoader())
                                : _SendEnquiryButton(
                                    onTap: () {
                                      contactUsController.handleSubmitEnquiry(
                                        context,
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100.w),

                Row(
                  children: [
                    Expanded(
                      child: FeedbackCards(
                        iconUrl: IconUrls.kClockFilledIcon,
                        title: "Our Response",
                        subTitle:
                            "We understand the importance of timely responses, and our team is committed to addressing your inquiries promptly. Whether you have a specific project in mind, need advice on digital strategies, or want to explore partnership opportunities, we are here to assist you at every step.",
                      ),
                    ),
                    SizedBox(width: 50.w),

                    Expanded(
                      child: FeedbackCards(
                        iconUrl: IconUrls.kShieldIcon,
                        title: "Privacy Assurance",
                        subTitle:
                            "At Germane Media, we prioritize your privacy and protect your personal information in compliance with data protection regulations. Rest assured that your details will only be used for the purpose of addressing your inquiries and will not be shared with third parties without your consent",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 100.w),

                DesktopFooter(),
              ],
            ),
          ),
        ],
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
    this.maxLength,
    this.borderRadius,
    this.inputFormatters,
    required this.controller,
  });
  final String title, helpText;
  final double? height;
  final int? maxLines, maxLength;
  final double? borderRadius;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

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
            maxLength: maxLength,
            inputFormatters: inputFormatters,
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
            hint: Text(
              hintText,
              style: AppTextStyles.body.copyWith(
                fontSize: 16.spMin,
                color: AppColors.kTextColor2,
              ),
            ),
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

/// Outlined pill button that fills white (with dark text/icon) on hover.
class _SendEnquiryButton extends StatefulWidget {
  const _SendEnquiryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_SendEnquiryButton> createState() => _SendEnquiryButtonState();
}

class _SendEnquiryButtonState extends State<_SendEnquiryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = _isHovered
        ? AppColors.kBackgroundColor2
        : AppColors.whiteColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.whiteColor : Colors.transparent,
            border: Border.all(width: 1, color: AppColors.kBorderColor),
            borderRadius: BorderRadius.circular(74.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Send your Inquiry",
                style: AppTextStyles.h3.copyWith(color: textColor),
              ),
              SizedBox(width: 6.w),
              SvgPicture.asset(
                IconUrls.kRightArrowIcon,
                height: 28.w,
                width: 28.w,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                excludeFromSemantics: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
