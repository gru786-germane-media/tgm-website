import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/utils/utility_methods.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/company/controllers/career_controller.dart';
import 'package:tgm/modules/company/controllers/company_controller.dart';
import 'package:tgm/modules/company/controllers/people_controller.dart';
import 'package:tgm/modules/company/widgets/bottom_loop_text_mobile.dart';
import 'package:tgm/modules/company/widgets/circular_carousel_company_mobile.dart';
import 'package:tgm/modules/contactUs/views/mobile_contact_us.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';

class MobileCompany extends StatefulWidget {
  const MobileCompany({super.key, required this.section});
  final CompanyPageSection? section;

  @override
  State<MobileCompany> createState() => _MobileCompanyState();
}

class _MobileCompanyState extends State<MobileCompany> {
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
  void didUpdateWidget(MobileCompany oldWidget) {
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
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                CompanySection(),
                const SizedBox(height: 30),

                CompanyVision(key: _visionKey),
                const SizedBox(height: 30),

                ComanyCareer(key: _careerKey),
                const SizedBox(height: 30),

                CompanyPeople(key: _peopleKey),

                const SizedBox(height: 30),

                CompanyFeedback(key: _feedbackKey),
                const SizedBox(height: 30),
                MobileFooter(),
                const SizedBox(height: 50),
              ],
            ),
          ),

          Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Color(0xff2a2828),
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.kBorderColor),
                top: BorderSide(width: 1, color: AppColors.kBorderColor),
              ),
            ),
            child: BottomLoopTextMobile(),
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
              style: AppTextStyles.h0.copyWith(fontSize: 28),
            ),

            const SizedBox(height: 20),

            CircularCarouselCompanyMobile(),
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

          style: AppTextStyles.h0.copyWith(fontSize: 32),
        ),
        SizedBox(height: 14),
        SelectableText(
          '''Every product we build, every solution we implement, and every strategy we design is shaped by the expertise, passion, and insight of our team members.
Together, we’re more than a company — we’re a community of innovators shaping the future of digital advertising.''',

          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.kTextColor2,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 30),

        Obx(
          () => peopleController.isLoadingPeople.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : SizedBox(
                  height: 225,
                  child: ListView.builder(
                    itemCount: peopleController.peopleList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final people = peopleController.peopleList[index];
                      // ClipPath
                      //clipper: PeopleCardClipper(flip: index % 2 == 0),
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: 144,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppCachedImage(
                              height: 121,
                              width: 144,
                              imageUrl: people.imageUrl ?? "",
                              fit: BoxFit.fitWidth,
                            ),

                            Container(
                              width: 144,
                              height: 84,
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 10,
                                left: 10,
                              ),
                              color: Color(0xff2a2a2a),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SelectableText(
                                          // people.name ?? "No name",
                                          formatName(people.name),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.h1.copyWith(
                                            fontSize: 13.71,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SelectableText(
                                          people.position ?? "No data",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.h3.copyWith(
                                            fontSize: 8,
                                            color: AppColors.kTextColor2,
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
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                "We Value Your Feedback",
                textAlign: TextAlign.center,

                style: AppTextStyles.h2.copyWith(fontSize: 28),
              ),
              SizedBox(height: 14),
              SelectableText(
                "Please fill out the form below — it only takes a few moments, and your input is highly appreciated.",

                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.kTextColor2,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.kContainerColor.withAlpha(80),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactFormFieldsMobile(
                      title: "Name",
                      helpText: "Enter Your Name",
                      controller: companyController.nameTextEditingController,
                    ),
                    SizedBox(height: 20),
                    ContactFormFieldsMobile(
                      title: "Email",
                      helpText: "Enter Your Email",
                      controller: companyController.emailTextEditingController,
                    ),
                    SizedBox(width: 20),
                    ContactFormFieldsMobile(
                      title: "Phone Number",
                      helpText: "Enter Your Phone Number",
                      controller: companyController.nameTextEditingController,
                    ),
                    SizedBox(height: 20),
                    ContactFormFieldsMobile(
                      title: "Message",
                      helpText: "Enter Your Message",
                      maxLines: 4,
                      height: 153,
                      borderRadius: 20,
                      controller:
                          companyController.messageTextEditingController,
                    ),
                    SizedBox(height: 20),
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
                                    height: 64,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(74),
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
                                          style: AppTextStyles.h3Mobile,
                                        ),
                                        SizedBox(width: 6),
                                        SvgPicture.asset(
                                          IconUrls.kRightArrowIcon,
                                          width: 28,
                                          height: 28,
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

              SizedBox(height: 30),

              FeedbackCards(
                iconUrl: IconUrls.kClockFilledIcon,
                title: "Our Response",
                subTitle:
                    "We understand the importance of timely responses, and our team is committed to addressing your inquiries promptly. Whether you have a specific project in mind, need advice on digital strategies, or want to explore partnership opportunities, we are here to assist you at every step.",
              ),

              SizedBox(height: 20),

              FeedbackCards(
                iconUrl: IconUrls.kShieldIcon,
                title: "Privacy Assurance",
                subTitle:
                    "At Germane Media, we prioritize your privacy and protect your personal information in compliance with data protection regulations. Rest assured that your details will only be used for the purpose of addressing your inquiries and will not be shared with third parties without your consent",
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
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
                height: 74,
                width: 74,
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
                    height: 34,
                    width: 34,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(width: 12),
              SelectableText(
                title,
                style: AppTextStyles.h2.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 16,
            ),
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
        Stack(
          children: [
            Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.asset(
                    "assets/temp/careerImage1.png",
                    height: 200,
                    width: double.maxFinite,
                    fit: BoxFit.scaleDown,
                  ),
                ),

                SizedBox(width: 30),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: SelectableText(
                    "Get In Touch With Us Today",
                    style: AppTextStyles.h1.copyWith(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: SelectableText(
                    "At The Germane Media, we believe every conversation is an opportunity to unlock value, build transparency, and drive growth. Reach out to us, and one of our experts will guide you through our solutions, insights, or partnership opportunities.",
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor2,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                InkWell(
                  onTap: () {
                    context.go('/contact-us');
                    trackPage("/contact-us");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    margin: EdgeInsetsGeometry.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color(0xff141414),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: AppColors.kBorderColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Contact Us",
                        style: AppTextStyles.h3Mobile.copyWith(
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

        const SizedBox(height: 20),
        Stack(
          children: [
            Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.asset(
                    "assets/temp/careerImage2.png",
                    height: 177,
                    width: double.maxFinite,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: SelectableText(
                        "Career at The Germane Media",
                        style: AppTextStyles.h1.copyWith(fontSize: 32),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: SelectableText(
                        "Explore our current job listings to discover exciting career opportunities that match your skill set and interests. We offer positions in various digital disciplines, including web design, mobile app development, digital marketing, project management, and more. Each job listing provides comprehensive details about the role, responsibilities, qualifications, and benefits. Whether you are an experienced professional or a fresh graduate, we welcome talent from all backgrounds to join our team.",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.kTextColor2,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Open Jobs",
                                style: AppTextStyles.h3.copyWith(
                                  color: Color(0xff98989A),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Obx(
                                () => careerController.isLoadingCareers.value
                                    ? Center(
                                        child:
                                            CircularProgressIndicator.adaptive(),
                                      )
                                    : SelectableText(
                                        careerController.careersList.length < 10
                                            ? "0${careerController.careersList.length}"
                                            : "${careerController.careersList.length}",
                                        style: AppTextStyles.h3.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SelectableText(
                                "Upcoming Jobs",
                                style: AppTextStyles.h3.copyWith(
                                  color: Color(0xff98989A),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Obx(
                                () => careerController.isLoadingCareers.value
                                    ? Center(
                                        child:
                                            CircularProgressIndicator.adaptive(),
                                      )
                                    : SelectableText(
                                        careerController.careersList.length < 10
                                            ? "0${careerController.careersList.length}"
                                            : "${careerController.careersList.length}",
                                        style: AppTextStyles.h3.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 20),
                      ],
                    ),

                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        context.go('/careers');
                        trackPage("/careers");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        margin: EdgeInsetsGeometry.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xff141414),
                          borderRadius: BorderRadius.circular(12),
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_scrollController.hasClients) return;

      double maxScroll = _scrollController.position.maxScrollExtent;
      double current = _scrollController.offset;

      double next = current + 100; // scroll step

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment(0, 1.5),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(11, (int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Image.asset(
                        "assets/temp/company$index.png",
                        width: MediaQuery.sizeOf(context).width * 0.23,

                        fit: BoxFit.scaleDown,
                      ),
                    );
                  }),
                ),
              ),
              ClipOval(
                child: Container(
                  width: double.infinity,
                  height: 30,
                  color: AppColors.kBackgroundColor2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          MobileCompanySection(
            title: "Our Vision",
            subTitle:
                '''To redefine digital monetization by empowering publishers with intelligence, transparency, and control — creating a future where every impression is valued, every stream is optimized, and every publisher thrives independently. At The Germane Media, we believe the future of advertising belongs to those who own their value.  Our vision is to create an ecosystem where publishers are no longer at the mercy of opaque intermediaries, but instead lead with insight, autonomy, and technology built in their favor.''',
          ),
          const SizedBox(height: 30),
          MobileCompanySection(
            title: "Our Mission",
            subTitle:
                '''To build the most trusted ecosystem for CTV, In-App, and Web monetization through data-driven technology, ethical practices, and relentless innovation — helping publishers unlock sustainable revenue and long-term growth, not just short-term yield.
                  We exist to make advertising smarter, cleaner, and more transparent. Our mission drives us to engineer solutions that simplify complexity, eliminate bias, and empower publishers to grow with confidence — one impression, one connection, one innovation at a time.''',
          ),
          const SizedBox(height: 30),

          MobileCompanySection(
            title: "Our Story – The Germane\nJourney",
            subTitle:
                '''Germane Media was born from a simple observation: Publishers were rich in audience, but poor in control. While platforms and middlemen dictated value, publishers were left with opaque data, unstable yields, and limited visibility. We set out to change that.Founded by ad-tech specialists and programmatic engineers, The Germane Media was built on a singular belief — Monetization should be intelligent, independent, and fair. From our early days helping partners implement header bidding, to powering full-scale CTV, gaming, and OTT networks today, we’ve evolved into a strategic ally trusted by publishers worldwide. By blending data science, yield engineering, and programmatic strategy, we don’t just fill ad inventory —  we build monetization ecosystems designed for longevity and independence.Because this is more than advertising. This is Publisher Empowerment.''',
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class MobileCompanySection extends StatelessWidget {
  const MobileCompanySection({
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
        SelectableText(
          title,
          style: AppTextStyles.h0.copyWith(fontSize: 32),
          maxLines: 2,
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
          child: SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor2,
            ),
          ),
        ),
      ],
    );
  }
}
