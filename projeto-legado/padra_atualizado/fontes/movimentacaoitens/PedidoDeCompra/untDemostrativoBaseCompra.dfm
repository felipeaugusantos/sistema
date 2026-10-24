inherited frmDemostrativoBaseCompra: TfrmDemostrativoBaseCompra
  Width = 759
  Height = 450
  Caption = 'Demonstrativo de Saldos'
  Color = 15724527
  Position = poScreenCenter
  ExplicitWidth = 759
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 753
    ExplicitTop = 364
    ExplicitWidth = 753
    inherited FlwBotoes: TFlowPanel
      Width = 749
      ExplicitWidth = 749
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 673
      Caption = 'Sair'
      ExplicitLeft = 673
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 753
    ExplicitTop = 390
    ExplicitWidth = 753
    inherited pnlNomeForm: TPanel
      Left = 582
      ExplicitLeft = 582
    end
    inherited pnlInfo: TPanel
      Width = 582
      ExplicitWidth = 582
    end
  end
  object cxvSaldos: TcxVerticalGrid [2]
    Left = 0
    Top = 73
    Width = 369
    Height = 306
    BorderStyle = cxcbsNone
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    LookAndFeel.NativeStyle = True
    OptionsView.ScrollBars = ssVertical
    OptionsView.RowHeaderWidth = 229
    OptionsView.RowHeight = 18
    OptionsView.ShowButtons = False
    OptionsData.Editing = False
    ParentFont = False
    TabOrder = 2
    ExplicitHeight = 291
    Version = 1
    object cxvSaldosTitulo: TcxCategoryRow
      Properties.Caption = 'Saldo Base para Compra'
      Properties.HeaderAlignmentHorz = taCenter
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxvEstFisico: TcxEditorRow
      Options.CanAutoHeight = False
      Options.CanMovedToCustomizationForm = False
      Options.CanResized = False
      Options.Moving = False
      Options.ShowExpandButton = False
      Options.ShowInCustomizationForm = False
      Properties.Caption = 'Saldo F'#237'sico (+)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Options.Filtering = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxvGarantia: TcxEditorRow
      Properties.Caption = 'Reservado Garantia (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxvPedidoVenda: TcxEditorRow
      Properties.Caption = 'Reservado Pedido Venda (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 3
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxvOrdemProducao: TcxEditorRow
      Properties.Caption = 'Ordem de Produ'#231#227'o (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 4
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxvEntFutPrevisao: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Previs'#227'o (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 5
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxvEntFutFalta: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Falta Produto (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 6
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxvEntFutAguarda: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Aguardando Cliente (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 7
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxvVendasPerdidas: TcxEditorRow
      Properties.Caption = 'Vendas Perdidas (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 8
      ParentID = -1
      Index = 8
      Version = 1
    end
    object cxvTransferencias: TcxEditorRow
      Properties.Caption = 'Saldos de Transfer'#234'ncias para a loja (+)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 9
      ParentID = -1
      Index = 9
      Version = 1
    end
    object cxvCotacao: TcxEditorRow
      Properties.Caption = 'Saldo de Cota'#231#227'o (+)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 10
      ParentID = -1
      Index = 10
      Version = 1
    end
    object cxvPedidoCompra: TcxEditorRow
      Properties.Caption = 'Pedido Compra Pendente (+)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 11
      ParentID = -1
      Index = 11
      Version = 1
    end
    object cxvDisponivel: TcxEditorRow
      Properties.Caption = 'Saldo Base para Compra'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBasCompra
      Styles.Content = cxsValorDisponivel
      ID = 12
      ParentID = -1
      Index = 12
      Version = 1
    end
    object cxvEnderecamento: TcxEditorRow
      Properties.Caption = 'Reservado Endere'#231'amento '
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 13
      ParentID = -1
      Index = 13
      Version = 1
    end
    object cxvSaldosSaldoRequisicao: TcxEditorRow
      Properties.Caption = 'Saldo Requisi'#231#227'o (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 14
      ParentID = -1
      Index = 14
      Version = 1
    end
    object cxvSaldoExterno: TcxEditorRow
      Options.CanAutoHeight = False
      Options.CanMovedToCustomizationForm = False
      Options.CanResized = False
      Options.Moving = False
      Options.ShowExpandButton = False
      Options.ShowInCustomizationForm = False
      Properties.Caption = 'Saldo Externo'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Options.Filtering = False
      Properties.Value = Null
      Styles.Header = cxsSaldosBas
      ID = 15
      ParentID = -1
      Index = 15
      Version = 1
    end
  end
  object cxvSaldosDisp: TcxVerticalGrid [3]
    Left = 384
    Top = 73
    Width = 369
    Height = 306
    BorderStyle = cxcbsNone
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    LookAndFeel.NativeStyle = True
    OptionsView.ScrollBars = ssVertical
    OptionsView.RowHeaderWidth = 216
    OptionsView.RowHeight = 18
    OptionsView.ShowButtons = False
    OptionsData.Editing = False
    ParentFont = False
    TabOrder = 4
    ExplicitHeight = 291
    Version = 1
    object cxCategoryRow1: TcxCategoryRow
      Properties.Caption = 'Saldo Dispon'#237'vel'
      Properties.HeaderAlignmentHorz = taCenter
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxvEstFisicoDisp: TcxEditorRow
      Options.CanAutoHeight = False
      Options.CanMovedToCustomizationForm = False
      Options.CanResized = False
      Options.Moving = False
      Options.ShowExpandButton = False
      Options.ShowInCustomizationForm = False
      Properties.Caption = 'Saldo F'#237'sico (+)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Options.Filtering = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxvGarantiaDisp: TcxEditorRow
      Properties.Caption = 'Reservado Garantia (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxvPedidoVendaDisp: TcxEditorRow
      Properties.Caption = 'Reservado Pedido Venda (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 3
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxvEnderecamentoDisp: TcxEditorRow
      Properties.Caption = 'Reservado Endere'#231'amento (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 4
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxvOrdemProducaoDisp: TcxEditorRow
      Properties.Caption = 'Ordem de Produ'#231#227'o (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 5
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxvEntFutPrevisaoDisp: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Previs'#227'o (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 6
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxvEntFutFaltaDisp: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Falta Produto (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 7
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxvEntFutAguardaDisp: TcxEditorRow
      Properties.Caption = 'Entrega Futura - Aguardando Cliente (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 8
      ParentID = -1
      Index = 8
      Version = 1
    end
    object cxvSaldoExternoDisp: TcxEditorRow
      Properties.Caption = 'Saldo Externo (-)'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 9
      ParentID = -1
      Index = 9
      Version = 1
    end
    object cxvDisponivelDisp: TcxEditorRow
      Properties.Caption = 'Saldo Dispon'#237'vel'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDispCompra
      Styles.Content = cxsValorDisponivel
      ID = 10
      ParentID = -1
      Index = 10
      Version = 1
    end
    object cxvPedidoCompraDisp: TcxEditorRow
      Properties.Caption = 'Pedido Compra Pendente '
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taRightJustify
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Editing = False
      Properties.Value = Null
      Styles.Header = cxsSaldosDisp
      ID = 11
      ParentID = -1
      Index = 11
      Version = 1
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 753
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label5: TLabel
      Left = 22
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
    object lblEmpresa: TLabel
      Left = 17
      Top = 41
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 64
      Top = 14
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 143
      Top = 14
      Width = 594
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 70
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 64
      Top = 37
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 143
      Top = 37
      Width = 594
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 70
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 672
    Top = 176
  end
  object cxsGrid: TcxStyleRepository
    Left = 664
    Top = 240
    PixelsPerInch = 96
    object cxsSaldosBas: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsSaldosBasCompra: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosDisp: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
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
    object cxsSaldosDispCompra: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
  end
end
