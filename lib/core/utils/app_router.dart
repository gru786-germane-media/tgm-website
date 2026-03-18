import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/models/page_sections.dart';
import 'package:tgm/core/widgets/deferred_widget.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';
import 'package:tgm/shared/widgets/responsive_builder.dart';
import 'package:get/get.dart';

import 'package:tgm/modules/company/views/desktop_career.dart' deferred as desktopCareer;
import 'package:tgm/modules/company/views/desktop_company.dart' deferred as desktopCompany;
import 'package:tgm/modules/company/views/mobile_career.dart' deferred as mobileCareer;
import 'package:tgm/modules/company/views/mobile_company.dart' deferred as mobileCompany;
import 'package:tgm/modules/contactUs/views/desktop_contact_us.dart' deferred as desktopContactUs;
import 'package:tgm/modules/contactUs/views/mobile_contact_us.dart' deferred as mobileContactUs;
import 'package:tgm/modules/home/views/desktop_home.dart' deferred as desktopHome;
import 'package:tgm/modules/home/views/mobile_home.dart' deferred as mobileHome;
import 'package:tgm/modules/mediaHub/views/desktop_blogs.dart' deferred as desktopBlogs;
import 'package:tgm/modules/mediaHub/views/desktop_gallery.dart' deferred as desktopGallery;
import 'package:tgm/modules/mediaHub/views/desktop_media_hub.dart' deferred as desktopMediaHub;
import 'package:tgm/modules/mediaHub/views/desktop_newsroom.dart' deferred as desktopNewsroom;
import 'package:tgm/modules/mediaHub/views/desktop_particular_blog.dart' deferred as desktopParticularBlog;
import 'package:tgm/modules/mediaHub/views/desktop_particular_gallery.dart' deferred as desktopParticularGallery;
import 'package:tgm/modules/mediaHub/views/mobile_blogs.dart' deferred as mobileBlogs;
import 'package:tgm/modules/mediaHub/views/mobile_gallery.dart' deferred as mobileGallery;
import 'package:tgm/modules/mediaHub/views/mobile_media_hub.dart' deferred as mobileMediaHub;
import 'package:tgm/modules/mediaHub/views/mobile_newsroom.dart' deferred as mobileNewsroom;
import 'package:tgm/modules/mediaHub/views/mobile_particular_blog.dart' deferred as mobileParticularBlog;
import 'package:tgm/modules/mediaHub/views/mobile_particular_gallery.dart' deferred as mobileParticularGallery;
import 'package:tgm/modules/monetization/views/ctv_monetization/desktop_ctv_monetization.dart' deferred as desktopCtvMonetization;
import 'package:tgm/modules/monetization/views/ctv_monetization/mobile_ctv_monetization.dart' deferred as mobileCtvMonetization;
import 'package:tgm/modules/monetization/views/desktop_monetization.dart' deferred as desktopMonetization;
import 'package:tgm/modules/monetization/views/game_monetization/desktop_game_monetization.dart' deferred as desktopGameMonetization;
import 'package:tgm/modules/monetization/views/game_monetization/mobile_game_monetization.dart' deferred as mobileGameMonetization;
import 'package:tgm/modules/monetization/views/in_app_monetization/desktop_in_app_monetization.dart' deferred as desktopInAppMonetization;
import 'package:tgm/modules/monetization/views/in_app_monetization/mobile_in_app_monetization.dart' deferred as mobileInAppMonetization;
import 'package:tgm/modules/monetization/views/mobile_monetization.dart' deferred as mobileMonetization;
import 'package:tgm/modules/monetization/views/particular_case_study_desktop.dart' deferred as particularCaseStudyDesktop;
import 'package:tgm/modules/monetization/views/particular_case_study_mobile.dart' deferred as particularCaseStudyMobile;
import 'package:tgm/modules/monetization/views/web_monetization/desktop_web_monetization.dart' deferred as desktopWebMonetization;
import 'package:tgm/modules/monetization/views/web_monetization/mobile_web_monetization.dart' deferred as mobileWebMonetization;
import 'package:tgm/modules/others/views/privacy_policy.dart' deferred as privacyPolicy;
import 'package:tgm/modules/others/views/privacy_policy_mobile.dart' deferred as privacyPolicyMobile;
import 'package:tgm/modules/others/views/test.dart' deferred as testScreen;
import 'package:tgm/modules/solutions/views/desktop_solutions.dart' deferred as desktopSolutions;
import 'package:tgm/modules/solutions/views/mobile_solutions.dart' deferred as mobileSolutions;

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  observers: [_RouterObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final sectionName = state.uri.queryParameters['section'];

        HomePageSection? section;

        if (sectionName != null) {
          section = HomePageSection.values.firstWhere(
            (e) => e.name == sectionName,
            orElse: () => HomePageSection.home,
          );
        }

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            desktopHome.loadLibrary(),
            mobileHome.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: desktopHome.DesktopHome(section: section),
            tablet: desktopHome.DesktopHome(section: section),
            mobile: mobileHome.MobileHome(section: section),
          ),
        );
      },
    ),
    GoRoute(
      path: '/monetization',
      builder: (context, state) {
        final sectionName = state.uri.queryParameters['section'];

        MonetizationPageSection? section;

        if (sectionName != null) {
          section = MonetizationPageSection.values.firstWhere(
            (e) => e.name == sectionName,
            orElse: () => MonetizationPageSection.monetizationHome,
          );
        }

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            desktopMonetization.loadLibrary(),
            mobileMonetization.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: desktopMonetization.DesktopMonetization(section: section),
            tablet: desktopMonetization.DesktopMonetization(section: section),
            mobile: mobileMonetization.MobileMonetization(section: section),
          ),
        );
      },
    ),
    GoRoute(
      path: '/monetization/ctv',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopCtvMonetization.loadLibrary(),
          mobileCtvMonetization.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopCtvMonetization.DesktopCtvMonetization(),
          tablet: desktopCtvMonetization.DesktopCtvMonetization(),
          mobile: mobileCtvMonetization.MobileCtvMonetization(),
        ),
      ),
    ),
    GoRoute(
      path: '/monetization/game',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopGameMonetization.loadLibrary(),
          mobileGameMonetization.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopGameMonetization.DesktopGameMonetization(),
          tablet: desktopGameMonetization.DesktopGameMonetization(),
          mobile: mobileGameMonetization.MobileGameMonetization(),
        ),
      ),
    ),
    GoRoute(
      path: '/monetization/in-app',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopInAppMonetization.loadLibrary(),
          mobileInAppMonetization.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopInAppMonetization.DesktopInAppMonetization(),
          tablet: desktopInAppMonetization.DesktopInAppMonetization(),
          mobile: mobileInAppMonetization.MobileInAppMonetization(),
        ),
      ),
    ),
    GoRoute(
      path: '/monetization/web',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopWebMonetization.loadLibrary(),
          mobileWebMonetization.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopWebMonetization.DesktopWebMonetization(),
          tablet: desktopWebMonetization.DesktopWebMonetization(),
          mobile: mobileWebMonetization.MobileWebMonetization(),
        ),
      ),
    ),
    GoRoute(
      path: '/solutions',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopSolutions.loadLibrary(),
          mobileSolutions.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopSolutions.DesktopSolutions(),
          tablet: desktopSolutions.DesktopSolutions(),
          mobile: mobileSolutions.MobileSolutions(),
        ),
      ),
    ),
    GoRoute(
      path: '/media-hub',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopMediaHub.loadLibrary(),
          mobileMediaHub.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopMediaHub.DesktopMediaHub(),
          tablet: desktopMediaHub.DesktopMediaHub(),
          mobile: mobileMediaHub.MobileMediaHub(),
        ),
      ),
    ),
    GoRoute(
      path: '/company',
      builder: (context, state) {
        final sectionName = state.uri.queryParameters['section'];

        CompanyPageSection? section;

        if (sectionName != null) {
          section = CompanyPageSection.values.firstWhere(
            (e) => e.name == sectionName,
            orElse: () => CompanyPageSection.vision,
          );
        }

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            desktopCompany.loadLibrary(),
            mobileCompany.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: desktopCompany.DesktopCompany(section: section),
            tablet: desktopCompany.DesktopCompany(section: section),
            mobile: mobileCompany.MobileCompany(section: section),
          ),
        );
      },
    ),
    GoRoute(
      path: '/careers',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopCareer.loadLibrary(),
          mobileCareer.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopCareer.DesktopCareer(),
          tablet: desktopCareer.DesktopCareer(),
          mobile: mobileCareer.MobileCareer(),
        ),
      ),
    ),
    GoRoute(
      path: '/blogs',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopBlogs.loadLibrary(),
          mobileBlogs.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopBlogs.DesktopBlogs(),
          tablet: desktopBlogs.DesktopBlogs(),
          mobile: mobileBlogs.MobileBlogs(),
        ),
      ),
    ),
    GoRoute(
      path: '/newsroom',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopNewsroom.loadLibrary(),
          mobileNewsroom.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopNewsroom.DesktopNewsroom(),
          tablet: desktopNewsroom.DesktopNewsroom(),
          mobile: mobileNewsroom.MobileNewsroom(),
        ),
      ),
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopGallery.loadLibrary(),
          mobileGallery.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopGallery.DesktopGallery(),
          tablet: desktopGallery.DesktopGallery(),
          mobile: mobileGallery.MobileGallery(),
        ),
      ),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => testScreen.loadLibrary(),
        createWidget: () => ResponsiveBuilder(
          desktop: testScreen.Test(),
          tablet: testScreen.Test(),
          mobile: testScreen.Test(),
        ),
      ),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          privacyPolicy.loadLibrary(),
          privacyPolicyMobile.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: privacyPolicy.PrivacyPolicyScreen(),
          tablet: privacyPolicy.PrivacyPolicyScreen(),
          mobile: privacyPolicyMobile.PrivacyPolicyMobile(),
        ),
      ),
    ),
    GoRoute(
      path: '/blogs/:blogId',
      builder: (context, state) {
        final blogId = int.parse(state.pathParameters['blogId']!);

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            desktopParticularBlog.loadLibrary(),
            mobileParticularBlog.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: desktopParticularBlog.DesktopParticularBlog(blogId: blogId),
            tablet: desktopParticularBlog.DesktopParticularBlog(blogId: blogId),
            mobile: mobileParticularBlog.MobileParticularBlog(blogId: blogId),
          ),
        );
      },
    ),
    GoRoute(
      path: '/casestudy/:casestudyId',
      builder: (context, state) {
        final caseStudyId = int.parse(state.pathParameters['casestudyId']!);

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            particularCaseStudyDesktop.loadLibrary(),
            desktopParticularBlog.loadLibrary(),
            particularCaseStudyMobile.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: particularCaseStudyDesktop.ParticularCaseStudyDesktop(caseStudyId: caseStudyId,
            ),
            tablet: particularCaseStudyDesktop.ParticularCaseStudyDesktop(caseStudyId: caseStudyId,
            ),
            mobile: particularCaseStudyMobile.ParticularCaseStudyMobile(caseStudyId: caseStudyId,
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/gallery/:galleryId',
      builder: (context, state) {
        final galleryId = int.parse(state.pathParameters['galleryId']!);

        return DeferredWidget(
          libraryLoader: () => Future.wait([
            desktopParticularGallery.loadLibrary(),
            mobileParticularGallery.loadLibrary(),
          ]),
          createWidget: () => ResponsiveBuilder(
            desktop: desktopParticularGallery.DesktopParticularGallery(galleryId: galleryId),
            tablet: desktopParticularGallery.DesktopParticularGallery(galleryId: galleryId),
            mobile: mobileParticularGallery.MobileParticularGallery(galleryId: galleryId),
          ),
        );
      },
    ),
    GoRoute(
      path: '/contact-us',
      builder: (context, state) => DeferredWidget(
        libraryLoader: () => Future.wait([
          desktopContactUs.loadLibrary(),
          mobileContactUs.loadLibrary(),
        ]),
        createWidget: () => ResponsiveBuilder(
          desktop: desktopContactUs.DesktopContactUs(),
          tablet: desktopContactUs.DesktopContactUs(),
          mobile: mobileContactUs.MobileContactUs(),
        ),
      ),
    ),
  ],
);

class _RouterObserver extends NavigatorObserver {
  final headerController = Get.put(HeaderController());

  void _update(Route? route) {
    final location = route?.settings.name ?? '';
    headerController.updateIndexFromRoute(location);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _update(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _update(newRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _update(previousRoute);
  }
}
