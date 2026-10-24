inherited frmPnlDadosItemAntigo: TfrmPnlDadosItemAntigo
  ClientHeight = 390
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 1024
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDadosItem: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 390
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlRodape: TPanel
      Left = 0
      Top = 63
      Width = 1024
      Height = 327
      Align = alClient
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        1024
        327)
      object lblIteAti: TLabel
        Left = 425
        Top = 5
        Width = 46
        Height = 13
        Alignment = taCenter
        Caption = 'lblIteAti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblLocFis: TLabel
        Left = 312
        Top = 28
        Width = 63
        Height = 14
        Caption = 'Local. F'#237'sica:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 413
        Top = 28
        Width = 85
        Height = 14
        Caption = 'Local. Super Est.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblLegendas: TLabel
        Left = 314
        Top = 9
        Width = 86
        Height = 13
        Caption = 'Mostrar Legendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblLegendasClick
      end
      object lblIteEmb: TLabel
        Left = 813
        Top = 113
        Width = 200
        Height = 12
        Alignment = taCenter
        AutoSize = False
        Caption = 'EMBALAGEM FECHADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblTmpGar: TLabel
        Left = 688
        Top = 191
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tempo Garantia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblInfGar: TLabel
        Left = 688
        Top = 208
        Width = 116
        Height = 14
        Alignment = taRightJustify
        Caption = 'Informa'#231#227'o de Garantia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object pgcSaldos: TPageControl
        Left = 0
        Top = 0
        Width = 306
        Height = 279
        ActivePage = tbsSaldos
        TabOrder = 0
        StyleElements = [seFont, seClient]
        OnEnter = pgcSaldosEnter
        OnExit = pgcSaldosExit
        object tbsSaldos: TTabSheet
          Caption = 'Saldos'
          object cxvSaldos: TcxVerticalGrid
            Left = 0
            Top = 0
            Width = 298
            Height = 251
            BorderStyle = cxcbsNone
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LookAndFeel.NativeStyle = True
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 197
            OptionsView.RowHeight = 18
            OptionsView.ShowButtons = False
            ParentFont = False
            TabOrder = 0
            OnEnter = cxvSaldosEnter
            OnExit = cxvSaldosExit
            Version = 1
            object cxvEstFisico: TcxEditorRow
              Options.CanAutoHeight = False
              Options.CanMovedToCustomizationForm = False
              Options.CanResized = False
              Options.Moving = False
              Options.ShowExpandButton = False
              Options.ShowInCustomizationForm = False
              Properties.Caption = 'Saldo F'#237'sico '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Options.Filtering = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object cxvGarantia: TcxEditorRow
              Properties.Caption = 'Reservado Garantia '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 1
              ParentID = -1
              Index = 1
              Version = 1
            end
            object cxvPedidoVenda: TcxEditorRow
              Properties.Caption = 'Reservado Pedido Venda '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 2
              ParentID = -1
              Index = 2
              Version = 1
            end
            object cxvEnderecamento: TcxEditorRow
              Properties.Caption = 'Reservado Endere'#231'amento '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 3
              ParentID = -1
              Index = 3
              Version = 1
            end
            object cxvExterno: TcxEditorRow
              Properties.Caption = 'Reservado Externo '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 4
              ParentID = -1
              Index = 4
              Version = 1
            end
            object cxvOrdemProducao: TcxEditorRow
              Properties.Caption = 'Ordem de Produ'#231#227'o '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 5
              ParentID = -1
              Index = 5
              Version = 1
            end
            object cxvEntFutPrevisao: TcxEditorRow
              Properties.Caption = 'Entr. Futura Previs'#227'o '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 6
              ParentID = -1
              Index = 6
              Version = 1
            end
            object cxvEntFutFalta: TcxEditorRow
              Properties.Caption = 'Entr. Futura Falta Produto '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 7
              ParentID = -1
              Index = 7
              Version = 1
            end
            object cxvEntFutAguarda: TcxEditorRow
              Properties.Caption = 'Entr. Futura Aguar. Cliente '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
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
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosDisponivel
              Styles.Content = cxsValorDisponivel
              ID = 9
              ParentID = -1
              Index = 9
              Version = 1
            end
            object cxvSalDisMenosEntFut: TcxEditorRow
              Properties.Caption = 'Saldo Disp - Ent.Futura '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 10
              ParentID = -1
              Index = 10
              Version = 1
            end
            object cxvPedidoCompra: TcxEditorRow
              Properties.Caption = 'Pedido Compra Pendente '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 11
              ParentID = -1
              Index = 11
              Version = 1
            end
            object cxvPedidoCompraLoja: TcxEditorRow
              Properties.Caption = 'Pedido Compra Pendente  Lojas'
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.EditProperties.ReadOnly = True
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Filtering = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 12
              ParentID = -1
              Index = 12
              Version = 1
            end
            object cxvPedidoBaixaEntregaFutura: TcxEditorRow
              Properties.Caption = 'Reservado Ped.Bai.Ent.Fut.'
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 13
              ParentID = -1
              Index = 13
              Version = 1
            end
            object cxvTransfEstAndamentoAgFat: TcxEditorRow
              Properties.Caption = 'Transf. Estoq. Andamento - Ag. Fat.'
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 14
              ParentID = -1
              Index = 14
              Version = 1
            end
            object cxvTransfEstAndamentoAgEnt: TcxEditorRow
              Properties.Caption = 'Transf. Estoq. Andamento - Ag. Ent.'
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldos
              ID = 15
              ParentID = -1
              Index = 15
              Version = 1
            end
          end
        end
        object tbsSaldosML: TTabSheet
          Caption = 'Saldos ML'
          ImageIndex = 2
          object cxvSaldosML: TcxVerticalGrid
            Left = 0
            Top = 0
            Width = 298
            Height = 251
            BorderStyle = cxcbsNone
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LookAndFeel.NativeStyle = True
            OptionsView.ScrollBars = ssNone
            OptionsView.RowHeaderWidth = 153
            OptionsView.RowHeight = 18
            OptionsView.ShowButtons = False
            ParentFont = False
            TabOrder = 0
            OnEnter = cxvSaldosMLEnter
            OnExit = cxvSaldosMLExit
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
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Options.Filtering = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object cxvGarantiaML: TcxEditorRow
              Properties.Caption = 'Reservado Garantia '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 1
              ParentID = -1
              Index = 1
              Version = 1
            end
            object cxvPedidoVendaML: TcxEditorRow
              Properties.Caption = 'Reservado Pedido Venda '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 2
              ParentID = -1
              Index = 2
              Version = 1
            end
            object cxvEnderecamentoML: TcxEditorRow
              Properties.Caption = 'Reservado Endere'#231'amento '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 3
              ParentID = -1
              Index = 3
              Version = 1
            end
            object cxvExternoML: TcxEditorRow
              Properties.Caption = 'Reservado Externo '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 4
              ParentID = -1
              Index = 4
              Version = 1
            end
            object cxvOrdemProducaoML: TcxEditorRow
              Properties.Caption = 'Ordem de Produ'#231#227'o '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 5
              ParentID = -1
              Index = 5
              Version = 1
            end
            object cxvEntFutPrevisaoML: TcxEditorRow
              Properties.Caption = 'Entr. Futura Previs'#227'o '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 6
              ParentID = -1
              Index = 6
              Version = 1
            end
            object cxvEntFutFaltaML: TcxEditorRow
              Properties.Caption = 'Entr. Futura Falta Produto '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 7
              ParentID = -1
              Index = 7
              Version = 1
            end
            object cxvEntFutAguardaML: TcxEditorRow
              Properties.Caption = 'Entr. Futura Aguar. Cliente '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 8
              ParentID = -1
              Index = 8
              Version = 1
            end
            object cxvDisponivelML: TcxEditorRow
              Properties.Caption = 'Saldo Dispon'#237'vel '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosMLDisponivel
              Styles.Content = cxsValorDisponivel
              ID = 9
              ParentID = -1
              Index = 9
              Version = 1
            end
            object cxvSalDisMenosEntFutML: TcxEditorRow
              Properties.Caption = 'Saldo Disp - Ent.Futura '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 10
              ParentID = -1
              Index = 10
              Version = 1
            end
            object cxvPedidoCompraML: TcxEditorRow
              Properties.Caption = 'Pedido Compra Pendente '
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
              Properties.Value = Null
              Styles.Header = cxsSaldosML
              ID = 11
              ParentID = -1
              Index = 11
              Version = 1
            end
            object cxvPedidoBaixaEntregaFuturaML: TcxEditorRow
              Properties.Caption = 'Reservado Ped.Bai.Ent.Fut.'
              Properties.EditPropertiesClassName = 'TcxTextEditProperties'
              Properties.EditProperties.Alignment.Horz = taRightJustify
              Properties.DataBinding.ValueType = 'String'
              Properties.Options.Editing = False
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
      object pnlImgPro: TPanel
        Left = 877
        Top = 8
        Width = 144
        Height = 100
        BevelInner = bvLowered
        BorderWidth = 2
        BorderStyle = bsSingle
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object imgPro: TImage
          Left = 4
          Top = 4
          Width = 132
          Height = 88
          Align = alClient
          Center = True
          IncrementalDisplay = True
          PopupMenu = popImgPro
          Proportional = True
          Stretch = True
          OnDblClick = imgProDblClick
        end
        object lblErrImg: TLabel
          Left = 4
          Top = 4
          Width = 132
          Height = 88
          Align = alClient
          Alignment = taCenter
          Caption = 
            'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
            'to do arquivo!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          Visible = False
          WordWrap = True
          ExplicitWidth = 131
          ExplicitHeight = 36
        end
      end
      object GroupBox2: TGroupBox
        Left = 513
        Top = -2
        Width = 362
        Height = 107
        TabOrder = 2
        object lblPreCus: TLabel
          Left = 51
          Top = 15
          Width = 65
          Height = 14
          Caption = 'Pre'#231'o Venda:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblUltVen: TLabel
          Left = 38
          Top = 37
          Width = 78
          Height = 14
          Caption = 'Dias n'#227'o vende:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPreBoca: TLabel
          Left = 5
          Top = 58
          Width = 111
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pre'#231'o Boca de Caixa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clFuchsia
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblComBoca: TLabel
          Left = 4
          Top = 80
          Width = 112
          Height = 14
          Alignment = taRightJustify
          Caption = '% Comiss. Boca Caixa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clFuchsia
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object dbePreVen: TDBEditFocus
          Left = 118
          Top = 12
          Width = 65
          Height = 22
          AutoSize = False
          DataField = 'ITE_PREVEN'
          DataSource = dtsConsulta
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUltVen: TDBEditFocus
          Left = 118
          Top = 34
          Width = 65
          Height = 22
          AutoSize = False
          DataField = 'ULTVEN'
          DataSource = dtsConsulta
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtPrecoBoca: TEditFocus
          Left = 118
          Top = 56
          Width = 65
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clFuchsia
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtComBoca: TEditFocus
          Left = 118
          Top = 77
          Width = 65
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clFuchsia
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object pnlPrePromoc: TPanel
          Left = 187
          Top = 0
          Width = 169
          Height = 109
          BevelOuter = bvNone
          Ctl3D = False
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 4
          object lblValPro: TLabel
            Left = 10
            Top = 88
            Width = 92
            Height = 14
            Caption = 'Pre'#231'o Promocional:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblMinPro: TLabel
            Left = 6
            Top = 45
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Min. Promo'#231#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblLimPro: TLabel
            Left = 6
            Top = 66
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Lim. Promo'#231#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblDispPro: TLabel
            Left = 1
            Top = 23
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Disp. Promo'#231#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtValPro: TEditFocus
            Left = 105
            Top = 85
            Width = 63
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtMinPro: TEditFocus
            Left = 105
            Top = 42
            Width = 63
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtLimPro: TEditFocus
            Left = 105
            Top = 64
            Width = 63
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtDispPro: TEditFocus
            Left = 105
            Top = 20
            Width = 63
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object lblDesPro: TcxLabel
            Left = 0
            Top = 0
            Align = alTop
            AutoSize = False
            Caption = '.........'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'Tahoma'
            Style.Font.Style = []
            Style.TextColor = clRed
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            Properties.WordWrap = True
            Transparent = True
            Height = 18
            Width = 169
            AnchorX = 85
            AnchorY = 9
          end
        end
      end
      object dbeLocFis: TDBEditFocus
        Left = 313
        Top = 42
        Width = 96
        Height = 22
        DataField = 'CAM_LOCFIS'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeLocSup: TDBEditFocus
        Left = 414
        Top = 42
        Width = 96
        Height = 22
        DataField = 'ITE_LOCSUP'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object pnlMetragem: TPanel
        Left = 695
        Top = 112
        Width = 121
        Height = 70
        BevelOuter = bvLowered
        TabOrder = 5
        Visible = False
        object lblQtdPec: TLabel
          Left = 2
          Top = 23
          Width = 91
          Height = 11
          Caption = 'Qtde.  : 1,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
        end
        object lblComPec: TLabel
          Left = 2
          Top = 35
          Width = 91
          Height = 11
          Caption = 'Compri.: 1,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
        end
        object lblLarPec: TLabel
          Left = 2
          Top = 46
          Width = 91
          Height = 11
          Caption = 'Largura: 1,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
        end
        object lblEspPec: TLabel
          Left = 2
          Top = 58
          Width = 91
          Height = 11
          Caption = 'Espess.: 1,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
        end
        object btnMetragem: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 121
          Height = 20
          Caption = '[ F1 ] Metragem'
          TabOrder = 0
          OnClick = btnMetragemClick
        end
      end
      object cxgIteEmb: TcxGridCitel
        Left = 837
        Top = 127
        Width = 182
        Height = 86
        TabOrder = 6
        TabStop = False
        Visible = False
        OnEnter = cxgIteEmbEnter
        OnExit = cxgIteEmbExit
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgIteEmbTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
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
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgIteEmbTableViewQTDEMB: TcxGridDBColumn
            Caption = 'Qtde.'
            DataBinding.FieldName = 'ITB_QTDEMB'
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Options.Sorting = False
            Width = 33
          end
          object cxgIteEmbTableViewDESCON: TcxGridDBColumn
            Caption = '% Desc.'
            DataBinding.FieldName = 'ITB_DESCON'
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Options.Sorting = False
            Width = 47
          end
          object cxgIteEmbTableViewTABPRE: TcxGridDBColumn
            Caption = 'Tabela'
            DataBinding.FieldName = 'ITB_TABPRE'
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Options.Sorting = False
            Width = 39
          end
          object cxgIteEmbTableViewUNITAR: TcxGridDBColumn
            Caption = 'Unit'#225'rio'
            DataBinding.FieldName = 'UNITAR'
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Options.Sorting = False
            Width = 60
          end
        end
        object cxgIteEmbLevel: TcxGridLevel
          GridView = cxgIteEmbTableView
        end
      end
      object btnTranEst: TBitBtnLocked
        Left = 330
        Top = 142
        Width = 171
        Height = 19
        Caption = '[AltF12] Transf.Estoq.andamento'
        TabOrder = 7
        OnClick = btnTranEstClick
      end
      object btnVendasPerdidas: TBitBtnLocked
        Left = 500
        Top = 106
        Width = 182
        Height = 19
        Caption = 'Incluir &Vendas Perdidas'
        TabOrder = 8
        OnClick = btnVendasPerdidasClick
      end
      object btnEmbalagem: TBitBtnLocked
        Left = 500
        Top = 214
        Width = 182
        Height = 19
        Caption = '[Alt+F7] Embalagem'
        TabOrder = 9
        OnClick = btnEmbalagemClick
      end
      object btnExecutaTarefa: TBitBtnLocked
        Left = 330
        Top = 268
        Width = 171
        Height = 19
        Caption = '[ F4 ] Composi'#231#227'o do Custo'
        TabOrder = 10
        OnClick = btnExecutaTarefaClick
      end
      object btnItensVend: TBitBtnLocked
        Left = 330
        Top = 160
        Width = 171
        Height = 19
        Caption = '[ F9 ] Itens Vendidos'
        TabOrder = 11
        OnClick = btnItensVendClick
      end
      object btnConsVendasPerdidas: TBitBtnLocked
        Left = 500
        Top = 124
        Width = 182
        Height = 19
        Caption = 'C&onsultar Vendas Perdidas'
        TabOrder = 12
        OnClick = btnConsVendasPerdidasClick
      end
      object btnExiEstrutura: TBitBtnLocked
        Left = 500
        Top = 196
        Width = 182
        Height = 19
        Caption = '[ Alt + F8 ] Exibir Estrutura'
        TabOrder = 13
        Visible = False
        OnClick = btnExiEstruturaClick
      end
      object btnEntregasPendentes: TBitBtnLocked
        Left = 500
        Top = 250
        Width = 182
        Height = 19
        Caption = '[ F5 ] Entregas Pendentes'
        TabOrder = 14
        OnClick = btnEntregasPendentesClick
      end
      object btnItensComp: TBitBtnLocked
        Left = 330
        Top = 178
        Width = 171
        Height = 19
        Caption = '[ F10 ] Itens Comprados'
        TabOrder = 15
        OnClick = btnItensCompClick
      end
      object btnMostraPrecoVenda: TBitBtnLocked
        Left = 500
        Top = 142
        Width = 182
        Height = 19
        Caption = '&Pre'#231'o Venda das Lojas'
        TabOrder = 16
        OnClick = btnMostraPrecoVendaClick
      end
      object btnMostraEstoque: TBitBtnLocked
        Left = 500
        Top = 268
        Width = 182
        Height = 19
        Caption = '[ F6 ] Estoque das Lojas'
        TabOrder = 17
        OnClick = btnMostraEstoqueClick
      end
      object btnPedComp: TBitBtnLocked
        Left = 330
        Top = 196
        Width = 171
        Height = 19
        Caption = '[ F11 ] Pedidos de Compra'
        TabOrder = 18
        OnClick = btnPedCompClick
      end
      object btnSepIte: TBitBtnLocked
        Left = 500
        Top = 160
        Width = 182
        Height = 19
        Caption = '[ Alt + F5 ] Separa'#231#227'o do Item'
        TabOrder = 19
        OnClick = btnSepIteClick
      end
      object btnPedSalRes: TBitBtnLocked
        Left = 330
        Top = 106
        Width = 171
        Height = 19
        Caption = '[ F7 ] Docs. de Saldo Reservado'
        TabOrder = 20
        OnClick = btnPedSalResClick
      end
      object btnPedCompGrid: TBitBtnLocked
        Left = 330
        Top = 214
        Width = 171
        Height = 19
        Caption = '[ F12 ] Ped. Compra (Grid)'
        TabOrder = 21
        OnClick = btnPedCompGridClick
      end
      object btnLotIte: TBitBtnLocked
        Left = 500
        Top = 178
        Width = 182
        Height = 19
        Caption = '[ Alt + F6 ] Lotes do Item'
        TabOrder = 22
        OnClick = btnLotIteClick
      end
      object btnComSisAnt: TBitBtnLocked
        Left = 330
        Top = 124
        Width = 171
        Height = 19
        Caption = '[Alt+F1] Compras do sist. anterior'
        TabOrder = 23
        OnClick = btnComSisAntClick
      end
      object btnVedasSisAnt: TBitBtnLocked
        Left = 330
        Top = 232
        Width = 171
        Height = 19
        Caption = '[Alt+F2] Vendas do Sist. anterior'
        TabOrder = 24
        OnClick = btnVedasSisAntClick
      end
      object btnAtalhos: TBitBtnLocked
        Left = 592
        Top = 232
        Width = 90
        Height = 19
        Caption = '[ Alt+T ] A&talhos'
        TabOrder = 25
        OnClick = btnAtalhosClick
      end
      object btnFichaKardex: TBitBtnLocked
        Left = 500
        Top = 232
        Width = 93
        Height = 19
        Caption = '[ Alt+K ] &Kardex'
        TabOrder = 26
        OnClick = btnFichaKardexClick
      end
      object btnSemelhantes: TBitBtnLocked
        Left = 330
        Top = 250
        Width = 96
        Height = 19
        Caption = '[F2] Semelhantes'
        TabOrder = 27
        OnClick = btnSemelhantesClick
      end
      object btnSimilares: TBitBtnLocked
        Left = 425
        Top = 247
        Width = 76
        Height = 19
        Caption = '[F8] Similares'
        TabOrder = 28
        OnClick = btnSimilaresClick
      end
      object dbeTmpGar: TDBEditFocus
        Left = 768
        Top = 185
        Width = 50
        Height = 22
        DataField = 'ITE_TMPGAR'
        DataSource = dtsConsulta
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeInfGar: TDBEditFocus
        Left = 688
        Top = 223
        Width = 292
        Height = 22
        DataField = 'ITE_INFGAR'
        DataSource = dtsConsulta
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 30
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnOrcamentos: TBitBtnLocked
        Left = 330
        Top = 70
        Width = 171
        Height = 19
        Caption = '[ Alt + F10 ] Or'#231'amentos'
        TabOrder = 32
        Visible = False
        OnClick = btnOrcamentosClick
      end
      object btnSimilaresOrcPed: TBitBtnLocked
        Left = 330
        Top = 88
        Width = 171
        Height = 19
        Caption = '[ Alt + F11 ] Similares Vend./Or'#231'.'
        TabOrder = 33
        OnClick = btnSimilaresOrcPedClick
      end
      object MemProBrin: TMemoFocus
        Left = 688
        Top = 248
        Width = 336
        Height = 72
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Lines.Strings = (
          'MemProBrin')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 31
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
        Texto = 'MemProBrin'
      end
      object btnCadArmazem: TBitBtnLocked
        Left = 330
        Top = 286
        Width = 171
        Height = 19
        Caption = 'Cadastro de Armaz'#233'm'
        TabOrder = 34
        OnClick = btnCadArmazemClick
      end
      object btnCadSimilaridade: TBitBtnLocked
        Left = 500
        Top = 286
        Width = 182
        Height = 19
        Caption = 'Cadastro de Similaridade'
        TabOrder = 35
        OnClick = btnCadSimilaridadeClick
      end
      object btnChkLstDevGar: TBitBtnLocked
        Left = 500
        Top = 304
        Width = 182
        Height = 19
        Caption = 'Devolu'#231#227'o/Garantia'
        Enabled = False
        TabOrder = 36
        Visible = False
        OnClick = btnChkLstDevGarClick
      end
      object btnRedeAncora: TBitBtnLocked
        Left = 330
        Top = 304
        Width = 171
        Height = 19
        Caption = '[Alt + R] Consulta Fo&rnec. Balc'#227'o'
        TabOrder = 37
      end
    end
    object pnlAplicacao: TPanel
      Left = 0
      Top = 0
      Width = 1024
      Height = 63
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object pnlAplic: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 63
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 677
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          ParentColor = True
          TabOrder = 0
          object lblExpandirAplicacao: TLabel
            Left = 635
            Top = 0
            Width = 42
            Height = 14
            Cursor = crHandPoint
            Align = alRight
            Caption = 'Expandir'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblExpandirAplicacaoClick
            ExplicitHeight = 13
          end
        end
        object DBAplica: TDBRichEdit
          Tag = 99
          Left = 0
          Top = 14
          Width = 677
          Height = 49
          Align = alClient
          DataField = 'ITE_APLICA'
          DataSource = dtsConsulta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          Zoom = 100
        end
      end
      object pnlMsgLivre: TPanel
        Left = 677
        Top = 0
        Width = 347
        Height = 63
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 347
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Mensagem Livre'
          ParentColor = True
          TabOrder = 0
        end
        object dbeMSGLIV: TDBMemoFocus
          Left = 0
          Top = 14
          Width = 347
          Height = 49
          Align = alClient
          BorderStyle = bsNone
          DataField = 'MSGLIV'
          DataSource = dtsConsulta
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
  end
  object dtsConsulta: TDataSource
    Left = 904
    Top = 192
  end
  object popAtalhos: TPopupMenu
    Left = 944
    Top = 231
    object mnuAgregados: TMenuItem
      Caption = '[Alt + G] A&gregados'
      OnClick = mnuAgregadosClick
    end
    object mnuReqCompra: TMenuItem
      Caption = '[Alt + R] &Requisi'#231#227'o de Compra'
      OnClick = mnuReqCompraClick
    end
    object btnImgSite: TMenuItem
      Caption = '[Alt + F9] &Visualizar Imagem Site'
      OnClick = btnImgSiteClick
    end
    object mnuEstVendaForaEstab: TMenuItem
      Caption = '[Alt + F] Estoque de Venda &fora do Estabelecimento'
      OnClick = mnuEstVendaForaEstabClick
    end
    object mnuNotasFiscaisAssociadasEmAberto: TMenuItem
      Caption = 'Notas Fiscais Associadas - Em Aberto'
      OnClick = mnuNotasFiscaisAssociadasEmAbertoClick
    end
  end
  object cxsGrid: TcxStyleRepository
    Left = 208
    Top = 168
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
  object ppmGarantia: TPopupMenu
    Left = 456
    Top = 359
    object ChecklistdeGarantiadeMercadorias1: TMenuItem
      Caption = 'Checklist de Garantia de Mercadorias'
      OnClick = ChecklistdeGarantiadeMercadorias1Click
    end
    object ChecklistdeTrocadeMercadorias1: TMenuItem
      Caption = 'Checklist de Troca de Mercadorias'
      OnClick = ChecklistdeTrocadeMercadorias1Click
    end
  end
  object popImgPro: TPopupMenu
    Left = 864
    Top = 197
    object mnuEnviarporWhatsapp: TMenuItem
      Caption = 'Enviar por Whatsapp'
      OnClick = mnuEnviarporWhatsappClick
    end
  end
end
