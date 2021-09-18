part of '../markdown.dart';

extension _MarkdownParserHeadlineEx on _MarkdownParser {
  Widget? headline(String line) {
    if (RegExp('^#+ ').hasMatch(line)) {
      if (line.startsWith('######')) {
        return Text(line.substring(7), style: style.theme.headline6);
      } else if (line.startsWith('#####')) {
        return Text(line.substring(6), style: style.theme.headline5);
      } else if (line.startsWith('####')) {
        return Text(line.substring(5), style: style.theme.headline4);
      } else if (line.startsWith('###')) {
        return Text(line.substring(4), style: style.theme.headline3);
      } else if (line.startsWith('##')) {
        return Text(line.substring(3), style: style.theme.headline2);
      } else if (line.startsWith('#')) {
        return Text(line.substring(2), style: style.theme.headline1);
      }
    }

    return null;
  }
}
