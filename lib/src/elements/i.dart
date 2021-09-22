part of '../markdown.dart';

extension _MarkdownParserIEx on _MarkdownParser {
  Widget? i(String line) {
    final bMatched = RegExp(r'\*').allMatches(line);

    if (bMatched.isNotEmpty && bMatched.length % 2 == 0) {
      final splitLine = line.split('*');

      final List<InlineSpan> lines = [];

      splitLine.asMap().forEach((index, value) {
        lines.add(
          TextSpan(
            text: value,
            style: index % 2 == 0 //
                ? style.theme.bodyText1
                : style.iStyle.style,
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

class MarkdownIStyle {
  MarkdownIStyle({
    TextStyle? style,
    Color? styleColor,
  }) : style = style ?? TextStyle(fontStyle: FontStyle.italic, fontSize: 17, color: styleColor);

  final TextStyle style;
}
