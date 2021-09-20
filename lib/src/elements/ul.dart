part of '../markdown.dart';

extension _MarkdownParserUlEx on _MarkdownParser {
  Widget? ul(String line) {
    if (RegExp(r'^\s*- ').hasMatch(line)) {
      late Widget text;
      int indent = 0;

      /// TODO 絶対もっといい書き方ある & 3段目までしか対応していない
      if (line.startsWith('- ')) {
        text = Text(line.substring(2), style: style.liStyle.liStyle ?? style.theme.bodyText1);
      } else if (line.startsWith('  - ')) {
        text = Text(line.substring(4), style: style.liStyle.liStyle ?? style.theme.bodyText1);
        indent = 1;
      } else if (line.startsWith('    - ')) {
        text = Text(line.substring(6), style: style.liStyle.liStyle ?? style.theme.bodyText1);
        indent = 2;
      }
      return Padding(
        padding: style.liStyle.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(indent, (_) => Gap(style.liStyle.indentPoint)),
            Center(child: style.liStyle.ulBuilder(indent)),
            Gap(style.liStyle.betweenSpacePoint),
            Flexible(child: text),
          ],
        ),
      );
    }

    return null;
  }
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
