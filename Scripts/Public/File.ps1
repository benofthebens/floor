class File {
     [string] $fileName
     [string] $dateOfCreation
     [string] $fileType
     [int] $version
     [string] $extension
     
     File([string] $_filename, [string] $_dateOfCreation, [string] $_fileType, [int] $_version,[string] $_extension){
         $this.fileName = $_filename
         $this.dateOfCreation = $_dateOfCreation
         $this.fileType = $_fileType
         $this.version = $_version
         $this.extension = $_extension
     }
     [string] ToString() {
          return "$($this.fileName)$($this.version)-$($this.fileType)-$($this.dateOfCreation)$($this.extension)"
     }
     [void] IncrementVersion(){
          $this.version = $this.version + 1
     }
}