part of '../markdown.dart';


extension _MarkdownParserCodeEx on _MarkdownParser {
  Widget? code(String line) {
    /// code block
    if (RegExp(r'^```').hasMatch(line)) {

      final fileName = line.substring(3);

      final List<String> codes = lineBlock(r'^```$');
      // final controller = ScrollController();

      final copyButtonBuilder = style.codeStyle.copyButtonBuilder;

      Widget? button;
      if (copyButtonBuilder != null) {
        button = copyButtonBuilder(codes.join('\n'));
      }

      return Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            padding: style.codeStyle.padding,
            color: style.codeStyle.backgroundColor,
            decoration: style.codeStyle.codeDecoration,

            /// scrollbarの位置がズレる compositsubscriptionも必要
            //   isAlwaysShown: style.codeStyle.scrollBarAlwaysShown,

            child: SingleChildScrollView(
              // controller: controller,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: codes
                    .map(
                      // (x) => RichText(
                      //   text: TextSpan(
                      //     text: '',
                      //     children: syntax(x),
                      //   ),
                      // ),
                      (x) => Text(
                        x,
                        style: style.codeStyle.style,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (button != null)
            Align(
              child: button,
              alignment: style.codeStyle.codeButtonAlignment,
            ),
          if (fileName.isNotEmpty && style.codeStyle.showFileGuide)
            Align(
              alignment: style.codeStyle.fileGuideAlignment,
              child: Container(
                decoration: style.codeStyle.fileGuideDecoration,
                padding: style.codeStyle.fileGuidePadding,
                child: Text(
                  fileName,
                  style: style.codeStyle.fileGuideStyle,
                ),
              ),
            ),
        ],
      );
    }

    /// inline code
    final bMatched = RegExp(r'`').allMatches(line);

    if (bMatched.isNotEmpty && bMatched.length % 2 == 0) {
      final splitLine = line.split('`');

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
    /// block
    this.padding = const EdgeInsets.fromLTRB(30, 40, 30, 20),
    this.backgroundColor = const Color(0xff424242),
    this.style = const TextStyle(color: Color(0xffFAFAFA)),
    this.scrollBarAlwaysShown = true,

    /// fileguide
    this.showFileGuide = true,
    this.fileGuideStyle = const TextStyle(color: Color(0xff101010)),
    this.fileGuideDecoration = const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(5),
        )),
    this.fileGuideAlignment = Alignment.topLeft,
    this.fileGuidePadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 7),

    /// user copy button
    this.copyButtonBuilder,
    this.codeDecoration,
    this.codeButtonAlignment = Alignment.topRight,

    /// inline
    this.inlineDecoration = const BoxDecoration(color: Color(0xffF5F5F5), borderRadius: BorderRadius.all(Radius.circular(5))),
    this.inlineStyle = const TextStyle(color: Color(0xffAD1457)),
    this.inlinePadding = const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
  });

  final EdgeInsets padding;

  final Color backgroundColor;

  final TextStyle? style;

  final Widget? Function(String code)? copyButtonBuilder;

  final Decoration? codeDecoration;

  final Alignment codeButtonAlignment;

  final bool scrollBarAlwaysShown;

  final Decoration inlineDecoration;

  final TextStyle? inlineStyle;

  final EdgeInsets inlinePadding;

  final bool showFileGuide;

  final TextStyle? fileGuideStyle;

  final Decoration fileGuideDecoration;

  final EdgeInsets fileGuidePadding;

  final Alignment fileGuideAlignment;
}
