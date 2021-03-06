part of '../markdown.dart';

extension _MarkdownParserBEx on _MarkdownParser {
  Widget? b(String line) {
    final bMatched = RegExp(r'\*\*').allMatches(line);

    if (bMatched.isNotEmpty && bMatched.length % 2 == 0) {
      final splitLine = line.split('**');

      final List<InlineSpan> lines = [];

      splitLine.asMap().forEach((index, value) {
        lines.add(
          TextSpan(
            text: value,
            style: index % 2 == 0 //
                ? style.theme.bodyText1
                : style.bStyle.style,
          ),
        );
      });

      return RichText(
        text: TextSpan(
          text: '',
          children: lines,
        ),
      );
    }

    return null;
  }
}

class MarkdownBStyle {
  MarkdownBStyle({
    TextStyle? style,
    Color? styleColor,
  }) : style = style ?? TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: styleColor)
          ..apply(fontWeightDelta: 2);

  final TextStyle style;
}
