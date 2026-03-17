import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/people_card_clipper.dart';
import 'package:tgm/core/utils/utility_methods.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/company/controllers/career_controller.dart';
import 'package:tgm/modules/company/controllers/company_controller.dart';
import 'package:tgm/modules/company/controllers/people_controller.dart';
import 'package:tgm/modules/company/widgets/bottom_loop_text.dart';
import 'package:tgm/modules/company/widgets/circular_casousel_company.dart';
import 'package:tgm/modules/contactUs/views/desktop_contact_us.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';

class DesktopCompany extends StatefulWidget {
  const DesktopCompany({super.key, required this.section});
  final CompanyPageSection? section;

  @override
  State<DesktopCompany> createState() => _DesktopCompanyState();
}

class _DesktopCompanyState extends State<DesktopCompany> {
  final GlobalKey _visionKey = GlobalKey();

  final GlobalKey _careerKey = GlobalKey();

  final GlobalKey _peopleKey = GlobalKey();

  final GlobalKey _feedbackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Scroll to the section after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToWidget(widget.section);
    });
  }

  @override
  void didUpdateWidget(DesktopCompany oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll if the section parameter changes
    if (oldWidget.section != widget.section) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToWidget(widget.section);
      });
    }
  }

  void _scrollToWidget(CompanyPageSection? section) {
    if (section == null) return;

    GlobalKey? targetKey;

    switch (section) {
      case CompanyPageSection.vision:
        targetKey = _visionKey;
        break;
      case CompanyPageSection.career:
        targetKey = _careerKey;
        break;
      case CompanyPageSection.people:
        targetKey = _peopleKey;
        break;
      case CompanyPageSection.feedback:
        targetKey = _feedbackKey;
        break;
    }

    final context = targetKey?.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.w),
                CompanySection(),
                SizedBox(height: 50.w),

                CompanyVision(key: _visionKey),
                SizedBox(height: 50.w),

                ComanyCareer(key: _careerKey),
                SizedBox(height: 50.w),

                CompanyPeople(key: _peopleKey),

                SizedBox(height: 50.w),

                CompanyFeedback(key: _feedbackKey),
                SizedBox(height: 50.w),
                DesktopFooter(),
                SizedBox(height: 80.w),
              ],
            ),
          ),

          Container(
            height: 80.w,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Color(0xff2a2828),
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.kBorderColor),
                top: BorderSide(width: 1, color: AppColors.kBorderColor),
              ),
            ),
            child: BottomLoopText(),
          ),
        ],
      ),
    );
  }
}

class CompanySection extends StatelessWidget {
  const CompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Empowering Publishers.\nRedefining Monetizations.",
              style: AppTextStyles.h0,
            ),

            SizedBox(height: 50.w),

            CircularCarouselCompany(),
          ],
        ),
      ],
    );
  }
}

class CompanyPeople extends StatelessWidget {
  const CompanyPeople({super.key});

