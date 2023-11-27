# sem-pr-labeler

GitHub Action to relabel by the type of semantic pr

<!-- INSERT -->

## Inputs

| parameter | description | required | default |
| --- | --- | --- | --- |
| github_token | GITHUB_TOKEN | `true` |  |
| repo | repository | `true` |  |
| pr_num | pr number | `true` |  |
| label_prefix | the value to prepend the label | `false` | sem-pr:  |
| type | type of sematic pr | `true` |  |
| is_breaking_change | is pr breaking change('true' or 'false') | `true` | false |


## Runs

This action is a `composite` action.



## Example usage

Example of relabeling a pull request based on the Scope included in the PR title:

```yaml
name: "relabel by sem pr"
on:
  pull_request_target:
    types:
      - opened
      - edited

jobs:
  relabel:
    permissions:
      contents: read
      pull-requests: write
    runs-on: ubuntu-latest
    steps:
      - name: info
        id: info
        uses: hankei6km/gha-sem-from-title@v0
        with:
          title: ${{ github.event.pull_request.title }}
      - name: edit
        uses: hankei6km/gha-sem-pr-labeler@v0
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          repo: ${{ github.repository }}
          pr_num: ${{ github.event.pull_request.number }}
          type: ${{ steps.info.outputs.type }}
          is_breaking_change: ${{ steps.info.outputs.is_breaking_change }}
```

## Related

- [sem-from-title](https://github.com/hankei6km/gha-sem-from-title)

## Licenses

MIT License

Copyright (c) 2023 hankei6km
