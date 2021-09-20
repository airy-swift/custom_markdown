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

      // if (style.aStyle.displayStyle == ALinkDisplayStyle.Url && (splitLine[0].isEmpty && splitLine[1].isEmpty)) {
      /// 現状サーバ側で設定をするかセキュリティレベルを落とさないとhttp requestがflutter webからは送れないためbookmark link見送る
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
      // } else if (style.aStyle.displayStyle == ALinkDisplayStyle.Bookmark) {
      //   return AnyLinkPreview(
      //     link: url,
      //     displayDirection: UIDirection.UIDirectionHorizontal,
      //     showMultimedia: false,
      //     bodyMaxLines: 5,
      //     bodyTextOverflow: TextOverflow.ellipsis,
      //     titleStyle: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
      //   );
      // }
    }

    return null;
  }
}

enum ALinkDisplayStyle {
  Url,
  Bookmark,
}

class MarkdownAStyle {
  MarkdownAStyle({
    TapGestureRecognizer? onLinkTap,
    this.linkStyle = const TextStyle(color: Colors.blueAccent),
    this.displayStyle = ALinkDisplayStyle.Bookmark,
  }) {
    tapGestureRecognizer = (uri) {
      return TapGestureRecognizer()..onTap = () => html.window.open(uri, '');
    };
  }

  late final TapGestureRecognizer Function(String uri) tapGestureRecognizer;

  final TextStyle linkStyle;

  final ALinkDisplayStyle displayStyle;
}
