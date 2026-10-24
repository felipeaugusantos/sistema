inherited frmCancelamentoPedidoJadlog: TfrmCancelamentoPedidoJadlog
  Width = 773
  Height = 532
  Caption = 'Cancelamento de Pedido - Jadlog'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 773
  ExplicitHeight = 532
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 459
    Width = 767
    TabOrder = 2
    ExplicitTop = 459
    ExplicitWidth = 767
    inherited FlwBotoes: TFlowPanel
      Width = 763
      ExplicitWidth = 763
      object btnEnvCan: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F10] Enviar Cancelamento'
        TabOrder = 0
        OnClick = btnEnvCanClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 160
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F5] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarClick
      end
      object btnDesmar: TBitBtnLocked
        Left = 320
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F6] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 684
      ExplicitLeft = 684
    end
  end
  inherited pnlStatus: TPanel
    Top = 487
    Width = 767
    TabOrder = 3
    ExplicitTop = 487
    ExplicitWidth = 767
    inherited pnlNomeForm: TPanel
      Left = 596
      ExplicitLeft = 596
    end
    inherited pnlInfo: TPanel
      Width = 596
      ExplicitWidth = 596
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 767
    Height = 137
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 12
      Width = 168
      Height = 14
      Caption = 'Per'#237'odo de Emiss'#227'o do documento:'
    end
    object Label2: TLabel
      Left = 62
      Top = 37
      Width = 112
      Height = 14
      Caption = 'N'#250'mero do Documento:'
    end
    object Label3: TLabel
      Left = 57
      Top = 62
      Width = 117
      Height = 14
      Caption = 'Empresa do Documento:'
    end
    object Label4: TLabel
      Left = 67
      Top = 86
      Width = 107
      Height = 14
      Caption = 'Cliente do Documento:'
    end
    object Label5: TLabel
      Left = 46
      Top = 110
      Width = 128
      Height = 14
      Caption = 'C'#243'digo de Rastreio Jadlog:'
    end
    object Label7: TLabel
      Left = 269
      Top = 12
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object edtNumDoc: TEditFocus
      Left = 175
      Top = 34
      Width = 119
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 240
      Top = 83
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 175
      Top = 83
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodRas: TEditFocus
      Left = 175
      Top = 107
      Width = 119
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 14
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 175
      Top = 59
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 3
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 229
      Top = 59
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 175
      Top = 8
      AutoSize = False
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
      TabOrder = 0
      Height = 24
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 278
      Top = 8
      AutoSize = False
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
      TabOrder = 1
      Height = 24
      Width = 90
    end
    object btnAdicionar: TBitBtnLocked
      Left = 307
      Top = 107
      Width = 104
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 8
      OnClick = btnAdicionarClick
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 435
    Width = 767
    Height = 24
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label6: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 759
      Height = 19
      Align = alClient
      Alignment = taCenter
      Caption = 'Pressione Enter para marcar o registro no grid'
      ExplicitWidth = 223
      ExplicitHeight = 14
    end
  end
  object grdjadlog: TcxGrid [4]
    Left = 0
    Top = 137
    Width = 767
    Height = 298
    Align = alClient
    TabOrder = 1
    object grdjadlogDBTableView: TcxGridDBTableView
      OnKeyPress = grdjadlogDBTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdjadlogDBTableViewCustomDrawCell
      DataController.DataSource = dtsJadlog
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdjadlogDTAEMI: TcxGridDBColumn
        Caption = 'Data de Emiss'#227'o'
        DataBinding.FieldName = 'DTAEMI'
        Width = 95
      end
      object grdjadlogDOCUME: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUME'
      end
      object grdjadlogCLIENT: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENT'
        Width = 424
      end
      object grdjadlogCODSHI: TcxGridDBColumn
        Caption = 'C'#243'd. Rastreio Jadlog'
        DataBinding.FieldName = 'CODSHI'
        Width = 122
      end
      object grdjadlogMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object grdjadlogLevel1: TcxGridLevel
      GridView = grdjadlogDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 16
  end
  object cdsJadlog: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 168
    object cdsJadlogAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsJadlogCODJAD: TStringField
      FieldName = 'CODJAD'
      Size = 13
    end
    object cdsJadlogCODSHI: TStringField
      FieldName = 'CODSHI'
      Size = 14
    end
    object cdsJadlogCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsJadlogNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsJadlogESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsJadlogCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsJadlogDTAEMI: TDateField
      FieldName = 'DTAEMI'
    end
    object cdsJadlogCANCEL: TBooleanField
      FieldName = 'CANCEL'
    end
    object cdsJadlogDOCUME: TStringField
      FieldName = 'DOCUME'
      Size = 19
    end
    object cdsJadlogCLIENT: TStringField
      FieldName = 'CLIENT'
      Size = 60
    end
    object cdsJadlogMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
  end
  object dtsJadlog: TDataSource
    DataSet = cdsJadlog
    Left = 192
    Top = 168
  end
end
