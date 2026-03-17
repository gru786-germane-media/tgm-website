import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/modules/company/controllers/career_controller.dart';
import 'package:tgm/modules/company/model/career_info_model.dart';

class DesktopCareer extends StatelessWidget {
  const DesktopCareer({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerController careerController = Get.put(CareerController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      body: Stack(
        children: [
          Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 96.w),
            child: Column(
              children: [
                SelectableText.rich(
                  textAlign: TextAlign.center,

                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Job Listings",
                        style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
                      ),
                      TextSpan(
                        text: " at The Germane Media",

                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.kTextColor1,
                          fontSize: 48.spMin,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.w),
                SelectableText(
                  "Explore our current job listings to discover exciting career opportunities that match your skill set and interests. We offer positions in various digital disciplines, including web design, mobile app development, digital marketing, project management, and more. Each job listing provides comprehensive details about the role, responsibilities, qualifications, and benefits. Whether you are an experienced professional or a fresh graduate, we welcome talent from all backgrounds to join our team.",

                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.kTextColor1,
                  ),
                ),

                SizedBox(height: 80.w),

                Obx(
                  () => careerController.isLoadingCareers.value
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : Expanded(
                          child: ListView.builder(
                            itemCount: careerController.careersList.length,
                            itemBuilder: (context, index) {
                              return JobCard(
                                currentCareer:
                                    careerController.careersList[index],
                              );
                            },
                          ),
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
      padding: EdgeInsets.all(50.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.kBorderColor),
        borderRadius: BorderRadius.circular(20.r),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 96.w,
                width: 96.w,
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
                    height: 56.w,
                    width: 56.w,
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
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      widget.currentCareer.title,
                      style: AppTextStyles.h2,
                    ),
                    SelectableText(
                      widget.currentCareer.location,
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.kTextColor1,
                      ),
                    ),
                    //
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL(widget.currentCareer.link);
                },
                child: Container(
                  height: 68.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Apply Now", style: AppTextStyles.h3),
                      SizedBox(width: 20.w),
                      Container(
                        height: 48.w,
                        width: 68.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(135.r),
                          color: AppColors.kSelectedButtonColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            IconUrls.kRightArrowIcon,
                            height: 28.w,
                            width: 28.w,
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
          SizedBox(height: 50.w),

          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kSalaryIcon,
                height: 28.w,
                width: 28.w,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10.w),
              SelectableText(
                "Salary - ${widget.currentCareer.salary}",
                style: AppTextStyles.h3,
              ),
            ],
          ),
          SizedBox(height: 24.w),

          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kExpIcon,
                height: 28.w,
                width: 28.w,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10.w),
              SelectableText(
                "Experience - ${widget.currentCareer.experience}",
                style: AppTextStyles.h3,
              ),
            ],
          ),
          SizedBox(height: 24.w),
          Row(
            children: [
              SvgPicture.asset(
                IconUrls.kStarsIcon,
                height: 28.w,
                width: 28.w,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10.w),
              SelectableText(
                "Skills - ${widget.currentCareer.skills}",
                style: AppTextStyles.h3,
              ),
            ],
          ),

          SizedBox(height: 50.w),

          Visibility(
            visible: !isCollapsed,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(50.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1, color: AppColors.kBorderColor),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Job Description",
                    style: AppTextStyles.h3.copyWith(fontSize: 22.spMin),
                  ),
                  SizedBox(height: 14.w),

                  SelectableText(
                    widget.currentCareer.description,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),

                  SizedBox(height: 30.w),

                  Container(
                    padding: EdgeInsets.all(10.w),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
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
                          height: 28.w,
                          width: 28.w,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 10.w),
                        SelectableText(
                          "Application Deadline: ${widget.currentCareer.applicationDeadline.toString().split(" ")[0]}",
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.kTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: !isCollapsed,
            child: SizedBox(height: 50.w),
          ),

          Visibility(
            visible: !isCollapsed,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(50.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1, color: AppColors.kBorderColor),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Responsibilities",
                    style: AppTextStyles.h3.copyWith(fontSize: 22.spMin),
                  ),
                  SizedBox(height: 14.w),

                  SelectableText(
                    widget.currentCareer.responsibilities,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: !isCollapsed,
            child: SizedBox(height: 50.w),
          ),

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
                  style: AppTextStyles.h3.copyWith(
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
                  height: 74.w,
                  width: 74.w,
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
                        height: 28.w,
                        width: 28.w,

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
