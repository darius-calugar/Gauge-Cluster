import 'package:flutter/painting.dart';

abstract final class AppColors {
  static final black1 = HSLColor.fromAHSL(1, 0, 0, .000).toColor();
  static final black2 = HSLColor.fromAHSL(1, 0, 0, .025).toColor();
  static final black3 = HSLColor.fromAHSL(1, 0, 0, .050).toColor();
  static final black4 = HSLColor.fromAHSL(1, 0, 0, .075).toColor();
  static final black5 = HSLColor.fromAHSL(1, 0, 0, .100).toColor();
  static final black6 = HSLColor.fromAHSL(1, 0, 0, .125).toColor();
  static final black7 = HSLColor.fromAHSL(1, 0, 0, .150).toColor();
  static final black8 = HSLColor.fromAHSL(1, 0, 0, .175).toColor();
  static final black9 = HSLColor.fromAHSL(1, 0, 0, .200).toColor();

  static final white1 = HSLColor.fromAHSL(1, 0, 0, 1.00).toColor();
  static final white2 = HSLColor.fromAHSL(1, 0, 0, .950).toColor();
  static final white3 = HSLColor.fromAHSL(1, 0, 0, .900).toColor();
  static final white4 = HSLColor.fromAHSL(1, 0, 0, .850).toColor();
  static final white5 = HSLColor.fromAHSL(1, 0, 0, .800).toColor();
  static final white6 = HSLColor.fromAHSL(1, 0, 0, .750).toColor();
  static final white7 = HSLColor.fromAHSL(1, 0, 0, .700).toColor();
  static final white8 = HSLColor.fromAHSL(1, 0, 0, .650).toColor();
  static final white9 = HSLColor.fromAHSL(1, 0, 0, .600).toColor();


  static final red1 = HSLColor.fromAHSL(1, 0, .8, .9).toColor();
  static final red2 = HSLColor.fromAHSL(1, 0, .8, .8).toColor();
  static final red3 = HSLColor.fromAHSL(1, 0, .8, .7).toColor();
  static final red4 = HSLColor.fromAHSL(1, 0, .8, .6).toColor();
  static final red5 = HSLColor.fromAHSL(1, 0, .8, .5).toColor();
  static final red6 = HSLColor.fromAHSL(1, 0, .8, .4).toColor();
  static final red7 = HSLColor.fromAHSL(1, 0, .8, .3).toColor();
  static final red8 = HSLColor.fromAHSL(1, 0, .8, .2).toColor();
  static final red9 = HSLColor.fromAHSL(1, 0, .8, .1).toColor();

  static final orange1 = HSLColor.fromAHSL(1, 30, .8, .9).toColor();
  static final orange2 = HSLColor.fromAHSL(1, 30, .8, .8).toColor();
  static final orange3 = HSLColor.fromAHSL(1, 30, .8, .7).toColor();
  static final orange4 = HSLColor.fromAHSL(1, 30, .8, .6).toColor();
  static final orange5 = HSLColor.fromAHSL(1, 30, .8, .5).toColor();
  static final orange6 = HSLColor.fromAHSL(1, 30, .8, .4).toColor();
  static final orange7 = HSLColor.fromAHSL(1, 30, .8, .3).toColor();
  static final orange8 = HSLColor.fromAHSL(1, 30, .8, .2).toColor();
  static final orange9 = HSLColor.fromAHSL(1, 30, .8, .1).toColor();

  static final yellow1 = HSLColor.fromAHSL(1, 60, .8, .9).toColor();
  static final yellow2 = HSLColor.fromAHSL(1, 60, .8, .8).toColor();
  static final yellow3 = HSLColor.fromAHSL(1, 60, .8, .7).toColor();
  static final yellow4 = HSLColor.fromAHSL(1, 60, .8, .6).toColor();
  static final yellow5 = HSLColor.fromAHSL(1, 60, .8, .5).toColor();
  static final yellow6 = HSLColor.fromAHSL(1, 60, .8, .4).toColor();
  static final yellow7 = HSLColor.fromAHSL(1, 60, .8, .3).toColor();
  static final yellow8 = HSLColor.fromAHSL(1, 60, .8, .2).toColor();
  static final yellow9 = HSLColor.fromAHSL(1, 60, .8, .1).toColor();

