inherited frmGerAutDespesasFinanceiras: TfrmGerAutDespesasFinanceiras
  Width = 535
  Height = 169
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o automatizada das despesas financeiras '
  Position = poMainFormCenter
  ExplicitWidth = 535
  ExplicitHeight = 169
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 96
    Width = 529
    TabOrder = 2
    ExplicitTop = 96
    ExplicitWidth = 529
    inherited FlwBotoes: TFlowPanel
      Width = 0
      Height = 0
      Align = alNone
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 450
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGerarDespesasFinanceiras: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 212
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Gerar Despesas Financeiras'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFB8824DFFB8824DFFFFFFFFFFB8824DFFB8824DFFFFFF
        FFFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFB8824DFFB8824DFFFFFFFFFFB8824DFFB8824DFFFFFF
        FFFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFFB8824DFFFFFF
        FFFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
        C1FFC1C1C1FFC1C1C1FFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
        C1FFC1C1C1FFC1C1C1FFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 2
      Visible = False
      OnClick = btnGerarDespesasFinanceirasClick
    end
    object btnDesmarca: TBitBtnLocked
      Left = 325
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F8 ] Desmarca Tudo'
      TabOrder = 3
      OnClick = btnDesmarcaClick
    end
    object btnMarca: TBitBtnLocked
      Left = 214
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F9 ] Marca Tudo'
      TabOrder = 4
      OnClick = btnMarcaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 124
    Width = 529
    TabOrder = 3
    ExplicitTop = 124
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 358
      ExplicitLeft = 358
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 529
    Height = 97
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ShowCaption = False
    TabOrder = 0
    object Label2: TLabel
      Left = 13
      Top = 53
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo Pagamentos:'
    end
    object Label4: TLabel
      Left = 215
      Top = 53
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object lblEmpresa: TLabel
      Left = 66
      Top = 24
      Width = 48
      Height = 14
      Caption = 'Empresa.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDataInicial: TcxDateEdit
      Tag = 99
      Left = 120
      Top = 49
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
      Width = 89
    end
    object btnCarregarPagamentos: TBitBtnLocked
      Left = 333
      Top = 49
      Width = 103
      Height = 24
      Align = alCustom
      Caption = '&Carregar'
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
      TabOrder = 4
      OnClick = btnCarregarPagamentosClick
    end
    object edtDataFinal: TcxDateEdit
      Tag = 99
      Left = 227
      Top = 49
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
      TabOrder = 3
      Width = 89
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 120
      Top = 21
      Width = 57
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
      TabOrder = 0
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 178
      Top = 21
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object pnlDados: TPanel [3]
    Left = 0
    Top = 97
    Width = 529
    Height = 0
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object grdLancamentos: TcxGridCitel
      Left = 2
      Top = 2
      Width = 525
      Height = 0
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = grdLancamentosDadosCellDblClick
        OnCustomDrawCell = grdLancamentosDadosCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = grdLancamentosDadosCTP_VALPAG
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = grdLancamentosDadosVALOR_PIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = grdLancamentosDadosVALOR_COFINS
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosCTP_DTAPAG: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CTP_DTAPAG'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 86
        end
        object grdLancamentosDadosCTP_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CTP_CODEMP'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 52
        end
        object grdLancamentosDadosFORNECEDOR: TcxGridDBColumn
          Caption = 'Fornecedor'
          DataBinding.FieldName = 'FORNECEDOR'
          PropertiesClassName = 'TcxTextEditProperties'
          OnGetCellHint = grdLancamentosDadosFORNECEDORGetCellHint
          Width = 200
        end
        object grdLancamentosDadosCTP_CTABAI: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CTP_CTABAI'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 62
        end
        object grdLancamentosDadosCTA_DESCTA: TcxGridDBColumn
          Caption = 'Plano de Contas'
          DataBinding.FieldName = 'CTA_DESCTA'
          PropertiesClassName = 'TcxTextEditProperties'
          OnGetCellHint = grdLancamentosDadosCTA_DESCTAGetCellHint
          Width = 200
        end
        object grdLancamentosDadosCTP_VALPAG: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CTP_VALPAG'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Width = 90
        end
        object grdLancamentosDadosBCCREDITO: TcxGridDBColumn
          Caption = 'C'#243'd. BC. Cr'#233'dito'
          DataBinding.FieldName = 'BCCREDITO'
          PropertiesClassName = 'TcxTextEditProperties'
          OnGetCellHint = grdLancamentosDadosBCCREDITOGetCellHint
          Width = 200
        end
        object grdLancamentosDadosORIGEMCREDITO: TcxGridDBColumn
          Caption = 'Inc. Origem Cr'#233'dito'
          DataBinding.FieldName = 'ORIGEMCREDITO'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 113
        end
        object grdLancamentosDadosCTA_CSTPIS: TcxGridDBColumn
          Caption = 'CST Pis'
          DataBinding.FieldName = 'CTA_CSTPIS'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object grdLancamentosDadosCTA_ALQPIS: TcxGridDBColumn
          Caption = 'Alq. Pis'
          DataBinding.FieldName = 'CTA_ALQPIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00%;-,0.00%'
          Width = 71
        end
        object grdLancamentosDadosVALOR_PIS: TcxGridDBColumn
          Caption = 'Valor Pis'
          DataBinding.FieldName = 'VALOR_PIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Width = 70
        end
        object grdLancamentosDadosCTA_CSTCOF: TcxGridDBColumn
          Caption = 'CST Cofins'
          DataBinding.FieldName = 'CTA_CSTCOF'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 62
        end
        object grdLancamentosDadosCTA_ALQCOF: TcxGridDBColumn
          Caption = 'Aql. Cofins'
          DataBinding.FieldName = 'CTA_ALQCOF'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00%;-,0.00%'
          Width = 71
        end
        object grdLancamentosDadosVALOR_COFINS: TcxGridDBColumn
          Caption = 'Valor Cofins'
          DataBinding.FieldName = 'VALOR_COFINS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Width = 70
        end
        object grdLancamentosDadosCTP_HIST01: TcxGridDBColumn
          Caption = 'Descri'#231#227'o da Opera'#231#227'o'
          DataBinding.FieldName = 'CTP_HIST01'
          PropertiesClassName = 'TcxMemoProperties'
          OnGetCellHint = grdLancamentosDadosCTP_HIST01GetCellHint
          Width = 200
        end
        object grdLancamentosDadosMARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MARDES'
          Visible = False
        end
      end
      object grdLancamentosDadosCta: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'AUTOINCREM_FEC'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'AUTOINCREM_FEC;RCX_SEQCON;RCX_CODOPE;MODALIDADE'
        DataController.MasterKeyFieldNames = 'AUTOINCREM'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosCtaRCX_SEQCON: TcxGridDBColumn
          Caption = 'Seq. Controle'
          DataBinding.FieldName = 'RCX_SEQCON'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 80
        end
        object grdLancamentosDadosCtaMODALIDADE: TcxGridDBColumn
          Caption = 'Modalidade'
          DataBinding.FieldName = 'MODALIDADE'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 75
        end
        object grdLancamentosDadosCtaRCX_CODOPE: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'RCX_CODOPE'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 75
        end
        object grdLancamentosDadosCtaVALOR: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALOR'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 80
        end
        object grdLancamentosDadosCtaDOCUMENTOS: TcxGridDBColumn
          DataBinding.FieldName = 'BOTAO'
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.ShowEditButtons = isebAlways
          Width = 30
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosCtaRCX_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'RCX_STATUS'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 85
        end
        object grdLancamentosDadosCtaACOES: TcxGridDBColumn
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.ShowEditButtons = isebAlways
          Width = 190
        end
        object grdLancamentosDadosCtaVALORSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'VALORSELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosCtaTRF_OPELIB: TcxGridDBColumn
          Caption = 'Status por'
          DataBinding.FieldName = 'TRF_OPELIB'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 160
        end
        object grdLancamentosDadosCtaTRF_DTALIB: TcxGridDBColumn
          Caption = 'Data/Hora Status'
          DataBinding.FieldName = 'TRF_DTALIB'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 110
        end
        object grdLancamentosDadosCtaTRF_MOTIVO: TcxGridDBColumn
          Caption = 'Motivo Recusa'
          DataBinding.FieldName = 'TRF_MOTIVO'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 220
        end
      end
      object grdLancamentosNivel: TcxGridLevel
        GridView = grdLancamentosDados
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 304
  end
end
