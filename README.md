# mecavoltia_society_app

App móvil (Flutter) de administración para los socios de Mecavoltia. Desde acá Cristhian, Fernando y Brayan gestionan el portafolio y sus perfiles públicos. **No es una app para clientes**: solo 3 usuarios, autenticados por email + contraseña, sin registro público.

> Reglas de arquitectura, tipado y estilo: ver [rules.md](./rules.md) — **cumplimiento obligatorio**.

## Stack

| Capa | Tecnología | Por qué |
| --- | --- | --- |
| Framework | Flutter | Multiplataforma Android/iOS con un solo código |
| Estado / DI | **Riverpod** (`AsyncNotifier` + code generation) | Menos boilerplate que Bloc, DI compile-safe, encaja natural con clean architecture para una app CRUD chica |
| Modelos | freezed + json_serializable | Inmutabilidad y serialización sin código a mano |
| HTTP | dio (+ interceptor de refresh automático de tokens) | Interceptors, tipado de errores |
| Navegación | go_router | Rutas declarativas con guards de sesión |
| Storage seguro | flutter_secure_storage | Tokens en Keychain/Keystore, jamás en SharedPreferences |

## Features (fase 1)

| Feature | Funcionalidad |
| --- | --- |
| `auth` | Login email + contraseña contra `/api/auth/*`, refresh automático, logout |
| `portfolio` | CRUD de trabajos: título/descr. en es+en, categoría, subir/ordenar imágenes, publicar/despublicar |
| `profile` | Editar perfil propio: foto, bio es/en, LinkedIn, subir CV |

Consume la API vía el gateway: `/api/auth/*` (identidad) y `/api/*` (contenido), con el JWT en `Authorization`.

## Reglas de negocio clave

- Cada socio edita **solo su propio perfil** (lo autoriza el backend por el `sub` del token; la app además oculta lo ajeno).
- Los trabajos del portafolio son de la sociedad: cualquier socio puede crearlos y editarlos.
- Sesión persistente con refresh token rotativo; si el refresh falla, logout limpio a la pantalla de login.

## Ejecución

1. Levantar el stack: `docker compose -f docker-compose.dev.yml up -d` (raíz del workspace).
2. Correr la app:

```sh
flutter run -d windows    # escritorio, apunta a http://localhost
flutter run               # emulador Android, apunta a http://10.0.2.2 automáticamente
```

**URL de la API**: se configura en [assets/config.env](assets/config.env) → `API_BASE_URL` (para teléfono físico en la LAN: la IP de tu PC, ej. `http://192.168.0.104`; vacío = default por plataforma). `--dart-define=API_BASE_URL=...` la sobreescribe si hace falta.

> Teléfono físico: además del mismo WiFi, el firewall de Windows debe permitir el puerto 80 entrante en redes privadas (una vez, como administrador): `netsh advfirewall firewall add rule name="Mecavoltia dev 80" dir=in action=allow protocol=TCP localport=80 profile=private`. Probá primero `http://TU_IP/es` en el navegador del teléfono: si la web carga, la app conecta.

Credenciales de desarrollo: email de cada socio (`brayan@mecavoltia.com`, etc.) con la contraseña que hayas puesto en `SEED_PASSWORD_*` al correr el seed del auth service.

Tras tocar modelos o providers: `dart run build_runner build --delete-conflicting-outputs`. Verificación: `flutter analyze && flutter test`.
