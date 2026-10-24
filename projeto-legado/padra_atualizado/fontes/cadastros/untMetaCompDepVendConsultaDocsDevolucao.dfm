inherited frmMetaCompDepVendConsultaDocsDevolucao: TfrmMetaCompDepVendConsultaDocsDevolucao
  Width = 762
  Height = 590
  Caption = 'Consulta Documentos de Devolu'#231#227'o'
  ExplicitWidth = 762
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 756
    TabOrder = 1
    ExplicitTop = 519
    ExplicitWidth = 756
    inherited FlwBotoes: TFlowPanel
      Width = 752
      ExplicitWidth = 752
    end
    inherited btnSair: TBitBtnLocked
      Left = 673
      ExplicitLeft = 673
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 756
    TabOrder = 2
    ExplicitTop = 545
    ExplicitWidth = 756
    inherited pnlNomeForm: TPanel
      Left = 585
      ExplicitLeft = 585
    end
    inherited pnlInfo: TPanel
      Width = 585
      ExplicitWidth = 585
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 756
    Height = 121
    Align = alTop
    TabOrder = 0
    object Label19: TLabel
      Left = 30
      Top = 53
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblCodEmp: TLabel
      Left = 20
      Top = 76
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 24
      Top = 31
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label6: TLabel
      Left = 140
      Top = 31
      Width = 8
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'a'
    end
    object Label1: TLabel
      Left = 6
      Top = 7
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 70
      Top = 50
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 136
      Top = 50
      Width = 611
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 70
      Top = 73
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnExit = edtCodEmpExit
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
      Left = 136
      Top = 73
      Width = 611
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 70
      Top = 27
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 155
      Top = 27
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 70
      Top = 4
      Width = 150
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
    object btnFiltrar: TBitBtnLocked
      Left = 663
      Top = 95
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
      TabOrder = 7
      OnClick = btnFiltrarClick
    end
  end
  object grdDocsDev: TcxGridCitel [3]
    Left = 0
    Top = 121
    Width = 756
    Height = 398
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDocsDevTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsMT2DocsDev
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDocsDevTvSELECIONADO: TcxGridDBColumn
        Caption = 'Selecionado'
        DataBinding.FieldName = 'SELECIONADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Width = 70
      end
      object grdDocsDevTvDOCUME: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DEV_DOCUME'
        Width = 120
      end
      object grdDocsDevTvCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'DEV_CODEMP'
        Width = 50
      end
      object grdDocsDevTvCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'DEV_CLIENTE'
        Width = 280
      end
      object grdDocsDevTvDTAEMI: TcxGridDBColumn
        Caption = 'Data Emiss'#227'o'
        DataBinding.FieldName = 'DEV_DTAEMI'
        Width = 80
      end
      object grdDocsDevTvVALDOC: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'DEV_VALDOC'
        Width = 100
      end
    end
    object grdDocsDevLvl: TcxGridLevel
      GridView = grdDocsDevTv
    end
  end
  object cdsDocsDev: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 204
    object cdsDocsDevSELECIONADO: TBooleanField
      FieldName = 'SELECIONADO'
    end
    object cdsDocsDevDEV_NUMDOC: TStringField
      FieldName = 'DEV_NUMDOC'
      Size = 12
    end
    object cdsDocsDevDEV_ESPDOC: TStringField
      FieldName = 'DEV_ESPDOC'
      Size = 2
    end
    object cdsDocsDevDEV_CODEMP: TStringField
      FieldName = 'DEV_CODEMP'
      Size = 3
    end
    object cdsDocsDevDEV_DOCUME: TStringField
      FieldName = 'DEV_DOCUME'
    end
    object cdsDocsDevDEV_CLIENTE: TStringField
      FieldName = 'DEV_CLIENTE'
      Size = 70
    end
    object cdsDocsDevDEV_DTAEMI: TDateField
      FieldName = 'DEV_DTAEMI'
    end
    object cdsDocsDevDEV_VALDOC: TFloatField
      FieldName = 'DEV_VALDOC'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT2DocsDev: TDataSource
    DataSet = cdsDocsDev
    Left = 467
    Top = 204
  end
end
