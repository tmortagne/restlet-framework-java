# Auto-generated by EclipseNSIS Script Wizard
# 4 janv. 2007 16:46:31

Name "Restlet"
SetCompressor lzma

# Defines
!define VERSION @version-compact@
!define REGKEY "SOFTWARE\Noelios\$(^Name)"
!define COMPANY "Noelios Consulting"
!define URL http://www.restlet.org

Caption "Noelios Restlet Engine @version-full@"
BrandingText " "

# MUI defines
!define MUI_ICON @www@/favicon.ico
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Noelios\$(^Name)"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_UNICON @www@/favicon.ico
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH
!define MUI_WELCOMEFINISHPAGE_BITMAP @images-dir@\installer.bmp
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP @images-dir@\logo150.bmp
!define MUI_LANGDLL_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Noelios"

# Included files
!include Sections.nsh
!include MUI.nsh
!include LogicLib.nsh
!include TextFunc.nsh

!insertmacro un.LineFind
!insertmacro un.TrimNewLines

#Include library from Mozilla foundation
!include common.nsh
# Reserved Files

# Variables
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE @license-dir@/LICENSE.txt
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE English ;first language is the default language
!insertmacro MUI_LANGUAGE Albanian
!insertmacro MUI_LANGUAGE Arabic
!insertmacro MUI_LANGUAGE Basque
!insertmacro MUI_LANGUAGE Belarusian
!insertmacro MUI_LANGUAGE Bosnian
!insertmacro MUI_LANGUAGE Breton
!insertmacro MUI_LANGUAGE Bulgarian
!insertmacro MUI_LANGUAGE Catalan
!insertmacro MUI_LANGUAGE Croatian
!insertmacro MUI_LANGUAGE Czech
!insertmacro MUI_LANGUAGE Danish
!insertmacro MUI_LANGUAGE Dutch
!insertmacro MUI_LANGUAGE Estonian
!insertmacro MUI_LANGUAGE Farsi
!insertmacro MUI_LANGUAGE Finnish
!insertmacro MUI_LANGUAGE French
!insertmacro MUI_LANGUAGE German
!insertmacro MUI_LANGUAGE Greek
!insertmacro MUI_LANGUAGE Hebrew
!insertmacro MUI_LANGUAGE Hungarian
!insertmacro MUI_LANGUAGE Icelandic
!insertmacro MUI_LANGUAGE Indonesian
!insertmacro MUI_LANGUAGE Irish
!insertmacro MUI_LANGUAGE Italian
!insertmacro MUI_LANGUAGE Japanese
!insertmacro MUI_LANGUAGE Korean
!insertmacro MUI_LANGUAGE Kurdish
!insertmacro MUI_LANGUAGE Latvian
!insertmacro MUI_LANGUAGE Lithuanian
!insertmacro MUI_LANGUAGE Luxembourgish
!insertmacro MUI_LANGUAGE Macedonian
!insertmacro MUI_LANGUAGE Malay
!insertmacro MUI_LANGUAGE Mongolian
!insertmacro MUI_LANGUAGE Norwegian
!insertmacro MUI_LANGUAGE NorwegianNynorsk
!insertmacro MUI_LANGUAGE Polish
!insertmacro MUI_LANGUAGE Portuguese
!insertmacro MUI_LANGUAGE PortugueseBR
!insertmacro MUI_LANGUAGE Romanian
!insertmacro MUI_LANGUAGE Russian
!insertmacro MUI_LANGUAGE Serbian
!insertmacro MUI_LANGUAGE SerbianLatin
!insertmacro MUI_LANGUAGE SimpChinese
!insertmacro MUI_LANGUAGE Slovak
!insertmacro MUI_LANGUAGE Spanish
!insertmacro MUI_LANGUAGE Swedish
!insertmacro MUI_LANGUAGE Thai
!insertmacro MUI_LANGUAGE TradChinese
!insertmacro MUI_LANGUAGE Turkish
!insertmacro MUI_LANGUAGE Ukrainian
!insertmacro MUI_LANGUAGE Welsh

# Installer attributes
OutFile @dist-base@/restlet-${VERSION}.exe
InstallDir "$PROGRAMFILES\Noelios\Restlet-@version-base@"
CRCCheck on
XPStyle on
ShowInstDetails hide
ShowUnInstDetails hide
VIProductVersion @version-base@.0.0
VIAddVersionKey ProductName "Restlet"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion ""
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path

# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    File /r @dist@\*.*
    WriteRegStr HKLM "${REGKEY}\Components" Main 1
SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Version ${VERSION}
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    WriteUninstaller $INSTDIR\uninstall${VERSION}.exe
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Uninstall $(^Name)${VERSION}.lnk" $INSTDIR\uninstall${VERSION}.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Home page.lnk" "http://www.restlet.org" "" "$INSTDIR\uninstall${VERSION}.exe"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Restlet API (javadocs).lnk" "$INSTDIR\docs\api\index.html"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Restlet Extensions (javadocs).lnk" "$INSTDIR\docs\ext\index.html"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Noelios Restlet Engine (javadocs).lnk" "$INSTDIR\docs\nre\index.html"
    !insertmacro MUI_STARTMENU_WRITE_END
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" DisplayName "Noelios Restlet Engine @version-full@"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" DisplayIcon $INSTDIR\uninstall${VERSION}.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" UninstallString $INSTDIR\uninstall${VERSION}.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}" NoRepair 1
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o un.Main UNSEC0000
    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)${VERSION}"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Uninstall $(^Name)${VERSION}.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Home page.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Restlet API (javadocs).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Restlet Extensions (javadocs).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Restlet ${VERSION}\Noelios Restlet Engine (javadocs).lnk"

    Delete /REBOOTOK $INSTDIR\uninstall${VERSION}.exe
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegValue HKLM "${REGKEY}" Version
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup

    ; Remove files. If we don't have a log file skip
    ${If} ${FileExists} "$INSTDIR\uninstall.log"
        ; Copy the uninstall log file to a temporary file
        CopyFiles "$INSTDIR\uninstall.log" "$INSTDIR\uninstall.log.bak"

       ; Delete files
       ${un.LineFind} "$INSTDIR\uninstall.log.bak" "/NUL" "1:-1" "un.RemoveFilesCallback"

       ; Remove empty directories
       ${un.LineFind} "$INSTDIR\uninstall.log.bak" "/NUL" "1:-1" "un.RemoveDirsCallback"

       ; Delete the temporary uninstall log file
       ${DeleteFile} "$INSTDIR\uninstall.log.bak"

	   ; Remove the installation directory if it is empty
       ${RemoveDir} "$INSTDIR"

       ;Remove the Noelios directory (if so) if it is empty
       StrCmp "$INSTDIR" "$PROGRAMFILES\Noelios\Restlet-@version-base@" 0 +2
       ${RemoveDir} "$PROGRAMFILES\Noelios"
       
    ${EndIf}
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
    ;!insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    ReadRegStr $StartMenuGroup HKLM "${REGKEY}" StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

################################################################################
# Helper Functions

Function un.RemoveFilesCallback
	${un.TrimNewLines} "$R9" "$R9"
    StrCpy $R1 "$INSTDIR\$R9"
    ${deleteFile} "$R1"

	ClearErrors
	Push 0
FunctionEnd

; Using locate will leave file handles open to some of the directories which
; will prevent the deletion of these directories. This parses the uninstall.log
; and uses the file entries to find / remove empty directories.
Function un.RemoveDirsCallback
	${un.TrimNewLines} "$R9" "$R9"
	StrCpy $R2 "$INSTDIR"
	StrCpy $R1 "$INSTDIR\$R9"
    loop:
	   Push $R1
	   ${GetParentDir}
	   Pop $R0
	   GetFullPathName $R1 "$R0"
	   ; We only try to remove empty directories but the Desktop, StartMenu, and
	   ; QuickLaunch directories can be empty so guard against removing them.
	   ${If} "$R2" != "$INSTDIR"
	       SetShellVarContext all
	       ${If} $R1 == "$DESKTOP"
	       ${OrIf} $R1 == "$STARTMENU"
	           GoTo end
	       ${EndIf}
	       SetShellVarContext current
	       ${If} $R1 == "$QUICKLAUNCH"
	       ${OrIf} $R1 == "$DESKTOP"
	       ${OrIf} $R1 == "$STARTMENU"
	           GoTo end
	       ${EndIf}
	   ${ElseIf} "$R1" == "$INSTDIR"
	       GoTo end
	   ${EndIf}
	   ${RemoveDir} "$R1"

	   ${If} ${Errors}
	   ${OrIf} "$R2" != "$INSTDIR"
	       GoTo end
	   ${EndIf}
	   GoTo loop
	end:
	ClearErrors
    Push 0
FunctionEnd
