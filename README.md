# HDI_JSONTableForm_v17

![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
![4D](https://img.shields.io/static/v1?label=4D&message=21%2B&color=blue)
[![license](https://img.shields.io/github/license/miyako/HDI_JSONTableForm_v17)](LICENSE)

**How do I create a dynamic form from a table?**

A 4D "How Do I" (HDI) example. Pick a table, tick the fields you want, and the project generates an input or output form for it as a JSON form file, previews it in a subform, and runs it.

## Features

- Generates **input** (detail) and **output** (list box) forms from any table in the structure.
- Chooses which fields to include and which label to show for each one.
- Two layouts for the toolbar: buttons on the top, or buttons on the left.
- Live preview in a subform, then **Open** the generated `.json` or **Run** it with `FORM SET INPUT` / `DIALOG`.
- Three sample tables (`Samples`, `Person`, `AllTypes`) with a field of every common type, including picture and object.

## Requirements

- 4D 21 or later (project mode, `compatibilityVersion` 2101).
- macOS or Windows. macOS 26 (Tahoe) uses Liquid Glass; earlier systems use the classic look.

## Getting started

1. Open `Project/HDI_JSONTableForm_v17.4DProject` with 4D.
2. The splash window opens on startup; click **Demo**.
3. Choose a table, select input or output, choose a template, then click **Generate**.
4. Click **Run** to display the generated form, or **Open** to inspect the JSON.

Generated forms are written to `Resources/JSONForms/{Table}Input.json` and `{Table}Output.json`.

## Points of interest

| Topic | Where | What to look at |
|-------|-------|-----------------|
| Form generation | `Methods/generateForm.4dm` | Builds a form object from JSON templates, one label and input per selected field, then `OBJECT SET SUBFORM` to preview it. |
| Templates | `Resources/Template/*.json` | Reusable form and object definitions (`inputTemplate`, `outputTemplate`, `objectTemplate`). |
| Field discovery | `Methods/loadField.4dm` | Walks the catalog with `Last field number`, `GET FIELD PROPERTIES` and `Field name` (BLOB fields are skipped). |
| Running a JSON form | `Forms/HDI2/ObjectMethods/btnRun.4dm` | Uses a `/RESOURCES/...` path with `FORM SET INPUT` and a non-blocking `DIALOG`. |
| Startup pattern | `Methods/00_Start.4dm`, `Forms/HDI/` | `CALL WORKER` plus `DIALOG(...; *)`, window reuse, no `New process`. |

## Project layout

```
Project/Sources/
  Methods/             00_Start, generateForm, loadField, initHDI, getIconPath, Compiler_*
  Forms/HDI/           splash dialog
  Forms/HDI2/          the demo: tabs, table picker, field list box, preview subform
  TableForms/          default input/output forms of the three sample tables
  menus.json           menu bar (standard actions)
  styleSheets*.css     dark mode and Liquid Glass styles
Resources/
  Template/            JSON templates used by the generator
  JSONForms/           generated forms
  en.lproj, ja.lproj/  XLIFF localisation (English, Japanese)
```

## Modernisation notes

Common conventions applied to all HDI repositories:

- **Localisation:** every user-visible string uses `:xliff:` references or `Localized string`; XLIFF files are grouped by purpose (`menu`, `messages`, one per form). Standard `Common*` IDs come from 4D.
- **Declarations:** `var` and `#DECLARE`; no `C_*` directives.
- **Menus:** standard actions (`quit`, `cut`, `copy`, ...) instead of wrapper methods.
- **Methods:** subroutines are hidden from the Run Method dialog (`"invisible": true`).
- **Appearance:** `"automatic"` colours and `styleSheets.css` media queries for dark mode; `styleSheets_mac.css` sets push button height per form theme (27px Liquid Glass, 23px classic).
- **List boxes:** `truncateMode: none` and `resizingMode: legacy`.

## References

- Blog post: [How to create a dynamic form from a table in 3 steps](https://blog.4d.com/how-to-create-a-dynamic-form-from-a-table-in-3-steps/)
- [JSON form definition](https://developer.4d.com/docs/FormEditor/formEditor) and [form object properties](https://developer.4d.com/docs/FormObjects/propertiesReference)
- [CSS in 4D forms](https://developer.4d.com/docs/FormEditor/stylesheets)
- [`OBJECT SET SUBFORM`](https://developer.4d.com/docs/commands/object-set-subform), [`FORM SET INPUT`](https://developer.4d.com/docs/commands/form-set-input), [`DIALOG`](https://developer.4d.com/docs/commands/dialog)

## Origin

Originally a binary `.4DB` example (4D v17) distributed by 4D: [download](https://download.4d.com/4DBlog/Tips/4D_v17/DynamicForm_TableForm/HDI_JSONTableForm_v17.zip). It was converted to a project with the 4D 21 conversion tool and then modernised with GitHub Copilot.

## License

[MIT](LICENSE)
