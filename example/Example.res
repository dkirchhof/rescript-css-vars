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
    fg: "black",
    bg: "white",
  },
  fontSizes: {
    normal: "1rem",
    big: "1.5rem",
  },
})

Js.log(
  `
  :root {
    ${values}
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
