object frmGetMenu: TfrmGetMenu
  Left = 335
  Top = 253
  BorderIcons = []
  ClientHeight = 30
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MaxHeight = 69
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object stgMenu: TStringGrid
    Left = 0
    Top = 0
    Width = 284
    Height = 30
    Align = alClient
    ColCount = 1
    DefaultColWidth = 284
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ScrollBars = ssNone
    TabOrder = 0
    OnDblClick = stgMenuDblClick
    OnKeyDown = stgMenuKeyDown
    ColWidths = (
      284)
    RowHeights = (
      24
      24)
  end
end
