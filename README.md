# chic

[![Package Version](https://img.shields.io/hexpm/v/chic)](https://hex.pm/packages/chic)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/chic/)
![JavaScript-compatible](https://img.shields.io/badge/target-javascript-f1e05a)

Type safe bindings for [Shiki](https://shiki.style/).

This is very early and experimental, expect breaking changes.

```sh
npm install shiki
```

```sh
gleam add chic@1
```

```gleam
import chic
import gleam/io
import gleam/javascript/promise.{type Promise}

pub fn main() {
  use hl <- promise.await(
    chic.create_highlighter(["github-dark", "vitesse-dark"], [
      "javascript",
      "go",
      "gleam",
    ]),
  )

  let assert Ok(highlighter) = hl

  use html_js <- promise.await(chic.highlight(
    highlighter,
    "console.log('hello');",
    "javascript",
    "github-dark",
  ))

  case html_js {
    Ok(html) -> io.println(html)
    Error(e) -> {
      io.println(e)
    }
  }

  promise.resolve(Nil)
}
```

Further documentation can be found at <https://hexdocs.pm/chic>.

## Development

```sh
gleam test  # Run the tests
```
