part of 'markdown.dart';

class _MarkdownParser {
  _MarkdownParser({required String body, MarkdownStyle? markdowonStyle, double? gapPoint})
      : lines = body.split('\n'),
        style = markdowonStyle ?? MarkdownStyle(),
        gap = Gap(gapPoint ?? 20);

  late final List<String> lines;

  int lineIndex = 0;

  int dryLineIndex = 0;

  final MarkdownStyle style;

  final Gap gap;

  List<Widget> parse() {
    List<Widget> contents = [];

    try {
      while (true) {
        final line = nextLine;

        ///
        /// ここから同じ感じの処理が続く
        ///
        /// [funcion, function].foreach(...)
        /// というやり方でもいいがコメントを追記したり後から変更しやすいように当面はこの形式
        ///

        {
          /// user defined styler
          final builder = style.userStyle.builder;
          if (builder != null) {
            final x = builder(line);
            if (x != null) {
              contents.add(x);
              continue;
            }
          }
        }
        {
          /// br
          /// 改行は複数あればあるだけスペースをとる
          final x = br(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// hr
          final x = hr(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// headline
          final x = headline(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// code
          final x = code(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// note: info, warning, error
          final x = note(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// block quote
          final x = blockQuote(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {

          /// table
          final x = table(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// image
          /// 必ず[a]の前に実行する
          final x = image(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// a
          final x = a(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// b
          /// 必ず[i]の前に実行する
          final x = b(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// i
          final x = i(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// checkbox
          /// 必ず[li]の前に実行する
          final x = checkBox(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// ul
          final x = ul(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }
        {
          /// ol
          final x = ol(line);
          if (x != null) {
            contents.add(x);
            continue;
          }
        }

        {
          /// 最後の砦。ここまでで該当しないlineは無いとする
          /// p
          final x = p(line);
          contents.add(x);
        }

        /// elementsに関しては以下に記述することを許容しない

      }
    } on NoLineException catch (_) {
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

  String get dryNextLine {
    try {
      final line = lines[dryLineIndex];
      dryLineIndex++;
      return line;
    } catch (_) {
      /// error他にあるかチェック
      throw NoLineException();
    }
  }

  List<String> lineBlock(String pattern) {
    final List<String> lines = [];
    while (true) {
      final line = nextLine;
      if (RegExp(pattern).hasMatch(line)) {
        break;
      }
      lines.add(line);
    }
    return lines;
  }

  // List<String> dryExclusiveLineBlock(String pattern, {int? index}) {
  //   final List<String> lines = [];
  //   dryLineIndex = index ?? lineIndex - 1; // 開始位置から始めたい
  //   while (true) {
  //     final line = dryNextLine;
  //     if (!RegExp(pattern).hasMatch(line)) {
  //       lineIndex = dryLineIndex - 1;
  //       break;
  //     }
  //     lines.add(line);
  //   }
  //   return lines;
  // }
}

class NoLineException implements Exception {}
