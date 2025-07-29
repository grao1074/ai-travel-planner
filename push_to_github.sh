#!/bin/bash

echo "🚀 Setting up GitHub Repository for AI Travel Planner"
echo "====================================================="

# Check if git is configured
if ! git config --global user.name > /dev/null 2>&1; then
    echo "❌ Git user name not configured"
    echo "Please run: git config --global user.name 'Your Name'"
    echo "Please run: git config --global user.email 'your.email@example.com'"
    exit 1
fi

if ! git config --global user.email > /dev/null 2>&1; then
    echo "❌ Git user email not configured"
    echo "Please run: git config --global user.email 'your.email@example.com'"
    exit 1
fi

echo "✅ Git is configured"

# Check if we have a remote repository
if git remote -v | grep -q origin; then
    echo "✅ Remote repository already configured"
    echo "Pushing to existing repository..."
    git branch -M main
    git push -u origin main
else
    echo ""
    echo "📋 To create a GitHub repository, follow these steps:"
    echo ""
    echo "1. Go to https://github.com/new"
    echo "2. Repository name: ai-travel-planner"
    echo "3. Description: AI-powered travel planning app with Flutter and Clean Architecture"
    echo "4. Make it Public or Private (your choice)"
    echo "5. Don't initialize with README (we already have one)"
    echo "6. Click 'Create repository'"
    echo ""
    echo "After creating the repository, run these commands:"
    echo ""
    echo "git remote add origin https://github.com/YOUR_USERNAME/ai-travel-planner.git"
    echo "git branch -M main"
    echo "git push -u origin main"
    echo ""
    echo "Or if you want to use SSH:"
    echo "git remote add origin git@github.com:YOUR_USERNAME/ai-travel-planner.git"
    echo "git branch -M main"
    echo "git push -u origin main"
fi

echo ""
echo "🎉 Your AI Travel Planner app is ready for GitHub!"
echo ""
echo "📁 Project location: $(pwd)"
echo "📱 To run the app: flutter run -d chrome"
echo "🌐 App URL: http://localhost:8080"
echo ""
echo "📚 Check GITHUB_SETUP.md for detailed instructions" 