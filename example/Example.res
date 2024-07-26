type colors = {
  fg: string,
  bg: string,
}

type fontSizes = {
  normal: string,
  big: string,
}

type theme = {colors: colors, fontSizes: fontSizes}

let (values, vars) = CssVars.make({
  colors: {
    fg: "light-dark(black, white)",
    bg: "light-dark(white, black)",
  },
  fontSizes: {
    normal: "1rem",
    big: "1.5rem",
  },
})

let printWithSpaces = (lines, spaces) => {
  lines
  ->Js.String2.split("\n")
  ->Js.Array2.map(line => Js.String2.repeat(" ", spaces) ++ line)
  ->Js.Array2.joinWith("\n")
}

Js.log(
  `
  :root {
${printWithSpaces(values, 4)}
  }

  body {
    color: ${vars.colors.fg};
    background: ${vars.colors.bg};

    font-size: ${vars.fontSizes.normal};
  }

  h1 {
    font-size: ${vars.fontSizes.big};
  }
`,
)
