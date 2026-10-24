object frmArqNaoGravados: TfrmArqNaoGravados
  Left = 292
  Top = 203
  Caption = 'Arquivos n'#227'o gravados'
  ClientHeight = 307
  ClientWidth = 613
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCentral: TPanel
    Left = 0
    Top = 0
    Width = 613
    Height = 307
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object memResumo: TMemo
      Left = 1
      Top = 1
      Width = 611
      Height = 305
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyDown = memResumoKeyDown
    end
  end
end
