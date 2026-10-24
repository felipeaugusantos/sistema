inherited frmTranferenciaPedidoMultiLoja: TfrmTranferenciaPedidoMultiLoja
  Width = 1024
  Height = 768
  Caption = 'Gerar Transfer'#234'ncias ap'#243's Entrada Mercadoria(Pedidos Multi Loja)'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object lblPedidosCompra: TLabel [0]
    Left = 0
    Top = 105
    Width = 1018
    Height = 14
    Align = alTop
    Caption = 'Pedidos de Compra:'
    Visible = False
    ExplicitWidth = 96
  end
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnConfirma: TSpeedButton
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirma'
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 888
      Width = 124
      Caption = '[ Esc ] - Cancela'
      ExplicitLeft = 888
      ExplicitWidth = 124
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 105
    Align = alTop
    ParentColor = True
    TabOrder = 2
    object btnCarregar: TSpeedButton
      Left = 870
      Top = 74
      Width = 120
      Height = 22
      Caption = '&Carregar'
      OnClick = btnCarregarClick
    end
    object grpPedCom: TGroupBox
      Left = 440
      Top = 1
      Width = 424
      Height = 103
      Align = alLeft
      Caption = ' Pedido de Compra '
      TabOrder = 1
      object Label1: TLabel
        Left = 14
        Top = 23
        Width = 54
        Height = 14
        Caption = 'Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 116
        Top = 23
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 156
        Top = 23
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 14
        Top = 60
        Width = 81
        Height = 14
        Caption = 'Empresa Destino'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtNumPed: TEditFocus
        Tag = 99
        Left = 14
        Top = 37
        Width = 100
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtPdEspDoc: TEditFocus
        Left = 116
        Top = 37
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 1
        Text = 'PD'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodEmpPD: TEditFocus
        Tag = 99
        Left = 156
        Top = 37
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        OnExit = edtCodEmpPDExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpPD: TEditFocus
        Left = 186
        Top = 37
        Width = 225
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEmpOri: TEditFocus
        Tag = 99
        Left = 14
        Top = 73
        Width = 29
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
        TabOrder = 4
        OnExit = edtEmpOriExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtEmpOriDes: TEditFocus
        Left = 44
        Top = 73
        Width = 367
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object grpDocEnt: TGroupBox
      Left = 1
      Top = 1
      Width = 439
      Height = 103
      Align = alLeft
      Caption = ' Nota Fiscal de Entrada '
      TabOrder = 0
      object lblDocumento: TLabel
        Left = 6
        Top = 23
        Width = 54
        Height = 14
        Caption = 'Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEspecie: TLabel
        Left = 108
        Top = 23
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSerie: TLabel
        Left = 148
        Top = 23
        Width = 25
        Height = 14
        Caption = 'S'#233'rie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 179
        Top = 23
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblForNot: TLabel
        Left = 7
        Top = 60
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtDocumento: TEditFocus
        Tag = 99
        Left = 6
        Top = 37
        Width = 100
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspecie: TEditFocus
        Left = 108
        Top = 37
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 1
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSerie: TEditFocus
        Tag = 99
        Left = 148
        Top = 37
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmpNF: TEditFocus
        Tag = 99
        Left = 179
        Top = 37
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 3
        OnExit = edtCodEmpNFExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpNF: TEditFocus
        Left = 209
        Top = 37
        Width = 225
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
      object edtForNot: TEditFocus
        Tag = 99
        Left = 6
        Top = 73
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnExit = edtForNotExit
        OnKeyPress = edtForNotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForNot: TEditFocus
        Left = 66
        Top = 73
        Width = 367
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 119
    Width = 1018
    Height = 576
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 3
    object cxDados: TcxGrid
      Left = 1
      Top = 1
      Width = 1016
      Height = 574
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDados: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgDadosCustomDrawCell
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Position = spFooter
            Column = cxgDadosQTDDES
          end
          item
            Kind = skSum
            Position = spFooter
            Column = cxgDadosQTDTRA
          end
          item
            Kind = skSum
            Position = spFooter
            Column = cxgDadosSALFIS
          end
          item
            Kind = skSum
            Position = spFooter
            Column = cxgDadosSALDIS
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
        OnCustomDrawGroupCell = cxgDadosCustomDrawGroupCell
        object cxgDadosAGRUP: TcxGridDBColumn
          DataBinding.FieldName = 'AGRUP'
          Visible = False
          OnGetDisplayText = cxgDadosAGRUPGetDisplayText
          GroupIndex = 0
          IsCaptionAssigned = True
        end
        object cxgDadosColumn2: TcxGridDBColumn
          Caption = 'Empresa Destino'
          DataBinding.FieldName = 'NOMEMP'
          Options.Editing = False
          Options.Moving = False
          Width = 370
        end
        object cxgDadosQTDDES: TcxGridDBColumn
          Caption = 'Qtd. Pedido'
          DataBinding.FieldName = 'QTDDES'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 100
          Options.Editing = False
          Width = 100
        end
        object cxgDadosQTDTRA: TcxGridDBColumn
          Caption = 'Qtd. A Transferir'
          DataBinding.FieldName = 'QTDTRA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Properties.OnValidate = cxgDadosQTDTRAPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 100
          Width = 100
        end
        object cxgDadosSALFIS: TcxGridDBColumn
          Caption = 'Saldo F'#237'sico'
          DataBinding.FieldName = 'SALFIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 100
          Options.Editing = False
          Width = 100
        end
        object cxgDadosSALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'SALDIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 100
          Options.Editing = False
          Width = 100
        end
        object cxgDadosITE_ESTMIN: TcxGridDBColumn
          Caption = 'Estoque M'#237'nimo'
          DataBinding.FieldName = 'ITE_ESTMIN'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 100
          Options.Editing = False
          Width = 100
        end
        object cxgDadosITE_ESTMAX: TcxGridDBColumn
          Caption = 'Estoque M'#225'ximo'
          DataBinding.FieldName = 'ITE_ESTMAX'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 103
          Options.Editing = False
          Width = 103
        end
        object cxgDadosEMPDES: TcxGridDBColumn
          Caption = 'Empresa de Destino'
          DataBinding.FieldName = 'PCD_EMPDES'
          Visible = False
        end
        object cxgDadosITEFRA: TcxGridDBColumn
          DataBinding.FieldName = 'UNI_ITEFRA'
          Visible = False
        end
      end
      object cxlDados: TcxGridLevel
        GridView = cxgDados
      end
    end
  end
  object dtsDados: TDataSource
    Left = 648
    Top = 336
  end
end
