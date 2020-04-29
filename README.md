# ApiGen - ***Github Action***
Simple Github Action Which Helps You To Generate PHP Code Documentation Website Using ApiGen

## Configuration
| Argument | Default | Description |
| --- | ------- | ----------- |
|`push_to_branch` | gh-pages | Which Branch To Push |
|`before_cmd` | null | Option to run custom cmd before generating docs |
|`after_cmd` | null | Option to run custom cmd after generating docs |
|`auto_push` | Yes | if `Yes` then auto pushes files to current repo to the branch defined in `push_to_branch` |
|`output_folder` | null | Custom output folder if `auto_push` is disabled |
|`source_folder` | null | Custom source folder if `auto_push` is disabled |
|`cached_apigen` | yes |  Set yes to reduce runtime load |
---

> **Note** Provide A Branch Which is only for the docs. if any other contents in it then all will be deleted **DO NOT USE : MASTER**  

## Cached Stats
With cached enabled workflow takes only around **25s** to **35s**
if cached disabled then workflow takes around **45s** to **55s**
cache is useful then running in private repo or if you want to reduce load in github servers  

## Example Workflow File

## Without Local Cache
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
      with:
        cached_apigen: 'no'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Local Cache
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
      with:
        cached_apigen: 'yes'
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

