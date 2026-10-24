inherited frmCadMazGeraArquivos: TfrmCadMazGeraArquivos
  Left = 474
  Top = 215
  Height = 244
  Caption = 'Gera'#231#227'o de arquivo de cadastro - Maza'
  Position = poMainFormCenter
  ExplicitHeight = 244
  PixelsPerInch = 96
  TextHeight = 14
  inherited gProgresso: TGauge
    Top = 152
    ExplicitTop = 152
  end
  inherited pnlBotoes: TPanel
    Top = 176
    ExplicitTop = 176
  end
  inherited pnlStatus: TPanel
    Top = 204
    ExplicitTop = 204
  end
  inherited pnlCabecalho: TPanel
    Caption = 'Gera'#231#227'o de arquivo de cadastro - Maza'
  end
  object rgOpcao: TRadioGroup [5]
    Left = 8
    Top = 112
    Width = 417
    Height = 33
    Caption = 'Op'#231#227'o'
    Columns = 3
    Ctl3D = False
    ItemIndex = 0
    Items.Strings = (
      'Colorantes'
      'Bases'
      'Formulas')
    ParentCtl3D = False
    TabOrder = 4
  end
end
