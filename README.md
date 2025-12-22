# Grenade Helper 道具包分享仓库

这是一个社区驱动的 CS2 道具包分享仓库。任何人都可以通过 Pull Request 分享自己的道具包。

## 如何分享你的道具包

### 1. Fork 这个仓库

### 2. 创建你的 JSON 文件

在根目录创建一个以你的名字命名的 JSON 文件，例如 `your_name.json`：

```json
{
  "author": "你的名字",
  "packages": [
    {
      "id": "your_name_dust2_v1",
      "name": "Dust2 烟雾合集",
      "description": "我常用的烟点",
      "map": "dust2",
      "count": 15,
      "updated": "2024-12-22",
      "url": "packages/dust2/your_name_smokes.cs2pkg",
      "size": "2.5MB"
    },
    {
      "id": "your_name_all_v1",
      "name": "全图整合包",
      "description": "我的全部道具",
      "map": null,
      "count": 50,
      "updated": "2024-12-22",
      "url": "packages/your_name_全图.cs2pkg",
      "size": "8.0MB"
    }
  ]
}
```

### 3. 上传你的 .cs2pkg 文件

- **单地图包**: 放到对应地图文件夹，如 `packages/dust2/`
- **全图整合包**: 直接放到 `packages/` 根目录

### 4. 提交 Pull Request

提交后，GitHub Action 会自动更新 `index.json`。

## JSON 文件格式说明

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `id` | string | ✅ | 唯一标识符，建议格式: `作者名_地图_版本` |
| `name` | string | ✅ | 显示名称 |
| `description` | string | ❌ | 描述信息 |
| `map` | string/null | ❌ | 地图名（null = 全图通用） |
| `count` | int | ❌ | 道具数量 |
| `updated` | string | ✅ | 更新日期 (YYYY-MM-DD) |
| `url` | string | ✅ | .cs2pkg 文件相对路径 |
| `size` | string | ❌ | 文件大小 |

## 目录结构

```
grenade-packs/
├── index.json              # 自动生成，请勿手动编辑
├── example.json            # 示例
├── contributor_a.json      # 贡献者 A
├── contributor_b.json      # 贡献者 B
├── packages/
│   ├── dust2/              # Dust2 地图道具包
│   │   └── xxx.cs2pkg
│   ├── inferno/            # Inferno 地图道具包
│   ├── mirage/             # Mirage 地图道具包
│   ├── anubis/             # Anubis 地图道具包
│   ├── ancient/            # Ancient 地图道具包
│   ├── nuke/               # Nuke 地图道具包
│   ├── vertigo/            # Vertigo 地图道具包
│   └── xxx_全图.cs2pkg     # 全图整合包直接放这里
├── script/
│   └── update_index.dart
└── .github/
    └── workflows/
        └── update-index.yml
```

## 许可证

MIT License
