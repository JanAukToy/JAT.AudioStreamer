unit Form_Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,

  JalCaptureAudioThread, JalWaveWriter, Jal.Win.AudioClient;

type
  TFormMain = class(TForm)
    pnl_Settings: TPanel;
    pnl_SamplingRate: TPanel;
    txt_SamplingRate: TLabel;
    cmb_SamplingRate: TComboBox;
    pnl_Bits: TPanel;
    txt_Bits: TLabel;
    cmb_Bits: TComboBox;
    pnl_Channel: TPanel;
    txt_Channel: TLabel;
    cmb_Channel: TComboBox;
    pnl_Control: TPanel;
    btn_StartCapture: TButton;
    btn_EndCapture: TButton;
    pnl_AudioType: TPanel;
    txt_AudioType: TLabel;
    cmb_AudioType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartCaptureClick(Sender: TObject);
    procedure btn_EndCaptureClick(Sender: TObject);
  private
    { Private �錾 }
    f_CaptureAudioThread: TJalCaptureAudioThread;
    f_WaveWriter: TJalWaveWriter;

    procedure OnIdleApplication(Sender: TObject; var Done: Boolean);
    procedure OnCaptureBuffer(const a_Sender: TThread; const a_pData: PByte; const a_Count: Integer);
    procedure OnTerminate(Sender: TObject);
  public
    { Public �錾 }
  end;

var
  FormMain: TFormMain;

implementation

uses
  JalWaveHelper;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Application.OnIdle := OnIdleApplication;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  if Assigned(f_CaptureAudioThread) then
    f_CaptureAudioThread.Terminate;
end;

procedure TFormMain.OnIdleApplication(Sender: TObject; var Done: Boolean);
var
  l_isRunningThread: Boolean;
begin
  l_isRunningThread := Assigned(f_CaptureAudioThread);

  btn_StartCapture.Enabled := not l_isRunningThread;
  btn_EndCapture.Enabled := l_isRunningThread;
end;

procedure TFormMain.btn_StartCaptureClick(Sender: TObject);
var
  l_Format: WAVEFORMATEX;
begin
  // Get Format
  l_Format := TJalWaveHelper.GetPCMFormat(StrToInt(cmb_SamplingRate.Text), StrToInt(cmb_Bits.Text),
    cmb_Channel.ItemIndex + 1);

  // Create Wave Writer
  f_WaveWriter := TJalWaveWriter.Create(ExtractFileDir(Application.ExeName) + Format('\%dch%dhz%dbit.wav',
    [l_Format.nChannels, l_Format.nSamplesPerSec, l_Format.wBitsPerSample]), l_Format);

  // Create Capture Thread
  f_CaptureAudioThread := TJalCaptureAudioThread.Create(TAudioType(cmb_AudioType.ItemIndex), @f_WaveWriter.Format);

  // Assign Handlers
  f_CaptureAudioThread.OnCaptureBuffer := OnCaptureBuffer;
  f_CaptureAudioThread.OnTerminate := OnTerminate;
end;

procedure TFormMain.btn_EndCaptureClick(Sender: TObject);
begin
  if Assigned(f_CaptureAudioThread) then
    f_CaptureAudioThread.Terminate;
end;

procedure TFormMain.OnCaptureBuffer(const a_Sender: TThread; const a_pData: PByte; const a_Count: Integer);
begin
  // Write Buffer
  f_WaveWriter.WriteBuffer(a_pData, a_Count);
end;

procedure TFormMain.OnTerminate(Sender: TObject);
begin
  TThread.Queue(nil,
    procedure
    begin
      FreeAndNil(f_WaveWriter);
      f_CaptureAudioThread := nil;
    end);
end;

end.
