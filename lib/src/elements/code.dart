part of '../markdown.dart';

/// TODO inline
extension _MarkdownParserCodeEx on _MarkdownParser {
  Widget? code(String line) {
    /// code block
    if (RegExp(r'^```$').hasMatch(line)) {
      final List<String> codes = [];
      while (true) {
        final line = nextLine;
        if (RegExp(r'^```$').hasMatch(line)) {
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

    /// inline code
    final bMatched = RegExp(r'```').allMatches(line);

    if (bMatched.isNotEmpty && bMatched.length % 2 == 0) {
      final splitLine = line.split('```');

      final List<InlineSpan> lines = [];

      splitLine.asMap().forEach((index, value) {
        InlineSpan x;

        if (index % 2 == 0) {
          x = TextSpan(
            text: value,
            style: style.theme.bodyText1,
          );
        } else {
          x = WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                decoration: style.codeStyle.inlineDecoration,
                padding: style.codeStyle.inlinePadding,
                child: Text(value, style: style.codeStyle.inlineStyle),
              ),
            ),
          );
        }

        lines.add(x);
      });

      return RichText(
        text: TextSpan(
          text: '',
          children: lines,
        ),
      );
    }

    return null;
  }
}

class MarkdownCodeStyle {
  const MarkdownCodeStyle({
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.backgroundColor = const Color(0xff424242),
    this.fontStyle = const TextStyle(color: Color(0xffFAFAFA)),
    this.scrollBarAlwaysShown = true,
    this.inlineDecoration = const BoxDecoration(color: Color(0xffF5F5F5), borderRadius: BorderRadius.all(Radius.circular(5))),
    this.inlineStyle = const TextStyle(color: Color(0xffAD1457)),
    this.inlinePadding = const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
  });

  final EdgeInsets padding;

  final Color backgroundColor;

  final TextStyle? fontStyle;

  final bool scrollBarAlwaysShown;

  final Decoration inlineDecoration;

  final TextStyle? inlineStyle;

  final EdgeInsets inlinePadding;
}
