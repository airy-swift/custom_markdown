
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

part 'parser.dart';
part 'style.dart';
part 'elements/br.dart';
part 'elements/hr.dart';
part 'elements/p.dart';
part 'elements/headline.dart';
part 'elements/check_box.dart';
part 'elements/block_quote.dart';
part 'elements/table.dart';
part 'elements/code.dart';
part 'elements/note.dart';
part 'elements/image.dart';
part 'elements/a.dart';
part 'elements/b.dart';
part 'elements/i.dart';
part 'elements/ul.dart';
part 'elements/ol.dart';

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