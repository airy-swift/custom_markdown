part of '../markdown.dart';

extension _MarkdownParserPEx on _MarkdownParser {
  Widget p(String line) {
    return Text(line, style: style.theme.bodyText1,);
  }
}
