inherited frmCadCtaPagarSimplificado: TfrmCadCtaPagarSimplificado
  Width = 808
  Height = 163
  Caption = 'Manuten'#231#227'o de Contas a Pagar'
  ExplicitWidth = 808
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 90
    Width = 802
    ExplicitTop = 90
    ExplicitWidth = 802
    inherited FlwBotoes: TFlowPanel
      Width = 798
      ExplicitTop = 2
      ExplicitWidth = 798
      inherited btnIncluir: TBitBtnLocked
        Visible = False
      end
      inherited btnExcluir: TBitBtnLocked
        Visible = False
      end
      inherited btnPesquisa: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 726
      ExplicitLeft = 726
    end
  end
  inherited pnlStatus: TPanel
    Top = 118
    Width = 802
    ExplicitTop = 118
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 455
      ExplicitLeft = 455
    end
    inherited pnlInfo: TPanel
      Width = 455
      ExplicitWidth = 455
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 802
    Height = 55
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 46
      Top = 7
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 284
      Top = 7
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object Label3: TLabel
      Left = 58
      Top = 30
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 356
      Top = 30
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label15: TLabel
      Left = 387
      Top = 7
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object dbeNumDup: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 4
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_NUMDUP'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeParcel: TDBEditFocus
      Tag = 99
      Left = 327
      Top = 4
      Width = 26
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_PARCEL'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 27
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODEMP'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 417
      Top = 27
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODFOR'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object dbeSerie: TDBEditFocus
      Tag = 99
      Left = 417
      Top = 4
      Width = 38
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_SERIE_'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 188
      Top = 27
      Width = 165
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 489
      Top = 27
      Width = 286
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDetalhe: TPanel [4]
    Left = 0
    Top = 55
    Width = 802
    Height = 35
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label7: TLabel
      Left = 31
      Top = 8
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Cadastro:'
    end
    object Label8: TLabel
      Left = 273
      Top = 8
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Vencimento:'
    end
    object Label9: TLabel
      Left = 543
      Top = 8
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 5
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_DTACAD'
      DataSource = dtsTabela
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaVen: TDBEditFocus
      Tag = 99
      Left = 359
      Top = 5
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_DTAVEN'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValDup: TDBEditFocus
      Tag = 99
      Left = 573
      Top = 5
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_VALDUP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnEnter = dbeValDupEnter
      OnExit = dbeValDupExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 752
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
  end
  object dtsTabela: TDataSource
    Left = 584
    Top = 10
  end
end
