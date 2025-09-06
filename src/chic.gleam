import gleam/javascript/promise.{type Promise}

pub type Highlighter

@external(javascript, "./shiki_ffi.mjs", "createHighlighterFFI")
pub fn create_highlighter(
  themes: List(String),
  languages: List(String),
) -> Promise(Result(Highlighter, String))

@external(javascript, "./shiki_ffi.mjs", "codeToHtmlFFI")
pub fn highlight(
  highlighter: Highlighter,
  code: String,
  lang: String,
  theme: String,
) -> Promise(Result(String, String))
