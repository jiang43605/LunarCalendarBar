# LunarCalendarBar

<p align="center">
  <img src="https://img.shields.io/badge/macOS-15.0+-blue.svg" alt="macOS">
  <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift">
  <img src="https://img.shields.io/github/license/jiang43605/LunarCalendarBar.svg" alt="License">
  <img src="https://img.shields.io/github/v/release/jiang43605/LunarCalendarBar" alt="Release">
</p>

A beautiful macOS menu bar calendar app with lunar calendar, Chinese holidays, and macOS 26 glassmorphism style.

## Features

- 🗓️ **Menu Bar Calendar** - Quick access from macOS status bar
- 🌙 **Lunar Calendar** - Full lunar calendar support showing both solar and lunar dates
- 🎉 **Chinese Holidays** - Highlights major Chinese holidays and festivals
- ✨ **macOS 26 Style** - Glassmorphism design with smooth animations
- 🔄 **Auto Launch** - Optional login item for automatic startup

## Screenshots

Screenshots coming soon...

## Requirements

- macOS 15.0 (Tahoe) or later
- Apple Silicon or Intel Mac

## Installation

### Manual
1. Download the latest `.dmg` from [Releases](https://github.com/jiang43605/LunarCalendarBar/releases)
2. Mount the DMG and drag `LunarCalendarBar.app` to Applications

### Homebrew (coming soon)
```bash
brew install lunar-calendar-bar
```

## Usage

1. Click the calendar icon in the menu bar
2. Browse months with left/right arrows
3. Click the year to select a different year
4. Click "今天" (Today) to return to current date

## Development

### Prerequisites
- Xcode 15.0+
- XcodeGen

### Setup
```bash
# Install XcodeGen
brew install xcodegen

# Generate Xcode project
xcodegen generate

# Open in Xcode
open LunarCalendarBar.xcodeproj
```

### Build
```bash
xcodebuild -project LunarCalendarBar.xcodeproj -scheme LunarCalendarBar -configuration Release build
```

## Data Sources

This project uses the following open-source resources:

### Lunar Calendar
- **Lunar-Solar-Calendar-Converter**  
  https://github.com/isee15/Lunar-Solar-Calendar-Converter  
  A reliable algorithm for converting between solar and lunar calendars, supporting years 1900-2100.

### Reference Projects
- **LunarBar** - https://github.com/LunarBar-app/LunarBar  
  A compact lunar calendar for your macOS menu bar (inspiration source)

### Chinese Holidays
Chinese holiday data is maintained locally as the official holiday schedule is relatively stable. Major holidays include:

| Date | Holiday |
|------|---------|
| 01-01 | New Year's Day (元旦) |
| 05-01 | Labor Day (劳动节) |
| 10-01 | National Day (国庆节) |
| Lunar 1st-1st | Spring Festival (春节) |
| Lunar 1st-15th | Lantern Festival (元宵节) |
| Lunar 5th-5th | Dragon Boat Festival (端午节) |
| Lunar 8th-15th | Mid-Autumn Festival (中秋节) |

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

⭐ Star this repo if you find it useful!