# 🎮 Troll Game - Launcher & GameContent Architecture

## 📋 **Tổng quan**

Project đã được tách thành 2 phần chính để giải quyết vấn đề AdMob và Auto-update không thể hoạt động cùng lúc:

### 🚀 **Launcher** (`launcher/`)
- **Chức năng**: App chính được cài đặt trên điện thoại (.apk)
- **Nhiệm vụ**:
  - ✅ Kiểm tra và tải phiên bản mới từ GitHub
  - ✅ Hiển thị AdMob ads
  - ✅ Load và chạy GameContent từ file .pck
  - ✅ Quản lý lifecycle của game

### 🎮 **GameContent** (`GameContent/`)
- **Chức năng**: Chứa toàn bộ nội dung game
- **Nhiệm vụ**:
  - ✅ Chứa scenes, scripts, assets, gameplay
  - ✅ Export thành file .pck
  - ✅ Sử dụng AdMob thông qua Launcher bridge

## 🔄 **Quy trình hoạt động**

```
1. Người chơi mở app (Launcher.apk)
   ↓
2. Launcher khởi động → Hiển thị LauncherUI
   ↓
3. Kiểm tra version trên GitHub
   ↓
4. Nếu có bản mới → Tải .pck về user://
   ↓
5. Load .pck vào memory
   ↓
6. Chuyển sang StartUI.tscn từ GameContent
   ↓
7. Game chạy + AdMob hoạt động thông qua Launcher
```

## 📁 **Cấu trúc thư mục**

```
Troll_Demo_Project-Godot-/
├── launcher/                          ← Project Launcher
│   ├── project.godot                  ← Cấu hình Launcher
│   ├── scenes/
│   │   └── LauncherUI.tscn           ← UI chính của Launcher
│   ├── scripts/
│   │   ├── LauncherManager.gd        ← Quản lý chính
│   │   ├── UpdateChecker.gd          ← Kiểm tra cập nhật
│   │   ├── AdMobManager.gd           ← Quản lý AdMob
│   │   └── LauncherUI.gd             ← Script UI
│   ├── assets/
│   │   └── default_bus_layout.tres   ← Audio layout
│   ├── addons/
│   │   └── AdmobPlugin/              ← AdMob plugin
│   └── release/
│       └── Game_Cho_Tro_Choi.apk     ← APK build
└── GameContent/                       ← Thư mục GameContent
    ├── project.godot                  ← Cấu hình GameContent
    ├── scenes/                        ← Toàn bộ scenes
    ├── scripts/                       ← Toàn bộ scripts
    │   └── UI_Scripts/
    │       ├── admob.gd               ← AdMob wrapper
    │       └── GameAdMob.gd           ← Bridge đến Launcher
    ├── assets/                        ← Toàn bộ assets
    └── Export_file/
        ├── Game_Troll_Vi_en_lastest.pck
        └── version.txt
```

## 🛠️ **Cách sử dụng**

### **1. Development**
- Mở project `launcher/` trong Godot
- GameContent sẽ được load từ thư mục `GameContent/`
- Test AdMob và update system

### **2. Build APK**
- Export Launcher thành APK
- APK sẽ chứa Launcher + GameContent (cho development)

### **3. Deploy**
- Upload file `.pck` lên GitHub
- Upload APK lên store
- Người chơi chỉ cần cài APK một lần

### **4. Update Game**
- Chỉ cần update file `.pck` trên GitHub
- Người chơi tự động nhận bản cập nhật
- Không cần cài lại APK

## 🔧 **Cấu hình**

### **Launcher Settings**
```gdscript
# UpdateChecker.gd
const VERSION_URL = "https://raw.githubusercontent.com/.../version.txt"
const UPDATE_URL = "https://raw.githubusercontent.com/.../Game_Troll_Vi_en_lastest.pck"
```

### **AdMob Settings**
```gdscript
# AdMobManager.gd
var interstitial_ad_id = "ca-app-pub-3940256099942544/1033173712"  # Test ID
var banner_ad_id = "ca-app-pub-3940256099942544/6300978111"  # Test ID
```

## 🎯 **Ưu điểm**

✅ **AdMob hoạt động hoàn hảo** - Plugin chỉ trong project được build  
✅ **Auto-update hoạt động** - Tải .pck từ GitHub  
✅ **Không cần cài lại app** - Chỉ update nội dung  
✅ **Tách biệt rõ ràng** - Launcher vs GameContent  
✅ **Dễ maintain** - Cấu trúc đơn giản  
✅ **Performance tốt** - Load .pck vào memory  

## 🚨 **Lưu ý quan trọng**

1. **AdMob chỉ hoạt động trong Launcher** - GameContent sử dụng bridge
2. **File .pck phải được upload đúng đường dẫn** trên GitHub
3. **Version.txt phải được cập nhật** khi có phiên bản mới
4. **Test kỹ trước khi deploy** - Đảm bảo .pck load được

## 🔍 **Debug**

### **Kiểm tra logs**
- Launcher: `LauncherManager`, `UpdateChecker`, `AdMobManager`
- GameContent: `GameAdMob`, `admob.gd`

### **Common Issues**
- ❌ Không load được .pck → Kiểm tra đường dẫn GitHub
- ❌ AdMob không hiển thị → Kiểm tra AdMobManager initialization
- ❌ Game không chạy → Kiểm tra scene path trong LauncherManager

## 📞 **Support**

Nếu gặp vấn đề, kiểm tra:
1. Console logs trong Godot
2. Đường dẫn GitHub có đúng không
3. File .pck có được export đúng không
4. AdMob có được khởi tạo đúng không
