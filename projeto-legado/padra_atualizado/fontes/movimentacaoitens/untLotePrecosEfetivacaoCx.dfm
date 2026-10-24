inherited frmLotePrecosEfetivacaoCx: TfrmLotePrecosEfetivacaoCx
  Width = 1211
  Height = 704
  BorderStyle = bsSizeable
  Caption = 'Ativar lote de pre'#231'os da entrada de mercadorias'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitLeft = -288
  ExplicitWidth = 1211
  ExplicitHeight = 704
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 578
    Width = 1195
    Height = 71
    ExplicitTop = 578
    ExplicitWidth = 1195
    ExplicitHeight = 71
    inherited FlwBotoes: TFlowPanel
      Width = 1191
      Height = 67
      ExplicitWidth = 1191
      ExplicitHeight = 67
      inherited btnConfirma: TBitBtnLocked
        Width = 111
        Caption = '[ F10 ] Confirma'
        ModalResult = 0
        ExplicitWidth = 111
      end
      object btnMargemLucroGeral: TBitBtnLocked
        Left = 111
        Top = 0
        Width = 149
        Height = 22
        Caption = '[ F3 ] Margem de lucro geral'
        TabOrder = 1
        OnClick = btnMargemLucroGeralClick
      end
      object btnCompCusto: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 143
        Height = 22
        Caption = '[ F4 ] Composi'#231#227'o do Custo'
        TabOrder = 2
        OnClick = btnCompCustoClick
      end
      object btnMarcarItem: TBitBtnLocked
        Left = 403
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F5 ] Marca/Desmarca Item'
        TabOrder = 3
        OnClick = btnMarcarItemClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 543
        Top = 0
        Width = 114
        Height = 22
        Caption = '[ F6 ] Marcar Todos'
        TabOrder = 4
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 657
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F7 ] Desmarcar Todos'
        TabOrder = 5
        OnClick = btnDesmarcarClick
      end
      object btnOpcPreVen: TBitBtnLocked
        Left = 777
        Top = 0
        Width = 323
        Height = 22
        Caption = '[ F8 ] Op'#231#227'o c'#225'lculo como "Pre'#231'o de venda" para todos os itens'
        TabOrder = 6
        OnClick = btnOpcPreVenClick
      end
      object btnRecalcMargem: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 407
        Height = 22
        Caption = 
          '[ Alt F8 ] Recarrega o pre'#231'o de venda do cadastro e recalcula Ma' +
          'rgem para todos'
        NumGlyphs = 2
        TabOrder = 7
        OnClick = btnRecalcMargemClick
      end
      object btnRecalcPreco: TBitBtnLocked
        Left = 407
        Top = 22
        Width = 406
        Height = 22
        Caption = 
          '[ Alt F9 ] Recarrega a margem do cadastro e recalcula Pre'#231'o de V' +
          'enda para todos'
        NumGlyphs = 2
        TabOrder = 8
        OnClick = btnRecalcPrecoClick
      end
      object btnOpcMargem: TBitBtnLocked
        Left = 813
        Top = 22
        Width = 279
        Height = 22
        Caption = '[ F9 ] Op'#231#227'o c'#225'lculo como "Margem" para todos os itens'
        TabOrder = 9
        OnClick = btnOpcMargemClick
      end
      object btnEspelho: TBitBtnLocked
        Left = 1092
        Top = 22
        Width = 96
        Height = 22
        Caption = '[ F11 ] - Espelho'
        TabOrder = 10
        OnClick = btnEspelhoClick
      end
      object btnCadProduto: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 130
        Height = 22
        Caption = '[ INSERT ] - Cad. Produtos'
        TabOrder = 11
        OnClick = btnCadProdutoClick
      end
      object btnPromocao: TBitBtnLocked
        Left = 130
        Top = 44
        Width = 200
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '[ F12 ] - Visualizar Promo'#231#245'es do Item'
        TabOrder = 12
        OnClick = btnPromocaoClick
      end
      object btnRecalcMargIdeal: TBitBtnLocked
        Left = 330
        Top = 44
        Width = 255
        Height = 22
        Caption = '[ Alt F10 ] Carrega Margem Ideal Na Margem Bruta'
        TabOrder = 13
        OnClick = btnRecalcMargIdealClick
      end
      object btnExpProdutos: TBitBtnLocked
        Left = 585
        Top = 44
        Width = 222
        Height = 22
        Caption = '[ Alt + F11 ] Exportar Produtos Para Excel'
        TabOrder = 14
        OnClick = btnExpProdutosClick
      end
      object btnMarcarPrcRdz: TBitBtnLocked
        Left = 807
        Top = 44
        Width = 278
        Height = 22
        Caption = '[Alt + F12] Marcar Itens com Pre'#231'o de Compra Reduzido'
        TabOrder = 15
        OnClick = btnMarcarPrcRdzClick
      end
      object btnCarPreMedNaPreCom: TBitBtnLocked
        Left = 0
        Top = 66
        Width = 340
        Height = 22
        Caption = '[ Alt + F7 ] - Carregar pre'#231'o m'#233'dio no pre'#231'o de compra do item'
        TabOrder = 16
        OnClick = btnCarPreMedNaPreComClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1115
      Top = 46
      Width = 78
      Height = 23
      Cancel = False
      ExplicitLeft = 1115
      ExplicitTop = 46
      ExplicitWidth = 78
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 649
    Width = 1195
    ExplicitTop = 649
    ExplicitWidth = 1195
    inherited pnlNomeForm: TPanel
      Left = 1024
      ExplicitLeft = 1024
    end
    inherited pnlInfo: TPanel
      Width = 1024
      ExplicitWidth = 1024
    end
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 0
    Width = 1195
    Height = 568
    Align = alClient
    Caption = 'Panel3'
    ParentColor = True
    TabOrder = 3
    object splPrecos: TSplitter
      Left = 1
      Top = 219
      Width = 1193
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Beveled = True
      Color = clYellow
      MinSize = 20
      ParentColor = False
      ResizeStyle = rsNone
      ExplicitLeft = 0
      ExplicitTop = 180
      ExplicitWidth = 1346
    end
    object pnlTail: TPanel
      Left = 1
      Top = 224
      Width = 1193
      Height = 343
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1002
        Height = 343
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object pnlTitPrecos: TPanel
          Left = 1
          Top = 1
          Width = 1000
          Height = 24
          Align = alTop
          Caption = 'PRE'#199'OS DO PRODUTO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBackground = False
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          object Label12: TLabel
            Left = 5
            Top = 4
            Width = 51
            Height = 14
            Caption = 'Qtd. Grid:'
          end
          object edtQtdGrid: TComboBox
            Left = 58
            Top = 1
            Width = 35
            Height = 22
            Style = csOwnerDrawFixed
            ItemIndex = 0
            TabOrder = 0
            Text = '1'
            OnChange = edtQtdGridChange
            Items.Strings = (
              '1'
              '2'
              '3')
          end
        end
        object ScrollBox1: TScrollBox
          Left = 1
          Top = 25
          Width = 1000
          Height = 317
          Align = alClient
          ParentBackground = True
          TabOrder = 1
          object dbgPrecos: TDBGridCitel
            Left = 0
            Top = 0
            Width = 729
            Height = 296
            Align = alLeft
            DataSource = dtsPrecos
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnDrawColumnCell = dbgPrecosDrawColumnCell
            OnEnter = dbgPrecosEnter
            OnExit = dbgPrecos3Exit
            OnKeyDown = dbgPrecosKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'DESCRI'
                Title.Caption = 'Descri'#231#227'o'
                Width = 219
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'VALANT'
                Title.Alignment = taRightJustify
                Title.Caption = 'Valor Anterior'
                Width = 120
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'VALATU'
                Title.Alignment = taRightJustify
                Title.Caption = 'Valor Atual'
                Width = 120
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'CAMALT'
                Title.Alignment = taCenter
                Title.Caption = 'Alt?'
                Width = 26
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UTILIZ'
                Title.Caption = 'Utiliza'
                Width = 34
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EMBANT'
                Title.Caption = 'Valor Ant.Emb.'
                Width = 87
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EMBATU'
                Title.Caption = 'Valor Atual Emb'
                Width = 92
                Visible = True
              end>
          end
          object pnlSep2: TPanel
            Left = 1465
            Top = 0
            Width = 688
            Height = 296
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object dbgPrecos3: TDBGridCitel
              Left = 0
              Top = 0
              Width = 693
              Height = 296
              Align = alLeft
              DataSource = dtsPrecos3
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = 14
              TitleFont.Name = 'Arial'
              TitleFont.Pitch = fpVariable
              TitleFont.Style = []
              Visible = False
              OnDrawColumnCell = dbgPrecosDrawColumnCell
              OnEnter = dbgPrecosEnter
              OnExit = dbgPrecos3Exit
              OnKeyDown = dbgPrecosKeyDown
              CorZebra = clMoneyGreen
              Zebra = False
              DestacarMouse = False
              Columns = <
                item
                  Expanded = False
                  FieldName = 'DESCRI'
                  Title.Caption = 'Descri'#231#227'o'
                  Width = 188
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALANT'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor Anterior'
                  Width = 120
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALATU'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor Atual'
                  Width = 120
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'CAMALT'
                  Title.Alignment = taCenter
                  Title.Caption = 'Alt?'
                  Width = 26
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UTILIZ'
                  Title.Caption = 'Utiliza'
                  Width = 34
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EMBANT'
                  Title.Caption = 'Valor Ant.Emb.'
                  Width = 87
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EMBATU'
                  Title.Caption = 'Valor Atual Emb'
                  Width = 92
                  Visible = True
                end>
            end
          end
          object pnlSep1: TPanel
            Left = 729
            Top = 0
            Width = 736
            Height = 296
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object dbgPrecos2: TDBGridCitel
              Left = 0
              Top = 0
              Width = 736
              Height = 296
              Align = alClient
              DataSource = dtsPrecos2
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = 14
              TitleFont.Name = 'Arial'
              TitleFont.Pitch = fpVariable
              TitleFont.Style = []
              Visible = False
              OnDrawColumnCell = dbgPrecosDrawColumnCell
              OnEnter = dbgPrecosEnter
              OnExit = dbgPrecos3Exit
              OnKeyDown = dbgPrecosKeyDown
              CorZebra = clMoneyGreen
              Zebra = False
              DestacarMouse = False
              Columns = <
                item
                  Expanded = False
                  FieldName = 'DESCRI'
                  Title.Caption = 'Descri'#231#227'o'
                  Width = 219
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALANT'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor Anterior'
                  Width = 120
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALATU'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor Atual'
                  Width = 120
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'CAMALT'
                  Title.Alignment = taCenter
                  Title.Caption = 'Alt?'
                  Width = 26
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UTILIZ'
                  Title.Caption = 'Utiliza'
                  Width = 35
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EMBANT'
                  Title.Caption = 'Valor Ant.Emb.'
                  Width = 87
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EMBATU'
                  Title.Caption = 'Valor Atual Emb'
                  Width = 92
                  Visible = True
                end>
            end
          end
        end
      end
      object pnlLegendas: TPanel
        Left = 1002
        Top = 0
        Width = 191
        Height = 343
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        BorderWidth = 7
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object pnlDock: TPanel
          Left = 8
          Top = -2
          Width = 175
          Height = 337
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object Label13: TLabel
            Left = 0
            Top = 31
            Width = 175
            Height = 56
            Align = alBottom
            Alignment = taCenter
            Caption = 
              'Para alterar o Pre'#231'o de Venda ou a Margem de Lucro Pressione [En' +
              'ter] sobre o campo.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 165
          end
          object Label11: TLabel
            Left = 0
            Top = 87
            Width = 175
            Height = 42
            Align = alBottom
            Alignment = taCenter
            Caption = 
              'Para marcar ou desmarcar o campo "Utiliza" pressionar o [Espa'#231'o]' +
              ' sobre a linha'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 159
          end
          object lblPromocao: TLabel
            Left = 0
            Top = 0
            Width = 175
            Height = 14
            Align = alTop
            Alignment = taCenter
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 3
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 251
            Width = 175
            Height = 86
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alBottom
            Caption = 'Legenda:'
            TabOrder = 0
            object Label7: TLabel
              Left = 30
              Top = 42
              Width = 88
              Height = 14
              Caption = 'Campos Alterados'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Shape1: TShape
              Left = 12
              Top = 41
              Width = 15
              Height = 15
              Brush.Color = clRed
            end
            object Label8: TLabel
              Left = 30
              Top = 22
              Width = 65
              Height = 14
              Caption = 'Selecionados'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Shape2: TShape
              Left = 12
              Top = 21
              Width = 15
              Height = 15
              Brush.Color = clAqua
            end
            object Shape3: TShape
              Left = 12
              Top = 61
              Width = 15
              Height = 15
              Brush.Color = clPurple
            end
            object Label14: TLabel
              Left = 30
              Top = 62
              Width = 66
              Height = 14
              Caption = 'Item Estrutura'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 162
            Width = 175
            Height = 89
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alBottom
            Caption = 'Informa'#231#245'es:'
            TabOrder = 1
            object Label9: TLabel
              Left = 12
              Top = 59
              Width = 74
              Height = 14
              Caption = 'Total Registros:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label10: TLabel
              Left = 19
              Top = 31
              Width = 68
              Height = 14
              Caption = 'Selecionados:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtQtdSel: TEditFocus
              Left = 89
              Top = 23
              Width = 46
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
            object edtQtdReg: TEditFocus
              Left = 89
              Top = 51
              Width = 46
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
          end
          object pnlArrMai: TPanel
            Left = 0
            Top = 129
            Width = 175
            Height = 33
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            object edtDecUni: TEditFocus
              Tag = 99
              Left = 156
              Top = 7
              Width = 19
              Height = 22
              Alignment = taLeftJustify
              TabOrder = 0
              Text = '0'
              OnKeyPress = edtDecUniKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttInteiro
            end
            object chkArrMai: TCheckBox
              Left = 1
              Top = 10
              Width = 155
              Height = 17
              Caption = 'Arredondar Casas Decimais'
              TabOrder = 1
              OnClick = chkArrMaiClick
            end
          end
        end
      end
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 1193
      Height = 218
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlGridItens: TPanel
        Left = 0
        Top = 90
        Width = 1193
        Height = 128
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 0
        object cxgItens: TcxGrid
          Left = 0
          Top = 0
          Width = 1193
          Height = 128
          Align = alClient
          TabOrder = 0
          OnEnter = cxgItensEnter
          OnExit = cxgItensExit
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxbItens: TcxGridDBBandedTableView
            OnKeyDown = cxbItensKeyDown
            OnKeyUp = cxbItensKeyUp
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxbItensCustomDrawCell
            OnEditKeyDown = cxbItensEditKeyDown
            OnEditKeyPress = cxbItensEditKeyPress
            DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracImmediately
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsSelection.HideFocusRectOnExit = False
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum item selecionado>'
            OptionsView.GroupByBox = False
            Bands = <
              item
                Caption = 'Informa'#231#245'es b'#225'sicas'
                FixedKind = fkLeft
                Width = 629
              end
              item
                Caption = 'Dados complementares'
                Width = 840
              end
              item
                Caption = 'Pre'#231'o de Custo'
                Width = 254
              end
              item
                Caption = 'Pre'#231'o de Custo Real'
              end
              item
                Caption = 'Tabela 1'
                Width = 545
              end
              item
                Caption = 'Tabela 2'
                Width = 545
              end
              item
                Caption = 'Tabela 3'
                Width = 545
              end
              item
                Caption = 'Tabela 4'
                Width = 545
              end
              item
                Caption = 'Tabela 5'
                Width = 545
              end
              item
                Caption = 'Tabela 6'
                Width = 545
              end
              item
                Caption = 'Tabela 7'
                Width = 545
              end
              item
                Caption = 'Margem ideal e Pre'#231'o Ideal'
                Width = 1070
              end
              item
                Caption = 'Pre'#231'o M'#233'dio'
              end>
            OnBandPosChanged = cxbItensBandPosChanged
            object cxbItensAUTOINCREM: TcxGridDBBandedColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              Position.BandIndex = 10
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensCODITE: TcxGridDBBandedColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'ITE_CODITE'
              Options.Editing = False
              Width = 56
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensColumn2: TcxGridDBBandedColumn
              Caption = 'C'#243'digo de F'#225'brica'
              DataBinding.FieldName = 'ITE_CODFAB'
              Options.Editing = False
              Width = 105
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensColumn3: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'ITE_DESCRI'
              Options.Editing = False
              Width = 188
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensITEGRU: TcxGridDBBandedColumn
              Caption = 'Linha/Grupo'
              DataBinding.FieldName = 'DES_LINGRU'
              Options.Editing = False
              Width = 122
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensMAR_DESMAR: TcxGridDBBandedColumn
              Caption = 'Marca'
              DataBinding.FieldName = 'ITE_DESMAR'
              Options.Editing = False
              Width = 79
              Position.BandIndex = 0
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDEP_DESCRI: TcxGridDBBandedColumn
              Caption = 'Departamento'
              DataBinding.FieldName = 'ITE_DESDEP'
              Options.Editing = False
              Width = 79
              Position.BandIndex = 0
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensColumn4: TcxGridDBBandedColumn
              Caption = 'Refer'#234'ncia'
              DataBinding.FieldName = 'ITE_REFERE'
              Options.Editing = False
              Width = 36
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensColumn5: TcxGridDBBandedColumn
              Caption = 'Total ST'
              DataBinding.FieldName = 'ITE_VALRET'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 33
              Position.BandIndex = 1
              Position.ColIndex = 14
              Position.RowIndex = 0
            end
            object cxbItensColumn6: TcxGridDBBandedColumn
              Caption = 'Total IPI'
              DataBinding.FieldName = 'ITE_VALIPI'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 34
              Position.BandIndex = 1
              Position.ColIndex = 13
              Position.RowIndex = 0
            end
            object cxbItensColumn7: TcxGridDBBandedColumn
              Caption = 'Valor Total'
              DataBinding.FieldName = 'ITE_TOTITE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 36
              Position.BandIndex = 1
              Position.ColIndex = 12
              Position.RowIndex = 0
            end
            object cxbItensITE_UNITAR: TcxGridDBBandedColumn
              Caption = 'Vlr. Unit'#225'rio'
              DataBinding.FieldName = 'ITE_UNITAR'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 34
              Position.BandIndex = 1
              Position.ColIndex = 11
              Position.RowIndex = 0
            end
            object cxbQuantidade: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'ITE_QTDITE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 34
              Position.BandIndex = 1
              Position.ColIndex = 10
              Position.RowIndex = 0
            end
            object cxbItensColumn10: TcxGridDBBandedColumn
              Caption = 'Unid'
              DataBinding.FieldName = 'ITE_SIGUNI'
              Options.Editing = False
              Width = 20
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PRECOM: TcxGridDBBandedColumn
              AlternateCaption = 'LTP_PRECOM'
              Caption = 'Pre'#231'o Compra'
              DataBinding.FieldName = 'LTP_PRECOM_ATU'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              Properties.OnValidate = cxbItensLTP_PRECOMPropertiesValidate
              HeaderAlignmentHorz = taRightJustify
              Width = 37
              Position.BandIndex = 1
              Position.ColIndex = 16
              Position.RowIndex = 0
            end
            object cxbItensDESGPR: TcxGridDBBandedColumn
              Caption = 'Gr. Pre'#231'o'
              DataBinding.FieldName = 'ITE_DESGPR'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnEditValueChanged = cxbItensDESGPRPropertiesEditValueChanged
              Width = 54
              Position.BandIndex = 1
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensDESABF: TcxGridDBBandedColumn
              Caption = 'Abrevia'#231#227'o Fiscal'
              DataBinding.FieldName = 'ABF_DESABF'
              Options.Editing = False
              Width = 55
              Position.BandIndex = 1
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensColumn8: TcxGridDBBandedColumn
              Caption = 'Loc. F'#237'sica'
              DataBinding.FieldName = 'ITE_LOCFIS'
              Options.Editing = False
              Width = 36
              Position.BandIndex = 1
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensColumn11: TcxGridDBBandedColumn
              Caption = 'Estoque'
              DataBinding.FieldName = 'ITE_SALDOS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 3
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 44
              Position.BandIndex = 1
              Position.ColIndex = 8
              Position.RowIndex = 0
            end
            object cxbItensVFCPST: TcxGridDBBandedColumn
              Caption = 'Vlr FCP ST'
              DataBinding.FieldName = 'VFCPST'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 20
              Position.BandIndex = 1
              Position.ColIndex = 18
              Position.RowIndex = 0
            end
            object cxbItensLTP_PRECUS: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Custo'
              DataBinding.FieldName = 'LTP_PRECUS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 62
              Position.BandIndex = 2
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PRECUS_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Custo Anterior'
              DataBinding.FieldName = 'LTP_PRECUS_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 91
              Position.BandIndex = 2
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensDIFCUS: TcxGridDBBandedColumn
              Caption = '% Difer. Custo'
              DataBinding.FieldName = 'DIFCUS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 80
              Position.BandIndex = 2
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR1: TcxGridDBBandedColumn
              Caption = 'Margem 1'
              DataBinding.FieldName = 'LTP_MARBR1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 65
              Position.BandIndex = 4
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE1: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 1'
              DataBinding.FieldName = 'LTP_PREVE1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 64
              Position.BandIndex = 4
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL1: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 1'
              DataBinding.FieldName = 'TIPCAL1'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 64
              Position.BandIndex = 4
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR2: TcxGridDBBandedColumn
              Caption = 'Margem 2'
              DataBinding.FieldName = 'LTP_MARBR2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 64
              Position.BandIndex = 5
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE2: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 2'
              DataBinding.FieldName = 'LTP_PREVE2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 63
              Position.BandIndex = 5
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL2: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 2'
              DataBinding.FieldName = 'TIPCAL2'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 65
              Position.BandIndex = 5
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR3: TcxGridDBBandedColumn
              Caption = 'Margem 3'
              DataBinding.FieldName = 'LTP_MARBR3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 62
              Position.BandIndex = 6
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE3: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 3'
              DataBinding.FieldName = 'LTP_PREVE3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 65
              Position.BandIndex = 6
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL3: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 3'
              DataBinding.FieldName = 'TIPCAL3'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 64
              Position.BandIndex = 6
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR4: TcxGridDBBandedColumn
              Caption = 'Margem 4'
              DataBinding.FieldName = 'LTP_MARBR4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 65
              Position.BandIndex = 7
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE4: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 4'
              DataBinding.FieldName = 'LTP_PREVE4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 64
              Position.BandIndex = 7
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL4: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 4'
              DataBinding.FieldName = 'TIPCAL4'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 64
              Position.BandIndex = 7
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR5: TcxGridDBBandedColumn
              Caption = 'Margem 5'
              DataBinding.FieldName = 'LTP_MARBR5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 65
              Position.BandIndex = 8
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE5: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 5'
              DataBinding.FieldName = 'LTP_PREVE5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 61
              Position.BandIndex = 8
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL5: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 5'
              DataBinding.FieldName = 'TIPCAL5'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 65
              Position.BandIndex = 8
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR6: TcxGridDBBandedColumn
              Caption = 'Margem 6'
              DataBinding.FieldName = 'LTP_MARBR6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 63
              Position.BandIndex = 9
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE6: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 6'
              DataBinding.FieldName = 'LTP_PREVE6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 64
              Position.BandIndex = 9
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL6: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 6'
              DataBinding.FieldName = 'TIPCAL6'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 64
              Position.BandIndex = 9
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR7: TcxGridDBBandedColumn
              Caption = 'Margem 7'
              DataBinding.FieldName = 'LTP_MARBR7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 64
              Position.BandIndex = 10
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE7: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 7'
              DataBinding.FieldName = 'LTP_PREVE7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Width = 65
              Position.BandIndex = 10
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensTIPCAL7: TcxGridDBBandedColumn
              Caption = 'C'#225'lculo 7'
              DataBinding.FieldName = 'TIPCAL7'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Margem'
                'Pre'#231'o Venda')
              HeaderAlignmentHorz = taCenter
              Width = 64
              Position.BandIndex = 10
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR1_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 1 Ant.'
              DataBinding.FieldName = 'LTP_MARBR1_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 4
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR2_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 2 Ant.'
              DataBinding.FieldName = 'LTP_MARBR2_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 5
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR3_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 3 Ant.'
              DataBinding.FieldName = 'LTP_MARBR3_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 6
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR4_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 4 Ant.'
              DataBinding.FieldName = 'LTP_MARBR4_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 7
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR5_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 5 Ant.'
              DataBinding.FieldName = 'LTP_MARBR5_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 8
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR6_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 6 Ant.'
              DataBinding.FieldName = 'LTP_MARBR6_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 9
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensLTP_MARBR7_ANT: TcxGridDBBandedColumn
              Caption = 'Margem 7 Ant.'
              DataBinding.FieldName = 'LTP_MARBR7_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 10
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE1_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 1 Ant.'
              DataBinding.FieldName = 'LTP_PREVE1_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 4
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE2_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 2 Ant.'
              DataBinding.FieldName = 'LTP_PREVE2_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 5
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE3_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 3 Ant.'
              DataBinding.FieldName = 'LTP_PREVE3_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 6
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE4_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 4 Ant.'
              DataBinding.FieldName = 'LTP_PREVE4_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 7
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE5_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 5 Ant.'
              DataBinding.FieldName = 'LTP_PREVE5_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 8
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE6_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 6 Ant.'
              DataBinding.FieldName = 'LTP_PREVE6_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 9
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensLTP_PREVE7_ANT: TcxGridDBBandedColumn
              Caption = 'Pr. Venda 7 Ant.'
              DataBinding.FieldName = 'LTP_PREVE7_ANT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 75
              Position.BandIndex = 10
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensDIFMA1: TcxGridDBBandedColumn
              Caption = '%  Dif. Mar.1'
              DataBinding.FieldName = 'DIFMA1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 4
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR1: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 1'
              DataBinding.FieldName = 'DIFPR1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 4
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDIFMA2: TcxGridDBBandedColumn
              Caption = '%  Dif. Mar.2'
              DataBinding.FieldName = 'DIFMA2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 5
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR2: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 2'
              DataBinding.FieldName = 'DIFPR2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 5
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDIFMA3: TcxGridDBBandedColumn
              Caption = '% Dif. Mar. 3'
              DataBinding.FieldName = 'DIFMA3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 6
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR3: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 3'
              DataBinding.FieldName = 'DIFPR3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 6
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDIFMA4: TcxGridDBBandedColumn
              Caption = '% Dif. Mar. 4'
              DataBinding.FieldName = 'DIFMA4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 7
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR4: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 4'
              DataBinding.FieldName = 'DIFPR4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 7
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDIFMA5: TcxGridDBBandedColumn
              Caption = '% Dif. Mar. 5'
              DataBinding.FieldName = 'DIFMA5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 8
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR5: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 5'
              DataBinding.FieldName = 'DIFPR5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 8
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensDIFMA6: TcxGridDBBandedColumn
              Caption = '% Dif.Mar. 6'
              DataBinding.FieldName = 'DIFMA6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 9
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensDIFPR6: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 6'
              DataBinding.FieldName = 'DIFPR6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 9
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensDIFMA7: TcxGridDBBandedColumn
              Caption = '% Dif. Mar. 7'
              DataBinding.FieldName = 'DIFMA7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Position.BandIndex = 10
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensDIFPR7: TcxGridDBBandedColumn
              Caption = '% Dif. Pre'#231'o 7'
              DataBinding.FieldName = 'DIFPR7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 70
              Position.BandIndex = 10
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensMARID1: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 1'
              DataBinding.FieldName = 'ITE_MARID1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensPREID1: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 1'
              DataBinding.FieldName = 'ITE_PREID1'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensMARID2: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 2'
              DataBinding.FieldName = 'ITE_MARID2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensPREID2: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 2'
              DataBinding.FieldName = 'ITE_PREID2'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensMARID3: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 3'
              DataBinding.FieldName = 'ITE_MARID3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object cxbItensPREID3: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 3'
              DataBinding.FieldName = 'ITE_PREID3'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object cxbItensMARID4: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 4'
              DataBinding.FieldName = 'ITE_MARID4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensPREID4: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 4'
              DataBinding.FieldName = 'ITE_PREID4'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object cxbItensMARID5: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 5'
              DataBinding.FieldName = 'ITE_MARID5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 8
              Position.RowIndex = 0
            end
            object cxbItensPREID5: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 5'
              DataBinding.FieldName = 'ITE_PREID5'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 9
              Position.RowIndex = 0
            end
            object cxbItensMARID6: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 6'
              DataBinding.FieldName = 'ITE_MARID6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 10
              Position.RowIndex = 0
            end
            object cxbItensPREID6: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 6'
              DataBinding.FieldName = 'ITE_PREID6'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 11
              Position.RowIndex = 0
            end
            object cxbItensMARID7: TcxGridDBBandedColumn
              Caption = 'Margem Ideal 7'
              DataBinding.FieldName = 'ITE_MARID7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 75
              Position.BandIndex = 11
              Position.ColIndex = 12
              Position.RowIndex = 0
            end
            object cxbItensPREID7: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Ideal 7'
              DataBinding.FieldName = 'ITE_PREID7'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 65
              Position.BandIndex = 11
              Position.ColIndex = 13
              Position.RowIndex = 0
            end
            object cxbItensVLRFCP: TcxGridDBBandedColumn
              Caption = 'Vlr FCP'
              DataBinding.FieldName = 'VALFCP'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 39
              Position.BandIndex = 1
              Position.ColIndex = 15
              Position.RowIndex = 0
            end
            object cxbItensCLAIPI: TcxGridDBBandedColumn
              Caption = 'NCM'
              DataBinding.FieldName = 'ITE_CLAIPI'
              Options.Editing = False
              Width = 20
              Position.BandIndex = 1
              Position.ColIndex = 19
              Position.RowIndex = 0
            end
            object cxbItensCLAFIS: TcxGridDBBandedColumn
              Caption = 'CFOP'
              DataBinding.FieldName = 'ITE_CLAFIS'
              Options.Editing = False
              Width = 20
              Position.BandIndex = 1
              Position.ColIndex = 20
              Position.RowIndex = 0
            end
            object cxbItensPREDOL: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o Compra Em D'#243'lar'
              DataBinding.FieldName = 'LTP_PREDOL'
              Options.Editing = False
              Width = 88
              Position.BandIndex = 1
              Position.ColIndex = 17
              Position.RowIndex = 0
            end
            object cxbItensESTRUT: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ESTRUT'
              Visible = False
              Position.BandIndex = 0
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object cxbItensESTRUT_FILHO: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ESTRUT_FILHO'
              Visible = False
              Position.BandIndex = 0
              Position.ColIndex = 8
              Position.RowIndex = 0
            end
            object cxbItensITE_ABFPIS: TcxGridDBBandedColumn
              Caption = 'Abrevia'#231#227'o PIS'
              DataBinding.FieldName = 'ABF_DESPIS'
              Width = 48
              Position.BandIndex = 1
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object cxbItensITE_ABFCOF: TcxGridDBBandedColumn
              Caption = 'Abrevia'#231#227'o Cofins'
              DataBinding.FieldName = 'ABF_DESCOF'
              Width = 47
              Position.BandIndex = 1
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object cxbItensSALDIS: TcxGridDBBandedColumn
              Caption = 'Saldo Dispon'#237'vel'
              DataBinding.FieldName = 'SALDIS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              Options.Editing = False
              Width = 48
              Position.BandIndex = 1
              Position.ColIndex = 9
              Position.RowIndex = 0
            end
            object cxbItensPREMED: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o M'#233'dio'
              DataBinding.FieldName = 'PREMED'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 2
              Properties.DisplayFormat = '0.00;-0.00'
              Options.Editing = False
              Position.BandIndex = 12
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensSIT_DESCRI: TcxGridDBBandedColumn
              Caption = 'Situa'#231#227'o'
              DataBinding.FieldName = 'SIT_DESCRI'
              MinWidth = 50
              Options.Editing = False
              Width = 57
              Position.BandIndex = 1
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensSIT_CORSIT: TcxGridDBBandedColumn
              Caption = 'Cor situa'#231#227'o'
              DataBinding.FieldName = 'SIT_CORSIT'
              Visible = False
              Position.BandIndex = 0
              Position.ColIndex = 9
              Position.RowIndex = 0
            end
            object cxbItensIMPULT: TcxGridDBBandedColumn
              Caption = 'Pre'#231'o de '#250'ltima compra + Impostos'
              DataBinding.FieldName = 'IMPULT'
              Options.Editing = False
              Position.BandIndex = 2
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxbItensNVLGIR: TcxGridDBBandedColumn
              Caption = 'Curva ABC'
              DataBinding.FieldName = 'NIVGIR'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Position.BandIndex = 1
              Position.ColIndex = 21
              Position.RowIndex = 0
            end
            object cxbItensDTAALT: TcxGridDBBandedColumn
              Caption = 'Dt Ult Alt Pre'#231'o'
              DataBinding.FieldName = 'DTAALT'
              PropertiesClassName = 'TcxDateEditProperties'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Position.BandIndex = 1
              Position.ColIndex = 22
              Position.RowIndex = 0
            end
            object cxbItensColumn1: TcxGridDBBandedColumn
              Caption = 'Anterior'
              DataBinding.FieldName = 'ITE_CUSREA_ANT'
              HeaderAlignmentHorz = taCenter
              Position.BandIndex = 3
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensColumn9: TcxGridDBBandedColumn
              Caption = 'Atual'
              DataBinding.FieldName = 'ITE_CUSREA'
              HeaderAlignmentHorz = taCenter
              Position.BandIndex = 3
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxbItensColumn12: TcxGridDBBandedColumn
              Caption = '%Diferen'#231'a'
              DataBinding.FieldName = 'ITE_CUSREA_DIF'
              HeaderAlignmentHorz = taCenter
              Position.BandIndex = 3
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxbItensITE_APLICA: TcxGridDBBandedColumn
              Caption = 'Aplica'#231#227'o'
              DataBinding.FieldName = 'ITE_APLICA'
              Options.Editing = False
              Position.BandIndex = 1
              Position.ColIndex = 23
              Position.RowIndex = 0
            end
            object cxbItensLTP_RPRENT: TcxGridDBBandedColumn
              Caption = 'Item n'#227'o permite redu'#231#227'o de pre'#231'os na entrada'
              DataBinding.FieldName = 'LTP_RPRENT'
              Position.BandIndex = 1
              Position.ColIndex = 24
              Position.RowIndex = 0
            end
            object cxbItensNROITE: TcxGridDBBandedColumn
              Caption = 'Seq.'
              DataBinding.FieldName = 'NROITE'
              Options.Editing = False
              Width = 35
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxbItensITE_NIVCRI: TcxGridDBBandedColumn
              Caption = 'N'#237'vel Criticidade'
              DataBinding.FieldName = 'ITE_NIVCRI'
              Width = 125
              Position.BandIndex = 1
              Position.ColIndex = 25
              Position.RowIndex = 0
            end
          end
          object cxgItensLevel1: TcxGridLevel
            GridView = cxbItens
          end
        end
      end
      object pnlHeader: TPanel
        Left = 0
        Top = 0
        Width = 1193
        Height = 90
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label1: TLabel
          Left = 13
          Top = 39
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object Label2: TLabel
          Left = 17
          Top = 66
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Documento:'
        end
        object Label3: TLabel
          Left = 168
          Top = 62
          Width = 4
          Height = 14
          Alignment = taRightJustify
          Caption = '-'
        end
        object Label4: TLabel
          Left = 213
          Top = 66
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'S'#233'rie:'
        end
        object Label5: TLabel
          Left = 292
          Top = 66
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data de Entrada:'
        end
        object Label6: TLabel
          Left = 6
          Top = 13
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Respons'#225'vel:'
        end
        object lblCotDol: TLabel
          Left = 457
          Top = 32
          Width = 199
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cota'#231#227'o do D'#243'lar utilizada no documento:'
          Visible = False
        end
        object lblCotAnt: TLabel
          Left = 530
          Top = 9
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cota'#231#227'o do D'#243'lar anterior:'
          Visible = False
        end
        object lblEmp: TLabel
          Left = 466
          Top = 66
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'Emp:'
        end
        object edtCodFor: TEditFocus
          Left = 76
          Top = 33
          Width = 375
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtNumDoc: TEditFocus
          Left = 76
          Top = 59
          Width = 90
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEspDoc: TEditFocus
          Left = 174
          Top = 59
          Width = 32
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSerie: TEditFocus
          Left = 243
          Top = 59
          Width = 42
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtDtaEnt: TEditFocus
          Left = 376
          Top = 59
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtOpeRes: TEditFocus
          Left = 76
          Top = 7
          Width = 375
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnPesLot: TBitBtnLocked
          Left = 588
          Top = 53
          Width = 146
          Height = 31
          Caption = '[F1] &Pesquisar Lote'
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FF1C98CE1C98CE1C98CEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF0E90C946B2DA3BB5DE24A4D51698CE0F90CA0C8CC6FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9975741F4975FF00FFFF00FFFF00FF098AC68FD1EAB4FFFF78F6FF76EE
            FC65DDF34ECAEA3CBAE129A9D81899CF0F90CA0A8BC60A8BC6FF00FFFF00FFFF
            00FFFF01FEFF00FFAC7673235E9C0D6BD15E809FFF00FFFF00FF078AC648ADD7
            D1FFFF79FBFF7DFAFF7FFCFF81FAFF81FAFF7AF3FF75EAFC5FD8F340BFE52DAD
            DA1C9ED11193CB0E8FC9288AB7A978772C5E8E106DE235A3FF3099F0FF00FFFF
            00FF0D8FC91896CCBDEAF68AFEFF7AF7FF7AF7FF79F4FF78F4FF78F4FF78F4FF
            79F4FF7DF4FF78F2FF72EAFC68DEF66BBFD5918388265C8F0D6EE0359EFF3FAA
            FE2392FFFF00FFFF00FF1396CB20A0D36FC2E2ADFFFF76F7FF7AF7FF79F4FF78
            F4FF77F3FF78F0FC77EFFE75EEFE76EFFE74EFFF81DEEA9A8E912D5D8E0D6DDD
            319AFF3DA9FF228EFEFF00FFFF00FFFF00FF1091CA49C1E33BABD7BCF8FC79FB
            FF7AF7FF79F4FF78F4FF83D9E28FCAD08ED7DA87CAD07AC2CB74E3F07FB4BB34
            628B0A6BD8329DFF3EA9FF2899F60D8EC9FF00FFFF00FFFF00FF0F8FC966D8EF
            38BAE0A3DDEF8AFEFF78F4FE7BE9F28BDCE0BBAFA4DDC6ADDAD4B6D3C7ACB8AB
            988FA5A373898B5280A746AAFB3FAFFF32A4FB56D1F61396CBFF00FFFF00FFFF
            00FF0F8FC96EDEF2A4676970C1E1A7FFFF75E9F091A1A3CBCEC4F7F0D0FFFFD7
            FFFFD5FFFFD8FFFFD5D3C49DA78472CAB0A97AD8FA4EC9FE4AC5F66CE5FC2BAD
            D9FF00FFFF00FFFF00FF0F8FC96CDCF0A4676940B0D9C4F8FE7DC7CBCBB0A7FF
            FCF8FFFFF6FFFFDAFFFFD4FFFFD3FFFCCFFFF8BBF2D3A4D5A48E76DAEF6DE7FE
            4ECAF66FE7FF52D0ED0C8CC7FF00FFFF00FF108FC96BDAEFA0675B30B5DDABDA
            EEA79F99F8F6DAFFFFFEFFFFFEFFFFF0FFFFDCFFFFD1FCF6C6FAD89EFFDE9DD5
            B1918AC0C96EE5FB4ECAF66CE3FE73EBFC1698CEFF00FFFF00FF108FC96BDAEF
            A0675BFFF4E5289FD0C4A390FFFFDEFFFFEAFFFFFCFFFFF6FFFFDCFFFFD3FCF7
            C6F0C28AFCCE89EDD1A3A7AAA973DAF04ECAF669E2FB81F7FF33B6DE0A8AC5FF
            00FF1190C972DDF2A7756BFFFBF0F8EADCCBB699FFFFDAFFFFD8FFFFE3FFFFE1
            FFFFD8FFFFD3FAE6B1EBAB72F6C27FF4D9A5B1A7A379D4E64ECAF669E2FB81F7
            FF66E1F71192CAFF00FF1290C973DEF2A7756BFFFFFCFAF0E6CAAB93FFFFD7FF
            FFD4FFFFD5FFFFD8FFFFD5FCF0BFF2C589E9A362FBCF88F2D9A7A6ABA973D8EB
            4BC9F667E2FB7AF3FF7DF4FF28ACD9FF00FF1290C972E0F2BC8268FFFFFFFEF7
            F2B78F84FCFECCFFFFD1FCF8C9FEF7C7FAE5AFF2C78BEEBC82F4D39FFFF7B6E2
            C49CA3BABF8BEAFA62D1F879E7FE88F7FF89F8FF54D0EE0C8EC61290C972E0F2
            BC8268FFFFFFFFFEFCD4BCB7D1B89AFFFFC9FADDA1EFBD86EAAA6EEBB274F7DE
            BAFFFFF8F0E7CEAF9F989CC6D8A0D8EDADDEF0BBE6F3BDEAF6C2EEF8B2E9F718
            96CC1391CA76E2F3D1926DFFFFFFFFFFFFFAF7F6DDC6BBDCBF9AFFEBABFEDD98
            FED58CFFE6A1FFFFE0EDE6E2B8918953B5D041C2E63FC0E61C9ED11190C91593
            CA1895CB1A97CB0F91C91593CA7FE6F4D1926DFFFFFFFFFFFFFFFFFFFEFBF8E7
            D4CBD8AF9AE9C9A0E3C29CE1C49CCAAB8EAF9583A56B6B76EFFF76F3FF74EFFF
            23A9D8FF00FFFF00FFFF00FFFF00FFFF00FF0F8FC988DCEFDA9D75FFFFFFFFFF
            FFFFFFFFFFFFFFFFFEFCFCF6EFFCF3E6EDD8C9A56B5FA56B5FA56B5FA4676983
            E9FC82EBFC80E9FC24A4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3AA7D5
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
            55E68F31B56D4D1F9CCF239FD126A0D11192CAFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF0A8CC7E7AB79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            DCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8
            F2EFF7F2EFF7F2EFD8C2C0A56B5FC1836CFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD192
            6DD1926DD1926DD1926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 6
          OnClick = btnPesLotClick
        end
        object btnPesPed: TBitBtnLocked
          Left = 740
          Top = 53
          Width = 204
          Height = 31
          Caption = '[F2] &Pesquisar Pedido de Compra'
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FF1C98CE1C98CE1C98CEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF0E90C946B2DA3BB5DE24A4D51698CE0F90CA0C8CC6FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9975741F4975FF00FFFF00FFFF00FF098AC68FD1EAB4FFFF78F6FF76EE
            FC65DDF34ECAEA3CBAE129A9D81899CF0F90CA0A8BC60A8BC6FF00FFFF00FFFF
            00FFFF01FEFF00FFAC7673235E9C0D6BD15E809FFF00FFFF00FF078AC648ADD7
            D1FFFF79FBFF7DFAFF7FFCFF81FAFF81FAFF7AF3FF75EAFC5FD8F340BFE52DAD
            DA1C9ED11193CB0E8FC9288AB7A978772C5E8E106DE235A3FF3099F0FF00FFFF
            00FF0D8FC91896CCBDEAF68AFEFF7AF7FF7AF7FF79F4FF78F4FF78F4FF78F4FF
            79F4FF7DF4FF78F2FF72EAFC68DEF66BBFD5918388265C8F0D6EE0359EFF3FAA
            FE2392FFFF00FFFF00FF1396CB20A0D36FC2E2ADFFFF76F7FF7AF7FF79F4FF78
            F4FF77F3FF78F0FC77EFFE75EEFE76EFFE74EFFF81DEEA9A8E912D5D8E0D6DDD
            319AFF3DA9FF228EFEFF00FFFF00FFFF00FF1091CA49C1E33BABD7BCF8FC79FB
            FF7AF7FF79F4FF78F4FF83D9E28FCAD08ED7DA87CAD07AC2CB74E3F07FB4BB34
            628B0A6BD8329DFF3EA9FF2899F60D8EC9FF00FFFF00FFFF00FF0F8FC966D8EF
            38BAE0A3DDEF8AFEFF78F4FE7BE9F28BDCE0BBAFA4DDC6ADDAD4B6D3C7ACB8AB
            988FA5A373898B5280A746AAFB3FAFFF32A4FB56D1F61396CBFF00FFFF00FFFF
            00FF0F8FC96EDEF2A4676970C1E1A7FFFF75E9F091A1A3CBCEC4F7F0D0FFFFD7
            FFFFD5FFFFD8FFFFD5D3C49DA78472CAB0A97AD8FA4EC9FE4AC5F66CE5FC2BAD
            D9FF00FFFF00FFFF00FF0F8FC96CDCF0A4676940B0D9C4F8FE7DC7CBCBB0A7FF
            FCF8FFFFF6FFFFDAFFFFD4FFFFD3FFFCCFFFF8BBF2D3A4D5A48E76DAEF6DE7FE
            4ECAF66FE7FF52D0ED0C8CC7FF00FFFF00FF108FC96BDAEFA0675B30B5DDABDA
            EEA79F99F8F6DAFFFFFEFFFFFEFFFFF0FFFFDCFFFFD1FCF6C6FAD89EFFDE9DD5
            B1918AC0C96EE5FB4ECAF66CE3FE73EBFC1698CEFF00FFFF00FF108FC96BDAEF
            A0675BFFF4E5289FD0C4A390FFFFDEFFFFEAFFFFFCFFFFF6FFFFDCFFFFD3FCF7
            C6F0C28AFCCE89EDD1A3A7AAA973DAF04ECAF669E2FB81F7FF33B6DE0A8AC5FF
            00FF1190C972DDF2A7756BFFFBF0F8EADCCBB699FFFFDAFFFFD8FFFFE3FFFFE1
            FFFFD8FFFFD3FAE6B1EBAB72F6C27FF4D9A5B1A7A379D4E64ECAF669E2FB81F7
            FF66E1F71192CAFF00FF1290C973DEF2A7756BFFFFFCFAF0E6CAAB93FFFFD7FF
            FFD4FFFFD5FFFFD8FFFFD5FCF0BFF2C589E9A362FBCF88F2D9A7A6ABA973D8EB
            4BC9F667E2FB7AF3FF7DF4FF28ACD9FF00FF1290C972E0F2BC8268FFFFFFFEF7
            F2B78F84FCFECCFFFFD1FCF8C9FEF7C7FAE5AFF2C78BEEBC82F4D39FFFF7B6E2
            C49CA3BABF8BEAFA62D1F879E7FE88F7FF89F8FF54D0EE0C8EC61290C972E0F2
            BC8268FFFFFFFFFEFCD4BCB7D1B89AFFFFC9FADDA1EFBD86EAAA6EEBB274F7DE
            BAFFFFF8F0E7CEAF9F989CC6D8A0D8EDADDEF0BBE6F3BDEAF6C2EEF8B2E9F718
            96CC1391CA76E2F3D1926DFFFFFFFFFFFFFAF7F6DDC6BBDCBF9AFFEBABFEDD98
            FED58CFFE6A1FFFFE0EDE6E2B8918953B5D041C2E63FC0E61C9ED11190C91593
            CA1895CB1A97CB0F91C91593CA7FE6F4D1926DFFFFFFFFFFFFFFFFFFFEFBF8E7
            D4CBD8AF9AE9C9A0E3C29CE1C49CCAAB8EAF9583A56B6B76EFFF76F3FF74EFFF
            23A9D8FF00FFFF00FFFF00FFFF00FFFF00FF0F8FC988DCEFDA9D75FFFFFFFFFF
            FFFFFFFFFFFFFFFFFEFCFCF6EFFCF3E6EDD8C9A56B5FA56B5FA56B5FA4676983
            E9FC82EBFC80E9FC24A4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3AA7D5
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
            55E68F31B56D4D1F9CCF239FD126A0D11192CAFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF0A8CC7E7AB79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            DCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8
            F2EFF7F2EFF7F2EFD8C2C0A56B5FC1836CFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD192
            6DD1926DD1926DD1926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 7
          OnClick = btnPesPedClick
        end
        object edtCotDol: TEditFocus
          Tag = 99
          Left = 659
          Top = 26
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          ReadOnly = True
          TabOrder = 8
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtCotAnt: TEditFocus
          Tag = 99
          Left = 659
          Top = 3
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          ReadOnly = True
          TabOrder = 9
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtCodEmp: TEditFocus
          Left = 493
          Top = 59
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 10
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object grpCalculoPrecoVenda: TGroupBox
          Left = 753
          Top = -2
          Width = 432
          Height = 51
          Caption = 'Selecione para calcular o Pre'#231'o de Venda + Impostos:'
          TabOrder = 11
          object lblPerfilSaida: TLabel
            Left = 15
            Top = 12
            Width = 69
            Height = 14
            Caption = 'Perfil de Sa'#237'da'
          end
          object lblEstados: TLabel
            Left = 378
            Top = 12
            Width = 33
            Height = 14
            Caption = 'Estado'
          end
          object cmbPerfil: TComboBox
            Left = 14
            Top = 26
            Width = 358
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = cmbPerfilChange
            Items.Strings = (
              ''
              'NCO - SAIDAS NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)'
              'CCO - SAIDAS CONTRIBUINTE CONSUMIDOR'
              'CNC - SAIDAS CONTRIBUINTE NAO CONSUMIDOR'
              'SNA - SAIDAS SIMPLES NACIONAL'
              'CTA - SAIDAS CONSTRUTORA / NAO CONTRIBUINTE COM INSC.ESTADUAL'
              'PRU - SAIDAS PRODUTOR RURAL'
              'IND - SAIDAS INDUSTRIA'
              'TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS')
          end
          object cmbEstado: TComboBox
            Left = 378
            Top = 26
            Width = 50
            Height = 22
            Style = csDropDownList
            TabOrder = 1
            OnChange = cmbEstadoChange
            Items.Strings = (
              ''
              'AC'
              'AL'
              'AM'
              'AP'
              'BA'
              'CE'
              'DF'
              'ES'
              'EX'
              'GO'
              'MA'
              'MG'
              'MS'
              'MT'
              'PA'
              'PB'
              'PE'
              'PI'
              'PR'
              'RJ'
              'RN'
              'RO'
              'RR'
              'RS'
              'SC'
              'SE'
              'SP'
              'TO')
          end
          object btnCfgGri: TcxButton
            Left = 948
            Top = 53
            Width = 124
            Height = 31
            Caption = 'Configurar Colunas'
            Kind = cxbkDropDown
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000002C744558745469746C65004F7074696F6E733B437573746F6D697A3B
              426172733B526962626F6E3B5374616E646172643B6534D17A000002D9494441
              54785E5D926F68D55518C73FCFD9D5BBBBCAB1ED6612B817DA16D606A2D48B81
              9B8631ADC1DD2632962C31442C29885E0C5FCC17D11B85486C6D8C18283A1699
              84C3406A5B39596CB3EC8F7B61AE568381BAD9FEE96AF7FECE394FDCDFEF0AD2
              8B2FCF730E87CFF3FD3E1C014CFBB91F078D3135008A820280AA003EAAEA51A2
              739009AEBE77B06AA7AA66628011A4E670F36688083CD2FCEF18955367AE6D03
              F200628058F5A090CE38145005EF7D2800C420C6A028F9AB0CCE7A0011110C20
              2EF0003855BC579C73749CEEE3D889D3B47F7A81C1A11F58496742A02A58EB00
              A4E9401B06C087178A6A240F14AC56F2DCBF54569471E7DE029DDD1748AF04E1
              80C02A805867A30881F37855B2551010A1796F1D3DBD17F96E68944307F7F175
              FF1097FB8769A8DB8E7591036F5D2E82F3A1ED0F3FEEE1CAF075026B43C8ABAF
              BCC4C4C424730FD2943FB381D16B37B0D662BD05C0B91C20081C59C8CCEC3C77
              671618F87694E5E57F181EFD85977756E39C52589C646171299CEE5C2E420E40
              105922CF1892C922161797397EF20C4B4BCB54566EC23A65FAF62CB1BC58B8C0
              92C244142102448D88E1B9674BB9317E931D3BAA686B3DC4AE5DDB49AC29C27B
              47F2C922366E2CE5FB919FD8B4A118C0645D3FDC41387D776D35537F4DD1D1D5
              C357FD63FC393DC7AD5B9304D6B39276A4EA77F3F3F81F8C8FFF0A10FFA6EF13
              0901D60322240A1EE368EB5B3CBDB6902F3F3FCFBB47DEA6F3D449BEE8ED21C8
              38A6EEDCA7A131C5C2D23C5BAB524D403C06908DA0C09A82D53C9E88F1C6FE3D
              BCBE2F85B5D1720706AFF0D9D96EEA9BF6F3FBF41CF57B52D9257FE455E604C8
              3FDC7AFE722C9E5FE3158C107D260511E5A99227A8282F616CE42A37277EA3B1
              E54DC0B3AE28CEFBC73EF85B0003C4815580E4C42395876F926B4B5FDBFC62CD
              89869623220867BBDA674455011011D69755E3BD0D23791F69EB0BDBB83E7289
              99DB9302240A8BD7353FBFA5F6B87AE5FEFCDD77FE03B7507F361277596D0000
              000049454E44AE426082}
            TabOrder = 2
          end
        end
        object cxButton1: TcxButton
          Left = 948
          Top = 53
          Width = 124
          Height = 31
          Caption = 'Configurar Colunas'
          DropDownMenu = mnuOpcGrid
          Kind = cxbkDropDown
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000002C744558745469746C65004F7074696F6E733B437573746F6D697A3B
            426172733B526962626F6E3B5374616E646172643B6534D17A000002D9494441
            54785E5D926F68D55518C73FCFD9D5BBBBCAB1ED6612B817DA16D606A2D48B81
            9B8631ADC1DD2632962C31442C29885E0C5FCC17D11B85486C6D8C18283A1699
            84C3406A5B39596CB3EC8F7B61AE568381BAD9FEE96AF7FECE394FDCDFEF0AD2
            8B2FCF730E87CFF3FD3E1C014CFBB91F078D3135008A820280AA003EAAEA51A2
            739009AEBE77B06AA7AA66628011A4E670F36688083CD2FCEF18955367AE6D03
            F200628058F5A090CE38145005EF7D2800C420C6A028F9AB0CCE7A0011110C20
            2EF0003855BC579C73749CEEE3D889D3B47F7A81C1A11F58496742A02A58EB00
            A4E9401B06C087178A6A240F14AC56F2DCBF54569471E7DE029DDD1748AF04E1
            80C02A805867A30881F37855B2551010A1796F1D3DBD17F96E68944307F7F175
            FF1097FB8769A8DB8E7591036F5D2E82F3A1ED0F3FEEE1CAF075026B43C8ABAF
            BCC4C4C424730FD2943FB381D16B37B0D662BD05C0B91C20081C59C8CCEC3C77
            671618F87694E5E57F181EFD85977756E39C52589C646171299CEE5C2E420E40
            105922CF1892C922161797397EF20C4B4BCB54566EC23A65FAF62CB1BC58B8C0
            92C244142102448D88E1B9674BB9317E931D3BAA686B3DC4AE5DDB49AC29C27B
            47F2C922366E2CE5FB919FD8B4A118C0645D3FDC41387D776D35537F4DD1D1D5
            C357FD63FC393DC7AD5B9304D6B39276A4EA77F3F3F81F8C8FFF0A10FFA6EF13
            0901D60322240A1EE368EB5B3CBDB6902F3F3FCFBB47DEA6F3D449BEE8ED21C8
            38A6EEDCA7A131C5C2D23C5BAB524D403C06908DA0C09A82D53C9E88F1C6FE3D
            BCBE2F85B5D1720706AFF0D9D96EEA9BF6F3FBF41CF57B52D9257FE455E604C8
            3FDC7AFE722C9E5FE3158C107D260511E5A99227A8282F616CE42A37277EA3B1
            E54DC0B3AE28CEFBC73EF85B0003C4815580E4C42395876F926B4B5FDBFC62CD
            89869623220867BBDA674455011011D69755E3BD0D23791F69EB0BDBB83E7289
            99DB9302240A8BD7353FBFA5F6B87AE5FEFCDD77FE03B7507F361277596D0000
            000049454E44AE426082}
          TabOrder = 12
        end
      end
    end
  end
  object pgbProgresso: TProgressBar [3]
    Left = 0
    Top = 568
    Width = 1195
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 2
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1096
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1032
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1152
    Top = 32
  end
  object dtsPrecos: TDataSource
    Left = 120
    Top = 328
  end
  object dtsPrecos2: TDataSource
    Left = 112
    Top = 396
  end
  object dtsPrecos3: TDataSource
    Left = 116
    Top = 432
  end
  object mnuOpcGrid: TPopupMenu
    Left = 1071
    Top = 54
    object ConfigurarColunas1: TMenuItem
      Caption = 'Configurar Colunas'
      OnClick = ConfigurarColunas1Click
    end
    object ReiniciarGrid1: TMenuItem
      Caption = 'Reiniciar Grid'
      OnClick = ReiniciarGrid1Click
    end
  end
end
