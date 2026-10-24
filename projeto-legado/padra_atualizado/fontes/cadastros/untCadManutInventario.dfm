inherited frmCadManutInventario: TfrmCadManutInventario
  Left = 249
  Top = 267
  Width = 1376
  Height = 738
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Manuten'#231#227'o de Invent'#225'rio'
  Position = poDefault
  ExplicitWidth = 1376
  ExplicitHeight = 738
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 655
    Width = 1360
    ExplicitTop = 655
    ExplicitWidth = 1360
    DesignSize = (
      1360
      28)
    object shpAltera: TShape [0]
      Left = 172
      Top = 6
      Width = 16
      Height = 15
      Brush.Color = 11463062
    end
    object Label1: TLabel [1]
      Left = 191
      Top = 7
      Width = 165
      Height = 14
      Caption = 'Colunas que podem ser alteradas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape [2]
      Left = 370
      Top = 6
      Width = 16
      Height = 15
      Brush.Color = clAqua
    end
    object Label2: TLabel [3]
      Left = 392
      Top = 6
      Width = 94
      Height = 14
      Caption = 'Produtos alteradas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 164
      Align = alNone
      ExplicitWidth = 164
      inherited btnIncluir: TBitBtnLocked
        Visible = False
      end
      inherited btnGravar: TBitBtnLocked
        Anchors = [akTop, akRight]
        Visible = False
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 0
        Top = 20
        Anchors = [akTop, akRight]
        Visible = False
        ExplicitLeft = 0
        ExplicitTop = 20
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 72
        Top = 20
        Visible = False
        ExplicitLeft = 72
        ExplicitTop = 20
      end
      inherited btnCancela: TBitBtnLocked
        Left = 0
        Top = 40
        Anchors = [akTop, akRight]
        Visible = False
        ExplicitLeft = 0
        ExplicitTop = 40
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 72
        Top = 40
        Width = 79
        Anchors = [akTop, akRight]
        Visible = False
        ExplicitLeft = 72
        ExplicitTop = 40
        ExplicitWidth = 79
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1283
      Anchors = [akTop, akRight]
      ExplicitLeft = 1283
    end
    object btnAjustar: TBitBtnLocked
      Left = 3
      Top = 4
      Width = 158
      Height = 20
      Caption = '[ F4 ] Consultar valor / Ajustar '
      TabOrder = 2
      OnClick = btnAjustarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 683
    Width = 1360
    ExplicitTop = 683
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1013
      ExplicitLeft = 1013
    end
    inherited pnlInfo: TPanel
      Width = 1013
      ExplicitWidth = 1013
    end
  end
  inherited pgcDados: TPageControl
    Width = 1360
    Height = 627
    Enabled = False
    ExplicitWidth = 1360
    ExplicitHeight = 627
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1352
      ExplicitHeight = 595
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 1360
    Height = 627
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object cxItens: TcxGrid
      Left = 0
      Top = 0
      Width = 1360
      Height = 627
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItens: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgItensCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir filtros'
        FilterRow.Visible = True
        OptionsView.GroupByBox = False
        Styles.Selection = cxStyle1
        object cxgItensCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'ITE_CODITE'
          MinWidth = 64
          Options.Editing = False
        end
        object cxgItensCODGRU: TcxGridDBColumn
          Caption = 'Grupo'
          DataBinding.FieldName = 'ITE_CODGRU'
          MinWidth = 64
          Options.Editing = False
        end
        object cxgItensCODABF: TcxGridDBColumn
          Caption = 'Abr. Fiscal'
          DataBinding.FieldName = 'ITE_CODABF'
          MinWidth = 64
          Options.Editing = False
        end
        object cxgItensCODUNI: TcxGridDBColumn
          Caption = 'UN'
          DataBinding.FieldName = 'ITE_CODUNI'
          Options.Editing = False
          Width = 20
        end
        object cxgItensDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'ITE_DESITE'
          Options.Editing = False
        end
        object cxgItensDESMAR: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'MAR_DESMAR'
        end
        object cxgItensREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'ITE_REFERE'
          Options.Editing = False
        end
        object cxgItensSALDOS: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'ITE_SALDOS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
        end
        object cxgItensSAL_ML: TcxGridDBColumn
          Caption = 'Saldo ML'
          DataBinding.FieldName = 'ITE_SAL_ML'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
        end
        object cxgItensCNV_ML: TcxGridDBColumn
          Caption = 'Fator Tintom'#233'trico'
          DataBinding.FieldName = 'ITE_CNV_ML'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 92
        end
        object cxgItensPRECOM: TcxGridDBColumn
          Caption = 'Pre'#231'o Compra'
          DataBinding.FieldName = 'ITE_PRECOM'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 2
          Options.Editing = False
          Width = 74
        end
        object cxgItensPRECUS: TcxGridDBColumn
          Caption = 'Pre'#231'o Custo'
          DataBinding.FieldName = 'ITE_PRECUS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 65
        end
        object cxgItensPREVE1: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 1'
          DataBinding.FieldName = 'ITE_PREVE1'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 89
        end
        object cxgItensPREVE2: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 2'
          DataBinding.FieldName = 'ITE_PREVE2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 89
        end
        object cxgItensPREVE3: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 3'
          DataBinding.FieldName = 'ITE_PREVE3'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 89
        end
        object cxgItensPREVE4: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 4'
          DataBinding.FieldName = 'ITE_PREVE4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 77
        end
        object cxgItensPREVE5: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 5'
          DataBinding.FieldName = 'ITE_PREVE5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 89
        end
        object cxgItensPREVE6: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 6'
          DataBinding.FieldName = 'ITE_PREVE6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 77
        end
        object cxgItensPREVE7: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda 7'
          DataBinding.FieldName = 'ITE_PREVE7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 77
        end
        object cxgItensPREMED: TcxGridDBColumn
          Caption = 'Pre'#231'o M'#233'dio'
          DataBinding.FieldName = 'ITE_PREMED'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
        end
        object cxgItensPREULT: TcxGridDBColumn
          Caption = #218'ltimo Pre'#231'o'
          DataBinding.FieldName = 'ITE_PREULT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Options.Editing = False
        end
        object cxgItensIMPULT: TcxGridDBColumn
          Caption = #218'ltimo Pre'#231'o + Imp.'
          DataBinding.FieldName = 'ITE_IMPULT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Options.Editing = False
          Width = 108
        end
        object cxgItensSALBAL: TcxGridDBColumn
          Caption = 'Saldo Bal.'
          DataBinding.FieldName = 'ITE_SALBAL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
        end
        object cxgItensAltera: TcxGridDBColumn
          DataBinding.FieldName = 'ALTERA'
          Visible = False
        end
      end
      object cxlItens: TcxGridLevel
        GridView = cxgItens
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 627
    Width = 1360
    Height = 28
    Align = alBottom
    TabOrder = 4
    object Label3: TLabel
      Left = 4
      Top = 8
      Width = 168
      Height = 14
      Alignment = taRightJustify
      Caption = 'Escolha o pre'#231'o para manuten'#231#227'o:'
    end
    object cmbPreInv: TComboBox
      Tag = 99
      Left = 172
      Top = 3
      Width = 360
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbPreInvChange
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clScrollBar
    end
  end
end
