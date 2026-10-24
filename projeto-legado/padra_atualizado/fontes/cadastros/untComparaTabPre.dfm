inherited frmComparaTabPre: TfrmComparaTabPre
  Width = 1252
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Tabelas Relacionadas de Fornecedores'
  WindowState = wsMaximized
  ExplicitWidth = 1252
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1236
    TabOrder = 2
    ExplicitTop = 517
    ExplicitWidth = 1236
    inherited FlwBotoes: TFlowPanel
      Width = 1232
      ExplicitWidth = 1232
    end
    inherited btnSair: TBitBtnLocked
      Left = 1153
      Caption = 'Sair'
      ExplicitLeft = 1153
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1236
    TabOrder = 3
    ExplicitTop = 545
    ExplicitWidth = 1236
    inherited pnlNomeForm: TPanel
      Left = 1065
      ExplicitLeft = 1065
    end
    inherited pnlInfo: TPanel
      Width = 1065
      ExplicitWidth = 1065
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1236
    Height = 101
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lbl1: TLabel
      Left = 14
      Top = 18
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Left = 129
      Top = 14
      Width = 395
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 57
      Top = 14
      Width = 71
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 1
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object rdgStatus: TRadioGroup
      Tag = 99
      Left = 57
      Top = 42
      Width = 467
      Height = 48
      Caption = 'Status da Tabela'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ativa'
        'Inativa'
        'Todas')
      TabOrder = 2
      OnClick = rdgStatusClick
    end
  end
  object cxgDados: TcxGrid [3]
    Left = 0
    Top = 101
    Width = 1236
    Height = 416
    Align = alClient
    TabOrder = 1
    object cxbDadosView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro econtrado>'
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxs2
      Bands = <
        item
          FixedKind = fkLeft
          Width = 308
        end
        item
        end
        item
          FixedKind = fkRight
        end>
      object cxcDadosViewColumn1: TcxGridDBBandedColumn
        Caption = 'Tabela'
        DataBinding.FieldName = 'TAB_CODTAB'
        HeaderAlignmentHorz = taCenter
        Width = 46
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn2: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'TAB_NOMTAB'
        HeaderAlignmentHorz = taCenter
        Width = 166
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn3: TcxGridDBBandedColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        HeaderAlignmentHorz = taCenter
        Width = 149
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn4: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Fornecedor'
        DataBinding.FieldName = 'TAB_CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 71
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn5: TcxGridDBBandedColumn
        Caption = 'Ativa'
        DataBinding.FieldName = 'TAB_ATICMP'
        HeaderAlignmentHorz = taCenter
        Width = 40
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn6: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
        HeaderAlignmentHorz = taCenter
        Width = 127
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn7: TcxGridDBBandedColumn
        AlternateCaption = '0.00;-0.00'
        Caption = 'M'#250'ltipo de Compra'
        DataBinding.FieldName = 'ITE_MLTCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Width = 74
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn8: TcxGridDBBandedColumn
        AlternateCaption = '0.00;-0.00'
        Caption = 'Pre'#231'o de Compra L'#237'quido'
        DataBinding.FieldName = 'ITE_COMLIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn9: TcxGridDBBandedColumn
        AlternateCaption = '0.00;-0.00'
        Caption = 'IPI Entrada (+)'
        DataBinding.FieldName = 'ITE_IPIENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn10: TcxGridDBBandedColumn
        AlternateCaption = '0.00;-0.00'
        Caption = 'Sub. Tribut'#225'ria (+)'
        DataBinding.FieldName = 'ITE_SUBSTI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn13: TcxGridDBBandedColumn
        AlternateCaption = '0.00;-0.00'
        Caption = 'Pre'#231'o de Custo'
        DataBinding.FieldName = 'ITE_PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 80
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcDadosViewColumn15: TcxGridDBBandedColumn
        Caption = #218'lt. Compra'
        DataBinding.FieldName = 'ITE_DTAULT'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxbDadosViewColumn1: TcxGridDBBandedColumn
        Caption = 'ICMS Entrada (-)'
        DataBinding.FieldName = 'ITE_ICMENT'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxbDadosViewColumn2: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (-)'
        DataBinding.FieldName = 'ITE_SUBFED'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxbDadosViewColumn3: TcxGridDBBandedColumn
        Caption = '% Frete (+)'
        DataBinding.FieldName = 'ITE_FREENT'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxbDadosVALFRE: TcxGridDBBandedColumn
        Caption = 'Valor Frete (+)'
        DataBinding.FieldName = 'ITE_VALFRE'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxbDadosViewColumn5: TcxGridDBBandedColumn
        Caption = 'Acr'#233'scimo Finan. (+)'
        DataBinding.FieldName = 'ITE_ACRFIN'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxbDadosDESADB: TcxGridDBBandedColumn
        Caption = 'Descontos Adicionais (Boleto) (+)'
        DataBinding.FieldName = 'ITE_DESADB'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
    end
    object cxlGrid1Level1: TcxGridLevel
      GridView = cxbDadosView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 272
  end
  object cxs1: TcxStyleRepository
    Left = 144
    Top = 320
    PixelsPerInch = 96
    object cxs2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
