inherited frmCadAutAba: TfrmCadAutAba
  Left = 329
  Top = 205
  Width = 534
  Height = 276
  Caption = 'Autoriza'#231#227'o de Abastecimento'
  ExplicitWidth = 534
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 206
    Width = 528
    Height = 25
    TabOrder = 1
    ExplicitTop = 206
    ExplicitWidth = 528
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 453
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 453
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
      Left = 455
      Width = 71
      Height = 21
      Align = alRight
      ExplicitLeft = 455
      ExplicitWidth = 71
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 231
    Width = 528
    TabOrder = 3
    ExplicitTop = 231
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 384
      Width = 144
      ExplicitLeft = 384
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 384
      ExplicitWidth = 384
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 206
    Visible = False
    ExplicitWidth = 528
    ExplicitHeight = 206
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 174
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 206
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 54
      Top = 18
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sequ'#234'ncia:'
    end
    object Label2: TLabel
      Left = 49
      Top = 87
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 336
      Top = 18
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Emiss'#227'o:'
    end
    object Label7: TLabel
      Left = 16
      Top = 156
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vol. / Qtd de Litros:'
    end
    object Label28: TLabel
      Left = 61
      Top = 176
      Width = 47
      Height = 14
      Caption = 'Motorista:'
    end
    object Label4: TLabel
      Left = 70
      Top = 110
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object Label5: TLabel
      Left = 199
      Top = 132
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Combust'#237'vel:'
    end
    object Label6: TLabel
      Left = 259
      Top = 156
      Width = 117
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do Abastecimento:'
    end
    object Label8: TLabel
      Left = 63
      Top = 64
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label9: TLabel
      Left = 428
      Top = 132
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Utilizada:'
    end
    object Label10: TLabel
      Left = 10
      Top = 132
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Km Atual do Ve'#237'culo:'
    end
    object lblDigita: TLabel
      Left = 59
      Top = 40
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object dbeSeqAbast: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 11
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_SEQABA'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 80
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_CODFOR'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaEmi: TDBEditFocus
      Tag = 99
      Left = 409
      Top = 11
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_DTAEMI'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVolQtdLitros: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 149
      Width = 122
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_QTDLTS'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 173
      Top = 80
      Width = 328
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMot: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 172
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_CODMOT'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      OnKeyPress = dbeCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 173
      Top = 172
      Width = 328
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
    object dbePlaVei: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 103
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_PLAVEI'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      OnKeyPress = dbePlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomVei: TEditFocus
      Left = 173
      Top = 103
      Width = 328
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbcCombustivel: TDBComboBoxFocus
      Tag = 99
      Left = 263
      Top = 125
      Width = 145
      Height = 22
      Style = csDropDownList
      DataField = 'ABA_COMBUS'
      DataSource = dtsAutAba_
      Items.Strings = (
        'ALCOOL'
        'GASOLINA'
        'DIESEL'
        'GAS'
        'DIESEL S-10'
        #211'LEO MOTOR'
        #211'LEO CAMBIO'
        #211'LEO DIRE'#199#195'O'
        'DIESEL S-500'
        'ADIT ARLA')
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeValAbast: TDBEditFocus
      Tag = 99
      Left = 379
      Top = 149
      Width = 122
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_VLRABA'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 173
      Top = 57
      Width = 328
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 57
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_CODEMP'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeStatus: TDBEditFocus
      Left = 475
      Top = 126
      Width = 26
      Height = 22
      TabStop = False
      DataField = 'ABA_STATUS'
      DataSource = dtsAutAba_
      Enabled = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeKm_Vei: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 126
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ABA_KM_VEI'
      DataSource = dtsAutAba_
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 8
      OnKeyPress = dbeKm_VeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 173
      Top = 34
      Width = 328
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
    object dbeCodOpe: TDBEditFocus
      Tag = 99
      Left = 111
      Top = 34
      Width = 60
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ABA_CODOPE'
      DataSource = dtsAutAba_
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 104
  end
  object dtsAutAba_: TDataSource
    Left = 352
    Top = 40
  end
end
