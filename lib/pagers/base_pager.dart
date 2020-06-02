import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void _IWidgetLifeCycle();

typedef void _IWidgetLifeCycleWithParam<T>(T value);

typedef Widget _ICreateContentView(BuildContext context);

// ignore: must_be_immutable
abstract class BasePager extends StatefulWidget {
  _BasePagerState _state;

  @override
  State<StatefulWidget> createState() {
    return _state = _BasePagerState(
        title: title(),
        initStateCallBack: initState,
        didChangeDependenciesCallBack: didChangeDependencies,
        createContentView: createContent,
        deactivateCallBack: deactivate,
        disposeCallBack: dispose,
        didUpdateWidgetCallBack: didUpdateWidget);
  }

  void setState(VoidCallback callback) {
    // ignore: invalid_use_of_protected_member
    _state.setState(callback);
  }

  void initState() {
    print("页面启动==>"+title());
  }

  void didChangeDependencies() {}

  void didUpdateWidget(BasePager oldWidget) {}

  void deactivate() {}

  void dispose() {}

  Widget createContent(BuildContext context);

  String title();
}

class _BasePagerState extends State<BasePager> {
  final String title;
  final _ICreateContentView createContentView;
  final _IWidgetLifeCycle initStateCallBack;
  final _IWidgetLifeCycle didChangeDependenciesCallBack;
  final _IWidgetLifeCycle deactivateCallBack;
  final _IWidgetLifeCycle disposeCallBack;
  final _IWidgetLifeCycleWithParam<BasePager> didUpdateWidgetCallBack;

  _BasePagerState(
      {this.title,
      this.createContentView,
      this.initStateCallBack,
      this.didChangeDependenciesCallBack,
      this.deactivateCallBack,
      this.disposeCallBack,
      this.didUpdateWidgetCallBack});

  @override
  void initState() {
    super.initState();
    initStateCallBack();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    didChangeDependenciesCallBack();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(title),
            ),
          body: createContentView(context),
        ));
  }

  @override
  void didUpdateWidget(BasePager oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgetCallBack(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
    deactivateCallBack();
  }

  @override
  void dispose() {
    super.dispose();
    disposeCallBack();
  }
}
