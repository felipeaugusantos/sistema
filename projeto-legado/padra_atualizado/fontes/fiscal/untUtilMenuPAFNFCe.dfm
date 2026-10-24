inherited frmUtilMenuPAFNFCe: TfrmUtilMenuPAFNFCe
  Width = 450
  Height = 600
  Caption = 'Menu Fiscal PAF-NFC-e'
  Position = poScreenCenter
  ExplicitWidth = 450
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 444
    ExplicitTop = 527
    ExplicitWidth = 444
    inherited FlwBotoes: TFlowPanel
      Width = 440
      ExplicitWidth = 440
    end
    inherited btnSair: TBitBtnLocked
      Left = 364
      ExplicitLeft = 364
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 444
    ExplicitTop = 555
    ExplicitWidth = 444
    inherited pnlNomeForm: TPanel
      Left = 273
      ExplicitLeft = 273
    end
    inherited pnlInfo: TPanel
      Width = 273
      ExplicitWidth = 273
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 33
    Width = 444
    Height = 494
    Align = alClient
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      444
      494)
    object btnIdentificacao: TBitBtnLocked
      Left = 2
      Top = 6
      Width = 439
      Height = 43
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Identifica'#231#227'o do PAF-NFC-e'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnIdentificacaoClick
    end
    object btnRegistros: TBitBtnLocked
      Left = 2
      Top = 55
      Width = 439
      Height = 43
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Registros do PAF-NFC-e'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnRegistrosClick
    end
    object btnVendas: TBitBtnLocked
      Left = 2
      Top = 104
      Width = 439
      Height = 43
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Vendas Identificadas pelo CPF/CNPJ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnVendasClick
    end
    object btnRequisicoes: TBitBtnLocked
      Left = 2
      Top = 153
      Width = 439
      Height = 43
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Requisi'#231#245'es Externas Registradas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnRequisicoesClick
    end
    object btnControle: TBitBtnLocked
      Left = 2
      Top = 202
      Width = 439
      Height = 43
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Controle dos DAV'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnControleClick
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 444
    Height = 33
    Align = alTop
    Caption = 'MENU FISCAL'
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
    Left = 288
    Top = 432
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 32
    Top = 464
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 424
  end
end
