object frmPnlDadosFormula: TfrmPnlDadosFormula
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 159
  ClientWidth = 737
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 24
    Width = 67
    Height = 13
    Caption = 'Observa'#231#245'es:'
  end
  object lblObs001: TLabel
    Left = 77
    Top = 24
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 1'
  end
  object lblObs002: TLabel
    Left = 77
    Top = 38
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 2'
  end
  object lblObs004: TLabel
    Left = 77
    Top = 67
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 4'
  end
  object lblObs003: TLabel
    Left = 77
    Top = 52
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 3'
  end
  object lblObs005: TLabel
    Left = 77
    Top = 81
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 5'
  end
  object lblObs007: TLabel
    Left = 77
    Top = 110
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 7'
  end
  object lblObs006: TLabel
    Left = 77
    Top = 95
    Width = 72
    Height = 13
    Caption = 'Observa'#231#245'es 6'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 737
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object shpRed: TShape
      Left = 62
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = clRed
      Pen.Color = clRed
      Pen.Width = 0
    end
    object Label2: TLabel
      Left = 80
      Top = 4
      Width = 39
      Height = 13
      Caption = 'Inativas'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object shpBlk: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = clBlack
      Pen.Width = 0
    end
    object lblAtivas: TLabel
      Left = 20
      Top = 4
      Width = 30
      Height = 13
      Caption = 'Ativas'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object pnlCadFormula: TPanel
    Left = 0
    Top = 133
    Width = 737
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    ExplicitTop = 124
    object btnCadFormula: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 113
      Height = 26
      Align = alLeft
      Caption = '[F1] - Alterar'
      TabOrder = 0
      OnClick = btnCadFormulaClick
    end
  end
end
