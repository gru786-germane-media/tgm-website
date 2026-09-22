import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/utils/utility_methods.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/core/widgets/circle_arrow_button.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/company/controllers/career_controller.dart';
import 'package:tgm/modules/company/controllers/company_controller.dart';
import 'package:tgm/modules/company/controllers/people_controller.dart';
import 'package:tgm/modules/company/widgets/bottom_loop_text.dart';
import 'package:tgm/modules/company/widgets/company_principles_fan.dart';
import 'package:tgm/modules/contactUs/views/desktop_contact_us.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';

class DesktopCompany extends StatefulWidget {
  const DesktopCompany({super.key, required this.section, this.empQuery});
  final CompanyPageSection? section;
  final String? empQuery;

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

    final context = targetKey.currentContext;

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
                SizedBox(height: 30.w),

                CompanyVision(key: _visionKey),
                SizedBox(height: 30.w),

                ComanyCareer(key: _careerKey),
                SizedBox(height: 50.w),

                CompanyPeople(key: _peopleKey, empQuery: widget.empQuery),

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

          Positioned(right: 50, bottom: 130, child: StickyBookCallButton()),
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
        Image.asset(
          ImageUrls.kBackgroundTextureBig,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Empowering Publishers.\nRedefining Monetization.",
              textAlign: TextAlign.center,
              style: AppTextStyles.h0,
            ),

            SizedBox(height: 60.w),

            CompanyPrinciplesFan(),
          ],
        ),
      ],
    );
  }
}

class CompanyPeople extends StatefulWidget {
  const CompanyPeople({super.key, this.empQuery});
  final String? empQuery;

  @override
  State<CompanyPeople> createState() => _CompanyPeopleState();
}

