inherited frmOrdProIndDesenvQtds: TfrmOrdProIndDesenvQtds
  Width = 747
  Height = 198
  Caption = 'Informe a quantidade a ser produzida'
  OnClose = FormClose
  ExplicitWidth = 747
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 126
    Width = 741
    ExplicitTop = 126
    ExplicitWidth = 741
    inherited btnSair: TBitBtnLocked
      Left = 658
      TabOrder = 1
      ExplicitLeft = 658
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 741
    Height = 126
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ORD_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 59
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 451
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 61
      end
      object cxgItensQTDPRO: TcxGridDBColumn
        Caption = 'Quantidade a Produzir'
        DataBinding.FieldName = 'ORD_QTDPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 145
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 154
    Width = 741
    ExplicitTop = 154
    ExplicitWidth = 741
    inherited pnlNomeForm: TPanel
      Left = 570
      ExplicitLeft = 570
    end
    inherited pnlInfo: TPanel
      Width = 570
      ExplicitWidth = 570
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 240
  end
end
