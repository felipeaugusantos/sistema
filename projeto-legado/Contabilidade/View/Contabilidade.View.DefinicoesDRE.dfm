inherited frmCadDefDemonsResultExerc: TfrmCadDefDemonsResultExerc
  Left = 326
  Top = 371
  Width = 771
  Height = 378
  Caption = 'Cadastro de Defini'#231#245'es DRE'
  OnDestroy = FormDestroy
  ExplicitWidth = 771
  ExplicitHeight = 378
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 307
    Width = 765
    Height = 26
    TabOrder = 2
    ExplicitTop = 307
    ExplicitWidth = 765
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 687
      Height = 22
      ExplicitWidth = 687
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 22
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Height = 22
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 22
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 22
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 22
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 22
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 689
      Width = 74
      Align = alRight
      ExplicitLeft = 689
      ExplicitWidth = 74
    end
  end
  inherited pnlStatus: TPanel
    Top = 333
    Width = 765
    TabOrder = 3
    ExplicitTop = 333
    ExplicitWidth = 765
    inherited pnlNomeForm: TPanel
      Left = 418
      TabOrder = 1
      ExplicitLeft = 418
    end
    inherited pnlInfo: TPanel
      Width = 418
      TabOrder = 0
      ExplicitWidth = 418
    end
  end
  inherited pgcDados: TPageControl
    Width = 765
    Height = 307
    TabOrder = 0
    ExplicitWidth = 765
    ExplicitHeight = 307
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 757
      ExplicitHeight = 275
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 765
    Height = 307
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 761
      Height = 39
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object lblCodigo: TLabel
        Left = 3
        Top = 13
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object lblDescricao: TLabel
        Left = 148
        Top = 13
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object lblVinculo: TLabel
        Left = 607
        Top = 13
        Width = 39
        Height = 14
        Caption = 'V'#237'nculo:'
        Visible = False
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 41
        Top = 9
        Width = 101
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DRE_CODDRE'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 202
        Top = 9
        Width = 331
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DRE_DESCRI'
        DataSource = dtsTabela
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbcTitulo: TDBCheckBox
        Left = 542
        Top = 12
        Width = 50
        Height = 17
        Caption = 'T'#237'tulo?'
        DataField = 'DRE_TITULO'
        DataSource = dtsTabela
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbcTituloClick
      end
      object dbeDreTip: TDBEditFocus
        Tag = 99
        Left = 651
        Top = 9
        Width = 101
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 3
        Visible = False
        OnKeyPress = dbeDreTipKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDados: TPanel
      Left = 2
      Top = 41
      Width = 761
      Height = 264
      Align = alClient
      TabOrder = 1
      object pnlAddConta: TPanel
        Left = 1
        Top = 1
        Width = 759
        Height = 262
        Align = alClient
        Color = 16770261
        Enabled = False
        TabOrder = 0
        object Label1: TLabel
          Left = 240
          Top = 11
          Width = 31
          Height = 14
          Caption = 'Conta:'
        end
        object Label24: TLabel
          Left = 23
          Top = 11
          Width = 26
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sinal:'
        end
        object cxgDados: TcxGridCitel
          Left = 1
          Top = 42
          Width = 757
          Height = 219
          Align = alBottom
          TabOrder = 3
          object cxgDadosTableView: TcxGridDBTableViewCitel
            OnKeyDown = cxgDadosTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxgDadosTableViewCellClick
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgDadosTableViewNCO_SINAL_: TcxGridDBColumn
              Caption = 'Sinal'
              DataBinding.FieldName = 'NCO_SINAL_'
              Width = 55
            end
            object cxgDadosTableViewNCO_CODCON: TcxGridDBColumn
              Caption = 'Conta'
              DataBinding.FieldName = 'NCO_CODCON'
              Width = 154
            end
            object cxgDadosTableViewNCO_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NCO_DESCRI'
              Width = 292
            end
            object cxgDadosTableViewNCO_SEQUEN: TcxGridDBColumn
              Caption = 'Sequencia'
              DataBinding.FieldName = 'NCO_SEQUEN'
              Width = 63
            end
          end
          object cxgDadosLevel1: TcxGridLevel
            GridView = cxgDadosTableView
          end
        end
        object btnAddConta: TBitBtnLocked
          Left = 553
          Top = 6
          Width = 28
          Height = 24
          Hint = 'Adicionar Conta!'
          Caption = '+'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnAddContaClick
        end
        object edtSinal: TComboBoxFocus
          Left = 55
          Top = 7
          Width = 70
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            '-'
            '+')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object mskConta: TMaskEditFocus
          Left = 280
          Top = 7
          Width = 230
          Height = 22
          TabOrder = 1
          Text = ''
          OnKeyPress = mskContaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 128
  end
  object dtsTabela: TDataSource
    Left = 48
    Top = 120
  end
  object dtsDreNco: TDataSource
    Left = 110
    Top = 124
  end
end
