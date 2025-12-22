import 'dart:convert';
import 'dart:io';

/// 自动扫描所有贡献者的 JSON 文件并更新 index.json
void main() async {
  final currentDir = Directory.current;
  final jsonFiles = <String>[];
  final allPackages = <Map<String, dynamic>>[];

  print('扫描 JSON 文件...');

  // 扫描根目录下的所有 .json 文件（排除 index.json）
  await for (final entity in currentDir.list()) {
    if (entity is File && entity.path.endsWith('.json')) {
      final fileName = entity.uri.pathSegments.last;
      if (fileName != 'index.json') {
        jsonFiles.add(fileName);
        print('  发现: $fileName');

        // 读取并解析每个贡献者的 JSON 文件
        try {
          final content = await entity.readAsString();
          final data = jsonDecode(content) as Map<String, dynamic>;

          // 获取作者名（从 JSON 或从文件名）
          final author =
              data['author'] as String? ?? fileName.replaceAll('.json', '');

          // 获取包列表
          final packages = data['packages'] as List<dynamic>? ?? [];
          for (final pkg in packages) {
            final pkgMap = Map<String, dynamic>.from(pkg as Map);
            // 确保每个包都有作者信息
            pkgMap['author'] ??= author;
            allPackages.add(pkgMap);
          }
        } catch (e) {
          print('  警告: 解析 $fileName 失败 - $e');
        }
      }
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
