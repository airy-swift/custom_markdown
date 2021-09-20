part of '../markdown.dart';

extension _MarkdownParserHeadlineEx on _MarkdownParser {
  Widget? headline(String line) {
    if (RegExp('^#+ ').hasMatch(line)) {
      final decorationBuilder = style.headlineDecoration.builder;

      if (line.startsWith('######')) {
        return decorationBuilder(Text(line.substring(7), style: style.theme.headline6), HeadlineType.H6);
      } else if (line.startsWith('#####')) {
        return decorationBuilder(Text(line.substring(6), style: style.theme.headline5), HeadlineType.H5);
      } else if (line.startsWith('####')) {
        return decorationBuilder(Text(line.substring(5), style: style.theme.headline4), HeadlineType.H4);
      } else if (line.startsWith('###')) {
        return decorationBuilder(Text(line.substring(4), style: style.theme.headline3), HeadlineType.H3);
      } else if (line.startsWith('##')) {
        return decorationBuilder(Text(line.substring(3), style: style.theme.headline2), HeadlineType.H2);
      } else if (line.startsWith('#')) {
        return decorationBuilder(Text(line.substring(2), style: style.theme.headline1), HeadlineType.H1);
      }
    }

    return null;
  }
}

enum HeadlineType {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
}

class MarkdownHeadlineDecoration {
  MarkdownHeadlineDecoration({
    Widget Function(Widget child, HeadlineType headlineType)? decorationBuilder,
  }) {
    builder = decorationBuilder ?? (child, headlineType) => child;
  }

  late final Widget Function(Widget child, HeadlineType headlineType) builder;
}
