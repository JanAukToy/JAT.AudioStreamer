unit Jal.FFmpeg.Defines;

interface

type
  // --------------------------
  // Audio Streaming
  // --------------------------

  TJalFFmpegAudioStreamingCodecs = (jfascOpus);

  TJalFFmpegAudioStreamingCodecsHelper = record helper for TJalFFmpegAudioStreamingCodecs
    function ToParamStr: string;
  end;

  TJalFFmpegAudioStreamingSettings = record
    Codec: TJalFFmpegAudioStreamingCodecs;
    Bitrate: Cardinal;
    IP: string;
    Port: Integer;
    DirSDPFileName: string;
  end;

implementation

{ TJalFFmpegAudioStreamingCodecsHelper }

function TJalFFmpegAudioStreamingCodecsHelper.ToParamStr: string;
begin
  case Self of

    jfascOpus:
      Result := 'libopus';

  else
    Exit('');
  end;
end;

end.
