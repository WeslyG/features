
# Hashicorp direct install from mirror (hashicorp-mirror)

Download hashicorp product from any mirror you like (support x86/arm aarch)

## Example Usage

```json
"features": {
    "ghcr.io/WeslyG/features/hashicorp-mirror:2": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| mirror | Set hashicorp mirror link | string | hashicorp-releases.yandexcloud.net |
| products | Set hashicorp product name from mirror (for example https://hashicorp-releases.yandexcloud.net) | string | terraform |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/WeslyG/features/blob/main/src/hashicorp-mirror/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
