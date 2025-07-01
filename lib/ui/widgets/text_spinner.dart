import 'package:flutter/material.dart';
import 'package:flutter_test_game/ui/widgets/svg_icon.dart';

import '../app_theme.dart';
import '../gradients.dart';
import '../styles.dart';

class TextSpinner extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String) onChanged;

  const TextSpinner({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  State<TextSpinner> createState() => _TextSpinnerState();
}

class _TextSpinnerState extends State<TextSpinner> {
  bool _isExpanded = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(TextSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      setState(() {
        _selectedValue = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return meaninglessSpinner();
    } else {
      return meaningfullSpinner();
    }
  }

  Widget arrowDown(BuildContext context) => CustomSvgIcon(
        assetPath: 'assets/icons/triangle_arrow_down.svg',
        size: FigmaHelper.iconSize(context, 29),
        color: AppTheme.white,
        isSelected: true,
      );

  Widget meaninglessSpinner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: spinnerGradient,
        borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: FigmaHelper.px(context, 34),
          vertical: FigmaHelper.px(context, 45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Select...',
                style: AppTypography.spinnerTitle(context),
              ),
            ),
            arrowDown(context),
          ],
        ),
      ),
    );
  }

  Widget meaningfullSpinner() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: spinnerGradient,
              borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FigmaHelper.px(context, 45),
                vertical: FigmaHelper.px(context, 34),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _selectedValue ?? 'Select...',
                      style: AppTypography.spinnerTitle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  arrowDown(context),
                ],
              ),
            ),
          ),
        ),

        // Expanded dropdown list
        if (_isExpanded)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: FigmaHelper.px(context, 8)),
            decoration: BoxDecoration(
              gradient: spinnerGradient,
              borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
            ),
            child: Column(
              children: widget.items.map((item) {
                final isSelected = item == _selectedValue;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedValue = item;
                      _isExpanded = false;
                    });
                    widget.onChanged(item);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: FigmaHelper.px(context, 20),
                      vertical: FigmaHelper.px(context, 15),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 22)),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                        fontSize: FigmaHelper.px(context, 52),
                        height: 1.0,
                        letterSpacing: -0.02,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
