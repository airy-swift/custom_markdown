part of 'markdown.dart';

class MarkdownStyle {
  /// headlineのようなメジャーなものはtop階層のプロパティにしているが基本的にはstyleクラスを噛ませる
  MarkdownStyle({
    double fontSizeDelta = 1,
    bool downSizeHeadline = false,
    Color fontColor = const Color.fromRGBO(20, 20, 20, 1),
    String fontFamily = "",
    TextTheme? textTheme,
    MarkdownHeadlineDecoration? headlineDecoration,
    this.codeStyle = const MarkdownCodeStyle(),
    this.imageStyle = const MarkdownImageStyle(),
    this.userStyle = const MarkdownUserStyle(),
    this.hrStyle = const MarkdownHrStyle(),
    this.checkboxStyle = const MarkdownCheckboxStyle(),
    MarkdownNoteStyle? noteStyle,
    MarkdownLiStyle? liStyle,
    MarkdownBStyle? bStyle,
    MarkdownAStyle? aStyle,
    MarkdownIStyle? iStyle,
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headline5,
    TextStyle? headline6,
    TextStyle? subtitle1,
    TextStyle? subtitle2,
    TextStyle? bodyText1,
    TextStyle? bodyText2,
    TextStyle? caption,
    TextStyle? overline,
    TextStyle? button,
  })  : theme = textTheme ??
            TextTheme(
              headline1: headline1 ?? TextStyle(fontSize: (downSizeHeadline ? 48 : 96) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              headline2: headline2 ?? TextStyle(fontSize: (downSizeHeadline ? 34 : 60) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              headline3: headline3 ?? TextStyle(fontSize: (downSizeHeadline ? 24 : 48) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              headline4: headline4 ?? TextStyle(fontSize: (downSizeHeadline ? 20 : 34) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              headline5: headline5 ?? TextStyle(fontSize: (downSizeHeadline ? 16 : 24) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              headline6: headline6 ?? TextStyle(fontSize: 20 * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
              subtitle1: subtitle1 ?? TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              subtitle2: subtitle2 ?? TextStyle(fontSize: 14 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              bodyText1: bodyText1 ?? TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              bodyText2: bodyText2 ?? TextStyle(fontSize: 14 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              caption: caption ?? TextStyle(fontSize: 12 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              overline: overline ?? TextStyle(fontSize: 10 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
              button: button ?? TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
            ),
        this.aStyle = aStyle ?? MarkdownAStyle(),
        this.bStyle = bStyle ?? MarkdownBStyle(),
        this.iStyle = iStyle ?? MarkdownIStyle(),
        this.liStyle = liStyle ?? MarkdownLiStyle(),
        this.noteStyle = noteStyle ?? MarkdownNoteStyle(),
        this.headlineDecoration = headlineDecoration ?? MarkdownHeadlineDecoration();

  final TextTheme theme;

  final MarkdownHeadlineDecoration headlineDecoration;

  final MarkdownCodeStyle codeStyle;

  final MarkdownImageStyle imageStyle;

  final MarkdownAStyle aStyle;

  final MarkdownBStyle bStyle;

  final MarkdownLiStyle liStyle;

  final MarkdownUserStyle userStyle;

  final MarkdownHrStyle hrStyle;

  final MarkdownCheckboxStyle checkboxStyle;

  final MarkdownNoteStyle noteStyle;

  final MarkdownIStyle iStyle;
}

class MarkdownUserStyle {
  const MarkdownUserStyle({this.builder});

  final Widget? Function(String line)? builder;
}
