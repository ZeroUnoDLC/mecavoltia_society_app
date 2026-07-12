# Reglas del proyecto — mecavoltia_society_app

Reglas **estrictas y de cumplimiento obligatorio** para la app Flutter de los socios.

## 1. Arquitectura: clean architecture por feature

```
lib/
├── core/
│   ├── network/         # Cliente dio, interceptores (auth, refresh, logging), errores de red
│   ├── router/          # go_router, guards de sesión
│   ├── storage/         # Wrapper de flutter_secure_storage
│   ├── theme/           # Design tokens: colores, tipografía, espaciado
│   └── errors/          # Failures base
└── features/
    └── portfolio/
        ├── domain/          # Entidades (freezed), contratos de repositorio, use cases
        ├── data/            # DTOs, datasources (API), implementación de repositorios
        └── presentation/    # Providers/Notifiers (Riverpod), screens, widgets
```

### Regla de dependencias

```
presentation → domain ← data
```

- `domain` es Dart puro: sin Flutter, sin dio, sin Riverpod. Entidades + contratos + use cases.
- `data` implementa los contratos de `domain`. Es la única capa que conoce dio y los DTOs de la API.
- `presentation` consume use cases a través de providers. Jamás llama a un datasource directo.
- Una feature no importa de otra feature; lo común se promueve a `core`.
- DTO ≠ entidad: los DTOs (`data`) se mapean a entidades (`domain`) en el repositorio. La UI jamás ve un DTO.

## 2. Estado: Riverpod (decisión cerrada)

- `AsyncNotifier` / `Notifier` con **code generation** (`@riverpod`). Nada de `StateProvider` sueltos para lógica de negocio.
- DI por providers: repositorios y use cases se exponen como providers; `presentation` los lee con `ref`.
- Estado de pantalla = `AsyncValue<T>`: loading/error/data se renderizan con `when`, sin banderas booleanas manuales (`isLoading`).
- Prohibido `setState` para estado de negocio (solo micro-estado visual local).

## 3. Tipado y estilo

- `analysis_options.yaml` con **very_good_analysis** como base. El linter no se silencia: se corrige el código.
- **Prohibido `dynamic`** y prohibido `as` sin chequeo previo (`is`).
- Modelos con **freezed**: inmutables, `copyWith`, uniones selladas para estados y errores (`sealed class Failure`).
- Naming: snake_case en archivos con sufijo de rol (`work_repository.dart`, `login_screen.dart`, `work_card.dart`); PascalCase en tipos; camelCase en miembros.
- Widgets chicos y componibles; si un `build` supera ~80 líneas, se extraen widgets (widgets privados o archivo propio, jamás métodos `_buildXxx`).
- Todo texto visible sale de un archivo de strings centralizado (la app es interna: español solamente, pero sin literales sueltos en widgets).

## 4. Seguridad

- Tokens **solo** en `flutter_secure_storage` (Keychain/Keystore). Prohibido SharedPreferences para credenciales.
- Refresh automático en interceptor de dio con lock (un solo refresh concurrente); si el refresh falla → limpiar sesión → login.
- Nunca loguear tokens ni contraseñas, tampoco en modo debug.
- Sin registro público ni "recordar contraseña" casero.

## 5. Errores

- `data` captura excepciones (dio, parsing) y las convierte en `Failure`s tipados de `domain`.
- `presentation` mapea `Failure` → mensaje al usuario. Un `catch` genérico que traga errores es una violación.

## 6. Testing

- **TDD estricto.** Use cases y notifiers: tests unitarios con repositorios falsos (overrides de providers de Riverpod).
- Repositorios: tests con datasources falsos (fixtures JSON reales de la API).
- Flujos críticos con widget tests: login OK, login fallido, sesión expirada → redirect a login.

## 7. Commits

- Conventional commits en inglés (`feat(portfolio): add image reorder`).
- Sin atribución de IA.
