part of 'markdown.dart';

class MarkdownStyle {
  MarkdownStyle({
    double fontSizeDelta = 1,
    bool downSizeHeadline = false,
    Color fontColor = const Color.fromRGBO(20, 20, 20, 1),
    String fontFamily = "",
    TextTheme? textTheme,
    MarkdownHeadlineDecoration? headlineDecoration,
    this.codeStyle = const MarkdownCodeStyle(),
    this.imageStyle = const MarkdownImageStyle(),
    MarkdownLiStyle? liStyle,
    MarkdownBStyle? bStyle,
    MarkdownAStyle? aStyle,
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
        this.liStyle = liStyle ?? MarkdownLiStyle(),
        this.headlineDecoration = headlineDecoration ?? MarkdownHeadlineDecoration();

  final TextTheme theme;

  final MarkdownHeadlineDecoration headlineDecoration;

  final MarkdownCodeStyle codeStyle;

  final MarkdownImageStyle imageStyle;

  final MarkdownAStyle aStyle;

  final MarkdownBStyle bStyle;

  final MarkdownLiStyle liStyle;
}

class MarkdownHeadlineDecoration {
  MarkdownHeadlineDecoration({
    Widget Function(Widget child, HeadlineType headlineType)? decorationBuilder,
  }) {
    builder = decorationBuilder ?? (child, headlineType) => child;
  }

  late final Widget Function(Widget child, HeadlineType headlineType) builder;
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

class MarkdownAStyle {
  MarkdownAStyle({
    TapGestureRecognizer? onLinkTap,
    this.linkStyle = const TextStyle(color: Colors.blueAccent),
  }) {
    tapGestureRecognizer = (uri) {
      return TapGestureRecognizer()..onTap = () => html.window.open(uri, '');
    };
  }

  late final TapGestureRecognizer Function(String uri) tapGestureRecognizer;

  final TextStyle linkStyle;
}

class MarkdownBStyle {
  MarkdownBStyle({
    TextStyle? boldStyle,
  }) : boldStyle = boldStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 17)
          ..apply(fontWeightDelta: 2);

  final TextStyle boldStyle;
}

class MarkdownLiStyle {
  MarkdownLiStyle({
    this.liStyle,
    this.padding = const EdgeInsets.all(8.0),
    Widget Function(int indent)? ulBuilder,
    Widget Function(int indent, int num)? olBuilder,
    this.indentPoint = 10,
    this.betweenSpacePoint = 6,
  }) {
    this.ulBuilder = ulBuilder ??
        (indent) => Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: indent % 2 == 0 //
                    ? Colors.black87
                    : Colors.blue,
              ),
            );
    this.olBuilder = olBuilder ??
        (indent, num) => Container(
              // width: 7,
              // height: 7,
              child: Text(num.toString() + '.'),
            );
  }

  final TextStyle? liStyle;

  final EdgeInsets padding;

  late final Widget Function(int indent) ulBuilder;

  late final Widget Function(int indent, int num) olBuilder;

  final double indentPoint;

  final double betweenSpacePoint;
}
