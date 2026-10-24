object frmRTTIEngineProgress: TfrmRTTIEngineProgress
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmRTTIEngineProgress'
  ClientHeight = 211
  ClientWidth = 253
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblInform: TLabel
    Left = 3
    Top = 188
    Width = 241
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Carregando Dados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dxGaugeControl: TdxGaugeControl
    Left = 3
    Top = 6
    Width = 241
    Height = 185
    BorderStyle = cxcbsNone
    Transparent = True
    object CircularScale: TdxGaugeCircularScale
      StyleName = 'IceColdZone'
    end
  end
end
