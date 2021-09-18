part of 'markdown.dart';

class _MarkdownParser {
  _MarkdownParser({required String body, MarkdownStyle? markdowonStyle, double? gapPoint})
      : lines = body.split('\n'),
        style = markdowonStyle ?? MarkdownStyle(),
        gap = Gap(gapPoint ?? 20);

  late final List<String> lines;

  int lineIndex = 0;

  final MarkdownStyle style;

  final Gap gap;

  List<Widget> parse() {
    List<Widget> contents = [];

    try {
      while (true) {
        final line = nextLine;

        {
          /// br 改行は複数あればあるだけスペースをとる
          final x = br(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// headline カスタムは[MarkdownStyle]から
          final x = headline(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// code カスタムは[MarkdownStyle]から syntax highlight対応したい
          final x = code(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// image カスタムは[MarkdownStyle]から
          final x = image(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// 最後の砦。ここまでで該当しないlineは無いとする
          /// p カスタムは[MarkdownStyle]から
          final x = p(line);
          contents.add(x);
        }
        /// elementsに関しては以下に記述することを許容しない
      }
    } catch (_) {
      // nextlineがなくなったとして握り潰す
    }
    return contents;
  }

  String get nextLine {
    try {
      final line = lines[lineIndex];
      lineIndex++;
      return line;
    } catch (_) {
      /// error他にあるかチェック
      throw NoLineException();
    }
  }
}

class NoLineException implements Exception {}
