object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'JAudioLib - AudioStreamingClientByFFmpeg'
  ClientHeight = 411
  ClientWidth = 334
  Color = clBtnFace
  Constraints.MaxHeight = 450
  Constraints.MaxWidth = 350
  Constraints.MinHeight = 250
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
    Height = 361
    Align = alClient
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    object txt_InputFormat: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 16
      Width = 312
      Height = 15
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Alignment = taCenter
      Caption = 'Input Format'
      Layout = tlCenter
      ExplicitWidth = 78
    end
    object txt_OutputSettings: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 166
      Width = 312
      Height = 15
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Alignment = taCenter
      Caption = 'Output Settings'
      Layout = tlCenter
      ExplicitWidth = 92
    end
    object pnl_SamplingRate: TPanel
      Left = 11
      Top = 86
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object txt_SamplingRate: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'SamplingRate (kHz):'
        Layout = tlCenter
      end
      object cmb_SamplingRate: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '8000'
        Items.Strings = (
          '8000'
          '16000'
          '44100'
          '48000')
      end
    end
    object pnl_Bits: TPanel
      Left = 11
      Top = 111
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object txt_Bits: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Bits:'
        Layout = tlCenter
      end
      object cmb_Bits: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '8'
        Items.Strings = (
          '8'
          '16'
          '32')
      end
    end
    object pnl_Channel: TPanel
      Left = 11
      Top = 136
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object txt_Channel: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Channel:'
        Layout = tlCenter
      end
      object cmb_Channel: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Monoral'
        Items.Strings = (
          'Monoral'
          'Stereo')
      end
    end
    object pnl_AudioType: TPanel
      Left = 11
      Top = 36
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object txt_AudioType: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'AudioType:'
        Layout = tlCenter
      end
      object cmb_AudioType: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Mic'
        Items.Strings = (
          'Mic'
          'System')
      end
    end
    object pnl_ShareMode: TPanel
      Left = 11
      Top = 61
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object txt_ShareMode: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'ShareMode:'
        Layout = tlCenter
        ExplicitTop = -6
      end
      object cmb_ShareMode: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Shared'
        Items.Strings = (
          'Shared'
          'Exclusive')
      end
    end
    object pnl_OutputCodec: TPanel
      Left = 11
      Top = 186
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object txt_OutputCodec: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Codec:'
        Layout = tlCenter
      end
      object cmb_OutputCodec: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Opus'
        Items.Strings = (
          'Opus')
      end
    end
    object pnl_OutputBitrate: TPanel
      Left = 11
      Top = 211
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object txt_OutputBitrate: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Bitrate:'
        Layout = tlCenter
      end
      object cmb_OutputBitrate: TComboBox
        Left = 130
        Top = 0
        Width = 182
        Height = 23
        Align = alClient
        Style = csDropDownList
        ItemIndex = 4
        TabOrder = 0
        Text = '96000'
        Items.Strings = (
          '16000'
          '24000'
          '48000'
          '64000'
          '96000'
          '128000'
          '256000')
      end
    end
    object pnl_OutputIP: TPanel
      Left = 11
      Top = 236
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 7
      object txt_OutputIP: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'IP:'
        Layout = tlCenter
      end
      object edt_OutputIP: TEdit
        Left = 130
        Top = 0
        Width = 182
        Height = 25
        Align = alClient
        TabOrder = 0
        Text = '127.0.0.1'
        ExplicitHeight = 23
      end
    end
    object pnl_OutputPort: TPanel
      Left = 11
      Top = 261
      Width = 312
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 8
      object txt_OutputPort: TLabel
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Align = alLeft
        AutoSize = False
        Caption = 'Port:'
        Layout = tlCenter
      end
      object spn_OutputPort: TSpinEdit
        Left = 130
        Top = 0
        Width = 182
        Height = 25
        Align = alClient
        MaxValue = 65535
        MinValue = 0
        TabOrder = 0
        Value = 1234
      end
    end
  end
  object pnl_Control: TPanel
    Left = 0
    Top = 361
    Width = 334
    Height = 50
    Align = alBottom
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 1
    object btn_StartCapture: TButton
      Left = 11
      Top = 11
      Width = 100
      Height = 28
      Align = alLeft
      Caption = 'START'
      TabOrder = 0
      OnClick = btn_StartCaptureClick
    end
    object btn_EndCapture: TButton
      Left = 223
      Top = 11
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'END'
      TabOrder = 1
      OnClick = btn_EndCaptureClick
    end
  end
end
