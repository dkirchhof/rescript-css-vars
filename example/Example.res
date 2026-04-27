type colors = {
  fg: string,
  bg: string,
}

type fontSizes = {
  normal: string,
  big: string,
}

type theme = {colors: colors, fontSizes: fontSizes}

let cssVars = CssVars.make({
  colors: {
    fg: "light-dark(black, white)",
    bg: "light-dark(white, black)",
  },
  fontSizes: {
    normal: "1rem",
    big: "1.5rem",
  },
})

let theme = cssVars.values
let vars = cssVars.vars

let printWithSpaces = (lines, spaces) => {
  lines
  ->String.split("\n")
  ->Array.map(line => String.repeat(" ", spaces) + line)
  ->Array.join("\n")
}

Console.log(
  `
:root {
${cssVars->CssVars.assignAll->printWithSpaces(2)}
}

body {
  color: ${theme.colors.fg};
  background: ${theme.colors.bg};

  font-size: ${theme.fontSizes.normal};
}

h1 {
  ${CssVars.override(vars.colors.fg, "red")}

  font-size: ${theme.fontSizes.big};
}`,
)
