part of '../markdown.dart';

extension _MarkdownParserOlEx on _MarkdownParser {
  Widget? ol(String line) {
    if (RegExp(r'^\s*\d+\. ').hasMatch(line)) {
      late Widget text;
      int indent = 0;

      /// TODO 絶対もっといい書き方ある & 3段目までしか対応していない
      final indent0 = RegExp(r'^\d+\. ').stringMatch(line);
      final indent1 = RegExp(r'^\s\s\d+\. ').stringMatch(line);
      final indent2 = RegExp(r'^\s\s\s\s\d+\. ').stringMatch(line);

      late int num;

      if (indent0 != null) {
        num = int.parse(RegExp(r'\d+').stringMatch(indent0) ?? "1");
        text = Text(line.replaceFirst('${num.toString()}.', ''), style: style.liStyle.liStyle ?? style.theme.bodyText1);
      } else if (indent1 != null) {
        num = int.parse(RegExp(r'\d+').stringMatch(indent1) ?? "1");
        text = Text(line.substring(2).replaceFirst('${num.toString()}.', ''), style: style.liStyle.liStyle ?? style.theme.bodyText1);
        indent = 1;
      } else if (indent2 != null) {
        num = int.parse(RegExp(r'\d+').stringMatch(indent2) ?? "1");
        text = Text(line.substring(4).replaceFirst('${num.toString()}.', ''), style: style.liStyle.liStyle ?? style.theme.bodyText1);
        indent = 2;
      } else {
        return null;
      }

      return Padding(
        padding: style.liStyle.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(indent, (_) => Gap(style.liStyle.indentPoint)),
            Center(child: style.liStyle.olBuilder(indent, num)),
            Gap(style.liStyle.betweenSpacePoint),
            Flexible(child: text),
          ],
        ),
      );
    }

    return null;
  }
}