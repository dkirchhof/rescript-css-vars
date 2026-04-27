type cssVars<'a> = {
  assignments: array<(string, string)>,
  vars: 'a,
  values: 'a,
}

let make: 'a => cssVars<'a>
let assignAll: cssVars<'a> => string
let override: (string, string) => string
