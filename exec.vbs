url = "ugahoge"
userName = "hogehoge"

Set ws = CreateObject("WScript.Shell")
execCommand = "powershell -NoProfile -ExecutionPolicy RemoteSigned .\autoconnect.ps1 " & url & " " & userName
ws.Run execCommand, vbHide
Set ws = Nothing
