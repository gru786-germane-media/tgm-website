import 'package:flutter/material.dart';

class DeferredWidget extends StatefulWidget {
  final Future<void> Function() libraryLoader;
  final Widget Function() createWidget;
  final Widget placeholder;

  const DeferredWidget({
    Key? key,
    required this.libraryLoader,
    required this.createWidget,
    this.placeholder = const Center(child: CircularProgressIndicator()),
  }) : super(key: key);

  @override
  State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    widget.libraryLoader().then((_) {
      if (mounted) {
        setState(() {
          _loaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded) {
      return widget.createWidget();
    }
    return widget.placeholder;
  }
}
