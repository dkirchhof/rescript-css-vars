@unboxed type rec value = String(string) | Object(Js.Dict.t<value>)

let rec traverse = (theme, path) => {
  let values = []
  let vars = Js.Dict.empty()

  theme
  ->Js.Dict.entries
  ->Js.Array2.forEach(((key, value)) => {
    switch value {
    | String(value) => {
        Js.Array2.push(values, `--${path}${key}: ${value};`)->ignore
        Js.Dict.set(vars, key, String(`var(--${path}${key})`))
      }
    | Object(value) => {
        let (subValues, subVars) = traverse(value, `${path}${key}_`)

        Js.Array2.pushMany(values, subValues)->ignore
        Js.Dict.set(vars, key, Object(subVars))
      }
    }
  })

  (values, vars)
}

let make = (theme: 'a): (string, 'a) => {
  let (values, vars) = theme->Obj.magic->traverse("")

  (Js.Array2.joinWith(values, "\n"), Obj.magic(vars))
}

// const traverse = <T extends Record<string, Record<string, string>>>(theme: T): { values: string[], vars: T; } => {
//     const values: string[] = [];
//     const vars: Record<string, Record<string, string>> = {};

//     Object.entries(theme).forEach(([key, value]) => {
//         vars[key] = {};

//         Object.entries(value).forEach(([subKey, subValue]) => {
//              values.push(`--${key}-${subKey}: ${subValue};`);
//              vars[key][subKey] = `var(--${key}-${subKey})`;
//         });
//     });

//     return { values, vars } as any;
// };
