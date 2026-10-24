inherited frmFatConsultaDocumentoEntrega: TfrmFatConsultaDocumentoEntrega
  Width = 1014
  Height = 592
  Caption = 'Consulta de Documentos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1014
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 547
    Width = 1008
    ExplicitTop = 547
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
  end
  inherited pnlStatus: TPanel
    Top = 547
    Width = 1008
    ExplicitTop = 547
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  inherited pgcDados: TPageControl
    Width = 1008
    Height = 547
    ExplicitWidth = 1008
    ExplicitHeight = 547
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1000
      ExplicitHeight = 515
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 547
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 1006
      Height = 171
      Align = alTop
      TabOrder = 0
      object lblMotorista: TLabel
        Left = 14
        Top = 9
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motorista:'
      end
      object lblCliente: TLabel
        Left = 26
        Top = 32
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblNumDoc: TLabel
        Left = 4
        Top = 55
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object lblEspDoc: TLabel
        Left = 20
        Top = 78
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Esp'#233'cie:'
      end
      object lblDtaDoc: TLabel
        Left = 8
        Top = 101
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Doc. :'
      end
      object lblDtaSai: TLabel
        Left = 31
        Top = 124
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sa'#237'da:'
      end
      object lblDtaChe: TLabel
        Left = 15
        Top = 147
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chegada:'
      end
      object Label6: TLabel
        Left = 136
        Top = 102
        Width = 9
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = #224
      end
      object Label1: TLabel
        Left = 136
        Top = 125
        Width = 9
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = #224
      end
      object Label2: TLabel
        Left = 136
        Top = 148
        Width = 9
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = #224
      end
      object edtCodMot: TEditFocus
        Tag = 99
        Left = 66
        Top = 6
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodMotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomMot: TEditFocus
        Left = 146
        Top = 6
        Width = 374
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 66
        Top = 29
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 2
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
        Left = 146
        Top = 29
        Width = 374
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 66
        Top = 52
        Width = 125
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 66
        Top = 75
        Width = 31
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
      object mskDtaDocIni: TMaskEditFocus
        Tag = 99
        Left = 66
        Top = 98
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaDocFin: TMaskEditFocus
        Tag = 99
        Left = 151
        Top = 98
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 7
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaSaiIni: TMaskEditFocus
        Tag = 99
        Left = 66
        Top = 121
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 8
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaSaiFin: TMaskEditFocus
        Tag = 99
        Left = 151
        Top = 121
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 9
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaCheIni: TMaskEditFocus
        Tag = 99
        Left = 66
        Top = 144
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 10
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaCheFin: TMaskEditFocus
        Tag = 99
        Left = 151
        Top = 144
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 11
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object btnFiltrar: TBitBtnLocked
        Left = 226
        Top = 144
        Width = 85
        Height = 22
        Caption = '&Consultar'
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
        TabOrder = 12
        OnClick = btnFiltrarClick
      end
    end
    object cxgDocumentos: TcxGridCitel
      Left = 1
      Top = 172
      Width = 1006
      Height = 374
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocumentosDBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDocumentos
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
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgDocumentosDOCUMENTO: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'DOCUMENTO'
          Width = 168
        end
        object cxgDocumentosCLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Width = 480
        end
        object cxgDocumentosENTREGADOR: TcxGridDBColumn
          Caption = 'Entregador'
          DataBinding.FieldName = 'ENTREGADOR'
          Width = 347
        end
        object cxgDocumentosDATAHORADOC: TcxGridDBColumn
          Caption = 'Data Doc.'
          DataBinding.FieldName = 'DATAHORADOC'
          Width = 171
        end
        object cxgDocumentosSAIDA: TcxGridDBColumn
          Caption = 'Sa'#237'da'
          DataBinding.FieldName = 'SAIDA'
          Width = 145
        end
        object cxgDocumentosCHEGADA: TcxGridDBColumn
          Caption = 'Chegada'
          DataBinding.FieldName = 'CHEGADA'
          Width = 157
        end
      end
      object cxgDocumentosLevel1: TcxGridLevel
        GridView = cxgDocumentosDBTableViewCitel1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1080
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1048
    Top = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 976
    Top = 312
  end
  object dtsDocumentos: TDataSource
    Left = 568
    Top = 352
  end
end
