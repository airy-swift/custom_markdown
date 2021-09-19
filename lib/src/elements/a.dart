part of '../markdown.dart';

extension _MarkdownParserAEx on _MarkdownParser {
  Widget? a(String line) {

    /// TODO 1行当り1つまでのリンクしか対応していない
    final linkMatched = RegExp(r'\[.*\]\(http.+\)').stringMatch(line);

    if (linkMatched != null) {
      final splitLine = line.split(linkMatched);

      final url = RegExp(r'\(http.*\)').stringMatch(line)?.replaceFirst('(', '').replaceFirst(')', '');

      if (url == null) {
        return null;
      }

      return RichText(
        text: TextSpan(text: '', children: [
          TextSpan(
            text: splitLine[0],
            style: style.theme.bodyText1,
          ),
          TextSpan(
            text: url,
            style: style.aStyle.linkStyle,
            recognizer: style.aStyle.tapGestureRecognizer(url),
          ),
          TextSpan(
            text: splitLine[1],
            style: style.theme.bodyText1,
          ),
        ]),
      );
    }

    return null;
  }
}