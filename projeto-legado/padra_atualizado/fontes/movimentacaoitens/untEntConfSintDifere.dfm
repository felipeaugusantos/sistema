inherited frmEntConfSintDifere: TfrmEntConfSintDifere
  Width = 649
  Height = 502
  BorderStyle = bsSizeable
  Caption = 'Diferen'#231'as entre a confer'#234'ncia e a entrada de mercadorias'
  ExplicitWidth = 649
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 633
    ExplicitTop = 420
    ExplicitWidth = 633
    inherited btnSair: TBitBtnLocked
      Left = 553
      ExplicitLeft = 553
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 633
    Height = 420
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 55
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 290
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Embalagem'
        DataBinding.FieldName = 'EMBALA'
        HeaderAlignmentHorz = taRightJustify
        Width = 67
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Quantidade conferida'
        DataBinding.FieldName = 'QTDCON'
        HeaderAlignmentHorz = taRightJustify
        Width = 112
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Quantidade entrada'
        DataBinding.FieldName = 'QTDENT'
        HeaderAlignmentHorz = taRightJustify
        Width = 109
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 448
    Width = 633
    ExplicitTop = 448
    ExplicitWidth = 633
    inherited pnlNomeForm: TPanel
      Left = 462
      ExplicitLeft = 462
    end
    inherited pnlInfo: TPanel
      Width = 462
      ExplicitWidth = 462
    end
  end
  object dtsItens: TDataSource
    Left = 216
    Top = 176
  end
end
