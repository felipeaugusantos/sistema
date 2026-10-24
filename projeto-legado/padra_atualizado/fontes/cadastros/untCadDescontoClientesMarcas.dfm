inherited frmCadDescontoClientesMarcas: TfrmCadDescontoClientesMarcas
  Width = 600
  Height = 501
  Caption = 'Cadastro de Desconto Clientes / Marcas'
  ExplicitWidth = 600
  ExplicitHeight = 501
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 132
    Width = 584
    TabOrder = 3
    ExplicitTop = 132
    ExplicitWidth = 584
    inherited FlwBotoes: TFlowPanel
      Width = 49
      ExplicitWidth = 49
      inherited btnPesquisar: TBitBtnLocked
        Left = 0
        Top = 24
        ExplicitLeft = 0
        ExplicitTop = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 498
      ExplicitLeft = 498
    end
    inherited btnCancela: TBitBtnLocked
      Left = 359
      ExplicitLeft = 359
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 270
      ExplicitLeft = 270
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 180
      ExplicitLeft = 180
    end
    inherited btnGravar: TBitBtnLocked
      Left = 91
      ExplicitLeft = 91
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 584
    TabOrder = 8
    ExplicitTop = 446
    ExplicitWidth = 584
    inherited pnlNomeForm: TPanel
      Left = 413
      ExplicitLeft = 413
    end
    inherited pnlInfo: TPanel
      Width = 413
      ExplicitWidth = 413
    end
  end
  inherited pnlHeader: TPanel
    Top = 36
    Width = 584
    Height = 56
    TabOrder = 1
    ExplicitTop = 36
    ExplicitWidth = 584
    ExplicitHeight = 56
    inherited lblInf: TLabel
      Left = 750
      ExplicitLeft = 750
    end
    object lblMarca: TLabel [1]
      Left = 25
      Top = 7
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label2: TLabel [2]
      Left = 9
      Top = 34
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    inherited pgcDados: TPageControl
      Left = 750
      ExplicitLeft = 750
    end
    object dbeDesMar: TDBEditFocus
      Left = 125
      Top = 4
      Width = 451
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'MAR_DESMAR'
      DataSource = dtsConsulta
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 60
      Top = 4
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MDS_CODMAR'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnKeyPress = dbeCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbePerdes: TDBEditFocus
      Tag = 99
      Left = 60
      Top = 31
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MDS_PERDES'
      DataSource = dtsConsulta
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 403
    Width = 584
    Height = 17
    Caption = 'Pressione DELETE para excluir um registro do grid'
    TabOrder = 6
    Visible = True
    ExplicitTop = 403
    ExplicitWidth = 584
    ExplicitHeight = 17
  end
  inherited dbgConsulta: TDBGridCitel
    Left = 1
    Top = 166
    Align = alNone
    TabOrder = 5
    Visible = False
  end
  inherited pnlPesquisa: TPanel
    Top = 92
    Width = 584
    TabOrder = 2
    ExplicitTop = 92
    ExplicitWidth = 584
    inherited edtString: TEditFocus
      Left = 303
      Width = 273
      ExplicitLeft = 303
      ExplicitWidth = 273
    end
    inherited edtValor: TEditFocus
      Left = 499
      ExplicitLeft = 499
    end
  end
  inherited pnlInfBotoes: TPanel
    Top = 420
    Width = 584
    TabOrder = 7
    Visible = False
    ExplicitTop = 420
    ExplicitWidth = 584
    inherited Label1: TLabel
      Width = 580
      Height = 22
    end
  end
  object pnlCliente: TPanel [7]
    Left = 0
    Top = 0
    Width = 584
    Height = 36
    Align = alTop
    TabOrder = 0
    DesignSize = (
      584
      36)
    object lblCliente: TLabel
      Left = 23
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 60
      Top = 10
      Width = 65
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
      Left = 125
      Top = 10
      Width = 367
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
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
    object btnPesquisaDesc: TBitBtnLocked
      Left = 498
      Top = 9
      Width = 78
      Height = 24
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnPesquisaDescClick
    end
  end
  object cxgDescon: TcxGridCitel [8]
    Left = 0
    Top = 160
    Width = 584
    Height = 243
    Align = alClient
    TabOrder = 4
    object cxgDesconTBV: TcxGridDBTableViewCitel
      OnKeyDown = cxgDesconTBVKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgDesconTBVCellDblClick
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDesconTBVCodMar: TcxGridDBColumn
        DataBinding.FieldName = 'MDS_CODMAR'
        Width = 74
      end
      object cxgDesconTBVDesMar: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Width = 405
      end
      object cxgDesconTBVDecon: TcxGridDBColumn
        DataBinding.FieldName = 'MDS_PERDES'
        Width = 86
      end
    end
    object cxgDesconLevel1: TcxGridLevel
      GridView = cxgDesconTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 200
  end
  inherited qryConsulta: TUniQuery
    Left = 128
    Top = 256
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Left = 80
    Top = 256
  end
  inherited cdsConsulta: TUniClientDataSet
    OnReconcileError = cdsConsultaReconcileError
    Left = 176
    Top = 256
    object cdsConsultaMAR_DESMAR: TStringField
      DisplayLabel = 'Marca'
      FieldName = 'MAR_DESMAR'
      ProviderFlags = []
      Size = 30
    end
    object cdsConsultaAUTOINCREM: TStringField
      DisplayLabel = 'AutoIncremento'
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaMDS_CODMAR: TStringField
      DisplayLabel = 'C'#243'd. Marca'
      FieldName = 'MDS_CODMAR'
      Size = 6
    end
    object cdsConsultaMDS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'MDS_CODEMP'
      Size = 3
    end
    object cdsConsultaMDS_CODCLI: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'MDS_CODCLI'
      Size = 8
    end
    object cdsConsultaMDS_PERDES: TFloatField
      DisplayLabel = '(%) Desconto'
      FieldName = 'MDS_PERDES'
      EditFormat = '#,##0.00'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 272
    Top = 256
  end
end
