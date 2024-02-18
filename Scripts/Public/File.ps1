class File {
     [string] $fileName
     [string] $dateOfCreation
     [string] $fileType
     [int] $version
     [string] $extension
     [string] $path
     
     File([string] $_filename, [string] $_dateOfCreation, [string] $_fileType, [int] $_version,[string] $_extension){
         $this.fileName = $_filename
         $this.dateOfCreation = $_dateOfCreation
         $this.fileType = $_fileType
         $this.version = $_version
         $this.extension = $_extension
     }
     [string] ToString() {
          return "$($this.dateOfCreation)-$($this.fileName)-$($this.fileType)-v$($this.version)$($this.extension)"
     }
     [void] IncrementVersion(){
          $this.version = $this.version + 1
     }
     [void] FormatFileName(){
          $withinBrackets = $false
          $result = ""
          Write-Host $this.fileName
          for($i=0; $i -lt $this.fileName.Length;$i++){
               if($this.fileName[$i] -eq " "){
                    $result += "_" 
               }
               if($this.fileName[$i] -eq "("){
                    $withinBrackets = $true
               }
               if(-not $withinBrackets -and -not ($this.fileName[$i] -eq " ")){
                    $result += $this.fileName[$i]
               }
               if($this.fileName[$i] -eq ")"){
                    $withinBrackets = $false
               }
          }
          
          if($result[$result.Length-1] -eq "_"){
               $result = $result.Substring(0, $result.Length-1)
          }
          $this.fileName = $result
          
     }
}
