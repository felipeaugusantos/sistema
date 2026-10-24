inherited frmCadVenDiaEmp: TfrmCadVenDiaEmp
  Width = 593
  Height = 161
  Caption = 'Vendas Di'#225'rias por Empresa - Cadastro de Ajuste'
  ExplicitWidth = 593
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 88
    Width = 587
    ExplicitTop = 166
    ExplicitWidth = 587
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitWidth = 583
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 22
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 22
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 22
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 22
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 22
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 22
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 501
      Width = 78
      ExplicitLeft = 501
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 116
    Width = 587
    ExplicitTop = 194
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 400
      Width = 187
      ExplicitLeft = 400
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 400
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 88
    Visible = False
    ExplicitWidth = 587
    ExplicitHeight = 166
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 579
      ExplicitHeight = 134
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 587
    Height = 88
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitHeight = 166
    object Label3: TLabel
      Left = 56
      Top = 18
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
    end
    object Label5: TLabel
      Left = 73
      Top = 43
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object Label7: TLabel
      Left = 217
      Top = 46
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object dbeDtaAju: TDBEditFocus
      Tag = 99
      Left = 375
      Top = 43
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_DTAAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 15
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_CODEMP'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = dbeCodEmpExit
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 148
      Top = 15
      Width = 381
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeValAju: TDBEditFocus
      Tag = 99
      Left = 251
      Top = 43
      Width = 118
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_VALAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object mskDtaAju: TcxDateEdit
      Tag = 99
      Left = 104
      Top = 41
      Enabled = False
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 90
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 24
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
