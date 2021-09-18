

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'parser.dart';
part 'style.dart';
part 'elements/br.dart';
part 'elements/p.dart';
part 'elements/headline.dart';
part 'elements/code.dart';
part 'elements/image.dart';

class Markdown extends StatelessWidget {
  Markdown({required this.body, this.style}) {
    final parser = _MarkdownParser(body: body, markdowonStyle: style);
    markdonwBody = parser.parse();
  }

  final String body;

  final MarkdownStyle? style;

  late final List<Widget> markdonwBody;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: markdonwBody,
      ),
    );
  }
}