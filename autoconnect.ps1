Import-Module .\Module\UIAutomation.dll

Add-Type -Assembly System.Windows.Forms

if ($args.length -ne 2) {
    Write-Host "�����́A�ڑ���URL�ƃ��[�U�����w�肵�Ă��������B"
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
    # HTTP�X�e�[�^�X�R�[�h�擾
    $statusCode = $_.Exception.Response.StatusCode.value__
    [System.Windows.Forms.MessageBox]::Show("�����^�C���擾���ɃG���[���������܂����B`nStatus=" + $statusCode, "�G���[")

    exit
}

# �e�[�u����񒊏o
$tables = @($response.ParsedHtml.getElementsByTagName("TABLE"))
$rows = @($tables[0].Rows)
$cells = @($rows[0].Cells)

# �p�X���[�h���o
$pass = $cells[0].InnerText
$pass += $cells[1].InnerText
$pass += $cells[2].InnerText
$pass += $cells[3].InnerText
$pass += $cells[5].InnerText
$pass += $cells[6].InnerText
$pass += $cells[7].InnerText
$pass += $cells[8].InnerText

## UIAutomation�̐Ԙg��\��
#[UIAutomation.Preferences]::Highlight = $false
#
##�̃E�B���h�E�T���āAConnect�{�^���N���b�N
#$window = Get-UiaWindow -Name 'zzzzz'
#$window | Get-UiaButton -Name 'Connect' | Invoke-UiaButtonClick | Out-Null
#
##�F�؃_�C�A���O�̃p�X���[�h���͂��āAOK�N���b�N
#$window.Keyboard.TypeText("password")
#$window | Get-UiaButton -Name 'OK' | Invoke-UiaButtonClick | Out-Null
