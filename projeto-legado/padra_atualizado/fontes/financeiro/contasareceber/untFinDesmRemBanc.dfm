inherited frmFinDesmRemBanc: TfrmFinDesmRemBanc
  Left = 185
  Top = 150
  Width = 935
  BorderIcons = [biSystemMenu]
  Caption = 'Restaura'#231#227'o de Remessa Banc'#225'ria - Contas a Receber'
  Position = poMainFormCenter
  ExplicitWidth = 935
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 434
    Width = 929
    TabOrder = 5
    ExplicitTop = 434
    ExplicitWidth = 929
    DesignSize = (
      929
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 925
      ExplicitWidth = 925
    end
  end
  inherited pnlStatus: TPanel
    Width = 929
    TabOrder = 3
    ExplicitTop = 460
    ExplicitWidth = 929
    inherited pnlNomeForm: TPanel
      Left = 758
      ExplicitLeft = 758
    end
    inherited pnlInfo: TPanel
      Width = 758
      ExplicitWidth = 758
    end
  end
  inherited pgcDados: TPageControl
    Left = 560
    Top = 109
    Width = 369
    Height = 325
    TabOrder = 1
    TabStop = False
    ExplicitLeft = 560
    ExplicitTop = 109
    ExplicitWidth = 369
    ExplicitHeight = 325
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 361
      ExplicitHeight = 293
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 929
    Height = 109
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 82
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 78
      Top = 85
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 213
      Top = 85
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label4: TLabel
      Left = 83
      Top = 61
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object Label6: TLabel
      Left = 72
      Top = 37
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 119
      Top = 9
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 193
      Top = 9
      Width = 457
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 119
      Top = 57
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodBcoExit
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesBco: TEditFocus
      Left = 193
      Top = 57
      Width = 457
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
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
      Left = 119
      Top = 81
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
      Properties.OnValidate = mskDtaIniPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 223
      Top = 81
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
      Properties.OnValidate = mskDtaIniPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      Width = 90
    end
    object btnConsultar: TBitBtnLocked
      Left = 660
      Top = 81
      Width = 106
      Height = 22
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 7
      OnClick = btnConsultarClick
    end
    object rbtDtaVen: TRadioButton
      Left = 422
      Top = 85
      Width = 123
      Height = 17
      Caption = 'Data de Vencimento'
      TabOrder = 6
    end
    object rbtDtaEnv: TRadioButton
      Left = 325
      Top = 85
      Width = 92
      Height = 17
      Caption = 'Data de Envio'
      Checked = True
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 5
      TabStop = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 119
      Top = 33
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 193
      Top = 33
      Width = 457
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rbtDtaCad: TRadioButton
      Left = 550
      Top = 85
      Width = 107
      Height = 17
      Caption = 'Data de Cadastro'
      TabOrder = 11
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 434
    Width = 929
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 2
    object FlwpnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 736
      Height = 22
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object BtnMarcarTodas2: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 0
        OnClick = BtnMarcarTodas2Click
      end
      object btnDesmarca: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 1
        OnClick = btnDesmarcaClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
    end
    object btnSairAgrup: TBitBtnLocked
      Left = 802
      Top = 2
      Width = 125
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAgrupClick
    end
  end
  object pnlAux2: TPanel [5]
    Left = 0
    Top = 109
    Width = 560
    Height = 325
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object pnlTotais: TPanel
      Left = 0
      Top = 270
      Width = 560
      Height = 55
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label21: TLabel
        Left = 36
        Top = 9
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total duplicatas:'
      end
      object Label9: TLabel
        Left = 26
        Top = 32
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Selecionado:'
      end
      object edtTotalDup: TEditFocus
        Left = 115
        Top = 5
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotalSelecionado: TEditFocus
        Left = 115
        Top = 28
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    end
    object dbgDuplicatas: TcxGrid
      Left = 0
      Top = 0
      Width = 560
      Height = 270
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = dbgDuplicatasDBTableView1CellDblClick
        OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
        DataController.DataSource = dtsCtaRec
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object colNumDup: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'CTR_NUMDUP'
          Width = 137
        end
        object colEspDoc: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'CTR_ESPDOC'
          Width = 56
        end
        object colCodEmp: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CTR_CODEMP'
          Width = 60
        end
        object colDtaCad: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'CTR_DTACAD'
          Width = 85
        end
        object colDtaVen: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTR_DTAVEN'
          Width = 81
        end
        object colValDup: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CTR_VALDUP'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 97
        end
        object dbgDuplicatasCTR_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MARDES'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasDBTableView1
      end
    end
  end
  object pnlAux1: TPanel [6]
    Left = 560
    Top = 109
    Width = 369
    Height = 325
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 369
      Height = 325
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label5: TLabel
        Left = 24
        Top = 23
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Nome: TLabel
        Left = 29
        Top = 46
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label7: TLabel
        Left = 15
        Top = 69
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label10: TLabel
        Left = 29
        Top = 92
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label12: TLabel
        Left = 5
        Top = 115
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nosso Nro:'
      end
      object Label14: TLabel
        Left = 14
        Top = 149
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object edtCodCliBai: TEditFocus
        Left = 63
        Top = 19
        Width = 290
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomCliBai: TEditFocus
        Left = 63
        Top = 42
        Width = 290
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtNomPorBai: TEditFocus
        Left = 63
        Top = 88
        Width = 290
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodPorBai: TEditFocus
        Left = 63
        Top = 65
        Width = 290
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
      object edtNosNum: TEditFocus
        Left = 63
        Top = 111
        Width = 290
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gpbDadEnv: TGroupBox
        Left = 8
        Top = 200
        Width = 345
        Height = 105
        Caption = 'Dados do Envio'
        TabOrder = 5
        object Label8: TLabel
          Left = 26
          Top = 39
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data:'
        end
        object Label11: TLabel
          Left = 17
          Top = 62
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Banco:'
        end
        object edtDtaEnv: TEditFocus
          Left = 55
          Top = 35
          Width = 282
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBcoEnv: TEditFocus
          Left = 55
          Top = 58
          Width = 282
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
      end
      object edtHistor: TMemoFocus
        Left = 63
        Top = 134
        Width = 290
        Height = 45
        TabStop = False
        Color = 16768952
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 864
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 16
  end
  object dtsCtaRec: TDataSource
    AutoEdit = False
    Left = 432
    Top = 392
  end
end