class _CompanyPeopleState extends State<CompanyPeople> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  ScrollPosition? _ambientScrollPosition;
  bool _autoScrollStarted = false;
  bool _paused = false;
  int _itemCount = 0;

  // card width (380) + horizontal margin (20 each side)
  double get _cardExtent => 420.w;
  double get _loopWidth => _itemCount * _cardExtent;

  @override
  void initState() {
    super.initState();
    // Don't auto-scroll until the user has actually scrolled this section
    // into view — start listening to the page scroll and check visibility.
    WidgetsBinding.instance.addPostFrameCallback((_) => _watchForVisibility());
  }

  void _watchForVisibility() {
    if (!mounted) return;
    _ambientScrollPosition = Scrollable.maybeOf(context)?.position;
    _ambientScrollPosition?.addListener(_maybeStartAutoScroll);
    _maybeStartAutoScroll(); // in case it's already in view (e.g. deep link)
  }

  void _maybeStartAutoScroll() {
    if (_autoScrollStarted || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox ||
        !renderObject.attached ||
        !renderObject.hasSize) {
      return;
    }

    final top = renderObject.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;
    final isVisible =
        top < screenHeight && (top + renderObject.size.height) > 0;
    if (!isVisible) return;

    _autoScrollStarted = true;
    _ambientScrollPosition?.removeListener(_maybeStartAutoScroll);
    _autoScrollTimer = Timer.periodic(
      const Duration(milliseconds: 16),
      (_) => _tick(),
    );
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _ambientScrollPosition?.removeListener(_maybeStartAutoScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _tick() {
    if (_paused || !_scrollController.hasClients || _itemCount == 0) return;
    final viewport = _scrollController.position.viewportDimension;
    if (_loopWidth <= viewport) return; // not enough cards to scroll

    double next = _scrollController.offset + 0.7;
    if (next >= _loopWidth) next -= _loopWidth;
    _scrollController.jumpTo(next);
  }

  void _nudge(int direction) {
    if (!_scrollController.hasClients) return;
    final target = (_scrollController.offset + direction * _cardExtent).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

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

        Obx(() {
          if (peopleController.isLoadingPeople.value) {
            return Center(child: AppLoader());
          }

          final displayList = reorderForDeepLink(
            items: peopleController.peopleList,
            query: widget.empQuery,
            nameOf: (p) => p.name ?? "",
          );
          _itemCount = displayList.length;
          // Duplicate the strip so the auto-scroll can loop seamlessly, but
          // only when there are enough cards to actually overflow.
          final loopable = displayList.length >= 4;

          return MouseRegion(
            onEnter: (_) => _paused = true,
            onExit: (_) => _paused = false,
            child: SizedBox(
              height: 560.w,
              child: Row(
                children: [
                  if (loopable)
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 8.w),
                      child: CircleArrowButton(
                        direction: ArrowDirection.left,
                        onTap: () => _nudge(-1),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: loopable
                          ? displayList.length * 2
                          : displayList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, rawIndex) {
                        final index = rawIndex % displayList.length;
                        final people = displayList[index];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 380.w,
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: AppColors.kCardColor3,
                              borderRadius: BorderRadius.circular(28.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.kBorderColor,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppCachedImage(
                                  height: 360.w,
                                  width: 352.w,
                                  imageUrl: people.imageUrl ?? "",
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(18.r),
                                  semanticLabel: formatName(people.name),
                                ),
                                SizedBox(height: 20.w),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectableText(
                                        formatName(people.name),
                                        maxLines: 2,
                                        style: AppTextStyles.h1.copyWith(
                                          fontSize: 28.spMin,
                                        ),
                                      ),
                                      SizedBox(height: 6.w),
                                      SelectableText(
                                        people.position ?? "No data",
                                        style: AppTextStyles.h3.copyWith(
                                          fontSize: 18.spMin,
                                          color: AppColors.kTextColor2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 14.w),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (loopable)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 16.w),
                      child: CircleArrowButton(
                        direction: ArrowDirection.right,
                        onTap: () => _nudge(1),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
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
        Column(
          children: [
            Image.asset(
              ImageUrls.kBackgroundTextureBig,
              fit: BoxFit.cover,
              width: double.maxFinite,
              excludeFromSemantics: true,
            ),
            Image.asset(
              ImageUrls.kBackgroundTextureBig,
              fit: BoxFit.cover,
              width: double.maxFinite,
              excludeFromSemantics: true,
            ),

            Image.asset(
              ImageUrls.kBackgroundTextureBig,
              fit: BoxFit.cover,
              width: double.maxFinite,
              excludeFromSemantics: true,
            ),
          ],
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
                  border: Border.all(width: 0.5, color: Color(0xff666666)),
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
                            maxLength: 50,
                            controller:
                                companyController.nameTextEditingController,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Expanded(
                          child: ContactFormFields(
                            title: "Email",
                            helpText: "Enter Your Email",
                            maxLength: 50,
                            controller:
                                companyController.emailTextEditingController,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Expanded(
                          child: ContactFormFields(
                            title: "Phone Number",
                            helpText: "Enter Your Phone Number",
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            maxLength: 15,
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
                            maxLength: 200,
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
                              ? Center(child: AppLoader())
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
                                          excludeFromSemantics: true,
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
        border: Border.all(width: 1, color: AppColors.kBorderColor),
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Color.fromARGB(0, 26, 26, 26),
        //     Color.fromARGB(128, 26, 26, 26),
        //     Color(0xff1a1a1a),
        //   ],
        // ),
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
                    semanticsLabel: "$title icon",
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
              Image.asset(
                ImageUrls.kBackgroundTextureBig,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
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
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h1.copyWith(
                              fontSize: 36.spMin,
                            ),
                          ),
                          SizedBox(height: 30.w),
                          SelectableText(
                            "At The Germane Media, we believe every conversation is an opportunity to unlock value, build transparency, and drive growth. Reach out to us, and one of our experts will guide you through our solutions, insights, or partnership opportunities.",
                            
                            textAlign: TextAlign.center,
                            
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.kTextColor2,
                            ),
                          ),
                          SizedBox(height: 50.w),

                          _ContactActionButton(
                            label: "Contact Us",
                            onTap: () {
                              context.go('/contact-us');
                              trackPage("/contact-us");
                            },
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
                        semanticLabel: "Get in touch with The Germane Media",
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
              Image.asset(
                ImageUrls.kBackgroundTextureBig,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
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
                        semanticLabel: "Careers at The Germane Media",
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
                            textAlign: TextAlign.center,
                           
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
                                        ? Center(child: AppLoader())
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
                                        ? Center(child: AppLoader())
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
                              _ContactActionButton(
                                label: "Learn More",
                                onTap: () {
                                  context.go('/careers');
                                  trackPage("/careers");
                                },
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          ImageUrls.kBackgroundTextureBig,
          fit: BoxFit.cover,
          width: double.maxFinite,
          excludeFromSemantics: true,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xxxl.w,

            bottom: AppSpacing.xxxl.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DesktopCompanySections(
                      title: "Our Vision",
                      subTitle:
                          '''To redefine digital monetization by empowering publishers with intelligence, transparency, and control — creating a future where every impression is valued, every stream is optimized, and every publisher thrives independently. At The Germane Media, we believe the future of advertising belongs to those who own their value.  Our vision is to create an ecosystem where publishers are no longer at the mercy of opaque intermediaries, but instead lead with insight, autonomy, and technology built in their favor.''',
                    ),
                    SizedBox(height: 50.w),
                    DesktopCompanySections(
                      title: "Our Mission",
                      subTitle:
                          '''To build the most trusted ecosystem for CTV, In-App, and Web monetization through data-driven technology, ethical practices, and relentless innovation — helping publishers unlock sustainable revenue and long-term growth, not just short-term yield.
                  We exist to make advertising smarter, cleaner, and more transparent. Our mission drives us to engineer solutions that simplify complexity, eliminate bias, and empower publishers to grow with confidence — one impression, one connection, one innovation at a time.''',
                    ),
                    SizedBox(height: 50.w),

                    DesktopCompanySections(
                      title: "Our Story – The Germane\nJourney",
                      subTitle:
                          '''Germane Media was born from a simple observation: Publishers were rich in audience, but poor in control. While platforms and middlemen dictated value, publishers were left with opaque data, unstable yields, and limited visibility. We set out to change that.Founded by ad-tech specialists and programmatic engineers, The Germane Media was built on a singular belief — Monetization should be intelligent, independent, and fair. From our early days helping partners implement header bidding, to powering full-scale CTV, gaming, and OTT networks today, we’ve evolved into a strategic ally trusted by publishers worldwide. By blending data science, yield engineering, and programmatic strategy, we don’t just fill ad inventory —  we build monetization ecosystems designed for longevity and independence.Because this is more than advertising. This is Publisher Empowerment.''',
                    ),

                    SizedBox(height: 50.w),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment(-1.8, 0),
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 1.2,
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
                                  semanticLabel:
                                      "Life at The Germane Media, photo ${index + 1}",
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
                      height: MediaQuery.sizeOf(context).height * 1.25,
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
        ),
      ],
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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 75.w),
          child: SelectableText(title, style: AppTextStyles.h0, maxLines: 2),
        ),
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 75.w),
          child: SelectableText(
            subTitle,
            textAlign: TextAlign.start,
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

/// Outlined pill button that fills white (with dark text) on hover.
class _ContactActionButton extends StatefulWidget {
  const _ContactActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_ContactActionButton> createState() => _ContactActionButtonState();
}

class _ContactActionButtonState extends State<_ContactActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 63.w,
          width: 270.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.whiteColor : Color(0xff141414),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1, color: AppColors.kBorderColor),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: AppTextStyles.h3.copyWith(
                color: _isHovered
                    ? AppColors.kBackgroundColor2
                    : Color(0xff98989A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
