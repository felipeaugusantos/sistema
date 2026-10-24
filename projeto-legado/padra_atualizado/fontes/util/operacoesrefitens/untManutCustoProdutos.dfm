inherited frmManutCustoProdutos: TfrmManutCustoProdutos
  Width = 502
  Height = 535
  Caption = 'Manuten'#231#227'o de Custos da Entrada de Mercadorias'
  OnDestroy = FormDestroy
  ExplicitWidth = 502
  ExplicitHeight = 535
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 464
    Width = 496
    ExplicitTop = 464
    ExplicitWidth = 496
    inherited FlwBotoes: TFlowPanel
      Width = 415
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 417
      Top = 2
      Align = alRight
      ExplicitLeft = 413
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 496
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblProduto: TLabel
      Left = 6
      Top = 1
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 41
      Width = 496
      Height = 3
      Align = alBottom
      Shape = bsBottomLine
      ExplicitTop = 42
      ExplicitWidth = 508
    end
    object dbeDesPro: TDBEditFocus
      Left = 71
      Top = 16
      Width = 415
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'ITE_DESITE'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 6
      Top = 16
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
    end
  end
  object pnlInfProduto: TPanel [3]
    Left = 0
    Top = 44
    Width = 496
    Height = 165
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 3
    object lblLinhaGrupo: TLabel
      Left = 5
      Top = 4
      Width = 59
      Height = 14
      Caption = 'Linha/Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 43
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 387
      Top = 43
      Width = 39
      Height = 14
      Caption = 'Unidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 82
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 120
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 157
      Width = 496
      Height = 8
      Align = alBottom
      Shape = bsBottomLine
      ExplicitTop = 284
    end
    object dbeCodGru: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 18
      Width = 64
      Height = 22
      Color = 16768952
      DataField = 'ITE_CODGRU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesGru: TDBEditFocus
      Left = 71
      Top = 18
      Width = 415
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'GRU_DESGRU'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeRefere: TDBEditFocus
      Left = 5
      Top = 59
      Width = 377
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'ITE_REFERE'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesUni: TDBEditFocus
      Left = 387
      Top = 59
      Width = 99
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'UNI_SIGUNI'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 97
      Width = 64
      Height = 22
      Color = 16768952
      DataField = 'ITE_CODMAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesMar: TDBEditFocus
      Left = 71
      Top = 97
      Width = 415
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'MAR_DESMAR'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 135
      Width = 64
      Height = 22
      Color = 16768952
      DataField = 'ITE_CODFOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomFor: TDBEditFocus
      Left = 71
      Top = 135
      Width = 415
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'FOR_NOMFOR'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 209
    Width = 496
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 4
    object Label9: TLabel
      Left = 5
      Top = 3
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 0
      Top = 40
      Width = 496
      Height = 8
      Align = alBottom
      Shape = bsBottomLine
      ExplicitTop = 284
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 18
      Width = 64
      Height = 22
      Color = 16768952
      DataField = 'ITE_CODEMP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomEmp: TDBEditFocus
      Left = 71
      Top = 18
      Width = 415
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EMP_NOMEMP'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlPreMed: TPanel [5]
    Left = 0
    Top = 257
    Width = 496
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object Bevel4: TBevel
      Left = 0
      Top = 65
      Width = 496
      Height = 2
      Align = alBottom
      Shape = bsBottomLine
      ExplicitLeft = 208
      ExplicitTop = 80
      ExplicitWidth = 50
    end
    object Label5: TLabel
      Left = 0
      Top = 0
      Width = 496
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = '[ Pre'#231'o M'#233'dio ]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 108
    end
    object Label6: TLabel
      Left = 5
      Top = 20
      Width = 55
      Height = 14
      Caption = 'Pre'#231'o Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 144
      Top = 20
      Width = 56
      Height = 14
      Caption = 'Novo Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object DBEditFocus1: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 35
      Width = 133
      Height = 22
      Color = 16768952
      DataField = 'ITE_PREMED'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNewPreMed: TDBEditFocus
      Tag = 99
      Left = 144
      Top = 35
      Width = 133
      Height = 22
      DataField = 'NEW_PREMED'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlImpUlt: TPanel [6]
    Left = 0
    Top = 391
    Width = 496
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    object Bevel5: TBevel
      Left = 0
      Top = 65
      Width = 496
      Height = 2
      Align = alBottom
      Shape = bsBottomLine
      ExplicitLeft = 208
      ExplicitTop = 80
      ExplicitWidth = 50
    end
    object Label8: TLabel
      Left = 0
      Top = 0
      Width = 496
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = '[ Pre'#231'o de '#218'ltima Compra com Impostos de Entrada ]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 371
    end
    object Label10: TLabel
      Left = 5
      Top = 20
      Width = 55
      Height = 14
      Caption = 'Pre'#231'o Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 144
      Top = 20
      Width = 56
      Height = 14
      Caption = 'Novo Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object DBEditFocus3: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 35
      Width = 133
      Height = 22
      Color = 16768952
      DataField = 'ITE_IMPULT'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNewImpUlt: TDBEditFocus
      Tag = 99
      Left = 144
      Top = 35
      Width = 133
      Height = 22
      DataField = 'NEW_IMPULT'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlPreUlt: TPanel [7]
    Left = 0
    Top = 324
    Width = 496
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 6
    object Bevel6: TBevel
      Left = 0
      Top = 65
      Width = 496
      Height = 2
      Align = alBottom
      Shape = bsBottomLine
      ExplicitLeft = 208
      ExplicitTop = 80
      ExplicitWidth = 50
    end
    object Label12: TLabel
      Left = 0
      Top = 0
      Width = 496
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = '[ Pre'#231'o de '#218'ltima Compra ]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 189
    end
    object Label13: TLabel
      Left = 5
      Top = 20
      Width = 55
      Height = 14
      Caption = 'Pre'#231'o Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 144
      Top = 20
      Width = 56
      Height = 14
      Caption = 'Novo Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object DBEditFocus5: TDBEditFocus
      Tag = 99
      Left = 5
      Top = 35
      Width = 133
      Height = 22
      Color = 16768952
      DataField = 'ITE_PREULT'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNewPreUlt: TDBEditFocus
      Tag = 99
      Left = 144
      Top = 35
      Width = 133
      Height = 22
      DataField = 'NEW_PREULT'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 490
    Width = 496
    ExplicitTop = 490
    ExplicitWidth = 496
    inherited pnlNomeForm: TPanel
      Left = 325
      ExplicitLeft = 325
    end
    inherited pnlInfo: TPanel
      Width = 325
      ExplicitWidth = 325
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1048
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 992
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 888
  end
end
