import 'package:custom_markdown/custom_markdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          child: Markdown(
            body: text,
            style: MarkdownStyle(
              imageStyle: MarkdownImageStyle(captionBuilder: (caption) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    caption,
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

final text = """
# hello
## hello

### hello

#### hello


```

texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext

git push origin master

class MainActiveScreen extends StatelessWIdget {
  const MainActiveScreen();
  
  @overrride
  Widget build(BUidlCOnstext contexxt) {
    return Text("hello");
   }
}

```

![airy-swift account image](https://user-images.githubusercontent.com/61507019/133907465-121f3691-2fd7-4f85-ac1e-84795d9c0cc6.jpeg)


##### hello

###### hello


""";
