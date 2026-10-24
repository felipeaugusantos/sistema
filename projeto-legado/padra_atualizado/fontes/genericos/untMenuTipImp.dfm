inherited frmMenuTipImp: TfrmMenuTipImp
  Left = 406
  Top = 307
  Width = 176
  Height = 168
  BorderIcons = [biSystemMenu]
  Caption = 'Escolha o tipo...'
  Position = poOwnerFormCenter
  ExplicitWidth = 176
  ExplicitHeight = 168
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 99
    Width = 170
    Height = 24
    TabOrder = 1
    ExplicitTop = 99
    ExplicitWidth = 170
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 89
      Height = 20
      ExplicitWidth = 89
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 91
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 91
      ExplicitTop = 2
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 123
    Width = 170
    TabOrder = 2
    ExplicitTop = 123
    ExplicitWidth = 170
    inherited pnlNomeForm: TPanel
      Left = -1
      ExplicitLeft = -1
    end
    inherited pnlInfo: TPanel
      Width = 57
      ExplicitWidth = 57
    end
  end
  object stgTipImp: TStringGrid [2]
    Left = 0
    Top = 0
    Width = 170
    Height = 99
    Align = alClient
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = stgTipImpDblClick
    OnKeyDown = stgTipImpKeyDown
    OnSelectCell = stgTipImpSelectCell
    ColWidths = (
      64)
    RowHeights = (
      24
      24)
  end
end
