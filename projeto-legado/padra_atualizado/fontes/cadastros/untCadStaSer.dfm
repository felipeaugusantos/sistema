inherited frmCadStaSer: TfrmCadStaSer
  Left = 319
  Top = 465
  Width = 535
  Height = 296
  Caption = 'Cadastro de Status do Servi'#231'o'
  ExplicitWidth = 535
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 226
    Width = 529
    Height = 25
    TabOrder = 2
    ExplicitTop = 226
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 461
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 461
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 21
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 75
        Height = 21
        ExplicitLeft = 74
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 149
        Width = 75
        Height = 21
        ExplicitLeft = 149
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 224
        Width = 75
        Height = 21
        ExplicitLeft = 224
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 299
        Width = 75
        Height = 21
        ExplicitLeft = 299
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 374
        Width = 75
        Height = 21
        ExplicitLeft = 374
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 463
      Width = 64
      Height = 21
      Align = alRight
      ExplicitLeft = 463
      ExplicitWidth = 64
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 251
    Width = 529
    TabOrder = 3
    ExplicitTop = 251
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 322
      Width = 207
      TabOrder = 1
      ExplicitLeft = 322
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 322
      TabOrder = 0
      ExplicitWidth = 322
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    TabOrder = 1
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 226
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 11
      Top = 36
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 32
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'STS_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'STS_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object chkFinali: TDBCheckBox
      Left = 65
      Top = 57
      Width = 450
      Height = 17
      Caption = 
        'Este status finaliza o servi'#231'o e deixa o prisma dispon'#237'vel para ' +
        'um novo servi'#231'o?'
      DataField = 'STS_FINALI'
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkSelFat: TDBCheckBox
      Left = 65
      Top = 73
      Width = 450
      Height = 17
      Caption = 'Permitir selecionar na digita'#231#227'o de servi'#231'o do faturamento?'
      DataField = 'STS_SELFAT'
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkNotCli: TDBCheckBox
      Tag = 99
      Left = 65
      Top = 89
      Width = 158
      Height = 17
      Caption = 'Enviar Notifica'#231#227'o ao Cliente'
      DataField = 'STS_NOTCLI'
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkNotCliClick
    end
    object pnlNotCli: TPanel
      Left = 2
      Top = 112
      Width = 525
      Height = 112
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 5
      object lblMsgCli: TLabel
        Left = 0
        Top = 0
        Width = 525
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'Notifica'#231#227'o Cliente'
        ExplicitWidth = 89
      end
      object mmoMsgCli: TDBMemo
        Tag = 99
        Left = 0
        Top = 14
        Width = 525
        Height = 98
        Align = alClient
        DataField = 'STS_MSGCLI'
        TabOrder = 0
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 80
  end
end
