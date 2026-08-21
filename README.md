# DeepSeek Harness en Coolify (Oracle ARM)

Despliegue mínimo de DeepSeek Harness (dsh) en Coolify usando Docker Compose. No es necesario clonar el repo oficial de DeepSeek Harness.

## Variables de entorno

Configura estas variables en Coolify → Environment Variables:

- `OPENAI_API_BASE` = `http://9router:3000/v1` (o `http://9router-<uuid>:3000/v1` si está en otro stack de Coolify)
- `OPENAI_BASE_URL` = `http://9router:3000/v1` (o `http://9router-<uuid>:3000/v1`)
- `OPENAI_API_KEY` = `sk-2d4e263986bedbff-jgk4jd-afd2703a`
- `OPENAI_MODEL` = `9r9r`

## Deploy en Coolify

1. Crea un nuevo recurso desde **Public Repository** y apunta a este repo.
2. Elige **Build Pack: Docker Compose**.
3. Base Directory: `/`
4. Docker Compose file location: `docker-compose.yml`
5. Añ¡¡¡ade las variables de entorno arriba.
6. En **Domains**, asigna `https://dh.coolif.qzz.io:3080` al servicio `proxy` en el puerto `80`.

## Acceso

- **IP directa**: `http://193.122.1.163:3080`
- **Coolify domain**: `https://dh.coolif.qzz.io:3080`

El proxy nginx escucha en el puerto 80 del contenedor (mapeado a 3080 en el host) y redirige a deepseek-harness:3080.

## Notas sobre 9router

- Si `9router` está en otro stack de Coolify: usa `http://9router-<uuid>:3000/v1`
- Activa **Connect to Predefined Network** en deepseek-harness para conectar con 9router.

## Notas técnicas

- Para Oracle ARM, esta imagen usa `node:22-bookworm-slim`, que tiene soporte `linux/arm64`.
- dsh se instala globalmente en el build para evitar problemas con npx en runtime.
- El flag --host no se usa porque dsh no lo permite (solo acepta 127.0.0.1 por seguridad).
- nginx actua como proxy inverso para exponer el servicio externamente.
