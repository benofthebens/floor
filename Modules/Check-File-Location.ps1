. "C:\Users\benja\Desktop\Floor\Scripts\Public\File.ps1"

function Check-File-Location(){
     $jsonFilePath = "C:\Users\benja\Desktop\Floor\Resources\data\Renamed_Files.json"
     # Read the existing JSON content
     $jsonContent = Get-Content -Path $jsonFilePath | Out-String | ConvertFrom-Json
     $currentDirectory = Get-Location

     # Loop through the files and output their details
     foreach ($file in $jsonContent.Files) {
          $relativepath = Get-Item $file.path | Resolve-Path -Relative
          $directoryLocation = Split-Path -Path $relativepath -Parent
          Set-Location $directoryLocation 
          $directoryFiles = Get-ChildItem -File
          if($file.path-contains $directoryFiles.FullName ){
               continue;
          }
          else {
                # Remove the current file object from the JSON content
               $jsonContent.Files = $jsonContent.Files | Where-Object { $_.path -ne $file.path }

               # Convert the modified JSON content back to string and rewrite the JSON file
               $jsonContent | ConvertTo-Json | Set-Content -Path $jsonFilePath
          }
          
     }
     $OriginalRelativePath = Get-Item $currentDirectory | Resolve-Path -Relative
     Set-Location $OriginalRelativePath
     

}
