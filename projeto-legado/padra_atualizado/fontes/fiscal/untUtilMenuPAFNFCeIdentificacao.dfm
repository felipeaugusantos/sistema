inherited frmUtilMenuPAFNFCeIdentificacao: TfrmUtilMenuPAFNFCeIdentificacao
  Width = 696
  Height = 514
  Caption = 'Menu Fiscal PAF-NFC-e'
  Position = poScreenCenter
  ExplicitWidth = 696
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 441
    Width = 690
    ExplicitTop = 441
    ExplicitWidth = 690
    inherited FlwBotoes: TFlowPanel
      Width = 686
      ExplicitWidth = 686
    end
    inherited btnSair: TBitBtnLocked
      Left = 610
      ExplicitLeft = 610
    end
  end
  inherited pnlStatus: TPanel
    Top = 469
    Width = 690
    ExplicitTop = 469
    ExplicitWidth = 690
    inherited pnlNomeForm: TPanel
      Left = 519
      ExplicitLeft = 519
    end
    inherited pnlInfo: TPanel
      Width = 519
      ExplicitWidth = 519
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 33
    Width = 690
    Height = 408
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
    object mmoIdentificacao: TMemo
      Left = 1
      Top = 1
      Width = 688
      Height = 406
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
    Width = 690
    Height = 33
    Align = alTop
    Caption = 'IDENTIFICA'#199#195'O DA EMPRESA'
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
