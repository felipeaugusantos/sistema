inherited frmRecTransfDivergencias: TfrmRecTransfDivergencias
  Width = 663
  Height = 448
  Caption = 'Diverg'#234'ncias entre o Pedido e a Nota de Entrada'
  ExplicitWidth = 663
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 657
    ExplicitTop = 377
    ExplicitWidth = 657
    inherited FlwBotoes: TFlowPanel
      Width = 494
      ExplicitWidth = 653
      inherited btnConfirma: TBitBtnLocked
        Width = 133
        Caption = '&Confirma a entrada'
        ExplicitWidth = 133
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 496
      Top = 2
      Width = 159
      Align = alRight
      Caption = 'C&ancela a sele'#231#227'o'
      ExplicitLeft = 492
      ExplicitWidth = 159
    end
  end
  object cxGrid: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 657
    Height = 288
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Appending = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgColCodIte: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Width = 57
      end
      object cxgColDesIte: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 341
      end
      object cxgColQtdAbe: TcxGridDBColumn
        Caption = 'Quant. Aberta no Pedido'
        DataBinding.FieldName = 'QTDABE'
        HeaderAlignmentHorz = taRightJustify
        Width = 128
      end
      object cxgColQtdNot: TcxGridDBColumn
        Caption = 'Quantidade na Nota'
        DataBinding.FieldName = 'QTDNOT'
        HeaderAlignmentHorz = taRightJustify
        Width = 109
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object mmoInform: TMemo [3]
    Left = 0
    Top = 288
    Width = 657
    Height = 89
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 657
    ExplicitTop = 403
    ExplicitWidth = 657
    inherited pnlNomeForm: TPanel
      Left = 486
      ExplicitLeft = 486
    end
    inherited pnlInfo: TPanel
      Width = 486
      ExplicitWidth = 486
    end
  end
  object dtsItens: TDataSource
    Left = 152
    Top = 208
  end
end
