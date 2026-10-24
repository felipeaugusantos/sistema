inherited frmValidacaoEspelhoXMLView: TfrmValidacaoEspelhoXMLView
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Valida'#231#227'o XML AD '
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1008
    ExplicitTop = 519
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitTop = 2
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ExplicitLeft = 928
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
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
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 492
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsValidacao
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgItensCODIGO_PRODUTO: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODIGO_PRODUTO'
        OnCustomDrawCell = cxgItensCODIGO_PRODUTOCustomDrawCell
        Options.CellMerging = True
        SortIndex = 0
        SortOrder = soAscending
        Width = 60
      end
      object cxgItensDESCRICAO_PRODUTO: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESCRICAO_PRODUTO'
        OnCustomDrawCell = cxgItensDESCRICAO_PRODUTOCustomDrawCell
        Options.CellMerging = True
        Width = 238
      end
      object cxItensCODIGO_FABRICA: TcxGridDBColumn
        Caption = 'C'#243'd. Fabrica'
        DataBinding.FieldName = 'CODIGO_FABRICA'
        OnCustomDrawCell = cxItensCODIGO_FABRICACustomDrawCell
        Width = 120
      end
      object cxgItensREFERENCIA: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERENCIA'
        OnCustomDrawCell = cxgItensREFERENCIACustomDrawCell
        Width = 82
      end
      object cxgItensSIGLA_UNIDADE: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGLA_UNIDADE'
        OnCustomDrawCell = cxgItensSIGLA_UNIDADECustomDrawCell
        Width = 46
      end
      object cxgItensCLASSIFICACAO_FISCAL: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLASSIFICACAO_FISCAL'
        OnCustomDrawCell = cxgItensCLASSIFICACAO_FISCALCustomDrawCell
        MinWidth = 38
        Width = 38
      end
      object cxgItensCST: TcxGridDBColumn
        DataBinding.FieldName = 'CST'
        OnCustomDrawCell = cxgItensCSTCustomDrawCell
        Width = 35
      end
      object cxgItensQUANTIDADE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QUANTIDADE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;(0.0000)'
        OnCustomDrawCell = cxgItensQUANTIDADECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgItensVALOR_BRUTO: TcxGridDBColumn
        Caption = 'Valor Bruto'
        DataBinding.FieldName = 'VALOR_BRUTO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_BRUTOCustomDrawCell
      end
      object cxgItensDESCONTO: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'DESCONTO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensDESCONTOCustomDrawCell
      end
      object cxgItensBASE_ICMS: TcxGridDBColumn
        Caption = 'Base ICMS'
        DataBinding.FieldName = 'BASE_ICMS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASE_ICMSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensALIQUOTA_ICMS: TcxGridDBColumn
        Caption = 'Alq.ICMS'
        DataBinding.FieldName = 'ALIQUOTA_ICMS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALIQUOTA_ICMSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object cxgItensVALOR_ICMS: TcxGridDBColumn
        Caption = 'Valor ICMS'
        DataBinding.FieldName = 'VALOR_ICMS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_ICMSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensBASE_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn
        Caption = 'Base Subst.'
        DataBinding.FieldName = 'BASE_SUBSTITUICAO_TRIBUTARIA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASE_SUBSTITUICAO_TRIBUTARIACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensVALOR_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn
        Caption = 'Valor Subst.'
        DataBinding.FieldName = 'VALOR_SUBSTITUICAO_TRIBUTARIA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_SUBSTITUICAO_TRIBUTARIACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensBASE_IPI: TcxGridDBColumn
        Caption = 'Base IPI'
        DataBinding.FieldName = 'BASE_IPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASE_IPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 65
      end
      object cxgItensALIQUOTA_IPI: TcxGridDBColumn
        Caption = 'Alq.IPI'
        DataBinding.FieldName = 'ALIQUOTA_IPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALIQUOTA_IPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 46
      end
      object cxgItensVALOR_IPI: TcxGridDBColumn
        Caption = 'Valor IPI'
        DataBinding.FieldName = 'VALOR_IPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_IPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensBASE_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        Caption = 'Base FCP'
        DataBinding.FieldName = 'BASE_FUNDO_COMBATE_POBREZA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASE_FUNDO_COMBATE_POBREZACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 81
      end
      object cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        Caption = 'ALiq. FCP'
        DataBinding.FieldName = 'ALIQUOTA_FUNDO_COMBATE_POBREZA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALIQUOTA_FUNDO_COMBATE_POBREZACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 81
      end
      object cxgItensVALOR_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        Caption = 'Valor FCP'
        DataBinding.FieldName = 'VALOR_FUNDO_COMBATE_POBREZA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_FUNDO_COMBATE_POBREZACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgItensBASE_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        Caption = 'Base FCP ST'
        DataBinding.FieldName = 'BASE_FUNDO_COMBATE_POBREZA_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASE_FUNDO_COMBATE_POBREZA_STCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 81
      end
      object cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        Caption = 'ALiq. FCP ST'
        DataBinding.FieldName = 'ALIQUOTA_FUNDO_COMBATE_POBREZA_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA_STCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 78
      end
      object cxgItensVALOR_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        Caption = 'Valor FCP ST'
        DataBinding.FieldName = 'VALOR_FUNDO_COMBATE_POBREZA_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALOR_FUNDO_COMBATE_POBREZA_STCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 81
      end
      object cxgItensVALIDACAO_VALOR_BRUTO: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_BRUTO'
        Visible = False
      end
      object cxgItensVALIDACAO_QUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_QUANTIDADE'
        Visible = False
      end
      object cxgItensVALIDACAO_BASE_ICMS: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_BASE_ICMS'
        Visible = False
      end
      object cxgItensVALIDACAO_ALIQUOTA_ICMS: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_ALIQUOTA_ICMS'
        Visible = False
      end
      object cxgItensVALIDACAO_VALOR_ICMS: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_ICMS'
        Visible = False
      end
      object cxgItensVALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA'
        Visible = False
      end
      object cxgItensVALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA'
        Visible = False
      end
      object cxgItensVALIDACAO_BASE_IPI: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_BASE_IPI'
        Visible = False
      end
      object cxgItensVALIDACAO_ALIQUOTA_IPI: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_ALIQUOTA_IPI'
        Visible = False
      end
      object cxgItensVALIDACAO_VALOR_IPI: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_IPI'
        Visible = False
      end
      object cxgItensVALIDACAO_CST: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_CST'
        Visible = False
      end
      object cxgItensVALIDACAO_DESCONTO: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_DESCONTO'
        Visible = False
      end
      object cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST'
        Visible = False
      end
      object cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST'
        Visible = False
      end
      object cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST'
        Visible = False
      end
      object cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_BASE_FUNDO_COMBATE_POBREZA'
        Visible = False
      end
      object cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA'
        Visible = False
      end
      object cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA'
        Visible = False
      end
      object cxgItensVALIDACAO_CLASSIFICACAO_FISCAL: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_CLASSIFICACAO_FISCAL'
        Visible = False
      end
      object cxgItensTIPO: TcxGridDBColumn
        DataBinding.FieldName = 'TIPO'
        Visible = False
      end
      object cxgItensVALIDACAO_DESCRICAO: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDACAO_DESCRICAO'
        Visible = False
      end
      object cxgItensVALIDO: TcxGridDBColumn
        DataBinding.FieldName = 'VALIDO'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 492
    Width = 1008
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object shpXML: TShape
      Left = 12
      Top = 4
      Width = 17
      Height = 17
      Brush.Color = 7405568
    end
    object Label1: TLabel
      Left = 35
      Top = 6
      Width = 104
      Height = 14
      Caption = 'Nota Eletr'#244'nica (XML)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpEspelho: TShape
      Left = 155
      Top = 4
      Width = 17
      Height = 17
      Brush.Color = 22784
    end
    object Label2: TLabel
      Left = 178
      Top = 6
      Width = 38
      Height = 14
      Caption = 'Espelho'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpErro: TShape
      Left = 230
      Top = 4
      Width = 17
      Height = 17
      Brush.Color = 13421823
    end
    object Label3: TLabel
      Left = 253
      Top = 6
      Width = 63
      Height = 14
      Caption = 'Diverg'#234'ncias'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 60
  end
  object dtsValidacao: TDataSource
    Left = 732
    Top = 360
  end
end
