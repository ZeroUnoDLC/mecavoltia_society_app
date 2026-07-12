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

Backend local vía `docker-compose.dev.yml` de la raíz (roadmap paso 2). Scaffolding de la app en el roadmap paso 5.
