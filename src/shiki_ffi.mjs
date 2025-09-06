import { createHighlighter } from "shiki";
import { Ok, Error } from "./gleam.mjs";

export async function createHighlighterFFI(themes, languages) {
  try {
    const themesArray = themes.toArray();
    const languagesArray = languages.toArray();

    const highlighter = await createHighlighter({
      themes: themesArray,
      langs: languagesArray,
    });

    return new Ok(highlighter);
  } catch (error) {
    return new Error(`Failed to create highlighter: ${error.message}`);
  }
}

export async function codeToHtmlFFI(highlighter, code, lang, theme) {
  try {
    const html = highlighter.codeToHtml(code, {
      lang: lang,
      theme: theme,
    });

    return new Ok(html);
  } catch (error) {
    return new Error(error.message);
  }
}

// let highlighter = null;

// async function getHighlighter() {
//   if (!highlighter) {
//     highlighter = await createHighlighter({
//       themes: Object.keys(bundledThemes),
//       langs: Object.keys(bundledLanguages),
//     });
//   }
//   return highlighter;
// }

// export async function codeToHtmlFFI(code, lang, theme) {
//   try {
//     const hl = await getHighlighter();

//     // Check if theme is available before attempting to use it
//     const availableThemes = hl.getLoadedThemes();
//     if (!availableThemes.includes(theme)) {
//       return new Error(new HighlightError(`theme '${theme}' is not available`));
//     }

//     return new Ok(
//       hl.codeToHtml(code, {
//         lang: lang,
//         theme: theme,
//       }),
//     );
//   } catch (error) {
//     return new Error(
//       new HighlightError(`highlighting failed: ${error.message}`),
//     );
//   }
// }
