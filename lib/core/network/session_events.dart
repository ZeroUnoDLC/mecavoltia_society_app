import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_events.g.dart';

/// Canal de eventos de sesión: el interceptor avisa "sesión expirada"
/// sin conocer al AuthController (evita la dependencia circular dio ↔ auth).
class SessionEvents {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get expired => _controller.stream;

  void notifyExpired() => _controller.add(null);

  void dispose() => unawaited(_controller.close());
}

@Riverpod(keepAlive: true)
SessionEvents sessionEvents(Ref ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
}
