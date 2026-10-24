inherited frmParametrosContabilizacao: TfrmParametrosContabilizacao
  Width = 1024
  Height = 663
  Caption = 'Par'#226'metros para Contabiliza'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 618
    Width = 1018
    TabOrder = 0
    ExplicitTop = 618
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
  object pnlFundo: TPanel [1]
    Left = 0
    Top = 0
    Width = 1018
    Height = 590
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 415
      Width = 1016
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 87
      ExplicitTop = 408
      ExplicitWidth = 169
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 418
      Width = 1016
      Height = 171
      Align = alBottom
      Caption = 'pnlGrid'
      TabOrder = 0
      object cxGridCitel1: TcxGridCitel
        Left = 1
        Top = 1
        Width = 1014
        Height = 169
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
          OnDblClick = cxGridCitel1DBTableViewCitel1DblClick
          OnKeyDown = cxGridCitel1DBTableViewCitel1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Styles.OnGetContentStyle = cxGridCitel1DBTableViewCitel1StylesGetContentStyle
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridCitel1DBTableViewCitel1CON_TIPPLA: TcxGridDBColumn
            Caption = 'Tipo de Lan'#231'amento'
            DataBinding.FieldName = 'CON_TIPLAN'
            SortIndex = 0
            SortOrder = soAscending
            Width = 125
          end
          object cxGridCitel1DBTableViewCitel1CFOP: TcxGridDBColumn
            DataBinding.FieldName = 'CLAFIS'
            SortIndex = 1
            SortOrder = soAscending
          end
          object cxGridCitel1DBTableViewCitel1CON_CODTRI: TcxGridDBColumn
            Caption = 'CST'
            DataBinding.FieldName = 'CON_CODTRI'
          end
          object cxGridCitel1DBTableViewCitel1CON_NATCFO: TcxGridDBColumn
            Caption = 'Natureza de Opera'#231#227'o'
            DataBinding.FieldName = 'NAT_DESCRI'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 184
          end
          object cxGridCitel1DBTableViewCitel1CON_NATOPE: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CON_NATOPE'
            SortIndex = 3
            SortOrder = soAscending
            Width = 154
          end
          object cxGridCitel1DBTableViewCitel1CON_FORPGO: TcxGridDBColumn
            Caption = 'Forma de Pagamento'
            DataBinding.FieldName = 'CON_FORPGO'
            SortIndex = 2
            SortOrder = soAscending
            Width = 124
          end
          object cxGridCitel1DBTableViewCitel1CON_DESVAL: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Valor'
            DataBinding.FieldName = 'CON_DESVAL'
            SortIndex = 4
            SortOrder = soAscending
            Width = 105
          end
          object cxGridCitel1DBTableViewCitel1CON_CONDEB: TcxGridDBColumn
            Caption = 'Conta de D'#233'bito'
            DataBinding.FieldName = 'CON_CONDEB'
            Width = 126
          end
          object cxGridCitel1DBTableViewCitel1DESDEB: TcxGridDBColumn
            Caption = 'Desc. Conta D'#233'bito'
            DataBinding.FieldName = 'DESDEB'
            Width = 160
          end
          object cxGridCitel1DBTableViewCitel1CON_CFDEBI: TcxGridDBColumn
            Caption = 'Cli/For D'#233'bito'
            DataBinding.FieldName = 'CON_CFDEBI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 72
          end
          object cxGridCitel1DBTableViewCitel1CON_PORDEB: TcxGridDBColumn
            Caption = 'Portador D'#233'bito'
            DataBinding.FieldName = 'CON_PORDEB'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 80
          end
          object cxGridCitel1DBTableViewCitel1CON_PCDEBI: TcxGridDBColumn
            Caption = 'Plano de Contas D'#233'bito'
            DataBinding.FieldName = 'CON_PCDEBI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 116
          end
          object cxGridCitel1DBTableViewCitel1CON_CMPDEB: TcxGridDBColumn
            Caption = 'Complemento D'#233'bito'
            DataBinding.FieldName = 'CON_CMPDEB'
            Width = 106
          end
          object cxGridCitel1DBTableViewCitel1CON_CONCRE: TcxGridDBColumn
            Caption = 'Conta de Cr'#233'dito'
            DataBinding.FieldName = 'CON_CONCRE'
            Width = 149
          end
          object cxGridCitel1DBTableViewCitel1DESCRE: TcxGridDBColumn
            Caption = 'Desc. Conta Cr'#233'dito'
            DataBinding.FieldName = 'DESCRE'
            Width = 134
          end
          object cxGridCitel1DBTableViewCitel1CON_CFCRED: TcxGridDBColumn
            Caption = 'Cli/For Cr'#233'dito'
            DataBinding.FieldName = 'CON_CFCRED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 73
          end
          object cxGridCitel1DBTableViewCitel1CON_PORCRE: TcxGridDBColumn
            Caption = 'Portador Cr'#233'dito'
            DataBinding.FieldName = 'CON_PORCRE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 84
          end
          object cxGridCitel1DBTableViewCitel1CON_PCCRED: TcxGridDBColumn
            Caption = 'Plano de Contas Cr'#233'dito'
            DataBinding.FieldName = 'CON_PCCRED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 125
          end
          object cxGridCitel1DBTableViewCitel1HISCRE: TcxGridDBColumn
            Caption = 'Hist'#243'rico'
            DataBinding.FieldName = 'HISCRE'
            Width = 85
          end
          object cxGridCitel1DBTableViewCitel1CON_TITPDD: TcxGridDBColumn
            Caption = 'T'#237'tulos PDD'
            DataBinding.FieldName = 'CON_TITPDD'
            PropertiesClassName = 'TcxRadioGroupProperties'
            Properties.Columns = 2
            Properties.Items = <
              item
                Caption = 'N'#227'o'
                Value = 'N'
              end
              item
                Caption = 'Sim'
                Value = 'S'
              end>
            Options.Editing = False
            Width = 132
          end
          object cxGridCitel1DBTableViewCitel1CON_PAGAME: TcxGridDBColumn
            Caption = 'Pagamentos'
            DataBinding.FieldName = 'CON_PAGAME'
            Width = 100
          end
          object cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn
            Caption = 'Origem'
            DataBinding.FieldName = 'ORIGEM'
            Width = 100
          end
          object cxGridCitel1DBTableViewCitel1CON_CODORI: TcxGridDBColumn
            Caption = 'MarketPlace'
            DataBinding.FieldName = 'CON_CODORI'
            Options.Editing = False
            Width = 100
          end
          object cxGridCitel1DBTableViewCitel1CON_CODGRU: TcxGridDBColumn
            Caption = 'Linha/Grupo'
            DataBinding.FieldName = 'CON_CODGRU'
            Options.Editing = False
            Width = 100
          end
          object cxGridCitel1DBTableViewCitel1STATUS: TcxGridDBColumn
            Caption = 'St. Vig'#234'ncia'
            DataBinding.FieldName = 'STATUS'
            Width = 75
          end
          object cxGridCitel1DBTableViewCitel1CON_PAGANT: TcxGridDBColumn
            Caption = 'Adiantamento'
            DataBinding.FieldName = 'CON_PAGANT'
            Width = 90
          end
          object cxGridCitel1DBTableViewCitel1CON_VIGINI: TcxGridDBColumn
            Caption = 'Vig'#234'ncia In'#237'cio'
            DataBinding.FieldName = 'CON_VIGINI'
            PropertiesClassName = 'TcxDateEditProperties'
            Width = 81
          end
          object cxGridCitel1DBTableViewCitel1CON_VIGFIN: TcxGridDBColumn
            Caption = 'Vig'#234'ncia Final'
            DataBinding.FieldName = 'CON_VIGFIN'
            PropertiesClassName = 'TcxDateEditProperties'
            Width = 84
          end
        end
        object cxGridCitel1Level1: TcxGridLevel
          GridView = cxGridCitel1DBTableViewCitel1
        end
      end
    end
    object pnlParametros: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 385
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PanelGroup: TCategoryPanelGroup
        Left = 0
        Top = 0
        Width = 289
        Height = 385
        VertScrollBar.Tracking = True
        DoubleBuffered = True
        Color = 15790320
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        ParentDoubleBuffered = False
        TabOrder = 0
        object pnlGrupoProd: TCategoryPanel
          Top = 1086
          Caption = 'Linha/Grupo'
          TabOrder = 0
          ExplicitWidth = 287
          object GridGrupo: TcxGridCitel
            Left = 0
            Top = 0
            Width = 268
            Height = 174
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            ExplicitWidth = 285
            object GridGrupoTableView: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              FindPanel.ApplyInputDelay = 500
              FindPanel.DisplayMode = fpdmAlways
              FindPanel.InfoText = 'Digite algo para pesquisar'
              FindPanel.ShowFindButton = False
              DataController.DataSource = dsGrupoProd
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object GridGrupoTableViewSELECI: TcxGridDBColumn
                DataBinding.FieldName = 'SELECI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                MinWidth = 26
                Options.HorzSizing = False
                Options.Moving = False
                Options.Sorting = False
                Width = 26
                IsCaptionAssigned = True
              end
              object GridGrupoTableViewGRUPO: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'GRUPO'
                MinWidth = 210
                Options.Editing = False
                Options.HorzSizing = False
                Options.Moving = False
                Options.Sorting = False
                Width = 210
              end
            end
            object GridGrupoLevel1: TcxGridLevel
              GridView = GridGrupoTableView
            end
          end
        end
        object pnlMarketPlace: TCategoryPanel
          Top = 726
          Height = 180
          Caption = 'MarketPlace'
          Locked = True
          TabOrder = 1
          ExplicitWidth = 185
          object lstMarketPlace: TcxCheckListBox
            Left = 7
            Top = 6
            Width = 251
            Height = 144
            Items = <>
            TabOrder = 0
          end
        end
        object pnlCst: TCategoryPanel
          Top = 669
          Height = 57
          Caption = 'CST'
          Locked = True
          TabOrder = 2
          Visible = False
          ExplicitWidth = 287
          object edtCST: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnExit = edtPagamentosExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlPagamentos: TCategoryPanel
          Top = 612
          Height = 57
          Caption = 'Pagamentos'
          TabOrder = 3
          ExplicitWidth = 185
          object edtPagamentos: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnExit = edtPagamentosExit
            Items.Strings = (
              'Pagamentos Avulsos'
              'Pagamentos Fatura')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlTitPDD: TCategoryPanel
          Top = 544
          Height = 68
          Caption = 'T'#237'tulos PDD'
          Locked = True
          TabOrder = 4
          ExplicitWidth = 287
          object rgTitPDD: TRadioGroup
            Left = 8
            Top = 4
            Width = 250
            Height = 37
            Columns = 2
            Items.Strings = (
              'N'#227'o'
              'Sim')
            TabOrder = 0
          end
        end
        object pnlValor: TCategoryPanel
          Top = 487
          Height = 57
          Caption = 'Valor'
          Locked = True
          TabOrder = 5
          ExplicitWidth = 287
          object edtValor: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = edtValorChange
            OnEnter = edtValorEnter
            OnExit = edtValorExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlAdiantamento: TCategoryPanel
          Top = 430
          Height = 57
          Caption = 'Adiantamento'
          Locked = True
          TabOrder = 6
          Visible = False
          ExplicitWidth = 185
          object edtAdiantamento: TComboBoxFocus
            Left = 8
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              ''
              'Sim'
              'N'#227'o')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlNatOpe: TCategoryPanel
          Top = 373
          Height = 57
          Caption = 'Condi'#231#227'o de Pagamento'
          Locked = True
          TabOrder = 7
          Visible = False
          ExplicitWidth = 185
          object edtNatOpe: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              #192' Vista'
              #192' Prazo'
              'Todos')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlOrigem: TCategoryPanel
          Top = 316
          Height = 57
          Caption = 'Origem'
          TabOrder = 8
          ExplicitWidth = 185
          object edtOrigem: TComboBoxFocus
            Left = 8
            Top = 5
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = edtOrigemChange
            Items.Strings = (
              ''
              'CTR'
              'CTP'
              'CHQ'
              'TRF'
              'MCA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlCfop: TCategoryPanel
          Top = 114
          Height = 202
          Caption = 'CFOP'#39's'
          Locked = True
          TabOrder = 9
          Visible = False
          ExplicitWidth = 185
          object Label10: TLabel
            Left = 10
            Top = 8
            Width = 29
            Height = 14
            Caption = 'Todos'
          end
          object Label1: TLabel
            Left = 198
            Top = 8
            Width = 65
            Height = 14
            Caption = 'Selecionados'
          end
          object Label12: TLabel
            Left = 10
            Top = 138
            Width = 110
            Height = 14
            Caption = 'Natureza de Opera'#231#227'o'
          end
          object lstCfoTod: TListBox
            Left = 10
            Top = 25
            Width = 75
            Height = 112
            ItemHeight = 14
            MultiSelect = True
            TabOrder = 0
            OnDblClick = lstCfoTodDblClick
          end
          object lstCfoSel: TListBox
            Left = 198
            Top = 25
            Width = 75
            Height = 112
            ItemHeight = 14
            MultiSelect = True
            TabOrder = 1
            OnDblClick = lstCfoSelDblClick
            OnKeyDown = lstCfoSelKeyDown
          end
          object btnAddCfo: TBitBtnLocked
            Left = 88
            Top = 25
            Width = 25
            Height = 25
            Caption = '>'
            TabOrder = 2
            OnClick = btnAddCfoClick
          end
          object btnClaTod: TBitBtnLocked
            Left = 88
            Top = 74
            Width = 47
            Height = 47
            Caption = 'CFOPs venda >'
            TabOrder = 3
            WordWrap = True
            OnClick = btnClaTodClick
          end
          object btnAddTod: TBitBtnLocked
            Left = 88
            Top = 49
            Width = 25
            Height = 25
            Caption = '>>'
            TabOrder = 4
            OnClick = btnAddTodClick
          end
          object btnRemTod: TBitBtnLocked
            Left = 170
            Top = 49
            Width = 25
            Height = 25
            Caption = '<<'
            TabOrder = 5
            OnClick = btnRemTodClick
          end
          object btnRemCfo: TBitBtnLocked
            Left = 170
            Top = 25
            Width = 25
            Height = 25
            Caption = '<'
            TabOrder = 6
            OnClick = btnRemCfoClick
          end
          object edtNatCfo: TDBLookupComboBox
            Left = 10
            Top = 153
            Width = 263
            Height = 22
            DataField = 'KeyValue'
            DataSource = dtsNatKey
            DropDownWidth = 500
            KeyField = 'AUTOINCREM'
            ListField = 'NAT_DESCRI;NAT_CODCFO'
            ListSource = dtsNatCfo
            NullValueKey = 46
            TabOrder = 7
            OnDropDown = edtNatCfoDropDown
          end
        end
        object pnlForPag: TCategoryPanel
          Top = 57
          Height = 57
          Caption = 'Forma de Pagamento'
          Locked = True
          TabOrder = 10
          Visible = False
          ExplicitWidth = 185
          object edtForPag: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = edtForPagChange
            OnExit = edtForPagExit
            Items.Strings = (
              'Dinheiro'
              'Cheque '#224' vista'
              'Cheque pr'#233
              'Cart'#227'o '
              'Ordem de Pagamento'
              'Todas')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlTipLan: TCategoryPanel
          Top = 0
          Height = 57
          Caption = 'Tipo de Lan'#231'amento'
          Locked = True
          TabOrder = 11
          ExplicitWidth = 185
          object edtTipLan: TComboBoxFocus
            Left = 7
            Top = 6
            Width = 250
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = edtTipLanChange
            Items.Strings = (
              'CTP-Contas '#224' Pagar'
              'CTR-Contas '#224' receber '
              'CHQ-Cheque '
              'CAR-Cart'#227'o '
              'BAN-Movimento Banc'#225'rio '
              'ENT-Entrada de Mercadorias'
              'SAI-Sa'#237'da de Mercadorias '
              'COE-Conhecimento de Entrada '
              'COS-Conhecimento de Sa'#237'da')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlOrigemCPC: TCategoryPanel
          Top = 906
          Height = 180
          Caption = 'Origem'
          Locked = True
          TabOrder = 12
          ExplicitWidth = 185
          object lstOrigemCPC: TcxCheckListBox
            Left = 7
            Top = 6
            Width = 251
            Height = 144
            Items = <>
            ScrollWidth = 350
            TabOrder = 0
            OnClickCheck = lstOrigemCPCClickCheck
          end
        end
      end
      object CategoryPanelGroup2: TCategoryPanelGroup
        Left = 289
        Top = 0
        Width = 727
        Height = 385
        VertScrollBar.Tracking = True
        Align = alClient
        Color = 15790320
        GradientColor = 15790320
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        TabOrder = 1
        object CategoryPanel2: TCategoryPanel
          Top = 189
          Caption = 'Vig'#234'ncia'
          TabOrder = 0
          ExplicitWidth = 725
          object Label19: TLabel
            Left = 22
            Top = 6
            Width = 84
            Height = 14
            Caption = 'In'#237'cio da Vig'#234'ncia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 149
            Top = 6
            Width = 82
            Height = 14
            Caption = 'Final da Vig'#234'ncia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object mskVigIni: TMaskEditFocus
            Left = 22
            Top = 22
            Width = 116
            Height = 22
            EditMask = '99/99/9999'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskVigFin: TMaskEditFocus
            Left = 149
            Top = 22
            Width = 116
            Height = 22
            EditMask = '99/99/9999'
            MaxLength = 10
            TabOrder = 1
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
        end
        object CategoryPanel1: TCategoryPanel
          Top = 0
          Height = 189
          Caption = 'Lan'#231'amentos'
          TabOrder = 1
          ExplicitWidth = 185
          object Label2: TLabel
            Left = 22
            Top = 11
            Width = 28
            Height = 14
            Caption = 'Conta'
          end
          object Label3: TLabel
            Left = 381
            Top = 6
            Width = 30
            Height = 14
            Caption = 'Cli/For'
          end
          object Label4: TLabel
            Left = 417
            Top = 6
            Width = 41
            Height = 14
            Caption = 'Portador'
          end
          object Label5: TLabel
            Left = 2
            Top = 11
            Width = 17
            Height = 14
            Caption = 'C/D'
          end
          object Label6: TLabel
            Left = 7
            Top = 55
            Width = 7
            Height = 14
            Caption = 'C'
          end
          object Label7: TLabel
            Left = 7
            Top = 31
            Width = 7
            Height = 14
            Caption = 'D'
          end
          object Label8: TLabel
            Left = 22
            Top = 76
            Width = 42
            Height = 14
            Caption = 'Hist'#243'rico'
          end
          object Label9: TLabel
            Left = 318
            Top = 76
            Width = 64
            Height = 14
            Caption = 'Complemento'
          end
          object Label11: TLabel
            Left = 464
            Top = -1
            Width = 41
            Height = 28
            Alignment = taCenter
            Caption = 'Plano de Contas'
            WordWrap = True
          end
          object Label13: TLabel
            Left = 590
            Top = 6
            Width = 53
            Height = 14
            Caption = 'Considerar'
          end
          object Label14: TLabel
            Left = 509
            Top = 6
            Width = 43
            Height = 14
            Alignment = taCenter
            Caption = 'Bandeira'
            WordWrap = True
          end
          object Label15: TLabel
            Left = 556
            Top = -2
            Width = 32
            Height = 28
            Alignment = taCenter
            Caption = 'Abrev. Prod.'
            WordWrap = True
          end
          object Label16: TLabel
            Left = 149
            Top = 11
            Width = 76
            Height = 14
            Caption = 'Conta Reduzida'
          end
          object edtDesContaCRedito: TEditFocus
            Left = 221
            Top = 52
            Width = 124
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesContaDebito: TEditFocus
            Left = 221
            Top = 28
            Width = 124
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnConfirmar: TBitBtnLocked
            Left = 600
            Top = 90
            Width = 115
            Height = 25
            Caption = 'Confirmar'
            TabOrder = 14
            OnClick = btnConfirmarClick
          end
          object edtCmpDebito: TComboBoxFocus
            Left = 318
            Top = 91
            Width = 276
            Height = 22
            Style = csDropDownList
            TabOrder = 5
            Items.Strings = (
              ''
              'N. Docto'
              'N. Docto. Nome fornecedor/cliente'
              'Nome fornecedor/cliente'
              'N. Conhecimento. Nome transportadora'
              'N. Docto. / CNPJ / Nome fornecedor/cliente')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtHisCre: TEditFocus
            Tag = 99
            Left = 22
            Top = 91
            Width = 30
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 11
            OnExit = edtHisCreExit
            OnKeyPress = edtHisCreKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesHisCre: TEditFocus
            Left = 54
            Top = 91
            Width = 258
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            TabOrder = 12
            OnKeyPress = edtHisCreKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskContaCredito: TMaskEditFocus
            Left = 22
            Top = 52
            Width = 126
            Height = 22
            TabOrder = 6
            Text = ''
            OnExit = mskContaCreditoExit
            OnKeyPress = mskContaCreditoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskContaDebito: TMaskEditFocus
            Left = 22
            Top = 28
            Width = 126
            Height = 22
            TabOrder = 0
            Text = ''
            OnExit = mskContaDebitoExit
            OnKeyPress = mskContaDebitoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object btnPlaNcoDeb: TBitBtnLocked
            Left = 347
            Top = 27
            Width = 34
            Height = 23
            Hint = 'Conta Desmembrada por Empresa'
            Caption = '(0)'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnPlaNcoDebClick
          end
          object btnPlaNcoCre: TBitBtnLocked
            Left = 347
            Top = 52
            Width = 34
            Height = 23
            Hint = 'Conta Desmembrada por Empresa'
            Caption = '(0)'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            OnClick = btnPlaNcoCreClick
          end
          object gbCredito: TGroupBox
            Left = 383
            Top = 52
            Width = 327
            Height = 24
            TabOrder = 10
            object chkCliForCre: TCheckBox
              Left = 8
              Top = 3
              Width = 25
              Height = 17
              TabOrder = 0
              OnClick = chkCliForCreClick
            end
            object chkPorCre: TCheckBox
              Left = 48
              Top = 3
              Width = 25
              Height = 17
              TabOrder = 1
              OnClick = chkPorCreClick
            end
            object chkPlaConCre: TCheckBox
              Left = 98
              Top = 3
              Width = 25
              Height = 17
              TabOrder = 2
              OnClick = chkPlaConCreClick
            end
            object rdbCreCad: TRadioButton
              Left = 258
              Top = 3
              Width = 65
              Height = 17
              Caption = 'Cadastro'
              TabOrder = 6
            end
            object rdbCreBai: TRadioButton
              Left = 205
              Top = 3
              Width = 50
              Height = 17
              Caption = 'Baixa'
              Checked = True
              TabOrder = 5
              TabStop = True
            end
            object chkBandeiraCredito: TCheckBox
              Left = 139
              Top = 3
              Width = 25
              Height = 17
              Enabled = False
              TabOrder = 3
              OnClick = chkBandeiraCreditoClick
            end
            object chkAbrevCredito: TCheckBox
              Left = 183
              Top = 3
              Width = 18
              Height = 17
              Enabled = False
              TabOrder = 4
              OnClick = chkAbrevCreditoClick
            end
          end
          object gbDebito: TGroupBox
            Left = 383
            Top = 26
            Width = 327
            Height = 24
            TabOrder = 4
            object chkCliForDeb: TCheckBox
              Left = 8
              Top = 4
              Width = 25
              Height = 17
              TabOrder = 0
              OnClick = chkCliForDebClick
            end
            object chkPorDeb: TCheckBox
              Left = 48
              Top = 4
              Width = 25
              Height = 17
              TabOrder = 1
              OnClick = chkPorDebClick
            end
            object chkPlaConDeb: TCheckBox
              Left = 98
              Top = 4
              Width = 25
              Height = 17
              TabOrder = 2
              OnClick = chkPlaConDebClick
            end
            object rdbDebBai: TRadioButton
              Left = 205
              Top = 4
              Width = 50
              Height = 17
              Caption = 'Baixa'
              Checked = True
              TabOrder = 5
              TabStop = True
            end
            object rdbDebCad: TRadioButton
              Left = 258
              Top = 4
              Width = 65
              Height = 17
              Caption = 'Cadastro'
              TabOrder = 6
            end
            object chkBandeiraDebito: TCheckBox
              Left = 139
              Top = 4
              Width = 25
              Height = 17
              Enabled = False
              TabOrder = 3
              OnClick = chkBandeiraDebitoClick
            end
            object chkAbrevDebito: TCheckBox
              Left = 183
              Top = 3
              Width = 17
              Height = 17
              Enabled = False
              TabOrder = 4
              OnClick = chkAbrevDebitoClick
            end
          end
          object cklComplemento: TCheckListBox
            Left = 318
            Top = 91
            Width = 276
            Height = 66
            ItemHeight = 14
            TabOrder = 13
          end
          object edtContaReduzidaCredito: TEditFocus
            Left = 149
            Top = 52
            Width = 71
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 7
            OnEnter = edtContaReduzidaCreditoEnter
            OnExit = edtContaReduzidaCreditoExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtContaReduzidaDebito: TEditFocus
            Left = 149
            Top = 28
            Width = 71
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 1
            OnEnter = edtContaReduzidaDebitoEnter
            OnExit = edtContaReduzidaDebitoExit
            NormalColor = clWindow
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
    object pnlFiltros: TPanel
      Left = 1
      Top = 386
      Width = 1016
      Height = 29
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        1016
        29)
      object Label17: TLabel
        Left = 11
        Top = 8
        Width = 170
        Height = 14
        Caption = 'Par'#226'metros a serem exibidos: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 777
        Top = 8
        Width = 112
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Data para a Exibi'#231#227'o: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rdbInativos: TRadioButton
        Left = 248
        Top = 7
        Width = 63
        Height = 16
        Caption = 'Inativos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = rdbInativosClick
      end
      object rdbAtivos: TRadioButton
        Left = 187
        Top = 7
        Width = 55
        Height = 16
        Caption = 'Ativos'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = rdbAtivosClick
      end
      object rdbTodos: TRadioButton
        Left = 317
        Top = 7
        Width = 65
        Height = 16
        Caption = 'Todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = rdbTodosClick
      end
      object mskDataExibicao: TMaskEditFocus
        Left = 895
        Top = 4
        Width = 116
        Height = 22
        Anchors = [akTop, akRight]
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        OnExit = mskDataExibicaoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
  end
  inherited pnlBotoes: TPanel [2]
    Top = 590
    Width = 1018
    TabOrder = 2
    ExplicitTop = 590
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnExportar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Hint = 'Exportar os Dados para Planilha Eletr'#244'nica'
        Caption = '&Exportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 140
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 304
  end
  object dtsDados: TDataSource
    Left = 328
    Top = 356
  end
  object dtsNatCfo: TDataSource
    AutoEdit = False
    Left = 402
    Top = 149
  end
  object cdsNatKey: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 574
    Top = 249
    object cdsNatKeyKeyValue: TStringField
      FieldName = 'KeyValue'
    end
  end
  object dtsNatKey: TDataSource
    DataSet = cdsNatKey
    Left = 646
    Top = 249
  end
  object cdsGrupoProd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 574
    Top = 302
    object cdsGrupoProdSELECI: TBooleanField
      FieldName = 'SELECI'
    end
    object cdsGrupoProdGRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 80
    end
    object cdsGrupoProdCODGRU: TStringField
      FieldName = 'CODGRU'
      Size = 6
    end
    object cdsGrupoProdDESGRU: TStringField
      FieldName = 'DESGRU'
      Size = 70
    end
  end
  object dsGrupoProd: TDataSource
    DataSet = cdsGrupoProd
    Left = 642
    Top = 302
  end
  object StyleRepository: TcxStyleRepository
    Left = 810
    Top = 249
    PixelsPerInch = 96
    object estiloInativo: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
    object estiloPadrao: TcxStyle
    end
  end
end
