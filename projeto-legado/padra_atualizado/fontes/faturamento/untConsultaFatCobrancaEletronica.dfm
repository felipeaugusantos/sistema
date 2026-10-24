inherited frmConsultaFatCobrancaEletronica: TfrmConsultaFatCobrancaEletronica
  Width = 1035
  Height = 568
  Caption = 'Cobran'#231'as Eletr'#244'nicas'
  Position = poScreenCenter
  ExplicitWidth = 1035
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 495
    Width = 1029
    ExplicitTop = 495
    ExplicitWidth = 1029
    inherited FlwBotoes: TFlowPanel
      Width = 1025
      ExplicitWidth = 1025
      object btnCopiarLinkPagamento: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 21
        Caption = '[F4] Copiar Link Pagto'
        TabOrder = 0
        OnClick = btnCopiarLinkPagamentoClick
      end
      object btnDispararMensagem: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 21
        Caption = '[F12] Disparar Mensagem'
        TabOrder = 1
        OnClick = btnDispararMensagemClick
      end
      object btnLiberarRegistro: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 150
        Height = 21
        Caption = '[F5] Liberar Registro'
        TabOrder = 2
        OnClick = btnLiberarRegistroClick
      end
      object btnCriarNovoLink: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 150
        Height = 21
        Caption = '[F6] Criar Novo Link'
        TabOrder = 3
        OnClick = btnCriarNovoLinkClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 949
      ExplicitLeft = 949
    end
  end
  inherited pnlStatus: TPanel
    Top = 523
    Width = 1029
    ExplicitTop = 523
    ExplicitWidth = 1029
    inherited pnlNomeForm: TPanel
      Left = 858
      ExplicitLeft = 858
    end
    inherited pnlInfo: TPanel
      Width = 858
      Alignment = taLeftJustify
      Caption = 
        ' [ENTER] - Mostra dados inconsistentes retornados na comunica'#231#227'o' +
        ' com a API'
      ExplicitWidth = 858
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1029
    Height = 103
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblPeriodo: TLabel
      Left = 8
      Top = 9
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Cobran'#231'a:'
    end
    object Label3: TLabel
      Left = 182
      Top = 9
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblEmpresa: TLabel
      Left = 38
      Top = 55
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblVendedor: TLabel
      Left = 33
      Top = 32
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object shaVendedor: TShape
      Left = 89
      Top = 29
      Width = 6
      Height = 22
    end
    object shaEmpresa: TShape
      Left = 89
      Top = 52
      Width = 6
      Height = 22
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 89
      Top = 4
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
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 193
      Top = 4
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
      Width = 90
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 96
      Top = 52
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
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
      Left = 157
      Top = 52
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnCarregarPedidos: TBitBtnLocked
      Left = 373
      Top = 77
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
      TabOrder = 5
      OnClick = btnCarregarPedidosClick
    end
    object edtCodigoVendedor: TEditFocus
      Tag = 99
      Left = 96
      Top = 29
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
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
      Left = 157
      Top = 29
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object grbLegenda: TGroupBox
      Left = 524
      Top = 0
      Width = 498
      Height = 99
      Caption = ' Legendas '
      TabOrder = 7
      object Label1: TLabel
        Left = 212
        Top = 21
        Width = 58
        Height = 14
        Caption = 'Link Gerado'
      end
      object Label2: TLabel
        Left = 212
        Top = 46
        Width = 60
        Height = 14
        Caption = 'Link Enviado'
      end
      object Label4: TLabel
        Left = 212
        Top = 71
        Width = 86
        Height = 14
        Caption = 'Pedido Cancelado'
      end
      object Label5: TLabel
        Left = 367
        Top = 21
        Width = 128
        Height = 14
        Caption = 'Transa'#231#227'o com Pend'#234'ncia'
      end
      object Label6: TLabel
        Left = 367
        Top = 46
        Width = 99
        Height = 14
        Caption = 'Pagamento Efetuado'
      end
      object Label7: TLabel
        Left = 367
        Top = 71
        Width = 64
        Height = 14
        Caption = 'Link Expirado'
      end
      object shpLegGerado: TShape
        Left = 188
        Top = 19
        Width = 18
        Height = 18
        Brush.Color = clBlue
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegCancelado: TShape
        Left = 188
        Top = 69
        Width = 18
        Height = 18
        Brush.Color = clRed
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegEnviado: TShape
        Left = 188
        Top = 44
        Width = 18
        Height = 18
        Brush.Color = clOlive
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegFormaPagamento: TShape
        Left = 343
        Top = 19
        Width = 18
        Height = 18
        Brush.Color = 36095
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegPago: TShape
        Left = 343
        Top = 44
        Width = 18
        Height = 18
        Brush.Color = clGreen
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegExpirado: TShape
        Left = 343
        Top = 69
        Width = 18
        Height = 18
        Brush.Color = clMaroon
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegAguardandoLink: TShape
        Left = 12
        Top = 19
        Width = 18
        Height = 18
        Brush.Color = clBlack
        Pen.Color = -1
        Pen.Style = psClear
      end
      object shpLegAguardandoLiberacaoComercial: TShape
        Left = 12
        Top = 44
        Width = 18
        Height = 18
        Brush.Color = clPurple
        Pen.Color = -1
        Pen.Style = psClear
      end
      object Label8: TLabel
        Left = 36
        Top = 21
        Width = 142
        Height = 14
        Caption = 'Aguardando Gera'#231#227'o de Link'
      end
      object Label9: TLabel
        Left = 36
        Top = 46
        Width = 130
        Height = 14
        Caption = 'Aguardando Lib. Comercial'
      end
      object shpLegDadosIncosistentes: TShape
        Left = 12
        Top = 69
        Width = 18
        Height = 18
        Brush.Color = clFuchsia
        Pen.Color = -1
        Pen.Style = psClear
      end
      object Label10: TLabel
        Left = 36
        Top = 71
        Width = 104
        Height = 14
        Caption = 'Dados Inconsistentes'
      end
    end
  end
  object grdLancamentos: TcxGridCitel [3]
    Left = 0
    Top = 103
    Width = 1029
    Height = 392
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdLancamentosDados: TcxGridDBTableViewCitel
      OnDblClick = grdLancamentosDadosDblClick
      OnKeyPress = grdLancamentosDadosKeyPress
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
      object grdLancamentosDadosNUMDOC: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'NUMDOC'
        Width = 114
      end
      object grdLancamentosDadosESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
        Width = 46
      end
      object grdLancamentosDadosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Width = 55
      end
      object grdLancamentosDadosDTAENT: TcxGridDBColumn
        Caption = 'Data Documento'
        DataBinding.FieldName = 'DTAENT'
        Width = 89
      end
      object grdLancamentosDadosNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 284
      end
      object grdLancamentosDadosCELULA: TcxGridDBColumn
        Caption = 'Celular'
        DataBinding.FieldName = 'CELULA'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = '!\(99\)00000-0000;1;_'
        Width = 90
      end
      object grdLancamentosDadosEMAIL_: TcxGridDBColumn
        Caption = 'Email'
        DataBinding.FieldName = 'EMAIL_'
        Width = 180
      end
      object grdLancamentosDadosVLRCON: TcxGridDBColumn
        Caption = 'Valor Documento'
        DataBinding.FieldName = 'VLRCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 93
      end
      object grdLancamentosDadosVENDED: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDED'
        Width = 157
      end
      object grdLancamentosDadosLNKPAG: TcxGridDBColumn
        Caption = 'Link Pagamento'
        DataBinding.FieldName = 'LNKPAG'
        Width = 276
      end
      object grdLancamentosDadosEMLENV: TcxGridDBColumn
        Caption = 'Env. Email'
        DataBinding.FieldName = 'EMLENV'
        MinWidth = 60
      end
      object grdLancamentosDadosSMSENV: TcxGridDBColumn
        Caption = 'Env. SMS'
        DataBinding.FieldName = 'SMSENV'
        MinWidth = 60
        Width = 64
      end
      object grdLancamentosDadosWPPENV: TcxGridDBColumn
        Caption = 'Env. Whats'
        DataBinding.FieldName = 'WPPENV'
        MinWidth = 60
        Width = 64
      end
      object grdLancamentosDadosSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
      end
      object grdLancamentosDadosSTATRA: TcxGridDBColumn
        Caption = 'Status Transa'#231#227'o API Cobran'#231'a'
        DataBinding.FieldName = 'STATRA'
        OnGetDisplayText = grdLancamentosDadosSTATRAGetDisplayText
        Width = 300
      end
      object grdLancamentosDadosMSGRET: TcxGridDBColumn
        Caption = 'Mensagem Retorno'
        DataBinding.FieldName = 'MSGRET'
        Width = 450
      end
      object grdLancamentosDadosTIPREC: TcxGridDBColumn
        DataBinding.FieldName = 'TIPREC'
        Visible = False
      end
      object grdLancamentosDadosCODSTA: TcxGridDBColumn
        DataBinding.FieldName = 'CODSTA'
        Visible = False
      end
      object grdLancamentosDadosLIBCOM: TcxGridDBColumn
        DataBinding.FieldName = 'LIBCOM'
        Visible = False
      end
    end
    object grdLancamentosNivel: TcxGridLevel
      GridView = grdLancamentosDados
    end
  end
  object pnlHabilitaDisparoMensagem: TPanel [4]
    Left = 8
    Top = 360
    Width = 171
    Height = 89
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 4
    DesignSize = (
      171
      89)
    object btnConfirmaDisparoMensagem: TBitBtnLocked
      Left = 96
      Top = 63
      Width = 64
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmaDisparoMensagemClick
    end
    object chkDisparaEmail: TCheckBox
      Left = 6
      Top = 6
      Width = 159
      Height = 17
      Align = alTop
      Caption = 'Disparar E-mail'
      TabOrder = 1
    end
    object chkDisparaSms: TCheckBox
      Left = 6
      Top = 23
      Width = 159
      Height = 17
      Align = alTop
      Caption = 'Disparar SMS'
      TabOrder = 2
    end
    object chkDisparaWhatsapp: TCheckBox
      Left = 6
      Top = 40
      Width = 159
      Height = 17
      Align = alTop
      Caption = 'Disparar Whatsapp'
      TabOrder = 3
    end
    object btnCancelaDisparoMensagem: TBitBtnLocked
      Left = 6
      Top = 63
      Width = 64
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = btnCancelaDisparoMensagemClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 80
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 256
  end
end
