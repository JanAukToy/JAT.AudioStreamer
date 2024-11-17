unit Jal.FFmpeg.AudioStreamingClientPipe;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows, Winapi.MMSystem,
  Jal.FFmpeg.Defines;

type
  TJalFFmpegAudioStreamingClientPipe = class
  private
    f_DirFFmpeg: string;

    f_ProcessInfo: TProcessInformation;
    f_PipeInputHandle: THandle;
    f_PipeOutputHandle: THandle;

    function GetFFmpegCmdParams(const a_InputFormat: tWAVEFORMATEX;
      const a_OutputSettings: TJalFFmpegAudioStreamingSettings): string;
  public
    constructor Create(const a_DirFFmpeg: string);
    destructor Destroy; override;

    property ProcessInfo: TProcessInformation read f_ProcessInfo;

    function Execute(const a_InputFormat: tWAVEFORMATEX;
      const a_OutputSettings: TJalFFmpegAudioStreamingSettings): Boolean;
    procedure Terminate;

    function WriteData(const a_pData: PByte; const a_Count: DWORD): Boolean;
  end;

implementation

uses
  System.IOUtils, System.StrUtils;

{ TJalFFmpegAudioStreamingClientPipe }

constructor TJalFFmpegAudioStreamingClientPipe.Create(const a_DirFFmpeg: string);
begin
  f_DirFFmpeg := a_DirFFmpeg;

  ZeroMemory(@f_ProcessInfo, SizeOf(f_ProcessInfo));
  f_PipeInputHandle := 0;
  f_PipeOutputHandle := 0;
end;

destructor TJalFFmpegAudioStreamingClientPipe.Destroy;
begin
  Terminate;

  inherited;
end;

function TJalFFmpegAudioStreamingClientPipe.Execute(const a_InputFormat: tWAVEFORMATEX;
  const a_OutputSettings: TJalFFmpegAudioStreamingSettings): Boolean;
var
  l_StartupInfo: TStartupInfo;
  l_SecurityAttributes: TSecurityAttributes;
  l_FFmpegCmd: string;
begin
  // Set Security
  l_SecurityAttributes.nLength := SizeOf(l_SecurityAttributes);
  l_SecurityAttributes.bInheritHandle := True;
  l_SecurityAttributes.lpSecurityDescriptor := nil;

  // Create Pipe
  if not CreatePipe(f_PipeOutputHandle, f_PipeInputHandle, @l_SecurityAttributes, 0) then
  begin
    raise Exception.Create('Failed to create pipe.');
  end;

  // Process Settings
  ZeroMemory(@f_ProcessInfo, SizeOf(f_ProcessInfo));
  ZeroMemory(@l_StartupInfo, SizeOf(l_StartupInfo));
  l_StartupInfo.cb := SizeOf(l_StartupInfo);
  l_StartupInfo.hStdInput := f_PipeOutputHandle;
  l_StartupInfo.dwFlags := STARTF_USESTDHANDLES;

  // Create Command
  l_FFmpegCmd :=
    Format('"%s" %s', [TPath.Combine(f_DirFFmpeg, 'ffmpeg'), GetFFmpegCmdParams(a_InputFormat, a_OutputSettings)]);

  // Create Process
  if CreateProcess(
    nil, PChar(l_FFmpegCmd), nil, nil, True, CREATE_NO_WINDOW, nil, nil, l_StartupInfo, f_ProcessInfo) then
  begin
    Result := True;
  end
  else
  begin
    // Clear
    Terminate;

    raise Exception.Create('Failed to start FFmpeg process.');
  end;
end;

function TJalFFmpegAudioStreamingClientPipe.GetFFmpegCmdParams(const a_InputFormat: tWAVEFORMATEX;
  const a_OutputSettings: TJalFFmpegAudioStreamingSettings): string;
var
  l_DataFormat: string;
begin
  if a_InputFormat.wBitsPerSample = 8 then
  begin
    l_DataFormat := 'u8';
  end
  else
  begin
    // s16le/s32le
    l_DataFormat :=
      Format('s%dle', [a_InputFormat.wBitsPerSample]);
  end;

  Result :=
  // Input
    Format('-f %s -ar %d -ac %d -i - ', [l_DataFormat, a_InputFormat.nSamplesPerSec, a_InputFormat.nChannels]) +
  // Output
    Format('-c:a %s -b:a %d -f rtp rtp://%s:%d -sdp_file "%s"', [
    a_OutputSettings.Codec.ToParamStr, Integer(a_OutputSettings.Bitrate), a_OutputSettings.IP, a_OutputSettings.Port,
    a_OutputSettings.DirSDPFileName]);
end;

procedure TJalFFmpegAudioStreamingClientPipe.Terminate;
begin
  if f_PipeInputHandle > 0 then
  begin
    CloseHandle(f_PipeInputHandle);
    f_PipeInputHandle := 0;
  end;

  if f_PipeOutputHandle > 0 then
  begin
    CloseHandle(f_PipeOutputHandle);
    f_PipeOutputHandle := 0;
  end;

  if f_ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(f_ProcessInfo.hProcess, 0);
    CloseHandle(f_ProcessInfo.hProcess);
  end;

  if f_ProcessInfo.hThread > 0 then
    CloseHandle(f_ProcessInfo.hThread);

  ZeroMemory(@f_ProcessInfo, SizeOf(f_ProcessInfo));
end;

function TJalFFmpegAudioStreamingClientPipe.WriteData(const a_pData: PByte; const a_Count: DWORD): Boolean;
var
  l_BytesWritten: DWORD;
begin
  Result := False;

  if (f_PipeInputHandle <= 0) or (a_pData = nil) or (a_Count = 0) then
  begin
    Exit;
  end;

  // Write to Pipe
  if WriteFile(f_PipeInputHandle, a_pData^, a_Count, l_BytesWritten, nil) then
  begin
    Result := (l_BytesWritten = a_Count);
  end;
end;

end.
