# Makes web-sized copies of your photos for the site.
#
# Put your original photos in Pictures\past-the-office-originals\<place>\
# (one folder per place, named like the place file), then run:
#   npm run photos
#
# Each photo is turned the right way up, shrunk to at most 1600 pixels on its
# longest side, and saved as a JPEG in public\images\places\<place>\ with a
# lower-case name. The copy has no hidden data (no GPS location, time or phone
# model), because only the picture itself is drawn into a fresh image.
# Originals are never changed. Photos already prepared are skipped.

param(
  [string]$Originals = "$env:USERPROFILE\Pictures\past-the-office-originals",
  [int]$MaxSize = 1600,
  [int]$Quality = 82
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing
$siteImages = Join-Path $PSScriptRoot "..\public\images\places"

$jpeg = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$settings = New-Object System.Drawing.Imaging.EncoderParameters 1
$settings.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]$Quality)

# Phones often store a photo sideways and record which way up it goes (EXIF tag 274).
$turns = @{
  2 = "RotateNoneFlipX"; 3 = "Rotate180FlipNone"; 4 = "Rotate180FlipX"; 5 = "Rotate90FlipX"
  6 = "Rotate90FlipNone"; 7 = "Rotate270FlipX"; 8 = "Rotate270FlipNone"
}

Get-ChildItem $Originals -Recurse -File -Include *.jpg, *.jpeg | ForEach-Object {
  $place = $_.Directory.Name
  $outDir = Join-Path $siteImages $place
  $outFile = Join-Path $outDir ($_.BaseName.ToLower() + ".jpg")
  if (Test-Path $outFile) { return }
  New-Item -ItemType Directory -Force $outDir | Out-Null

  $photo = [System.Drawing.Image]::FromFile($_.FullName)
  if ($photo.PropertyIdList -contains 274) {
    $turn = $turns[[int]$photo.GetPropertyItem(274).Value[0]]
    if ($turn) { $photo.RotateFlip($turn) }
  }

  $scale = [Math]::Min(1.0, $MaxSize / [Math]::Max($photo.Width, $photo.Height))
  $width = [int]($photo.Width * $scale)
  $height = [int]($photo.Height * $scale)
  $small = New-Object System.Drawing.Bitmap $width, $height
  $canvas = [System.Drawing.Graphics]::FromImage($small)
  $canvas.InterpolationMode = "HighQualityBicubic"
  $canvas.DrawImage($photo, 0, 0, $width, $height)
  $small.Save($outFile, $jpeg, $settings)

  $canvas.Dispose(); $small.Dispose(); $photo.Dispose()
  "{0}/{1}  {2} KB" -f $place, (Split-Path $outFile -Leaf), [int]((Get-Item $outFile).Length / 1KB)
}
