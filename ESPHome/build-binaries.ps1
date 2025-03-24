$apiYaml = "openradfan-controller.yaml"
$standaloneYaml = "openradfan-controller-standalone.yaml"
$outputDir = "release_binaries"

# Create output folder
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

# Build API version
Write-Host "Building API version..."
esphome compile $apiYaml
Copy-Item ".esphome\build\openradfan\.pioenvs\openradfan\*.factory.bin" "$outputDir/openradfan-controller-api.factory.bin" -Force
Copy-Item ".esphome\build\openradfan\.pioenvs\openradfan\*ota.bin" "$outputDir/openradfan-controller-api.ota.bin" -Force

# Build Standalone version
Write-Host "Building Standalone version..."
esphome compile $standaloneYaml
Copy-Item ".esphome\build\openradfan-standalone\.pioenvs\openradfan-standalone\*.factory.bin" "$outputDir/openradfan-controller-standalone.factory.bin" -Force
Copy-Item ".esphome\build\openradfan-standalone\.pioenvs\openradfan-standalone\*ota.bin" "$outputDir/openradfan-controller-standalone.ota.bin" -Force
