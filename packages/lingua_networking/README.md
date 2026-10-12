# lingua_networking

Shared Dio transport for Lingua applications. `DioClientFactory` applies typed
timeouts and `AuthInterceptor` accepts token/session callbacks, so this package
never imports `lingua_auth`.

Set `AuthInterceptor.skipAuthenticationKey` for login and refresh calls. A 401
automatically refreshes and replays only GET, HEAD and OPTIONS. A mutation must
set `AuthInterceptor.retryAfterRefreshKey` deliberately after confirming that
replay is safe and idempotent.
