part of '../markdown.dart';


/// TODO inline
extension _MarkdownParserCodeEx on _MarkdownParser {
  Widget? code(String line) {
    if (RegExp(r'^```').hasMatch(line)) {
      final List<String> codes = [];
      while (true) {
        final line = nextLine;
        if (RegExp(r'^```').hasMatch(line)) {
          break;
        }
        codes.add(line);
      }
      // final controller = ScrollController();
      return Container(
        padding: style.codeStyle.padding,
        color: style.codeStyle.backgroundColor,

        /// scrollbarの位置がズレる compositsubscriptionも必要
        // child: Scrollbar(
        //   isAlwaysShown: style.codeStyle.scrollBarAlwaysShown,
        //   controller: controller,
        child: SingleChildScrollView(
          // controller: controller,
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codes
                .map((x) => Text(
                      x,
                      style: style.codeStyle.fontStyle,
                    ))
                .toList(),
          ),
        ),
        // ),
      );
    }

    return null;
  }
}
