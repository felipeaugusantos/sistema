inherited frmSelBancoExt: TfrmSelBancoExt
  Width = 160
  Height = 112
  BorderStyle = bsNone
  Caption = 'frmSelBancoExt'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 160
  ExplicitHeight = 112
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel [0]
    Left = 0
    Top = 28
    Width = 160
    Height = 68
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = 16770261
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object btnBB: TcxButton
      Left = 6
      Top = 36
      Width = 145
      Height = 25
      Caption = '001 - Banco do Brasil'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      TabOrder = 1
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnBBClick
    end
    object btnItau: TcxButton
      Left = 7
      Top = 67
      Width = 145
      Height = 25
      Caption = '341 - Ita'#250
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      TabOrder = 2
      Visible = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnItauClick
    end
    object btnSantander: TcxButton
      Left = 7
      Top = 98
      Width = 145
      Height = 25
      Caption = '033 - Santander'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      TabOrder = 3
      Visible = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnSantanderClick
    end
    object btnSicredi: TcxButton
      Left = 6
      Top = 129
      Width = 145
      Height = 25
      Caption = '748 - Sicredi'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      TabOrder = 4
      Visible = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnSicrediClick
    end
    object btnBradesco: TcxButton
      Left = 7
      Top = 4
      Width = 144
      Height = 25
      Caption = '237 - Bradesco'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnBradescoClick
    end
  end
  inherited pnlBotoes: TPanel
    Top = 96
    Width = 160
    Height = 0
    TabOrder = 4
    ExplicitTop = 96
    ExplicitWidth = 160
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 156
      ExplicitWidth = 156
    end
    inherited btnSair: TBitBtnLocked
      Left = 324
      Top = -25
      ExplicitLeft = 324
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 160
    TabOrder = 2
    ExplicitTop = 96
    ExplicitWidth = 160
    inherited pnlNomeForm: TPanel
      Left = 2
      Width = 158
      ExplicitLeft = 2
      ExplicitWidth = 158
    end
    inherited pnlInfo: TPanel
      Width = 2
      ExplicitWidth = 2
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 160
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Color = clNavy
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    StyleElements = [seFont]
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 47
      Height = 22
      Align = alLeft
      Caption = 'Op'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
      ExplicitHeight = 16
    end
    object btnFechar: TcxButton
      AlignWithMargins = True
      Left = 134
      Top = 1
      Width = 25
      Height = 26
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'X'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnFecharClick
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 48
  end
end
