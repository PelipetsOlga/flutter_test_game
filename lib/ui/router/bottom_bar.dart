import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../gradients.dart';
import '../widgets/svg_icon.dart';
import 'app_router.dart';

class NavigationItem {
  final IconData? icon;
  final String? svgAssetPath;
  final String label;
  final String route;

  NavigationItem({
    this.icon,
    this.svgAssetPath,
    required this.label,
    required this.route,
  }) : assert(icon != null || svgAssetPath != null,
            'Either icon or svgAssetPath must be provided');
}

class GameBottomBar extends StatelessWidget {
  const GameBottomBar({
    super.key,
    required List<NavigationItem> navigationItems,
  }) : _navigationItems = navigationItems;

  final List<NavigationItem> _navigationItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FigmaHelper.withOpacity(AppTheme.secondaryBlue, 55),
      ),
      child: SafeArea(
        child: Padding(
          padding: FigmaHelper.padding(context, 8, 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected =
                  GoRouterState.of(context).uri.path == item.route;

              return GestureDetector(
                onTap: () {
                  if (!isSelected) {
                    context.go(item.route);
                  }
                },
                child: Container(
                  width: FigmaHelper.containerSize(context, 130),
                  height: FigmaHelper.containerSize(context, 130),
                  decoration: BoxDecoration(
                    gradient: item.route == route_add_new_game
                        ? orangeVerticalGradient
                        : null,
                    color: item.route == route_add_new_game
                        ? null
                        : AppTheme.darkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: item.svgAssetPath != null
                        ? CustomSvgIcon(
                            assetPath: item.svgAssetPath!,
                            size: FigmaHelper.iconSize(context, 79),
                            color: item.route == route_add_new_game
                                ? AppTheme.white
                                : isSelected
                                    ? AppTheme.yellowAccent
                                    : AppTheme.white,
                            isSelected: isSelected,
                          )
                        : Icon(
                            item.icon,
                            color: item.route == route_add_new_game
                                ? AppTheme.white
                                : isSelected
                                    ? AppTheme.yellowAccent
                                    : AppTheme.white,
                            size: FigmaHelper.iconSize(context, 79),
                          ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
