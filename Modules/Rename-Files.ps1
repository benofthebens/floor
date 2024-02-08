. "C:\Users\benja\Desktop\Floor\Scripts\Public\File.ps1"

function Rename-Files(){
     #get the children of the current folder
     $files = Get-ChildItem -File
     #get json path
     $jsonFilePath = "C:\Users\benja\Desktop\Floor\Resources\data\Renamed_Files.json"
     # Read the existing JSON content
     $jsonContent = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json

     
     foreach($file in $files){
          #initalise new file object
          $newFile = [File]::new($file.BaseName,$file.CreationTime.Date.ToString("yyyy_MM_dd"),"DOT",0,$file.Extension)
          #new path
          $newFilePath = Join-Path -Path $file.Directory.FullName -ChildPath $newFile.ToString()
          #if the same file exsits increment the version 
          #(subject to change)
          while($jsonContent.Files -contains $newFilePath){
               $newFile.IncrementVersion()
               $newFilePath = Join-Path -Path $file.Directory.FullName -ChildPath $newFile.ToString()
          }
          
          if ( $jsonContent.Files -contains $file.FullName) {
               Write-Host "File path already exists in the JSON file: $newFilePath"
          }
          else {
               #renames the file 
               Rename-Item -Path $file.FullName -NewName $newFile.ToString()

               # Add the new file path to the JSON content
               $jsonContent.Files += $newFilePath

               # Convert the modified JSON content back to JSON format
               $updatedJsonContent = ConvertTo-Json -InputObject $jsonContent -Depth 100

               # Write the updated JSON content back to the file
               Set-Content -Path $jsonFilePath -Value $updatedJsonContent

          }
          
     }
}
