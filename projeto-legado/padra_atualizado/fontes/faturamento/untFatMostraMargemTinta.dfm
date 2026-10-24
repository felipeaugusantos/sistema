inherited frmFatMostraMargemTinta: TfrmFatMostraMargemTinta
  BorderStyle = bsSizeable
  Caption = 'Consulta de Custo / Margem das Tintas'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 450
    Width = 759
    ExplicitTop = 450
    ExplicitWidth = 759
  end
  inherited pgcDados: TPageControl
    Width = 759
    Height = 450
    ExplicitWidth = 759
    ExplicitHeight = 450
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 751
      ExplicitHeight = 418
    end
  end
  object dbgDadosTintas: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 759
    Height = 450
    Align = alClient
    PopupMenu = popGrid
    TabOrder = 3
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgvDadosTintas: TcxGridDBTableView
      OnKeyDown = dbgvDadosTintasKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDadosTintas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem Registros>'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      OptionsView.GroupSummaryLayout = gslAlignWithColumnsAndDistribute
      Styles.Footer = cxstylFooter
      Styles.Group = cxstylGrupo
    end
    object dbglDadosTintas: TcxGridLevel
      GridView = dbgvDadosTintas
    end
  end
  inherited pnlStatus: TPanel
    Top = 450
    Width = 759
    ExplicitTop = 450
    ExplicitWidth = 759
    inherited pnlNomeForm: TPanel
      Left = 588
      ExplicitLeft = 588
    end
    inherited pnlInfo: TPanel
      Width = 588
      ExplicitWidth = 588
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 16
  end
  object cdsDadosTintas: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Descricao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Tipo'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Produto'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Quantidade'
        DataType = ftFloat
      end
      item
        Name = 'PrecoVenda'
        DataType = ftCurrency
      end
      item
        Name = 'PrecoCusto'
        DataType = ftCurrency
      end
      item
        Name = 'PrecoCustoReal'
        DataType = ftCurrency
      end
      item
        Name = 'PrecoCustoMedio'
        DataType = ftCurrency
      end
      item
        Name = 'OutrosValores'
        DataType = ftCurrency
      end
      item
        Name = 'IcmsSaida'
        DataType = ftCurrency
      end
      item
        Name = 'ImpostosFederais'
        DataType = ftCurrency
      end
      item
        Name = 'DespesasOperacionais'
        DataType = ftCurrency
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'UltimoPrecoCompraImpostos'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsDadosTintasCalcFields
    Left = 48
    Top = 16
    object cdsDadosTintasDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 100
    end
    object cdsDadosTintasTipo: TStringField
      FieldName = 'Tipo'
      Size = 100
    end
    object cdsDadosTintasProduto: TStringField
      FieldName = 'Produto'
      Size = 100
    end
    object cdsDadosTintasQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '0.000'
    end
    object cdsDadosTintasPrecoVenda: TCurrencyField
      DisplayLabel = 'Venda'
      FieldName = 'PrecoVenda'
    end
    object cdsDadosTintasPrecoCusto: TCurrencyField
      DisplayLabel = 'Custo'
      FieldName = 'PrecoCusto'
    end
    object cdsDadosTintasOutrosValores: TCurrencyField
      DisplayLabel = 'Outros Valores'
      FieldName = 'OutrosValores'
    end
    object cdsDadosTintasIcmsSaida: TCurrencyField
      DisplayLabel = 'Icms Sa'#237'da'
      FieldName = 'IcmsSaida'
    end
    object cdsDadosTintasImpostosFederais: TCurrencyField
      DisplayLabel = 'Impostos Federais'
      FieldName = 'ImpostosFederais'
    end
    object cdsDadosTintasDespesasOperacionais: TCurrencyField
      DisplayLabel = 'Despesas Operacionais'
      FieldName = 'DespesasOperacionais'
    end
    object cdsDadosTintasMargem: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Margem'
      DisplayFormat = '0.00%'
      Calculated = True
    end
    object cdsDadosTintasCODITE: TStringField
      FieldName = 'CODITE'
      Visible = False
      Size = 7
    end
    object cdsDadosTintasPrecoCustoMedio: TCurrencyField
      DisplayLabel = 'Custo M'#233'dio'
      FieldName = 'PrecoCustoMedio'
    end
    object cdsDadosTintasPrecoCustoReal: TCurrencyField
      DisplayLabel = 'Custo Real'
      FieldName = 'PrecoCustoReal'
    end
    object cdsDadosTintasUltimoPrecoCompraImpostos: TCurrencyField
      DisplayLabel = #218'ltimo Pre'#231'o de Compra + Impostos'
      FieldName = 'UltimoPrecoCompraImpostos'
    end
    object cdsDadosTintasMarkup: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Markup'
      DisplayFormat = '0.00%'
      Calculated = True
    end
  end
  object dtsDadosTintas: TDataSource
    AutoEdit = False
    DataSet = cdsDadosTintas
    Left = 112
    Top = 16
  end
  object cxstylrpstryGrupo: TcxStyleRepository
    Left = 80
    Top = 16
    PixelsPerInch = 96
    object cxstylGrupo: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxstylFooter: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object popGrid: TPopupMenu
    OnPopup = popGridPopup
    Left = 512
    Top = 168
    object ImprimirF4: TMenuItem
      Caption = 'Imprimir'
      OnClick = ImprimirF4Click
    end
  end
end
