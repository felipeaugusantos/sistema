inherited frmCadClassFiscal: TfrmCadClassFiscal
  Left = 174
  Top = 172
  Width = 650
  Height = 597
  Caption = 'Cadastro de Classifica'#231#245'es Fiscais'
  ExplicitWidth = 650
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 644
    Height = 25
    TabOrder = 1
    ExplicitTop = 527
    ExplicitWidth = 644
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 570
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 570
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        ExplicitWidth = 71
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        ExplicitLeft = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        ExplicitLeft = 142
        ExplicitWidth = 71
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        ExplicitLeft = 213
        ExplicitWidth = 71
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 71
        ExplicitLeft = 284
        ExplicitWidth = 71
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 71
        ExplicitLeft = 355
        ExplicitWidth = 71
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 572
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 572
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 552
    Width = 644
    TabOrder = 3
    ExplicitTop = 552
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 473
      Width = 171
      ExplicitLeft = 473
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 473
      ExplicitWidth = 473
    end
  end
  inherited pgcDados: TPageControl
    Width = 644
    Height = 527
    Visible = False
    ExplicitWidth = 644
    ExplicitHeight = 527
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 636
      ExplicitHeight = 495
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 644
    Height = 527
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 54
      Top = 13
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'CFOP:'
    end
    object Label2: TLabel
      Left = 32
      Top = 36
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label10: TLabel
      Left = 32
      Top = 220
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Presta'#231#227'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 126
      Top = 220
      Width = 151
      Height = 14
      Caption = '(I)ndustria (C)om'#233'rcio (G)eral   '
      CorDestaque = clRed
    end
    object Label4: TLabel
      Left = 29
      Top = 151
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem:'
    end
    object dbeDescr2: TDBEditFocus
      Left = 86
      Top = 55
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_DESCR2'
      DataSource = dtsCadCfo
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCfo: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_CODCFO'
      DataSource = dtsCadCfo
      TabOrder = 0
      OnExit = dbeCodCfoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescr1: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 32
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_DESCR1'
      DataSource = dtsCadCfo
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescr3: TDBEditFocus
      Left = 86
      Top = 78
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_DESCR3'
      DataSource = dtsCadCfo
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescr5: TDBEditFocus
      Left = 86
      Top = 124
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_DESCR5'
      DataSource = dtsCadCfo
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEMNAT01: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 147
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_MNAT01'
      DataSource = dtsCadCfo
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEMNAT02: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 170
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_MNAT02'
      DataSource = dtsCadCfo
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEMNAT03: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 193
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_MNAT03'
      DataSource = dtsCadCfo
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePresta: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 216
      Width = 36
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_PRESTA'
      DataSource = dtsCadCfo
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescr4: TDBEditFocus
      Left = 86
      Top = 101
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFO_DESCR4'
      DataSource = dtsCadCfo
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object PageControl1: TPageControl
      Left = 4
      Top = 242
      Width = 645
      Height = 275
      ActivePage = TabNatOpe
      Style = tsFlatButtons
      TabOrder = 10
      object TabSped: TTabSheet
        Caption = 'Plano de Contas SPED'
        object grbPlaConSped: TGroupBox
          Left = 0
          Top = 2
          Width = 500
          Height = 153
          Caption = 'Plano de Contas SPED:'
          TabOrder = 0
          object Label5: TLabel
            Left = 36
            Top = 40
            Width = 128
            Height = 14
            Alignment = taRightJustify
            Caption = 'Indicador do Tipo de Conta'
          end
          object Label6: TLabel
            Left = 36
            Top = 69
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Conta Cont'#225'bil:'
          end
          object Label7: TLabel
            Left = 82
            Top = 97
            Width = 26
            Height = 14
            Alignment = taRightJustify
            Caption = 'N'#237'vel:'
          end
          object Label8: TLabel
            Left = 33
            Top = 128
            Width = 131
            Height = 14
            Alignment = taRightJustify
            Caption = 'Natureza da Conta Cont'#225'bil'
          end
          object cbbIndicadorTipoConta: TComboBoxFocus
            Tag = 99
            Left = 170
            Top = 37
            Width = 225
            Height = 22
            Style = csDropDownList
            Enabled = False
            ItemIndex = 0
            TabOrder = 1
            Text = 'Anal'#237'tico - Conta'
            Items.Strings = (
              'Anal'#237'tico - Conta'
              'Sint'#233'tico - Grupo de Contas')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeConCon: TDBEditFocus
            Tag = 99
            Left = 111
            Top = 66
            Width = 220
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CFO_CONCON'
            DataSource = dtsCadCfo
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeNivel: TDBEditFocus
            Tag = 99
            Left = 111
            Top = 94
            Width = 220
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CFO_NIVEL_'
            DataSource = dtsCadCfo
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object cbbNaturezaContaContabil: TComboBoxFocus
            Left = 170
            Top = 125
            Width = 225
            Height = 22
            Style = csDropDownList
            Enabled = False
            ItemIndex = 5
            TabOrder = 4
            Text = '09 - Outras'
            Items.Strings = (
              '01 - Contas de Ativo'
              '02 - Contas de Passivo'
              '03 - Patrim'#244'nio L'#237'quido'
              '04 - Contas de Resultado'
              '05 - Contas de Compensa'#231#227'o'
              '09 - Outras')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object chkEnviarSpedFiscal: TDBCheckBox
            Left = 24
            Top = 17
            Width = 201
            Height = 17
            Caption = 'Enviar para o SPED Fiscal'
            DataField = 'CFO_EVSPED'
            DataSource = dtsCadCfo
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkEnviarSpedFiscalClick
          end
        end
      end
      object TabNatOpe: TTabSheet
        Caption = 'Classifica'#231#245'es Fiscais - Natureza da Opera'#231#227'o'
        ImageIndex = 1
        object lblCndPag: TLabel
          Left = 3
          Top = 9
          Width = 113
          Height = 14
          Alignment = taRightJustify
          Caption = 'Natureza da Opera'#231#227'o:'
        end
        object btnIncNat: TBitBtnLocked
          Left = 459
          Top = 6
          Width = 39
          Height = 22
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
            7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF313131726E726A66697D797A2929293838384242422828286868683131
            31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
            6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
            CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
            203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
            A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
            E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
            D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
            ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
            FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
            2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
            5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
            DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
            D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
            C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnIncNatClick
        end
        object edtNatOperacao: TEditFocus
          Tag = 99
          Left = 119
          Top = 6
          Width = 336
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 150
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 150
          TipoTexto = ttAlfanumerico
        end
        object cxgNatOpe: TcxGrid
          Left = 0
          Top = 34
          Width = 498
          Height = 209
          TabOrder = 2
          TabStop = False
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgNatOpeView: TcxGridDBTableView
            OnKeyDown = cxgNatOpeViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsNatOpe
            DataController.KeyFieldNames = 'AUTOINCREM'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '  '
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxgNatOpeViewNAT_CODCFO: TcxGridDBColumn
              Visible = False
            end
            object cxgNatOpeViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Natureza da Opera'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Options.Editing = False
              Options.Moving = False
              SortIndex = 0
              SortOrder = soAscending
              Width = 452
            end
            object cxgNatOpeViewNAT_ATIVO_: TcxGridDBColumn
              Caption = 'Ativo'
              DataBinding.FieldName = 'NAT_ATIVO_'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              Properties.OnValidate = cxgNatOpeViewNAT_ATIVO_PropertiesValidate
              Options.Moving = False
              Width = 44
            end
          end
          object cxgNatOpeLevel: TcxGridLevel
            GridView = cxgNatOpeView
          end
        end
      end
      object tabCorrelacaoEntMer: TTabSheet
        Caption = 'Correla'#231#227'o de CFOP para Entrada de Mercadorias'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grbClaEnt: TGroupBox
          Left = 3
          Top = 3
          Width = 382
          Height = 81
          Caption = 'Correla'#231#227'o de CFOP para Entrada de Mercadorias:'
          TabOrder = 0
          object lblClaSub: TLabel
            Left = 9
            Top = 28
            Width = 258
            Height = 14
            Alignment = taRightJustify
            Caption = 'Para produtos substitu'#237'dos ou conhecimento de frete:'
          end
          object lblClaEnt: TLabel
            Left = 114
            Top = 55
            Width = 153
            Height = 14
            Alignment = taRightJustify
            Caption = 'Para produtos n'#227'o substitu'#237'dos:'
          end
          object dbeClaSub: TDBEditFocus
            Tag = 99
            Left = 269
            Top = 20
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CFO_CLASUB'
            DataSource = dtsCadCfo
            TabOrder = 0
            OnKeyPress = dbeClaSubKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeClaEnt: TDBEditFocus
            Tag = 99
            Left = 269
            Top = 47
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CFO_CLAENT'
            DataSource = dtsCadCfo
            TabOrder = 1
            OnKeyPress = dbeClaSubKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
        end
      end
    end
    object btnCorrelacaoEntMerEmpresas: TBitBtnLocked
      Left = 180
      Top = 9
      Width = 35
      Height = 22
      Hint = 
        'Cadastrar Correla'#231#227'o de CFOP para Entrada de Mercadorias Por Emp' +
        'resas'
      Caption = '+'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      TabStop = False
      OnClick = btnCorrelacaoEntMerEmpresasClick
    end
    object GroupBox1: TGroupBox
      Left = 512
      Top = 9
      Width = 130
      Height = 229
      Caption = 'Modelos Permitidos'
      TabOrder = 12
      object lblMarcacoes: TLabel
        Left = 2
        Top = 171
        Width = 126
        Height = 14
        Align = alBottom
        Caption = 'Op'#231#245'es de Marca'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblMarcacoesClick
        ExplicitWidth = 104
      end
      object Label3: TLabel
        Left = 2
        Top = 185
        Width = 126
        Height = 42
        Align = alBottom
        Caption = 
          'Se todos estiverem desmarcado, todos os modelos ser'#227'o permitidos' +
          '.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = lblMarcacoesClick
        ExplicitLeft = -7
        ExplicitTop = 141
      end
      object cxGridCitel1: TcxGridCitel
        Left = 2
        Top = 16
        Width = 126
        Height = 155
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsModelos
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxModeloSelecionado: TcxGridDBColumn
            Caption = 'Sel.'
            DataBinding.FieldName = 'SELECIONADO'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Width = 28
          end
          object cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn
            Caption = 'Modelo'
            DataBinding.FieldName = 'CFO_MODELO'
            MinWidth = 64
            Options.Editing = False
          end
        end
        object cxGridCitel1Level1: TcxGridLevel
          GridView = cxGridCitel1DBTableViewCitel1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 64
  end
  object dtsCadCfo: TDataSource
    OnStateChange = dtsCadCfoStateChange
    OnDataChange = dtsCadCfoDataChange
    Left = 112
    Top = 120
  end
  object dtsNatOpe: TDataSource
    Left = 32
    Top = 120
  end
  object dtsModelos: TDataSource
    Left = 816
    Top = 88
  end
  object popMarcacoes: TPopupMenu
    Left = 552
    Top = 296
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarTodos1: TMenuItem
      Caption = 'Desmarca Todos'
      OnClick = DesmarTodos1Click
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
