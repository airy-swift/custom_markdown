part of '../markdown.dart';


extension MarkdownBlockQuoteEx on _MarkdownParser {
  Widget? blockQuote(String line) {
    if (RegExp(r'^>+\s').hasMatch(line)) {

      /// 連続している引用の行を全部取得
      dryLineIndex = lineIndex - 1;
      final List<BlockQuote> blockQuotes = [];
      while (true) {
        final line = dryNextLine;
        final quote = RegExp(r'^>+').stringMatch(line);

        if (quote != null) {
          blockQuotes.add(BlockQuote(quote.length, line));
        } else {
          break;
        }
      }
      lineIndex = dryLineIndex - 1;

      /// indentをカウント
      int maxIndent = 0;
      final Map<int, List<String>> quotes = {};
      for (BlockQuote i in blockQuotes) {
        if (maxIndent < i.indent) {
          maxIndent = i.indent;
          quotes[maxIndent] = [RegExp(r'^>+\s*(.*)').firstMatch(i.line)?.group(1) ?? ""];
        } else {
          quotes[maxIndent]!.add(RegExp(r'^>+\s*(.*)').firstMatch(i.line)?.group(1) ?? "");
        }
      }

      /// 入れ子にする
      Widget? ret;
      for (int i = maxIndent; i > 0; i--) {
        ret = builder(quotes[i]!, child: ret);
      }

      return ret;
    }

    return null;
  }

  Widget builder(List<String> lines, {Widget? child}) {
    return IntrinsicHeight(
      child: Padding(
        padding: style.blockQuoteStyle.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 3,
              color: style.blockQuoteStyle.quoteColor,
            ),
            Gap(style.blockQuoteStyle.betweenPoint),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Gap(style.blockQuoteStyle.betweenPoint),
                        Text(
                          lines.join('\n'),
                          style: style.blockQuoteStyle.style,
                        ),
                      ],
                    ),
                  ),
                  if (child != null)
                    child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkdownBlockQuoteStyle {
  const MarkdownBlockQuoteStyle({
    this.betweenPoint = 5,
    this.quoteColor = const Color(0xff7a7a7a),
    this.padding = const EdgeInsets.all(8.0),
    this.style = const TextStyle(color: Color(0xffcacaca), fontStyle: FontStyle.italic),
  });

  final double betweenPoint;

  final Color quoteColor;

  final EdgeInsets padding;

  final TextStyle style;
}


class BlockQuote {
  const BlockQuote(this.indent, this.line);

  final int indent;
  final String line;
}