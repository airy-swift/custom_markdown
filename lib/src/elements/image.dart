part of '../markdown.dart';

extension _MarkdownParserImageEx on _MarkdownParser {
  Widget? image(String line) {
    if (RegExp(r'!\[.*\]\(http.*\)').hasMatch(line)) {
      final imageUrl = RegExp(r'\(http.*\)').stringMatch(line)?.replaceFirst('(', '').replaceFirst(')', '');
      final caption = RegExp(r'\[.*\]').stringMatch(line)?.replaceFirst('[', '').replaceFirst(']', '');

      if (imageUrl != null) {
        final imageBuilder = style.imageStyle.imageBuilder;
        final showCaption = style.imageStyle.showCaption;

        late Widget? captionWidget;
        if (showCaption && caption != null) {
          final captionBuilder = style.imageStyle.captionBuilder;
          captionWidget = captionBuilder != null //
              ? captionBuilder(caption)
              : Text(caption);
        }

        Widget imageWidget = imageBuilder != null //
            ? imageBuilder(Image.network(imageUrl))
            : Image.network(imageUrl);

        if (captionWidget == null) {
          return imageWidget;
        } else {
          return Column(
            crossAxisAlignment: style.imageStyle.crossAxisAlignment,
            children: [
              imageWidget,
              captionWidget,
            ],
          );
        }
      }
    }

    return null;
  }
}
