inherited frmCustosVariaveis: TfrmCustosVariaveis
  Width = 528
  Height = 233
  BorderIcons = [biSystemMenu]
  Caption = 'Custos vari'#225'veis'
  Position = poScreenCenter
  ExplicitWidth = 528
  ExplicitHeight = 233
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 160
    Width = 522
    ExplicitTop = 160
    ExplicitWidth = 522
    inherited FlwBotoes: TFlowPanel
      Width = 518
    end
    inherited btnSair: TBitBtnLocked
      Left = 439
      ExplicitLeft = 439
    end
  end
  inherited pnlStatus: TPanel
    Top = 188
    Width = 522
    ExplicitTop = 188
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 351
      ExplicitLeft = 351
    end
    inherited pnlInfo: TPanel
      Width = 351
      ExplicitWidth = 351
    end
  end
  object Panel1: TPanel [3]
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 506
    Height = 46
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 501
    object Label1: TLabel
      Left = 32
      Top = 4
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object lblProduto: TLabel
      Left = 78
      Top = 4
      Width = 315
      Height = 14
      AutoSize = False
      Caption = 'lblProduto'
    end
    object lblReferencia: TLabel
      Left = 78
      Top = 24
      Width = 63
      Height = 14
      Caption = 'lblReferencia'
    end
    object Label5: TLabel
      Left = 399
      Top = 4
      Width = 42
      Height = 14
      Caption = 'Unidade:'
    end
    object lblUnidade: TLabel
      Left = 447
      Top = 4
      Width = 49
      Height = 14
      Caption = 'lblUnidade'
    end
  end
  object Panel2: TPanel [4]
    AlignWithMargins = True
    Left = 8
    Top = 62
    Width = 506
    Height = 90
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 4
    object lblTitBocaDeCaixa: TLabel
      Left = 164
      Top = 8
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'lblTitBocaDeCaixa'
    end
    object Label8: TLabel
      Left = 178
      Top = 28
      Width = 72
      Height = 14
      Caption = 'ICMS de Sa'#237'da:'
    end
    object Label9: TLabel
      Left = 159
      Top = 48
      Width = 91
      Height = 14
      Caption = 'Impostos Federais:'
    end
    object Label10: TLabel
      Left = 131
      Top = 68
      Width = 119
      Height = 14
      Caption = 'Despesas Operacionais:'
    end
    object lblBocaDeCaixa: TLabel
      Left = 256
      Top = 8
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblIcms: TLabel
      Left = 256
      Top = 28
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblImpostosFederais: TLabel
      Left = 256
      Top = 48
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblDespesasOperacionais: TLabel
      Left = 256
      Top = 68
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object Label3: TLabel
      Left = 327
      Top = 28
      Width = 10
      Height = 14
      Caption = '%'
    end
    object Label4: TLabel
      Left = 327
      Top = 48
      Width = 10
      Height = 14
      Caption = '%'
    end
    object Label6: TLabel
      Left = 327
      Top = 68
      Width = 10
      Height = 14
      Caption = '%'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 744
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
  end
end
