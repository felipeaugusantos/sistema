inherited frmCadArmazem: TfrmCadArmazem
  Width = 525
  Height = 304
  Caption = 'Cadastro de Armaz'#233'm'
  ExplicitWidth = 525
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 519
    Height = 25
    ExplicitTop = 234
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      Width = 70
      Height = 20
      ExplicitLeft = 440
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 259
    Width = 519
    ExplicitTop = 259
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 167
      ExplicitLeft = 352
      ExplicitWidth = 167
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 0
    Align = alNone
    ExplicitWidth = 519
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 226
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 17
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 32
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 415
      Top = 15
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblResp: TLabel
      Left = 2
      Top = 63
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Respons'#225'vel:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 35
      Width = 440
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AMZ_DESCRI'
      DataSource = dtsCadAMZ
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAmz: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 11
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AMZ_CODAMZ'
      DataSource = dtsCadAMZ
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 463
      Top = 11
      Width = 48
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'AMZ_CODEMP'
      DataSource = dtsCadAMZ
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodResp: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 59
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AMZ_OPERES'
      DataSource = dtsCadAMZ
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodRespKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomResp: TEditFocus
      Left = 122
      Top = 59
      Width = 389
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlReplicacao: TPanel [4]
    Left = 0
    Top = 81
    Width = 519
    Height = 153
    Align = alClient
    BevelOuter = bvNone
    Padding.Top = 10
    TabOrder = 4
    object grbReplicacao: TGroupBox
      Left = 0
      Top = 10
      Width = 519
      Height = 143
      Align = alClient
      Padding.Top = 10
      TabOrder = 1
      object chkPriPro: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 11
        Width = 246
        Height = 17
        Caption = 'Armaz'#233'm principal para Ordem de Produ'#231#227'o'
        DataField = 'AMZ_PRIPRO'
        DataSource = dtsCadAMZ
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkArmPrC: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 27
        Width = 319
        Height = 17
        Caption = 'Armaz'#233'm Principal para compras'
        DataField = 'AMZ_ARMPRC'
        DataSource = dtsCadAMZ
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkGarPri: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 43
        Width = 311
        Height = 17
        Caption = 'Armaz'#233'm Principal para Recebimento de Garantia do Cliente'
        DataField = 'AMZ_GARPRI'
        DataSource = dtsCadAMZ
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkArmPri: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 77
        Width = 280
        Height = 17
        Caption = 'Armaz'#233'm Principal para vendas no check-out/Tablet.'
        DataField = 'AMZ_ARMPRI'
        DataSource = dtsCadAMZ
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkPriTin: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 94
        Width = 179
        Height = 17
        Caption = 'Lote principal para Tinta M'#225'quina'
        DataField = 'AMZ_PRITIN'
        DataSource = dtsCadAMZ
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkArmOPV: TDBCheckBox
        Left = 18
        Top = 59
        Width = 387
        Height = 17
        Caption = 
          'Armaz'#233'm/Lote Principal para vendas no Or'#231'amento/Pedido/Venda Nor' +
          'mal'
        DataField = 'AMZ_ARMOPV'
        DataSource = dtsCadAMZ
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkPriInd: TDBCheckBox
        Tag = 99
        Left = 18
        Top = 109
        Width = 280
        Height = 17
        Caption = 'Armaz'#233'm principal para Ordem de Produ'#231#227'o Industrial'
        DataField = 'AMZ_PRIIND'
        DataSource = dtsCadAMZ
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object chkReplicar: TDBCheckBox
      Tag = 99
      Left = 11
      Top = 4
      Width = 118
      Height = 17
      Caption = 'Realiza Replica'#231#227'o?'
      DataField = 'AMZ_REPAMZ'
      DataSource = dtsCadAMZ
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkReplicarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 140
  end
  object dtsCadAMZ: TDataSource
    Left = 440
    Top = 88
  end
end
