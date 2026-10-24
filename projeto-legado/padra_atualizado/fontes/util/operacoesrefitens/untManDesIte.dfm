inherited frmManDesIte: TfrmManDesIte
  Width = 483
  Height = 299
  Caption = 'Manuten'#231#227'o de Produto'
  Position = poMainFormCenter
  ExplicitWidth = 483
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 226
    Width = 477
    TabOrder = 2
    ExplicitTop = 226
    ExplicitWidth = 477
    inherited FlwBotoes: TFlowPanel
      Left = 154
      Width = 244
      TabOrder = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 398
      Top = 2
      Height = 24
      Align = alRight
      ModalResult = 2
      TabOrder = 2
      OnClick = nil
      ExplicitLeft = 398
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 24
      Align = alLeft
      Caption = '&Confirma'
      Enabled = False
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
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitHeight = 22
    end
    object btnCancela: TBitBtnLocked
      Left = 77
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = 'Cancela'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnCancelaClick
      ExplicitLeft = 80
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlCodIte: TPanel [2]
    Left = 0
    Top = 0
    Width = 477
    Height = 48
    Align = alTop
    BevelInner = bvLowered
    BorderWidth = 2
    ParentColor = True
    TabOrder = 0
    object lblProduto: TLabel
      Left = 12
      Top = 17
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 55
      Top = 13
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 122
      Top = 13
      Width = 342
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 48
    Width = 477
    Height = 178
    Align = alClient
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 1
    object lbl2: TLabel
      Left = 8
      Top = 81
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aplica'#231#227'o'
    end
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 99
      Height = 14
      Caption = 'Descri'#231#227'o Completa:'
    end
    object Label2: TLabel
      Left = 8
      Top = 42
      Width = 112
      Height = 14
      Caption = 'Descri'#231#227'o Simplificada:'
    end
    object mmoAplIte: TMemoFocus
      Tag = 99
      Left = 8
      Top = 97
      Width = 456
      Height = 71
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtDesCom: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 456
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 70
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 70
      TipoTexto = ttAlfanumerico
    end
    object edtDesSim: TEditFocus
      Tag = 99
      Left = 8
      Top = 58
      Width = 456
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 70
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 70
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 254
    Width = 477
    TabOrder = 3
    ExplicitTop = 254
    ExplicitWidth = 477
    inherited pnlNomeForm: TPanel
      Left = 306
      ExplicitLeft = 306
    end
    inherited pnlInfo: TPanel
      Width = 306
      ExplicitWidth = 306
    end
  end
end
