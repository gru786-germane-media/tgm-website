import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/company/controllers/career_controller.dart';
import 'package:tgm/modules/company/model/career_info_model.dart';

class MobileCareer extends StatelessWidget {
  const MobileCareer({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerController careerController = Get.put(CareerController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/company');
            trackPage("/company");
          },
          child: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              IconUrls.kRightArrowIcon,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SelectableText.rich(
                    textAlign: TextAlign.center,

                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Job Listings",
                          style: AppTextStyles.h1.copyWith(fontSize: 28),
                        ),
                        TextSpan(
                          text: " at The Germane Media",

                          style: AppTextStyles.h1.copyWith(
                            color: AppColors.kTextColor1,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  SelectableText(
                    "Explore our current job listings to discover exciting career opportunities that match your skill set and interests. We offer positions in various digital disciplines, including web design, mobile app development, digital marketing, project management, and more. Each job listing provides comprehensive details about the role, responsibilities, qualifications, and benefits. Whether you are an experienced professional or a fresh graduate, we welcome talent from all backgrounds to join our team.",

                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor1,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 30),

                  Obx(
                    () => careerController.isLoadingCareers.value
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            itemCount: careerController.careersList.length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return JobCard(
                                currentCareer:
                                    careerController.careersList[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatefulWidget {
  const JobCard({super.key, required this.currentCareer});
  final CareerInfoModel currentCareer;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.kBorderColor),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                  gradient: LinearGradient(
                    colors: [Color(0xff1a1a1a), Color.fromARGB(0, 26, 26, 26)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 29,
                    width: 29,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff1a1a1a),
                          Color.fromARGB(0, 26, 26, 26),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconUrls.kCursorIcon,
                        height: 12.5,
                        width: 12.5,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      widget.currentCareer.title,
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                    ),
                    SelectableText(
                      widget.currentCareer.location,
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.kTextColor1,
                        fontSize: 16,
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  launchURL(widget.currentCareer.link);
                },
                child: Container(
                  height: 68,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Apply Now", style: AppTextStyles.h3Mobile),
                      SizedBox(width: 20),
                      Container(
                        height: 48,
                        width: 68,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.kSelectedButtonColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            IconUrls.kRightArrowIcon,
                            height: 28,
                            width: 28,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kSalaryIcon,
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10),
              SelectableText(
                "Salary - ${widget.currentCareer.salary}",
                style: AppTextStyles.h3.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kExpIcon,
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10),
              SelectableText(
                "Experience - ${widget.currentCareer.experience}",
                style: AppTextStyles.h3.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kStarsIcon,
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10),
              SelectableText(
                "Skills - ${widget.currentCareer.skills}",
                style: AppTextStyles.h3.copyWith(fontSize: 16),
              ),
            ],
          ),

          SizedBox(height: 20),

          Visibility(
            visible: !isCollapsed,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: AppColors.kBorderColor),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Job Description",
                    style: AppTextStyles.h3.copyWith(fontSize: 22),
                  ),
                  SizedBox(height: 10),

                  SelectableText(
                    widget.currentCareer.description,
                    style: AppTextStyles.h3Mobile.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(10.w),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: AppColors.kBorderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconUrls.kStatsIcon,
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SelectableText(
                            "Application Deadline: ${widget.currentCareer.applicationDeadline.toString().split(" ")[0]}",
                            style: AppTextStyles.h3Mobile.copyWith(
                              color: AppColors.kTextColor2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(visible: !isCollapsed, child: SizedBox(height: 20)),

          Visibility(
            visible: !isCollapsed,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1, color: AppColors.kBorderColor),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Responsibilities",
                    style: AppTextStyles.h3.copyWith(fontSize: 22),
                  ),
                  SizedBox(height: 14),

                  SelectableText(
                    widget.currentCareer.responsibilities,
                    style: AppTextStyles.h3Mobile.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(visible: !isCollapsed, child: SizedBox(height: 20)),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                child: Text(
                  isCollapsed ? "Show More" : "Show Less",
                  style: AppTextStyles.h3Mobile.copyWith(
                    color: AppColors.kTextColor1,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                child: Container(
                  height: 74,
                  width: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.kBorderColor,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff262626),
                        Color.fromARGB(0, 38, 38, 38),

                        Color.fromARGB(0, 38, 38, 38),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(1.0, isCollapsed ? -1.0 : 1.0),
                      child: SvgPicture.asset(
                        IconUrls.kCollapseIcon,
                        height: 28,
                        width: 28,

                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
