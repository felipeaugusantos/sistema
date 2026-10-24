inherited frmGerencImpr: TfrmGerencImpr
  Left = 315
  Top = 76
  Width = 390
  Height = 454
  ActiveControl = stgFilas
  Caption = 'Gerenciador de Impress'#227'o'
  Position = poScreenCenter
  ExplicitWidth = 390
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 384
    ExplicitTop = 381
    ExplicitWidth = 384
    inherited FlwBotoes: TFlowPanel
      Width = 303
      ExplicitTop = 2
      ExplicitWidth = 380
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 305
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 303
    end
  end
  object stgFilas: TStringGrid [2]
    Left = 0
    Top = 0
    Width = 384
    Height = 381
    Align = alClient
    Color = 16770261
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    ParentFont = False
    TabOrder = 2
    OnKeyDown = stgFilasKeyDown
    OnSelectCell = stgFilasSelectCell
    ColWidths = (
      64
      64)
    RowHeights = (
      24
      24)
  end
  inherited pnlStatus: TPanel
    Top = 409
    Width = 384
    ExplicitTop = 409
    ExplicitWidth = 384
    inherited pnlNomeForm: TPanel
      Left = 253
      Width = 131
      ExplicitLeft = 253
      ExplicitWidth = 131
    end
    inherited pnlInfo: TPanel
      Width = 253
      ExplicitWidth = 253
    end
  end
end
