#EGGSTOASTBACON :: https://github.com/eggstoastbacon

[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$loadPageDelay = "3"
$packageDelay = "1"

mkdir c:\temp -erroraction silentlycontinue
$nowintxt = "c:\temp\nowin.txt"
$winners = "c:\temp\winners.txt"

$done = "false"

$username = "username"
$password = "password"

$pages = (136..190)
$mainpages = "https://www.amazon.com/ga/giveaways?pageId="

function Clicker {
    [Clicker]::LeftClickAtPoint(1000, 600)
    [Clicker]::LeftClickAtPoint(1000, 630)
    [Clicker]::LeftClickAtPoint(1000, 660)
    [Clicker]::LeftClickAtPoint(1000, 690)
    [Clicker]::LeftClickAtPoint(1000, 720)
    [Clicker]::LeftClickAtPoint(1000, 750)
    [Clicker]::LeftClickAtPoint(1000, 770)
    [Clicker]::LeftClickAtPoint(1000, 790)
    [Clicker]::LeftClickAtPoint(1000, 820)
    [Clicker]::LeftClickAtPoint(1000, 850)
    [Clicker]::LeftClickAtPoint(1000, 880)
    [Clicker]::LeftClickAtPoint(1000, 910)
    [Clicker]::LeftClickAtPoint(1000, 940)
    [Clicker]::LeftClickAtPoint(1000, 820)
    [Clicker]::LeftClickAtPoint(1000, 850)
}

function amazonClicker {
    [Clicker]::LeftClickAtPoint(850, 870)
    #start-sleep 1
    #[Clicker]::LeftClickAtPoint(850,840)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 810)
    #start-sleep 1
    #[Clicker]::LeftClickAtPoint(850,780)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 750)
}

function youtubeClicker {
    [Clicker]::LeftClickAtPoint(900, 870)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 860)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 850)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 840)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 830)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 820)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 810)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 800)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 790)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 780)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 770)
    start-sleep .5
    [Clicker]::LeftClickAtPoint(900, 760)
}

function winClicker {
    [Clicker]::LeftClickAtPoint(850, 810)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 790)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 760)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 730)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(850, 700)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(830, 670)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(830, 640)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(830, 610)
    #start-sleep 1
    [Clicker]::LeftClickAtPoint(830, 590)
}

function screenshot([Drawing.Rectangle]$bounds, $path) {
    $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
    $graphics = [Drawing.Graphics]::FromImage($bmp)

    $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

    $bmp.Save($path)

    $graphics.Dispose()
    $bmp.Dispose()
}

Function maxIE {
    param($global:ie)
    $asm = [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $global:ie.Width = $screen.width
    $global:ie.Height = $screen.height
    $global:ie.Top = 0
    $global:ie.Left = 0
}

$cSource = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;
public class Clicker
{
//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct INPUT
{ 
    public int        type; // 0 = INPUT_MOUSE,
                            // 1 = INPUT_KEYBOARD
                            // 2 = INPUT_HARDWARE
    public MOUSEINPUT mi;
}

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct MOUSEINPUT
{
    public int    dx ;
    public int    dy ;
    public int    mouseData ;
    public int    dwFlags;
    public int    time;
    public IntPtr dwExtraInfo;
}

//This covers most use cases although complex mice may have additional buttons
//There are additional constants you can use for those cases, see the msdn page
const int MOUSEEVENTF_MOVED      = 0x0001 ;
const int MOUSEEVENTF_LEFTDOWN   = 0x0002 ;
const int MOUSEEVENTF_LEFTUP     = 0x0004 ;
const int MOUSEEVENTF_RIGHTDOWN  = 0x0008 ;
const int MOUSEEVENTF_RIGHTUP    = 0x0010 ;
const int MOUSEEVENTF_MIDDLEDOWN = 0x0020 ;
const int MOUSEEVENTF_MIDDLEUP   = 0x0040 ;
const int MOUSEEVENTF_WHEEL      = 0x0080 ;
const int MOUSEEVENTF_XDOWN      = 0x0100 ;
const int MOUSEEVENTF_XUP        = 0x0200 ;
const int MOUSEEVENTF_ABSOLUTE   = 0x8000 ;

const int screen_length = 0x10000 ;

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646310(v=vs.85).aspx
[System.Runtime.InteropServices.DllImport("user32.dll")]
extern static uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

public static void LeftClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}
}
'@
Add-Type -TypeDefinition $cSource -ReferencedAssemblies System.Windows.Forms, System.Drawing

