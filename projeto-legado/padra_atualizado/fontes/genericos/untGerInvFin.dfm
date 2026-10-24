object frmGerInvFin: TfrmGerInvFin
  Left = 465
  Top = 332
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Gerando Posi'#231#227'o Financeira'
  ClientHeight = 64
  ClientWidth = 327
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 327
    Height = 64
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object lblGerInvCTR: TLabel
      Left = 11
      Top = 25
      Width = 136
      Height = 14
      Caption = 'Gerando Posi'#231#227'o Financeira'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object pgbStatus: TProgressBar
      Left = 10
      Top = 41
      Width = 306
      Height = 11
      Smooth = True
      TabOrder = 0
    end
  end
  object tmrFecha: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrFechaTimer
    Left = 288
    Top = 8
  end
end
