[![pub package](https://img.shields.io/pub/v/yaz.svg)](https://pub.dev/packages/yaz)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/MehmetYaz/sign)


# Sign

Basic state management base for dart. Sign inspired QT framework signal-slot architecture.


This package is supported all platforms include dart sdk.

For Flutter: [sign_flutter](https://pub.dev/packages/sign_flutter)

Flutter package has some Widgets for signal and some extensions to generate
signal from ``ChangeNotifier`` and ``ValueNotifier``.

#### 1) What is Signal?

Signal is simply a class that triggers a function when its value changes (or on request).

In this regard, ``Signal`` is very similar to Flutter's ChangeNotifier or ValueNotifier,
GetX's observable, or Provider's StateNotifier.

Signal has some minor differences. First it is independent of Flutter. And its so simple, 
it lacks the long lines of code that control so many cases. 

It also works with `Slot` instead of callbacks.


