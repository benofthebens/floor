. "C:\Users\benja\Desktop\Floor\Scripts\Public\File.ps1"

function Rename-Files(){
     # Get the children of the current folder
     $files = Get-ChildItem -File
     # Get json path
     $jsonFilePath = "C:\Users\benja\Desktop\Floor\Resources\data\Renamed_Files.json"
     # Read the existing JSON content
     $jsonContent = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json

     foreach($file in $files){
          # Initialize new file object
          $newFile = [File]::new($file.BaseName, $file.CreationTime.Date.ToString("yyyyMMdd"), "DOT", 0, $file.Extension)
          $newFile.FormatFileName()
          # New path
          $newFilePath = Join-Path -Path $file.Directory.FullName -ChildPath $newFile.ToString()
          #checks if teh file name has already been formatted 
          if($jsonContent.Files.path -contains $file.FullName){
               continue
          }
          #updates the version if the filename already exsits
          while($jsonContent.Files.path -contains $newFilePath){
               $newFile.IncrementVersion()
               $newFilePath = Join-Path -Path $file.Directory.FullName -ChildPath $newFile.ToString()
          }
           
          # Rename the file 
          Rename-Item -Path $file.FullName -NewName $newFile.ToString()
          $newFile.path = $newFilePath

          # Add the new file path to the JSON content
          $jsonContent.Files += $newFile

          # Convert the modified JSON content back to JSON format
          $updatedJsonContent = ConvertTo-Json -InputObject $jsonContent -Depth 100

          # Write the updated JSON content back to the file
          Set-Content -Path $jsonFilePath -Value $updatedJsonContent
     }
}