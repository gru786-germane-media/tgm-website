import 'package:flutter/material.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class BottomLoopTextMobile extends StatefulWidget {
  const BottomLoopTextMobile({super.key});

  @override
  State<BottomLoopTextMobile> createState() => _BottomLoopTextMobileState();
}

class _BottomLoopTextMobileState extends State<BottomLoopTextMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;

  final String text =
      "Our principles drive innovation, transparency, and independence in everything we do.";

  final double spacing = 75;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..addListener(() {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(_controller.value * 1000);
            }
          });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(
                text,
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w400, fontSize: 13.57),
                softWrap: false,
              ),
              SizedBox(width: spacing),
            ],
          );
        },
      ),
    );
  }
}
