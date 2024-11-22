class TodolistItem {
  final String label;
  bool checked;

  TodolistItem({required this.label, required this.checked});

  factory TodolistItem.fromJSON(Map<String, dynamic> json) {
    return TodolistItem(
      label: json['label'],
      checked: json['checked'],
    );
  }

  Map<String, dynamic> TodolistToMap(TodolistItem item) {
    return <String, dynamic>{
      'label': item.label,
      'checked': item.checked,
    };
  }
}
