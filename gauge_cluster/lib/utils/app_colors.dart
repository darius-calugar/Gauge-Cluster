import 'package:flutter/painting.dart';

class ColorPack {
  final Color $1;
  final Color $2;
  final Color $3;
  final Color $4;
  final Color $5;
  final Color $6;
  final Color $7;
  final Color $8;
  final Color $9;

  const ColorPack(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
    this.$6,
    this.$7,
    this.$8,
    this.$9,
  );

  List<Color> get values => [$1, $2, $3, $4, $5, $6, $7, $8, $9];
}

abstract final class AppColors {
  static final black = ColorPack(
    HSLColor.fromAHSL(1, 0, 0, .000).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .025).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .050).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .075).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .100).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .125).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .150).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .175).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .200).toColor(),
  );

  static final white = ColorPack(
    HSLColor.fromAHSL(1, 0, 0, 1.00).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .950).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .900).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .850).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .800).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .750).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .700).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .650).toColor(),
    HSLColor.fromAHSL(1, 0, 0, .600).toColor(),
  );

  static final _red = HSLColor.fromAHSL(1, 0, .8, .5);
  static final red = _red.toColor();
  static final lightRed = ColorPack(
    _red.withLightness(.55).toColor(),
    _red.withLightness(.60).toColor(),
    _red.withLightness(.65).toColor(),
    _red.withLightness(.70).toColor(),
    _red.withLightness(.75).toColor(),
    _red.withLightness(.80).toColor(),
    _red.withLightness(.85).toColor(),
    _red.withLightness(.90).toColor(),
    _red.withLightness(.95).toColor(),
  );
  static final darkRed = ColorPack(
    _red.withLightness(.45).toColor(),
    _red.withLightness(.40).toColor(),
    _red.withLightness(.35).toColor(),
    _red.withLightness(.30).toColor(),
    _red.withLightness(.25).toColor(),
    _red.withLightness(.20).toColor(),
    _red.withLightness(.15).toColor(),
    _red.withLightness(.10).toColor(),
    _red.withLightness(.05).toColor(),
  );

  static final _orange = HSLColor.fromAHSL(1, 30, .8, .5);
  static final orange = _orange.toColor();
  static final lightOrange = ColorPack(
    _orange.withLightness(.55).toColor(),
    _orange.withLightness(.60).toColor(),
    _orange.withLightness(.65).toColor(),
    _orange.withLightness(.70).toColor(),
    _orange.withLightness(.75).toColor(),
    _orange.withLightness(.80).toColor(),
    _orange.withLightness(.85).toColor(),
    _orange.withLightness(.90).toColor(),
    _orange.withLightness(.95).toColor(),
  );
  static final darkOrange = ColorPack(
    _orange.withLightness(.45).toColor(),
    _orange.withLightness(.40).toColor(),
    _orange.withLightness(.35).toColor(),
    _orange.withLightness(.30).toColor(),
    _orange.withLightness(.25).toColor(),
    _orange.withLightness(.20).toColor(),
    _orange.withLightness(.15).toColor(),
    _orange.withLightness(.10).toColor(),
    _orange.withLightness(.05).toColor(),
  );

  static final _yellow = HSLColor.fromAHSL(1, 60, .8, .5);
  static final yellow = _yellow.toColor();
  static final lightYellow = ColorPack(
    _yellow.withLightness(.55).toColor(),
    _yellow.withLightness(.60).toColor(),
    _yellow.withLightness(.65).toColor(),
    _yellow.withLightness(.70).toColor(),
    _yellow.withLightness(.75).toColor(),
    _yellow.withLightness(.80).toColor(),
    _yellow.withLightness(.85).toColor(),
    _yellow.withLightness(.90).toColor(),
    _yellow.withLightness(.95).toColor(),
  );
  static final darkYellow = ColorPack(
    _yellow.withLightness(.45).toColor(),
    _yellow.withLightness(.40).toColor(),
    _yellow.withLightness(.35).toColor(),
    _yellow.withLightness(.30).toColor(),
    _yellow.withLightness(.25).toColor(),
    _yellow.withLightness(.20).toColor(),
    _yellow.withLightness(.15).toColor(),
    _yellow.withLightness(.10).toColor(),
    _yellow.withLightness(.05).toColor(),
  );

  static final _green = HSLColor.fromAHSL(1, 120, .8, .5);
  static final green = _green.toColor();
  static final lightGreen = ColorPack(
    _green.withLightness(.55).toColor(),
    _green.withLightness(.60).toColor(),
    _green.withLightness(.65).toColor(),
    _green.withLightness(.70).toColor(),
    _green.withLightness(.75).toColor(),
    _green.withLightness(.80).toColor(),
    _green.withLightness(.85).toColor(),
    _green.withLightness(.90).toColor(),
    _green.withLightness(.95).toColor(),
  );
  static final darkGreen = ColorPack(
    _green.withLightness(.45).toColor(),
    _green.withLightness(.40).toColor(),
    _green.withLightness(.35).toColor(),
    _green.withLightness(.30).toColor(),
    _green.withLightness(.25).toColor(),
    _green.withLightness(.20).toColor(),
    _green.withLightness(.15).toColor(),
    _green.withLightness(.10).toColor(),
    _green.withLightness(.05).toColor(),
  );

  static final _cyan = HSLColor.fromAHSL(1, 170, .8, .5);
  static final cyan = _cyan.toColor();
  static final lightCyan = ColorPack(
    _cyan.withLightness(.55).toColor(),
    _cyan.withLightness(.60).toColor(),
    _cyan.withLightness(.65).toColor(),
    _cyan.withLightness(.70).toColor(),
    _cyan.withLightness(.75).toColor(),
    _cyan.withLightness(.80).toColor(),
    _cyan.withLightness(.85).toColor(),
    _cyan.withLightness(.90).toColor(),
    _cyan.withLightness(.95).toColor(),
  );
  static final darkCyan = ColorPack(
    _cyan.withLightness(.45).toColor(),
    _cyan.withLightness(.40).toColor(),
    _cyan.withLightness(.35).toColor(),
    _cyan.withLightness(.30).toColor(),
    _cyan.withLightness(.25).toColor(),
    _cyan.withLightness(.20).toColor(),
    _cyan.withLightness(.15).toColor(),
    _cyan.withLightness(.10).toColor(),
    _cyan.withLightness(.05).toColor(),
  );

  static final _blue = HSLColor.fromAHSL(1, 240, .8, .5);
  static final blue = _blue.toColor();
  static final lightBlue = ColorPack(
    _blue.withLightness(.55).toColor(),
    _blue.withLightness(.60).toColor(),
    _blue.withLightness(.65).toColor(),
    _blue.withLightness(.70).toColor(),
    _blue.withLightness(.75).toColor(),
    _blue.withLightness(.80).toColor(),
    _blue.withLightness(.85).toColor(),
    _blue.withLightness(.90).toColor(),
    _blue.withLightness(.95).toColor(),
  );
  static final darkBlue = ColorPack(
    _blue.withLightness(.45).toColor(),
    _blue.withLightness(.40).toColor(),
    _blue.withLightness(.35).toColor(),
    _blue.withLightness(.30).toColor(),
    _blue.withLightness(.25).toColor(),
    _blue.withLightness(.20).toColor(),
    _blue.withLightness(.15).toColor(),
    _blue.withLightness(.10).toColor(),
    _blue.withLightness(.05).toColor(),
  );

  static final _purple = HSLColor.fromAHSL(1, 270, .8, .5);
  static final purple = _purple.toColor();
  static final lightPurple = ColorPack(
    _purple.withLightness(.55).toColor(),
    _purple.withLightness(.60).toColor(),
    _purple.withLightness(.65).toColor(),
    _purple.withLightness(.70).toColor(),
    _purple.withLightness(.75).toColor(),
    _purple.withLightness(.80).toColor(),
    _purple.withLightness(.85).toColor(),
    _purple.withLightness(.90).toColor(),
    _purple.withLightness(.95).toColor(),
  );
  static final darkPurple = ColorPack(
    _purple.withLightness(.45).toColor(),
    _purple.withLightness(.40).toColor(),
    _purple.withLightness(.35).toColor(),
    _purple.withLightness(.30).toColor(),
    _purple.withLightness(.25).toColor(),
    _purple.withLightness(.20).toColor(),
    _purple.withLightness(.15).toColor(),
    _purple.withLightness(.10).toColor(),
    _purple.withLightness(.05).toColor(),
  );

  static final _pink = HSLColor.fromAHSL(1, 300, .8, .5);
  static final pink = _pink.toColor();
  static final lightPink = ColorPack(
    _pink.withLightness(.55).toColor(),
    _pink.withLightness(.60).toColor(),
    _pink.withLightness(.65).toColor(),
    _pink.withLightness(.70).toColor(),
    _pink.withLightness(.75).toColor(),
    _pink.withLightness(.80).toColor(),
    _pink.withLightness(.85).toColor(),
    _pink.withLightness(.90).toColor(),
    _pink.withLightness(.95).toColor(),
  );
  static final darkPink = ColorPack(
    _pink.withLightness(.45).toColor(),
    _pink.withLightness(.40).toColor(),
    _pink.withLightness(.35).toColor(),
    _pink.withLightness(.30).toColor(),
    _pink.withLightness(.25).toColor(),
    _pink.withLightness(.20).toColor(),
    _pink.withLightness(.15).toColor(),
    _pink.withLightness(.10).toColor(),
    _pink.withLightness(.05).toColor(),
  );
}

extension AppColorUtils on Color {
  Color get transparent => withAlpha(0);
}