  static final green1 = HSLColor.fromAHSL(1, 120, .8, .9).toColor();
  static final green2 = HSLColor.fromAHSL(1, 120, .8, .8).toColor();
  static final green3 = HSLColor.fromAHSL(1, 120, .8, .7).toColor();
  static final green4 = HSLColor.fromAHSL(1, 120, .8, .6).toColor();
  static final green5 = HSLColor.fromAHSL(1, 120, .8, .5).toColor();
  static final green6 = HSLColor.fromAHSL(1, 120, .8, .4).toColor();
  static final green7 = HSLColor.fromAHSL(1, 120, .8, .3).toColor();
  static final green8 = HSLColor.fromAHSL(1, 120, .8, .2).toColor();
  static final green9 = HSLColor.fromAHSL(1, 120, .8, .1).toColor();

  static final cyan1 = HSLColor.fromAHSL(1, 170, .8, .9).toColor();
  static final cyan2 = HSLColor.fromAHSL(1, 170, .8, .8).toColor();
  static final cyan3 = HSLColor.fromAHSL(1, 170, .8, .7).toColor();
  static final cyan4 = HSLColor.fromAHSL(1, 170, .8, .6).toColor();
  static final cyan5 = HSLColor.fromAHSL(1, 170, .8, .5).toColor();
  static final cyan6 = HSLColor.fromAHSL(1, 170, .8, .4).toColor();
  static final cyan7 = HSLColor.fromAHSL(1, 170, .8, .3).toColor();
  static final cyan8 = HSLColor.fromAHSL(1, 170, .8, .2).toColor();
  static final cyan9 = HSLColor.fromAHSL(1, 170, .8, .1).toColor();

  static final blue1 = HSLColor.fromAHSL(1, 240, .8, .9).toColor();
  static final blue2 = HSLColor.fromAHSL(1, 240, .8, .8).toColor();
  static final blue3 = HSLColor.fromAHSL(1, 240, .8, .7).toColor();
  static final blue4 = HSLColor.fromAHSL(1, 240, .8, .6).toColor();
  static final blue5 = HSLColor.fromAHSL(1, 240, .8, .5).toColor();
  static final blue6 = HSLColor.fromAHSL(1, 240, .8, .4).toColor();
  static final blue7 = HSLColor.fromAHSL(1, 240, .8, .3).toColor();
  static final blue8 = HSLColor.fromAHSL(1, 240, .8, .2).toColor();
  static final blue9 = HSLColor.fromAHSL(1, 240, .8, .1).toColor();

  static final purple1 = HSLColor.fromAHSL(1, 270, .8, .9).toColor();
  static final purple2 = HSLColor.fromAHSL(1, 270, .8, .8).toColor();
  static final purple3 = HSLColor.fromAHSL(1, 270, .8, .7).toColor();
  static final purple4 = HSLColor.fromAHSL(1, 270, .8, .6).toColor();
  static final purple5 = HSLColor.fromAHSL(1, 270, .8, .5).toColor();
  static final purple6 = HSLColor.fromAHSL(1, 270, .8, .4).toColor();
  static final purple7 = HSLColor.fromAHSL(1, 270, .8, .3).toColor();
  static final purple8 = HSLColor.fromAHSL(1, 270, .8, .2).toColor();
  static final purple9 = HSLColor.fromAHSL(1, 270, .8, .1).toColor();

  static final pink1 = HSLColor.fromAHSL(1, 300, .8, .9).toColor();
  static final pink2 = HSLColor.fromAHSL(1, 300, .8, .8).toColor();
  static final pink3 = HSLColor.fromAHSL(1, 300, .8, .7).toColor();
  static final pink4 = HSLColor.fromAHSL(1, 300, .8, .6).toColor();
  static final pink5 = HSLColor.fromAHSL(1, 300, .8, .5).toColor();
  static final pink6 = HSLColor.fromAHSL(1, 300, .8, .4).toColor();
  static final pink7 = HSLColor.fromAHSL(1, 300, .8, .3).toColor();
  static final pink8 = HSLColor.fromAHSL(1, 300, .8, .2).toColor();
  static final pink9 = HSLColor.fromAHSL(1, 300, .8, .1).toColor();
}
