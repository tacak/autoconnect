Import-Module .\Module\UIAutomation.dll

Add-Type -Assembly System.Windows.Forms

if ($args.length -ne 2) {
    Write-Host "引数は、接続先URLとユーザ名を指定してください。"
    exit
}

$url=$args[0]
$username=$args[1]

try
{
    #$address = $url + "?id=" + $([Uri]::EscapeDataString($username))
    #$response = Invoke-WebRequest $address
    $response = Invoke-WebRequest "http://example.com" -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362"
}
catch [System.Net.WebException]
{
    # HTTPステータスコード取得
    $statusCode = $_.Exception.Response.StatusCode.value__
    [System.Windows.Forms.MessageBox]::Show("ワンタイム取得時にエラーが発生しました。`nStatus=" + $statusCode, "エラー")

    exit
}

# テーブル情報抽出
$tables = @($response.ParsedHtml.getElementsByTagName("TABLE"))
$rows = @($tables[0].Rows)
$cells = @($rows[0].Cells)

# パスワード抽出
$pass = $cells[0].InnerText
$pass += $cells[1].InnerText
$pass += $cells[2].InnerText
$pass += $cells[3].InnerText
$pass += $cells[5].InnerText
$pass += $cells[6].InnerText
$pass += $cells[7].InnerText
$pass += $cells[8].InnerText

## UIAutomationの赤枠非表示
#[UIAutomation.Preferences]::Highlight = $false
#
##のウィンドウ探して、Connectボタンクリック
#$window = Get-UiaWindow -Name 'zzzzz'
#$window | Get-UiaButton -Name 'Connect' | Invoke-UiaButtonClick | Out-Null
#
##認証ダイアログのパスワード入力して、OKクリック
#$window.Keyboard.TypeText("password")
#$window | Get-UiaButton -Name 'OK' | Invoke-UiaButtonClick | Out-Null
