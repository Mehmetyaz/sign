[![pub package](https://img.shields.io/pub/v/yaz.svg)](https://pub.dev/packages/yaz)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/MehmetYaz/sign)

# Sign

Basic state management base for dart. Sign inspired QT framework signal-slot architecture.

This package is supported all platforms include dart sdk.

For Flutter: [sign_flutter](https://pub.dev/packages/sign_flutter)

Flutter package has some Widgets for signal and some extensions to generate signal from ``ChangeNotifier``
and ``ValueNotifier``.

## 1) What is Signal?

Signal is simply a class that triggers a function when its value changes (or on request).

In this regard, ``Signal`` is very similar to Flutter's ChangeNotifier or ValueNotifier, GetX's observable, or
Provider's StateNotifier.

Signal has some minor differences. First it is independent of Flutter. And its so simple, it lacks the long lines of
code that control so many cases.

It also works with `Slot` instead of callbacks.

Basically there are only **3 things**:

#### 1. ``Signal`` : Signal has a ``value``. This is the class that triggers the function when ``value`` changes or `sign()` called.

#### 2. ``Slot`` : Slot can be added to desired Signals. Signal triggers are handled with ``Slot.onValue`` when added to a Signal.

#### 3. ``MultiSignal`` : MultiSignal is both a Slot and a Signal. It collects triggers from different Signals as one Slot and works like a single Signal.

![Architecture](https://github.com/Mehmetyaz/sign/blob/master/documentation/signal-slot.jpeg?raw=true)

## How To Use?

1. Define a ``Signal`` implementation or create a ``Signal`` from any variable.

````dart

/// Create a Signal from a variable
final Signal<int> signal = 0.signal;

void f() {
  signal.value++;
  // OR
  signal.sign();
}

/// Define signal implementation
class MySignal extends Signal<int> {
  MySignal() : super(0);

  void changeSomething() {
    // Change signal value to trigger signal
    value = newValue;

    // Or use sign() to trigger signal
    sign();
  }
}
````

2. Define a ``Slot`` implementation.

````dart

class MySlot extends Slot<int> {
  MySlot() : super();

  @override
  void onValue(int value) {
    // Do something
  }
}
````

In Flutter you can create states that are themselves a slot. You can use aSignal.builder() or SlotWidget for this.

3. Add a ``Slot`` to a ``Signal``.

````dart
void f() {
  // Add a Slot to a Signal
  signal.addSlot(MySlot());
}
````

### Special Signal Classes

If you want to trigger changes on List and Map, you don't need to use an expression like `value = newList`.

Statements like these reduce performance significantly.

You can use ``SignalList`` and ``SignalMap`` instead.

SignalList and SignalMap trigger a signal in any case that changes the collection content.

```dart

final signalList = <int>[].signalList;
final signalMap = <String,String>{}.signalMap;
void f() {
  signalList.add(1); // triggered

  signalList.remove(1); // triggered

  signalList.clear(); // triggered

  signalList[0] = 10; // triggered
  
  signalMap['a'] = 'b'; // triggered
  
  signalMap.remove('a'); // triggered
  
}
```

To create a SignalList, use ``SignalList`` constructors or create with `list.signalList`.

To create a SignalMap, use ``SignalMap`` constructors or create with `map.signalMap`.


# GlobalSignal / GlobalSlot

``GlobalSlot``s are triggered by changes in same generic type ``GlobalSignal`` without the 
need to add to GlobalSignals.

GlobalSignal must be created only once or disposed before creating a new instance.

```dart
void main(){
  var globalCounter = GlobalCounter();

  GlobalCountSlot('a');
  GlobalCountSlot('b');
  GlobalCountSlot('c');
  GlobalCountSlot('d');
  GlobalCountSlot('e');
  
  
  globalCounter.value++;
  // GlobalCountSlot 'a', 'b', 'c', 'd', 'e' triggered
}

class GlobalCounter extends GlobalSignal<int> {
  GlobalCounter() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }
}

class GlobalCountSlot extends GlobalSlot<int, GlobalCounter> {
  GlobalCountSlot(this.name);

  String name;

  @override
  void onValue(int value) {
    print('GlobalCountSlot :  $name : $value');
  }
}
````