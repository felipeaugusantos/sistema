inherited frmUtilMenuPAFNFCeMensagem: TfrmUtilMenuPAFNFCeMensagem
  Width = 1000
  Height = 556
  Caption = 'Menu Fiscal PAF-NFC-e'
  Position = poScreenCenter
  ExplicitWidth = 1000
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 994
    ExplicitTop = 483
    ExplicitWidth = 994
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 914
    end
  end
  inherited pnlStatus: TPanel
    Top = 511
    Width = 994
    ExplicitTop = 511
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 823
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 33
    Width = 994
    Height = 450
    Align = alClient
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object mmoAlerta: TMemo
      Left = 1
      Top = 1
      Width = 992
      Height = 448
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 994
    Height = 33
    Align = alTop
    Caption = 'ALERTA'
    Color = clActiveCaption
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 160
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 40
    Top = 248
  end
end
