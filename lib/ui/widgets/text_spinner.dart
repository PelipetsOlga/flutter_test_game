import 'package:flutter/material.dart';
import 'package:flutter_test_game/ui/widgets/svg_icon.dart';
import '../app_theme.dart';
import '../gradients.dart';
import '../styles.dart';

class TextSpinner extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String) onChanged;
  final double? width;
  final double? height;

  const TextSpinner({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.width,
    this.height,
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
    _selectedValue = widget.selectedValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Collapsed view - clickable spinner
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width:  double.infinity,
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
                      _selectedValue ?? '',
                      style: AppTypography.spinnerTitle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomSvgIcon(
                    assetPath: 'assets/icons/triangle_arrow_down.svg',
                    size: FigmaHelper.iconSize(context, 29),
                    color:  AppTheme.white,
                    isSelected: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Expanded dropdown list
        if (_isExpanded)
          Container(
            width: widget.width ?? double.infinity,
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
                      color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
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