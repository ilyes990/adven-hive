#!/bin/bash

# Adventure Hive - Quick Deploy Script
# This script builds and deploys your Flutter web app to Netlify

echo "🚀 Adventure Hive - Netlify Deployment Script"
echo "=============================================="
echo ""

# Step 1: Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Step 2: Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Step 3: Build for web
echo "🏗️  Building Flutter web app..."
flutter build web --release --base-href=/

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "📁 Build output location: build/web/"
    echo ""
    echo "Choose your deployment method:"
    echo "  1. Manual deploy: netlify deploy --prod"
    echo "  2. Drag & drop: Open https://app.netlify.com/drop and drag build/web folder"
    echo "  3. GitHub: Push to main branch (if connected)"
    echo ""
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi

