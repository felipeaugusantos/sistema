inherited frmPnlDadosItemResumido: TfrmPnlDadosItemResumido
  ClientHeight = 425
  ClientWidth = 1175
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 1175
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDadosItem: TPanel
    Left = 0
    Top = 0
    Width = 1175
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlAplicacao: TPanel
      Left = 0
      Top = 0
      Width = 1175
      Height = 61
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object pnlAplic: TPanel
        Left = 0
        Top = 0
        Width = 759
        Height = 61
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 759
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          ParentColor = True
          TabOrder = 0
          object lblExpandirAplicacao: TLabel
            Left = 717
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
          Left = 0
          Top = 14
          Width = 759
          Height = 47
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
        Left = 759
        Top = 0
        Width = 416
        Height = 61
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 416
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
          Width = 416
          Height = 47
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
    object pnlRodape: TPanel
      Left = 0
      Top = 61
      Width = 1175
      Height = 364
      Align = alClient
      ParentColor = True
      TabOrder = 1
      object pnlTotaisRodape: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 327
        Width = 1167
        Height = 33
        Align = alBottom
        BevelKind = bkSoft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblTotaisRodape: TLabel
          Left = 197
          Top = 10
          Width = 428
          Height = 13
          Alignment = taRightJustify
          Caption = 
            'Aqui ser'#225' exibido os campos de total da venda - M'#225'ximo Width des' +
            'se form deve ser 1175'
          Visible = False
        end
      end
      object pnlCndPag: TPanel
        Left = 1
        Top = 298
        Width = 1173
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object lblDesMax: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 4
          Width = 63
          Height = 18
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alLeft
          Caption = '% Desconto:'
          Layout = tlCenter
          ExplicitHeight = 13
        end
        object lblCndPag: TLabel
          AlignWithMargins = True
          Left = 279
          Top = 4
          Width = 141
          Height = 18
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alLeft
          Caption = 'Cond. Pgto.: / Forma Pgto.:  '
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          StyleElements = [seClient, seBorder]
          ExplicitHeight = 13
        end
        object edtDesMax: TEditFocus
          AlignWithMargins = True
          Left = 72
          Top = 5
          Width = 65
          Height = 17
          Margins.Top = 5
          Margins.Bottom = 4
          Align = alLeft
          Alignment = taRightJustify
          TabOrder = 0
          Text = '0,00'
          StyleElements = [seFont, seBorder]
          OnExit = edtDesMaxExit
          OnKeyDown = edtDesMaxKeyDown
          NormalColor = clWindow
          FocusColor = clWindow
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
          ExplicitHeight = 21
        end
        object btnCndPag: TBitBtnLocked
          AlignWithMargins = True
          Left = 143
          Top = 3
          Width = 130
          Height = 20
          Align = alLeft
          Caption = 'Condi'#231#227'o de Pagamento'
          TabOrder = 1
          OnClick = btnCndPagClick
        end
      end
      object pnlPaineis: TPanel
        Left = 1
        Top = 5
        Width = 1173
        Height = 293
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlPaineis'
        ParentColor = True
        ShowCaption = False
        TabOrder = 2
        object pnlSaldoLojas: TPanel
          Left = 315
          Top = 0
          Width = 194
          Height = 293
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'pnlSaldoLojas'
          ParentBackground = False
          ParentColor = True
          TabOrder = 2
          object pnlEsqLojas: TPanel
            Left = 0
            Top = 0
            Width = 4
            Height = 293
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'pnlEsqLojas'
            ParentColor = True
            ShowCaption = False
            TabOrder = 0
          end
          object pnlDirLojas: TPanel
            Left = 190
            Top = 0
            Width = 4
            Height = 293
            Align = alRight
            BevelOuter = bvNone
            Caption = 'pnlDirLojas'
            ParentColor = True
            ShowCaption = False
            TabOrder = 1
          end
          object cxgLojas: TcxGrid
            Left = 4
            Top = 0
            Width = 186
            Height = 293
            Align = alClient
            TabOrder = 2
            OnEnter = cxgLojasEnter
            OnExit = cxgLojasExit
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvLojas: TcxGridDBBandedTableView
              OnKeyDown = cxvSaldosKeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = cxvLojasCustomDrawCell
              DataController.DataSource = dtsSalLoj
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = ',0.000;-,0.000'
                  Kind = skSum
                  Column = cxvLojasSALFIS
                end
                item
                  Format = ',0.000;-,0.000'
                  Kind = skSum
                  Column = cxvLojasSALDIS
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              Bands = <
                item
                  Caption = 'Saldo das Lojas'
                  Width = 235
                end>
              object cxvLojasColumn1: TcxGridDBBandedColumn
                Caption = 'Emp.'
                DataBinding.FieldName = 'CODEMP'
                HeaderAlignmentHorz = taCenter
                Options.Focusing = False
                Styles.Content = cxsSaldos
                Width = 35
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLojasSALFIS: TcxGridDBBandedColumn
                Caption = 'Saldo F'#237'sico'
                DataBinding.FieldName = 'SALFIS'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DecimalPlaces = 3
                Properties.DisplayFormat = ',0.000;-,0.000'
                HeaderAlignmentHorz = taCenter
                Width = 91
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvLojasSALDIS: TcxGridDBBandedColumn
                Caption = 'Dispon'#237'vel'
                DataBinding.FieldName = 'SALDIS'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DecimalPlaces = 3
                Properties.DisplayFormat = ',0.000;-,0.000'
                HeaderAlignmentHorz = taCenter
                Width = 90
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxvLojasLISREG: TcxGridDBBandedColumn
                DataBinding.FieldName = 'LISREG'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
            end
            object cxgLojasLevel1: TcxGridLevel
              GridView = cxvLojas
            end
          end
        end
        object btnEstDet: TBitBtnLocked
          Left = 458
          Top = 2
          Width = 17
          Height = 16
          Hint = 'Estoque Detalhado'
          Caption = '...'
          TabOrder = 0
          OnClick = btnEstDetClick
        end
        object pnlPgcSaldos: TPanel
          Left = 0
          Top = 0
          Width = 315
          Height = 293
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'pnlPgcSaldos'
          ShowCaption = False
          TabOrder = 1
          object pgcSaldos: TPageControl
            Left = 0
            Top = 0
            Width = 315
            Height = 293
            ActivePage = tbsSaldos
            Align = alClient
            PopupMenu = popSaldos
            TabOrder = 0
            StyleElements = [seFont, seClient]
            OnEnter = pgcSaldosEnter
            OnExit = pgcSaldosExit
            object tbsSaldos: TTabSheet
              Caption = 'Saldos'
              object cxvSaldos: TcxVerticalGrid
                Left = 2
                Top = 1
                Width = 307
                Height = 265
                BorderStyle = cxcbsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                LookAndFeel.NativeStyle = True
                OptionsView.ScrollBars = ssVertical
                OptionsView.RowHeaderWidth = 196
                OptionsView.RowHeight = 18
                OptionsView.ShowButtons = False
                ParentFont = False
                TabOrder = 0
                OnEnter = cxvSaldosEnter
                OnExit = cxvSaldosExit
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
                  Tag = 526
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
                  Properties.Caption = 'Reservado em Ordem de Produ'#231#227'o '
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
                  Tag = 410
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
                  ID = 10
                  ParentID = -1
                  Index = 10
                  Version = 1
                end
                object cxvPedidoCompraPendenteLojas: TcxEditorRow
                  Tag = 411
                  Properties.Caption = 'Pedido Compra Pendente Lojas'
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
                object cxvReqPendente: TcxEditorRow
                  Tag = 337
                  Properties.Caption = 'Requisi'#231#245'es Pendentes'
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
                object cxvReqPendenteLojas: TcxEditorRow
                  Tag = 338
                  Properties.Caption = 'Requisi'#231#245'es Pendentes Lojas'
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
                  ID = 13
                  ParentID = -1
                  Index = 13
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
                  ID = 14
                  ParentID = -1
                  Index = 14
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
                  ID = 15
                  ParentID = -1
                  Index = 15
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
                  ID = 16
                  ParentID = -1
                  Index = 16
                  Version = 1
                end
                object cxvSaldoCompartilhado: TcxEditorRow
                  Properties.Caption = 'Saldo compartilhado '
                  Properties.EditPropertiesClassName = 'TcxTextEditProperties'
                  Properties.EditProperties.Alignment.Horz = taRightJustify
                  Properties.EditProperties.ReadOnly = True
                  Properties.DataBinding.ValueType = 'String'
                  Properties.Options.Filtering = False
                  Properties.Options.ShowEditButtons = eisbNever
                  Properties.Value = Null
                  Styles.Header = cxsSaldos
                  ID = 17
                  ParentID = -1
                  Index = 17
                  Version = 1
                end
                object cxvTotalEmOrdProd: TcxEditorRow
                  Properties.Caption = 'Total em Ordem de Produ'#231#227'o'
                  Properties.EditPropertiesClassName = 'TcxTextEditProperties'
                  Properties.EditProperties.Alignment.Horz = taRightJustify
                  Properties.EditProperties.ReadOnly = True
                  Properties.DataBinding.ValueType = 'String'
                  Properties.Options.Filtering = False
                  Properties.Options.ShowEditButtons = eisbNever
                  Properties.Value = Null
                  Styles.Header = cxsSaldos
                  ID = 18
                  ParentID = -1
                  Index = 18
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
                Width = 307
                Height = 265
                BorderStyle = cxcbsNone
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                LookAndFeel.NativeStyle = True
                OptionsView.ScrollBars = ssNone
                OptionsView.RowHeaderWidth = 108
                OptionsView.RowHeight = 18
                OptionsView.ShowButtons = False
                ParentFont = False
                TabOrder = 0
                OnEnter = cxvSaldosMLEnter
                OnExit = cxvSaldosMLExit
                OnKeyDown = cxvSaldosKeyDown
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
        end
        object pnlGrupoDireita: TPanel
          Left = 509
          Top = 0
          Width = 664
          Height = 293
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnlGrupoDireita'
          ParentColor = True
          ShowCaption = False
          TabOrder = 3
          object pnlProBrin: TPanel
            Left = 0
            Top = 255
            Width = 664
            Height = 38
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'pnlProBrin'
            ShowCaption = False
            TabOrder = 0
            object MemProBrin: TMemoFocus
              Left = 0
              Top = 8
              Width = 664
              Height = 30
              Align = alBottom
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
              TabOrder = 0
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
              Texto = 'MemProBrin'
            end
          end
          object pnlTotais: TPanel
            Left = 487
            Top = 0
            Width = 177
            Height = 255
            Align = alRight
            BevelOuter = bvNone
            Caption = 'pnlTotais'
            Padding.Left = 3
            ParentColor = True
            ShowCaption = False
            TabOrder = 1
            object pnlTotaisLateral: TPanel
              Left = 3
              Top = 0
              Width = 174
              Height = 255
              Align = alTop
              BevelOuter = bvNone
              Caption = 'pnlTotaisLateral'
              ParentColor = True
              ShowCaption = False
              TabOrder = 0
              object pnlTotaisLateralFlow: TFlowPanel
                Left = 0
                Top = 0
                Width = 174
                Height = 255
                Align = alClient
                BevelKind = bkSoft
                BevelOuter = bvNone
                Caption = 'pnlTotaisLateralFlow'
                ShowCaption = False
                TabOrder = 0
                object pnlTotGer: TPanel
                  Left = 0
                  Top = 0
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 0
                  object lblTotGer: TLabel
                    Left = 21
                    Top = 9
                    Width = 56
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total Itens:'
                  end
                  object edtTotGer: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Pitch = fpVariable
                    Font.Style = []
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ParentFont = False
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohIPI: TPanel
                  Left = 0
                  Top = 27
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 1
                  object lblSohIPI: TLabel
                    Left = 32
                    Top = 9
                    Width = 45
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total IPI:'
                  end
                  object edtSohIPI: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlTotIpi: TPanel
                  Left = 0
                  Top = 54
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 2
                  object lblTotIpi: TLabel
                    Left = 18
                    Top = 9
                    Width = 59
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total C/ IPI:'
                  end
                  object edtTotIpi: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohST: TPanel
                  Left = 0
                  Top = 81
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 3
                  object lblSohST: TLabel
                    Left = 31
                    Top = 6
                    Width = 43
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total ST:'
                  end
                  object edtSohST: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohFCP: TPanel
                  Left = 0
                  Top = 108
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 4
                  object lblSohFCP: TLabel
                    Left = 12
                    Top = 9
                    Width = 65
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total FCP ST:'
                  end
                  object edtSohFCP: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohCBS: TPanel
                  Left = 0
                  Top = 135
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 5
                  object lblSohCBS: TLabel
                    Left = 27
                    Top = 9
                    Width = 50
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total CBS:'
                  end
                  object edtSohCBS: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohIBS: TPanel
                  Left = 0
                  Top = 162
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 6
                  object lblSohIBS: TLabel
                    Left = 30
                    Top = 9
                    Width = 47
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total IBS:'
                  end
                  object edtSohIBS: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlSohIS: TPanel
                  Left = 0
                  Top = 189
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 7
                  object lblSohIS: TLabel
                    Left = 36
                    Top = 9
                    Width = 41
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total IS:'
                  end
                  object edtSohIS: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlTotSer: TPanel
                  Left = 0
                  Top = 216
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 8
                  object lblTotSer: TLabel
                    Left = 6
                    Top = 9
                    Width = 71
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total Servi'#231'os:'
                  end
                  object edtTotSer: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    Color = 16768952
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
                    NormalColor = 16768952
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 0
                    TipoTexto = ttAlfanumerico
                  end
                end
                object pnlTotImp: TPanel
                  Left = 0
                  Top = 243
                  Width = 166
                  Height = 27
                  BevelOuter = bvNone
                  TabOrder = 9
                  object lblTotImp: TLabel
                    Left = 12
                    Top = 9
                    Width = 65
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'Total Geral:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object edtTotImp: TEditFocus
                    Left = 80
                    Top = 5
                    Width = 78
                    Height = 21
                    TabStop = False
                    Alignment = taRightJustify
                    AutoSize = False
                    Color = 16768952
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clRed
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Pitch = fpVariable
                    Font.Style = [fsBold]
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    ParentFont = False
                    ReadOnly = True
                    TabOrder = 0
                    Text = '0,00'
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
            end
          end
          object pnlGrupoSimilares: TPanel
            Left = 0
            Top = 0
            Width = 487
            Height = 255
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pnlGrupoSimilares'
            ParentColor = True
            ShowCaption = False
            TabOrder = 2
            object spltGrupoSimilares: TSplitter
              Left = 299
              Top = 0
              Height = 139
              Align = alRight
              ExplicitLeft = 48
              ExplicitTop = 104
              ExplicitHeight = 100
            end
            object pnlGrupoVeiculos: TPanel
              Left = 0
              Top = 139
              Width = 487
              Height = 116
              Align = alBottom
              BevelOuter = bvNone
              Caption = 'pnlGrupoVeiculos'
              ParentColor = True
              ShowCaption = False
              TabOrder = 0
              object pnlVeiculos_Embalagens: TPanel
                Left = 87
                Top = 0
                Width = 257
                Height = 116
                Align = alClient
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 0
                object pnlEmbFec: TPanel
                  Left = 0
                  Top = 0
                  Width = 257
                  Height = 116
                  Align = alLeft
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  object lblIteEmb: TLabel
                    Left = 0
                    Top = 0
                    Width = 257
                    Height = 12
                    Align = alTop
                    Alignment = taCenter
                    AutoSize = False
                    Caption = 'EMBALAGEM FECHADA'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    ParentFont = False
                    ExplicitWidth = 253
                  end
                  object cxgIteEmb: TcxGridCitel
                    Left = 0
                    Top = 12
                    Width = 257
                    Height = 104
                    Align = alClient
                    TabOrder = 0
                    TabStop = False
                    OnEnter = cxgIteEmbEnter
                    OnExit = cxgIteEmbExit
                    LookAndFeel.ScrollbarMode = sbmClassic
                    object cxgIteEmbTableView: TcxGridDBTableViewCitel
                      OnKeyDown = cxvSaldosKeyDown
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
                      OptionsSelection.CellSelect = False
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
                        Width = 62
                      end
                    end
                    object cxgIteEmbLevel: TcxGridLevel
                      GridView = cxgIteEmbTableView
                    end
                  end
                end
                object pnlIteVeiculo: TPanel
                  Left = 257
                  Top = 0
                  Width = 0
                  Height = 116
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 1
                  object Label1: TLabel
                    Left = 0
                    Top = 0
                    Width = 0
                    Height = 15
                    Align = alTop
                    Alignment = taCenter
                    AutoSize = False
                    Caption = 'VE'#205'CULOS'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Layout = tlCenter
                    ExplicitWidth = 259
                  end
                  object cxVeiculos: TcxGridCitel
                    Left = 0
                    Top = 15
                    Width = 0
                    Height = 101
                    Align = alClient
                    TabOrder = 0
                    TabStop = False
                    OnEnter = cxgIteEmbEnter
                    OnExit = cxgIteEmbExit
                    LookAndFeel.ScrollbarMode = sbmClassic
                    object cxVeiculosDB: TcxGridDBTableViewCitel
                      OnKeyDown = cxvSaldosKeyDown
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
                      OptionsSelection.CellSelect = False
                      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                      OptionsView.GroupByBox = False
                      Zebra = False
                      Destaque = False
                      CorZebra = clMoneyGreen
                      object cxVeiculosMARCA: TcxGridDBColumn
                        Caption = 'Marca'
                        DataBinding.FieldName = 'MAR_DESMAR'
                        Width = 99
                      end
                      object cxVeiculoMODELO: TcxGridDBColumn
                        Caption = 'Modelo'
                        DataBinding.FieldName = 'MOD_DESMOD'
                        Width = 69
                      end
                      object cxVeiculosANOINI: TcxGridDBColumn
                        Caption = 'Inicio'
                        DataBinding.FieldName = 'MOD_ANOINI'
                      end
                      object cxVeiculosANOFIM: TcxGridDBColumn
                        Caption = 'Fim'
                        DataBinding.FieldName = 'MOD_ANOFIN'
                      end
                      object cxVeiculosVALVUL: TcxGridDBColumn
                        Caption = 'V'#225'lvula'
                        DataBinding.FieldName = 'MOD_VALVUL'
                      end
                      object cxVeiculosCILIND: TcxGridDBColumn
                        Caption = 'Cilindrada'
                        DataBinding.FieldName = 'MOD_CILIND'
                      end
                      object cxVeiculosPOTENC: TcxGridDBColumn
                        Caption = 'Pot'#234'ncia'
                        DataBinding.FieldName = 'MOD_POTENC'
                      end
                      object cxVeiculosCOMBUST: TcxGridDBColumn
                        Caption = 'Combust'#237'vel'
                        DataBinding.FieldName = 'MOD_COMBUS'
                      end
                      object cxVeiculosOBSERV: TcxGridDBColumn
                        Caption = 'Observa'#231#245'es'
                        DataBinding.FieldName = 'VEI_OBSERV'
                        Width = 81
                      end
                    end
                    object cxVeiculosLevel: TcxGridLevel
                      GridView = cxVeiculosDB
                    end
                  end
                end
              end
              object Panel3: TPanel
                Left = 0
                Top = 0
                Width = 87
                Height = 116
                Align = alLeft
                BevelOuter = bvNone
                Caption = 'pnlBotoes'
                ShowCaption = False
                TabOrder = 1
                object lblLegendas: TLabel
                  Left = 0
                  Top = 63
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
                object btnPopup: TBitBtnLocked
                  Left = 0
                  Top = 19
                  Width = 83
                  Height = 25
                  Caption = '&Menu'
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000070000
                    000B0000000C0000000C0000000C0000000C0000000C0000000C0000000D0000
                    000D0000000D0000000D0000000D0000000D0000000C0000000882594DBEB47C
                    6AFFB37C69FFB37B6AFFB37B69FFB37B68FFB37B68FFB37A69FFB37A68FFB37A
                    68FFB37A68FFB27968FFB37967FFB27967FFB27967FF7F574ABFB67F6DFFE7D3
                    CCFFE6D3CCFFE6D2CAFFE5D0C9FFE4D0C9FFE4CEC7FFE3CDC6FFE2CCC5FFE2CB
                    C4FFE1CAC2FFE0CAC2FFE0C8C1FFE0C8C0FFDFC7BFFFB37B69FFB78170FFE8D6
                    CFFFDFC6BDFFDFC5BCFFDEC5BBFFDEC4BBFFDDC3BAFFDDC2B9FFDCC2B9FFDCC1
                    B8FFDBC1B8FFDBC0B7FFDABFB6FFDABFB6FFE0C9C1FFB57D6BFFBA8472FFD6B5
                    A9FFC69B8CFFC69A8CFFC69A8BFFC6998BFFC5998AFFC6998AFFC5998AFFC599
                    8AFFC5998AFFC5998AFFC5998AFFC5988AFFD0AA9EFFB7806EFFBB8776FFFCFA
                    F8FFFBF7F5FFFCF7F5FFFBF7F5FFFCF7F5FFFCF7F4FFFBF7F5FFFBF7F5FFFCF7
                    F5FFFCF7F5FFFBF7F4FFFBF7F4FFFBF7F4FFFCF9F6FFB88371FFBD8A79FFFDFA
                    F8FFFCF8F5FFFCF8F5FFFCF7F6FFFCF8F5FFFBF8F5FFFCF8F5FFFCF7F5FFFCF8
                    F5FFFBF7F5FFFCF7F5FFFCF8F5FFFBF7F5FFFCF9F7FFBA8574FFC08E7CFFDDBF
                    B5FFCBA294FFCBA294FFCBA294FFCBA293FFCBA294FFCAA193FFCAA193FFCAA1
                    92FFCAA092FFCAA092FFCA9F92FFCA9F91FFD7B4A9FFBC8977FFC29180FFEEDF
                    D9FFE3CCC4FFE3CCC3FFE2CBC3FFE2CAC2FFE2CAC1FFE1C9C1FFE1C9C0FFE0C8
                    BFFFE0C7BEFFDFC7BEFFDFC6BDFFDFC5BDFFE7D3CDFFBF8C7AFFC49483FFEEE0
                    DAFFE4CDC5FFE4CDC4FFE3CDC4FFE3CCC3FFE3CBC2FFE2CAC2FFE2CAC1FFE1C9
                    C1FFE1C8C0FFE1C8BFFFE0C7BFFFDFC7BEFFE8D6CFFFC18F7EFFC79786FFE3CA
                    C0FFD1AB9CFFD1AB9CFFD1AA9CFFD0A99BFFD0AA9CFFD0A99BFFD0A99BFFCFA8
                    9BFFCFA89AFFCFA89AFFCFA79AFFCEA799FFDCBFB5FFC39281FFC99A8AFFFEFC
                    FBFFFDFAF9FFFCFAF8FFFCFAF9FFFDFAF8FFFCFAF9FFFDFAF8FFFDFAF8FFFDF9
                    F8FFFDFAF8FFFCF9F8FFFCFAF8FFFDF9F8FFFEFBFAFFC59685FFCB9D8DFFFEFC
                    FCFFFEFDFCFFFEFDFCFFFEFCFCFFFEFCFBFFFEFCFBFFFEFCFBFFFEFCFBFFFEFC
                    FBFFFEFCFBFFFEFBFBFFFEFBFBFFFEFBFBFFFEFBFBFFC79988FF97766ABECC9F
                    8FFFCCA08FFFCC9F8FFFCC9E8EFFCC9E8EFFCB9E8EFFCB9E8EFFCB9E8DFFCB9D
                    8DFFCA9D8DFFCA9C8CFFCB9D8CFFCA9C8CFFCA9C8BFF967367BF000000010000
                    0002000000020000000200000002000000020000000200000002000000020000
                    0003000000030000000300000003000000030000000300000002}
                  TabOrder = 0
                  OnClick = btnPopupClick
                end
              end
              object pnlFoto: TPanel
                Left = 344
                Top = 0
                Width = 143
                Height = 116
                Align = alRight
                BevelOuter = bvNone
                Caption = 'pnlFoto'
                ShowCaption = False
                TabOrder = 2
                object pnlImgPro: TPanel
                  Left = 1
                  Top = 15
                  Width = 144
                  Height = 101
                  BevelInner = bvLowered
                  BorderWidth = 2
                  BorderStyle = bsSingle
                  Color = clWhite
                  ParentBackground = False
                  TabOrder = 0
                  object imgPro: TImage
                    Left = 4
                    Top = 4
                    Width = 132
                    Height = 89
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
                    Height = 89
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
              end
            end
            object pnlSimilares: TPanel
              Left = 0
              Top = 0
              Width = 299
              Height = 139
              Align = alClient
              BevelOuter = bvNone
              Caption = 'pnlSimilares'
              ParentColor = True
              TabOrder = 1
              object cxgSimilares: TcxGrid
                Left = 0
                Top = 0
                Width = 299
                Height = 139
                Align = alClient
                TabOrder = 0
                OnEnter = cxgSimilaresEnter
                OnExit = cxgSimilaresExit
                LookAndFeel.ScrollbarMode = sbmClassic
                object cxvSilimares: TcxGridDBBandedTableView
                  OnKeyDown = cxvSilimaresKeyDown
                  Navigator.Buttons.CustomButtons = <>
                  OnCellClick = cxvSilimaresCellClick
                  OnCustomDrawCell = cxvSilimaresCustomDrawCell
                  DataController.DataSource = dtsSimilares
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsSelection.CellSelect = False
                  OptionsView.NoDataToDisplayInfoText = '<Nenhum similar encontrado>'
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GroupByBox = False
                  Bands = <
                    item
                      Caption = 'Produtos Similares'
                    end>
                  object cxvSimilaresCODITE: TcxGridDBBandedColumn
                    Caption = 'C'#243'digo'
                    DataBinding.FieldName = 'CODITE'
                    HeaderAlignmentHorz = taCenter
                    Options.Focusing = False
                    Options.AutoWidthSizable = False
                    Styles.Content = cxsSaldos
                    Width = 39
                    Position.BandIndex = 0
                    Position.ColIndex = 1
                    Position.RowIndex = 0
                  end
                  object cxvSimilaresDESITE: TcxGridDBBandedColumn
                    Caption = 'Descri'#231#227'o'
                    DataBinding.FieldName = 'DESITE'
                    GroupSummaryAlignment = taRightJustify
                    Width = 72
                    Position.BandIndex = 0
                    Position.ColIndex = 2
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresSIGUNI: TcxGridDBBandedColumn
                    Caption = 'Unid.'
                    DataBinding.FieldName = 'SIGUNI'
                    HeaderAlignmentHorz = taCenter
                    Options.AutoWidthSizable = False
                    Width = 46
                    Position.BandIndex = 0
                    Position.ColIndex = 3
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresPREVEN: TcxGridDBBandedColumn
                    Caption = 'Pre'#231'o Venda'
                    DataBinding.FieldName = 'PREVEN'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.DisplayFormat = ',0.00;-,0.00'
                    GroupSummaryAlignment = taRightJustify
                    HeaderAlignmentHorz = taCenter
                    Options.AutoWidthSizable = False
                    Width = 90
                    Position.BandIndex = 0
                    Position.ColIndex = 7
                    Position.RowIndex = 0
                  end
                  object cxvSimilaresSALDIS: TcxGridDBBandedColumn
                    Caption = 'Saldo Dispon'#237'vel'
                    DataBinding.FieldName = 'SALDIS'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.DecimalPlaces = 3
                    Properties.DisplayFormat = ',0.000;-,0.000'
                    HeaderAlignmentHorz = taCenter
                    Options.AutoWidthSizable = False
                    Width = 90
                    Position.BandIndex = 0
                    Position.ColIndex = 8
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresREFERE: TcxGridDBBandedColumn
                    Caption = 'Refer'#234'ncia'
                    DataBinding.FieldName = 'REFERE'
                    Width = 50
                    Position.BandIndex = 0
                    Position.ColIndex = 6
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresTAB: TcxGridDBBandedColumn
                    Caption = 'TAB'
                    DataBinding.FieldName = 'VENDIDO'
                    PropertiesClassName = 'TcxImageComboBoxProperties'
                    Properties.Images = imglImageList
                    Properties.Items = <
                      item
                        ImageIndex = 0
                        Value = 0
                      end
                      item
                        ImageIndex = 1
                        Value = 1
                      end>
                    Options.Editing = False
                    Options.Filtering = False
                    Options.Focusing = False
                    Options.AutoWidthSizable = False
                    Options.Moving = False
                    Options.Sorting = False
                    Width = 25
                    Position.BandIndex = 0
                    Position.ColIndex = 0
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresDESMAR: TcxGridDBBandedColumn
                    Caption = 'Marca'
                    DataBinding.FieldName = 'DESMAR'
                    Width = 47
                    Position.BandIndex = 0
                    Position.ColIndex = 4
                    Position.RowIndex = 0
                  end
                  object cxvSilimaresFABRIC: TcxGridDBBandedColumn
                    Caption = 'C'#243'd. F'#225'brica'
                    DataBinding.FieldName = 'FABRIC'
                    Width = 79
                    Position.BandIndex = 0
                    Position.ColIndex = 5
                    Position.RowIndex = 0
                  end
                end
                object cxGridLevel1: TcxGridLevel
                  GridView = cxvSilimares
                end
              end
            end
            object pnlEstrutura: TPanel
              Left = 302
              Top = 0
              Width = 185
              Height = 139
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 2
            end
          end
        end
      end
      object pnlTopMeio: TPanel
        Left = 1
        Top = 1
        Width = 1173
        Height = 4
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlTopMeio'
        ParentColor = True
        ShowCaption = False
        TabOrder = 3
      end
    end
  end
  object dtsConsulta: TDataSource
    Left = 192
    Top = 16
  end
  object cxsGrid: TcxStyleRepository
    Left = 392
    Top = 128
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
  object popMenu: TPopupMenu
    Left = 632
    Top = 120
    object btnCompCusto: TMenuItem
      Caption = 'Composi'#231#227'o do Custo'
      ShortCut = 16499
      OnClick = btnCompCustoClick
    end
    object btnComSisAnt: TMenuItem
      Caption = 'Compras do Sistema Anterior'
      ShortCut = 32880
      OnClick = btnComSisAntClick
    end
    object btnExiEstrutura: TMenuItem
      Caption = 'Exibir Estrutura'
      ShortCut = 32887
      OnClick = btnExiEstruturaClick
    end
    object btnItensComp: TMenuItem
      Caption = 'Itens Comprados'
      ShortCut = 121
      OnClick = btnItensCompClick
    end
    object btnItensVend: TMenuItem
      Caption = 'Itens Vendidos'
      ShortCut = 120
      OnClick = btnItensVendClick
    end
    object btnFichaKardex: TMenuItem
      Caption = 'Kardex'
      ShortCut = 119
      OnClick = btnFichaKardexClick
    end
    object btnOrcamentos: TMenuItem
      Caption = 'Or'#231'amentos'
      ShortCut = 32889
      OnClick = btnOrcamentosClick
    end
    object btnMostraPrecoVenda: TMenuItem
      Caption = '&Pre'#231'o Venda das Lojas'
      ShortCut = 117
      OnClick = btnMostraPrecoVendaClick
    end
    object btnSepIte: TMenuItem
      Caption = 'Separa'#231#227'o Item'
      ShortCut = 32884
      OnClick = btnSepIteClick
    end
    object ransfEstoqueemAndamento1: TMenuItem
      Caption = 'Transf. Estoque em Andamento'
      ShortCut = 32891
      OnClick = ransfEstoqueemAndamento1Click
    end
    object btnConsVendasPerdidas: TMenuItem
      Caption = 'Vendas Perdidas'
      ShortCut = 116
      OnClick = btnConsVendasPerdidasClick
    end
    object btnVendasPerdidas: TMenuItem
      Caption = 'Vendas Perdidas - Incluir'
      ShortCut = 122
      OnClick = btnVendasPerdidasClick
    end
    object btnVedasSisAnt: TMenuItem
      Caption = 'Vendas do Sistema Anterior'
      ShortCut = 32881
      OnClick = btnVedasSisAntClick
    end
    object btnAlterarModoTAB: TMenuItem
      Caption = 'Alterar para TAB modo Completo'
      ShortCut = 113
      OnClick = btnAlterarModoTABClick
    end
    object btnLotIte: TMenuItem
      Caption = 'Lotes do Item'
      ShortCut = 32885
      OnClick = btnLotIteClick
    end
    object mnuCadArmazem: TMenuItem
      Caption = 'Cadastro de Armaz'#233'm'
      OnClick = mnuCadArmazemClick
    end
    object mnuCadSimilaridade: TMenuItem
      Caption = 'Cadastro de Similaridade'
      OnClick = mnuCadSimilaridadeClick
    end
    object mnuAgregados: TMenuItem
      Caption = 'A&gregados'
      ShortCut = 32886
      OnClick = mnuAgregadosClick
    end
    object mnuSimilar: TMenuItem
      Caption = 'Similar'
      OnClick = mnuSimilarClick
    end
    object ChecklistDevoluoGarantia1: TMenuItem
      Caption = 'Checklist Devolu'#231#227'o/Garantia'
      object GarantiadeMercadoria1: TMenuItem
        Caption = 'Garantia de Mercadoria'
        OnClick = GarantiadeMercadoria1Click
      end
      object rocadeMercadoria1: TMenuItem
        Caption = 'Troca de Mercadoria'
        OnClick = rocadeMercadoria1Click
      end
    end
    object mnuEstVendaForaEstab: TMenuItem
      Caption = 'Estoque de Venda fora do Estabelecimento'
      OnClick = mnuEstVendaForaEstabClick
    end
    object mnuSolicitarRequisicaodeCompras: TMenuItem
      Caption = 'Solicitar &Requisi'#231#227'o de Compras '
      ShortCut = 32850
      OnClick = mnuSolicitarRequisicaodeComprasClick
    end
    object mnuSemelhantes: TMenuItem
      Caption = 'Semelhantes'
      ShortCut = 118
      OnClick = mnuSemelhantesClick
    end
    object mnuNotasFiscaisAssociadasEmAberto: TMenuItem
      Caption = 'Notas Fiscais Associadas - Em Aberto'
      OnClick = mnuNotasFiscaisAssociadasEmAbertoClick
    end
    object mnuConsultaBalcao: TMenuItem
      Caption = 'Consulta Fornec. Balc'#227'o'
      OnClick = mnuConsultaBalcaoClick
    end
    object mnuPedCompGrid: TMenuItem
      Caption = 'Ped. Compra (Grid)'
      ShortCut = 123
      OnClick = mnuPedCompGridClick
    end
  end
  object popSaldos: TPopupMenu
    OnPopup = popSaldosPopup
    Left = 206
    Top = 136
    object mnuConfigRel: TMenuItem
      Tag = 199
      Caption = 'Configura o relat'#243'rio chamado pelo bot'#227'o'
      OnClick = mnuConfigRelClick
    end
  end
  object dtsSalLoj: TDataSource
    Left = 440
    Top = 137
  end
  object dtsSimilares: TDataSource
    Left = 704
    Top = 128
  end
  object AppEvents: TApplicationEvents
    OnMessage = AppEventsMessage
    Left = 332
    Top = 144
  end
  object imglImageList: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 668
    Top = 120
    Bitmap = {
      494C010102000500040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000020000
      000A05020138301A0D946A391FD1874925EA854626E866381ED02F190C930301
      0030000000090000000100000000000000000000000000000000000000000000
      0002000000070000000C0000001000000012000000110000000E000000080000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000300000011341C
      0F97A65E37FAC58956FFD6A36CFFDDAF74FFDDAF73FFD6A46AFFC58955FF9C5B
      34F51A0E08730000000F00000003000000000000000000000001000000040000
      001206130D79113C29C6206A4AFF206A4AFF206B4AFF15432FD2071811840000
      0015000000050000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000010532E1BB9BC7B
      4CFFDDAE76FFDEB075FFDEAF74FFDEAF74FFDEB073FFDDAF74FFDEAF73FFDBAB
      71FFBD7D4DFF4E2B18B50000001000000002000000000000000501030235184E
      37DC23805BFF28AC7DFF2BC592FF2CC894FF2CC693FF29AE80FF24855FFF1547
      32D40104023D0000000700000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000008351F1295BE8052FFE0B3
      7BFFDFB075FFDEB176FFDFB278FFE0B378FFE0B279FFE0B278FFDFB278FFDFB2
      76FFDEB076FFC08252FF301C10920000000A00000003000201311D5C42ED289D
      73FF2EC896FF2DC996FF55D4ACFF67DAB5FF3ACD9DFF2FC996FF31CA99FF2AA4
      78FF1F6C4DF80104023D00000005000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000004020132AB6D45FADFB27CFFDFB2
      79FFE0B37AFFE0B57CFFE1B67DFFE2B67EFFE2B77EFFE2B77EFFE2B67DFFE0B4
      7BFFE0B47AFFDEB078FFAF6F48FB0302012F0000000A144530D02DA57BFF32CA
      99FF2DC896FF4BD2A8FF1F835BFF00663AFF44BE96FF30CB99FF30CB98FF33CC
      9CFF30AD83FF154B35D300000013000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000038221695CD9B6EFFE2B780FFE5BD
      89FFE7C291FFE8C393FFE8C494FFE8C594FFE8C495FFE8C495FFE8C494FFE8C3
      93FFE5BF8CFFE1B77EFFD09C6DFF2D1C118B040C085E2D8A65FF3ACD9EFF2FCA
      97FF4AD3A9FF339570FF87AF9DFFB1CFC1FF228A5FFF44D3A8FF35CF9FFF32CD
      9BFF3DD0A3FF30946FFF0718117F000000070000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000794D32D2DCB383FFE3B781FFBA86
      58FFA96F42FFAB7144FFAC7245FFB07849FFAB7144FFAD7446FFB07749FFB179
      4AFFC29161FFE4B983FFDEB17DFF74492FD0113627B63CB38CFF38CD9FFF4AD5
      A9FF42A382FF689782FFF8F1EEFFF9F3EEFF347E5CFF55C4A1FF42D5A8FF3DD3
      A4FF3BD1A4FF40BC95FF154935CD0000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A76D47F2E3BF8FFFE4BB84FFA56A
      3EFFF5EEE9FFFAF6F3FFFAF7F3FFFBF7F4FFFBF7F5FFFAF7F4FFFAF7F3FFFAF6
      F2FFAB7144FFE5BD87FFE5BE8BFF9F6946EE18573CDF4ACAA4FF43D2A8FF4EB3
      92FF4D8269FFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1A744EFF5FDCB8FF47D8
      ACFF46D6AAFF50D4ACFF227655F80000000E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A16C48ECE9C9A0FFE5BE89FFA56A
      3EFFE6D9D2FFE7DBD4FFE9DED7FFEAE0D9FFEAE0DAFFEBE1DBFFEBE0DBFFEEE5
      E1FFAA7043FFE7C08CFFEACA9DFFA26D48EE1E694BF265D9B8FF45D3A8FF0A66
      40FFD2D2CBFF698F76FF106A42FF72967DFFF1E8E3FF71A28BFF45A685FF5DDF
      BAFF4BD9AFFF6AE2C2FF26845FFF000000190000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007D553BD0E9CDACFFEAC796FFB784
      55FFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A3EFFA56A
      3EFFB78456FFEACA99FFEBD1ADFF7F573BD418593EDC77D9BEFF51DAB1FF3CBA
      92FF086840FF2E9C75FF56DEB8FF2C9972FF72967DFFF0EAE7FF4E886BFF59BB
      9AFF5ADEB9FF7EE2C7FF257E5BF80000000C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000402E1F97DDBB9DFFEED3A9FFEECF
      A2FFEED2A5FFF0D6A9FFF1D7ABFFF1D8ADFFF1D8ADFFF1D8ADFFF1D6AAFFF0D5
      A8FFEED2A5FFEFD4A7FFE0C2A2FF36271B8F103626AB76C8B0FF61E0BCFF55DD
      B7FF58DFBAFF5BE1BDFF5DE2BEFF5EE4C1FF278C66FF688E75FFE6E1DCFF166A
      46FF5ED8B4FF83D5BDFF174E3AC6000000090000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000403022BC4916AFCF5E8CCFFEFD6
      ABFFF1D8AEFFF2DAB0FFF3DCB3FFF3DEB4FFF3DEB4FFF3DEB4FFF3DCB2FFF1DB
      B0FFF1D8ADFFF7EACDFFC1906DFA0403022E02080647429C7AFF95ECD6FF59DF
      BAFF5DE2BDFF60E4BFFF63E6C1FF66E6C5FF66E8C7FF38A17DFF1E6C49FF278B
      63FF98EFD9FF4CAC8CFF0616116D000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000033F2E2292D7B08CFFF8EF
      D3FFF3E0B9FFF3DFB7FFF4E1B9FFF5E3BBFFF5E2BBFFF5E2BBFFF4E1B9FFF4E2
      BDFFFAF1D5FFD9B390FF37291D8C0000000600000004134231B577C6ADFF9AEE
      D9FF64E5C0FF63E7C3FF68E7C6FF6AE8C8FF6BE9C9FF6AEAC9FF5DD6B6FF97ED
      D7FF86D3BBFF1C6149D20000000C000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000007684D38B8D9B3
      8FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7ECCAFFF8EED0FFF4E8
      CDFFD7AF8BFF5F4733B30000000B0000000100000001000000181E674DDA6FC1
      A8FFB5F2E3FF98F0DAFF85EDD4FF74EBCEFF88EFD6FF9CF2DDFFBAF4E7FF77CD
      B3FF258362EA0103022E00000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000073E2E
      238FCC9D76FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8B9FFE3C5A3FFBA91
      6CF21E161067000000060000000100000000000000000000000100000017154B
      38B843AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8C1FF4AB692FF1A64
      4CCB000202270000000300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00020504032C392C218983644ACCBA8E69F1B38A67EE83644CCD3A2D228B0202
      0122000000030000000100000000000000000000000000000000000000010000
      0003020906410F3A2B9D1D6B50CF28926EEE1D6E52CF144D3BB004100C560000
      0006000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object popImgPro: TPopupMenu
    Left = 800
    Top = 149
    object mnuEnviarporWhatsapp: TMenuItem
      Caption = 'Enviar por Whatsapp'
      OnClick = mnuEnviarporWhatsappClick
    end
  end
  object dtsSubConsulta: TDataSource
    Left = 264
    Top = 48
  end
end