if ($done -notlike "true") {
    $global:ie = New-Object -ComObject 'internetExplorer.Application'
    $global:ie.Visible = $true

    foreach ($page in $pages) {
        ## Get Links
        Clear-Variable GWLinks -ErrorAction SilentlyContinue
        Clear-Variable hrefs -ErrorAction SilentlyContinue
        $GWLinks = @()
        $hrefs = @()
        $page
        maxIE $global:ie
        $global:ie.Navigate($mainpages + $page)
        start-sleep $loadPageDelay
        $hrefs += $global:ie.Document.links | select-object href | where-object { $_ -like "*fsrc*" }
        $GWLinks += $hrefs.href

        foreach ($GWLink in $GWLinks) {
            Clear-Variable check -ErrorAction SilentlyContinue
            Clear-Variable ended -ErrorAction SilentlyContinue
            $win = get-content $winners

            if ($gwlink -notin $win) {
                maxIE $global:ie
                $global:ie.Navigate("$GWLINK")
                $GWLink
                start-sleep $loadPageDelay
                ##Get Prize Name
                clear-variable captchaExists -ErrorAction SilentlyContinue
                clear-variable signinExists -ErrorAction SilentlyContinue
                clear-variable youtubeExists -ErrorAction SilentlyContinue
                clear-variable amazonvidExists -ErrorAction SilentlyContinue
                clear-variable captchaExists -ErrorAction SilentlyContinue
                #Find page loaded type and status
                $prizeName = $null
                $statusTitle = $null
                $packageExists = $null
                $amazonVidExists = $null
                $signinExists = $null




                function getStatus ($global:ie) {
                    $captchaCheck = $global:ie.Document.body.getElementsByClassName('a-dynamic-image') | where-object { $_.src -like "*opfcaptcha-prod*" }
                    if ($captchaCheck) { $global:captchaExists = "true" }else { $global:captchaExists = "false" }
                    $prizeName = $global:ie.Document.body.getElementsByClassName('a-size-base ellipse-2-line') | select-object textContent
                    $global:prizeName = $prizeName.textContent
                    $statusTitle = $global:ie.Document.body.getElementsByClassName('a-text-bold') | select-Object textContent
                    $global:statusTitle = $statusTitle.textContent | out-string

                    $packageCheck = $global:ie.document.body.GetElementsByClassName("a-text-center box-click-area") | where-object { $_.innerText -like '*Tap the box to see if you win*' }
                    if ($packageCheck) { $global:packageExists = "true" }else { $global:packageExists = "false" }
                    if ($packageCheck) { } else {
                        $packageCheck = $global:ie.document.body.GetElementsByClassName("giveaway-transparent") | where-object { $_.outerHTML -like '*Tap the box to see if you win*' }
                        if ($packageCheck) { $global:packageExists = "true" }else { $global:packageExists = "false" }
                    }

                    $youtubeCheck = $global:ie.Document.body.getElementsByTagName("iframe") | where-object { $_.ie8_src -like "*youtube.com*" }
                    if ($youtubeCheck) { $global:youtubeExists = "true" }else { $global:youtubeExists = "false" }
                    $amazonVidCheck = $amazonvideo = $global:ie.Document.body.getElementsbyClassName("video") | select-object currentSrc
                    if ($amazonVidCheck) { $global:amazonVidExists = "true" }else { $global:amazonVidExists = "false" }
                    $signinCheck = $global:ie.Document.IHTMLDocument3_getElementsbyTagName("a") | where-object { $_.outerHTML -like "*button*" -and $_.outerHTML -like "*role*" -and $_.outerHTML -like "*amazon*" -and $_.textContent -notlike "*giveaways*" }
                    if ($signinCheck) { $global:signinExists = "true" }else { $global:signinExists = "false" }
                    ##STATUS
                }

                getStatus $global:ie

                if ([string]$global:statusTitle -notlike "*Ended*" -and [string]$global:statusTitle -notlike "*you didn*" -and [string]$global:prizeName -notlike "*kindle edition*" -and [string]$global:statusTitle -notlike "*you won*") {

                    if ($global:signinExists -like "True") {
                        $signin = $global:ie.Document.IHTMLDocument3_getElementsbyTagName("a") | where-object { $_.outerHTML -like "*button*" -and $_.outerHTML -like "*role*" -and $_.outerHTML -like "*amazon*" }
                        $signin.click();
                        start-sleep 1
                        $global:ie.Document.IHTMLDocument3_getElementbyID(“ap_email”).value = "$username"
                        $global:ie.Document.IHTMLDocument3_getElementbyID(“ap_password”).value = "$password"
                        start-sleep 1
                        $signinComp = $global:ie.Document.IHTMLDocument3_getElementbyID("signInSubmit")
                        $signinComp.click();
                        start-sleep 1
                        getStatus $global:ie
                    }


                    if ($global:captchaExists -like "True") {
                        do {
                            Clear-Variable solved -ErrorAction SilentlyContinue
                            start-sleep 3
                            $chal = $global:ie.Document.IHTMLDocument3_getElementbyID("ga_ca_refresh")
                            if ($chal) {
                                $chal.click() 
                            }
                            else {
                                $global:ie.refresh()
                                $global:ie.Navigate("https://google.com")
                                start-sleep 5
                                $global:ie.Navigate("$GWLINK")
                            }
                            start-sleep 5
                            $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
   
                            [void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
                            start-sleep 2
                            $a = (Get-Process -Name iexplore) | Where-Object { $_.MainWindowHandle -eq $global:ie.HWND }
                            [Microsoft.VisualBasic.Interaction]::AppActivate($a.ID)
                            [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
                            $bounds = [Drawing.Rectangle]::FromLTRB(800, 510, 1000, 590)
                            screenshot $bounds $env:USERPROFILE\Pictures\pic01.jpg
                            $bounds = [Drawing.Rectangle]::FromLTRB(800, 555, 1000, 632)
                            screenshot $bounds $env:USERPROFILE\Pictures\pic02.jpg
                            $bounds = [Drawing.Rectangle]::FromLTRB(800, 575, 1000, 655)
                            screenshot $bounds $env:USERPROFILE\Pictures\pic03.jpg
                            $bounds = [Drawing.Rectangle]::FromLTRB(800, 490, 1000, 570)
                            screenshot $bounds $env:USERPROFILE\Pictures\pic04.jpg
                            start-sleep 2
                            [Microsoft.VisualBasic.Interaction]::AppActivate($PID)
                            write-host "Determining possibilities" -BackgroundColor white
                            $solved01 = Export-ImageText -Path $env:USERPROFILE\Pictures\pic01.jpg
                            $solved01 = $solved01.replace(" ", "") 
                            $solved01 = $solved01.replace(" ", "")
                            $solved02 = Export-ImageText -Path $env:USERPROFILE\Pictures\pic02.jpg
                            $solved02 = $solved02.replace(" ", "") 
                            $solved02 = $solved02.replace(" ", "")
                            $solved03 = Export-ImageText -Path $env:USERPROFILE\Pictures\pic03.jpg
                            $solved03 = $solved03.replace(" ", "") 
                            $solved03 = $solved03.replace(" ", "")
                            $solved04 = Export-ImageText -Path $env:USERPROFILE\Pictures\pic04.jpg
                            $solved04 = $solved04.replace(" ", "") 
                            $solved04 = $solved04.replace(" ", "")
                            write-host ("`n" + "Determining possibilities" + "`n") -BackgroundColor white -ForegroundColor Black
                            write-host ("#1: " + $solved01) -foregroundcolor yellow -backgroundcolor black
                            write-host ("#2: " + $solved02) -foregroundcolor red -backgroundcolor black
                            write-host ("#3: " + $solved03) -foregroundcolor cyan -backgroundcolor black
                            write-host ("#4: " + $solved04) -foregroundcolor white -backgroundcolor black
                            $nuses = (7..25)
                            if ($captcha -notlike $null -and $solved01.length -ge 6 -and $solved01.length -lt 9) {
                                $global:ie.Document.IHTMLDocument3_getElementbyID(“image_captcha_input").value = "$solved01"
                                start-sleep 2
                                [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    
                                foreach ($nus in $nuses) {
                                    try {
                                        $global:ie.document.IHTMLDocument3_GetElementsByTagName("input").item($nus).click()
                                    }
                                    catch { }
                                }
                                $global:ie.Document.IHTMLDocument3_getElementbyID("captcha_token").click()
                                clear-variable captcha -erroraction Silentlycontinue
                                $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
                                start-sleep 2
                            }

                            if ($captcha -notlike $null -and $solved02.length -ge 6 -and $solved02.length -lt 9) {
                                $global:ie.Document.IHTMLDocument3_getElementbyID(“image_captcha_input").value = "$solved02"
                                start-sleep 2
                                [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
                                start-sleep 2
                                foreach ($nus in $nuses) {
                                    try {
                                        $global:ie.document.IHTMLDocument3_GetElementsByTagName("input").item($nus).click()
                                    }
                                    catch { }
                                }
                                $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
                                start-sleep 2
                            }

                            if ($captcha -notlike $null -and $solved03.length -ge 6 -and $solved03.length -lt 9) {
                                $global:ie.Document.IHTMLDocument3_getElementbyID(“image_captcha_input").value = "$solved03"
                                start-sleep 2
                                [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
                                start-sleep 2
                                foreach ($nus in $nuses) {
                                    try {
                                        $global:ie.document.IHTMLDocument3_GetElementsByTagName("input").item($nus).click()
                                    }
                                    catch { }
                                }
                                $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
                                start-sleep 2
                            }

                            if ($captcha -notlike $null -and $solved04.length -ge 6 -and $solved04.length -lt 9) {
                                $global:ie.Document.IHTMLDocument3_getElementbyID(“image_captcha_input").value = "$solved04"
                                start-sleep 2
                                [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
                                start-sleep 2
                                foreach ($nus in $nuses) {
                                    try {
                                        $global:ie.document.IHTMLDocument3_GetElementsByTagName("input").item($nus).click()
                                    }
                                    catch { }
                                }
                                $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
                                start-sleep 2
                            }
                            $captcha = $global:ie.Document.IHTMLDocument3_getElementbyID("image_captcha")
                            pageStatus $global:ie
                        } while ($captcha.spellcheck -like "true")
                        getStatus $global:ie
                    }

                    if ($global:packageExists -like "True") {
                        [int]$i = 0
                        while ($packageExists -like "True" -and $global:statusTitle -notlike "*you didn*" -and $i -lt 5) {
                            getStatus $global:ie
                            Clicker
                            start-sleep $packagedelay
                            getStatus $global:ie
                            [int]$i++
                        }
                    }

                    if ($global:youtubeExists -like "True") {
                        $check = $global:ie.Document.body.getElementsByClassName("prize-title") | select-object textContent | out-string
                        [Clicker]::LeftClickAtPoint(900, 650)
                        start-sleep 17
                        youtubeClicker
                        start-sleep 6
                        getStatus $global:ie
                    }

                    if ($global:amazonvidExists -like "True") {
                        start-sleep 1
                        $theVideo = $global:ie.Document.IHTMLDocument3_getElementsbyTagName("video") | Where-Object { $_.initialtime -eq "0" }
                        $thevideo.play()
                        start-sleep 17
                        youtubeClicker
                        start-sleep 5
                        getStatus $global:ie
                    }

                }
                if ([string]$global:statusTitle -like "*You Won*") {
                    $gwlink | out-file $winners -append
                    $check | out-file $winners -append
                    $global:ie.Document.IHTMLDocument3_getElementbyID("continue-button").click()
                    start-sleep 2
                    $global:ie.Document.IHTMLDocument3_getElementbyID("ShipMyPrize").click()
                    start-sleep 2
                    $global:ie.Document.IHTMLDocument3_getElementbyID("ShipMyPrize").click()
                    start-sleep 2
                    $global:ie.Document.IHTMLDocument3_getElementbyID("ShipMyPrize").click()
                    start-sleep 2
                    #Winclicker
                    Write-host ("Check " + $GWLINK) -ForegroundColor Green
                }

                if ([string]$global:statusTitle -notlike "*You Won*") {
                    write-host ("Didn't win. " + $GWLINK) -ForegroundColor Red 
                }

            }
        }
    }
}

