inherited frmCadConcorrPesqMer: TfrmCadConcorrPesqMer
  Width = 672
  Height = 247
  Caption = 'Concorrentes para Pesquisa de Mercado'
  ExplicitWidth = 672
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 174
    Width = 666
    inherited FlwBotoes: TFlowPanel
      Width = 662
      ExplicitTop = 2
      inherited btnPesquisa: TBitBtnLocked
        Width = 78
        ExplicitWidth = 78
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 585
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 666
    inherited pnlNomeForm: TPanel
      Left = 319
    end
    inherited pnlInfo: TPanel
      Width = 319
    end
  end
  inherited pgcDados: TPageControl
    Width = 666
    Height = 174
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 666
    Height = 174
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 536
    ExplicitTop = 8
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 41
      Top = 30
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Codigo:'
    end
    object lbl1: TLabel
      Left = 477
      Top = 29
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situacao:'
    end
    object lbl2: TColorLabel
      Left = 568
      Top = 29
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 46
      Top = 52
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 27
      Top = 74
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endereco:'
    end
    object Label4: TLabel
      Left = 399
      Top = 74
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Numero:'
    end
    object Label6: TLabel
      Left = 9
      Top = 97
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Complemento:'
    end
    object Label5: TLabel
      Left = 296
      Top = 97
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label7: TLabel
      Left = 40
      Top = 120
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label10: TLabel
      Left = 292
      Top = 120
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label9: TLabel
      Left = 409
      Top = 120
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 79
      Top = 25
      Width = 104
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_CODIGO'
      DataSource = dtsCadConcorr
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 525
      Top = 25
      Width = 37
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_STATUS'
      DataSource = dtsCadConcorr
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object DBENOMCON: TDBEditFocus
      Tag = 99
      Left = 79
      Top = 48
      Width = 309
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_NOMCON'
      DataSource = dtsCadConcorr
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEENDERE: TDBEditFocus
      Left = 79
      Top = 71
      Width = 309
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_ENDERE'
      DataSource = dtsCadConcorr
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEENDNUM: TDBEditFocus
      Left = 442
      Top = 71
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_ENDNUM'
      DataSource = dtsCadConcorr
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEENDCMP: TDBEditFocus
      Left = 79
      Top = 94
      Width = 204
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_ENDCOM'
      DataSource = dtsCadConcorr
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEBAIRRO: TDBEditFocus
      Left = 331
      Top = 94
      Width = 232
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_BAIRRO'
      DataSource = dtsCadConcorr
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBECIDADE: TDBEditFocus
      Left = 79
      Top = 117
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_CODCID'
      DataSource = dtsCadConcorr
      TabOrder = 7
      OnKeyPress = DBECIDADEKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = DBECIDADEChamaCadastro
    end
    object edtNomCid: TEditFocus
      Left = 123
      Top = 117
      Width = 160
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 331
      Top = 117
      Width = 46
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumCEp: TDBEditFocus
      Tag = 99
      Left = 434
      Top = 117
      Width = 129
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCR_C_E_P_'
      DataSource = dtsCadConcorr
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 848
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 840
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 840
    Top = 16
  end
  object dtsCadConcorr: TDataSource
    Left = 616
    Top = 84
  end
end
