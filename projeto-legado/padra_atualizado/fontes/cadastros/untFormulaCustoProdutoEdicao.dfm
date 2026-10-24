inherited frmFormulaCustoProdutoEdicao: TfrmFormulaCustoProdutoEdicao
  Width = 834
  Height = 430
  BorderStyle = bsSizeable
  Caption = 'Constru'#231#227'o do Pre'#231'o de Custo do Produto'
  ExplicitWidth = 834
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 14
  object lblDesIte: TLabel [0]
    Left = 0
    Top = 0
    Width = 818
    Height = 18
    Align = alTop
    Alignment = taCenter
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 4
  end
  inherited pnlBotoes: TPanel
    Top = 349
    Width = 818
    TabOrder = 1
    ExplicitTop = 349
    ExplicitWidth = 818
    inherited FlwBotoes: TFlowPanel
      Width = 737
      ExplicitWidth = 737
      inherited btnConfirma: TBitBtnLocked
        Width = 110
        Caption = '&Grava F'#243'rmula'
        ModalResult = 0
        ExplicitWidth = 110
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 739
      Top = 2
      Align = alRight
      ExplicitLeft = 739
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 375
    Width = 818
    TabOrder = 2
    ExplicitTop = 375
    ExplicitWidth = 818
    inherited pnlNomeForm: TPanel
      Left = 647
      ExplicitLeft = 647
    end
    inherited pnlInfo: TPanel
      Width = 647
      ExplicitWidth = 647
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 18
    Width = 818
    Height = 154
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 0
    ExplicitHeight = 172
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensCODCAM: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'FOR_CODCAM'
        OnCustomDrawCell = cxvItensCODCAMCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 69
      end
      object cxvItensDESCAM: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Valor'
        DataBinding.FieldName = 'DESCAM'
        OnCustomDrawCell = cxvItensCODCAMCustomDrawCell
        Options.Editing = False
        Width = 134
      end
      object cxvItensOPERAD: TcxGridDBColumn
        Caption = '+/-'
        DataBinding.FieldName = 'OPERAD'
        OnCustomDrawCell = cxvItensCODCAMCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 31
      end
      object cxvItensBASCAL: TcxGridDBColumn
        Caption = 'F'#243'rmula da Base de C'#225'lculo'
        DataBinding.FieldName = 'FOR_BASCAL'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        OnCustomDrawCell = cxvItensBASCALCustomDrawCell
        Width = 447
      end
      object cxvItensPOSCAM: TcxGridDBColumn
        DataBinding.FieldName = 'POSCAM'
        Visible = False
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxvItensVALCAD: TcxGridDBColumn
        Caption = 'Conte'#250'do'
        DataBinding.FieldName = 'VALCAD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        OnGetDisplayText = cxvItensVALCADGetDisplayText
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxvItensEXPUSU: TcxGridDBColumn
        Caption = 'Desmostra'#231#227'o do Valor Calculado'
        DataBinding.FieldName = 'EXPUSU'
        Width = 434
      end
      object cxvItensVALCAL: TcxGridDBColumn
        Caption = 'Valor Calculado'
        DataBinding.FieldName = 'VALCAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 8
        Properties.DisplayFormat = '0.00000000;-0.0000000000'
        OnGetDisplayText = cxvItensVALCALGetDisplayText
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object pgcPreven: TPageControl [4]
    Left = 0
    Top = 172
    Width = 818
    Height = 177
    ActivePage = tbsPreven1
    Align = alBottom
    TabOrder = 3
    object tbsPreven1: TTabSheet
      Tag = 1
      Caption = 'Tabela de Pre'#231'o 1'
      OnShow = tbsPreven1Show
      object lblPreve1: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven2: TTabSheet
      Tag = 2
      Caption = 'Tabela de Pre'#231'o 2'
      ImageIndex = 1
      OnShow = tbsPreven2Show
      object lblPreve2: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven3: TTabSheet
      Tag = 3
      Caption = 'Tabela de Pre'#231'o 3'
      ImageIndex = 2
      OnShow = tbsPreven3Show
      object lblPreve3: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven4: TTabSheet
      Tag = 4
      Caption = 'Tabela de Pre'#231'o 4'
      ImageIndex = 3
      OnShow = tbsPreven4Show
      object lblPreve4: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven5: TTabSheet
      Tag = 5
      Caption = 'Tabela de Pre'#231'o 5'
      ImageIndex = 4
      OnShow = tbsPreven5Show
      object lblPreve5: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven6: TTabSheet
      Tag = 6
      Caption = 'Tabela de Pre'#231'o 6'
      ImageIndex = 5
      OnShow = tbsPreven6Show
      object lblPreve6: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
    object tbsPreven7: TTabSheet
      Tag = 7
      Caption = 'Tabela de Pre'#231'o 7'
      ImageIndex = 6
      OnShow = tbsPreven7Show
      object lblPreve7: TLabel
        Left = 0
        Top = 0
        Width = 810
        Height = 14
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 3
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 32
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 64
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 232
    Top = 104
    PixelsPerInch = 96
  end
end
