inherited frmManutKmRodado: TfrmManutKmRodado
  Left = 252
  Top = 307
  Width = 529
  Height = 485
  Caption = 'Manuten'#231#227'o de KM rodado'
  ExplicitWidth = 529
  ExplicitHeight = 485
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 390
    Width = 523
    Height = 50
    ExplicitTop = 390
    ExplicitWidth = 523
    ExplicitHeight = 50
    inherited FlwBotoes: TFlowPanel
      Width = 519
      Height = 46
      ExplicitTop = 2
      ExplicitWidth = 519
      ExplicitHeight = 46
      inherited btnCancela: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 362
        Width = 74
        ExplicitLeft = 362
        ExplicitWidth = 74
      end
      object btnGerarContasAPagar: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 216
        Height = 21
        Caption = 'Gerar Contas a Pagar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
          BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
          00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
          E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
          FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
          7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
          E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
          811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
          88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
          E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
          FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
          88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
          EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
          811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
          00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
          F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
          FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
          00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
          4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnGerarContasAPagarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 442
      Width = 72
      Height = 20
      ExplicitLeft = 442
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 440
    Width = 523
    ExplicitTop = 440
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 363
      Width = 160
      ExplicitLeft = 363
      ExplicitWidth = 160
    end
    inherited pnlInfo: TPanel
      Width = 363
      ExplicitWidth = 363
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 390
    ExplicitWidth = 523
    ExplicitHeight = 390
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 358
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 390
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 46
      Top = 43
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object Label2: TLabel
      Left = 59
      Top = 19
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object Label3: TLabel
      Left = 37
      Top = 164
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'KM Inicial:'
    end
    object Label4: TLabel
      Left = 196
      Top = 164
      Width = 45
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'KM Final:'
    end
    object Label5: TLabel
      Left = 8
      Top = 188
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abast.Valor R$:'
    end
    object Label6: TLabel
      Left = 179
      Top = 188
      Width = 62
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Abast.Litros:'
    end
    object lblConsLt: TLabel
      Left = 196
      Top = 235
      Width = 114
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Consumo em KM litros'
    end
    object lblConsKM: TLabel
      Left = 81
      Top = 235
      Width = 113
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Consumo em KM valor'
    end
    object Label9: TLabel
      Left = 32
      Top = 212
      Width = 52
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Motorista:'
    end
    object lbl1: TLabel
      Left = 363
      Top = 164
      Width = 67
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'KM Rodado:'
    end
    object lbl2: TLabel
      Left = 322
      Top = 235
      Width = 83
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Km por litro'
    end
    object Label10: TLabel
      Left = 38
      Top = 280
      Width = 46
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Hist'#243'rico:'
    end
    object Label11: TLabel
      Left = 348
      Top = 188
      Width = 82
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Manut. Valor R$:'
    end
    object Label7: TLabel
      Left = 282
      Top = 19
      Width = 151
      Height = 14
      Alignment = taRightJustify
      Caption = 'Autoriza'#231#227'o de Abastecimento:'
    end
    object lblFornecedor: TLabel
      Left = 8
      Top = 140
      Width = 76
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object lbl3: TLabel
      Left = 425
      Top = 235
      Width = 77
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do litro'
    end
    object lblKmAtual: TLabel
      Left = 179
      Top = 64
      Width = 325
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbePlaVei: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 40
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'KMT_PLAVEI'
      DataSource = dtsManKm_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbePlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeKmtIni: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 161
      Width = 70
      Height = 22
      DataField = 'KMT_KMTINI'
      DataSource = dtsManKm_
      MaxLength = 7
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeKmtFin: TDBEditFocus
      Tag = 99
      Left = 243
      Top = 161
      Width = 70
      Height = 22
      DataField = 'KMT_KMTFIN'
      DataSource = dtsManKm_
      MaxLength = 7
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeAbaVlr: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 185
      Width = 70
      Height = 22
      DataField = 'KMT_ABAVLR'
      DataSource = dtsManKm_
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeAbaLit: TDBEditFocus
      Tag = 99
      Left = 243
      Top = 185
      Width = 70
      Height = 22
      DataField = 'KMT_ABALIT'
      DataSource = dtsManKm_
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtConLit: TEditFocus
      Left = 200
      Top = 250
      Width = 107
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVei: TEditFocus
      Left = 156
      Top = 40
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConVlr: TEditFocus
      Left = 84
      Top = 250
      Width = 108
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMot: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 209
      Width = 70
      Height = 22
      DataField = 'KMT_CODMOT'
      DataSource = dtsManKm_
      MaxLength = 7
      TabOrder = 13
      OnKeyPress = dbeCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomMot: TEditFocus
      Left = 158
      Top = 209
      Width = 346
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtKmRoda: TEditFocus
      Left = 434
      Top = 161
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtKm_Lit: TEditFocus
      Left = 314
      Top = 250
      Width = 91
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeHistor: TDBMemoFocus
      Left = 85
      Top = 277
      Width = 419
      Height = 105
      DataField = 'KMT_HISTOR'
      DataSource = dtsManKm_
      TabOrder = 18
      OnKeyPress = dbeHistorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeManVlr: TDBEditFocus
      Tag = 99
      Left = 434
      Top = 185
      Width = 70
      Height = 22
      DataField = 'KMT_MANVLR'
      DataSource = dtsManKm_
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object gpbTipLan: TGroupBox
      Left = 85
      Top = 76
      Width = 419
      Height = 56
      Caption = 'Tipo de lan'#231'amento'
      TabOrder = 4
      object ColorLabel1: TColorLabel
        Left = 31
        Top = 24
        Width = 255
        Height = 14
        Caption = '(A)bastecimento (C)onserto \ Manuten'#231#227'o  (P)ed'#225'gio'
        CorDestaque = clRed
      end
      object dbeTipLan: TDBEditFocus
        Tag = 99
        Left = 3
        Top = 21
        Width = 25
        Height = 22
        CharCase = ecUpperCase
        DataField = 'KMT_TIPLAN'
        DataSource = dtsManKm_
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeAutAba: TDBEditFocus
      Tag = 99
      Left = 434
      Top = 16
      Width = 70
      Height = 22
      DataField = 'KMT_SEQABA'
      DataSource = dtsManKm_
      MaxLength = 6
      TabOrder = 1
      OnKeyPress = dbeAutAbaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object pnlDadosPedagio: TPanel
      Left = 553
      Top = 146
      Width = 504
      Height = 23
      BevelOuter = bvNone
      TabOrder = 8
      object Label8: TLabel
        Left = 2
        Top = 3
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vl. Total Ped'#225'gio:'
      end
      object dbeVltPdg: TDBEditFocus
        Tag = 99
        Left = 85
        Top = 0
        Width = 70
        Height = 22
        DataField = 'KMT_VLTPDG'
        DataSource = dtsManKm_
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 137
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'KMT_CODFOR'
      DataSource = dtsManKm_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 158
      Top = 137
      Width = 346
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaCad: TcxDBDateEdit
      Tag = 99
      Left = 85
      Top = 16
      AutoSize = False
      DataBinding.DataField = 'KMT_DTACAD'
      DataBinding.DataSource = dtsManKm_
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
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Height = 22
      Width = 92
    end
    object edtValor_lit: TEditFocus
      Left = 411
      Top = 250
      Width = 91
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 256
  end
  object dtsManKm_: TDataSource
    OnDataChange = dtsManKm_DataChange
    Left = 176
    Top = 256
  end
end
