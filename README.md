# Grenade Helper 道具包分享仓库

这是一个社区驱动的 CS2 道具包分享仓库。任何人都可以通过 Pull Request 分享自己的道具包。

## 如何分享你的道具包

### 1. Fork 这个仓库

### 2. 在对应地图文件夹中创建你的 JSON 文件和道具包

**单地图道具：** 放到对应地图文件夹

```
packages/dust2/
├── your_name.json           # 你的 JSON 描述文件
└── your_name_smokes.cs2pkg  # 你的道具包文件
```

**全图整合包：** 直接放到 packages 根目录

```
packages/
├── your_name.json           # 你的 JSON 描述文件
└── your_name_全图.cs2pkg    # 你的道具包文件
```

### 3. JSON 文件格式

```json
{
  "author": "你的名字",
  "packages": [
    {
      "id": "your_name_dust2_v1",
      "name": "Dust2 烟雾合集",
      "description": "我常用的烟点",
      "count": 15,
      "updated": "2024-12-22",
      "url": "packages/dust2/your_name_smokes.cs2pkg",
      "size": "2.5MB"
    }
  ]
}
```

> **注意：** 放在地图文件夹中的 JSON 会自动设置 `map` 字段，无需手动指定。

### 4. 提交 Pull Request

提交后，GitHub Action 会自动更新 `index.json`。

## JSON 字段说明

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `id` | string | ✅ | 唯一标识符，建议格式: `作者名_地图_版本` |
| `name` | string | ✅ | 显示名称 |
| `description` | string | ❌ | 描述信息 |
| `map` | string/null | ❌ | 地图名（地图文件夹中自动设置） |
| `count` | int | ❌ | 道具数量 |
| `updated` | string | ✅ | 更新日期 (YYYY-MM-DD) |
| `url` | string | ✅ | .cs2pkg 文件相对路径 |
| `size` | string | ❌ | 文件大小 |

## 目录结构

```
grenade-packs/
├── index.json              # 自动生成，请勿手动编辑
├── packages/
│   ├── dust2/              # Dust2 地图
│   │   ├── player_a.json
│   │   └── player_a_smokes.cs2pkg
│   ├── inferno/            # Inferno 地图
│   ├── mirage/             # Mirage 地图
│   ├── anubis/             # Anubis 地图
│   ├── ancient/            # Ancient 地图
│   ├── nuke/               # Nuke 地图
│   ├── vertigo/            # Vertigo 地图
│   ├── player_b.json       # 全图整合 (放根目录)
│   └── player_b_全图.cs2pkg
├── script/
│   └── update_index.dart
└── .github/
    └── workflows/
        └── update-index.yml
```

## 许可证

MIT License
