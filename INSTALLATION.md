# Installation Guide for Xanthan UNM Extension

This guide provides detailed step-by-step instructions for adding UNM branding to your Xanthan site.

## Before You Begin

**You need:**
- An existing Xanthan website repository on GitHub
- Access to edit your repository (you must be the owner or have write permissions)

**If you don't have a Xanthan site yet:**
1. Visit https://github.com/fredgibbs/xanthan
2. Click "Use this template" to create your own Xanthan site
3. Follow the Xanthan getting started guide
4. Return here once your site is live

---

## Installation Method 1: GitHub Web Interface (Recommended for Beginners)

### Step 1: Download the Extension

1. Go to https://github.com/amaranth-unm/xanthan-unm
2. Click the green **"Code"** button
3. Select **"Download ZIP"**
4. Save the ZIP file to your computer
5. Unzip the file - you'll see folders named `_layouts` and `_includes`

### Step 2: Upload the Layout File

1. Go to your Xanthan repository on GitHub
2. Click on the **`_layouts`** folder
3. Click **"Add file"** → **"Upload files"**
4. Drag **`base-unm.html`** from the unzipped folder into the upload area
5. Scroll down and click **"Commit changes"**

**What you should see:** The file `base-unm.html` now appears in your `_layouts` folder.

### Step 3: Create the UNM Includes Folder

GitHub doesn't let you create empty folders, so we'll create a placeholder file:

1. Go to your **`_includes`** folder
2. Click **"Add file"** → **"Create new file"**
3. In the filename box, type: `unm/placeholder.txt`
   - Notice how typing the `/` creates a folder named `unm`
4. In the file content area, type anything (like "temp")
5. Scroll down and click **"Commit new file"**

**What you should see:** A new folder `unm` inside `_includes`.

### Step 4: Upload the UNM Include Files

1. Navigate to **`_includes/unm/`** (the folder you just created)
2. Click **"Add file"** → **"Upload files"**
3. From the unzipped extension folder, drag these 5 files into the upload area:
   - `page-header-unm.html`
   - `nav-unm.html`
   - `nav-site.html`
   - `footer-unm.html`
   - `footer-site.html`
4. Scroll down and click **"Commit changes"**

### Step 5: Clean Up

1. Go back to **`_includes/unm/`**
2. Click on **`placeholder.txt`**
3. Click the **trash icon** to delete it
4. Confirm the deletion

### Step 6: Verify Installation

Check that these files exist in your repository:
- `_layouts/base-unm.html` ✓
- `_includes/unm/page-header-unm.html` ✓
- `_includes/unm/nav-unm.html` ✓
- `_includes/unm/nav-site.html` ✓
- `_includes/unm/footer-unm.html` ✓
- `_includes/unm/footer-site.html` ✓

---

## Installation Method 2: Git Command Line

### Prerequisites
- Git installed on your computer
- Your Xanthan repository cloned locally

### Installation Steps

```bash
# Navigate to your local Xanthan repository
cd ~/path/to/your-xanthan-site

# Create a temporary directory for the extension
mkdir temp-unm-extension
cd temp-unm-extension

# Download the extension files
git clone https://github.com/amaranth-unm/xanthan-unm.git
cd xanthan-unm

# Copy files to your Xanthan repository
cp _layouts/base-unm.html ../../_layouts/
cp -r _includes/unm ../../_includes/

# Go back to your repository root
cd ../..

# Clean up
rm -rf temp-unm-extension

# Verify files were copied
ls _layouts/base-unm.html
ls _includes/unm/

# Add, commit, and push
git add _layouts/base-unm.html _includes/unm/
git commit -m "Add UNM branding extension"
git push origin main
```

---

## Installation Method 3: Direct Download via curl

### For Advanced Users

```bash
# Navigate to your repository
cd ~/path/to/your-xanthan-site

# Create the UNM includes directory
mkdir -p _includes/unm

# Download layout
curl -o _layouts/base-unm.html \
  https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_layouts/base-unm.html

# Download include files
cd _includes/unm
curl -O https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_includes/unm/page-header-unm.html
curl -O https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_includes/unm/nav-unm.html
curl -O https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_includes/unm/nav-site.html
curl -O https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_includes/unm/footer-unm.html
curl -O https://raw.githubusercontent.com/amaranth-unm/xanthan-unm/main/_includes/unm/footer-site.html

# Return to repository root
cd ../..

# Commit and push
git add _layouts/base-unm.html _includes/unm/
git commit -m "Install UNM extension"
git push
```

---

## After Installation: Using the UNM Layout

### On Individual Pages

Edit any page's YAML front matter to use the UNM layout:

```yaml
---
layout: base-unm    # Changed from "layout: base"
title: My Page Title
---

# Your page content here
```

### Site-Wide

To use UNM branding on all pages:
1. Go through each `.md` file in your repository
2. Change `layout: base` to `layout: base-unm`
3. Commit the changes

**Pro tip:** Use GitHub's search feature to find all files with `layout: base` to update them quickly.

---

## Verification

### Check That It Works

1. Wait 1-2 minutes after committing (GitHub needs time to rebuild your site)
2. Visit your live website
3. Look for:
   - UNM header at the top
   - Departmental navigation bar
   - UNM footer at the bottom

### If It Doesn't Work

**Site hasn't updated?**
- Wait a full 2 minutes and refresh your browser
- Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Check GitHub Actions for build errors

**Missing elements?**
- Verify all 6 files are in the correct locations
- Check the YAML front matter uses `layout: base-unm` (not `base`)
- Look for typos in filenames

**Build errors in GitHub Actions?**
- Click on the "Actions" tab in your repository
- Click on the failed build to see the error message
- Common issue: Missing closing tags in include files

---

## Customization After Installation

Once installed, you can customize:
- Department links in `nav-unm.html`
- Site navigation in `nav-site.html`
- Footer content in `footer-unm.html`

See the main README for detailed customization instructions.

---

## Uninstallation

To remove the UNM extension:

1. Delete `_layouts/base-unm.html`
2. Delete the entire `_includes/unm/` folder
3. Change any pages using `layout: base-unm` back to `layout: base`
4. Commit and push

Your site will return to standard Xanthan styling.
