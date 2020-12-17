# Personal Notes

[![](https://img.shields.io/badge/Xcode-12.3-3d8af0?logo=xcode)](#) [![](https://img.shields.io/badge/Swift-5.3-FA7343?logo=swift)](#)

- toggle the simulator between dark and light mode with **⌘⇧A** (Cmd+Shift+A)
- configure asset to have light and dark mode versions within the _Attribute_ inspector panel
  - **Attributes Inspector** ➡ **Appearance** ➡ **Any, Dark**
- modifying the `appearance()` property of an element acts as a global configuration, affecting _all_ elements of that type with your project
- conform to dark mode preference by using the following `UIColor` options:
  - `.systemBackground`
  - `.secondarySystemBackground`
  - `.tertiarySystemBackground`
  - `.label`
  - `.secondaryLabel`
  - `.tertiaryLabel`
  - `.quaternaryLabel`
- 

- **SemanticUI**: visualize all of iOS 13's semantic and adaptable colors, text styles, and built-in icons
  - https://github.com/cocoacontrols/SemanticUI
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- **Human Interface Guidelines:** [Modality](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/modality/)
