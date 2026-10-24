inherited frmGetMenu: TfrmGetMenu
  Left = 335
  Top = 253
  VertScrollBar.Range = 0
  BorderIcons = []
  Caption = ''
  ClientHeight = 35
  ClientWidth = 284
  Constraints.MaxHeight = 69
  Position = poMainFormCenter
  ExplicitWidth = 290
  ExplicitHeight = 63
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 35
    Width = 284
    ExplicitTop = 35
    ExplicitWidth = 284
    inherited btnSair: TBitBtnLocked
      Left = 57
      ExplicitLeft = 57
    end
  end
  inherited pnlStatus: TPanel
    Top = 61
    Width = 138
    Height = 1
    Align = alNone
    Visible = False
    ExplicitTop = 61
    ExplicitWidth = 138
    ExplicitHeight = 1
    inherited pnlNomeForm: TPanel
      Left = -33
      Height = 1
      ExplicitLeft = -33
      ExplicitHeight = 1
    end
    inherited pnlInfo: TPanel
      Width = 69
      Height = 1
      ExplicitWidth = 69
      ExplicitHeight = 1
    end
  end
  inherited pgcDados: TPageControl
    Width = 284
    Height = 35
    Visible = False
    ExplicitWidth = 284
    ExplicitHeight = 35
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 276
      ExplicitHeight = 3
    end
  end
  object stgMenu: TStringGrid [3]
    Left = 0
    Top = 0
    Width = 284
    Height = 35
    Align = alClient
    ColCount = 1
    DefaultColWidth = 284
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ScrollBars = ssNone
    TabOrder = 3
    OnDblClick = stgMenuDblClick
    OnKeyDown = stgMenuKeyDown
  end
end
