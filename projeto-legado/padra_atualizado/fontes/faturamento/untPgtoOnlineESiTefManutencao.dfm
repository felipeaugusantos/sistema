inherited frmPgtoOnlineESiTefManutencao: TfrmPgtoOnlineESiTefManutencao
  Width = 914
  Height = 559
  Caption = 'Pagamento Online - Manuten'#231#227'o de Transa'#231#245'es'
  Position = poMainFormCenter
  ExplicitWidth = 914
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 472
    Width = 908
    ExplicitTop = 472
    ExplicitWidth = 908
    inherited FlwBotoes: TFlowPanel
      Width = 904
      ExplicitWidth = 904
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 908
    ExplicitTop = 514
    ExplicitWidth = 908
    inherited pnlNomeForm: TPanel
      Left = 737
      ExplicitLeft = 737
    end
    inherited pnlInfo: TPanel
      Width = 737
      ExplicitWidth = 737
    end
  end
  inherited pgcDados: TPageControl
    Top = 432
    Height = 36
    Align = alNone
    Visible = False
    ExplicitTop = 432
    ExplicitHeight = 36
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 4
    end
  end
  object pnlFundo: TPanel [3]
    AlignWithMargins = True
    Left = 3
    Top = 100
    Width = 902
    Height = 369
    Align = alClient
    TabOrder = 4
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 900
      Height = 367
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsTransacoes
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
        OptionsView.Indicator = True
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitel1DBTableViewCitel1CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Width = 52
        end
        object cxGridCitel1DBTableViewCitel1NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'NUMDOC'
        end
        object cxGridCitel1DBTableViewCitel1ESPDOC: TcxGridDBColumn
          Caption = 'ES'
          DataBinding.FieldName = 'ESPDOC'
        end
        object cxGridCitel1DBTableViewCitel1DTACAD: TcxGridDBColumn
          Caption = 'Dta. Cad.'
          DataBinding.FieldName = 'DTACAD'
        end
        object cxGridCitel1DBTableViewCitel1HRACAD: TcxGridDBColumn
          Caption = 'Hra. Cad.'
          DataBinding.FieldName = 'HRACAD'
        end
        object cxGridCitel1DBTableViewCitel1DESC_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'DESC_STATUS'
          Width = 257
        end
        object cxGridCitel1DBTableViewCitel1DESC_TIPTRA: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'DESC_TIPTRA'
        end
        object cxGridCitel1DBTableViewCitel1VALTRA: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALTRA'
        end
        object cxGridCitel1DBTableViewCitel1QTDPAR: TcxGridDBColumn
          Caption = 'Qtd. Parc.'
          DataBinding.FieldName = 'QTDPAR'
          Width = 54
        end
        object cxGridCitel1DBTableViewCitel1NUMCCD: TcxGridDBColumn
          Caption = 'Autoriza'#231#227'o'
          DataBinding.FieldName = 'NUMCCD'
          Width = 133
        end
        object cxGridCitel1DBTableViewCitel1NUMNSU: TcxGridDBColumn
          Caption = 'Num. Nsu'
          DataBinding.FieldName = 'NUMNSU'
          Width = 151
        end
        object cxGridCitel1DBTableViewCitel1DTAPAG: TcxGridDBColumn
          Caption = 'Dta. Pag.'
          DataBinding.FieldName = 'DTAPAG'
        end
        object cxGridCitel1DBTableViewCitel1HRAPAG: TcxGridDBColumn
          Caption = 'Hra. Pag'
          DataBinding.FieldName = 'HRAPAG'
        end
        object cxGridCitel1DBTableViewCitel1CODCLI: TcxGridDBColumn
          Caption = 'Cod. Cli.'
          DataBinding.FieldName = 'CODCLI'
        end
        object cxGridCitel1DBTableViewCitel1NOMCLI: TcxGridDBColumn
          Caption = 'Nome Cliente'
          DataBinding.FieldName = 'NOMCLI'
        end
        object cxGridCitel1DBTableViewCitel1NUMNIT: TcxGridDBColumn
          Caption = 'C'#243'digo da Transa'#231#227'o(NIT)'
          DataBinding.FieldName = 'NUMNIT'
          Width = 336
        end
        object cxGridCitel1DBTableViewCitel1URLPGT: TcxGridDBColumn
          Caption = 'Link de Pagamento'
          DataBinding.FieldName = 'URLPGT'
          Width = 648
        end
        object cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn
          Caption = 'Origem'
          DataBinding.FieldName = 'ORIGEM'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Width = 63
        end
        object cxGridCitel1DBTableViewCitel1DTAEXP: TcxGridDBColumn
          Caption = 'Data Expira'#231#227'o'
          DataBinding.FieldName = 'DTAEXP'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Kind = ckDateTime
          Options.Editing = False
          Width = 165
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitel1DBTableViewCitel1
      end
    end
  end
  object pnlFundoBotoes: TPanel [4]
    AlignWithMargins = True
    Left = 3
    Top = 475
    Width = 902
    Height = 36
    Align = alBottom
    TabOrder = 3
    object lbStatusDesvincular: TLabel
      Left = 8
      Top = 11
      Width = 154
      Height = 19
      Caption = 'lbStatusDesvincular'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnReenviarEmail: TcxButton
      AlignWithMargins = True
      Left = 344
      Top = 4
      Width = 157
      Height = 28
      Align = alRight
      TabOrder = 1
      OnClick = btnReenviarEmailClick
    end
    object btnNovoLink: TcxButton
      AlignWithMargins = True
      Left = 223
      Top = 4
      Width = 115
      Height = 28
      Align = alRight
      Caption = 'F1 - Gerar Novo Link'
      TabOrder = 0
      OnClick = btnNovoLinkClick
      ExplicitLeft = 235
    end
    object btnCancelarPgto: TcxButton
      AlignWithMargins = True
      Left = 507
      Top = 4
      Width = 135
      Height = 28
      Align = alRight
      Caption = 'F3 - Cancelar Pagamento'
      TabOrder = 2
      OnClick = btnCancelarPgtoClick
    end
    object btnDesvincularLink: TcxButton
      AlignWithMargins = True
      Left = 648
      Top = 4
      Width = 150
      Height = 28
      Align = alRight
      Caption = 'F4 - Desvincular Documento'
      TabOrder = 3
      OnClick = btnDesvincularLinkClick
    end
    object btnCopiarLink: TcxButton
      AlignWithMargins = True
      Left = 804
      Top = 4
      Width = 94
      Height = 28
      Align = alRight
      Caption = 'F5 - Copiar Link'
      TabOrder = 4
      OnClick = btnCopiarLinkClick
    end
  end
  object pnlFiltros: TPanel [5]
    Left = 0
    Top = 0
    Width = 908
    Height = 97
    Align = alTop
    TabOrder = 5
    DesignSize = (
      908
      97)
    object Label1: TLabel
      Left = 7
      Top = 12
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 169
      Top = 12
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
    end
    object lblCodEmp: TLabel
      Left = 19
      Top = 39
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label19: TLabel
      Left = 29
      Top = 65
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label4: TLabel
      Left = 258
      Top = 12
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label6: TLabel
      Left = 371
      Top = 12
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 7
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
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
      Left = 214
      Top = 7
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 69
      Top = 34
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 135
      Top = 34
      Width = 600
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
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
      Left = 69
      Top = 60
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
    object edtNomCli: TEditFocus
      Left = 135
      Top = 60
      Width = 600
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnFiltrar: TBitBtnLocked
      Left = 788
      Top = 60
      Width = 101
      Height = 22
      Anchors = [akTop, akRight]
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
      TabOrder = 6
      OnClick = btnFiltrarClick
    end
    object edtDtaDocIni: TMaskEditFocus
      Tag = 99
      Left = 303
      Top = 7
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDtaDocFim: TMaskEditFocus
      Tag = 99
      Left = 382
      Top = 7
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object dsTransacoes: TDataSource
    DataSet = cdsTransacoes
    OnDataChange = dsTransacoesDataChange
    Left = 608
    Top = 280
  end
  object ActionList1: TActionList
    Left = 376
    Top = 240
    object acGerarNovoLink: TAction
      Caption = 'acGerarNovoLink'
      ShortCut = 112
      OnExecute = acGerarNovoLinkExecute
    end
    object acReenciarEmailSms: TAction
      Caption = 'acReenciarEmailSms'
      ShortCut = 113
      OnExecute = acReenciarEmailSmsExecute
    end
    object acCancelarPgto: TAction
      Caption = 'acCancelarPgto'
      ShortCut = 114
      OnExecute = acCancelarPgtoExecute
    end
    object acDesvincularPedido: TAction
      Caption = 'acDesvincularPedido'
      ShortCut = 115
      OnExecute = acDesvincularPedidoExecute
    end
    object acCopiarLink: TAction
      Caption = 'acCopiarLink'
      ShortCut = 116
      OnExecute = acCopiarLinkExecute
    end
  end
  object cdsTransacoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 568
    Top = 280
    object cdsTransacoesURLPGT: TStringField
      FieldName = 'URLPGT'
      Size = 1000
    end
    object cdsTransacoesNUMNIT: TStringField
      FieldName = 'NUMNIT'
      Size = 64
    end
    object cdsTransacoesNUMNSU: TStringField
      FieldName = 'NUMNSU'
      Size = 40
    end
    object cdsTransacoesDTACAD: TDateField
      FieldName = 'DTACAD'
    end
    object cdsTransacoesHRACAD: TTimeField
      FieldName = 'HRACAD'
    end
    object cdsTransacoesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 3
    end
    object cdsTransacoesDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object cdsTransacoesHRAPAG: TTimeField
      FieldName = 'HRAPAG'
    end
    object cdsTransacoesVALTRA: TFloatField
      FieldName = 'VALTRA'
      DisplayFormat = ',#0.00'
      EditFormat = '0.00'
    end
    object cdsTransacoesNUMCCD: TStringField
      FieldName = 'NUMCCD'
      Size = 40
    end
    object cdsTransacoesNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsTransacoesAUTOINCREM_PED: TStringField
      FieldName = 'AUTOINCREM_PED'
    end
    object cdsTransacoesESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsTransacoesCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsTransacoesCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsTransacoesNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsTransacoesDESC_STATUS: TStringField
      FieldName = 'DESC_STATUS'
      Size = 200
    end
    object cdsTransacoesDESC_TIPTRA: TStringField
      FieldName = 'DESC_TIPTRA'
      Size = 10
    end
    object cdsTransacoesTIPTRA: TStringField
      FieldName = 'TIPTRA'
      Size = 1
    end
    object cdsTransacoesQTDPAR: TIntegerField
      FieldName = 'QTDPAR'
    end
    object cdsTransacoesCODOPE: TStringField
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsTransacoesMERCID: TStringField
      FieldName = 'MERCID'
      Size = 72
    end
    object cdsTransacoesTIPREC: TStringField
      FieldName = 'TIPREC'
      Size = 15
    end
    object cdsTransacoesORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 3
    end
    object cdsTransacoesDTAEXP: TDateTimeField
      FieldName = 'DTAEXP'
    end
  end
end
