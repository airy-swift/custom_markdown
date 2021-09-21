part of '../markdown.dart';

extension _MarkdownParserCheckboxEx on _MarkdownParser {
  Widget? checkBox(String line) {
    if (RegExp(r'^- \[.?\]').hasMatch(line)) {
      final checked = !line.startsWith('- [] ');

      final builder = style.checkboxStyle.builder;

      return builder != null //
          ? builder(checked)
          : Padding(
            padding: style.checkboxStyle.padding ?? const EdgeInsets.all(0),
            child: Row(
                children: [
                  Icon(
                    checked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                    color: checked ? style.checkboxStyle.checkColor ?? Colors.blue : Colors.grey,
                  ),
                  Text(
                    line.substring(checked ? 5 : 4),
                    style: style.checkboxStyle.style ?? style.theme.bodyText1,
                  ),
                ],
              ),
          );
    }
    return null;
  }
}

class MarkdownCheckboxStyle {
  const MarkdownCheckboxStyle({this.builder, this.checkColor, this.style, this.padding});

  final Widget Function(bool check)? builder;

  final Color? checkColor;

  final TextStyle? style;
  
  final EdgeInsets? padding;
}
