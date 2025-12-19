# 🚀 Advanced Smooth Scroll
A **RecyclerView-like advanced scrolling library for Flutter** that provides  
**ultra-smooth scrolling**, **auto pagination**, **pull-to-refresh**, and **fast scrolling**  
— fully compatible with **NestedScrollView & Slivers**.



## ✨ Features

✅ RecyclerView-like lazy loading  
✅ Ultra-smooth scrolling (custom physics)  
✅ Auto pagination (endless scroll)  
✅ Pull-to-refresh support  
✅ Fast scrolling with interactive scrollbar  
✅ NestedScrollView & SliverAppBar friendly  
✅ Highly customizable item UI  
✅ Clean, lightweight & future-ready  

---

## 🎥 Demo
https://github.com/user-attachments/assets/0577611b-f646-4232-9d1d-6f4b30b0d373

---

## 📦 Installation

### Add dependency:

```yaml
dependencies:
  advanced_smooth_scroll:
    path: url:'../advanced_smooth_scroll\advanced_smooth_scroll'
```
### Using GitHub (recommended during development):
```yaml
dependencies:
  advanced_smooth_scroll:
    git: url: https://github.com/YOUR_USERNAME/advanced_smooth_scroll.git
```
### 📥 Import
```dart
import 'package:advanced_smooth_scroll/advanced_smooth_scroll.dart';
```

---
## 🚀 Basic Usage
### Example: Users List with Pagination & Refresh
```
import 'package:flutter/material.dart';
import 'package:advanced_smooth_scroll/advanced_smooth_scroll.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<String> users = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    loadUsers(1);
  }

  Future<void> loadUsers(int page) async {
    if (!hasMore) return;

    await Future.delayed(const Duration(seconds: 1));

    if (page > 3) {
      hasMore = false;
      return;
    }

    setState(() {
      users.addAll(
        List.generate(15, (i) => 'User ${users.length + i}'),
      );
    });
  }

  Future<void> refreshUsers() async {
    setState(() {
      users.clear();
      hasMore = true;
    });
    await loadUsers(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: SliverAdvancedSmoothList(
        itemCount: users.length,
        onLoadMore: loadUsers,
        onRefresh: refreshUsers,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]),
          );
        },
      ),
    );
  }
}
```

---
## 🧠 How It Works
```scss
Screen Open
   ↓
onLoadMore(1)
   ↓
Items Render
   ↓
User Scrolls
   ↓
Auto onLoadMore(2)
   ↓
More Items
   ↓
Pull Down
   ↓
onRefresh()
```
---

## 🧩 Available Widgets
### 🔹 SliverAdvancedSmoothList (Recommended)
Best for:
- Large lists
- SliverAppBar
- NestedScrollView
- Maximum performance
```dart
SliverAdvancedSmoothList(
  itemCount: items.length,
  onLoadMore: fetchMore,
  onRefresh: refresh,
  itemBuilder: (context, index) => YourWidget(),
)
```
### 🔹 AdvancedSmoothList
Best for:
- Simple screens
- No Slivers needed
```dart
AdvancedSmoothList(
  itemCount: items.length,
  onLoadMore: fetchMore,
  itemBuilder: (context, index) => YourWidget(),
)
```
---
## 📄 License
```
MIT License

Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
