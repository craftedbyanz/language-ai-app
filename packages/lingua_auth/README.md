# lingua_auth

Pure-Dart authentication session contracts and coordination. This package does
not choose an HTTP client, sign-in protocol or credential-storage plugin.

Applications provide `AuthGateway` and `AuthSessionStore`, then expose
`AuthSessionManager.accessToken`, `refreshAccessToken` and `expireSession` to the
network composition layer. Mobile stores must use platform-secure storage; web
storage requires an explicit threat model and backend cookie/token policy.
