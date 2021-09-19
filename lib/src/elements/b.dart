part of '../markdown.dart';

extension _MarkdownParserBEx on _MarkdownParser {
  Widget? b(String line) {
    /// TODO 1行当り1つまでのリンクしか対応していない
    final bMatched = RegExp(r'\*\*').allMatches(line);

    if (bMatched.isNotEmpty && bMatched.length % 2 == 0) {
      final splitLine = line.split('**');

      final toggleB = splitLine.first.isNotEmpty;

      final List<InlineSpan> lines = [];

      if (toggleB) {
        splitLine.asMap().forEach((index, value) {
          lines.add(
            TextSpan(
              text: value,
              style: index % 2 == 0 //
                  ? style.bStyle.boldStyle
                  : style.theme.bodyText1,
            ),
          );
        });
      } else {
        splitLine.asMap().forEach((index, value) {
          lines.add(
            TextSpan(
              text: value,
              style: index % 2 == 0 //
                  ? style.theme.bodyText1
                  : style.bStyle.boldStyle,
            ),
          );
        });
      }

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
