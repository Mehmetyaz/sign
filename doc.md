# Sign Package Documentation

## Introduction

Sign is a lightweight state management solution that follows the signal-slot pattern. It provides a simple way to handle state changes and reactive programming in Dart applications.

## Basic Usage

### Creating a Signal

1. **Direct Creation**

   ```dart
   final mySignal = Signal<int>(0);
   ```

2. **Using Extension**

   ```dart
   final mySignal = 0.signal;
   ```

3. **Custom Signal Class**
   ```dart
   class CounterSignal extends Signal<int> {
     CounterSignal() : super(0);
   }
   ```

### Creating a Slot

1. **Using Mixin**

   ```dart
   class MySlot with Slot<int> {
     void onValue(int value) {
       // Handle value change
     }
   }
   ```

2. **Quick Handler**
   ```dart
   final mySlot = SlotWithHandler<int>((value) {
     // Handle value change
   });
   ```

### Connecting Signals and Slots

```dart
// Add slot to signal
mySignal.addSlot(mySlot);

// Remove when done
mySignal.removeSlot(mySlot);
```

## Advanced Features

### 1. Global State Management

Global signals allow you to manage application-wide state:

```dart
// Create global signal
final globalCounter = 0.globalSignal;

// Create global slot
class MyGlobalSlot extends GlobalSlot<int, GlobalCounter> {
  void onValue(int value) {
    // Handle global updates
  }
}
```

### 2. Collection Management

For Lists:

```dart
// Create signal list
final items = <String>[].signalList;

// Modifications automatically trigger slots
items.add('item');
items.remove('item');
```

For Maps:

```dart
// Create signal map
final data = <String, int>{}.signalMap;

// Modifications automatically trigger slots
data['key'] = 1;
data.remove('key');
```

### 3. Multiple Signal Handling

When you need to respond to multiple signals:

```dart
// Method 1: Direct MultiSignal creation
final combinedSignal = MultiSignal([signal1, signal2]);
combinedSignal.addSlot(mySlot);

// Method 2: Using List extension
final signals = <Signal<int>>[
  counterSignal,
  timerSignal,
  scoreSignal
];

// Convert the list of signals into a MultiSignal
final combinedSignal = signals.multiSignal;
combinedSignal.addSlot(SlotWithHandler((_) {
  // This will be called when ANY of the signals change
  print('One of the signals changed!');
}));
```

The `multiSignal` extension is particularly useful when:

- You have a dynamic list of signals
- You want to monitor multiple related signals as one
- You need to combine signals of the same type
- You want to create a single point of observation for multiple state changes

Example with dynamic signals:

```dart
class GameState {
  final List<Signal<PlayerScore>> playerScores = [];
  late final MultiSignal scoreUpdates;

  void initializeScores(int playerCount) {
    for (int i = 0; i < playerCount; i++) {
      playerScores.add(PlayerScore(0).signal);
    }

    // Monitor all player scores with a single slot
    scoreUpdates = playerScores.multiSignal;
    scoreUpdates.addSlot(SlotWithHandler((_) => updateScoreboard()));
  }
}
```

## Best Practices

1. **Signal Management**

   - Keep signals focused on single responsibilities
   - Dispose of signals when no longer needed
   - Use value equality checks for efficient updates

2. **Slot Management**

   - Remove slots when they're no longer needed
   - Keep slot logic simple and focused
   - Consider using SlotWithHandler for simple cases

3. **Global Signals**

   - Use sparingly for truly global state
   - Consider scoped alternatives when possible
   - Handle registration/unregistration properly

4. **Performance**
   - Use SignalList and SignalMap for collections
   - Avoid unnecessary signal emissions
   - Clean up unused slots and signals

## Common Use Cases

1. **Form State Management**

   ```dart
   final formField = ''.signal;
   formField.addSlot(SlotWithHandler((value) => validateField(value)));
   ```

2. **Counter Example**

   ```dart
   final counter = 0.signal;
   counter.addSlot(SlotWithHandler((count) => updateUI(count)));
   ```

3. **Collection Management**
   ```dart
   final todoList = <String>[].signalList;
   todoList.addSlot(SlotWithHandler((_) => refreshTodoUI()));
   ```

## Tips and Tricks

1. **Conditional Updates**

   - Use custom signal classes for complex update logic
   - Implement custom equality checks when needed

2. **Error Handling**

   - Wrap slot handlers in try-catch blocks
   - Provide error recovery mechanisms

3. **Testing**
   - Create mock signals for testing
   - Test slot behavior independently
   - Verify signal-slot connections

## Limitations

1. **Thread Safety**

   - Package is not thread-safe by default
   - Implement your own synchronization if needed

2. **Memory Management**

   - Remember to remove slots when not needed
   - Be cautious with global signals lifecycle

3. **Value Types**
   - Consider immutable types for signal values
   - Be aware of reference type implications

## Migration Guide

### From Other State Management Solutions

1. **From ChangeNotifier**

   - Replace notifyListeners() with signal emissions
   - Convert listeners to slots

2. **From Streams**

   - Replace StreamController with signals
   - Convert StreamSubscription to slots

3. **From GetX**
   - Replace Rx variables with signals
   - Convert .obs to .signal

```

```
