import 'package:flutter/material.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/monetization/data/monetization_detail_data.dart';
import 'package:tgm/modules/monetization/widgets/monetization_detail_view.dart';

/// Opens the monetization detail ([MonetizationDetailView]) as a modal
/// on top of the current screen. [initialIndex] selects the entry of
/// [kMonetizationDetails]; the in-modal arrows switch between entries
/// without closing.
Future<void> showMonetizationDetailDialog(
  BuildContext context, {
  required int initialIndex,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Monetization detail',
    // The view paints its own dimmed backdrop.
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, _, _) =>
        _MonetizationDetailDialog(initialIndex: initialIndex),
    transitionBuilder: (context, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );
}

class _MonetizationDetailDialog extends StatefulWidget {
  const _MonetizationDetailDialog({required this.initialIndex});

  final int initialIndex;

  @override
  State<_MonetizationDetailDialog> createState() =>
      _MonetizationDetailDialogState();
}

class _MonetizationDetailDialogState extends State<_MonetizationDetailDialog> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: MonetizationDetailView(
        index: _index,
        onClose: () => Navigator.of(context).pop(),
        onNavigate: (next) {
          setState(() => _index = next);
          trackPage(kMonetizationDetails[next].route);
        },
      ),
    );
  }
}
