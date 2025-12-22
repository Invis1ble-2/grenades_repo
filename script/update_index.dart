import 'dart:convert';
import 'dart:io';

/// 自动扫描所有地图文件夹中的 JSON 文件并更新 index.json
void main() async {
  final currentDir = Directory.current;
  final packagesDir = Directory('${currentDir.path}/packages');
  final jsonFiles = <String>[];
  final allPackages = <Map<String, dynamic>>[];

  print('扫描道具包...');

  // 扫描 packages 根目录（全图整合包）
  await _scanDirectory(packagesDir, null, jsonFiles, allPackages);

  // 扫描各地图子目录
  await for (final entity in packagesDir.list()) {
    if (entity is Directory) {
      final mapName =
          entity.uri.pathSegments[entity.uri.pathSegments.length - 2];
      await _scanDirectory(entity, mapName, jsonFiles, allPackages);
    }
  }

  // 按更新日期排序（最新的在前）
  allPackages.sort((a, b) {
    final dateA = a['updated'] as String? ?? '';
    final dateB = b['updated'] as String? ?? '';
    return dateB.compareTo(dateA);
  });

  // 生成 index.json
  final index = {
    'version': 1,
    'updated': DateTime.now().toIso8601String().split('T')[0],
    'sources': jsonFiles..sort(),
    'packages': allPackages,
  };

  final indexFile = File('index.json');
  await indexFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert(index),
  );

  print('');
  print('✅ index.json 已更新');
  print('   - 源文件: ${jsonFiles.length} 个');
  print('   - 道具包: ${allPackages.length} 个');
}

/// 扫描指定目录中的 JSON 文件
Future<void> _scanDirectory(
  Directory dir,
  String? mapName,
  List<String> jsonFiles,
  List<Map<String, dynamic>> allPackages,
) async {
  await for (final entity in dir.list()) {
    if (entity is File && entity.path.endsWith('.json')) {
      final relativePath = entity.path
          .replaceFirst(Directory.current.path, '')
          .replaceAll('\\', '/')
          .substring(1); // 移除开头的 /

      jsonFiles.add(relativePath);
      print('  发现: $relativePath');

      try {
        final content = await entity.readAsString();
        final data = jsonDecode(content) as Map<String, dynamic>;

        final author = data['author'] as String? ??
            entity.uri.pathSegments.last.replaceAll('.json', '');

        final packages = data['packages'] as List<dynamic>? ?? [];
        for (final pkg in packages) {
          final pkgMap = Map<String, dynamic>.from(pkg as Map);
          pkgMap['author'] ??= author;
          // 如果在地图子目录中且未指定 map，自动设置
          if (mapName != null && pkgMap['map'] == null) {
            pkgMap['map'] = mapName;
          }
          allPackages.add(pkgMap);
        }
      } catch (e) {
        print('  警告: 解析 $relativePath 失败 - $e');
      }
    }
  }
}
