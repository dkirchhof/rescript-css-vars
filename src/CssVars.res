@unboxed
type rec value =
  | String(string)
  | Object(dict<value>)

type cssVars<'a> = {
  assignments: array<(string, string)>,
  vars: 'a,
  values: 'a,
}

let rec traverse = (theme, path) => {
  let assignments = []
  let vars = Dict.make()
  let values = Dict.make()

  theme
  ->Dict.toArray
  ->Array.forEach(((key, value)) => {
    switch value {
    | String(value) => {
        let var = `--${path}${key}`

        Array.push(assignments, (var, value))
        Dict.set(vars, key, String(var))
        Dict.set(values, key, String(`var(${var})`))
      }
    | Object(value) => {
        let (subAssignments, subVars, subValues) = traverse(value, `${path}${key}-`)

        Array.pushMany(assignments, subAssignments)
        Dict.set(vars, key, Object(subVars))
        Dict.set(values, key, Object(subValues))
      }
    }
  })

  (assignments, vars, values)
}

let make = values => {
  let (assignments, vars, values) = traverse(Obj.magic(values), "")

  {
    assignments,
    vars: Obj.magic(vars),
    values: Obj.magic(values),
  }
}

let assignAll = cssVars => {
  cssVars.assignments->Array.map(((var, value)) => `${var}: ${value};`)->Array.join("\n")
}

let override = (var, value) => {
  `${var}: ${value};`
}
