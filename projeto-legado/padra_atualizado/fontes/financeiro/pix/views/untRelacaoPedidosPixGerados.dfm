inherited frmRelacaoPedidosPixGerados: TfrmRelacaoPedidosPixGerados
  Width = 1253
  Height = 634
  Caption = 'Rela'#231#227'o de Documentos com Pix Gerados'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1253
  ExplicitHeight = 634
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 561
    Width = 1247
    Anchors = [akRight, akBottom]
    ExplicitTop = 561
    ExplicitWidth = 1247
    inherited FlwBotoes: TFlowPanel
      Width = 1166
      ExplicitWidth = 1166
      object btnRemoverPix: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 127
        Height = 21
        Caption = '[F3] Remover Pix'
        TabOrder = 0
        OnClick = btnRemoverPixClick
      end
      object btnCopiarQRCode: TBitBtnLocked
        Left = 127
        Top = 0
        Width = 127
        Height = 21
        Caption = '[F4] Copiar QRCode Pix'
        TabOrder = 1
        OnClick = btnCopiarQRCodeClick
      end
      object btnReenviarEmail: TBitBtnLocked
        Left = 254
        Top = 0
        Width = 127
        Height = 21
        Caption = '[F12] Reenviar E-mail'
        TabOrder = 2
        OnClick = btnReenviarEmailClick
      end
      object btnRelatorioLOGMPX: TBitBtnLocked
        Left = 381
        Top = 0
        Width = 127
        Height = 21
        Caption = '[Ctrl+H] Hist'#243'rico Pix'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnRelatorioLOGMPXClick
      end
      object btnReceberPix: TBitBtnLocked
        Left = 508
        Top = 0
        Width = 127
        Height = 21
        Caption = '[ENTER] Recebimento Pix'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnReceberPixClick
      end
      object btnGerarCreditoCliente: TBitBtnLocked
        Left = 635
        Top = 0
        Width = 142
        Height = 21
        Caption = '[F11] Gerar Cr'#233'dito Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnGerarCreditoClienteClick
      end
      object btnGerarCCPixRecebido: TBitBtnLocked
        Left = 777
        Top = 0
        Width = 190
        Height = 21
        Caption = '[CTRL+F12] Gerar CC Pix Recebido'
        TabOrder = 5
        Visible = False
        OnClick = btnGerarCCPixRecebidoClick
      end
      object btnConPagPix: TBitBtnLocked
        Left = 967
        Top = 0
        Width = 154
        Height = 21
        Caption = '[F6] Consulta Pagamento Pix'
        TabOrder = 7
        OnClick = btnConPagPixClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1168
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 1168
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 589
    Width = 1247
    ExplicitTop = 589
    ExplicitWidth = 1247
    inherited pnlNomeForm: TPanel
      Left = 1076
      ExplicitLeft = 1076
    end
    inherited pnlInfo: TPanel
      Width = 1076
      ExplicitWidth = 1076
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1247
    Height = 137
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblStatus: TLabel
      Left = 29
      Top = 17
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object lblPeriodoPix: TLabel
      Left = 6
      Top = 42
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do Pix:'
    end
    object Label3: TLabel
      Left = 162
      Top = 42
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblGeradoPor: TLabel
      Left = 275
      Top = 17
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Gerado por:'
    end
    object lblVendedor: TLabel
      Left = 13
      Top = 65
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object shaVendedor: TShape
      Left = 69
      Top = 62
      Width = 6
      Height = 22
    end
    object cmbStatus: TComboBoxFocus
      Left = 69
      Top = 14
      Width = 194
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Ativos'
      Items.Strings = (
        'Ativos'
        'Pagos'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 69
      Top = 37
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
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 173
      Top = 37
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
      Width = 90
    end
    object cmbGeradoPelo: TComboBoxFocus
      Left = 339
      Top = 14
      Width = 159
      Height = 22
      Style = csDropDownList
      ItemIndex = 4
      TabOrder = 1
      Text = 'Todos'
      Items.Strings = (
        'Caixa'
        'Faturamento'
        'Financeiro'
        'Pedido'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodigoVendedor: TEditFocus
      Tag = 99
      Left = 76
      Top = 62
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodigoVendedorExit
      OnKeyPress = edtCodigoVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomeVendedor: TEditFocus
      Left = 137
      Top = 62
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlVendedor2: TPanel
      Left = 0
      Top = 84
      Width = 510
      Height = 24
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 6
      object lblVendedor2: TLabel
        Left = 4
        Top = 4
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor 2:'
      end
      object shaVendedor2: TShape
        Left = 69
        Top = 1
        Width = 6
        Height = 22
      end
      object edtCodigoVendedor2: TEditFocus
        Tag = 99
        Left = 76
        Top = 1
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodigoVendedor2Exit
        OnKeyPress = edtCodigoVendedor2KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomeVendedor2: TEditFocus
        Left = 137
        Top = 1
        Width = 361
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object pnlEmpresa: TPanel
      Left = 0
      Top = 107
      Width = 697
      Height = 24
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 7
      object lblEmpresa: TLabel
        Left = 18
        Top = 4
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object shaEmpresa: TShape
        Left = 69
        Top = 1
        Width = 6
        Height = 22
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 76
        Top = 1
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
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
      object edtDesEmp: TEditFocus
        Left = 137
        Top = 1
        Width = 361
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object btnCarregarPedidos: TBitBtnLocked
        Left = 514
        Top = 1
        Width = 145
        Height = 22
        Align = alCustom
        Caption = '&Carregar Documentos'
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
        TabOrder = 2
        OnClick = btnCarregarPedidosClick
      end
    end
  end
  object pnlGrid: TPanel [3]
    Left = 0
    Top = 137
    Width = 1247
    Height = 368
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object grdLancamentos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1245
      Height = 366
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDados: TcxGridDBTableViewCitel
        OnKeyDown = grdLancamentosDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
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
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosFGO_NUMDOC: TcxGridDBColumn
          Caption = 'N'#250'mero'
          DataBinding.FieldName = 'FGO_NUMDOC'
          Width = 144
        end
        object grdLancamentosDadosFGO_ESPDOC: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'FGO_ESPDOC'
          Width = 46
        end
        object grdLancamentosDadosFGO_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'FGO_CODEMP'
          Width = 55
        end
        object grdLancamentosDadosFGO_DTAENT: TcxGridDBColumn
          Caption = 'Data Documento'
          DataBinding.FieldName = 'FGO_DTAENT'
          Width = 89
        end
        object grdLancamentosDadosCLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Width = 284
        end
        object grdLancamentosDadosFONE01: TcxGridDBColumn
          Caption = 'Telefone'
          DataBinding.FieldName = 'FONE01'
          PropertiesClassName = 'TcxMaskEditProperties'
          Properties.EditMask = '!\(99\)00000-0000;1;_'
          Width = 90
        end
        object grdLancamentosDadosEMAIL1: TcxGridDBColumn
          Caption = 'Email'
          DataBinding.FieldName = 'EMAIL1'
          Width = 180
        end
        object grdLancamentosDadosFGO_VLRCON: TcxGridDBColumn
          Caption = 'Valor Documento'
          DataBinding.FieldName = 'FGO_VLRCON'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 93
        end
        object grdLancamentosDadosMPX_STATUS: TcxGridDBColumn
          Caption = 'Status Pix'
          DataBinding.FieldName = 'MPX_STATUS'
          Width = 77
        end
        object grdLancamentosDadosMPX_CODEMP: TcxGridDBColumn
          Caption = 'Empresa Pix'
          DataBinding.FieldName = 'MPX_CODEMP'
          Width = 68
        end
        object grdLancamentosDadosMPX_VALPIX: TcxGridDBColumn
          Caption = 'Valor do Pix'
          DataBinding.FieldName = 'MPX_VALPIX'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 80
        end
        object grdLancamentosDadosMPX_CRIADO: TcxGridDBColumn
          Caption = 'Gerado por'
          DataBinding.FieldName = 'MPX_CRIADO'
          Width = 89
        end
        object grdLancamentosDadosVENDEDOR: TcxGridDBColumn
          Caption = 'Vendedor'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 157
        end
        object grdLancamentosDadosMPX_QRCODE: TcxGridDBColumn
          Caption = 'C'#243'digo QRCode'
          DataBinding.FieldName = 'MPX_QRCODE'
          Width = 256
        end
      end
      object grdLancamentosNivel: TcxGridLevel
        GridView = grdLancamentosDados
      end
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 505
    Width = 1247
    Height = 56
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object gpbLegenda: TGroupBox
      Left = 2
      Top = 2
      Width = 176
      Height = 52
      Align = alLeft
      Caption = 'Legenda'
      TabOrder = 0
      object shpLegendaPagos: TShape
        Left = 8
        Top = 16
        Width = 14
        Height = 14
      end
      object lblLegendaPagos: TLabel
        Left = 27
        Top = 16
        Width = 127
        Height = 14
        Caption = 'Documentos com Pix pago'
      end
      object lblLegendaPagosA: TLabel
        Left = 11
        Top = 16
        Width = 8
        Height = 14
        Caption = 'A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lblLegendaAtivos: TLabel
        Left = 27
        Top = 32
        Width = 126
        Height = 14
        Caption = 'Documentos com Pix ativo'
      end
      object shpLegendaAtivos: TShape
        Left = 8
        Top = 32
        Width = 14
        Height = 14
      end
      object lblLegendaAtivosA: TLabel
        Left = 11
        Top = 32
        Width = 8
        Height = 14
        Caption = 'A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
    end
    object pnlRodapeTotais: TPanel
      Left = 1013
      Top = 2
      Width = 232
      Height = 52
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        232
        52)
      object lblTotal: TLabel
        Left = 3
        Top = 26
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total de Pix*:'
      end
      object lblQuantidadeTotal: TLabel
        Left = 88
        Top = 9
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Quantidade '
      end
      object lblValorTotal: TLabel
        Left = 203
        Top = 9
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor'
      end
      object edtQtdLancamentos: TEditFocus
        Left = 66
        Top = 23
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
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
      object edtValorLancamentos: TEditFocus
        Left = 148
        Top = 23
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
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
    object pnlAvisos: TPanel
      Left = 210
      Top = 12
      Width = 617
      Height = 26
      BevelInner = bvLowered
      BevelOuter = bvSpace
      BorderStyle = bsSingle
      Caption = 
        'ATEN'#199#195'O: Algumas cobran'#231'as Pix geradas e n'#227'o confirmadas foram r' +
        'ecebidas. Acesse CTRL+F12 para confirmar.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 296
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 320
  end
end
