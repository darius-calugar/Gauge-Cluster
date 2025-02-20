import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gauge_cluster/utils/assets.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.icon, {super.key, this.size = 24, this.color});

  final SvgIconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    final color = this.color ?? iconTheme.color;

    return SvgPicture.asset(
      icon.path,
      height: size,
      width: size,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}
