inherited frmImportacaoExtrato: TfrmImportacaoExtrato
  Left = 0
  Top = 0
  Width = 660
  Height = 629
  BorderIcons = [biSystemMenu]
  Caption = 'Importa'#231#227'o de Extrato Banc'#225'rio (OFX Online)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnPaint = nil
  OnShortCut = nil
  ExplicitWidth = 660
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 554
    Width = 654
    Height = 0
    Visible = False
    ExplicitTop = 554
    ExplicitWidth = 654
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 650
      ExplicitWidth = 650
    end
    inherited btnSair: TBitBtnLocked
      Top = -25
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 584
    Width = 654
    ExplicitTop = 584
    ExplicitWidth = 654
    inherited pnlNomeForm: TPanel
      Left = 483
      ExplicitLeft = 483
    end
    inherited pnlInfo: TPanel
      Width = 483
      ExplicitWidth = 483
    end
  end
  object pnlFooter: TPanel [2]
    Left = 0
    Top = 554
    Width = 654
    Height = 30
    Align = alBottom
    BevelOuter = bvLowered
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    StyleElements = []
    object lblTotalGeral: TLabel
      Left = 16
      Top = 7
      Width = 116
      Height = 16
      Caption = 'Total Geral: R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object pnlTop: TPanel [3]
    Left = 0
    Top = 0
    Width = 654
    Height = 81
    Align = alTop
    BevelOuter = bvLowered
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    StyleElements = []
    object lblTitulo: TLabel
      Left = 16
      Top = 12
      Width = 261
      Height = 19
      Caption = 'Importa'#231#227'o de Extrato Banc'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubTitulo: TLabel
      Left = 16
      Top = 37
      Width = 302
      Height = 13
      Caption = 
        'Selecione a conta para importar o extrato e iniciar a concilia'#231#227 +
        'o'
    end
    object edtFiltro: TEdit
      Left = 16
      Top = 54
      Width = 160
      Height = 21
      Hint = 'Filtrar por banco ou n'#250'mero da conta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Filtrar por banco ou conta'
      OnChange = edtFiltroChange
    end
  end
  object scbContas: TScrollBox [4]
    Left = 0
    Top = 81
    Width = 654
    Height = 473
    Align = alClient
    BorderStyle = bsNone
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
  end
end
