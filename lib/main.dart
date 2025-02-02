import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MethodChannel methodChannel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const viewType = 'text_field_error';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText:"Flutter TextFild")
            ),
            Container(
              height: 100,
              child: PlatformViewLink(
                      viewType: viewType,
                      surfaceFactory: (context, controller) =>
                          AndroidViewSurface(
                        controller: controller
                            // ignore: avoid_as
                            as AndroidViewController, // TODO get rid of casting?
                        gestureRecognizers: const <
                            Factory<OneSequenceGestureRecognizer>>{},
                        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                      ),
                      onCreatePlatformView: (params) {
                        return PlatformViewsService.initSurfaceAndroidView(
                          id: params.id,
                          viewType: viewType,
                          layoutDirection: TextDirection.ltr,
                          creationParamsCodec: const StandardMessageCodec(),
                        )
                          ..addOnPlatformViewCreatedListener(
                              params.onPlatformViewCreated)
                          ..create();
                      },
                    ),
            ),
          ],
        ),
      ),
      
    );
  }
}
