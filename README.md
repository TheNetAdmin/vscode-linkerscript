# LinkerScript Language Support for VSCode

This is the language support for LinkerScript for VSCode, provides syntax highlight.

It provides syntax highlight with [TmLanguage](https://macromates.com/manual/en/language_grammars) based on [regex](https://macromates.com/manual/en/regular_expressions) , without Abstract Syntax Tree (AST), thus some syntaxes and language features may not get correct highlight.

For source code, please visit [Github](https://github.com/TheNetAdmin/vscode-linkerscript).

## Develop

1. Install npm package `yamljs`
2. Edit rules in `*.yaml`
3. Use `yaml2json ***.yaml >***.json` to convert to json
4. Run with newly updated `***.json`

> Or you can use `F5` to run directly if `yamljs` is already installed globally, all configs are located at `.vscode/`

## Known issues

- **Lack of Multiline Match**: The regex expressions ought to match across lines to work with some syntax, but I currently cannot switch the `multiline` mode on. Maybe its related to issue [#13155](https://github.com/Microsoft/vscode/issues/13155), and if so, this feature [should be available now](https://github.com/BurntSushi/ripgrep/issues/176).
- **Misordered Syntax Highlight**: Due to the limitation of regex, some misordered options may not get highlight. If you wish to get support, please rearrange them according to [GNU Linker Script](https://sourceware.org/binutils/docs/ld/Scripts.html).

## Highlight preview

![Imgur](https://i.imgur.com/maONwsM.png)

## License

This project is released under MIT License.
