import 'package:TesUjian/src/model/tryout.dart';
import 'package:flutter/material.dart';

class TryoutParent extends InheritedWidget {
  const TryoutParent({
    Key key,
    @required this.tryoutModel,
    @required Widget child,
  })  : assert(tryoutModel != null),
        assert(child != null),
        super(key: key, child: child);

  final TryoutModel tryoutModel;

  static TryoutParent of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TryoutParent>();
  }

  @override
  bool updateShouldNotify(TryoutParent old) => tryoutModel != old.tryoutModel;
}
