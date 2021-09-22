part of '../markdown.dart';

extension _MarkdownParserTableEx on _MarkdownParser {
  Widget? table(String line) {
    if (RegExp(r'\s*\|(.*\|)+\s*$').hasMatch(line)) {
      final headerLine = line;

      /// alignmentを設定しているか? = tableであるか?を判定
      dryLineIndex = lineIndex;
      final alignmentLine = dryNextLine.replaceAll(' ', '');
      final alignmentMatch = RegExp(r'\|(:?-+:?\|)+$').allMatches(alignmentLine);

      if (alignmentMatch.isEmpty) {
        return null;
      }
      nextLine; // 上のdryNextLineした分を空打ち

      /// alignmentを取得
      List<Alignment> alignmentsSettings = [];
      alignmentLine.split('|').forEach((x) {
        if (x.isNotEmpty) alignmentsSettings.add(alignmentSwitcher(x));
      });

      final header = headerLine.split('|').skip(1).toList()..removeLast();
      final length = header.length;

      /// cellの数が合わないのでスルー
      if (alignmentsSettings.length != length) {
        return null;
      }

      final List<TableRow> rows = [];
      rows.add(getRow(
        contents: header,
        length: length,
        align: alignmentsSettings,
        textStyle: style.tableStyle.headerStyle,
        decoration: style.tableStyle.headerDecoration,
      )); // style

      bool isOdd = true;
      while (true) {
        final contentLine = dryNextLine;
        if (RegExp(r'\s*\|(.*\|)+\s*$').hasMatch(contentLine)) {
          final lines = contentLine.split('|').skip(1).toList()..removeLast();

          rows.add(getRow(
            contents: lines,
            length: length,
            align: alignmentsSettings,
            textStyle: style.tableStyle.contentStyle,
            decoration: isOdd //
                ? style.tableStyle.oddDecoration
                : style.tableStyle.evenDecoration,
          ));
          isOdd = !isOdd;
        } else {
          break;
        }
      }
      lineIndex = dryLineIndex - 1; // breakしたとき1つ通り過ぎている分を戻す

      return Table(
        border: TableBorder.all(color: style.tableStyle.borderColor),
        children: rows,
      );
    }

    return null;
  }

  Alignment alignmentSwitcher(String x) {
    final left = RegExp(r':-+').hasMatch(x);
    final right = RegExp(r'-+:').hasMatch(x);
    if (!left && right) return Alignment.centerRight;
    if (left && right) return Alignment.center;
    return Alignment.centerLeft;
  }

  TableRow getRow({
    required List<String> contents,
    required int length,
    required List<Alignment> align,
    required TextStyle? textStyle,
    required BoxDecoration? decoration,
  }) {
    final gap = length - contents.length;
    final filledContents = List.generate(gap <= 0 ? 0 : length - contents.length, (_) => '') + contents;

    final List<Widget> cells = [];

    for (int i = 0; i < length; i++) {
      cells.add(
        Container(
          alignment: align[i],
          child: Text(
            filledContents[i].replaceAllMapped(r'<\s*br\s*>', (_) => '\n'),
            style: textStyle ?? style.theme.bodyText1,
          ),
        ),
      );
    }
    return TableRow(
      decoration: decoration,
      children: cells,
    );
  }
}

class MarkdownTableStyle {
  const MarkdownTableStyle({
    this.headerStyle = const TextStyle(fontSize: 14, color: Color(0xfffafafa), fontWeight: FontWeight.bold),
    this.contentStyle = const TextStyle(fontSize: 14, color: Color(0xff424242)),
    this.borderColor = Colors.white,
    this.headerDecoration = const BoxDecoration(color: Color(0xff7986CB)),
    this.oddDecoration = const BoxDecoration(color: Color(0xfffafafa)),
    this.evenDecoration = const BoxDecoration(color: Color(0xffE8EAF6)),
  });

  final TextStyle? headerStyle;

  final TextStyle? contentStyle;

  final Color borderColor;

  final BoxDecoration? headerDecoration;

  final BoxDecoration? oddDecoration;

  final BoxDecoration? evenDecoration;
}
