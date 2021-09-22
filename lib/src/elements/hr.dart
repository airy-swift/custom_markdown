part of '../markdown.dart';

extension _MarkdownParserHrEx on _MarkdownParser {
  Widget? hr(String line) {
    if (RegExp(r'^--+$').hasMatch(line)) {
      return style.hrStyle.hr ?? Divider();
    }
    return null;
  }
}


class MarkdownHrStyle {
  const MarkdownHrStyle({this.hr});

  final Widget? hr;
}