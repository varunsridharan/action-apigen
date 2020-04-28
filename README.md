# ApiGen - ***Github Action***
Simple Github Action Which Helps You To Generate PHP Code Documentation Website Using ApiGen

## Configuration
| Argument | Default | Description |
| --- | ------- | ----------- |
|`push_to_branch` | gh-pages | Which Branch To Push |
|`before_cmd` | null | Option to run custom cmd before generating docs |
|`after_cmd` | null | Option to run custom cmd after generating docs |
|`auto_push` | Yes | If set the `Yes` then it auto pushes generated files to current github repo to the branch defined in `push_to_branch` |
|`output_folder` | null | This option can be used to provide custom output folder if `auto_push` is disabled |
|`source_folder` | null | This option can be used to provide custom source folder if `auto_push` is disabled |
---

> **Note** Provide A Branch Which is only for the docs. if any other contents in it then all will be deleted **DO NOT USE : MASTER**  


## Example Workflow File
```yaml
name: ON_PUSH

on:
  push:
    branches:
      - master

jobs:
  Document_Generator:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: 📝 ApiGen PHP Document Generator
      uses: varunsridharan/action-apigen@2.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        
```

---
## Contribute
If you would like to help, please take a look at the list of
[issues][issues] or the [To Do](#-todo) checklist.

## License
Our GitHub Actions are available for use and remix under the MIT license.

## Copyright
2017 - 2018 Varun Sridharan, [varunsridharan.in][website]

If you find it useful, let me know :wink:

You can contact me on [Twitter][twitter] or through my [email][email].

## Backed By
| [![DigitalOcean][do-image]][do-ref] | [![JetBrains][jb-image]][jb-ref] |  [![Tidio Chat][tidio-image]][tidio-ref] |
| --- | --- | --- |

[twitter]: https://twitter.com/varunsridharan2
[email]: mailto:varunsridharan23@gmail.com
[website]: https://varunsridharan.in
[issues]: issues/

[do-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/DO_Logo_Horizontal_Blue-small.png
[jb-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/phpstorm-small.png?v3
[tidio-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/tidiochat-small.png
[do-ref]: https://s.svarun.in/Ef
[jb-ref]: https://www.jetbrains.com
[tidio-ref]: https://tidiochat.com

