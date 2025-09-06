import chic
import gleam/javascript/promise
import gleam/result
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn create_highlighter_test() {
  use hl <- promise.await(chic.create_highlighter(["github-dark"], ["gleam"]))

  assert result.is_ok(hl) == True

  promise.resolve(hl)
}

pub fn create_highlighter_invalid_theme_test() {
  use hl <- promise.await(chic.create_highlighter(["test"], ["gleam"]))

  assert result.is_error(hl) == True

  promise.resolve(hl)
}

pub fn create_highlighter_invalid_lang_test() {
  use hl <- promise.await(chic.create_highlighter(["github-dark"], ["test"]))

  assert result.is_error(hl) == True

  promise.resolve(hl)
}

pub fn highlight_test() {
  use hl <- promise.await(
    chic.create_highlighter(["github-dark"], ["javascript"]),
  )

  let assert Ok(highlighter) = hl

  use html_js <- promise.await(chic.highlight(
    highlighter,
    "console.log('hello');",
    "javascript",
    "github-dark",
  ))

  assert result.is_ok(html_js) == True

  promise.resolve(html_js)
}

pub fn highlight_invalid_theme_test() {
  use hl <- promise.await(
    chic.create_highlighter(["github-dark"], ["javascript"]),
  )

  let assert Ok(highlighter) = hl

  use html_js <- promise.await(chic.highlight(
    highlighter,
    "console.log('hello');",
    "javascript",
    "github-light",
  ))

  assert result.is_error(html_js) == True

  promise.resolve(html_js)
}

pub fn highlight_output_test() {
  use hl <- promise.await(
    chic.create_highlighter(["github-dark"], ["javascript"]),
  )

  let assert Ok(highlighter) = hl

  use html_js <- promise.await(chic.highlight(
    highlighter,
    "console.log('hello');",
    "javascript",
    "github-dark",
  ))

  let assert Ok(html) = html_js

  assert html
    == "<pre class=\"shiki github-dark\" style=\"background-color:#24292e;color:#e1e4e8\" tabindex=\"0\"><code><span class=\"line\"><span style=\"color:#E1E4E8\">console.</span><span style=\"color:#B392F0\">log</span><span style=\"color:#E1E4E8\">(</span><span style=\"color:#9ECBFF\">'hello'</span><span style=\"color:#E1E4E8\">);</span></span></code></pre>"

  promise.resolve(html_js)
}
