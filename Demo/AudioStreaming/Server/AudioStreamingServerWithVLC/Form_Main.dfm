object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'JAudioLib - AudioStreamingServerWithVLC'
  ClientHeight = 211
  ClientWidth = 334
  Color = clBtnFace
  Constraints.MaxHeight = 250
  Constraints.MaxWidth = 350
  Constraints.MinHeight = 150
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Meiryo UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnl_Settings: TPanel
    Left = 0
    Top = 0
    Width = 334
    Height = 161
    Align = alClient
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitHeight = 361
    object pnl_CacheMS: TPanel
      Left = 11
      Top = 11
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 5000
      object txt_CacheMS: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Cache(ms):'
        Layout = tlCenter
      end
      object spn_CacheMS: TSpinEdit
        Left = 130
        Top = 0
        Width = 182
        Height = 25
        Align = alClient
        MaxValue = 10000
        MinValue = 0
        TabOrder = 0
        Value = 100
      end
    end
    object pnl_ClockJitterMS: TPanel
      Left = 11
      Top = 36
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 500
      object txt_ClockJitterMS: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'ClockJitter(ms):'
        Layout = tlCenter
      end
      object spn_ClockJitterMS: TSpinEdit
        Left = 130
        Top = 0
        Width = 182
        Height = 25
        Align = alClient
        MaxValue = 10000
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object pnl_DirSDPFileName: TPanel
      Left = 11
      Top = 61
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 500
      object txt_DirSDPFileName: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'DirSDPFileName:'
        Layout = tlCenter
      end
      object edt_DirSDPFileName: TEdit
        Left = 130
        Top = 0
        Width = 182
        Height = 25
        Align = alClient
        TabOrder = 0
        Text = './stream.sdp'
        ExplicitLeft = 96
        ExplicitWidth = 121
        ExplicitHeight = 23
      end
    end
  end
  object pnl_Control: TPanel
    Left = 0
    Top = 161
    Width = 334
    Height = 50
    Align = alBottom
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 1
    ExplicitTop = 361
    object btn_Start: TButton
      Left = 11
      Top = 11
      Width = 100
      Height = 28
      Align = alLeft
      Caption = 'START'
      TabOrder = 0
      OnClick = btn_StartClick
    end
    object btn_End: TButton
      Left = 223
      Top = 11
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'END'
      Enabled = False
      TabOrder = 1
      OnClick = btn_EndClick
    end
  end
end
