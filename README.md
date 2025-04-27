# GoPro Davinci File Organizer - Windows PowerShell Script 

## Overview

This PowerShell script automates the cleanup and organization of GoPro files in the current working directory. Renaming the extended videos for easy user experience in Davinci.

## What It Does

1. **Removes** all `.THM` (thumbnail) files.
2. **Renames** all `GL*.LRV` (low-resolution video) files to `GX*.MOV`.
3. **Processes** all `GX*.MOV` and `GX*.MP4` files:
   - Files starting with `GX01` are kept as-is.
   - Files starting with `GX02`, `GX03`, etc., are renamed to `GX01` plus a suffix showing their original prefix.
4. **Creates** a `proxy` directory (if it doesn't exist).
5. **Moves** all `.MOV` files into the `proxy` directory.

## Usage

Note this action can not be undone.

1. Copy to your directory
2. Right click and run with powershell

Example:

```powershell
cd C:\path\to\gopro\files
.\organize-gopro.ps1
```

## Notes

This script only affects .THM, .LRV, .MOV, and .MP4 files starting with GX.

Original .MP4 files remain in place unless explicitly processed.

Use at your own risk; consider testing on a copy of your files first.
