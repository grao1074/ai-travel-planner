#!/bin/bash

echo "🚀 Setting up AI Travel Planner App"
echo "====================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed."
    echo ""
    echo "📋 To install Flutter, please follow these steps:"
    echo ""
    echo "1. Visit https://flutter.dev/docs/get-started/install"
    echo "2. Download Flutter SDK for macOS"
    echo "3. Extract the downloaded file to a location (e.g., ~/development/flutter)"
    echo "4. Add Flutter to your PATH:"
    echo "   export PATH=\"\$PATH:\$HOME/development/flutter/bin\""
    echo "5. Run: flutter doctor"
    echo ""
    echo "🔧 After installing Flutter, run this script again."
    exit 1
fi

echo "✅ Flutter is installed!"

# Check Flutter version
echo "📱 Flutter version:"
flutter --version

echo ""
echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "🔧 Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 To run the app:"
echo "   flutter run"
echo ""
echo "📱 To run on a specific device:"
echo "   flutter devices"
echo "   flutter run -d <device-id>"
echo ""
echo "🔍 To check for issues:"
echo "   flutter doctor" 