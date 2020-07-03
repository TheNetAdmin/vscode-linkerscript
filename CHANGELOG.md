# Change Log

All notable changes to the "linkerscript" extension will be documented in this file.

## [1.0.1]

- Fix path bug [#1](https://github.com/TheNetAdmin/vscode-linkerscript/pull/1)

## [1.0.0]

- Initial release
- Support syntax according to [GNU Linker Script](https://sourceware.org/binutils/docs/ld/Scripts.html)

### Known issues

- **Lack of Multiline Match**: The regex expressions ought to match across lines to work with some syntax, but I currently cannot switch the `multiline` mode on. Maybe its related to issue [#13155](https://github.com/Microsoft/vscode/issues/13155), and if so, this feature is [under developed](https://github.com/BurntSushi/ripgrep/issues/176).
- **Misordered Syntax Highlight**: Due to the limitation of regex, some misordered options may not get highlight. If you wish to get support, please rearrange them according to [GNU Linker Script](https://sourceware.org/binutils/docs/ld/Scripts.html).