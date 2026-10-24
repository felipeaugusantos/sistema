inherited frmConfCodBarrasFormulacao: TfrmConfCodBarrasFormulacao
  Height = 233
  Caption = 'Confer'#234'ncia de formula'#231#227'o'
  Position = poScreenCenter
  ExplicitHeight = 233
  PixelsPerInch = 96
  TextHeight = 14
  object lblEti: TLabel [0]
    Left = 9
    Top = 35
    Width = 166
    Height = 15
    Caption = 'C'#243'digo de barras da etiqueta:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEmb: TLabel [1]
    Left = 9
    Top = 98
    Width = 38
    Height = 15
    Caption = 'Label1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object shpEti: TShape [2]
    Left = 412
    Top = 31
    Width = 65
    Height = 22
    Brush.Color = clRed
  end
  object shpEmb: TShape [3]
    Left = 412
    Top = 92
    Width = 65
    Height = 22
    Brush.Color = clRed
  end
  inherited pnlBotoes: TPanel
    Top = 160
    TabOrder = 2
    ExplicitTop = 160
    inherited btnConfirma: TBitBtnLocked
      Enabled = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 188
    TabOrder = 3
    ExplicitTop = 188
  end
  object edtCodBarEti: TEditFocus [7]
    Tag = 99
    Left = 201
    Top = 31
    Width = 205
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    OnChange = edtCodBarEtiChange
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodBarEmb: TEditFocus [8]
    Tag = 99
    Left = 201
    Top = 92
    Width = 205
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 1
    OnChange = edtCodBarEmbChange
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 144
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 64
    Top = 16
  end
  object tmrConfirma: TTimer
    Interval = 3000
    OnTimer = tmrConfirmaTimer
    Left = 296
    Top = 8
  end
end
