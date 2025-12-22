# 道具包文件目录

## 目录结构

每个贡献者的 **JSON 描述文件** 和 **.cs2pkg 道具包** 放在一起：

```
packages/
├── dust2/                       # Dust2 地图
│   ├── player_a.json            # 描述文件
│   └── player_a_smokes.cs2pkg   # 道具包
├── inferno/                     # Inferno 地图
├── mirage/                      # Mirage 地图
├── anubis/                      # Anubis 地图
├── ancient/                     # Ancient 地图
├── nuke/                        # Nuke 地图
├── vertigo/                     # Vertigo 地图
├── official.json                # 全图整合描述文件
└── official_全图精选.cs2pkg     # 全图整合道具包
```

## 规则

- **单地图包**: JSON 和 cs2pkg 放到对应地图文件夹
- **全图整合包**: JSON 和 cs2pkg 直接放到 packages 根目录
- 放在地图文件夹中的包会**自动设置 map 字段**
