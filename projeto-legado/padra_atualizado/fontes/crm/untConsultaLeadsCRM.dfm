inherited frmConsultaLeadsCRM: TfrmConsultaLeadsCRM
  Width = 1168
  Height = 768
  Caption = 'Consulta Leads CRM'
  WindowState = wsMaximized
  ExplicitWidth = 1168
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 675
    Width = 1162
    ExplicitTop = 675
    ExplicitWidth = 1162
    inherited FlwBotoes: TFlowPanel
      Width = 1158
      ExplicitWidth = 1158
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1162
    ExplicitTop = 723
    ExplicitWidth = 1162
    inherited pnlNomeForm: TPanel
      Left = 991
      ExplicitLeft = 991
    end
    inherited pnlInfo: TPanel
      Width = 991
      ExplicitWidth = 991
    end
  end
  inherited pgcDados: TPageControl
    Width = 1162
    Height = 675
    ExplicitWidth = 1162
    ExplicitHeight = 675
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1154
      ExplicitHeight = 643
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1162
    Height = 675
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlGrid: TPanel
      Left = 1
      Top = 202
      Width = 1160
      Height = 463
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 2
        Top = 232
        Width = 1156
        Height = 7
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 49
        ExplicitTop = 227
      end
      object dbgLeads: TcxGridCitel
        Left = 2
        Top = 2
        Width = 1156
        Height = 230
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 255
        object dbgLeadsDBTableView1: TcxGridDBTableViewCitel
          OnDblClick = dbgLeadsDBTableView1DblClick
          OnKeyDown = dbgLeadsDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = dbgLeadsDBTableView1CellClick
          OnCustomDrawCell = dbgLeadsDBTableView1CustomDrawCell
          DataController.DataSource = dtsLeads
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.PullFocusing = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum lead dispon'#237'vel>'
          OptionsView.GroupByBox = False
          OnColumnHeaderClick = dbgLeadsDBTableView1ColumnHeaderClick
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object dbgLeadsDBTableView1LDG_NUMDOC: TcxGridDBColumn
            Caption = 'N'#250'mero Lead'
            DataBinding.FieldName = 'LDG_NUMDOC'
          end
          object dbgLeadsDBTableView1LDG_DTACAD: TcxGridDBColumn
            Caption = 'Data Cad.'
            DataBinding.FieldName = 'LDG_DTACAD'
          end
          object dbgLeadsDBTableView1CLI_NOMCLI: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CLI_NOMCLI'
            Width = 323
          end
          object dbgLeadsDBTableView1FAS_OBR: TcxGridDBColumn
            Caption = 'Fase da Obra'
            DataBinding.FieldName = 'FAS_OBR'
            Width = 143
          end
          object dbgLeadsDBTableView1LDG_NOMPRO: TcxGridDBColumn
            Caption = 'Nome do Projeto'
            DataBinding.FieldName = 'LDG_NOMPRO'
          end
          object dbgLeadsDBTableView1NOM_VEN: TcxGridDBColumn
            Caption = 'Vendedor'
            DataBinding.FieldName = 'NOM_VEN'
          end
          object dbgLeadsDBTableView1NOM_EXT: TcxGridDBColumn
            Caption = 'Vendedor Externo'
            DataBinding.FieldName = 'NOM_EXT'
          end
          object dbgLeadsDBTableView1LDG_INIOBR: TcxGridDBColumn
            Caption = 'Data de In'#237'cio da Obra'
            DataBinding.FieldName = 'LDG_INIOBR'
          end
          object dbgLeadsDBTableView1LDG_PREORC: TcxGridDBColumn
            Caption = 'Data de Previs'#227'o do Or'#231'amento'
            DataBinding.FieldName = 'LDG_PREORC'
          end
          object dbgLeadsDBTableView1LDG_TOTVPR: TcxGridDBColumn
            Caption = 'Valor Total da Previs'#227'o do Or'#231'amento'
            DataBinding.FieldName = 'LDG_TOTVPR'
            Width = 212
          end
          object dbgLeadsDBTableView1STATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS'
          end
          object dbgLeadsDBTableView1LDG_DTAFIN: TcxGridDBColumn
            Caption = 'Data da Finaliza'#231#227'o'
            DataBinding.FieldName = 'LDG_DTAFIN'
          end
          object dbgLeadsDBTableView1OPE_FIN: TcxGridDBColumn
            Caption = 'Operador da Finaliza'#231#227'o'
            DataBinding.FieldName = 'OPE_FIN'
            Width = 141
          end
          object dbgLeadsDBTableView1NOM_INS: TcxGridDBColumn
            Caption = 'Instalador'
            DataBinding.FieldName = 'NOM_INS'
          end
          object dbgLeadsDBTableView1CAT_DESCRI: TcxGridDBColumn
            Caption = 'Categoria'
            DataBinding.FieldName = 'CAT_DESCRI'
          end
          object dbgLeadsDBTableView1PREVND: TcxGridDBColumn
            Caption = 'Pr'#233' Venda'
            DataBinding.FieldName = 'PREVND'
          end
          object dbgLeadsDBTableView1QTDORC: TcxGridDBColumn
            Caption = 'Qtd. Or'#231'amentos'
            DataBinding.FieldName = 'QTDORC'
          end
          object dbgLeadsDBTableView1QTDOCO: TcxGridDBColumn
            Caption = 'Qtd. Ocorr'#234'ncias'
            DataBinding.FieldName = 'QTDOCO'
          end
          object dbgLeadsDBTableView1LDG_ULTALT: TcxGridDBColumn
            Caption = #218'lt. Altera'#231#227'o'
            DataBinding.FieldName = 'LDG_ULTALT'
          end
        end
        object dbgLeadsLevel1: TcxGridLevel
          GridView = dbgLeadsDBTableView1
        end
      end
      object pnlItens: TPanel
        Left = 2
        Top = 239
        Width = 1156
        Height = 222
        Align = alBottom
        Caption = 'pnlItens'
        TabOrder = 1
        ExplicitTop = 264
        object pnlRodapeItens: TPanel
          Left = 1
          Top = 180
          Width = 1154
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object lblPrevOrcLead: TLabel
            Left = 9
            Top = 14
            Width = 148
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor previs'#227'o or'#231'. deste lead:'
          end
          object lblTotalPrevOrc: TLabel
            Left = 298
            Top = 14
            Width = 233
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor total da previs'#227'o de todos os or'#231'. listados:'
          end
          object lblQtdTotOrc: TLabel
            Left = 704
            Top = 14
            Width = 108
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. total or'#231'. listados:'
          end
          object cbExibirLinhaGrupo: TCheckBox
            Left = 980
            Top = 30
            Width = 185
            Height = 17
            Caption = 'cbExibirLinhaGrupo'
            Checked = True
            State = cbChecked
            TabOrder = 0
            Visible = False
          end
          object edtTotPrev: TEditFocus
            Left = 163
            Top = 10
            Width = 95
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtTotPrevOrc: TEditFocus
            Left = 535
            Top = 10
            Width = 95
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 2
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtQtdTotOrc: TEditFocus
            Left = 818
            Top = 10
            Width = 95
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
        end
        object cxGridItens: TcxGridCitel
          Left = 1
          Top = 1
          Width = 1154
          Height = 179
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridItensView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsItens
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.PullFocusing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.HideFocusRectOnExit = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum item dispon'#237'vel>'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object cxGridItensViewLDD_LINGRU: TcxGridDBColumn
              Caption = 'Linha/Grupo'
              DataBinding.FieldName = 'LDD_LINGRU'
            end
            object cxGridItensViewDESGRU: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESGRU'
            end
            object cxGridItensViewLDD_VALPRE: TcxGridDBColumn
              Caption = 'Previs'#227'o Or'#231'. R$'
              DataBinding.FieldName = 'LDD_VALPRE'
            end
            object cxGridItensViewLDD_CODMAR: TcxGridDBColumn
              Caption = 'C'#243'd.Marca'
              DataBinding.FieldName = 'LDD_CODMAR'
            end
            object cxGridItensViewDESMAR: TcxGridDBColumn
              Caption = 'Marca'
              DataBinding.FieldName = 'DESMAR'
            end
            object cxGridItensViewLDD_MOEDA_: TcxGridDBColumn
              Caption = 'Moeda'
              DataBinding.FieldName = 'LDD_MOEDA_'
            end
            object cxGridItensViewLDD_KAMFOR: TcxGridDBColumn
              Caption = 'Nome Kam'
              DataBinding.FieldName = 'LDD_KAMFOR'
            end
            object cxGridItensViewLDD_PREVEN: TcxGridDBColumn
              Caption = 'C'#243'd. pr'#233' venda'
              DataBinding.FieldName = 'LDD_PREVEN'
            end
            object cxGridItensViewNOMPVE: TcxGridDBColumn
              Caption = 'Nome pr'#233' venda'
              DataBinding.FieldName = 'NOMPVE'
            end
            object cxGridItensViewLDD_REGIST: TcxGridDBColumn
              Caption = 'Reg.'
              DataBinding.FieldName = 'LDD_REGIST'
            end
            object cxGridItensViewLDD_NUMREG: TcxGridDBColumn
              Caption = 'N'#250'mero registro'
              DataBinding.FieldName = 'LDD_NUMREG'
            end
            object cxGridItensViewLDD_DESCON: TcxGridDBColumn
              Caption = 'Desc.'
              DataBinding.FieldName = 'LDD_DESCON'
            end
            object cxGridItensViewLDD_AUTDES: TcxGridDBColumn
              Caption = 'Autoriza'#231#227'o do desconto'
              DataBinding.FieldName = 'LDD_AUTDES'
            end
            object cxGridItensViewLDD_OBSERV: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'LDD_OBSERV'
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridItensView
          end
        end
      end
    end
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 1160
      Height = 201
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object lblCodCli: TLabel
        Left = 81
        Top = 10
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDtaIni: TLabel
        Left = 488
        Top = 11
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data in'#237'cio da obra:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAteDtaIniObr: TLabel
        Left = 669
        Top = 11
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object lblCodPrj: TLabel
        Left = 80
        Top = 126
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Projeto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodVen: TLabel
        Left = 66
        Top = 33
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodVenExt: TLabel
        Left = 20
        Top = 58
        Width = 102
        Height = 14
        Caption = 'Vendedor Externo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblFasObr: TLabel
        Left = 49
        Top = 80
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fase da Obra:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDtaPrevOrc: TLabel
        Left = 432
        Top = 34
        Width = 158
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Previs'#227'o de Or'#231'amento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAteDtaPrvOrc: TLabel
        Left = 669
        Top = 32
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object lblCodCat: TLabel
        Left = 67
        Top = 103
        Width = 56
        Height = 14
        Caption = 'Categoria:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDtaIniFin: TLabel
        Left = 488
        Top = 58
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da finaliza'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAteDtaIniFin: TLabel
        Left = 669
        Top = 60
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object lblNumDoc: TLabel
        Left = 45
        Top = 151
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero Lead:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodOper: TLabel
        Left = 459
        Top = 81
        Width = 131
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador da finaliza'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodIns: TLabel
        Left = 533
        Top = 104
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Instalador:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 922
        Top = 10
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Cadastro:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 1076
        Top = 10
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object Label3: TLabel
        Left = 62
        Top = 173
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#233'-Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 884
        Top = 82
        Width = 117
        Height = 14
        Caption = 'Cont'#233'm Linha/Grupo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 904
        Top = 105
        Width = 97
        Height = 14
        Caption = 'Cont'#233'm Registro:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 918
        Top = 128
        Width = 83
        Height = 14
        Caption = 'Cont'#233'm Marca:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStatus: TLabel
        Left = 963
        Top = 34
        Width = 38
        Height = 14
        Caption = 'Status:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblMarca: TLabel
        Left = 555
        Top = 128
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 913
        Top = 153
        Width = 88
        Height = 14
        Caption = 'Ordem Exibi'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblLinhaGrupo: TLabel
        Left = 521
        Top = 151
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha/Grupo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpPermissaoVEN: TShape
        Left = 128
        Top = 31
        Width = 6
        Height = 22
        Brush.Color = clGreen
      end
      object shpPermissaoVEE: TShape
        Left = 128
        Top = 54
        Width = 6
        Height = 22
        Brush.Color = clRed
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 128
        Top = 8
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 0
        OnExit = edtCodCliExit
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 597
        Top = 8
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 16
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFim: TMaskEditFocus
        Tag = 99
        Left = 681
        Top = 8
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 17
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtNomCli: TEditFocus
        Left = 214
        Top = 8
        Width = 195
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
      object edtCodPrj: TEditFocus
        Tag = 99
        Left = 128
        Top = 123
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 10
        OnExit = edtCodPrjExit
        OnKeyPress = edtCodPrjKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 25
        TipoTexto = ttAlfanumerico
      end
      object edtDesCodPrj: TEditFocus
        Left = 214
        Top = 123
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnCarrega: TBitBtnLocked
        Left = 898
        Top = 169
        Width = 125
        Height = 26
        Caption = 'Carregar Leads'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          000A000000160000001B000000170000000B0000000200000000000000010000
          00060000000B0000000F0000000C0000000600000001000000000000000F2616
          1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
          1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
          70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
          72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
          D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
          D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
          F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
          F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
          E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
          E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
          A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
          CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
          5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
          CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
          3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
          D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
          1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
          E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
          0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
          C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
          0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
          58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
          0000000000010000000400000006000000050000000200000000000000000000
          0001000000010000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 35
        WordWrap = True
        OnClick = btnCarregaClick
      end
      object edtNomVen: TEditFocus
        Left = 214
        Top = 31
        Width = 195
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
      object edtCodVenExt: TEditFocus
        Tag = 99
        Left = 134
        Top = 54
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 4
        OnExit = edtCodVenExtExit
        OnKeyPress = edtCodVenExtKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomVenExt: TEditFocus
        Left = 214
        Top = 54
        Width = 195
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
      object edtDesFasObr: TEditFocus
        Left = 214
        Top = 77
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFasObr: TEditFocus
        Tag = 99
        Left = 128
        Top = 77
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 6
        OnExit = edtFasObrExit
        OnKeyPress = edtFasObrKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object mskDtaPrevOrc: TMaskEditFocus
        Tag = 99
        Left = 597
        Top = 31
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 18
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFimPrevOrc: TMaskEditFocus
        Tag = 99
        Left = 681
        Top = 31
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 19
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtDesCat: TEditFocus
        Left = 214
        Top = 100
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaIniFin: TMaskEditFocus
        Tag = 99
        Left = 597
        Top = 54
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 20
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFimFin: TMaskEditFocus
        Tag = 99
        Left = 681
        Top = 54
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 21
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 128
        Top = 146
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 12
        OnExit = edtNumDocExit
        OnKeyPress = edtNumDocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtCodOper: TEditFocus
        Tag = 99
        Left = 597
        Top = 77
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 22
        OnExit = edtCodOperExit
        OnKeyPress = edtCodOperKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesOper: TEditFocus
        Left = 683
        Top = 77
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 23
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnCancelar: TBitBtnLocked
        Left = 1029
        Top = 169
        Width = 125
        Height = 26
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 36
        OnClick = btnCancelarClick
      end
      object edtCodIns: TEditFocus
        Tag = 99
        Left = 597
        Top = 100
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 24
        OnExit = edtCodInsExit
        OnKeyPress = edtCodInsKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomIns: TEditFocus
        Left = 683
        Top = 100
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 25
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesNumDoc: TEditFocus
        Left = 214
        Top = 146
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 13
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 134
        Top = 31
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodVenExit
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtCodCat: TEditFocus
        Tag = 99
        Left = 128
        Top = 100
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 6
        TabOrder = 8
        OnExit = edtCodCatExit
        OnKeyPress = edtCodCatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object mskDtaCadIni: TMaskEditFocus
        Tag = 99
        Left = 1007
        Top = 6
        Width = 64
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 28
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaCadFim: TMaskEditFocus
        Tag = 99
        Left = 1088
        Top = 7
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 29
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object cbContemLinGrp: TComboBoxFocus
        Left = 1007
        Top = 77
        Width = 146
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 31
        Items.Strings = (
          'TODOS'
          'SIM'
          'N'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbContemReg: TComboBoxFocus
        Left = 1007
        Top = 100
        Width = 146
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 32
        Items.Strings = (
          'TODOS'
          'SIM'
          'N'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbContemMarca: TComboBoxFocus
        Left = 1007
        Top = 123
        Width = 146
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 33
        OnChange = cbContemMarcaChange
        Items.Strings = (
          'TODOS'
          'SIM'
          'N'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodPVe: TEditFocus
        Tag = 99
        Left = 128
        Top = 169
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 14
        OnExit = edtCodPVeExit
        OnKeyPress = edtCodPVeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomPve: TEditFocus
        Left = 214
        Top = 169
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbStatus: TcxCheckComboBox
        Left = 1007
        Top = 30
        Properties.Items = <>
        TabOrder = 30
        Width = 146
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 597
        Top = 123
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 26
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 683
        Top = 123
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 27
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbOrdemExibicao: TComboBoxFocus
        Left = 1007
        Top = 146
        Width = 146
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 34
        Items.Strings = (
          'TODOS'
          'SIM'
          'N'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodGru: TEditFocus
        Tag = 99
        Left = 597
        Top = 146
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 37
        OnExit = edtCodGruExit
        OnKeyPress = edtCodGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesGru: TEditFocus
        Left = 683
        Top = 146
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 38
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object splDivisor: TcxSplitter
      Left = 1
      Top = 665
      Width = 1160
      Height = 2
      Cursor = crVSplit
      AlignSplitter = salBottom
    end
    object pnlBotoesInferiores: TPanel
      Left = 1
      Top = 667
      Width = 1160
      Height = 7
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      Visible = False
    end
  end
  object pnlBotoesAgregados: TFlowPanel [4]
    Left = 0
    Top = 675
    Width = 1162
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 116
      Height = 24
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAbrirCadLead: TBitBtnLocked
      Left = 116
      Top = 0
      Width = 137
      Height = 24
      Hint = 'Abrir Cadastro de Lead'
      Align = alLeft
      Caption = 'Alterar Lead [F2]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6
        A4C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFE
        FCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBC2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
        FBC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFAF5FEFCFBFEFAF5FEFAF5FE
        FCFBFEFAF5FEFAF5FEFCFBFEFAF5FEFAF5C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFA
        F5C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FE
        F7F0FEF7F0FEF7F0FEF7F0FEF7F0FEF7F0C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FEF3E9FEF7F0FEF7F0FEF3E9FEF7F0FEF7
        F0C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FEF3E9FEF3E9FEF3E9FE
        F3E9FEF3E9FEF3E9FEF3E9FEF3E9FEF3E9C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFF0E2FFF0E2FEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEE
        DEC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FFEEDEFFF0E2FEF3E9FF
        EEDEFFF0E2DDCFC2DDCFC2DDCFC2DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEEDEFFEEDEFFEEDEFFEEDEFFEEDEFFEEDEC3B4A8C3B4A8C3B4A8C3B4
        A8C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FFEEDEFFEAD7FFEEDEFFEAD7FF
        EAD7FFEEDEB0A296B0A296B0A296B0A296C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEAD7FFEAD7FFEAD7FFEAD7FFEAD7C9B9ACFEFAF5FEF7F0E6DAD9C2A6
        A4FF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4FFEAD7FFE6D0FFEAD7FFE6D0FF
        EAD7C5B5A9FEFAF5DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C2A6A4FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0C9B9ACDDCFC2C2A6A4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2
        A6A4C2A6A4C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAbrirCadLeadClick
    end
    object btnExibirLinhaGrupo: TBitBtnLocked
      Left = 253
      Top = 0
      Width = 137
      Height = 24
      Align = alLeft
      Caption = 'Ocultar Linha/Grupo [F3]'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnExibirLinhaGrupoClick
    end
    object btnExportaCSV: TBitBtnLocked
      Left = 390
      Top = 0
      Width = 137
      Height = 24
      Align = alLeft
      Caption = 'Exportar CSV [F4]'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnExportaCSVClick
    end
    object btnPadrao: TBitBtnLocked
      Left = 527
      Top = 0
      Width = 137
      Height = 24
      Align = alLeft
      Caption = '&Ajusta Colunas'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 4
      OnClick = btnPadraoClick
    end
    object btnLarCol: TBitBtnLocked
      Left = 664
      Top = 0
      Width = 149
      Height = 23
      Align = alLeft
      Caption = 'Salva Largura Colunas'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        00080000000D0000000E0000000E0000000F0000000F0000000F0000000F0000
        000F00000010000000100000000F0000000A0000000200000000000000086A48
        3DBF946456FF936355FF936354FF936355FF926355FF926354FF936253FF9262
        53FF916252FF926252FF916252FF68463BC100000009000000000000000AA97B
        6DFFFBF5F2FFF9F2EEFFF9F2EFFFB18474FFD4A795FFD4A794FFD3A795FFAF83
        73FFFBF5F3FFFBF5F2FFFBF5F2FFA67769FF0000000D000000000000000AAB7E
        70FFFBF5F2FFF9F2EEFFF9F2EEFFB28676FFD4A896FFD4A996FFD4A896FFB084
        74FFFBF5F2FFFBF5F2FFFBF5F2FFA87A6BFF0000000D0000000000000009AD81
        72FFD0B4A8FFD0B4A8FFD0B3A8FFB38878FFB38878FFB28777FFB28777FFB286
        77FFD0B2A8FFCFB2A7FFCFB2A7FFAA7D6EFF0000000B0000000000000008AF84
        75FFFBF5F3FFF9F2EEFFF9F2EEFFB5897AFFD6AC99FFD6AC9AFFD6AB99FFB488
        78FFFBF5F2FFFBF5F3FFFBF5F3FFAC8071FF0000000A0000000000000006B186
        78FFFBF5F3FFFBF5F3FFFBF5F2FFB68B7CFFE1C0B1FFE1C0B0FFE1C0B1FFB48A
        7BFFFBF5F2FFFBF5F3FFFBF5F3FFAE8274FF0000000800000000000000039076
        6CC0C29E91FFC29E91FFC29E91FFC29E91FFC19E91FFC19D91FFC19D91FFC19D
        90FFC09D90FFC09D90FFC09C90FF8E746AC20000000500000000000000010000
        0003000000040000000500000005000000050000000500000005000000050000
        0006000000060000000600000006000000040000000100000000000000000000
        00000000000000000000000000004F342CFF0000000000000000000000004F34
        2CFF000000000000000000000000000000000000000000000000000000000000
        0000281B167E000000000000000050352DFF0000000000000000000000005034
        2DFF0000000000000000271A167E000000000000000000000000000000000000
        000053382FFF291B177E0000000053372FFF0000000000000000000000005237
        2EFF00000000281B177E51362DFF000000000000000000000000553A32FF553A
        30FF553931FF553930FF2B1D1981553831FF0000000000000000000000005438
        2FFF2A1C188153382FFF53372FFF53372FFF53372EFF00000000000000000000
        0000583C33FF2C1E1A8100000000573B32FF000000000000000000000000563A
        32FF000000002C1D1981553A31FF000000000000000000000000000000000000
        00002E1F1B810000000000000000593D34FF000000000000000000000000583C
        34FF00000000000000002D1E1981000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 5
      OnClick = btnLarColClick
    end
    object btnSairBaixa: TBitBtnLocked
      AlignWithMargins = True
      Left = 813
      Top = 0
      Width = 137
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[ Esc ] Sair'
      TabOrder = 6
      OnClick = btnSairBaixaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 848
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 848
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 728
    Top = 216
  end
  object dtsLeads: TDataSource
    DataSet = cdsLeads
    Left = 251
    Top = 230
  end
  object cdsLeads: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspLeads'
    AfterScroll = cdsLeadsAfterScroll
    Left = 303
    Top = 230
    object cdsLeadsLDG_NUMDOC: TStringField
      FieldName = 'LDG_NUMDOC'
    end
    object cdsLeadsCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
    end
    object cdsLeadsFAS_OBR: TStringField
      FieldName = 'FAS_OBR'
    end
    object cdsLeadsLDG_NOMPRO: TStringField
      FieldName = 'LDG_NOMPRO'
    end
    object cdsLeadsNOM_VEN: TStringField
      FieldName = 'NOM_VEN'
    end
    object cdsLeadsNOM_EXT: TStringField
      FieldName = 'NOM_EXT'
    end
    object cdsLeadsLDG_TOTVPR: TCurrencyField
      FieldName = 'LDG_TOTVPR'
      DisplayFormat = '#,##0.00'
    end
    object cdsLeadsSTATUS: TStringField
      FieldName = 'STATUS'
    end
    object cdsLeadsOPE_FIN: TStringField
      FieldName = 'OPE_FIN'
    end
    object cdsLeadsNOM_INS: TStringField
      FieldName = 'NOM_INS'
    end
    object cdsLeadsLDG_STATUS: TStringField
      FieldName = 'LDG_STATUS'
    end
    object cdsLeadsLDG_PREORC: TDateField
      FieldName = 'LDG_PREORC'
    end
    object cdsLeadsCODCLI: TStringField
      FieldName = 'CODCLI'
    end
    object cdsLeadsAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsLeadsLDG_INIOBR: TDateField
      FieldName = 'LDG_INIOBR'
    end
    object cdsLeadsLDG_DTAFIN: TDateField
      FieldName = 'LDG_DTAFIN'
    end
    object cdsLeadsCAT_DESCRI: TStringField
      FieldName = 'CAT_DESCRI'
    end
    object cdsLeadsPREVND: TStringField
      FieldName = 'PREVND'
    end
    object cdsLeadsQTDORC: TLargeintField
      FieldName = 'QTDORC'
    end
    object cdsLeadsQTDOCO: TLargeintField
      FieldName = 'QTDOCO'
    end
    object cdsLeadsLDG_ULTALT: TDateTimeField
      FieldName = 'LDG_ULTALT'
    end
    object cdsLeadsLDG_DTACAD: TDateField
      FieldName = 'LDG_DTACAD'
    end
    object cdsLeadsQTDORC_LIS: TFloatField
      FieldName = 'QTDORC_LIS'
    end
    object cdsLeadsTOT_VLRORC: TAggregateField
      FieldName = 'TOT_VLRORC'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(LDG_TOTVPR)'
    end
    object cdsLeadsTOT_QTDORC: TAggregateField
      FieldName = 'TOT_QTDORC'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDORC_LIS)'
    end
  end
  object qryLeads: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 140
    Top = 230
  end
  object dspLeads: TUniDataSetProvider
    DataSet = qryLeads
    Options = []
    Left = 196
    Top = 230
  end
  object imgButton: TImageList
    Left = 136
    Top = 298
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000884
      BD0031ADD60042B5DE0039B5D60021A5D60031ADD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000088CBD00108C
      C60063CEEF0084D6FF007BD6F7007BD6F70063C6E7005ABDE70031ADD6000000
      00000000000000000000000000000000000018427B00215AA500215AA500215A
      A500215AA500215AA500215AA500215AA5002152A5002152A5002152A5002152
      A5002152A50018428C0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001094C600189C
      CE006BCEEF008CDEFF007BD6F70063CEEF0042B5D60073CEF70084D6FF005ABD
      E70000000000000000000000000000000000215AA500316BAD006BA5D60084CE
      F70042A5E70042A5E70042A5E70039A5E700399CE700399CE700399CE700319C
      E700319CDE002973C60010294A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0021A5
      CE007BD6F7009CE7FF008CDEFF0042B5DE000884B50052BDDE007BD6F70084D6
      FF00189CCE00000000000000000000000000296BAD004A84BD004A8CC600B5E7
      FF006BBDEF0052B5EF0052ADEF004AADE7004AADE7004AADE70042A5E70042A5
      E70042A5E7003994D600184A8400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5CE0029AD
      D6009CE7FF00B5EFFF00A5E7FF0052BDDE00087BAD004ABDDE007BD6F7007BD6
      F700189CCE00000000000000000000000000296BB5006BA5D6003984C600ADDE
      F7009CDEF70063BDEF0063BDEF0063BDEF005AB5EF005AB5EF0052B5EF0052B5
      EF0052ADE7004AADE700296BB500000810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5D60031AD
      D600B5E7F700B5EFFF00B5EFFF00A5E7FF001094C6005AC6E70084D6FF0073CE
      F700189CCE000000000000000000000000003173BD008CC6E700529CD60084BD
      E700C6EFFF007BCEF70073CEF70073C6F7006BC6F7006BC6EF006BC6EF0063BD
      EF0063BDEF0063BDEF00428CCE0010294A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0031AD
      D60042B5D6004ABDDE0042B5DE0042B5DE005ABDE7006BCEEF0084D6FF008CDE
      FF00189CCE00000000000000000000000000317BBD00ADE7F70073CEEF005AA5
      D600DEF7FF00DEFFFF00DEF7FF00DEF7FF00DEF7FF00D6F7FF00D6F7FF00CEEF
      FF00C6EFFF00C6EFFF009CCEEF00215284000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D60021A5D60031ADD60031ADD60021A5CE0031ADD6005ABDE70084D6FF006BCE
      EF001094C6000000000000000000000000003984C600C6F7FF0094E7FF0063BD
      E7004A9CD6004A9CD6004A9CD6004A9CCE004A9CCE004A94CE004294CE004294
      CE003173B5003173B5002973B5002963A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D6000884B50021A5CE007BD6F70039B5D60021A5CE000884BD001094C60039B5
      D600108CC600000000000000000000000000398CC600CEF7FF00A5EFFF009CEF
      FF0094E7FF008CE7FF008CDEFF0084DEFF0084DEFF007BDEFF007BD6FF007BD6
      FF00296BB5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000087B
      AD00087BAD00189CC6007BD6F7007BD6F70031ADD600087BAD000884B500108C
      C60000000000000000000000000000000000398CCE00D6FFFF00ADF7FF00ADEF
      FF00A5EFFF00A5EFFF00BDF7FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00CEF7
      FF003184BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000884B5000884B5000000000021A5D600108CC600087BAD00087BAD000000
      0000000000000000000000000000000000003994CE00D6FFFF00B5F7FF00B5F7
      FF00B5F7FF00BDEFFF004A94CE00398CC600398CC600398CC600398CC6003984
      C600296394000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039B5D6000884BD00000000000000000000000000087BAD00087BAD000000
      0000000000000000000000000000000000004294CE00E7FFFF00E7FFFF00E7FF
      FF00D6F7FF00428CBD0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000108CC60063CEEF00189CC60000000000087BAD000884BD00000000000000
      00000000000000000000000000000000000031739C00429CD600429CD600429C
      D6004294CE001031420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000018A5CE0063C6E70052BDDE0031ADD6000884B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E07FFFFF00000000
      C01F000100000000C00F000100000000C007000100000000C007000000000000
      C007000000000000C007000000000000C007000000000000C007000700000000
      E00F000700000000F21F000700000000F39F01FF00000000F13F03FF00000000
      F83FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object cxHint: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Lucida Console'
    HintStyle.Font.Style = []
    Left = 197
    Top = 298
  end
  object qryItens: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 148
    Top = 462
  end
  object dspItens: TUniDataSetProvider
    DataSet = qryItens
    Options = []
    Left = 204
    Top = 462
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 259
    Top = 462
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'LDD_LINGRU'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_VALPRE'
        DataType = ftCurrency
      end
      item
        Name = 'LDD_KAMFOR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_PREVEN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_MOEDA_'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_REGIST'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_DESCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_NUMREG'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_AUTDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_KAFORN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_CODMAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_SEQGER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LDD_OBSERV'
        DataType = ftMemo
      end
      item
        Name = 'DESGRU'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMPVE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESMAR'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspItens'
    StoreDefs = True
    Left = 320
    Top = 462
    object cdsItensLDD_LINGRU: TStringField
      FieldName = 'LDD_LINGRU'
    end
    object cdsItensLDD_VALPRE: TCurrencyField
      FieldName = 'LDD_VALPRE'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensLDD_KAMFOR: TStringField
      FieldName = 'LDD_KAMFOR'
    end
    object cdsItensLDD_PREVEN: TStringField
      FieldName = 'LDD_PREVEN'
    end
    object cdsItensLDD_MOEDA_: TStringField
      FieldName = 'LDD_MOEDA_'
    end
    object cdsItensLDD_REGIST: TStringField
      FieldName = 'LDD_REGIST'
    end
    object cdsItensLDD_DESCON: TStringField
      FieldName = 'LDD_DESCON'
    end
    object cdsItensLDD_NUMREG: TStringField
      FieldName = 'LDD_NUMREG'
    end
    object cdsItensLDD_AUTDES: TStringField
      FieldName = 'LDD_AUTDES'
    end
    object cdsItensLDD_KAFORN: TStringField
      FieldName = 'LDD_KAFORN'
    end
    object cdsItensLDD_CODMAR: TStringField
      FieldName = 'LDD_CODMAR'
    end
    object cdsItensLDD_SEQGER: TStringField
      FieldName = 'LDD_SEQGER'
    end
    object cdsItensLDD_OBSERV: TMemoField
      FieldName = 'LDD_OBSERV'
      BlobType = ftMemo
    end
    object cdsItensDESGRU: TStringField
      FieldName = 'DESGRU'
    end
    object cdsItensNOMPVE: TStringField
      FieldName = 'NOMPVE'
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
    end
    object cdsItensTOTPREVI: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TOTPREVI'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsItensVLR_PREVIS: TAggregateField
      FieldName = 'VLR_PREVIS'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(LDD_VALPRE)'
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 281
    Top = 345
  end
  object dtsColOrd: TDataSource
    DataSet = cdsColOrd
    Left = 491
    Top = 529
  end
  object cdsColOrd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 491
    Top = 473
    object StringField1: TStringField
      FieldName = 'ORDCAP'
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'ORDNAM'
      Size = 50
    end
    object IntegerField1: TIntegerField
      FieldName = 'ORDCAM'
    end
    object StringField3: TStringField
      FieldName = 'ORDDSC'
      Size = 1
    end
  end
  object cdsColOrdItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 715
    Top = 473
    object StringField4: TStringField
      FieldName = 'ORDCAP'
      Size = 50
    end
    object StringField5: TStringField
      FieldName = 'ORDNAM'
      Size = 50
    end
    object IntegerField2: TIntegerField
      FieldName = 'ORDCAM'
    end
    object StringField6: TStringField
      FieldName = 'ORDDSC'
      Size = 1
    end
  end
  object dtsColOrdItens: TDataSource
    DataSet = cdsColOrdItens
    Left = 715
    Top = 529
  end
end
