# ADR-0008: Persist the app language as a device preference

- Status: Accepted
- Date: 2026-10-12

## Context

`SettingsDetailTemplate/Language` lets a person choose the language of app
controls and navigation. Losing that choice at every restart makes the control
misleading. The existing Flutter and Dart dependencies provide localization but
no durable, cross-platform key-value preference API. ADR-0006 deferred storage
until a concrete feature needed it; this language choice is that requirement.

## Decision

Use `shared_preferences` for the single non-sensitive `app.locale` value. Use
`SharedPreferencesAsync` so reads are not taken from an isolate-local cache.
Read before the first app frame, and fall back to the device locale if the
stored value is missing, unsupported or cannot be read. Apply the selection
only after the explicit Settings CTA and a successful write. Keep the store
behind `LocalePreferenceStore` so widgets and tests use a fake.

`shared_preferences` is maintained by the Flutter team and supports Android,
iOS, macOS and web. Flutter's own APIs do not persist this value, while custom
platform channels would require separate implementations and maintenance on
every target. This is a preference adapter, not an offline product database.
Credentials, lesson content, SRS scheduling and backend-owned state do not use
this store.

## Consequences

Bootstrap becomes asynchronous. The platform plugin and its endorsed platform
implementations are added to the root application only. Tests can inject a
memory store. A failed write leaves the selected language unchanged and shows
localized feedback. The plugin is unsuitable for critical data because writes
are not guaranteed to reach disk immediately.

Reference: https://pub.dev/packages/shared_preferences
