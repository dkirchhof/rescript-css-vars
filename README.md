# rescript-css-vars

## How to use

1. Define a record or object with all css variables.

```res
type colors = {
  fg: string,
  bg: string,
}

type fontSizes = {
  normal: string,
  big: string,
}

type theme = {colors: colors, fontSizes: fontSizes}
```

2. Use the `make` function to set all values.

```res
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
```

3. Inject the `values` string e.g. into the `:root` pseudo class.

```css
:root {
  ${values}
}
```

4. Use the `vars` record / object to get a css var.

```css
body {
  color: ${vars.colors.fg};
}
```

Example output:
```css
  :root {
    --colors_fg: white;
    --colors_bg: black;
    --fontSizes_normal: 1rem;
    --fontSizes_big: 1.5rem;
  }

  body {
    color: var(--colors_fg);
  }
```
