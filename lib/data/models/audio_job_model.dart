class AudioJobModel {
  final String id;
  final String status;
  final String type;
  final DateTime createdAt;
  final Map<String, dynamic> meta;
  final String? assetUrl;
  final int? durationSeconds;
  final String? category;
  final String? _title;
  final String? _description;

  AudioJobModel({
    required this.id,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.meta,
    this.assetUrl,
    this.durationSeconds,
    this.category,
    String? title,
    String? description,
  }) : _title = title, _description = description;

  factory AudioJobModel.fromJson(Map<String, dynamic> json) {
    // Helper to get value case-insensitively
    dynamic get(String key) => json[key] ?? json[key[0].toUpperCase() + key.substring(1)];

    return AudioJobModel(
      id: (get('id') ?? '') as String,
      status: (get('status') ?? 'UNKNOWN') as String,
      type: (get('type') ?? 'UNKNOWN') as String,
      createdAt: get('createdAt') != null 
          ? DateTime.tryParse(get('createdAt').toString()) ?? DateTime.now()
          : DateTime.now(),
      meta: (get('meta') as Map<String, dynamic>?) ?? {},
      assetUrl: get('assetUrl') as String?,
      durationSeconds: get('durationSeconds') as int?,
      category: get('category') as String?,
      title: get('title') as String?,
      description: get('description') as String?,
    );
  }

  String get title {
     if (_title != null && _title!.isNotEmpty) return _title!;
     
     final metaTitle = meta['title'] as String?;
     if (metaTitle != null && metaTitle.isNotEmpty) return metaTitle;
     
     // Fallback
     return type.replaceAll('_', ' ').toLowerCase().split(' ').map((word) {
       if (word.isEmpty) return '';
       return '${word[0].toUpperCase()}${word.substring(1)}';
     }).join(' ');
  }

  String get subtitle {
    if (_description != null && _description!.isNotEmpty) return _description!;
    
    if (meta.containsKey('subtitle')) return meta['subtitle'] as String;
    if (meta.containsKey('description')) return meta['description'] as String;
    if (meta.containsKey('topic')) return 'Topic: ${meta['topic']}';
    
    return 'Generated Podcast';
  }
}
