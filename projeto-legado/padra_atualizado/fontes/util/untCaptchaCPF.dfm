inherited frmCaptchaCPF: TfrmCaptchaCPF
  Width = 506
  Height = 223
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta CPF'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 506
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 298
    Top = 8
    Width = 30
    Height = 16
    Caption = 'CPF:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 298
    Top = 101
    Width = 188
    Height = 16
    Caption = 'Digite os caracteres da imagem:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 298
    Top = 54
    Width = 122
    Height = 16
    Caption = 'Data de Nascimento:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 150
    Width = 500
    TabOrder = 4
    ExplicitTop = 150
    ExplicitWidth = 500
    inherited FlwBotoes: TFlowPanel
      Width = 496
      TabOrder = 2
      ExplicitWidth = 496
    end
    inherited btnSair: TBitBtnLocked
      Left = 417
      ExplicitLeft = 417
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Confirmar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 178
    Width = 500
    TabOrder = 5
    ExplicitTop = 178
    ExplicitWidth = 500
    inherited pnlNomeForm: TPanel
      Left = 329
      ExplicitLeft = 329
    end
    inherited pnlInfo: TPanel
      Width = 329
      ExplicitWidth = 329
    end
  end
  object mskCpf: TMaskEditFocus [5]
    Left = 298
    Top = 24
    Width = 188
    Height = 27
    TabStop = False
    Enabled = False
    EditMask = '999.999.999-99;0;'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    MaxLength = 14
    ParentFont = False
    TabOrder = 0
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtCaptcha: TEditFocus [6]
    Left = 298
    Top = 117
    Width = 188
    Height = 30
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    MaxLength = 15
    ParentFont = False
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object pnlCaptcha: TPanel [7]
    Left = 8
    Top = 8
    Width = 274
    Height = 139
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 3
    object lblAtualiza: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 108
      Width = 266
      Height = 26
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Bottom = 3
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Atualizar captcha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      Layout = tlCenter
      OnClick = lblAtualizaClick
      ExplicitTop = 109
    end
    object imgCaptcha: TImage
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 266
      Height = 105
      Margins.Bottom = 0
      Align = alClient
      Center = True
      Proportional = True
      Stretch = True
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 274
      ExplicitHeight = 97
    end
  end
  object mskDataNasc: TMaskEditFocus [8]
    Left = 298
    Top = 70
    Width = 188
    Height = 27
    TabStop = False
    Enabled = False
    EditMask = '99/99/9999;0;'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 1
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 24
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 0
  end
end
