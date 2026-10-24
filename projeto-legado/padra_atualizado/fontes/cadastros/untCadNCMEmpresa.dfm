inherited frmCadNCMEmpresa: TfrmCadNCMEmpresa
  Width = 602
  Height = 140
  Caption = 'Cadastro de NCM por Empresa'
  OnCanResize = FormCanResize
  ExplicitWidth = 602
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 67
    Width = 596
    ExplicitTop = 67
    ExplicitWidth = 596
    inherited FlwBotoes: TFlowPanel
      Width = 592
      ExplicitTop = 2
      ExplicitWidth = 592
      inherited btnPesquisa: TBitBtnLocked
        Width = 77
        ExplicitWidth = 77
      end
      object btnImportar: TBitBtnLocked
        Left = 437
        Top = 0
        Width = 72
        Height = 20
        Caption = '&Importar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000E000000100000001000000010000000100000001000000011000000110000
          0011000000110000001100000011000000100000000B0000000377544AC1A474
          66FFA47465FFA47465FFA37364FFA37264FFA27263FFA27263FFA27162FFA271
          62FFA17062FFA17061FFA17061FFA17061FF735046C30000000AAC7E71FFF8F1
          EEFFF8F0EDFFF8F1ECFFF8F0ECFFF8F0ECFFF5EDE9FFF2EAE6FFF5EDE9FFF8EF
          EBFFF7EFEBFFF7EFEBFFF7EFEBFFF7F0EBFFA8796AFF0000000FAD8172FFF8F2
          EFFFF6EDE8FFF7EDE8FFF6ECE8FFF4EBE6FFE6DBD6FFA87A62FFE7DCD8FFF5EB
          E6FFF6EDE7FFF6ECE8FFF6ECE8FFF8F0ECFFA97B6BFF00000010AF8375FFF9F2
          EFFFF6ECE8FFF6EDE9FFF6ECE7FFEDE5E0FFAD836EFFC58A51FFB08975FFEDE4
          E0FFF6ECE7FFF6ECE8FFF6ECE8FFF8F1EDFFAA7C6DFF0000000FB18577FFF9F3
          F0FFF7EDE9FFF7EDE8FFF3EAE5FFCDB3A8FFAC6E41FFF7C67AFFA96B40FFCDB6
          ABFFF1E8E4FFF7EDE8FFF6EDE9FFF9F1EDFFAB7E6FFF0000000EB2887AFFF9F4
          F0FFF7EEE9FFF5EBE7FFE4D8D1FFA06544FFEFBE79FFF9CA82FFEDBB78FF9F63
          42FFE3D7D2FFF4EBE7FFF7EEE9FFF8F1EEFFAD8072FF0000000EB48A7CFFF9F4
          F1FFF7EEEAFFF4EBE7FFC69E83FFB47C54FFB47B53FFFACF88FFB37851FFB277
          4FFFC3987EFFF2E9E5FFF7EEE9FFF9F2EFFFAF8274FF0000000DB68D7FFFFAF4
          F2FFF7EEEAFFF6EDE9FFF2E9E5FFE9E1DDFFB77F57FFFDD48EFFB1744CFFE8DF
          DBFFF1E7E4FFF6EDE9FFF7EEEAFFF9F2EFFFB08476FF0000000CB88F82FFFAF5
          F2FFF7EEEAFFF7EEEBFFF7EEEAFFF0E7E5FFBA845CFFFEEAC1FFB2774FFFEFE7
          E3FFF7EEEAFFF7EFEAFFF7EEEAFFF9F3F0FFB28679FF0000000CB99184FFFAF5
          F3FFF8EFEBFFF7EFEAFFF7EFEBFFF2EAE6FFCB9E76FFCB9E76FFCB9E76FFF2E8
          E5FFF7EFEAFFF7EEEAFFF7EFEBFFFAF4F1FFB3897BFF0000000BBB9387FFFAF6
          F4FFF7EFEBFFF7EEEBFFF8EFEBFFF6EDEAFFF2EAE6FFF1E9E5FFF2EAE6FFF6ED
          EAFFF7EFEBFFF7EFEBFFF7EEEBFFFAF3F2FFB58B7DFF0000000AD4A477FFD8B1
          8BFFD2A373FFD1A372FFD1A272FFD1A170FFD0A070FFD09F6FFFCF9F6EFFCE9E
          6DFFCF9D6CFFCE9C6BFFCE9C6AFFD3A77CFFCE9764FF00000009D4A678FFEED7
          B6FFE2BB87FFE2BA86FFE2B985FFE2BA85FFE2BA85FFE1B984FFE1B984FFE1B8
          84FFE1B883FFE1B883FFE0B783FFEBD0AAFFCE9864FF00000009D4A679FFF1DC
          BCFFF0DCBCFFF0DBBCFFF0DBBCFFF0DCBBFFEFDABBFFEFDABBFFEFDABAFFEFDA
          B9FFEFD8B9FFEFD9B8FFEFD8B6FFEED5B1FFCE9865FF000000089E7B5AC0D4A6
          79FFD4A577FFD4A476FFD3A375FFD3A272FFD2A071FFD1A06FFFD09F6FFFD09D
          6DFFD09C6CFFD09B6AFFCF9B68FFCF9A67FF99714BC200000005}
        TabOrder = 6
        OnClick = btnImportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 515
      Height = 20
      ExplicitLeft = 515
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 596
    ExplicitTop = 95
    ExplicitWidth = 596
    inherited pnlNomeForm: TPanel
      Left = 249
      ExplicitLeft = 249
    end
    inherited pnlInfo: TPanel
      Width = 249
      ExplicitWidth = 249
    end
  end
  inherited pgcDados: TPageControl
    Width = 596
    Height = 67
    ActivePage = nil
    ExplicitWidth = 596
    ExplicitHeight = 67
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 588
      ExplicitHeight = 57
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 596
    Height = 67
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object lblCodIte: TLabel
      Left = 46
      Top = 17
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblCodPais: TLabel
      Left = 16
      Top = 40
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Empresa:'
    end
    object lblCodNCM: TLabel
      Left = 442
      Top = 40
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'NCM:'
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 13
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NCE_CODITE'
      DataSource = dtsCadNCMEmpresa
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 157
      Top = 13
      Width = 396
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
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
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 37
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NCE_CODEMP'
      DataSource = dtsCadNCMEmpresa
      MaxLength = 4
      TabOrder = 2
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 157
      Top = 37
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object dbeCodNCM: TDBEditFocus
      Tag = 99
      Left = 472
      Top = 37
      Width = 81
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NCE_CODNCM'
      DataSource = dtsCadNCMEmpresa
      MaxLength = 8
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 0
  end
  object dtsCadNCMEmpresa: TDataSource
    Left = 560
  end
end
