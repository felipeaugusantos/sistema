inherited frmFatMostraItemSalBal: TfrmFatMostraItemSalBal
  Left = 282
  Top = 265
  Height = 271
  BorderIcons = [biSystemMenu]
  Caption = 'Itens travados '
  Position = poMainFormCenter
  ExplicitHeight = 271
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 198
    ExplicitTop = 198
    inherited FlwBotoes: TFlowPanel
      Width = 402
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 198
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 1
      Width = 481
      Height = 196
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 226
    ExplicitTop = 226
  end
end
