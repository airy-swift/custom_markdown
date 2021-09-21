part of '../markdown.dart';

extension _MarkdownParserNoteEx on _MarkdownParser {
  Widget? note(String line) {
    /// code block
    if (RegExp(r'^:::\s*note').hasMatch(line)) {
      Widget icon;
      Color backgroundColor;
      if (RegExp(r'^:::\s*note\s+warning').hasMatch(line)) {
        icon = style.noteStyle.warningIcon;
        backgroundColor = style.noteStyle.warningBackgroundColor;
      } else if (RegExp(r'^:::\s*note\s+error').hasMatch(line)) {
        icon = style.noteStyle.errorIcon;
        backgroundColor = style.noteStyle.errorBackgroundColor;
      } else {
        icon = style.noteStyle.infoIcon;
        backgroundColor = style.noteStyle.infoBackgroundColor;
      }

      final List<String> notes = lineBlock(r'^:::$');

      return Container(
        padding: style.noteStyle.padding,
        color: backgroundColor,
        child: Row(
          children: [
            icon,
            Gap(style.noteStyle.betweenPoint),
            Text(
              notes.join('\n'),
              style: style.noteStyle.style ?? style.theme.bodyText1?.apply(color: Colors.black87),
            ),
          ],
        ),
      );
    }
  }
}


class MarkdownNoteStyle {
   MarkdownNoteStyle({
    this.padding = const EdgeInsets.all(16.0),
    this.style,
    this.betweenPoint = 16,
    Widget? infoIcon,
    Color? infoIconColor,
    this.infoBackgroundColor = const Color(0xffe5f8e2),
    Widget? warningIcon,
    Color? warningIconColor,
    this.warningBackgroundColor = const Color(0xfffdf9e2),
    Widget? errorIcon,
    Color? errorIconColor,
    this.errorBackgroundColor = const Color(0xfffbefee),
  }) {
     this.infoIcon = infoIcon ?? Icon(Icons.check_circle, color: infoIconColor ?? Color(0xff55c502), size: 24);
     this.warningIcon = warningIcon ?? Icon(Icons.warning, color: infoIconColor ?? Color(0xfff7a535), size: 24);
     this.errorIcon = infoIcon ?? CircleAvatar(child: Icon(Icons.close, color: infoIconColor ?? Color(0xfffafafa), size: 16), backgroundColor: Color(0xffd61034), radius: 10);
  }

  final EdgeInsets padding;

  final TextStyle? style;

  final double betweenPoint;

  // info
  late final Widget infoIcon;
  final Color infoBackgroundColor;

  // waning
  late final Widget warningIcon;
  final Color warningBackgroundColor;

  // error
  late final Widget errorIcon;
  final Color errorBackgroundColor;
}