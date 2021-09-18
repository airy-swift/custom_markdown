part of '../markdown.dart';

extension _MarkdownParserBrEx on _MarkdownParser {
  Widget? br(String line) {
    if (line.isEmpty) {
      return gap;
    }
    return null;
  }
}