  @override
  Widget build(BuildContext context) {
    final PeopleController peopleController = Get.put(PeopleController());
    return Column(
      children: [
        SelectableText(
          "Meet The Germane Team",
          textAlign: TextAlign.center,

          style: AppTextStyles.h0,
        ),
        SizedBox(height: 14.w),
        SelectableText(
          '''Every product we build, every solution we implement, and every strategy we design is shaped by the expertise, passion, and insight of our team members.
Together, we’re more than a company — we’re a community of innovators shaping the future of digital advertising.''',

          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        ),
        SizedBox(height: 50.w),

        Obx(
          () => peopleController.isLoadingPeople.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : SizedBox(
                  height: 600.w,
                  child: ListView.builder(
                    itemCount: peopleController.peopleList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final people = peopleController.peopleList[index];
                      // List<String> name = people.name!.split(" ");
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        width: 380.w,

                        // height: 566.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCachedImage(
                              height: 380.w,
                              width: 380.w,
                              imageUrl: people.imageUrl ?? "",
                              fit: BoxFit.fitWidth,
                            ),

                            Container(
                              width: 380.w,
                              height: 220.w,
                              color: Color(0xff2a2a2a),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // (index % 2 == 0)
                                    //     ? MainAxisAlignment.start
                                    //     : MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            left: (index % 2 == 0) ? 8.w : 0,
                                            top: 8.w,
                                            right: (index % 2 == 0) ? 0 : 8.w,
                                          ),

                                          child: SelectableText(
                                            formatName(people.name),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.h1.copyWith(
                                              fontSize: 30.spMin,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.w),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            left: (index % 2 == 0) ? 8.w : 0,
                                            right: (index % 2 == 0) ? 0 : 8.w,

                                            bottom: 8.w,
                                          ),
                                          child: SelectableText(
                                            people.position ?? "No data",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.h3.copyWith(
                                              fontSize: 20.spMin,
                                              color: AppColors.kTextColor2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class CompanyFeedback extends StatelessWidget {
  const CompanyFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyController companyController = Get.put(CompanyController());
    return Stack(
      children: [
        Image.asset(
          ImageUrls.kBackgroundTextureBig,
          fit: BoxFit.cover,
          width: double.maxFinite,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 60.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                "We Value Your Feedback",
                textAlign: TextAlign.center,

                style: AppTextStyles.h2,
              ),
              SizedBox(height: 14.w),
              SelectableText(
                "Please fill out the form below — it only takes a few moments, and your input is highly appreciated.",

                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
              ),
              SizedBox(height: 50.w),
              Container(
                padding: EdgeInsets.all(80.w),
                decoration: BoxDecoration(
                  color: AppColors.kContainerColor.withAlpha(80),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ContactFormFields(
                            title: "Name",
                            helpText: "Enter Your Name",
                            controller:
                                companyController.nameTextEditingController,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Expanded(
                          child: ContactFormFields(
                            title: "Email",
                            helpText: "Enter Your Email",
                            controller:
                                companyController.emailTextEditingController,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Expanded(
                          child: ContactFormFields(
                            title: "Phone Number",
                            helpText: "Enter Your Phone Number",
                            controller:
                                companyController.nameTextEditingController,
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
                            helpText: "Enter Your Message",
                            maxLines: 4,
                            height: 153.w,
                            borderRadius: 20.r,
                            controller:
                                companyController.messageTextEditingController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => companyController.isSubmittingFeedback.value
                              ? Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : InkWell(
                                  onTap:
                                      companyController
                                          .isSubmittingFeedback
                                          .value
                                      ? null
                                      : () => companyController.submitFeedback(
                                          context,
                                        ),
                                  child: Container(
                                    height: 64.w,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 18.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(74.r),
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.kBorderColor,
                                      ),
                                      color: AppColors.kSelectedButtonColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Submit Your Feedback",
                                          style: AppTextStyles.h3,
                                        ),
                                        SizedBox(width: 6.w),
                                        SvgPicture.asset(
                                          IconUrls.kRightArrowIcon,
                                          width: 28.w,
                                          height: 28.w,
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

              SizedBox(height: 50.w),

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
            ],
          ),
        ),
      ],
    );
  }
}

class FeedbackCards extends StatelessWidget {
  const FeedbackCards({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.subTitle,
  });
  final String iconUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(width: 0.5, color: AppColors.kBorderColor),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(0, 26, 26, 26),
            Color.fromARGB(128, 26, 26, 26),
            Color(0xff1a1a1a),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 74.w,
                width: 74.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff262626),
                      Color.fromARGB(127, 38, 38, 38),
                      Color.fromARGB(0, 38, 38, 38),
                    ],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconUrl,
                    height: 34.w,
                    width: 34.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              SelectableText(
                title,
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ],
      ),
    );
  }
}

class ComanyCareer extends StatelessWidget {
  const ComanyCareer({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerController careerController = Get.put(CareerController());
    return Column(
      children: [
        SizedBox(
          height: 587.h,
          width: double.maxFinite,
          child: Stack(
            children: [
              Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 160.w,
                  vertical: 80.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Get In Touch With Us Today",
                            style: AppTextStyles.h1.copyWith(
                              fontSize: 36.spMin,
                            ),
                          ),
                          SizedBox(height: 30.w),
                          SelectableText(
                            "At The Germane Media, we believe every conversation is an opportunity to unlock value, build transparency, and drive growth. Reach out to us, and one of our experts will guide you through our solutions, insights, or partnership opportunities.",
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.kTextColor2,
                            ),
                          ),
                          SizedBox(height: 50.w),

                          InkWell(
                            onTap: () {
                              context.go('/contact-us');
                            },
                            child: Container(
                              height: 63.w,
                              width: 270.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff141414),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Contact Us",
                                  style: AppTextStyles.h3.copyWith(
                                    color: Color(0xff98989A),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 80.w),

                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12.r),
                      child: Image.asset(
                        "assets/temp/careerImage1.png",
                        height: 427.w,
                        width: 515.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 25.w),
        SizedBox(
          height: 620.w,
          width: double.maxFinite,
          child: Stack(
            children: [
              Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 160.w,
                  vertical: 80.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12.r),
                      child: Image.asset(
                        "assets/temp/careerImage2.png",
                        height: 427.w,
                        width: 515.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SizedBox(width: 80.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Career at The Germane Media",
                            style: AppTextStyles.h1.copyWith(
                              fontSize: 36.spMin,
                            ),
                          ),
                          SizedBox(height: 30.w),
                          SelectableText(
                            "Explore our current job listings to discover exciting career opportunities that match your skill set and interests. We offer positions in various digital disciplines, including web design, mobile app development, digital marketing, project management, and more. Each job listing provides comprehensive details about the role, responsibilities, qualifications, and benefits. Whether you are an experienced professional or a fresh graduate, we welcome talent from all backgrounds to join our team.",
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.kTextColor2,
                            ),
                          ),
                          SizedBox(height: 50.w),

                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    "Open Jobs",
                                    style: AppTextStyles.h3.copyWith(
                                      color: Color(0xff98989A),
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  Obx(
                                    () =>
                                        careerController.isLoadingCareers.value
                                        ? Center(
                                            child:
                                                CircularProgressIndicator.adaptive(),
                                          )
                                        : SelectableText(
                                            careerController
                                                        .careersList
                                                        .length <
                                                    10
                                                ? "0${careerController.careersList.length}"
                                                : "${careerController.careersList.length}",
                                            style: AppTextStyles.h3,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SelectableText(
                                    "Upcoming Jobs",
                                    style: AppTextStyles.h3.copyWith(
                                      color: Color(0xff98989A),
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  Obx(
                                    () =>
                                        careerController.isLoadingCareers.value
                                        ? Center(
                                            child:
                                                CircularProgressIndicator.adaptive(),
                                          )
                                        : SelectableText(
                                            careerController
                                                        .careersList
                                                        .length <
                                                    10
                                                ? "0${careerController.careersList.length}"
                                                : "${careerController.careersList.length}",
                                            style: AppTextStyles.h3,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30.w),
                              InkWell(
                                onTap: () {
                                  context.go('/careers');
                                },
                                child: Container(
                                  height: 63.w,
                                  width: 270.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 12.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff141414),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.kBorderColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Learn More",
                                      style: AppTextStyles.h3.copyWith(
                                        color: Color(0xff98989A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompanyVision extends StatefulWidget {
  const CompanyVision({super.key});

  @override
  State<CompanyVision> createState() => _CompanyVisionState();
}

class _CompanyVisionState extends State<CompanyVision> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_scrollController.hasClients) return;

      double maxScroll = _scrollController.position.maxScrollExtent;
      double current = _scrollController.offset;

      double next = current + 200; // scroll step

      if (next >= maxScroll) {
        next = 0; // restart from top
      }

      _scrollController.animateTo(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xxxl.w,

        bottom: AppSpacing.xxxl.w,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                DesktopCompanySections(
                  title: "Our Vision",
                  subTitle:
                      '''To redefine digital monetization by empowering publishers with intelligence, transparency, and control — creating a future where every impression is valued, every stream is optimized, and every publisher thrives independently. At The Germane Media, we believe the future of advertising belongs to those who own their value.  Our vision is to create an ecosystem where publishers are no longer at the mercy of opaque intermediaries, but instead lead with insight, autonomy, and technology built in their favor.''',
                ),
                SizedBox(height: 90.w),
                DesktopCompanySections(
                  title: "Our Mission",
                  subTitle:
                      '''To build the most trusted ecosystem for CTV, In-App, and Web monetization through data-driven technology, ethical practices, and relentless innovation — helping publishers unlock sustainable revenue and long-term growth, not just short-term yield.
                  We exist to make advertising smarter, cleaner, and more transparent. Our mission drives us to engineer solutions that simplify complexity, eliminate bias, and empower publishers to grow with confidence — one impression, one connection, one innovation at a time.''',
                ),
                SizedBox(height: 90.w),

                DesktopCompanySections(
                  title: "Our Story – The Germane\nJourney",
                  subTitle:
                      '''Germane Media was born from a simple observation: Publishers were rich in audience, but poor in control. While platforms and middlemen dictated value, publishers were left with opaque data, unstable yields, and limited visibility. We set out to change that.Founded by ad-tech specialists and programmatic engineers, The Germane Media was built on a singular belief — Monetization should be intelligent, independent, and fair. From our early days helping partners implement header bidding, to powering full-scale CTV, gaming, and OTT networks today, we’ve evolved into a strategic ally trusted by publishers worldwide. By blending data science, yield engineering, and programmatic strategy, we don’t just fill ad inventory —  we build monetization ecosystems designed for longevity and independence.Because this is more than advertising. This is Publisher Empowerment.''',
                ),

                SizedBox(height: 90.w),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment(-1.8, 0),
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 2,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: List.generate(12, (int index) {
                        return Column(
                          children: [
                            Image.asset(
                              "assets/temp/company$index.png",
                              width: 460.w,
                              height: 422.w,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(height: 22.h),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                Container(
                  width: 157.w,
                  height: 1799.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(157.w, 1799.w),
                    ),
                    color: AppColors.kBackgroundColor2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopCompanySections extends StatelessWidget {
  const DesktopCompanySections({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(title, style: AppTextStyles.h0, maxLines: 2),
        SizedBox(height: 20.w),
        SizedBox(
          width: 850.w,
          child: SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(
              fontSize: 22.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
        ),
      ],
    );
  }
}
