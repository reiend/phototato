function Invoke-Build {
  Write-Host "Building the program please wait ..."
  Write-Host ""

  cmake  -S . -B  build -G "MinGW Makefiles" 
  Set-Location .\build
  cmake .. 
  make

}

function Convert-MilliSeconds {
  param($seconds)

  $milli_seconds = 1000;

  return $seconds * $milli_seconds
}

function Wait-Execution {
  param($time)
  [Threading.Thread]::Sleep((Convert-MilliSeconds $time))
}

function Remove-Logs {
  param($time)

  # clear terminal
  if($time -gt 1) {
    Write-Host "Clearing logs in"($time)"seconds"
  } else {

    Write-Host "Clearing logs in"($time)"second"
  }
  Wait-Execution $time

  Clear-Host 
}

function Move-Root {
  Set-Location ..\
}

function Invoke-Run {
  param($time)

  # run program
  Write-Host "Running the program"
  Remove-Logs $time
  .\main.exe
}

function Invoke-Project {
  $time = 1 

  Invoke-Build
  Remove-Logs $time
  Invoke-Run $time
  Move-Root
}

Invoke-Project
