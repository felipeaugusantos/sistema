inherited frmFatManConEquExibeSaldo: TfrmFatManConEquExibeSaldo
  Width = 340
  Height = 330
  Caption = 'Estoque do Item'
  ExplicitWidth = 340
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 334
    ExplicitTop = 259
    ExplicitWidth = 334
    inherited FlwBotoes: TFlowPanel
      Width = 330
      ExplicitWidth = 330
    end
    inherited btnSair: TBitBtnLocked
      Left = 251
      ExplicitLeft = 251
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 334
    ExplicitTop = 285
    ExplicitWidth = 334
    inherited pnlNomeForm: TPanel
      Left = 163
      ExplicitLeft = 163
    end
    inherited pnlInfo: TPanel
      Width = 163
      ExplicitWidth = 163
    end
  end
  object pgcSaldos: TPageControl [2]
    Left = 0
    Top = 0
    Width = 334
    Height = 259
    ActivePage = tbsSaldos
    Align = alClient
    TabOrder = 2
    StyleElements = [seFont, seClient]
    object tbsSaldos: TTabSheet
      Caption = 'Saldos'
      object cxvSaldos: TcxVerticalGrid
        Left = 0
        Top = 0
        Width = 326
        Height = 230
        BorderStyle = cxcbsNone
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        LookAndFeel.NativeStyle = True
        OptionsView.ScrollBars = ssNone
        OptionsView.RowHeaderWidth = 169
        OptionsView.RowHeight = 18
        OptionsView.ShowButtons = False
        ParentFont = False
        TabOrder = 0
        OnKeyDown = cxvSaldosKeyDown
        Version = 1
        object cxvEstFisico: TcxEditorRow
          Options.CanAutoHeight = False
          Options.CanMovedToCustomizationForm = False
          Options.CanResized = False
          Options.Moving = False
          Options.ShowExpandButton = False
          Options.ShowInCustomizationForm = False
          Properties.Caption = 'Saldo F'#237'sico'
          Properties.EditPropertiesClassName = 'TcxTextEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.ReadOnly = True
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbNever
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxvGarantia: TcxEditorRow
          Tag = 14
          Properties.Caption = 'Reservado Garantia '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.UseLeftAlignmentOnEditing = False
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxvPedidoVenda: TcxEditorRow
          Tag = 15
          Properties.Caption = 'Reservado Pedido Venda '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxvEnderecamento: TcxEditorRow
          Tag = 16
          Properties.Caption = 'Reservado Endere'#231'amento '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxvExterno: TcxEditorRow
          Tag = 104
          Properties.Caption = 'Reservado Externo'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxvOrdemProducao: TcxEditorRow
          Tag = 17
          Properties.Caption = 'Ordem de Produ'#231#227'o '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxvEntFutPrevisao: TcxEditorRow
          Tag = 18
          Properties.Caption = 'Entr. Futura Previs'#227'o '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxvEntFutFalta: TcxEditorRow
          Tag = 19
          Properties.Caption = 'Entr. Futura Falta Produto '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxvEntFutAguarda: TcxEditorRow
          Tag = 20
          Properties.Caption = 'Entr. Futura Aguar. Cliente '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxvDisponivel: TcxEditorRow
          Properties.Caption = 'Saldo Dispon'#237'vel '
          Properties.EditPropertiesClassName = 'TcxTextEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.ReadOnly = True
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbNever
          Properties.Value = Null
          Styles.Header = cxsSaldosDisponivel
          Styles.Content = cxsValorDisponivel
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
        object cxvPedidoCompra: TcxEditorRow
          Tag = 21
          Properties.Caption = 'Pedido Compra Pendente '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          Visible = False
          ID = 10
          ParentID = -1
          Index = 10
          Version = 1
        end
        object cxvTransfEstAndamento: TcxEditorRow
          Tag = 22
          Properties.Caption = 'Pedido Aguar. Transfer'#234'ncia'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 11
          ParentID = -1
          Index = 11
          Version = 1
        end
        object cxvPedidoBaixaEntregaFutura: TcxEditorRow
          Tag = 317
          Properties.Caption = 'Reservado Ped.Bai.Ent.Fut.'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldos
          ID = 12
          ParentID = -1
          Index = 12
          Version = 1
        end
      end
    end
    object tbsSaldosML: TTabSheet
      Caption = 'Saldos ML'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 213
      object cxvSaldosML: TcxVerticalGrid
        Left = 0
        Top = 0
        Width = 326
        Height = 230
        BorderStyle = cxcbsNone
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        LookAndFeel.NativeStyle = True
        OptionsView.ScrollBars = ssNone
        OptionsView.RowHeaderWidth = 153
        OptionsView.RowHeight = 18
        OptionsView.ShowButtons = False
        ParentFont = False
        TabOrder = 0
        OnKeyDown = cxvSaldosKeyDown
        ExplicitWidth = 272
        ExplicitHeight = 250
        Version = 1
        object cxvEstFisicoML: TcxEditorRow
          Options.CanAutoHeight = False
          Options.CanMovedToCustomizationForm = False
          Options.CanResized = False
          Options.Moving = False
          Options.ShowExpandButton = False
          Options.ShowInCustomizationForm = False
          Properties.Caption = 'Saldo F'#237'sico '
          Properties.EditPropertiesClassName = 'TcxTextEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.ReadOnly = True
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbNever
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxvGarantiaML: TcxEditorRow
          Tag = 23
          Properties.Caption = 'Reservado Garantia '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxvPedidoVendaML: TcxEditorRow
          Tag = 24
          Properties.Caption = 'Reservado Pedido Venda '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxvEnderecamentoML: TcxEditorRow
          Tag = 25
          Properties.Caption = 'Reservado Endere'#231'amento '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxvExternoML: TcxEditorRow
          Tag = 105
          Properties.Caption = 'Reservado Externo'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxvEntFutPrevisaoML: TcxEditorRow
          Tag = 27
          Properties.Caption = 'Entr. Futura Previs'#227'o '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxvEntFutFaltaML: TcxEditorRow
          Tag = 28
          Properties.Caption = 'Entr. Futura Falta Produto '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxvEntFutAguardaML: TcxEditorRow
          Tag = 29
          Properties.Caption = 'Entr. Futura Aguar. Cliente '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxvDisponivelML: TcxEditorRow
          Properties.Caption = 'Saldo Dispon'#237'vel '
          Properties.EditPropertiesClassName = 'TcxTextEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.ReadOnly = True
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbNever
          Properties.Value = Null
          Styles.Header = cxsSaldosMLDisponivel
          Styles.Content = cxsValorDisponivel
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxvPedidoCompraML: TcxEditorRow
          Tag = 30
          Properties.Caption = 'Pedido Compra Pendente '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
        object cxvTransfEstAndamentoML: TcxEditorRow
          Tag = 31
          Properties.Caption = 'Pedido Aguar. Transfer'#234'ncia'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 10
          ParentID = -1
          Index = 10
          Version = 1
        end
        object cxvOrdemProducaoML: TcxEditorRow
          Tag = 26
          Properties.Caption = 'Ordem de Produ'#231#227'o '
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 11
          ParentID = -1
          Index = 11
          Version = 1
        end
        object cxvPedidoBaixaEntregaFuturaML: TcxEditorRow
          Tag = 318
          Properties.Caption = 'Reservado Ped.Bai.Ent.Fut.'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Alignment.Horz = taRightJustify
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
              LeftAlignment = True
            end>
          Properties.EditProperties.ReadOnly = True
          Properties.EditProperties.OnButtonClick = cxvGarantiaEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Filtering = False
          Properties.Options.ShowEditButtons = eisbAlways
          Properties.Value = Null
          Styles.Header = cxsSaldosML
          ID = 12
          ParentID = -1
          Index = 12
          Version = 1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 0
  end
  object cxsGrid: TcxStyleRepository
    Left = 58
    PixelsPerInch = 96
    object cxsSaldos: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsSaldosDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosML: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsSaldosCD: TcxStyle
      AssignedValues = [svColor]
      Color = 16765039
    end
    object cxsSaldosCDML: TcxStyle
      AssignedValues = [svColor]
      Color = 12713921
    end
    object cxsSaldosMLDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosCDDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16765039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosCDMLDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12713921
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsValorDisponivel: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
  end
end
