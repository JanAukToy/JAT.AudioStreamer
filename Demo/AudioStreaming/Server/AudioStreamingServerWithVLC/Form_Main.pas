unit Form_Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
  Vcl.Samples.Spin,
  Winapi.Windows;

type
  TFormMain = class(TForm)
    pnl_Settings: TPanel;
    pnl_Control: TPanel;
    btn_Start: TButton;
    btn_End: TButton;
    pnl_CacheMS: TPanel;
    txt_CacheMS: TLabel;
    spn_CacheMS: TSpinEdit;
    pnl_ClockJitterMS: TPanel;
    txt_ClockJitterMS: TLabel;
    spn_ClockJitterMS: TSpinEdit;
    pnl_DirSDPFileName: TPanel;
    txt_DirSDPFileName: TLabel;
    edt_DirSDPFileName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
  private
    { Private éŒ¾ }
    f_DirVLCPlayer: string;
    f_VLCProcessInfo: TProcessInformation;

    function GetVLCInstallFolder: string;
    function StartReceiveAudioStreaming(const a_DirVLCPlayer: string; const a_DirSDPFileName: string;
      const a_CacheMS, a_ClockJitterMS: Word): Boolean;
    procedure EndReceiveAudioStreaming;
  public
    { Public éŒ¾ }
  end;

var
  FormMain: TFormMain;

implementation

uses
  Win.Registry;

{$R *.dfm}


procedure TFormMain.FormCreate(Sender: TObject);
begin
  ZeroMemory(@f_VLCProcessInfo, SizeOf(f_VLCProcessInfo));

  f_DirVLCPlayer := GetVLCInstallFolder;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  EndReceiveAudioStreaming;
end;

procedure TFormMain.btn_StartClick(Sender: TObject);
begin
  StartReceiveAudioStreaming(
    f_DirVLCPlayer, edt_DirSDPFileName.Text, spn_CacheMS.Value, spn_ClockJitterMS.Value);
end;

procedure TFormMain.btn_EndClick(Sender: TObject);
begin
  EndReceiveAudioStreaming;
end;

function TFormMain.GetVLCInstallFolder: string;
const
  VLC_REG_KEY = 'SOFTWARE\VideoLAN\VLC';
  VLC_REG_VALUE = 'InstallDir';
var
  l_Registry: TRegistry;
begin
  Result := '';
  l_Registry := TRegistry.Create(KEY_READ);

  try
    l_Registry.RootKey := HKEY_LOCAL_MACHINE;
    l_Registry.Access := KEY_READ or KEY_WOW64_64KEY;

    if l_Registry.OpenKeyReadOnly(VLC_REG_KEY) then
    begin
      if l_Registry.ValueExists(VLC_REG_VALUE) then
      begin
        Result := l_Registry.ReadString(VLC_REG_VALUE);
      end;

      l_Registry.CloseKey;
    end;

  finally
    l_Registry.Free;
  end;

  if Result = '' then
    raise Exception.Create('VLC player not found.');
end;

function TFormMain.StartReceiveAudioStreaming(const a_DirVLCPlayer: string; const a_DirSDPFileName: string;
  const a_CacheMS, a_ClockJitterMS: Word): Boolean;
var
  l_StartupInfo: TStartupInfo;
  l_ProcessInfo: TProcessInformation;
  l_ExecCmd: string;
begin
  FillChar(l_StartupInfo, SizeOf(l_StartupInfo), 0);
  l_StartupInfo.cb := SizeOf(l_StartupInfo);

  // Create command *using dummy interface.
  l_ExecCmd :=
    Format('"%s\vlc.exe" -I dummy --network-caching %d --clock-jitter %d "%s"', [
    a_DirVLCPlayer, a_CacheMS, a_ClockJitterMS, a_DirSDPFileName]);

  // Execute
  if CreateProcess(nil, PChar(l_ExecCmd), nil, nil, False, 0, nil, nil, l_StartupInfo, l_ProcessInfo) then
  begin
    f_VLCProcessInfo := l_ProcessInfo;

    btn_Start.Enabled := False;
    btn_End.Enabled := True;

    Result := True;
  end
  else
  begin
    raise Exception.Create('Failed to start VLC player process.');
  end;
end;

procedure TFormMain.EndReceiveAudioStreaming;
begin
  if f_VLCProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(f_VLCProcessInfo.hProcess, 0);
    CloseHandle(f_VLCProcessInfo.hProcess);
  end;

  if f_VLCProcessInfo.hThread > 0 then
    CloseHandle(f_VLCProcessInfo.hThread);

  ZeroMemory(@f_VLCProcessInfo, SizeOf(f_VLCProcessInfo));

  btn_Start.Enabled := True;
  btn_End.Enabled := False;
end;

end.
