import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/assets.dart';

class Toggle extends StatelessWidget {
  const Toggle({
    super.key,
    required this.icon,
    required this.value,
    this.onTap,
  });

  final SvgIconData icon;
  final bool value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color = value ? AppColors.white1 : AppColors.white3;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color.withAlpha(50),
        padding: EdgeInsets.all(4),
        child: SvgIcon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
