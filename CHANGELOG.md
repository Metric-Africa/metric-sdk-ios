# Changelog

All notable changes to the **MetricSDK** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2026-05-20

### Removed
- **OpenSSL Dependency**: Completely removed `OpenSSL-Universal` and its accompanying static/dynamic libraries (`OpenSSL.xcframework`) from the codebase, resolving security and vulnerability issues.

### Changed
- **NFC Cryptography Stubs**: Stubbed out OpenSSL-dependent functions (`aesMAC`, `oidToBytes`, and public key parsing in `DataGroup15` / `NFCPassportModel`) to safely bypass OpenSSL without breaking the core SDK compile targets.
- **Example App Embedding**: Explicitly added `iProov.xcframework` and `OZLivenessSDK.xcframework` to the **Embed Frameworks** build phase of the `Example` app target to resolve dynamic link (`dyld`) runtime launching crashes.

### Fixed
- **Error Redeclaration**: Resolved the conflict of the `OpenSSLError` enum redeclaration in `NFCPassportReaderError.swift` and `OpenSSLUtils.swift`.
- **Project Configuration Cleanliness**: Purged lingering build configurations, header, and runtime search paths (`LD_RUNPATH_SEARCH_PATHS`) associated with `OpenSSL-Universal`.

---

## [1.0.701] - 2026-02-15

### Fixed
- Minor bug fixes.

---

## [1.0.700] - 2026-01-08

### Changed
- Minor improvements and user interface changes.

---

## [1.0.600] - 2025-12-08

### Changed
- Minor improvements and user interface changes.

---

## [1.0.5057] - 2024-12-08

### Added
- Extended and basic data modes for additional information on the verification success screen.

---

## [1.0.505] - 2024-07-30

### Added
- Extra error display dialog for invalid sessions.

### Changed
- Verification success screen no longer displays personal details.

### Fixed
- Minor internal improvements.

---

## [1.0.503] - 2024-05-24

### Added
- Added `PrivacyInfo` privacy manifest file.
- Added sheet detailing selfie taking tips.
- Support for more vendors.

### Changed
- Dropped minimum iOS deployment target to iOS 12.X+.

### Fixed
- Minor internal improvements.

---

## [1.0.502] - 2024-05-18

### Added
- Added sheet detailing selfie taking tips.
- Support for more vendors.

### Changed
- Dropped minimum iOS deployment target to iOS 12.X+.

---

## [1.0.401] - 2024-03-19

### Changed
- Minor user interface changes.

---

## [1.0.4] - 2024-02-02

### Changed
- Minor enhancements and user interface polish.

---

## [1.0.3] - 2024-01-09

### Added
- Added the ability to `POST` the generated token directly to a custom URL.
- Added exception handling for `null` cases in `successHandler` and `errorHandler`.

---

## [1.0.2] - 2024-01-01

### Added
- Added CocoaPods support for integration.

### Changed
- Reorganized the directory structure of bindings to make installation simpler.

---

## [1.0.0] - 2023-12-16

### Added
- Initial release of MetricSDK.
