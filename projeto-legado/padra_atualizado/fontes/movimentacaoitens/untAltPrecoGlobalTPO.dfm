inherited frmAltPrecoGlobalTPO: TfrmAltPrecoGlobalTPO
  Left = 271
  Top = 148
  Width = 808
  Height = 630
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Global de Pre'#231'os - Tabela de Pre'#231'o Origem'
  Position = poScreenCenter
  ExplicitWidth = 808
  ExplicitHeight = 630
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 574
    Width = 802
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 585
    Width = 802
    ExplicitTop = 585
    ExplicitWidth = 802
    DesignSize = (
      802
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 798
      ExplicitWidth = 798
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 585
    Width = 802
    ExplicitTop = 585
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 655
      Width = 147
      ExplicitLeft = 655
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 655
      ExplicitWidth = 655
    end
  end
  inherited pgcDados: TPageControl
    Top = 306
    Width = 802
    Height = 192
    Visible = False
    ExplicitTop = 306
    ExplicitWidth = 802
    ExplicitHeight = 192
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 794
      ExplicitHeight = 160
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 802
    Height = 306
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 31
      Top = 9
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 32
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 43
      Top = 55
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label4: TLabel
      Left = 455
      Top = 55
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 66
      Top = 78
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label8: TLabel
      Left = 40
      Top = 101
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label5: TLabel
      Left = 33
      Top = 124
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Fiscal:'
    end
    object Label7: TLabel
      Left = 3
      Top = 193
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o de IPI:'
    end
    object Label9: TLabel
      Left = 294
      Top = 193
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo?:'
    end
    object ColorLabel1: TColorLabel
      Left = 373
      Top = 190
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object lblCodGpr: TLabel
      Left = 35
      Top = 261
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Pre'#231'o:'
    end
    object Label10: TLabel
      Left = 26
      Top = 238
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Compra:'
    end
    object Label167: TLabel
      Left = 26
      Top = 216
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Produto:'
    end
    object Label15: TLabel
      Left = 47
      Top = 148
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Pis:'
    end
    object Label16: TLabel
      Left = 30
      Top = 170
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Cofins:'
    end
    object lblCodDep: TLabel
      Left = 29
      Top = 284
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 101
      Top = 5
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = ''
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 101
      Top = 28
      Width = 435
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnKeyPress = edtDesIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 101
      Top = 51
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 500
      Top = 51
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 4
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 101
      Top = 74
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 5
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 101
      Top = 97
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 6
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesGru: TEditFocus
      Left = 151
      Top = 5
      Width = 385
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 170
      Top = 74
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 170
      Top = 97
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAbr: TEditFocus
      Tag = 99
      Left = 101
      Top = 120
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      OnKeyPress = edtCodAbrKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAbr: TEditFocus
      Left = 170
      Top = 120
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtClaIPI: TEditFocus
      Tag = 99
      Left = 101
      Top = 189
      Width = 188
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 11
      OnKeyPress = edtClaIPIKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgTipAlt: TRadioGroup
      Left = 540
      Top = 59
      Width = 249
      Height = 81
      Caption = 'Tipo de Altera'#231#227'o'
      Enabled = False
      ItemIndex = 2
      Items.Strings = (
        'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
        'Pre'#231'o de Custo, Alterando Margem de Lucro'
        'Pre'#231'o de Venda, Alterando Margem de Lucro')
      TabOrder = 10
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 330
      Top = 189
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 16
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object chkPenRec: TCheckBox
      Left = 542
      Top = 9
      Width = 248
      Height = 40
      Caption = 
        'Exibir somente produtos com pend'#234'ncia de rec'#225'lculo de pre'#231'o devi' +
        'do '#224' altera'#231#227'o de abrevi'#231#227'o fiscal'
      TabOrder = 2
      WordWrap = True
    end
    object edtCodGpr: TEditFocus
      Tag = 99
      Left = 101
      Top = 258
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 19
      OnExit = edtCodGprExit
      OnKeyPress = edtCodGprKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesGpr: TEditFocus
      Left = 170
      Top = 258
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 101
      Top = 235
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 18
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 170
      Top = 235
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 101
      Top = 212
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 17
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrdPro: TEditFocus
      Left = 170
      Top = 212
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAbfPis: TEditFocus
      Tag = 99
      Left = 101
      Top = 143
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 8
      OnExit = edtAbfPisExit
      OnKeyPress = edtAbfPisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesPis: TEditFocus
      Left = 170
      Top = 143
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAbfCof: TEditFocus
      Tag = 99
      Left = 101
      Top = 166
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 9
      OnExit = edtAbfCofExit
      OnKeyPress = edtAbfCofKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCof: TEditFocus
      Left = 170
      Top = 166
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 101
      Top = 281
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 21
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 170
      Top = 281
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgTiposAlt: TDBGridCitel [5]
    Left = 0
    Top = 306
    Width = 802
    Height = 192
    Align = alClient
    DataSource = dtsAltGlo
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgTiposAltDrawColumnCell
    OnDblClick = dbgTiposAltDblClick
    OnKeyDown = dbgTiposAltKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_DESCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o do Tipo de Altera'#231#227'o'
        Width = 487
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_ORIGEM'
        Title.Alignment = taCenter
        Title.Caption = 'Tabela Origem'
        Width = 119
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_VALCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 150
        Visible = True
      end>
  end
  object pnlDadosAlt: TPanel [6]
    Left = 0
    Top = 498
    Width = 802
    Height = 48
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object lblCamAlt: TLabel
      Left = 125
      Top = 6
      Width = 221
      Height = 14
      Caption = 'A Descri'#231#227'o campo sendo alterado vai aqui....'
    end
    object lbl1: TLabel
      Left = 10
      Top = 6
      Width = 83
      Height = 14
      Caption = 'Tabela de Pre'#231'os'
    end
    object edtCamAlt: TEditFocus
      Tag = 99
      Left = 125
      Top = 20
      Width = 190
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbbTabOrigem: TComboBox
      Left = 8
      Top = 20
      Width = 113
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      Text = 'Selecione...'
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 319
      Top = 20
      Width = 93
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnConfirmaAltClick
    end
    object btnCancelaAlt: TBitBtnLocked
      Left = 416
      Top = 20
      Width = 93
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = btnCancelaAltClick
    end
  end
  object pnlBotoesEnt: TPanel [7]
    Left = 0
    Top = 546
    Width = 802
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairAlt: TBitBtnLocked
      Left = 689
      Top = 2
      Width = 111
      Height = 24
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 184
    Top = 232
  end
  object cdsAltGlo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 232
    object cdsAltGloITE_DESCAM: TStringField
      FieldName = 'ITE_DESCAM'
      Size = 40
    end
    object cdsAltGloITE_VALCAM: TStringField
      FieldName = 'ITE_VALCAM'
      Size = 19
    end
    object cdsAltGloITE_MASCAM: TStringField
      FieldName = 'ITE_MASCAM'
      Size = 15
    end
    object cdsAltGloITE_NOMCAM: TStringField
      FieldName = 'ITE_NOMCAM'
      Size = 10
    end
    object cdsAltGloITE_DESABR: TStringField
      FieldName = 'ITE_DESABR'
      Size = 15
    end
    object cdsAltGloITE_LIMCAM: TIntegerField
      FieldName = 'ITE_LIMCAM'
    end
    object cdsAltGloITE_TIPCAM: TStringField
      FieldName = 'ITE_TIPCAM'
      Size = 15
    end
    object cdsAltGloITE_ALTERA: TStringField
      FieldName = 'ITE_ALTERA'
      Size = 1
    end
    object cdsAltGloITE_ORIGEM: TStringField
      FieldName = 'ITE_ORIGEM'
      Size = 15
    end
  end
  object dtsAltGlo: TDataSource
    DataSet = cdsAltGlo
    Left = 152
    Top = 232
  end
  object dspIteGlo: TUniDataSetProvider
    Options = []
    Left = 120
    Top = 272
  end
  object cdsIteGlo: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_DESITE'
    Params = <>
    ProviderName = 'dspIteGlo'
    Left = 152
    Top = 272
  end
end
