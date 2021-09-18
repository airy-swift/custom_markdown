part of 'markdown.dart';

class MarkdownStyle {
  MarkdownStyle({
    double fontSizeDelta = 1,
    bool downSizeHeadline = false,
    Color fontColor = const Color.fromRGBO(20, 20, 20, 1),
    String fontFamily = "",
    TextTheme? textTheme,
    this.codeStyle = const MarkdownCodeStyle(),
    this.imageStyle = const MarkdownImageStyle(),
  }) : theme = textTheme ?? TextTheme(
          headline1: TextStyle(fontSize: (downSizeHeadline ? 48 : 96) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          headline2: TextStyle(fontSize: (downSizeHeadline ? 34 : 60) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          headline3: TextStyle(fontSize: (downSizeHeadline ? 24 : 48) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          headline4: TextStyle(fontSize: (downSizeHeadline ? 20 : 34) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          headline5: TextStyle(fontSize: (downSizeHeadline ? 16 : 24) * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          headline6: TextStyle(fontSize: 20 * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
          subtitle1: TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          subtitle2: TextStyle(fontSize: 14 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          bodyText1: TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          bodyText2: TextStyle(fontSize: 14 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          caption: TextStyle(fontSize: 12 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          overline: TextStyle(fontSize: 10 * fontSizeDelta, fontFamily: fontFamily, color: fontColor),
          button: TextStyle(fontSize: 16 * fontSizeDelta, fontFamily: fontFamily, fontWeight: FontWeight.bold, color: fontColor),
        );

  final TextTheme theme;

  final MarkdownCodeStyle codeStyle;

  final MarkdownImageStyle imageStyle;
}

class MarkdownCodeStyle {
  const MarkdownCodeStyle({
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.backgroundColor = const Color(0xff424242),
    this.fontStyle = const TextStyle(color: Color(0xffFAFAFA)),
    this.scrollBarAlwaysShown = true,
  });

  final EdgeInsets padding;

  final Color backgroundColor;

  final TextStyle? fontStyle;

  final bool scrollBarAlwaysShown;
}

class MarkdownImageStyle {
  const MarkdownImageStyle({
    this.onTap,
    this.showCaption = true,
    this.placeHolder,
    this.imageBuilder,
    this.captionBuilder,
    this.errorImage,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final VoidCallback? onTap;

  final bool showCaption;

  /// child は image
  final Widget Function(Widget child)? imageBuilder;

  final Widget Function(String caption)? captionBuilder;

  final Widget? placeHolder;

  final Widget? errorImage;

  final CrossAxisAlignment crossAxisAlignment;
}
