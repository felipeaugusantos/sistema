object frmFrameICMSIPI: TfrmFrameICMSIPI
  Left = 0
  Top = 0
  Width = 1171
  Height = 555
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 1171
    Height = 555
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 451
    ExplicitHeight = 305
    object grdIcms: TStringGrid
      Left = 5
      Top = 29
      Width = 532
      Height = 261
      BiDiMode = bdLeftToRight
      Color = clWhite
      ColCount = 6
      Ctl3D = True
      DefaultColWidth = 152
      DefaultRowHeight = 15
      RowCount = 16
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      Font.Quality = fqClearType
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnDrawCell = grdIcmsDrawCell
      ColWidths = (
        152
        129
        121
        122
        152
        152)
    end
    object grdIpi: TStringGrid
      Left = 537
      Top = 29
      Width = 544
      Height = 261
      BiDiMode = bdLeftToRight
      Color = clWhite
      ColCount = 4
      Ctl3D = True
      DefaultColWidth = 152
      DefaultRowHeight = 15
      RowCount = 16
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      Font.Quality = fqClearType
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnDrawCell = grdIpiDrawCell
      ColWidths = (
        152
        131
        130
        122)
    end
    object Panel1: TPanel
      Left = 5
      Top = 8
      Width = 532
      Height = 22
      BevelOuter = bvNone
      Caption = 'RESUMO DE ICMS / ICMS ST'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object Panel2: TPanel
      Left = 538
      Top = 8
      Width = 543
      Height = 22
      BevelOuter = bvNone
      Caption = 'RESUMO DE IPI'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object Panel4: TPanel
      Left = 5
      Top = 291
      Width = 532
      Height = 22
      BevelOuter = bvNone
      Caption = 'RESUMO DE PIS'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
    end
    object grdPis: TStringGrid
      Left = 5
      Top = 313
      Width = 532
      Height = 182
      BiDiMode = bdLeftToRight
      Color = clWhite
      ColCount = 3
      Ctl3D = True
      DefaultColWidth = 175
      DefaultRowHeight = 15
      RowCount = 11
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      Font.Quality = fqClearType
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
    end
    object Panel5: TPanel
      Left = 538
      Top = 291
      Width = 543
      Height = 22
      BevelOuter = bvNone
      Caption = 'RESUMO DE COFINS'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
    end
    object grdCofins: TStringGrid
      Left = 537
      Top = 313
      Width = 544
      Height = 182
      BiDiMode = bdLeftToRight
      Color = clWhite
      ColCount = 3
      Ctl3D = True
      DefaultColWidth = 179
      DefaultRowHeight = 15
      RowCount = 11
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      Font.Quality = fqClearType
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 7
    end
  end
end
