# custom_markdown

welcome to my page!
[example my blog](https://airy-56405.web.app/)

# Installation

```pubspec.yaml
  dependencies:
    custom_markdown:

```

# how to use

it's so easy, the most of simple use case our product!

```dart
final text = """
# hello world
hey guys!
""";

  Markdown(
    body: text.replaceAll('\\n', '\n'),
  ),
```

and, blow code is one of example.

```dart
  Markdown(
    body: text.replaceAll('\\n', '\n'),
    style: MarkdownHeadlineDecoration(
      decorationBuilder: (child, headlineType) {
        if (headlineType == HeadlineType.H1) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: child,
          );
        }
        return Container(
          child: Align(
            alignment: Alignment.centerLeft,
              child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 9, 16, 12),
              child: child,
            ),
          ),
          color: colors.materialBlue.withOpacity(0.4),
        );
      },
    ),
  ),
```

# this package is still under development.

if you want to know what we development completion or incompletion,
let you see ```lib/src/elements```

# We are PR welcome ＼＼\\\\٩( 'ω' )و //／／