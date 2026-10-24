inherited frmAbreviacaoContabilProdutos: TfrmAbreviacaoContabilProdutos
  Left = 326
  Top = 371
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Abrevia'#231#227'o Cont'#225'bil Produtos'
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 794
    Height = 26
    TabOrder = 2
    ExplicitTop = 529
    ExplicitWidth = 794
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 716
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 790
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
      Left = 718
      Width = 74
      Align = alRight
      ExplicitLeft = 717
      ExplicitWidth = 74
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 529
    TabOrder = 0
    ExplicitWidth = 794
    ExplicitHeight = 527
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 495
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 529
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    ExplicitHeight = 527
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 790
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
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 41
        Top = 9
        Width = 101
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COG_CODIGO'
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
        Width = 565
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COG_DESCRI'
        DataSource = dtsTabela
        TabOrder = 1
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
      Width = 790
      Height = 486
      Align = alClient
      TabOrder = 1
      ExplicitHeight = 484
      object pnlAddReg: TPanel
        Left = 1
        Top = 1
        Width = 788
        Height = 484
        Align = alClient
        Color = 16770261
        TabOrder = 0
        ExplicitHeight = 482
        object cxgDados: TcxGridCitel
          Left = 1
          Top = 92
          Width = 786
          Height = 391
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 389
          object cxgDadosTableView: TcxGridDBTableViewCitel
            OnKeyDown = cxgDadosTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxgDadosTableViewCellClick
            OnEditKeyDown = cxgDadosTableViewEditKeyDown
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgDadosTableViewCOD_DESVAL: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'COD_DESVAL'
              Options.Editing = False
              Width = 100
            end
            object cxgDadosTableViewCOD_CLAFIS: TcxGridDBColumn
              Caption = 'CFOP'
              DataBinding.FieldName = 'COD_CLAFIS'
              Options.Editing = False
              Width = 53
            end
            object cxgDadosTableViewCOD_CONDEB: TcxGridDBColumn
              Caption = 'C. D'#233'bito'
              DataBinding.FieldName = 'COD_CONDEB'
              Width = 150
            end
            object cxgDadosTableViewCONTA_DEBITO: TcxGridDBColumn
              Caption = 'Conta D'#233'bito'
              DataBinding.FieldName = 'CONTA_DEBITO'
              Options.Editing = False
              Width = 200
            end
            object cxgDadosTableViewCOD_CONCRE: TcxGridDBColumn
              Caption = 'C.Cr'#233'dito'
              DataBinding.FieldName = 'COD_CONCRE'
              Width = 150
            end
            object cxgDadosTableViewCONTA_CREDITO: TcxGridDBColumn
              Caption = 'Conta Cr'#233'dito'
              DataBinding.FieldName = 'CONTA_CREDITO'
              Options.Editing = False
              Width = 200
            end
          end
          object cxgDadosLevel1: TcxGridLevel
            GridView = cxgDadosTableView
          end
        end
        object pnlDadosDigitacao: TPanel
          Left = 1
          Top = 1
          Width = 786
          Height = 91
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label3: TLabel
            Left = 64
            Top = 11
            Width = 30
            Height = 14
            Caption = 'CFOP:'
          end
          object Label24: TLabel
            Left = 226
            Top = 11
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor:'
          end
          object Label1: TLabel
            Left = 30
            Top = 39
            Width = 64
            Height = 14
            Caption = 'Conta D'#233'bito:'
          end
          object Label2: TLabel
            Left = 26
            Top = 67
            Width = 68
            Height = 14
            Caption = 'Conta Cr'#233'dito:'
          end
          object mskContaCredito: TMaskEditFocus
            Left = 100
            Top = 63
            Width = 150
            Height = 22
            TabOrder = 4
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
            Left = 100
            Top = 35
            Width = 150
            Height = 22
            TabOrder = 2
            Text = ''
            OnExit = mskContaDebitoExit
            OnKeyPress = mskContaDebitoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtValor: TComboBoxFocus
            Left = 260
            Top = 7
            Width = 150
            Height = 22
            Style = csDropDownList
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtClaFis: TComboBoxFocus
            Left = 100
            Top = 7
            Width = 109
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = edtClaFisChange
            Items.Strings = (
              '-'
              '+')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object btnAddReg: TBitBtnLocked
            Left = 737
            Top = 63
            Width = 28
            Height = 24
            Hint = 'Adicionar Conta!'
            Caption = '+'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = btnAddRegClick
          end
          object edtDesContaDebito: TEditFocus
            Left = 260
            Top = 35
            Width = 465
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
          object edtDesContaCredito: TEditFocus
            Left = 260
            Top = 63
            Width = 465
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
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 447
      TabOrder = 1
      ExplicitLeft = 447
    end
    inherited pnlInfo: TPanel
      Width = 447
      TabOrder = 0
      ExplicitWidth = 447
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
    Left = 676
    Top = 48
  end
  object dtsAbfCod: TDataSource
    Left = 738
    Top = 52
  end
end
