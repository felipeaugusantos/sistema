inherited frmCadCse: TfrmCadCse
  Width = 631
  Height = 345
  Caption = 'Cadastro de Signat'#225'rios da Escritura'#231#227'o'
  ExplicitWidth = 631
  ExplicitHeight = 345
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 274
    Width = 625
    Height = 26
    ExplicitTop = 274
    ExplicitWidth = 625
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 544
      Height = 22
      ExplicitWidth = 544
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        Height = 22
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 546
      Align = alRight
      ExplicitLeft = 546
    end
  end
  inherited pnlStatus: TPanel
    Top = 300
    Width = 625
    ExplicitTop = 300
    ExplicitWidth = 625
    inherited pnlNomeForm: TPanel
      Left = 278
      ExplicitLeft = 278
    end
    inherited pnlInfo: TPanel
      Width = 278
      ExplicitWidth = 278
    end
  end
  inherited pgcDados: TPageControl
    Width = 625
    Height = 274
    ExplicitWidth = 625
    ExplicitHeight = 274
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 617
      ExplicitHeight = 242
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 625
    Height = 274
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblDtaCer: TLabel
      Left = 8
      Top = 222
      Width = 115
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Validade Certid'#227'o:'
    end
    object lblNomSig: TLabel
      Left = 42
      Top = 38
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Signat'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQuaAss: TLabel
      Left = 2
      Top = 84
      Width = 121
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Qualifica'#231#227'o Assinante:'
    end
    object lblDocSig: TLabel
      Left = 13
      Top = 61
      Width = 110
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Documento Signat'#225'rio:'
    end
    object lblNumCrc: TLabel
      Left = 59
      Top = 107
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero CRC:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmaSig: TLabel
      Left = 45
      Top = 130
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Email Signat'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTelSig: TLabel
      Left = 28
      Top = 153
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone Signat'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblUfExCr: TLabel
      Left = 39
      Top = 176
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'UF de Expedi'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumCer: TLabel
      Left = 25
      Top = 199
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Certid'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblAguardandoSN: TColorLabel
      Left = 162
      Top = 245
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblSigRes: TLabel
      Left = 6
      Top = 245
      Width = 117
      Height = 14
      Alignment = taRightJustify
      Caption = 'Signat'#225'rio Respons'#225'vel:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblFormato: TLabel
      Left = 348
      Top = 199
      Width = 139
      Height = 14
      Caption = 'Formato(UF/Ano/N'#250'mero)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Tag = 50
      Left = 78
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeDtaCer: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 219
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_DTACER'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeNomSig: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 35
      Width = 470
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_NOMSIG'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object rdbCpf: TRadioButton
      Left = 128
      Top = 61
      Width = 51
      Height = 17
      Caption = 'CPF'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = rdbCpfClick
    end
    object rdbCnpj: TRadioButton
      Left = 176
      Top = 61
      Width = 58
      Height = 17
      Caption = 'CNPJ'
      TabOrder = 3
      OnClick = rdbCpfClick
    end
    object dbeDocSig: TDBEditFocus
      Tag = 99
      Left = 226
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_DOCSIG'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeNumCrc: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 104
      Width = 470
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_NUMCRC'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmaSig: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 127
      Width = 470
      Height = 22
      CharCase = ecLowerCase
      DataField = 'CSE_EMASIG'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTelSig: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 150
      Width = 167
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_TELSIG'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeUfExCr: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 173
      Width = 40
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_UFEXCR'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumCer: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 196
      Width = 212
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_NUMCER'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSigRes: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 242
      Width = 28
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_SIGRES'
      DataSource = dtsCadSig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbbQuaAss: TComboBoxFocus
      Tag = 99
      Left = 128
      Top = 81
      Width = 470
      Height = 22
      Style = csDropDownList
      Ctl3D = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      OnChange = cbbQuaAssChange
      Items.Strings = (
        '001 Pessoa Jur'#237'dica (e-CNPJ ou e-PJ)'
        '203 Diretor'
        '204 Conselheiro de Administra'#231#227'o'
        '205 Administrador'
        '206 Administrador do Grupo'
        '207 Administrador de Sociedade Filiada'
        '220 Administrador Judicial '#8211' Pessoa F'#237'sica'
        
          '222 Administrador Judicial '#8211' Pessoa Jur'#237'dica - Profissional Resp' +
          'ons'#225'vel'
        '223 Administrador Judicial/Gestor'
        '226 Gestor Judicial'
        '309 Procurador'
        '312 Inventariante'
        '313 Liquidante'
        '315 Interventor'
        '401 Titular '#8211' Pessoa F'#237'sica - EIRELI'
        '801 Empres'#225'rio'
        '900 Contador'
        '900 Contabilista'
        '999 Outros')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtNomEmp: TEditFocus
      Tag = 50
      Left = 193
      Top = 11
      Width = 405
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 128
      Top = 11
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CSE_CODEMP'
      DataSource = dtsCadSig
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1096
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1032
    Top = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1176
    Top = 352
  end
  object dtsCadSig: TDataSource
    Left = 264
    Top = 208
  end
end
