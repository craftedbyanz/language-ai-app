# API boundary

The Go backend is a separate repository. Future flow:

`Go backend → OpenAPI → generated Dart client → service adapter → repository implementation → domain/application → ViewModel → View`.

`lib/generated/api/` is reserved for disposable generated output. It contains no fabricated schema, models or service. `core/network/` documents shared transport ownership; feature-specific service adapters belong with the feature's data layer. No HTTP stack, mapper or OpenAPI generator is needed without a real contract.

Repositories own application data truth; adapters isolate external transports. Presentation never imports generated clients, even via convenience re-exports. Domain remains pure Dart. Translate failures into Result/AppFailure at repository boundaries when actual integration arrives; UI must not parse exception strings.

Backend resolves scoring, grading, completion, entitlement and server SRS scheduling. The client handles rendering, navigation, drafts, preferences and safe caches. Mutations have explicit retry, never automatic retry. Introduce authentication/secure storage only with a real requirement.
