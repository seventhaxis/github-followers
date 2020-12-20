# Personal Notes

[![](https://img.shields.io/badge/Xcode-12.3-3d8af0?logo=xcode)](#) [![](https://img.shields.io/badge/Swift-5.3-FA7343?logo=swift)](#)

- toggle the simulator between dark and light mode with **⌘⇧A** (Cmd+Shift+A)
- configure asset to have light and dark mode versions within the _Attribute_ inspector panel
  - **Attributes Inspector** → **Appearance** → **Any, Dark**
- modifying the `appearance()` property of an element acts as a global configuration, affecting _all_ elements of that type with your project
- conform to dark mode preference by using the following `UIColor` options:
  - `.systemBackground`
  - `.secondarySystemBackground`
  - `.tertiarySystemBackground`
  - `.label`
  - `.secondaryLabel`
  - `.tertiaryLabel`
  - `.quaternaryLabel`

---

- [SemanticUI](https://github.com/cocoacontrols/SemanticUI): visualize all of iOS 13's semantic and adaptable colors, text styles, and built-in icons
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Human Interface Guidelines: [Modality](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/modality/)

## Retrospective
- Throughout the course, the instructor relied on padding constants in constraints instead of setting a view's layout margins or directional insets. I feel this made for some unnecessarily complex or sloppy code.
- Additionally, the instructor manually set the height of elements that include an intrinsic size (e.g. `UILabel`). In my opinion, it would be better to rely on that intrinsic value to adjust for user text size preferences.
