inherited frmGenericNovasFormulas: TfrmGenericNovasFormulas
  Width = 661
  Height = 493
  Caption = 'Cadastro de Novas F'#243'rmulas'
  ExplicitWidth = 661
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 421
    Width = 655
    ExplicitTop = 421
    ExplicitWidth = 655
    DesignSize = (
      655
      28)
    inherited btnSair: TBitBtnLocked
      Left = 579
      ExplicitLeft = 579
    end
  end
  inherited pgcDados: TPageControl
    Width = 655
    Height = 421
    ExplicitWidth = 655
    ExplicitHeight = 421
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 647
      ExplicitHeight = 389
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 655
    Height = 421
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object lblCodigo: TLabel
      Left = 11
      Top = 33
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 653
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 53
      Top = 30
      Width = 201
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbgComponentes: TcxGrid
      Tag = 99
      AlignWithMargins = True
      Left = 4
      Top = 196
      Width = 647
      Height = 221
      Align = alBottom
      TabOrder = 2
      OnEnter = dbgComponentesEnter
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgvComponentes: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = dbgvComponentesEditKeyPress
        DataController.DataSource = dtsComponentes
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NewItemRow.InfoText = 'Clique aqui para inserir um novo componente'
        NewItemRow.Visible = True
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsData.Appending = True
        OptionsView.NoDataToDisplayInfoText = '<Sem componentes na f'#243'rmula>'
        OptionsView.GroupByBox = False
      end
      object dbglComponentes: TcxGridLevel
        GridView = dbgvComponentes
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 449
    Width = 655
    ExplicitTop = 449
    ExplicitWidth = 655
    inherited pnlNomeForm: TPanel
      Left = 308
      ExplicitLeft = 308
    end
    inherited pnlInfo: TPanel
      Width = 308
      ExplicitWidth = 308
    end
  end
  object dtsComponentes: TDataSource
    DataSet = cdsCompoentes
    Left = 160
    Top = 152
  end
  object cdsCompoentes: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cdsCompoentesField1'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsCompoentesBeforePost
    Left = 120
    Top = 152
  end
end
