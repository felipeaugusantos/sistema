inherited frmCadRennerIndustrialGeraArquivoNovo: TfrmCadRennerIndustrialGeraArquivoNovo
  Left = 351
  Top = 207
  Width = 453
  Height = 242
  Caption = 'Gera'#231#227'o de arquivo de cadastro - Renner Industrial'
  ExplicitWidth = 453
  ExplicitHeight = 242
  PixelsPerInch = 96
  TextHeight = 14
  inherited gProgresso: TGauge
    Top = 152
    Width = 433
    ExplicitTop = 152
    ExplicitWidth = 433
  end
  inherited pnlBotoes: TPanel
    Top = 174
    Width = 447
    ExplicitTop = 174
    ExplicitWidth = 447
    inherited btnSair: TBitBtnLocked
      Left = 364
      ExplicitLeft = 364
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 447
    ExplicitTop = 202
    ExplicitWidth = 447
    inherited pnlNomeForm: TPanel
      Left = 276
      ExplicitLeft = 276
    end
    inherited pnlInfo: TPanel
      Width = 276
      ExplicitWidth = 276
    end
  end
  inherited pnlCabecalho: TPanel
    Width = 447
    Caption = 'Gera'#231#227'o de arquivo de cadastro - Renner Industrial'
    ExplicitWidth = 447
  end
  inherited memSaida: TMemo
    Width = 433
    ExplicitWidth = 433
  end
  object rgOpcoes: TRadioGroup [5]
    Left = 8
    Top = 112
    Width = 433
    Height = 33
    Caption = 'Op'#231#245'es'
    Columns = 3
    Ctl3D = False
    ItemIndex = 0
    Items.Strings = (
      'Colorantes / Embalagens'
      'Bases'
      'F'#243'rmulas')
    ParentCtl3D = False
    TabOrder = 4
  end
end
