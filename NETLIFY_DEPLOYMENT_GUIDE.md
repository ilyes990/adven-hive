# Adventure Hive - Netlify Deployment Guide

This guide will walk you through deploying your Flutter web app to Netlify.

## 🎯 Prerequisites

Before deploying, make sure you have:
- ✅ Flutter SDK installed (run `flutter --version` to check)
- ✅ Git installed and repository initialized
- ✅ A Netlify account (sign up at https://netlify.com if you don't have one)
- ✅ Your Gemini API key configured in `lib/main.dart`

## 📋 What We've Set Up

The following files have been created/updated for Netlify deployment:

### 1. `netlify.toml` ✅
Configuration file that tells Netlify:
- Where to find the build output (`build/web`)
- How to build your app (`flutter build web --release`)
- Routing rules for Flutter's client-side navigation
- Security headers and caching rules

### 2. Updated `web/index.html` ✅
- Added proper viewport meta tags for mobile responsiveness
- Improved SEO with better title and description
- Enhanced PWA support for iOS devices

### 3. Updated `web/manifest.json` ✅
- Better app name: "Adventure Hive"
- Improved description for PWA installation
- Proper start URL configuration

### 4. `.gitignore` ✅
- Ensures build files aren't committed to git
- Keeps repository clean

## 🚀 Deployment Options

You have **two main options** to deploy to Netlify:

---

## Option 1: Deploy via GitHub (Recommended) 🌟

This option enables automatic deployments whenever you push to GitHub.

### Step 1: Push to GitHub

```bash
# Initialize git if not already done
git init

# Add all files
git add .

# Commit your changes
git commit -m "Prepare for Netlify deployment"

# Add your GitHub remote (replace with your repo URL)
git remote add origin https://github.com/yourusername/adven-hive.git

# Push to GitHub
git push -u origin main
```

### Step 2: Connect Netlify to GitHub

1. Log in to [Netlify](https://app.netlify.com)
2. Click **"Add new site"** → **"Import an existing project"**
3. Choose **"Deploy with GitHub"**
4. Authorize Netlify to access your GitHub account
5. Select your `adven-hive` repository

### Step 3: Configure Build Settings

Netlify should automatically detect the `netlify.toml` file, but verify these settings:

- **Base directory**: (leave empty)
- **Build command**: `flutter build web --release --base-href=/`
- **Publish directory**: `build/web`
- **Build environment**: Add these if needed:
  - `FLUTTER_CHANNEL`: `stable`

### Step 4: Add Environment Variables (If Needed)

If you want to keep your API key secret:

1. In Netlify dashboard, go to **Site settings** → **Environment variables**
2. Add variable:
   - Key: `GEMINI_API_KEY`
   - Value: Your actual API key

3. Update `lib/main.dart` to read from environment:
   ```dart
   const GEM_API_KEY = String.fromEnvironment('GEMINI_API_KEY', 
     defaultValue: 'your-fallback-key');
   ```

### Step 5: Deploy!

Click **"Deploy site"** and wait for the build to complete (usually 3-5 minutes).

---

## Option 2: Manual Deploy via Netlify CLI 💻

Deploy directly from your local machine.

### Step 1: Install Netlify CLI

```bash
npm install -g netlify-cli
```

### Step 2: Build Your Flutter Web App

```bash
# Clean previous builds
flutter clean

# Build for web with release mode
flutter build web --release --base-href=/
```

This will create the production build in `build/web/` directory.

### Step 3: Login to Netlify

```bash
netlify login
```

This will open your browser to authenticate.

### Step 4: Deploy

**For the first deployment:**
```bash
netlify deploy --dir=build/web --prod
```

You'll be asked:
- **Create & configure a new site**: Yes
- **Team**: Select your team
- **Site name**: Choose a unique name (e.g., `adventure-hive-app`)

**For subsequent deployments:**
```bash
netlify deploy --prod
```

The CLI will remember your site configuration.

---

## Option 3: Drag & Drop Deploy 🖱️

Quick and easy, but no automatic updates.

### Step 1: Build Your App

```bash
flutter clean
flutter build web --release --base-href=/
```

### Step 2: Deploy to Netlify

1. Go to [Netlify Drop](https://app.netlify.com/drop)
2. Drag the entire `build/web` folder onto the page
3. Wait for upload to complete

Your site will be live immediately at a random Netlify URL.

---

## 🔧 Post-Deployment Configuration

### Custom Domain (Optional)

1. In Netlify dashboard, go to **Domain settings**
2. Click **"Add custom domain"**
3. Enter your domain name
4. Follow instructions to configure DNS

### Enable HTTPS

HTTPS is automatically enabled by Netlify (using Let's Encrypt).

### Configure Site Name

1. Go to **Site settings** → **Site details**
2. Click **"Change site name"**
3. Choose something memorable: `adventure-hive-yourname.netlify.app`

---

## 🧪 Testing Your Deployment

After deployment, test these features:

- ✅ App loads correctly
- ✅ Navigation works (especially back/forward buttons)
- ✅ AI generation works (check API key)
- ✅ Images and assets load
- ✅ Responsive design on mobile
- ✅ PWA installation works

### Common Issues & Solutions

#### Issue: White screen after deployment
**Solution**: Check browser console for errors. Usually caused by:
- Incorrect base href
- Missing assets
- API key not configured

**Fix**:
```bash
flutter build web --release --base-href=/ --verbose
```

#### Issue: Routing doesn't work (404 on refresh)
**Solution**: The `netlify.toml` should handle this, but verify the redirect rule exists:
```toml
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

#### Issue: Images/assets not loading
**Solution**: Check that assets are properly defined in `pubspec.yaml` and rebuild:
```bash
flutter clean
flutter pub get
flutter build web --release
```

#### Issue: Gemini API not working
**Solution**: 
1. Check API key is correct in `lib/main.dart`
2. Verify API key has proper permissions in Google Cloud Console
3. Check browser console for specific error messages

---

## 📊 Monitoring Your Site

### View Deployment Logs
1. Netlify Dashboard → Your Site → **Deploys**
2. Click on any deployment to see build logs

### Analytics (Optional)
Enable Netlify Analytics:
1. Site Settings → **Analytics**
2. Enable analytics ($9/month)

Or use Google Analytics (free):
1. Add tracking script to `web/index.html`

---

## 🔄 Continuous Deployment

If you chose **Option 1 (GitHub)**, every push to your main branch will automatically:
1. Trigger a new build on Netlify
2. Run `flutter build web --release`
3. Deploy the new version
4. Keep your site up to date

### Branch Deployments
You can also set up preview deployments for branches:
1. Netlify Dashboard → **Build & deploy** → **Deploy contexts**
2. Enable **Deploy previews** for pull requests

---

## 🎉 Your Site is Live!

Your Adventure Hive app should now be accessible at:
- Default URL: `https://your-site-name.netlify.app`
- Or your custom domain if configured

### Share Your App
- Copy the URL from Netlify dashboard
- Share with friends and testers
- Collect feedback for improvements

---

## 📝 Maintenance & Updates

### Regular Updates
```bash
# Make your code changes
git add .
git commit -m "Your update description"
git push origin main

# Netlify will automatically rebuild and deploy
```

### Force Rebuild
If you need to rebuild without code changes:
1. Netlify Dashboard → **Deploys**
2. Click **"Trigger deploy"** → **"Clear cache and deploy site"**

---

## 🆘 Need Help?

- **Netlify Support**: https://docs.netlify.com
- **Flutter Web**: https://docs.flutter.dev/platform-integration/web
- **Project Issues**: Create an issue on your GitHub repository

---

## ✅ Deployment Checklist

Before going live, verify:

- [ ] All features work in web build
- [ ] API keys are configured
- [ ] Images and assets load correctly
- [ ] Responsive design is tested on mobile
- [ ] PWA features work (if applicable)
- [ ] No console errors in browser
- [ ] Performance is acceptable
- [ ] SEO tags are configured
- [ ] Favicon is set
- [ ] Custom domain configured (if desired)

---

## 🎯 Next Steps

After successful deployment:

1. **Test thoroughly** on different devices and browsers
2. **Monitor performance** using Netlify analytics or Lighthouse
3. **Optimize** if needed (lazy loading, code splitting)
4. **Promote** your app on social media
5. **Iterate** based on user feedback

---

**Happy Deploying! 🚀**

Your Adventure Hive app is ready to help people plan amazing outdoor adventures!

