inherited frmCadFuncionarios: TfrmCadFuncionarios
  Left = 344
  Top = 246
  Width = 716
  Height = 765
  Caption = 'Cadastro de Funcion'#225'rios'
  Position = poOwnerFormCenter
  ShowHint = True
  ExplicitWidth = 716
  ExplicitHeight = 765
  PixelsPerInch = 96
  TextHeight = 14
  object Label87: TLabel [0]
    Left = 216
    Top = 40
    Width = 38
    Height = 14
    Caption = 'Label87'
  end
  inherited pnlBotoes: TPanel
    Top = 671
    Width = 710
    Height = 49
    ExplicitTop = 671
    ExplicitWidth = 710
    ExplicitHeight = 49
    inherited FlwBotoes: TFlowPanel
      Width = 706
      Height = 45
      ExplicitTop = 2
      ExplicitWidth = 706
      ExplicitHeight = 45
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        Height = 22
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        Height = 22
        ExplicitLeft = 71
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        Height = 22
        ExplicitLeft = 142
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        Height = 22
        ExplicitLeft = 213
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 71
        Height = 22
        ExplicitLeft = 284
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 78
        Height = 22
        ExplicitLeft = 355
        ExplicitWidth = 78
        ExplicitHeight = 22
      end
      object btnFichaCad: TBitBtnLocked
        Left = 433
        Top = 0
        Width = 125
        Height = 22
        Caption = '&Ficha Cadastral'
        TabOrder = 6
        OnClick = btnFichaCadClick
      end
      object btnCadFor: TBitBtnLocked
        Left = 558
        Top = 0
        Width = 145
        Height = 22
        Caption = '&Cadastro de fornecedor'
        TabOrder = 7
        OnClick = btnCadForClick
      end
      object btnCadOpe: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 142
        Height = 22
        Caption = 'Cadastro de operador'
        TabOrder = 8
        OnClick = btnCadOpeClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 632
      Top = 24
      Width = 73
      Height = 21
      ExplicitLeft = 632
      ExplicitTop = 24
      ExplicitWidth = 73
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 720
    Width = 710
    ExplicitTop = 720
    ExplicitWidth = 710
    inherited pnlNomeForm: TPanel
      Left = 363
      ExplicitLeft = 363
    end
    inherited pnlInfo: TPanel
      Width = 363
      ExplicitWidth = 363
    end
  end
  inherited pgcDados: TPageControl
    Width = 710
    Height = 671
    Hint = 'ALT + [Setas] para navegar entre as abas.'
    StyleElements = [seFont, seBorder]
    OnEnter = pgcDadosEnter
    OnExit = pgcDadosExit
    OnMouseEnter = pgcDadosMouseEnter
    OnMouseLeave = pgcDadosMouseLeave
    ExplicitWidth = 710
    ExplicitHeight = 671
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 702
      ExplicitHeight = 639
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 702
        Height = 639
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl1: TLabel
          Left = 50
          Top = 10
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object lbl2: TLabel
          Left = 56
          Top = 34
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object lbl3: TLabel
          Left = 47
          Top = 195
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fun'#231#227'o:'
        end
        object lbl4: TLabel
          Left = 210
          Top = 219
          Width = 75
          Height = 14
          Caption = 'Data Admiss'#227'o:'
        end
        object lbl7: TLabel
          Left = 36
          Top = 240
          Width = 50
          Height = 14
          Caption = 'Pis/Pasep:'
        end
        object lbl8: TLabel
          Left = 41
          Top = 149
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label6: TLabel
          Left = 255
          Top = 240
          Width = 29
          Height = 14
          Alignment = taRightJustify
          Caption = 'CTPS:'
        end
        object Label13: TLabel
          Left = 391
          Top = 240
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Num S'#233'rie:'
        end
        object Label14: TLabel
          Left = 64
          Top = 264
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CPF:'
        end
        object Label15: TLabel
          Left = 395
          Top = 264
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Instru'#231#227'o:'
        end
        object Label16: TLabel
          Left = 68
          Top = 286
          Width = 18
          Height = 14
          Alignment = taRightJustify
          Caption = 'RG:'
        end
        object Label17: TLabel
          Left = 17
          Top = 312
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nacionalidade:'
        end
        object Label18: TLabel
          Left = 282
          Top = 311
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome Pai:'
        end
        object Label19: TLabel
          Left = 264
          Top = 333
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Local Nascto:'
        end
        object Label24: TLabel
          Left = 34
          Top = 333
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome M'#227'e:'
        end
        object Label23: TLabel
          Left = 422
          Top = 34
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Nascto:'
        end
        object Label20: TLabel
          Left = 272
          Top = 355
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado Civil:'
        end
        object Label22: TLabel
          Left = 31
          Top = 355
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cert. Militar:'
        end
        object lbl20: TLabel
          Left = 36
          Top = 172
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object Label1: TLabel
          Left = 167
          Top = 58
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label2: TLabel
          Left = 46
          Top = 80
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object Label3: TLabel
          Left = 167
          Top = 80
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label4: TLabel
          Left = 361
          Top = 80
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label5: TLabel
          Left = 50
          Top = 103
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label7: TLabel
          Left = 468
          Top = 104
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label9: TLabel
          Left = 64
          Top = 58
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label8: TLabel
          Left = 43
          Top = 126
          Width = 44
          Height = 14
          Caption = 'Telefone:'
        end
        object Label10: TLabel
          Left = 288
          Top = 126
          Width = 36
          Height = 14
          Caption = 'Celular:'
        end
        object Label66: TLabel
          Left = 59
          Top = 379
          Width = 27
          Height = 14
          Caption = 'Email:'
        end
        object Label79: TLabel
          Left = 380
          Top = 286
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Org'#227'o expe.:'
        end
        object Label80: TLabel
          Left = 559
          Top = 34
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sexo:'
        end
        object Label81: TLabel
          Left = 541
          Top = 195
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'CBO:'
        end
        object Label82: TLabel
          Left = 565
          Top = 240
          Width = 16
          Height = 14
          Alignment = taRightJustify
          Caption = 'UF:'
        end
        object Label83: TLabel
          Left = 223
          Top = 264
          Width = 62
          Height = 14
          Caption = 'Dta Emiss'#227'o:'
        end
        object Label84: TLabel
          Left = 223
          Top = 286
          Width = 62
          Height = 14
          Caption = 'Dta Emiss'#227'o:'
        end
        object Label85: TLabel
          Left = 3
          Top = 219
          Width = 84
          Height = 14
          Caption = 'Data Ex. Admiss.:'
        end
        object Label91: TLabel
          Left = 485
          Top = 379
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'CNS:'
        end
        object gpbCtaCor: TGroupBox
          Left = 26
          Top = 399
          Width = 420
          Height = 75
          Caption = 'Conta Corrente'
          TabOrder = 38
          object lbl9: TLabel
            Left = 27
            Top = 22
            Width = 34
            Height = 14
            Caption = 'Banco:'
          end
          object lbl10: TLabel
            Left = 18
            Top = 45
            Width = 43
            Height = 14
            Caption = 'Ag'#234'ncia:'
          end
          object lbl11: TLabel
            Left = 166
            Top = 45
            Width = 55
            Height = 14
            Caption = 'Num.Conta:'
          end
          object dbeBanco_: TDBEditFocus
            Tag = 99
            Left = 64
            Top = 18
            Width = 56
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FUN_BANCO_'
            DataSource = dtsCadFun
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnKeyPress = dbeBanco_KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeAgenci: TDBEditFocus
            Tag = 99
            Left = 64
            Top = 41
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FUN_AGENCI'
            DataSource = dtsCadFun
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeConta_: TDBEditFocus
            Tag = 99
            Left = 225
            Top = 41
            Width = 164
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FUN_CONTA_'
            DataSource = dtsCadFun
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtNomBan: TEditFocus
            Left = 122
            Top = 18
            Width = 267
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
        end
        object dbeCodFun: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 7
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODFUN'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeNomFun: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 30
          Width = 330
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NOMFUN'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodFnc: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 191
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_FUNATU'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 14
          OnKeyPress = dbeCodFncKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbePisPas: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 237
          Width = 113
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_PISPAS'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeObserv: TDBMemoFocus
          Tag = 99
          Left = 26
          Top = 527
          Width = 603
          Height = 55
          DataField = 'FUN_OBSERV'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ScrollBars = ssVertical
          TabOrder = 42
          OnKeyPress = dbeObservKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = ' '
        end
        object dbchkFUN_CARPON: TDBCheckBox
          Left = 460
          Top = 417
          Width = 169
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Cart'#227'o de Ponto OK?'
          DataField = 'FUN_CARPON'
          DataSource = dtsCadFun
          TabOrder = 39
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbchkFUN_REGIST: TDBCheckBox
          Left = 498
          Top = 443
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Registro OK?'
          DataField = 'FUN_REGIST'
          DataSource = dtsCadFun
          TabOrder = 40
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeDtaAdm: TDBEditFocus
          Tag = 99
          Left = 290
          Top = 212
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_DTAADM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodEmp: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 145
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODEMP'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 12
          OnKeyPress = dbeCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 152
          Top = 145
          Width = 477
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 43
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCTPS: TDBEditFocus
          Tag = 99
          Left = 288
          Top = 237
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_N_CTPS'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeNumSerie: TDBEditFocus
          Tag = 99
          Left = 445
          Top = 237
          Width = 114
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NUMSER'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeCPF: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 260
          Width = 113
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_C_P_F_'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbcGrauInstrucao: TDBComboBoxFocus
          Left = 445
          Top = 260
          Width = 184
          Height = 22
          Style = csDropDownList
          DataField = 'FUN_GRAINS'
          DataSource = dtsCadFun
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Items.Strings = (
            '1o. GRAU INCOMPLETO'
            '1o. GRAU COMPLETO'
            '2o. GRAU INCOMPLETO'
            '2o. GRAU COMPLETO'
            'SUPERIOR INCOMPLETO'
            'SUPERIOR COMPLETO'
            'P'#211'S GRADUA'#199#195'O INCOMPLETO'
            'P'#211'S GRADUA'#199#195'O COMPLETO ')
          ParentFont = False
          TabOrder = 25
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeRG: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 283
          Width = 113
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NUM_RG'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 15
          TabOrder = 26
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNacionalidade: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 306
          Width = 161
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NACION'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 30
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomePai: TDBEditFocus
          Tag = 99
          Left = 331
          Top = 306
          Width = 298
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NOMPAI'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 31
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodLocNascto: TDBEditFocus
          Tag = 99
          Left = 331
          Top = 329
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_LOCNAS'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 33
          OnKeyPress = dbeCodLocNasctoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtLocalNascto: TEditFocus
          Left = 375
          Top = 329
          Width = 254
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 44
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeNomeMae: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 329
          Width = 161
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NOMMAE'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 32
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaNascto: TDBEditFocus
          Tag = 99
          Left = 486
          Top = 30
          Width = 72
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_DTANAS'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbcEstadoCivil: TDBComboBoxFocus
          Left = 331
          Top = 352
          Width = 298
          Height = 22
          Style = csDropDownList
          DataField = 'FUN_ESTCIV'
          DataSource = dtsCadFun
          Items.Strings = (
            'SOLTEIRO(A)'
            'CASADO(A)'
            'VIUVO(A)'
            'MARITALMENTE'
            'DIVORCIADO(A)')
          TabOrder = 35
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeCertificadoMilitar: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 352
          Width = 161
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CERMIL'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 34
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object gpbDesligamento: TGroupBox
          Left = 26
          Top = 477
          Width = 603
          Height = 45
          Caption = 'Desligamento'
          TabOrder = 41
          object lbl5: TLabel
            Left = 8
            Top = 18
            Width = 75
            Height = 14
            Caption = 'Data Demiss'#227'o:'
          end
          object Label55: TLabel
            Left = 178
            Top = 18
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Motivo:'
          end
          object dbeDtaDem: TDBEditFocus
            Tag = 99
            Left = 89
            Top = 15
            Width = 86
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FUN_DTADEM'
            DataSource = dtsCadFun
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 40
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbcMotDes: TDBComboBoxFocus
            Tag = 99
            Left = 218
            Top = 15
            Width = 305
            Height = 22
            Style = csDropDownList
            DataField = 'FUN_MOTDES'
            DataSource = dtsCadFun
            Items.Strings = (
              'Demitido sem justa causa com aviso indenizado.'
              'Demitido sem justa causa com aviso trabalhado.'
              'Demitido por justa causa.'
              'Demitido por abandono de emprego.'
              'T'#233'rmino de contrato de trabalho no prazo.'
              'T'#233'rmino de contrato de trabalho antecipado.'
              'Pedido de demiss'#227'o com/sem desconto de aviso.'
              'Pedido de demiss'#227'o com aviso trabalhado.'
              'Pedido de demiss'#227'o por justa causa.'
              'Aposentadoria sem continuidade de vinculo.'
              'Aposentadoria com continuidade de vinculo.'
              'Aposentadoria por invalidez - Acidente de trabalho.'
              'Aposentadoria por invalidez - Doen'#231'a profissional.'
              'Aposentadoria por invalidez - Compuls'#243'ria.'
              'Aposentadoria por invalidez - Especial.'
              'Desligamento por falecimento.'
              'Falecimento - Acidente de trabalho a servi'#231'o.'
              'Falecimento - Acidente de trabalho de trajeto.'
              'Falecimento - Doen'#231'a profissional.')
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object dbeCodVen: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 168
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODVEN'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 13
          OnKeyPress = dbeCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomVen: TEditFocus
          Left = 152
          Top = 168
          Width = 477
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 45
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeEndFun: TDBEditFocus
          Tag = 99
          Left = 220
          Top = 53
          Width = 409
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_ENDERE'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComple: TDBEditFocus
          Tag = 99
          Left = 237
          Top = 76
          Width = 118
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_COMPLE'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndNum: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 76
          Width = 73
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_ENDNUM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBairro: TDBEditFocus
          Tag = 99
          Left = 395
          Top = 76
          Width = 234
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_BAIRRO'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCid: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 99
          Width = 38
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODCID'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 9
          OnKeyPress = dbeCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomCid: TEditFocus
          Left = 129
          Top = 99
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 46
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstado: TEditFocus
          Left = 511
          Top = 99
          Width = 118
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 47
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeNumCep: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 53
          Width = 73
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_C_E_P_'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          OnKeyPress = dbeNumCepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DbeNumTel: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 122
          Width = 194
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NUMTEL'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DbeNumCel: TDBEditFocus
          Tag = 99
          Left = 327
          Top = 122
          Width = 302
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NUMCEL'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DbeEmailFun: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 375
          Width = 217
          Height = 22
          DataField = 'FUN_EMAIL_'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 36
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtNomFnc: TEditFocus
          Left = 152
          Top = 191
          Width = 383
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
        object DBEditFocus1: TDBEditFocus
          Tag = 99
          Left = 445
          Top = 283
          Width = 136
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NRGEXP'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 15
          TabOrder = 28
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBComboBoxFocus1: TDBComboBoxFocus
          Left = 583
          Top = 283
          Width = 46
          Height = 22
          Style = csDropDownList
          DataField = 'FUN_RG_CUF'
          DataSource = dtsCadFun
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Items.Strings = (
            ''
            'AC'
            'AL'
            'AM'
            'AP'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MG'
            'MS'
            'MT'
            'PA'
            'PB'
            'PE'
            'PI'
            'PR'
            'RJ'
            'RN'
            'RO'
            'RR'
            'RS'
            'SC'
            'SP'
            'TO'
            'SE')
          ParentFont = False
          TabOrder = 29
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object DBComboBoxFocus2: TDBComboBoxFocus
          Left = 590
          Top = 30
          Width = 39
          Height = 22
          Style = csDropDownList
          DataField = 'FUN_SEXOFU'
          DataSource = dtsCadFun
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Items.Strings = (
            ''
            'M'
            'F')
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object DBEditFocus2: TDBEditFocus
          Tag = 99
          Left = 567
          Top = 191
          Width = 62
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODCBO'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 15
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBComboBoxFocus3: TDBComboBoxFocus
          Left = 583
          Top = 237
          Width = 46
          Height = 22
          Style = csDropDownList
          DataField = 'FUN_CTPSUF'
          DataSource = dtsCadFun
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Items.Strings = (
            ''
            'AC'
            'AL'
            'AM'
            'AP'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MG'
            'MS'
            'MT'
            'PA'
            'PB'
            'PE'
            'PI'
            'PR'
            'RJ'
            'RN'
            'RO'
            'RR'
            'RS'
            'SC'
            'SP'
            'TO'
            'SE')
          ParentFont = False
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object DBEditFocus3: TDBEditFocus
          Tag = 99
          Left = 288
          Top = 260
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CPFDEM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus4: TDBEditFocus
          Tag = 99
          Left = 288
          Top = 283
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUNC_RGDEM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaExa: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 214
          Width = 113
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_DTAEXA'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCNS: TDBEditFocus
          Tag = 99
          Left = 516
          Top = 375
          Width = 113
          Height = 22
          Hint = 'Cart'#227'o Nacional de Sa'#250'de'
          CharCase = ecUpperCase
          DataField = 'FUN_CODCNS'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 37
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
    end
    object tbsComp: TTabSheet
      Caption = '&2 - Complemento'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 592
      object lCodNacionalidade: TLabel
        Left = 3
        Top = 569
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cod. Nacionalidade:'
      end
      object lNaturezaOcupacao: TLabel
        Left = 297
        Top = 569
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Natureza Ocupa'#231#227'o:'
      end
      object lDtIniEmprego: TLabel
        Left = 284
        Top = 593
        Width = 112
        Height = 14
        Caption = 'Data In'#237'cio no Emprego:'
      end
      object lRendimento: TLabel
        Left = 38
        Top = 593
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Rendimento:'
      end
      object gpbHorTrab: TGroupBox
        Left = 3
        Top = 3
        Width = 586
        Height = 187
        Caption = 'Hor'#225'rio de Trabalho'
        TabOrder = 0
        object Label25: TLabel
          Left = 57
          Top = 22
          Width = 65
          Height = 14
          Caption = 'Domingo das:'
        end
        object Label26: TLabel
          Left = 190
          Top = 22
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label27: TLabel
          Left = 294
          Top = 22
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label28: TLabel
          Left = 413
          Top = 22
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label29: TLabel
          Left = 27
          Top = 46
          Width = 95
          Height = 14
          Caption = 'Segunda-Feira das:'
        end
        object Label30: TLabel
          Left = 190
          Top = 46
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label31: TLabel
          Left = 294
          Top = 46
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label32: TLabel
          Left = 413
          Top = 46
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label33: TLabel
          Left = 413
          Top = 70
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label34: TLabel
          Left = 294
          Top = 70
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label35: TLabel
          Left = 190
          Top = 70
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label36: TLabel
          Left = 42
          Top = 70
          Width = 79
          Height = 14
          Caption = 'Ter'#231'a-Feira das:'
        end
        object Label37: TLabel
          Left = 37
          Top = 93
          Width = 85
          Height = 14
          Caption = 'Quarta-Feira das:'
        end
        object Label38: TLabel
          Left = 190
          Top = 93
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label39: TLabel
          Left = 294
          Top = 93
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label40: TLabel
          Left = 413
          Top = 93
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label41: TLabel
          Left = 39
          Top = 116
          Width = 83
          Height = 14
          Caption = 'Quinta-Feira das:'
        end
        object Label42: TLabel
          Left = 190
          Top = 116
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label43: TLabel
          Left = 294
          Top = 116
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label44: TLabel
          Left = 413
          Top = 116
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label45: TLabel
          Left = 42
          Top = 139
          Width = 80
          Height = 14
          Caption = 'Sexta-Feira das:'
        end
        object Label46: TLabel
          Left = 190
          Top = 139
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label47: TLabel
          Left = 294
          Top = 139
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label48: TLabel
          Left = 413
          Top = 139
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label49: TLabel
          Left = 61
          Top = 162
          Width = 61
          Height = 14
          Caption = 'S'#225'bado das:'
        end
        object Label50: TLabel
          Left = 190
          Top = 162
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object Label51: TLabel
          Left = 294
          Top = 162
          Width = 30
          Height = 14
          Caption = 'e das:'
        end
        object Label52: TLabel
          Left = 413
          Top = 162
          Width = 12
          Height = 14
          Caption = 'as'
        end
        object dbeDom1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 18
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1DOM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDom2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 18
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2DOM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDom3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 18
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3DOM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDom4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 18
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4DOM'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSeg1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 42
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1SEG'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSeg2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 42
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2SEG'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSeg3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 42
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3SEG'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSeg4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 42
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4SEG'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTer4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 66
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4TER'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTer3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 66
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3TER'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTer2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 66
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2TER'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTer1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 66
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1TER'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQua1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 89
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1QUA'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQua2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 89
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2QUA'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQua3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 89
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3QUA'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQua4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 89
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4QUA'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQui1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 112
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1QUI'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQui2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 112
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2QUI'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQui3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 112
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3QUI'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQui4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 112
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4QUI'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSex1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 135
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1SEX'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSex2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 135
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2SEX'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSex3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 135
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3SEX'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSex4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 135
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4SEX'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSab1: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 158
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT1SAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSab2: TDBEditFocus
          Tag = 99
          Left = 208
          Top = 158
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT2SAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 25
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSab3: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 158
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT3SAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 26
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSab4: TDBEditFocus
          Tag = 99
          Left = 431
          Top = 158
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_HT4SAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTitEle: TGroupBox
        Left = 3
        Top = 195
        Width = 586
        Height = 65
        Caption = 'T'#237'tulo de Eleitor'
        TabOrder = 1
        object Label56: TLabel
          Left = 16
          Top = 28
          Width = 43
          Height = 14
          Caption = 'N'#186' T'#237'tulo:'
        end
        object Label57: TLabel
          Left = 196
          Top = 28
          Width = 28
          Height = 14
          Caption = 'Zona:'
        end
        object Label58: TLabel
          Left = 327
          Top = 28
          Width = 34
          Height = 14
          Caption = 'Se'#231#227'o:'
        end
        object dbeNumTit: TDBEditFocus
          Tag = 99
          Left = 62
          Top = 24
          Width = 128
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_NUMTIT'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeZonTit: TDBEditFocus
          Tag = 99
          Left = 230
          Top = 24
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_ZONTIT'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSecTit: TDBEditFocus
          Tag = 99
          Left = 367
          Top = 24
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_SECTIT'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbCarHab: TGroupBox
        Left = 3
        Top = 265
        Width = 586
        Height = 65
        Caption = 'Carteira de Habilita'#231#227'o'
        TabOrder = 2
        object Label59: TLabel
          Left = 17
          Top = 30
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#186' Cart. Hab:'
        end
        object Label60: TLabel
          Left = 278
          Top = 30
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria:'
        end
        object Label61: TLabel
          Left = 374
          Top = 30
          Width = 44
          Height = 14
          Caption = 'Validade:'
        end
        object dbeCatHab: TDBEditFocus
          Tag = 99
          Left = 330
          Top = 27
          Width = 32
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CATHAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValHab: TDBEditFocus
          Tag = 99
          Left = 423
          Top = 27
          Width = 86
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_VALHAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHabilitacao: TDBEditFocus
          Tag = 99
          Left = 86
          Top = 27
          Width = 181
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CARHAB'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbDadosPess: TGroupBox
        Left = 3
        Top = 335
        Width = 586
        Height = 150
        Caption = 'Dados Pessoais'
        TabOrder = 3
        object Label70: TLabel
          Left = 61
          Top = 100
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Altura:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object Label71: TLabel
          Left = 65
          Top = 124
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Peso:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object Label72: TLabel
          Left = 151
          Top = 100
          Width = 20
          Height = 14
          Caption = 'mts.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object Label73: TLabel
          Left = 150
          Top = 124
          Width = 13
          Height = 14
          Caption = 'Kg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object Label74: TLabel
          Left = 59
          Top = 28
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Filhos?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel1: TColorLabel
          Left = 135
          Top = 27
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label75: TLabel
          Left = 73
          Top = 52
          Width = 20
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel2: TColorLabel
          Left = 135
          Top = 52
          Width = 172
          Height = 14
          Caption = '(A)marelo (B)ranco Pa(R)do (P)reto'
          CorDestaque = clRed
        end
        object lbl21: TLabel
          Left = 16
          Top = 76
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tamanho roupa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel3: TColorLabel
          Left = 135
          Top = 76
          Width = 89
          Height = 14
          Caption = 'P / M / G / GG / XG'
          CorDestaque = clRed
        end
        object Label76: TLabel
          Left = 209
          Top = 28
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantos:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object lbl42: TLabel
          Left = 190
          Top = 88
          Width = 119
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'N'#237'vel de Qualidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl22: TLabel
          Left = 352
          Top = 18
          Width = 105
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Foto 1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl23: TLabel
          Left = 459
          Top = 18
          Width = 105
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Foto 2'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbeAltura: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 96
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_ALTURA'
          DataSource = dtsCadFun
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
        object dbePesFun: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 120
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_PESFUN'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeFilhos: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 24
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_FILHOS'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeCorFun: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 48
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CORFUN'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeTamanh: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 72
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_TAMANH'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeQtdFil: TDBEditFocus
          Tag = 99
          Left = 257
          Top = 24
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_QTDFIL'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object pnlSemaforo: TPanel
          Left = 188
          Top = 101
          Width = 121
          Height = 41
          BevelInner = bvRaised
          BevelOuter = bvLowered
          ParentColor = True
          TabOrder = 6
          object imgCinza: TImage
            Left = 1
            Top = 1
            Width = 40
            Height = 38
            Center = True
            Proportional = True
            Stretch = True
            Transparent = True
            OnClick = imgCinzaClick
          end
          object imgAzul: TImage
            Tag = 1
            Left = 40
            Top = 1
            Width = 40
            Height = 38
            Center = True
            Proportional = True
            Stretch = True
            Transparent = True
            OnClick = imgCinzaClick
          end
          object imgVerde: TImage
            Tag = 2
            Left = 79
            Top = 1
            Width = 40
            Height = 38
            Center = True
            Proportional = True
            Stretch = True
            Transparent = True
            OnClick = imgCinzaClick
          end
        end
        object pnlImgFun1: TPanel
          Left = 352
          Top = 35
          Width = 105
          Height = 105
          BevelInner = bvLowered
          BorderWidth = 2
          BorderStyle = bsSingle
          Color = clWhite
          ParentBackground = False
          TabOrder = 7
          object imgFoto01: TImage
            Left = 4
            Top = 4
            Width = 93
            Height = 93
            Hint = 'Duplo-clique para alterar a Foto'
            Align = alClient
            Center = True
            IncrementalDisplay = True
            ParentShowHint = False
            Proportional = True
            ShowHint = True
            Stretch = True
            OnDblClick = imgFoto01DblClick
          end
          object btnAmpliar1: TSpeedButton
            Left = 4
            Top = 4
            Width = 23
            Height = 22
            Hint = 'Ampliar foto'
            Enabled = False
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33033333333333333F7F3333333333333000333333333333F777333333333333
              000333333333333F777333333333333000333333333333F77733333333333300
              033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
              33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
              3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
              33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
              333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
              333333773FF77333333333370007333333333333777333333333}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnAmpliar1Click
          end
        end
        object pnlImgFun2: TPanel
          Left = 459
          Top = 35
          Width = 105
          Height = 105
          BevelInner = bvLowered
          BorderWidth = 2
          BorderStyle = bsSingle
          Color = clWhite
          ParentBackground = False
          TabOrder = 8
          object imgFoto02: TImage
            Left = 4
            Top = 4
            Width = 93
            Height = 93
            Hint = 'Duplo-clique para alterar a Foto'
            Align = alClient
            Center = True
            IncrementalDisplay = True
            ParentShowHint = False
            Proportional = True
            ShowHint = True
            Stretch = True
            OnDblClick = imgFoto02DblClick
          end
          object btnAmpliar2: TSpeedButton
            Left = 4
            Top = 4
            Width = 23
            Height = 22
            Hint = 'Ampliar foto'
            Enabled = False
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33033333333333333F7F3333333333333000333333333333F777333333333333
              000333333333333F777333333333333000333333333333F77733333333333300
              033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
              33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
              3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
              33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
              333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
              333333773FF77333333333370007333333333333777333333333}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnAmpliar2Click
          end
        end
      end
      object pnlBotoesInfo: TPanel
        Left = 0
        Top = 614
        Width = 702
        Height = 25
        Align = alBottom
        BevelInner = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object btnAbrirPastaAnexos: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 148
          Height = 21
          Align = alLeft
          Caption = 'Arquivos Anexos'
          Enabled = False
          TabOrder = 0
          OnClick = btnAbrirPastaAnexosClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 491
        Width = 586
        Height = 65
        Caption = 'Per'#237'odo de Experi'#234'ncia'
        TabOrder = 5
        object Label89: TLabel
          Left = 14
          Top = 32
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Em experi'#234'ncia?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel4: TColorLabel
          Left = 135
          Top = 31
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeEmExpe: TDBEditFocus
          Tag = 99
          Left = 97
          Top = 28
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_EMEXPE'
          DataSource = dtsCadFun
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbchkExpM45: TDBCheckBox
          Left = 328
          Top = 30
          Width = 73
          Height = 17
          Alignment = taLeftJustify
          Caption = '+ 45 dias'
          DataField = 'FUN_EXPM45'
          DataSource = dtsCadFun
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dbchkExpM45Click
        end
        object dbchkExp45d: TDBCheckBox
          Left = 214
          Top = 30
          Width = 70
          Height = 17
          Alignment = taLeftJustify
          Caption = '45 dias'
          DataField = 'FUN_EXP45D'
          DataSource = dtsCadFun
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dbchkExp45dClick
        end
      end
      object dbeCodNacionalidade: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 564
        Width = 191
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_CODNAC'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNatOcupacao: TDBEditFocus
        Tag = 99
        Left = 400
        Top = 564
        Width = 189
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_NATOCU'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaInicioEmprego: TDBEditFocus
        Tag = 99
        Left = 400
        Top = 589
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_DTIEMP'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRendimento: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 589
        Width = 104
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_RENDIM'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object tbsBeneficiarios: TTabSheet
      Caption = '&3 - Benefici'#225'rios'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlBenef: TPanel
        Tag = 99
        Left = 0
        Top = 0
        Width = 702
        Height = 129
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        object Label53: TLabel
          Left = 98
          Top = 9
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label54: TLabel
          Left = 28
          Top = 32
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grau de Parentesco:'
        end
        object Label67: TLabel
          Left = 110
          Top = 55
          Width = 18
          Height = 14
          Alignment = taRightJustify
          Caption = 'RG:'
        end
        object Label68: TLabel
          Left = 246
          Top = 55
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CPF:'
        end
        object Label69: TLabel
          Left = 57
          Top = 78
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data de Nasc.:'
        end
        object Label86: TLabel
          Left = 6
          Top = 103
          Width = 122
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dependente entra no IR?:'
        end
        object ColorLabel6: TColorLabel
          Left = 162
          Top = 103
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object edtBenefNome: TEditFocus
          Tag = 99
          Left = 132
          Top = 6
          Width = 395
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 0
          OnExit = edtBenefNomeExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 40
          TipoTexto = ttAlfanumerico
        end
        object cbxBenefgrauParen: TComboBoxFocus
          Tag = 99
          Left = 132
          Top = 29
          Width = 229
          Height = 22
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'FILHO(A)'
            'ESPOSO(A)'
            'MAE'
            'PAI'
            'SOGRO(A)')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtRG: TEditFocus
          Tag = 99
          Left = 132
          Top = 52
          Width = 111
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 20
          TabOrder = 2
          OnExit = edtRGExit
          OnKeyPress = edtRGKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object mskDtaNasc: TcxDateEdit
          Tag = 99
          Left = 132
          Top = 75
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 4
          Width = 90
        end
        object mskCpf: TMaskEditC_G_C_
          Tag = 99
          Left = 275
          Top = 52
          Width = 86
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999.999-99;0;'
          MaxLength = 14
          TabOrder = 3
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtBenefEntraIR: TEditFocus
          Tag = 99
          Left = 132
          Top = 100
          Width = 26
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 40
          TipoTexto = ttAlfanumerico
        end
      end
      object dbgBenef: TcxGrid
        Left = 0
        Top = 156
        Width = 702
        Height = 483
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgBenefDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsBenef
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object dbgBenefDBTableViewNOMBEN: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'NOMBEN'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 200
          end
          object dbgBenefDBTableViewGRAPAR: TcxGridDBColumn
            Caption = 'Grau Parentesco'
            DataBinding.FieldName = 'GRAPAR'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 100
          end
          object dbgBenefDBTableViewNUMRG: TcxGridDBColumn
            Caption = 'RG'
            DataBinding.FieldName = 'NUMRG'
            Options.Filtering = False
            Width = 100
          end
          object dbgBenefDBTableViewNUMCPF: TcxGridDBColumn
            Caption = 'CPF'
            DataBinding.FieldName = 'NUMCPF'
            PropertiesClassName = 'TcxMaskEditProperties'
            Properties.EditMask = '999.999.999-99'
            Options.Filtering = False
            Width = 100
          end
          object dbgBenefDBTableViewDTANAS: TcxGridDBColumn
            Caption = 'Data Nasc.'
            DataBinding.FieldName = 'DTANAS'
            PropertiesClassName = 'TcxDateEditProperties'
            Options.Filtering = False
            Width = 65
          end
          object dbgBenefDBTableViewDEPEIR: TcxGridDBColumn
            Caption = 'I.R.'
            DataBinding.FieldName = 'DEPEIR'
            Width = 25
          end
        end
        object dbgBenefLevel1: TcxGridLevel
          GridView = dbgBenefDBTableView
        end
      end
      object pnlAcoesBeneficiario: TPanel
        Left = 0
        Top = 129
        Width = 702
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
        object btnIncluirBeneficiario: TBitBtnLocked
          Left = 4
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Incluir'
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
          TabOrder = 0
          OnClick = btnIncluirBeneficiarioClick
        end
        object btnAlterarBeneficiario: TBitBtnLocked
          Left = 157
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Alterar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnAlterarBeneficiarioClick
        end
        object btnExcluirBeneficiario: TBitBtnLocked
          Left = 234
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Excluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnExcluirBeneficiarioClick
        end
        object btnCancelarBeneficiario: TBitBtnLocked
          Left = 311
          Top = 2
          Width = 76
          Height = 24
          Caption = 'Ca&ncelar'
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
          TabOrder = 4
          OnClick = btnCancelarBeneficiarioClick
        end
        object btnGravarBeneficiario: TBitBtnLocked
          Left = 81
          Top = 2
          Width = 76
          Height = 24
          Caption = 'G&ravar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
            7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF313131726E726A66697D797A2929293838384242422828286868683131
            31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
            6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
            CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
            203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
            A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
            E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
            D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
            ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
            FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
            2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
            5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
            DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
            D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
            C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnGravarBeneficiarioClick
        end
      end
    end
    object tbsFerias: TTabSheet
      Caption = '&4 - F'#233'rias'
      ImageIndex = 1
      OnShow = tbsFeriasShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFerias: TPanel
        Left = 0
        Top = 0
        Width = 702
        Height = 113
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        object lbl12: TLabel
          Left = 214
          Top = 14
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
        end
        object lbl13: TLabel
          Left = 19
          Top = 14
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Per'#237'odo Aquisitivo:'
        end
        object lbl14: TLabel
          Left = 24
          Top = 38
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Per'#237'odo de Gozo:'
        end
        object lbl15: TLabel
          Left = 214
          Top = 39
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
        end
        object lbl16: TLabel
          Left = 17
          Top = 63
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Recebimento:'
        end
        object lbl17: TLabel
          Left = 31
          Top = 87
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Recebido:'
        end
        object Label88: TLabel
          Left = 329
          Top = 39
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dias comprados:'
        end
        object mskAquIni: TcxDateEdit
          Tag = 99
          Left = 107
          Top = 9
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          OnExit = mskAquIniExit
          Width = 104
        end
        object mskAquFin: TcxDateEdit
          Tag = 99
          Left = 222
          Top = 10
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 104
        end
        object mskGozIni: TcxDateEdit
          Tag = 99
          Left = 107
          Top = 34
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 2
          Width = 104
        end
        object mskGozFin: TcxDateEdit
          Tag = 99
          Left = 222
          Top = 35
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 3
          Width = 104
        end
        object mskDtaRec: TcxDateEdit
          Tag = 99
          Left = 107
          Top = 59
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 5
          Width = 104
        end
        object dbeValRec: TEditFocus
          Tag = 99
          Left = 107
          Top = 84
          Width = 104
          Height = 22
          Alignment = taRightJustify
          TabOrder = 6
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '0.00'
        end
        object cbQtdDiasCompra: TComboBox
          Left = 414
          Top = 34
          Width = 40
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = '0'
          OnExit = cbQtdDiasCompraExit
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20'
            '21'
            '22'
            '23'
            '24'
            '25'
            '26'
            '27'
            '28'
            '29'
            '30')
        end
      end
      object pnl3: TPanel
        Left = 0
        Top = 140
        Width = 702
        Height = 19
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentBackground = False
        TabOrder = 2
        object lbl18: TLabel
          Left = 13
          Top = 3
          Width = 163
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Per'#237'odo Aquisitivo'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object lbl19: TLabel
          Left = 174
          Top = 3
          Width = 163
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Per'#237'odo de Gozo'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
      object dbgFerias: TcxGrid
        Left = 0
        Top = 159
        Width = 702
        Height = 480
        Align = alClient
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgFeriasDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsFerias
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.Indicator = True
          object dbgFeriasDBTableViewAQUINI: TcxGridDBColumn
            Caption = 'Data Inicial'
            DataBinding.FieldName = 'AQUINI'
            PropertiesClassName = 'TcxDateEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 70
          end
          object dbgFeriasDBTableViewAQUFIN: TcxGridDBColumn
            Caption = 'Data Final'
            DataBinding.FieldName = 'AQUFIN'
            PropertiesClassName = 'TcxDateEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 70
          end
          object dbgFeriasDBTableViewGOZINI: TcxGridDBColumn
            Caption = 'Data Inicial'
            DataBinding.FieldName = 'GOZINI'
            PropertiesClassName = 'TcxDateEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 70
          end
          object dbgFeriasDBTableViewGOZFIN: TcxGridDBColumn
            Caption = 'Data Final'
            DataBinding.FieldName = 'GOZFIN'
            PropertiesClassName = 'TcxDateEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 70
          end
          object dbgFeriasDBTableViewDTAREC: TcxGridDBColumn
            Caption = 'Data Receb.'
            DataBinding.FieldName = 'DTAREC'
            PropertiesClassName = 'TcxDateEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 70
          end
          object dbgFeriasDBTableViewVALREC: TcxGridDBColumn
            Caption = 'Vlr. Recebido'
            DataBinding.FieldName = 'VALREC'
            PropertiesClassName = 'TcxTextEditProperties'
            HeaderAlignmentHorz = taRightJustify
            Options.Filtering = False
            Width = 71
          end
          object dbgFeriasDBTableView1DIAGOZ: TcxGridDBColumn
            Caption = 'Dias de Gozo'
            DataBinding.FieldName = 'DIAGOZ'
            Width = 72
          end
          object dbgFeriasDBTableViewFER_DIACOM: TcxGridDBColumn
            Caption = 'Dias Comprado'
            DataBinding.FieldName = 'DIACOM'
            Width = 83
          end
          object dbgFeriasDBTableView1SALGOZ: TcxGridDBColumn
            Caption = 'Dias Restantes'
            DataBinding.FieldName = 'SALDO'
            Width = 80
          end
          object dbgFeriasDBTableView1ANO: TcxGridDBColumn
            DataBinding.FieldName = 'ANO'
            Visible = False
            GroupIndex = 0
          end
        end
        object dbgFeriasLevel1: TcxGridLevel
          GridView = dbgFeriasDBTableView1
        end
      end
      object pnlAcoesFerias: TPanel
        Left = 0
        Top = 113
        Width = 702
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
        object btnIncluirFerias: TBitBtnLocked
          Left = 5
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Incluir'
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
          TabOrder = 0
          OnClick = btnIncluirFeriasClick
        end
        object btnAlterarFerias: TBitBtnLocked
          Left = 157
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Alterar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnAlterarFeriasClick
        end
        object btnExcluirFerias: TBitBtnLocked
          Left = 234
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Excluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnExcluirFeriasClick
        end
        object btnCancelarFerias: TBitBtnLocked
          Left = 311
          Top = 2
          Width = 76
          Height = 24
          Caption = 'Ca&ncelar'
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
          TabOrder = 4
          OnClick = btnCancelarFeriasClick
        end
        object btnGravarFerias: TBitBtnLocked
          Left = 81
          Top = 2
          Width = 76
          Height = 24
          Caption = 'G&ravar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
            7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF313131726E726A66697D797A2929293838384242422828286868683131
            31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
            6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
            CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
            203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
            A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
            E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
            D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
            ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
            FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
            2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
            5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
            DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
            D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
            C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnGravarFeriasClick
        end
      end
    end
    object tbsIntegracaoCitel: TTabSheet
      Caption = '&5 - Integra'#231#227'o Citel'
      ImageIndex = 4
      object grpVincTese: TGroupBox
        Left = 3
        Top = 3
        Width = 593
        Height = 65
        Caption = 'V'#237'nculo Arquivo'
        TabOrder = 0
        object Label11: TLabel
          Left = 76
          Top = 16
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label12: TLabel
          Left = 11
          Top = 39
          Width = 110
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo do Funcion'#225'rio:'
          WordWrap = True
        end
        object Label21: TLabel
          Left = 189
          Top = 39
          Width = 29
          Height = 14
          Alignment = taRightJustify
          Caption = 'D'#237'gito:'
        end
        object dbEmpTes: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 13
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_EMPTES'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnChange = dbEmpTesChange
          OnExit = dbEmpTesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbCodTes: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 36
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODTES'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbDigTes: TDBEditFocus
          Tag = 99
          Left = 219
          Top = 36
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_DIGTES'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object grpExpContabil: TGroupBox
        Left = 3
        Top = 75
        Width = 593
        Height = 45
        Caption = 'Exporta'#231#227'o Cont'#225'bil'
        TabOrder = 1
        object lblEmpContab: TLabel
          Left = 76
          Top = 16
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object dbeEmpCont: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 13
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_EMPCON'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsCtaPag: TTabSheet
      Caption = '&6 - Gera'#231#227'o Contas '#224' Pagar'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbl6: TLabel
        Left = 42
        Top = 137
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sal'#225'rio Base:'
      end
      object Label63: TLabel
        Left = 58
        Top = 160
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. INSS:'
      end
      object Label77: TLabel
        Left = 39
        Top = 183
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base C'#225'l. I.R.:'
      end
      object Label78: TLabel
        Left = 66
        Top = 206
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. I.R.:'
      end
      object grpDadosCP: TGroupBox
        Left = 3
        Top = 3
        Width = 593
        Height = 127
        Caption = 'Dados para Gera'#231#227'o do Contas a Pagar'
        TabOrder = 0
        object Label62: TLabel
          Left = 60
          Top = 94
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label64: TLabel
          Left = 45
          Top = 25
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label65: TLabel
          Left = 68
          Top = 71
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Evento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDesPorTes: TEditFocus
          Left = 167
          Top = 91
          Width = 395
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesForTes: TEditFocus
          Left = 167
          Top = 22
          Width = 395
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesEveTes: TEditFocus
          Left = 167
          Top = 68
          Width = 395
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
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
        object dbForTes: TDBEditFocus
          Tag = 99
          Left = 106
          Top = 22
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODFOR'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 2
          OnKeyPress = dbForTesKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbEveTes: TDBEditFocus
          Tag = 99
          Left = 106
          Top = 68
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODEVE'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = dbEveTesKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbPorTes: TDBEditFocus
          Tag = 99
          Left = 106
          Top = 91
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FUN_CODPOR'
          DataSource = dtsCadFun
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 5
          OnKeyPress = dbPorTesKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
          Left = 27
          Top = 45
          Width = 540
          Height = 22
          TabOrder = 3
          ExplicitLeft = 27
          ExplicitTop = 45
          ExplicitWidth = 540
          inherited lblPlaContas: TLabel
            Left = 2
            Width = 75
            Height = 14
            Caption = 'Plano de Conta:'
            ExplicitLeft = 2
            ExplicitWidth = 75
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 79
            Width = 60
            Height = 22
            DataField = 'FUN_CODCTA'
            DataSource = dtsCadFun
            OnExit = fraPlanoDeContasdbeCodCtaExit
            OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
            ExplicitLeft = 79
            ExplicitWidth = 60
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 140
            Width = 395
            Height = 22
            ExplicitLeft = 140
            ExplicitWidth = 395
            ExplicitHeight = 22
          end
        end
      end
      object dbeSalBas: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 133
        Width = 104
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_SALBAS'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeAlqIns: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 156
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_ALQINS'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeBCalIr: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 179
        Width = 104
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_BCALIR'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeAliqIr: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 202
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FUN_ALIQIR'
        DataSource = dtsCadFun
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 590
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 564
  end
  object dtsCadFun: TDataSource
    Left = 584
    Top = 500
  end
  object cdsFerias: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 114
    object cdsFeriasCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
    object cdsFeriasAQUINI: TDateField
      FieldName = 'AQUINI'
    end
    object cdsFeriasAQUFIN: TDateField
      FieldName = 'AQUFIN'
    end
    object cdsFeriasGOZINI: TDateField
      FieldName = 'GOZINI'
    end
    object cdsFeriasGOZFIN: TDateField
      FieldName = 'GOZFIN'
    end
    object cdsFeriasDTAREC: TDateField
      FieldName = 'DTAREC'
    end
    object fltfldFeriasVALREC: TFloatField
      FieldName = 'VALREC'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object cdsFeriasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsFeriasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsFeriasDIACOM: TIntegerField
      FieldName = 'DIACOM'
    end
    object cdsFeriasSALGOZ: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'SALGOZ'
    end
    object cdsFeriasDIAGOZ: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'DIAGOZ'
    end
    object cdsFeriasSALDO: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'SALDO'
    end
    object cdsFeriasANO: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'ANO'
    end
  end
  object dtsFerias: TDataSource
    DataSet = cdsFerias
    OnStateChange = dtsFeriasStateChange
    Left = 416
    Top = 116
  end
  object cdsBenef: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 110
    object cdsBenefCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
    object cdsBenefNOMBEN: TStringField
      FieldName = 'NOMBEN'
      Size = 40
    end
    object cdsBenefGRAPAR: TStringField
      FieldName = 'GRAPAR'
      Size = 10
    end
    object cdsBenefNUMRG: TStringField
      FieldName = 'NUMRG'
    end
    object cdsBenefNUMCPF: TStringField
      DisplayWidth = 14
      FieldName = 'NUMCPF'
      Size = 14
    end
    object cdsBenefDTANAS: TDateField
      FieldName = 'DTANAS'
    end
    object cdsBenefAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsBenefCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsBenefDEPEIR: TStringField
      FieldName = 'DEPEIR'
      Size = 1
    end
  end
  object dtsBenef: TDataSource
    DataSet = cdsBenef
    OnStateChange = dtsBenefStateChange
    Left = 360
    Top = 568
  end
  object imglSemaforoOn: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 40
    Width = 40
    Left = 408
    Top = 584
    Bitmap = {
      494C010103000500040028002800FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000A00000002800000001002000000000000064
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011000000160000001B0000001F0000
      002100000022000000210000001E0000001A000000150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011000000160000001B0000001F0000
      002100000022000000210000001E0000001A000000150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011000000160000001B0000001F0000
      002100000022000000210000001E0000001A000000150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100000001A000000250000002F000000370000003E000000430000
      00460000004600000045000000420000003C000000340000002B000000210000
      00170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100000001A000000250000002F000000370000003E000000430000
      00460000004600000045000000420000003C000000340000002B000000210000
      00170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100000001A000000250000002F000000370000003E000000430000
      00460000004600000045000000420000003C000000340000002B000000210000
      00170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100000
      001D0000002C0000003B00000058242424F92A2A2AFF2A2A2AFF2A2A2AFF2A2A
      2AFF2A2A2AFF2A2A2AFF2A2A2AFF2A2A2AFF2A2A2AFF161616CD000000440000
      003700000027000000180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100000
      001D0000002C0000003B050000589A0401F9A40401FFA40401FFA40401FFA404
      01FFA40401FFA40401FFA40401FFA40401FFA40401FF5E0201CD000000440000
      003700000027000000180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100000
      001D0000002C0000003B00020058003700F9003B00FF003B00FF003B00FF003B
      00FF003B00FF003B00FF003B00FF003B00FF003B00FF002100CD000000440000
      003700000027000000180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B000000180000002A0000
      003D0F0F0FB22A2A2AFF2A2A2AFF2A2A2AFF656565FF666666FF696969FF6B6B
      6BFF6C6C6CFF6B6B6BFF686868FF666666FF5D5D5DFF323232FF2A2A2AFF2A2A
      2AFF0000005B0000003700000024000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B000000180000002A0000
      003D3F0200B2A40401FFA40401FFA40401FFBF5D09FFBD6209FFBF660AFFC068
      0AFFC0690AFFBF670AFFBE640AFFBC6009FFBC4E0FFFA70D0AFFA40401FFA404
      01FF0600005B0000003700000024000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B000000180000002A0000
      003D001600B2003B00FF003B00FF003B00FF028800FF028A00FF028E00FF0290
      00FF029000FF028E00FF028C00FF028800FF017B00FF004500FF003B00FF003B
      00FF0001005B0000003700000024000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0000001F000000350202026D2A2A
      2AFF2A2A2AFF585858FF606060FF656565FF686868FF6C6C6CFF717171FF7373
      73FF737373FF717171FF707070FF6B6B6BFF686868FF666666FF636363FF4040
      40FF2A2A2AFF2A2A2AFF000000430000002D000000190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0000001F000000350E00006DA404
      01FFA40401FFBA4A07FFBA5609FFBC5D0AFFBF630BFFC26A0BFFC4700BFFC573
      0BFFC5730BFFC4720BFFC36D0BFFC0660AFFBF620EFFBD5E11FFBC5913FFAF22
      11FFA40502FFA40401FF000000430000002D000000190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0000001F000000350004006D003B
      00FF003B00FF017700FF018000FF028600FF028C00FF029200FF029800FF029A
      00FF029A00FF029800FF029400FF028E00FF028C00FF028A00FF028600FF0159
      00FF003D00FF003B00FF000000430000002D000000190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010000000230000003C242424F72A2A2AFF4949
      49FF585858FF606060FF656565FF6C6C6CFF747474FF7B7B7BFF818181FF8484
      84FF848484FF848484FF7E7E7EFF767676FF707070FF6C6C6CFF666666FF6161
      61FF606060FF383838FF2A2A2AFF06060688000000340000001C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010000000230000003C970401F7A40401FFB434
      06FFB74C08FFBB550BFFBE5E0CFFC2690EFFC7740EFFCB7D0DFFCE860DFFD08A
      0EFFD08B0EFFCF890EFFCD820DFFC9780CFFC56E0BFFC1670FFFBE5E11FFBC57
      13FFB95316FFAA1613FFA40401FF1D010088000000340000001C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010000000230000003C003700F7003B00FF0165
      00FF017700FF018000FF028800FF029200FF029C00FF02A400FF02AA00FF03AE
      00FF03AE00FF03AE00FF02A800FF02A000FF029600FF029000FF028A00FF0284
      00FF018000FF004F00FF003B00FF000A0088000000340000001C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000040000000F000000240000003F2A2A2AFF2A2A2AFF505050FF5656
      56FF606060FF696969FF737373FF7E7E7EFF898989FF8F8F8FFF979797FF9A9A
      9AFF9A9A9AFF999999FF949494FF8C8C8CFF828282FF797979FF707070FF6666
      66FF606060FF5D5D5DFF595959FF2A2A2AFF181818D5000000360000001C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000040000000F000000240000003FA40401FFA40401FFB34007FFB748
      0AFFBB540EFFC26111FFC87014FFCF8114FFD58F14FFDA9A11FFDEA311FFDFA9
      12FFE1A912FFDFA611FFDC9F11FFD8940FFFD2860EFFCC780FFFC76A10FFC05D
      11FFBC5312FFBA4E16FFBB4618FFA40502FF680301D5000000360000001C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000040000000F000000240000003F003B00FF003B00FF016D00FF0175
      00FF018000FF028E00FF029A00FF02A800FF03B400FF03BE00FF03C600FF03CA
      00FF03CC00FF03C800FF03C200FF03B800FF03AC00FF02A000FF029600FF028A
      00FF028200FF017D00FF017700FF003D00FF002500D5000000360000001C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00030000000C000000210000003D2A2A2AFF2A2A2AFF4D4D4DFF555555FF6060
      60FF6C6C6CFF797979FF878787FF8F8F8FFF999999FF9D9D9DFFA4A4A4FFA5A5
      A5FFA7A7A7FFA5A5A5FFA0A0A0FF9A9A9AFF929292FF878787FF7C7C7CFF7070
      70FF666666FF5E5E5EFF585858FF585858FF2B2B2BFF151515C9000000330000
      0019000000080000000100000000000000000000000000000000000000000000
      00030000000C000000210000003DA40401FFA40401FFB23A07FFB7450CFFBC53
      12FFC46418FFCC761CFFD5881DFFDB971AFFE1A416FFE5AD13FFE8B514FFEAB9
      14FFEABA14FFEAB814FFE6B213FFE3A813FFDE9C11FFD88C0FFFD07C11FFC96B
      11FFC25B11FFBC4F13FFB84815FFB74519FFA50603FF590201C9000000330000
      0019000000080000000100000000000000000000000000000000000000000000
      00030000000C000000210000003D003B00FF003B00FF016900FF017300FF0282
      00FF029200FF02A200FF03B200FF03BE00FF03C800FF03D000FF03D600FF04DA
      00FF04DA00FF04DA00FF03D400FF03CC00FF03C000FF03B200FF02A600FF0296
      00FF028800FF017D00FF017700FF017500FF003D00FF002000C9000000330000
      0019000000080000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00080000001B000000372A2A2AFF2A2A2AFF494949FF515151FF5E5E5EFF6C6C
      6CFF7B7B7BFF898989FF929292FF999999FF9D9D9DFFA0A0A0FFA5A5A5FFA7A7
      A7FFA7A7A7FFA7A7A7FFA4A4A4FF9F9F9FFF979797FF8F8F8FFF848484FF7B7B
      7BFF6E6E6EFF636363FF5B5B5BFF555555FF535353FF2A2A2AFF060606860000
      002D000000130000000500000000000000000000000000000000000000010000
      00080000001B00000037A40401FFA40401FFB03407FFB53F0DFFBC4F16FFC663
      1EFFCF7622FFD88923FFDF9720FFE3A21BFFE7AA15FFE9B113FFECB814FFECBA
      15FFEDBA15FFECB914FFEBB513FFE8AD12FFE4A311FFE09710FFDA870EFFD378
      11FFCA6711FFC35712FFBB4A13FFB64216FFB63F19FFA40502FF1C0100860000
      002D000000130000000500000000000000000000000000000000000000010000
      00080000001B00000037003B00FF003B00FF016300FF016F00FF018000FF0292
      00FF02A400FF03B400FF03C000FF03C800FF03CE00FF03D400FF04DA00FF04DC
      00FF04DC00FF04DA00FF04D800FF03D000FF03C800FF03BE00FF03B000FF02A4
      00FF029400FF028600FF017900FF017300FF017100FF003D00FF000900860000
      002D000000130000000500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040000
      00130000002E0E0E0EAF2A2A2AFF454545FF4D4D4DFF5B5B5BFF696969FF7979
      79FF858585FF8D8D8DFF929292FF979797FF999999FF9C9C9CFF9F9F9FFFA0A0
      A0FFA0A0A0FF9F9F9FFF9D9D9DFF9A9A9AFF959595FF8F8F8FFF878787FF7C7C
      7CFF737373FF696969FF5E5E5EFF565656FF515151FF4D4D4DFF2A2A2AFF0000
      0043000000240000000D00000002000000000000000000000000000000040000
      00130000002E3E0200AFA40401FFAD2D06FFB3380CFFBB4915FFC65D20FFCF72
      26FFD88327FFDE8F23FFE2971EFFE49F18FFE6A313FFE8A912FFE9AD13FFEAAF
      13FFEAB013FFE9AE13FFE8AB12FFE7A612FFE49E11FFE19510FFDE8A0EFFD87C
      0DFFD16D0FFFC95E11FFC04F12FFB94413FFB53D16FFB53518FFA40401FF0000
      0043000000240000000D00000002000000000000000000000000000000040000
      00130000002E001500AF003B00FF015D00FF016900FF017900FF028E00FF02A2
      00FF03B200FF03BC00FF03C200FF03C600FF03C800FF03CE00FF03D200FF03D2
      00FF03D400FF03D200FF03D000FF03CC00FF03C400FF03BC00FF03B400FF02A8
      00FF029A00FF028E00FF018000FF017500FF016F00FF016900FF003B00FF0000
      0043000000240000000D00000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000010000000B0000
      0022000000412A2A2AFF3E3E3EFF464646FF535353FF636363FF717171FF7C7C
      7CFF858585FF898989FF8C8C8CFF8D8D8DFF919191FF949494FF959595FF9797
      97FF979797FF979797FF959595FF929292FF8D8D8DFF898989FF828282FF7B7B
      7BFF737373FF686868FF616161FF565656FF505050FF4E4E4EFF393939FF2A2A
      2AFF0000003700000019000000060000000000000000000000010000000B0000
      002200000041A40401FFAD2304FFB02F0AFFB83F13FFC3521DFFCD6624FFD575
      26FFDA8124FFDE881DFFDF8D17FFE29212FFE29710FFE49C11FFE5A011FFE6A2
      11FFE6A211FFE5A111FFE49E11FFE39910FFE1930FFFDF8C0FFFDB830EFFD978
      0CFFD46C0AFFCC5D0BFFC65110FFBD4310FFB63A12FFB33817FFAB1815FFA404
      01FF0000003700000019000000060000000000000000000000010000000B0000
      002200000041003B00FF015500FF016100FF017100FF028600FF029800FF02A6
      00FF03B000FF03B400FF03B800FF03BC00FF03BE00FF03C200FF03C600FF03C8
      00FF03C800FF03C600FF03C400FF03C000FF03BA00FF03B600FF03AE00FF02A4
      00FF029A00FF028C00FF028400FF017500FF016D00FF016B00FF005100FF003B
      00FF000000370000001900000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000004000000150000
      0032292929FB2A2A2AFF404040FF494949FF585858FF666666FF717171FF7979
      79FF7B7B7BFF7E7E7EFF818181FF848484FF878787FF8C8C8CFF8D8D8DFF8F8F
      8FFF8F8F8FFF8D8D8DFF8C8C8CFF898989FF858585FF818181FF7B7B7BFF7474
      74FF6E6E6EFF666666FF5D5D5DFF585858FF505050FF404040FF3D3D3DFF2A2A
      2AFF01010160000000270000000D000000020000000000000004000000150000
      00329D0502FBA40502FFAC2707FFB3330EFFBD4417FFC8561FFFD06522FFD571
      22FFD7751CFFDA7B16FFDC8011FFDD850EFFDF8A0EFFE08F0FFFE1920FFFE294
      10FFE29410FFE1930FFFE0900FFFDF8C0FFFDD870EFFDB800DFFD9770CFFD66F
      0BFFD3650AFFCE5908FFC74C06FFC2450EFFBA3A10FFAE2603FFAA2104FFA404
      01FF07000060000000270000000D000000020000000000000004000000150000
      0032003900FB003D00FF015900FF016500FF017700FF028A00FF029800FF02A2
      00FF02A600FF02AA00FF03AC00FF03B000FF03B400FF03B800FF03BA00FF03BC
      00FF03BC00FF03BA00FF03B800FF03B600FF03B000FF02AA00FF02A400FF029E
      00FF029400FF028A00FF017D00FF017700FF016D00FF015700FF005300FF003B
      00FF00020060000000270000000D000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000009000000200000
      00422B2B2BFF404040FF454545FF4D4D4DFF595959FF656565FF737373FF7373
      73FF717171FF737373FF767676FF7B7B7BFF7E7E7EFF828282FF848484FF8585
      85FF858585FF848484FF828282FF818181FF7B7B7BFF787878FF737373FF6E6E
      6EFF686868FF616161FF5B5B5BFF515151FF484848FF3E3E3EFF3B3B3BFF3232
      32FF2A2A2AFF0000003700000017000000050000000100000009000000200000
      0042A50704FFAB240AFFB02A0CFFB73511FFC14417FFCA521BFFD16627FFD468
      1EFFD46712FFD66B0EFFD7710BFFD9770CFFDB7C0DFFDC820DFFDD850EFFDD86
      0EFFDD860EFFDD850EFFDC830DFFDB7E0DFFD9790CFFD8730CFFD56C0BFFD364
      0AFFD05C09FFCC5207FFC84806FFC13B04FFB92F03FFB02402FFAB2003FFA80F
      08FFA40401FF0000003700000017000000050000000100000009000000200000
      0042003F00FF015700FF015D00FF016900FF017900FF028800FF029A00FF029C
      00FF029800FF029A00FF029E00FF02A400FF02A800FF03AC00FF03B000FF03B0
      00FF03B000FF03B000FF03AE00FF02AA00FF02A600FF02A000FF029A00FF0294
      00FF028C00FF028400FF017B00FF016F00FF016300FF015700FF005300FF0047
      00FF003B00FF0000003700000017000000050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000002000000100000002C1B1B
      1BD2333333FF414141FF454545FF4E4E4EFF555555FF5B5B5BFF616161FF6363
      63FF666666FF696969FF6E6E6EFF717171FF747474FF787878FF797979FF7B7B
      7BFF7B7B7BFF797979FF787878FF767676FF737373FF707070FF6B6B6BFF6666
      66FF616161FF5B5B5BFF555555FF505050FF464646FF3E3E3EFF454545FF4646
      46FF2A2A2AFF00000044000000210000000A00000002000000100000002C6506
      04D2A80F0CFFAD270FFFB22A0EFFBB3411FFC23E13FFC84712FFCB4F12FFCD53
      0DFFD0590AFFD15E09FFD3640AFFD56A0AFFD66F0BFFD8730CFFD9760CFFD977
      0CFFD9770CFFD9760CFFD8740CFFD7710BFFD56C0BFFD4670AFFD26009FFCF59
      08FFCD5107FFCA4906FFC64005FFC33704FFBB2D02FFB32301FFB12A11FFAE2B
      16FFA40401FF00000044000000210000000A00000002000000100000002C0028
      00D2004700FF015B00FF015F00FF016900FF017300FF017D00FF028400FF0286
      00FF028C00FF028E00FF029400FF029800FF029E00FF02A000FF02A400FF02A4
      00FF02A400FF02A400FF02A200FF029E00FF029A00FF029600FF029000FF028A
      00FF028400FF017B00FF017300FF016B00FF016100FF015700FF015F00FF015F
      00FF003B00FF00000044000000210000000A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000500000017000000383030
      30FF3E3E3EFF454545FF464646FF4B4B4BFF505050FF535353FF555555FF5959
      59FF5E5E5EFF616161FF666666FF696969FF6C6C6CFF707070FF707070FF7171
      71FF717171FF717171FF707070FF6C6C6CFF6B6B6BFF686868FF636363FF6060
      60FF595959FF555555FF505050FF4B4B4BFF434343FF3D3D3DFF3E3E3EFF4343
      43FF363636FF161616CB0000002C0000000F000000050000001700000038A70C
      09FFAD2011FFB02812FFB42A10FFBC2F10FFC0360EFFC53B0BFFC73F07FFC945
      06FFCB4C07FFCD5207FFCF5808FFD15E09FFD26209FFD3660AFFD4680AFFD569
      0AFFD56A0AFFD4690AFFD4670AFFD3630AFFD15F09FFD05A08FFCE5408FFCC4E
      07FFC94706FFC74005FFC43804FFC13003FFBB2702FFB41F00FFB02108FFAD27
      13FFAA1411FF5B0201CB0000002C0000000F0000000500000017000000380043
      00FF015700FF015D00FF015F00FF016500FF016D00FF017100FF017300FF0179
      00FF018000FF028400FF028A00FF028E00FF029200FF029600FF029800FF0298
      00FF029800FF029800FF029600FF029400FF029000FF028C00FF028600FF0282
      00FF017900FF017300FF016D00FF016500FF015D00FF015500FF015500FF015B
      00FF004D00FF002000CB0000002C0000000F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000080000001E000000413535
      35FF464646FF454545FF454545FF484848FF484848FF4B4B4BFF4D4D4DFF5151
      51FF565656FF595959FF5E5E5EFF616161FF656565FF666666FF686868FF6868
      68FF686868FF686868FF666666FF656565FF636363FF606060FF5B5B5BFF5858
      58FF535353FF4E4E4EFF4B4B4BFF464646FF404040FF3B3B3BFF363636FF4040
      40FF3D3D3DFF2A2A2AFF0000003500000015000000080000001E00000041A911
      0EFFAE2B19FFB12815FFB62811FFBC2A0EFFBF2C09FFC13006FFC33404FFC53B
      04FFC74105FFC94706FFCB4C07FFCD5107FFCE5508FFCF5808FFD05B08FFD05C
      09FFD05C09FFD05B09FFCF5908FFCF5608FFCD5307FFCC4E07FFCA4906FFC843
      05FFC63D05FFC43604FFC13003FFBF2902FFBA2201FFB51B01FFAE1600FFAD22
      10FFAB1C12FFA40401FF0000003500000015000000080000001E000000410049
      00FF015F00FF015F00FF015F00FF016100FF016300FF016700FF016900FF016F
      00FF017500FF017900FF018000FF028400FF028800FF028A00FF028C00FF028C
      00FF028C00FF028C00FF028A00FF028800FF028600FF028200FF017B00FF0177
      00FF017100FF016B00FF016500FF015F00FF015900FF005100FF004B00FF0157
      00FF005300FF003B00FF00000035000000150000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000B00000024030303653E3E
      3EFF494949FF454545FF464646FF464646FF464646FF484848FF484848FF4B4B
      4BFF505050FF535353FF565656FF595959FF5B5B5BFF5E5E5EFF606060FF6060
      60FF606060FF606060FF5E5E5EFF5B5B5BFF595959FF565656FF555555FF5151
      51FF4D4D4DFF484848FF454545FF414141FF3D3D3DFF383838FF353535FF3939
      39FF616161FF555555FF0000003C0000001A0000000B000000240A010065AD1C
      19FFAF2E1FFFB22818FFB72815FFBC2710FFBC280BFFC02B08FFC02B02FFC231
      03FFC43704FFC63C05FFC74105FFC94506FFCA4906FFCB4C07FFCC4E07FFCC4F
      07FFCC4F07FFCC4E07FFCB4C07FFCA4A06FFC94606FFC84205FFC63E05FFC539
      04FFC33303FFC02D03FFBE2802FFBC2201FFB91C01FFB41700FFAE1300FFAA1B
      0CFFB64C3FFFB73937FF0000003C0000001A0000000B00000024000400650155
      00FF016300FF015F00FF016100FF016100FF015F00FF016300FF016100FF0167
      00FF016D00FF017100FF017500FF017900FF017B00FF018000FF028200FF0282
      00FF028200FF028200FF018000FF017D00FF017900FF017500FF017300FF016F
      00FF016900FF016300FF015F00FF015900FF015500FF004F00FF004900FF0051
      00FF028400FF017300FF0000003C0000001A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000D00000029161616BA4545
      45FF4D4D4DFF484848FF484848FF464646FF454545FF454545FF414141FF4545
      45FF484848FF4B4B4BFF4E4E4EFF515151FF535353FF555555FF565656FF5656
      56FF565656FF565656FF555555FF555555FF515151FF505050FF4D4D4DFF4949
      49FF464646FF434343FF404040FF3D3D3DFF383838FF353535FF303030FF5E5E
      5EFF686868FF555555FF000000420000001E0000000D000000294A0706BAB025
      22FFAC3325FFB22A1DFFB82919FFBB2715FFBD250EFFBE2509FFBD2301FFBF28
      02FFC02D03FFC23203FFC43604FFC53A04FFC63D05FFC73F05FFC74105FFC842
      05FFC84205FFC84205FFC74005FFC63E05FFC53B04FFC43704FFC33303FFC12F
      03FFBF2A02FFBD2502FFBB2001FFB91B00FFB71600FFB31200FFAC0D00FFB848
      3BFFB75448FFB73937FF000000420000001E0000000D00000029001F00BA015F
      00FF016700FF016100FF016300FF016100FF015F00FF015D00FF015B00FF015F
      00FF016300FF016700FF016B00FF016F00FF017100FF017300FF017500FF0175
      00FF017500FF017500FF017300FF017300FF016F00FF016D00FF016900FF0165
      00FF016100FF015D00FF015700FF005300FF004F00FF004B00FF004500FF0180
      00FF028C00FF017300FF000000420000001E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000F0000002C2A2A2AE94949
      49FF5B5B5BFF4B4B4BFF464646FF484848FF454545FF414141FF3E3E3EFF4040
      40FF434343FF454545FF484848FF494949FF4B4B4BFF4D4D4DFF4E4E4EFF4E4E
      4EFF4E4E4EFF4E4E4EFF4D4D4DFF4D4D4DFF4B4B4BFF484848FF464646FF4343
      43FF404040FF3E3E3EFF393939FF383838FF353535FF303030FF464646FF6060
      60FF6B6B6BFF585858FF00000045000000210000000F0000002C88100EE9B22A
      27FFB14539FFAE2F23FFB4281DFFBB2718FFBB2311FFBB210BFFBA1D02FFBB20
      01FFBD2402FFBF2802FFC02C03FFC12F03FFC23203FFC33404FFC33504FFC436
      04FFC43604FFC43604FFC33404FFC23303FFC13003FFC02D03FFBF2902FFBE26
      02FFBC2101FFBA1D01FFB81900FFB71500FFB51100FFAE0C00FFAF291DFFB54A
      40FFB7594DFFB83B39FF00000045000000210000000F0000002C003C00E90163
      00FF017B00FF016500FF016100FF016100FF015D00FF015B00FF015500FF0157
      00FF015B00FF015F00FF016300FF016500FF016700FF016900FF016B00FF016B
      00FF016B00FF016B00FF016900FF016900FF016500FF016300FF015F00FF015D
      00FF015900FF015500FF005100FF004F00FF004B00FF004500FF015F00FF0282
      00FF029000FF017500FF00000045000000210000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000100000002E393939FF4D4D
      4DFF7C7C7CFF565656FF555555FF505050FF4B4B4BFF484848FF434343FF4545
      45FF484848FF494949FF4B4B4BFF4D4D4DFF505050FF505050FF515151FF5151
      51FF515151FF515151FF505050FF505050FF4E4E4EFF4D4D4DFF494949FF4848
      48FF464646FF434343FF414141FF3E3E3EFF3B3B3BFF393939FF505050FF6868
      68FF737373FF585858FF0000004600000022000000100000002EAB1714FFB32F
      2DFFBE6D61FFAF3F34FFB43B31FFB8332AFFBB2B22FFBC2917FFBB220EFFBC26
      0EFFBE290FFFBF2B0FFFC02F0FFFC13110FFC23410FFC33510FFC43710FFC437
      10FFC43811FFC43710FFC33610FFC33410FFC23210FFC12F0FFFC02C0FFFBE2A
      0FFFBD270EFFBB230EFFBA200DFFB81C0DFFB1190DFFA91A0DFFAE372CFFB554
      49FFB96156FFB83B39FF0000004600000022000000100000002E004F00FF0169
      00FF02A400FF017500FF017300FF016D00FF016700FF016300FF015B00FF015F
      00FF016300FF016300FF016700FF016900FF016B00FF016D00FF016F00FF016F
      00FF016F00FF016F00FF016D00FF016D00FF016B00FF016700FF016500FF0163
      00FF016100FF015D00FF015900FF015700FF005100FF004F00FF016D00FF028A
      00FF029800FF017500FF00000046000000220000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000100000002D323232F65353
      53FF848484FF5D5D5DFF595959FF555555FF4E4E4EFF414141FF434343FF4343
      43FF454545FF464646FF484848FF494949FF4B4B4BFF4D4D4DFF4D4D4DFF4D4D
      4DFF4D4D4DFF4D4D4DFF4D4D4DFF4B4B4BFF494949FF484848FF484848FF4545
      45FF434343FF414141FF3D3D3DFF3D3D3DFF3B3B3BFF414141FF515151FF6666
      66FF737373FF565656FF0000004600000022000000100000002D9D1815F6B636
      33FFC0756BFFAF483EFFB04238FFB33B31FFB53228FFB42115FFBA2213FFBA22
      10FFBC2411FFBD2711FFBE2911FFBF2B12FFC02D12FFC02F12FFC03012FFC030
      12FFC03012FFC03012FFC02F12FFC02E12FFBF2C12FFBE2A11FFBD2811FFBC25
      11FFBB2310FFB92010FFB51B10FFAF1B10FFA81B10FFA6251BFFAA392FFFB254
      4AFFB86258FFB73A38FF0000004600000022000000100000002D004800F60171
      00FF03AE00FF017D00FF017700FF017300FF016B00FF015B00FF015D00FF015B
      00FF015F00FF016100FF016300FF016500FF016700FF016900FF016900FF0169
      00FF016900FF016900FF016900FF016700FF016500FF016300FF016100FF015F
      00FF015D00FF015B00FF015500FF005300FF005100FF015900FF016D00FF028A
      00FF029A00FF017500FF00000046000000220000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000E0000002A232323D05656
      56FF8C8C8CFF616161FF5E5E5EFF595959FF494949FF434343FF484848FF4141
      41FF414141FF454545FF454545FF464646FF484848FF484848FF484848FF4949
      49FF494949FF484848FF484848FF484848FF464646FF464646FF454545FF4343
      43FF3E3E3EFF3E3E3EFF3D3D3DFF3B3B3BFF393939FF4B4B4BFF515151FF6666
      66FF737373FF555555FF000000440000001F0000000E0000002A66100ED0B73A
      38FFC37E76FFAE4E44FFAE4A40FFAF433AFFAA2F25FFAC251AFFB3291FFFB520
      15FFB92012FFBB2312FFBC2512FFBD2613FFBD2813FFBD2913FFBD2A13FFBE2A
      13FFBE2A13FFBD2A13FFBD2913FFBD2813FFBD2713FFBC2513FFBB2412FFBA22
      12FFB61D12FFB01D12FFAB1D12FFA51D12FFA01D12FFA5342AFFA43B31FFAF55
      4BFFB76358FFB73937FF000000440000001F0000000E0000002A003000D00175
      00FF03B800FF028400FF018000FF017900FF016300FF015B00FF016100FF0159
      00FF015B00FF015D00FF015F00FF016100FF016100FF016300FF016300FF0163
      00FF016300FF016300FF016300FF016100FF016100FF015F00FF015F00FF015D
      00FF015700FF015500FF005300FF005100FF004F00FF016700FF016D00FF028A
      00FF029A00FF017300FF000000440000001F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000C000000260A0A0A895959
      59FF949494FF686868FF656565FF606060FF4E4E4EFF535353FF4B4B4BFF4848
      48FF404040FF404040FF414141FF414141FF454545FF464646FF464646FF4646
      46FF464646FF464646FF464646FF454545FF434343FF414141FF414141FF4040
      40FF3E3E3EFF3E3E3EFF3D3D3DFF3B3B3BFF393939FF4B4B4BFF515151FF6868
      68FF6B6B6BFF555555FF0000003F0000001C0000000C0000002620040489B93E
      3CFFC78880FFAD574DFFAD524AFFAD4C44FFA7372DFFAC3A30FFAB3026FFAE2B
      20FFAE2015FFB22015FFB62015FFB82115FFBA2415FFBB2515FFBB2615FFBB26
      15FFBB2615FFBB2615FFBB2515FFBA2415FFB92215FFB72015FFB42015FFAF20
      15FFAC2015FFA72015FFA32015FF9E2015FF992015FFA0352BFFA13D33FFAE57
      4DFFB2594EFFB73937FF0000003F0000001C0000000C00000026000E00890179
      00FF03C200FF028C00FF028600FF028200FF016B00FF016F00FF016500FF0161
      00FF015700FF015900FF015B00FF015B00FF015F00FF015F00FF016100FF0161
      00FF016100FF016100FF015F00FF015F00FF015D00FF015B00FF015900FF0157
      00FF015700FF015500FF005300FF005100FF004F00FF016700FF016D00FF028C
      00FF028E00FF017300FF0000003F0000001C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000900000020000000445353
      53FF949494FF717171FF6E6E6EFF6B6B6BFF666666FF5D5D5DFF535353FF4D4D
      4DFF494949FF414141FF414141FF434343FF434343FF434343FF454545FF4545
      45FF454545FF454545FF434343FF434343FF434343FF434343FF414141FF4141
      41FF404040FF3E3E3EFF3E3E3EFF3D3D3DFF3D3D3DFF505050FF555555FF6C6C
      6CFF656565FF555555FF0000003800000017000000090000002000000044B735
      33FFC78981FFB3625AFFAF5F56FFAF5B52FFAE534AFFAC483FFFAA3C32FFAA34
      2AFFAB2F25FFAA2419FFAD2419FFAF2419FFB12419FFB32419FFB52419FFB524
      19FFB52419FFB52419FFB42419FFB22419FFB02419FFAE2419FFAB2419FFA724
      19FFA42419FFA02419FF9C2419FF992419FF952419FF9E3B31FFA24037FFB25D
      52FFB25148FFB73937FF0000003800000017000000090000002000000044016F
      00FF03C200FF029800FF029400FF029000FF028800FF017D00FF017100FF0169
      00FF016500FF015900FF015B00FF015B00FF015D00FF015D00FF015D00FF015D
      00FF015D00FF015D00FF015D00FF015D00FF015B00FF015B00FF015900FF0159
      00FF015700FF015700FF015500FF005300FF005300FF016B00FF017100FF0292
      00FF028800FF017300FF00000038000000170000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000005000000190000003C4848
      48FF818181FF7E7E7EFF7B7B7BFF717171FF747474FF6B6B6BFF606060FF5656
      56FF505050FF464646FF434343FF434343FF454545FF454545FF454545FF4646
      46FF464646FF454545FF454545FF454545FF454545FF434343FF434343FF4343
      43FF414141FF414141FF404040FF404040FF3E3E3EFF535353FF595959FF6666
      66FF535353FF505050FA0000002F0000001100000005000000190000003CB129
      27FFBD7168FFBB7167FFB66E65FFB1615AFFB2655DFFAE5A52FFAB4D44FFA740
      37FFA63A30FFA42D23FFA5291EFFA6291EFFA8291EFFAA291EFFAB291EFFAC29
      1EFFAC291EFFAB291EFFAA291EFFA9291EFFA7291EFFA6291EFFA3291EFFA029
      1EFF9D291EFF9A291EFF97291EFF94291EFF93291EFF9F4035FFA4463BFFAE55
      49FFB73634FFAD3634FA0000002F0000001100000005000000190000003C0163
      00FF02A800FF02A800FF02A400FF029600FF029A00FF028E00FF028200FF0173
      00FF016D00FF016100FF015D00FF015D00FF015D00FF015F00FF015F00FF015F
      00FF015F00FF015F00FF015F00FF015D00FF015D00FF015D00FF015B00FF015B
      00FF015900FF015900FF015700FF015700FF015700FF016F00FF017700FF028A
      00FF017100FF016D00FA0000002F000000110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000300000012000000303F3F
      3FFA707070FF999999FF878787FF7C7C7CFF7E7E7EFF787878FF707070FF6363
      63FF595959FF555555FF494949FF464646FF464646FF464646FF464646FF4848
      48FF484848FF464646FF464646FF464646FF464646FF464646FF464646FF4545
      45FF454545FF454545FF454545FF454545FF454545FF585858FF5E5E5EFF6E6E
      6EFF555555FF01010157000000250000000B000000030000001200000030A825
      23FAC35957FFC98F88FFBE7A73FFB87068FFB7716AFFB56962FFB06058FFA950
      48FFA5463DFFA53F36FFA13229FFA02E24FFA12E24FFA22E24FFA32E24FFA42E
      24FFA42E24FFA32E24FFA32E24FFA12E24FFA02E24FF9F2E24FF9E2E24FF9C2E
      24FF992E24FF972E24FF962E24FF962E24FF962E24FFA1453AFFA74C42FFB35D
      52FFB73836FF05010157000000250000000B0000000300000012000000300159
      00FA029600FF03CC00FF03B200FF02A600FF02A800FF02A000FF029400FF0284
      00FF017700FF017100FF016300FF015F00FF015F00FF016100FF016100FF0161
      00FF016100FF016100FF016100FF015F00FF015F00FF015F00FF015F00FF015F
      00FF015D00FF015D00FF015D00FF015D00FF015D00FF017500FF017D00FF0292
      00FF017300FF00020057000000250000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000010000000B000000240101
      014B696969FFA5A5A5FF949494FF949494FF929292FF898989FF7E7E7EFF7171
      71FF686868FF5E5E5EFF585858FF535353FF4B4B4BFF4B4B4BFF4B4B4BFF4B4B
      4BFF4B4B4BFF4B4B4BFF4B4B4BFF4B4B4BFF4B4B4BFF494949FF494949FF4949
      49FF494949FF494949FF494949FF494949FF494949FF5D5D5DFF686868FF6666
      66FF505050FF0000003B0000001A00000006000000010000000B000000240101
      014BBF504EFFD19B94FFC48981FFC58982FFC38781FFBD7C75FFB7726AFFB163
      5BFFAB574EFFA64C43FFA4453BFFA13E35FF9E352AFF9E352AFF9F352AFFA035
      2AFFA0352AFF9F352AFF9F352AFF9E352AFF9D352AFF9B352AFF9A352AFF9A35
      2AFF9A352AFF9A352AFF9A352AFF9A352AFF9A352AFFA64B40FFAE564CFFB452
      4AFFB53230FF0000003B0000001A00000006000000010000000B000000240001
      004B028C00FF04E000FF03C200FF03C200FF03C000FF03B400FF02A800FF0298
      00FF028A00FF017D00FF017700FF016F00FF016500FF016500FF016500FF0165
      00FF016500FF016500FF016500FF016500FF016500FF016500FF016300FF0163
      00FF016300FF016300FF016300FF016300FF016300FF017D00FF028A00FF028A
      00FF016D00FF0000003B0000001A000000060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000006000000180101
      013B535353FF8C8C8CFFA4A4A4FFA8A8A8FFB0B0B0FFAAAAAAFF959595FF8585
      85FF787878FF6C6C6CFF636363FF5D5D5DFF5B5B5BFF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF595959FF636363FF717171FF5656
      56FF262626C40000002C00000010000000030000000000000006000000180101
      013BB73634FFCC7975FFCE9A93FFCF9D97FFD0A29EFFCF9D99FFC58B85FFBB77
      70FFB46961FFAF5C55FFA85149FFA54B42FFA34840FF9D3B32FF9D3B31FF9D3B
      31FF9D3B31FF9D3B31FF9D3B31FF9D3B31FF9D3B31FF9D3B31FF9D3B31FF9D3B
      31FF9D3B31FF9D3B31FF9D3B31FF9D3B31FFA3463CFFAB5147FFB4625AFFB73A
      38FF5B1817C40000002C00000010000000030000000000000006000000180001
      003B017100FF03B800FF04DE00FF04E400FF04EE00FF04E600FF03C600FF03AE
      00FF029E00FF029200FF028400FF017D00FF017900FF016B00FF016B00FF016B
      00FF016B00FF016B00FF016B00FF016B00FF016B00FF016B00FF016B00FF016B
      00FF016B00FF016B00FF016B00FF016B00FF017700FF028400FF029800FF0175
      00FF013400C40000002C00000010000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000020000000E0000
      002B0505055D767676FFB8B8B8FFB8B8B8FFFEFEFEFFCFCFCFFFBFBFBFFF9A9A
      9AFF878787FF7B7B7BFF717171FF686868FF636363FF5E5E5EFF5E5E5EFF5959
      59FF535353FF535353FF535353FF535353FF535353FF535353FF535353FF5353
      53FF535353FF535353FF535353FF555555FF636363FF6E6E6EFF656565FF4949
      49FF0000003D0000001D000000080000000100000000000000020000000E0000
      002B0805045DC55F5EFFD7A9A4FFD5A9A4FFFFFFFFFFDCBAB6FFD6ADA9FFC791
      8BFFBC7A74FFB76E67FFB06259FFAB584FFFA95149FFA64D44FFA64C44FFA347
      3EFFA04037FFA04037FFA04037FFA04037FFA04037FFA04037FFA04037FFA040
      37FFA04037FFA04037FFA04037FFA14037FFA95148FFB15E54FFB64F4AFFB22B
      29FF0000003D0000001D000000080000000100000000000000020000000E0001
      002B0007005D029E00FF04F800FF04FA00FF4CFF48FF1BFF16FF05FF00FF03D0
      00FF03B200FF02A400FF029600FF028C00FF028400FF018000FF017D00FF0177
      00FF017100FF017100FF017100FF017100FF017100FF017100FF017100FF0171
      00FF017100FF017100FF017100FF017100FF028400FF029200FF028800FF0165
      00FF0000003D0000001D00000008000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000060000
      00190202023C595959FD9A9A9AFFDFDFDFFFFEFEFEFFFEFEFEFFDADADAFFB8B8
      B8FF979797FF8C8C8CFF828282FF767676FF6E6E6EFF696969FF686868FF6666
      66FF656565FF636363FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF5B5B5BFF6C6C6CFF7C7C7CFF555555FF0707
      07770000002A0000001000000003000000000000000000000000000000060000
      00190202023CB63E3DFDD58C8AFFE2C4C0FFFFFFFFFFFFFFFFFFDFC0BCFFD3A8
      A3FFC68E88FFBF8078FFBA756EFFB36861FFAF5F57FFAD5951FFAB564EFFAA55
      4DFFA9534BFFA85148FFA3473EFFA3473EFFA3473EFFA3473EFFA3473EFFA347
      3EFFA3473EFFA3473EFFA4473EFFA54940FFB05C52FFBA6E64FFB73735FF1404
      04770000002A0000001000000003000000000000000000000000000000060000
      00190003003C017700FD03CC00FF29FF24FF4CFF48FF4CFF48FF27FF22FF04F8
      00FF03CC00FF03B800FF03AC00FF029E00FF029400FF028E00FF028A00FF0288
      00FF028600FF028400FF017700FF017700FF017700FF017700FF017700FF0177
      00FF017700FF017700FF017900FF017B00FF029000FF02A400FF017100FF000A
      00770000002A0000001000000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      000D000000260404044A6C6C6CFFB5B5B5FFE7E7E7FFFEFEFEFFFEFEFEFFC5C5
      C5FFAAAAAAFF979797FF929292FF898989FF7E7E7EFF767676FF737373FF7070
      70FF6C6C6CFF6B6B6BFF606060FF606060FF606060FF606060FF606060FF6060
      60FF606060FF606060FF606060FF6E6E6EFF7C7C7CFF585858FF3D3D3DF80000
      0035000000180000000700000001000000000000000000000000000000020000
      000D000000260404044AC15553FFDDA7A5FFE7CFCBFFFFFFFFFFFFFFFFFFD9B2
      AFFFCF9E99FFC78C87FFC38782FFBD7B74FFB87069FFB46861FFB1635CFFB060
      58FFAE5D54FFAD5A52FFA64E46FFA64E45FFA64E45FFA64E45FFA64E45FFA64E
      45FFA64E45FFA74E45FFA74E45FFB15D54FFBA6D64FFB83B39FFA3211FF80000
      0035000000180000000700000001000000000000000000000000000000020000
      000D000100260006004A029200FF04F400FF2EFF2AFF4CFF48FF4CFF48FF0FFF
      0AFF04E600FF03C800FF03C000FF03B200FF02A600FF029E00FF029800FF0294
      00FF029200FF028E00FF018000FF018000FF018000FF018000FF018000FF0180
      00FF018000FF018000FF018000FF029200FF02A400FF017500FF015300F80000
      0035000000180000000700000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0005000000130202023009090957797979FFC2C2C2FFDDDDDDFFF1F1F1FFB8B8
      B8FFB4B4B4FFA2A2A2FF9D9D9DFF959595FF8D8D8DFF898989FF828282FF7E7E
      7EFF7B7B7BFF747474FF686868FF666666FF666666FF666666FF666666FF6666
      66FF666666FF666666FF6C6C6CFF818181FF585858FF3E3E3EFF0000003C0000
      001F0000000B0000000200000000000000000000000000000000000000000000
      0005000000130101013008080857C76361FFE1B0AFFFE1C3BEFFF2E3E1FFD4A9
      A4FFD1A5A0FFCB9793FFC9948EFFC48B85FFC1827CFFBC7B74FFBA756EFFB871
      6AFFB66D65FFB4665FFFAB574FFFAA554CFFAA554CFFAA554CFFAA554CFFAA55
      4CFFAB554CFFAB554DFFAF5C52FFBB7168FFB83C3AFFAD1D1BFF0000003C0000
      001F0000000B0000000200000000000000000000000000000000000000000000
      00050000001300020030000D005702A200FF09FF04FF29FF24FF3AFF36FF04FA
      00FF04F400FF04DC00FF03D600FF03C600FF03BA00FF03B200FF03AC00FF02A8
      00FF02A400FF029C00FF028A00FF028800FF028800FF028800FF028800FF0288
      00FF028800FF028800FF029000FF02A800FF017700FF015700FF0000003C0000
      001F0000000B0000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00010000000700000018020202350C0C0C65767676FFB0B0B0FFD2D2D2FFC4C4
      C4FFB8B8B8FFACACACFFA8A8A8FF9F9F9FFF999999FF949494FF919191FF8D8D
      8DFF878787FF828282FF707070FF6C6C6CFF6B6B6BFF6B6B6BFF6B6B6BFF6C6C
      6CFF6C6C6CFF737373FF848484FF595959FF393939FF0000003E000000230000
      000E000000030000000000000000000000000000000000000000000000000000
      00010000000700000018020202350E0B0B65C6605DFFDDA4A1FFDEBCB7FFD8B1
      ADFFD4A8A4FFD09F9AFFCD9C97FFCA9691FFC69089FFC48983FFC2857EFFC081
      7AFFBE7A74FFBA746DFFB05F58FFAD5C54FFAD5B53FFAD5B53FFAD5B53FFAD5C
      53FFAE5D54FFB3645BFFBD766EFFB93D3BFFAB1815FF0000003E000000230000
      000E000000030000000000000000000000000000000000000000000000000000
      000100000007000000180003003500100065029E00FF04EE00FF1FFF1AFF0DFF
      08FF04F800FF04E800FF04E400FF04DA00FF03CE00FF03C200FF03BE00FF03B8
      00FF03B200FF03AC00FF029400FF029000FF029000FF029000FF029000FF0290
      00FF029200FF029A00FF03AE00FF017700FF005100FF0000003E000000230000
      000E000000030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000002000000090000001A0202023507070753666666FFA0A0A0FFCACA
      CAFFC2C2C2FFB4B4B4FFB2B2B2FFA8A8A8FFA4A4A4FF9D9D9DFF9A9A9AFF9797
      97FF929292FF8A8A8AFF767676FF737373FF717171FF717171FF717171FF7676
      76FF7E7E7EFF7B7B7BFF585858FF363636FF0000003D00000024000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      000000000002000000090000001A0202023506060653BF4C4BFFD89392FFDCB6
      B3FFD8B0AAFFD2A5A0FFD1A39FFFCE9C97FFCB9893FFC9948FFFC7918BFFC68E
      87FFC48882FFBF7D78FFB46860FFB1645CFFB1625AFFB1625AFFB1635BFFB567
      5FFFBA7168FFBC6B64FFB93C3AFFA91310FF0000003D00000024000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      000000000002000000090000001A00030035000A0053028A00FF03D400FF15FF
      10FF09FF04FF04F200FF04F000FF04E400FF04DC00FF03D600FF03D000FF03CA
      00FF03C000FF03B600FF029E00FF029800FF029800FF029800FF029800FF029E
      00FF02A800FF02A400FF017700FF004B00FF0000003D00000024000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008000000180101012F03030348595959FF8787
      87FFA5A5A5FFC8C8C8FFBABABAFFA2A2A2FFA2A2A2FFAAAAAAFFA5A5A5FFA2A2
      A2FF9A9A9AFF949494FF7C7C7CFF797979FF797979FF7E7E7EFF858585FF8D8D
      8DFF595959FF383838FF101010AD00000037000000210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008000000180101012F03030348B93E3CFFCC72
      6FFFD89A98FFDCB5B1FFD5AAA5FFCC9892FFCB9891FFCE9D99FFCD9A95FFCB97
      92FFC9918CFFC48983FFB87068FFB66B64FFB66C63FFB97068FFBD7770FFC281
      77FFB93E3CFFAA1512FF3C0404AD00000037000000210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008000000180002002F00050048017900FF03B0
      00FF04DE00FF13FF0EFF04FC00FF04DC00FF04DC00FF04E600FF04E000FF04DA
      00FF03D000FF03C200FF02A600FF02A200FF02A200FF02A600FF03AE00FF03B8
      00FF017900FF004D00FF001700AD00000037000000210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001200000025010101390404
      045D585858FF898989FF9C9C9CFFC4C4C4FFC4C4C4FFB2B2B2FFA7A7A7FFA0A0
      A0FF9C9C9CFF959595FF8F8F8FFF8F8F8FFF919191FF7C7C7CFF5E5E5EFF3939
      39FF292929FB000000410000002E0000001B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001200000025010101390804
      035DB83B3AFFCD7573FFD68D8CFFD9B1ADFFD9B1ACFFD2A49FFFCE9B96FFCC97
      92FFCA938EFFC68C85FFC2837CFFC2837AFFC4857DFFBF6C65FFBB4441FFAB18
      15FF9D0502FB000000410000002E0000001B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001200010025000200390006
      005D017500FF03B400FF03CC00FF0DFF08FF0DFF08FF04F000FF04E200FF04DA
      00FF03D400FF03C600FF03BC00FF03BC00FF03BE00FF02A600FF018000FF0051
      00FF003900FB000000410000002E0000001B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C000000180000
      0029000000390000004C4E4E4EFF535353FF818181FF979797FF979797FF9595
      95FF919191FF878787FF6C6C6CFF666666FF454545FF2A2A2AFF161616CD0000
      0041000000320000002200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C000000180000
      0029000000390200004CB4302EFFB63634FFC96B6AFFD38887FFD38786FFD285
      84FFD07E7DFFCD7372FFC25552FFBF4D4AFFB02523FFA40401FF5E0201CD0000
      0041000000320000002200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C000000180000
      0029000000390001004C016B00FF017100FF02AA00FF03C800FF03C600FF03C4
      00FF03BE00FF03B200FF029200FF028A00FF015F00FF003B00FF002100CD0000
      0041000000320000002200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0000001800000024000000300000003B000000430808087A292929D43030
      30E0434343FF282828DE131313B60000005B00000041000000370000002C0000
      0020000000150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0000001800000024000000300000003B000000431604047A6E1816D47F1C
      1AE0AF2220FF791310DE460504B60600005B00000041000000370000002C0000
      0020000000150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0000001800000024000000300000003B00000043000B007A003900D40145
      00E0015B00FF003900DE001C00B60001005B00000041000000370000002C0000
      0020000000150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120000001900000020000000250000002A0000
      002C0000002D0000002C00000029000000240000001D00000017000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120000001900000020000000250000002A0000
      002C0000002D0000002C00000029000000240000001D00000017000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120000001900000020000000250000002A0000
      002C0000002D0000002C00000029000000240000001D00000017000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000A0000000280000000100010000000000200300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object imglSemaforoOff: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 40
    Width = 40
    Left = 568
    Top = 570
    Bitmap = {
      494C010103000500040028002800FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000A00000002800000001002000000000000064
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011000000160000001B0101011F0101
      012101010122010101210101011E0000001A000000150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011010101160101011B0202021F0202
      022102020222020202210202021E0101011A010101150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000003000000060000000B00000011010101160101011B0202021F0202
      022102020222020202210202021E0101011A010101150000000F0000000A0000
      0005000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100000001A010101250202022F030303370404043E050505430505
      05460505054605050545050505420404043C030303340202022B010101210000
      00170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100101011A030303250505052F070707370808083E0A0A0A430B0B
      0B460B0B0B460B0B0B450A0A0A420808083C060606340404042B020202210101
      01170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000030000
      0008000000100101011A030303250505052F070707370808083E0A0A0A430B0B
      0B460B0B0B460B0B0B450A0A0A420808083C060606340404042B020202210101
      01170000000D0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100101
      011D0202022C0404043B0C0C0C58A8A8A8F9B1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FF6F6F6FCD050505440303
      033701010127000000180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100101
      011D0404042C0808083B14111158CF9291F9DA9A99FFDA9A99FFDA9A99FFDA9A
      99FFDA9A99FFDA9A99FFDA9A99FFDA9A99FFDA9A99FF886362CD0A0A0A440707
      073703030327010101180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000200000007000000100101
      011D0404042C0808083B11121158919990F999A298FF99A298FF99A298FF99A2
      98FF99A298FF99A298FF99A298FF99A298FF99A298FF626761CD0A0A0A440707
      073703030327010101180000000D000000050000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B000000180202022A0404
      043D4D4D4DB2B1B1B1FFB1B1B1FFB1B1B1FFCACACAFFCACACAFFCBCBCBFFCCCC
      CCFFCBCBCBFFCACACAFFCBCBCBFFC9C9C9FFC5C5C5FFB1B1B1FFB1B1B1FFB1B1
      B1FF0D0D0D5B0303033701010124000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B010101180404042A0808
      083D644A4AB2DA9A99FFDA9A99FFDA9A99FFE5BE9CFFE4C09CFFE5C19DFFE5C2
      9DFFE5C39DFFE5C29DFFE4C19DFFE4BF9CFFE4B89FFFDB9E9DFFDA9A99FFDA9A
      99FF1513135B0707073702020224000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B010101180404042A0808
      083D4A4C49B299A298FF99A298FF99A298FF99EC98FF99ED98FF99F098FF99F1
      98FF99F198FF99F098FF99EE98FF99EC98FF99E298FF99A998FF99A298FF99A2
      98FF1313135B0707073702020224000000130000000800000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0101011F030303351616166DB1B1
      B1FFB1B1B1FFC3C3C3FFC6C6C6FFC9C9C9FFCCCCCCFFCDCDCDFFCCCCCCFFCBCB
      CBFFCBCBCBFFCACACAFFCCCCCCFFCDCDCDFFCBCBCBFFC8C8C8FFC6C6C6FFB1B1
      B1FFB1B1B1FFB1B1B1FF050505430202022D000000190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0202021F06060635211B1B6DDA9A
      99FFDA9A99FFE3B69CFFE3BB9CFFE4BE9DFFE5C09DFFE6C39DFFE7C59DFFE7C7
      9DFFE7C79DFFE7C69DFFE6C49DFFE5C19DFFE5C09EFFE4BEA0FFE4BCA0FFDEA6
      A0FFDA9B9AFFDA9A99FF0A0A0A430404042D010101190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000040000000E0202021F060606351B1C1B6D99A2
      98FF99A298FF99DF98FF99E598FF99EA98FF99EE98FF99F298FF99F698FF99F7
      98FF99F798FF99F698FF99F498FF99F098FF99EE98FF99ED98FF99EA98FF99BD
      98FF99A398FF99A298FF0A0A0A430404042D010101190000000A000000030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010010101230404043CA4A4A4F7B1B1B1FFB8B8
      B8FFC2C2C2FFC6C6C6FFC9C9C9FFCFCFCFFFCECECEFFCCCCCCFFCACACAFFCACA
      CAFFCACACAFFC9C9C9FFCBCBCBFFCCCCCCFFCDCDCDFFCDCDCDFFC9C9C9FFC5C5
      C5FFC2C2C2FFB1B1B1FFB1B1B1FF28282888030303340000001C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010020202230808083CCB908FF7DA9A99FFE0AD
      9BFFE2B79CFFE3BB9DFFE4BE9EFFE6C39EFFE8C79EFFEACB9EFFEBCE9EFFECCF
      9EFFECD09EFFEBCF9EFFEACC9EFFE9C99EFFE7C59DFFE6C29FFFE4BEA0FFE4BB
      A0FFE2BAA2FFDCA2A0FFDA9A99FF362B2B88060606340101011C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000010020202230808083C8F978EF799A298FF99CB
      98FF99DF98FF99E598FF99EC98FF99F298FF99F898FF99FC98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FE98FF99FA98FF99F598FF99F198FF99ED98FF99E8
      98FF99E598FF99B298FF99A298FF2B2C2B88060606340101011C0000000B0000
      0003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000040000000F010101240404043FB1B1B1FFB1B1B1FFBDBDBDFFC1C1
      C1FFC5C5C5FFCDCDCDFFD2D2D2FFD2D2D2FFD0D0D0FFCDCDCDFFCCCCCCFFC9C9
      C9FFCCCCCCFFCACACAFFCCCCCCFFCDCDCDFFCFCFCFFFD1D1D1FFD2D2D2FFCACA
      CAFFC5C5C5FFC2C2C2FFC0C0C0FFB1B1B1FF797979D5030303360000001C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000040000000F020202240909093FDA9A99FFDA9A99FFE0B29CFFE2B5
      9DFFE3BA9EFFE6BFA0FFE8C5A1FFEBCCA1FFEED1A1FFF0D6A0FFF1DAA0FFF2DC
      A0FFF2DCA0FFF2DBA0FFF0D8A0FFEFD49FFFECCE9EFFEAC99FFFE8C39FFFE5BE
      A0FFE4BAA0FFE3B8A2FFE3B5A2FFDA9B9AFF946C6BD5060606360101011C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000040000000F020202240909093F99A298FF99A298FF99D498FF99DD
      98FF99E598FF99F098FF99F798FF99FE98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FA98FF99F598FF99ED
      98FF99E798FF99E498FF99DF98FF99A398FF6B6F69D5060606360101011C0000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00030000000C010101210404043DB1B1B1FFB1B1B1FFBBBBBBFFC0C0C0FFC5C5
      C5FFCDCDCDFFD5D5D5FFDADADAFFD5D5D5FFD0D0D0FFCCCCCCFFCCCCCCFFCBCB
      CBFFCBCBCBFFCBCBCBFFCBCBCBFFCDCDCDFFCECECEFFCFCFCFFFD3D3D3FFD2D2
      D2FFCACACAFFC4C4C4FFC0C0C0FFBDBDBDFFB1B1B1FF6A6A6AC9020202330000
      0019000000080000000100000000000000000000000000000000000000000000
      00030000000C020202210808083DDA9A99FFDA9A99FFE0B09CFFE2B49EFFE4BA
      A0FFE7C1A2FFEAC8A4FFEECFA4FFF0D5A3FFF2DAA2FFF4DEA0FFF5E1A1FFF6E2
      A1FFF6E3A1FFF6E2A1FFF4E0A0FFF3DCA0FFF1D7A0FFEFD09FFFECCAA0FFE9C3
      A0FFE6BDA0FFE4B8A0FFE2B5A1FFE2B4A3FFDA9B9AFF835F5FC9050505330101
      0119000000080000000100000000000000000000000000000000000000000000
      00030000000C020202210808083D99A298FF99A298FF99CF98FF99DB98FF99E7
      98FF99F298FF99FB98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FD98FF99F5
      98FF99EC98FF99E498FF99DF98FF99DD98FF99A398FF5F625EC9050505330101
      0119000000080000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00080000001B03030337B1B1B1FFB1B1B1FFB8B8B8FFBDBDBDFFC3C3C3FFCDCD
      CDFFD5D5D5FFDEDEDEFFDADADAFFD5D5D5FFCFCFCFFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCDCDCDFFCDCDCDFFCFCFCFFFD1D1D1FFD5D5
      D5FFCFCFCFFFC8C8C8FFC2C2C2FFBCBCBCFFBCBCBCFFB1B1B1FF272727860202
      022D000000130000000500000000000000000000000000000000000000010000
      00080101011B07070737DA9A99FFDA9A99FFDFAD9CFFE1B29EFFE4B8A2FFE8C0
      A5FFEBC8A6FFEFCFA7FFF2D5A5FFF3D9A4FFF5DCA1FFF6DFA0FFF7E2A1FFF7E3
      A1FFF7E3A1FFF7E2A1FFF6E1A0FFF5DEA0FFF4DAA0FFF2D59FFFF0CE9EFFEDC9
      A0FFE9C2A0FFE6BBA0FFE3B6A0FFE1B3A2FFE1B2A3FFDA9B9AFF342A29860404
      042D000000130000000500000000000000000000000000000000000000010000
      00080101011B0707073799A298FF99A298FF99C898FF99D698FF99E598FF99F2
      98FF99FC98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FC
      98FF99F498FF99EA98FF99E198FF99DB98FF99D898FF99A398FF292A29860404
      042D000000130000000500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040000
      00130202022E4C4C4CAFB1B1B1FFB5B5B5FFBABABAFFC1C1C1FFC9C9C9FFD2D2
      D2FFDADADAFFDEDEDEFFDADADAFFD4D4D4FFCFCFCFFFCDCDCDFFCDCDCDFFCDCD
      CDFFCDCDCDFFCDCDCDFFCDCDCDFFCECECEFFCFCFCFFFD0D0D0FFD1D1D1FFD2D2
      D2FFD2D2D2FFCBCBCBFFC4C4C4FFBFBFBFFFBBBBBBFFB7B7B7FFB1B1B1FF0505
      0543010101240000000D00000002000000000000000000000000000000040000
      00130404042E614847AFDA9A99FFDEAB9BFFE0AF9EFFE3B6A1FFE8BEA5FFEBC6
      A8FFEFCDA8FFF1D1A7FFF3D5A5FFF4D8A2FFF4DAA0FFF5DCA0FFF6DEA0FFF6DE
      A0FFF6DFA0FFF6DEA0FFF5DDA0FFF5DBA0FFF4D8A0FFF2D49FFFF1CF9EFFEFCA
      9EFFECC49FFFE9BEA0FFE5B8A0FFE2B4A0FFE1B1A2FFE1AEA2FFDA9A99FF0A0A
      0A43020202240000000D00000002000000000000000000000000000000040000
      00130404042E474947AF99A298FF99C298FF99CF98FF99E198FF99F098FF99FB
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FE
      98FF99F798FF99F098FF99E598FF99DD98FF99D698FF99CF98FF99A298FF0A0A
      0A43020202240000000D00000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000010000000B0101
      012204040441B1B1B1FFB1B1B1FFB6B6B6FFBCBCBCFFC4C4C4FFCDCDCDFFD4D4
      D4FFD9D9D9FFDCDCDCFFD6D6D6FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCECE
      CEFFCECECEFFCECECEFFCFCFCFFFCFCFCFFFD0D0D0FFD2D2D2FFD2D2D2FFD3D3
      D3FFD2D2D2FFCACACAFFC5C5C5FFBEBEBEFFBABABAFFB8B8B8FFB1B1B1FFB1B1
      B1FF0303033700000019000000060000000000000000000000010000000B0202
      022209090941DA9A99FFDEA79AFFDFAB9DFFE2B2A0FFE6B9A4FFEAC1A7FFEEC7
      A8FFF0CCA7FFF1CFA4FFF2D1A2FFF3D3A0FFF3D59FFFF4D7A0FFF4D8A0FFF4D9
      A0FFF4D9A0FFF4D9A0FFF4D8A0FFF3D69FFFF2D39FFFF2D09FFFF0CD9EFFEFC9
      9EFFEDC49DFFEABE9DFFE8B99FFFE4B39FFFE1B0A0FFE0AFA2FFDDA2A1FFDA9A
      99FF0707073701010119000000060000000000000000000000010000000B0202
      02220909094199A298FF99B898FF99C698FF99D898FF99EA98FF99F698FF99FD
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FC
      98FF99F798FF99EE98FF99E898FF99DD98FF99D498FF99D298FF99B498FF99A2
      98FF070707370101011900000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000004000000150202
      0232AAAAAAFBB1B1B1FFB2B2B2FFB7B7B7FFBEBEBEFFC5C5C5FFCCCCCCFFD2D2
      D2FFD5D5D5FFD8D8D8FFD6D6D6FFD2D2D2FFD1D1D1FFD1D1D1FFD0D0D0FFD1D1
      D1FFD1D1D1FFD0D0D0FFD0D0D0FFD2D2D2FFD2D2D2FFD2D2D2FFD3D3D3FFD3D3
      D3FFCECECEFFC9C9C9FFC3C3C3FFBFBFBFFFBABABAFFB2B2B2FFB1B1B1FFB1B1
      B1FF0F0F0F60010101270000000D000000020000000000000004010101150505
      0532D29696FBDA9B9AFFDDA89CFFE0AD9EFFE4B4A2FFE8BBA5FFECC1A6FFEEC6
      A6FFEEC7A4FFF0CAA2FFF0CBA0FFF1CD9EFFF2CF9EFFF2D19FFFF2D39FFFF3D4
      9FFFF3D49FFFF2D39FFFF2D29FFFF2D09FFFF1CE9EFFF0CB9EFFEFC89EFFEEC5
      9DFFEDC19DFFEBBC9CFFE8B79BFFE6B49EFFE3B09FFFDEA89AFFDCA69AFFDA9A
      99FF18151560030303270000000D000000020000000000000004010101150505
      0532959B94FB99A398FF99BD98FF99CB98FF99DF98FF99ED98FF99F698FF99FB
      98FF99FD98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FC98FF99F9
      98FF99F498FF99ED98FF99E498FF99DF98FF99D498FF99BB98FF99B698FF99A2
      98FF15151560030303270000000D000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000009010101200505
      0542B1B1B1FFB1B1B1FFB3B3B3FFB8B8B8FFBDBDBDFFC4C4C4FFCCCCCCFFCDCD
      CDFFCECECEFFD1D1D1FFD4D4D4FFD3D3D3FFD3D3D3FFD2D2D2FFD2D2D2FFD2D2
      D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD3D3D3FFD4D4D4FFD2D2D2FFCDCD
      CDFFC9C9C9FFC5C5C5FFC1C1C1FFBBBBBBFFB5B5B5FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FF0303033700000017000000050000000100000009020202200A0A
      0A42DA9C9AFFDDA79DFFDFA99EFFE2AEA0FFE6B4A2FFE9B9A4FFECC1A8FFEDC2
      A5FFEDC2A0FFEEC39EFFEEC69DFFEFC89EFFF0CA9EFFF0CC9EFFF1CD9EFFF1CE
      9EFFF1CE9EFFF1CD9EFFF0CD9EFFF0CB9EFFEFC99EFFEFC79EFFEEC49DFFEDC1
      9DFFECBD9CFFEAB99CFFE8B59BFFE6B09AFFE2AB9AFFDFA79AFFDDA59AFFDC9F
      9CFFDA9A99FF0707073701010117000000050000000100000009020202200A0A
      0A4299A498FF99BB98FF99C298FF99CF98FF99E198FF99EC98FF99F798FF99F8
      98FF99F698FF99F798FF99F998FF99FC98FF99FE98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FD98FF99FA98FF99F798FF99F4
      98FF99EE98FF99E898FF99E298FF99D698FF99C898FF99BB98FF99B698FF99AA
      98FF99A298FF0707073701010117000000050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000002000000100202022C7575
      75D2B1B1B1FFB1B1B1FFB3B3B3FFB7B7B7FFBBBBBBFFBFBFBFFFC3C3C3FFC5C5
      C5FFC8C8C8FFCBCBCBFFCDCDCDFFD1D1D1FFD3D3D3FFD4D4D4FFD4D4D4FFD3D3
      D3FFD3D3D3FFD4D4D4FFD4D4D4FFD4D4D4FFD2D2D2FFCFCFCFFFCCCCCCFFC9C9
      C9FFC5C5C5FFC1C1C1FFBCBCBCFFB8B8B8FFB4B4B4FFB1B1B1FFB3B3B3FFB3B3
      B3FFB1B1B1FF05050544010101210000000A00000002000000100404042C9069
      69D2DC9F9EFFDEA89FFFE0A99EFFE3ADA0FFE6B1A0FFE8B5A0FFEAB8A0FFEABA
      9EFFECBC9DFFECBE9CFFEDC19DFFEEC39DFFEEC59DFFEFC79EFFEFC89EFFEFC8
      9EFFEFC89EFFEFC89EFFEFC79EFFEEC69DFFEEC49DFFEDC29DFFECBF9CFFEBBC
      9CFFEAB99CFFE9B69BFFE8B29BFFE6AF9AFFE3AB9AFFE0A799FFDFA9A0FFDEAA
      A2FFDA9A99FF0A0A0A44020202210000000A00000002000000100404042C676D
      66D299AA98FF99BF98FF99C498FF99CF98FF99DB98FF99E498FF99E898FF99EA
      98FF99EE98FF99F098FF99F498FF99F698FF99F998FF99FA98FF99FC98FF99FC
      98FF99FC98FF99FC98FF99FB98FF99F998FF99F798FF99F598FF99F198FF99ED
      98FF99E898FF99E298FF99DB98FF99D298FF99C698FF99BB98FF99C498FF99C4
      98FF99A298FF0A0A0A44020202210000000A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000050000001703030338B1B1
      B1FFB1B1B1FFB1B1B1FFB2B2B2FFB4B4B4FFB7B7B7FFB9B9B9FFBCBCBCFFBFBF
      BFFFC2C2C2FFC5C5C5FFC8C8C8FFCBCBCBFFCDCDCDFFCECECEFFCFCFCFFFD0D0
      D0FFD1D1D1FFD0D0D0FFCFCFCFFFCDCDCDFFCBCBCBFFC9C9C9FFC6C6C6FFC3C3
      C3FFC0C0C0FFBCBCBCFFB8B8B8FFB5B5B5FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FF6C6C6CCB0202022C0000000F000000050101011707070738DB9E
      9CFFDEA5A0FFDFA9A0FFE0A99FFFE4AB9FFFE5AE9EFFE7B09DFFE8B29CFFE9B4
      9BFFEAB79CFFEAB99CFFEBBC9CFFECBE9CFFECC09CFFEDC19DFFEDC29DFFEEC3
      9DFFEEC39DFFEDC39DFFEDC29DFFEDC09DFFECBF9CFFECBD9CFFEBBA9CFFEAB8
      9CFFE9B59BFFE8B29BFFE7AF9AFFE6AC9AFFE3A89AFFE0A599FFDFA69CFFDEA8
      A0FFDCA1A0FF856160CB0404042C0000000F00000005010101170707073899A7
      98FF99BB98FF99C298FF99C498FF99CB98FF99D498FF99D898FF99DB98FF99E1
      98FF99E598FF99E898FF99ED98FF99F098FF99F298FF99F598FF99F698FF99F6
      98FF99F698FF99F698FF99F598FF99F498FF99F198FF99EE98FF99EA98FF99E7
      98FF99E198FF99DB98FF99D498FF99CB98FF99C298FF99B898FF99B898FF99BF
      98FF99B098FF60645FCB0404042C0000000F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000080101011E04040441B1B1
      B1FFB2B2B2FFB1B1B1FFB1B1B1FFB2B2B2FFB3B3B3FFB4B4B4FFB7B7B7FFBABA
      BAFFBDBDBDFFC0C0C0FFC2C2C2FFC5C5C5FFC6C6C6FFC8C8C8FFC9C9C9FFC9C9
      C9FFC9C9C9FFC9C9C9FFC9C9C9FFC7C7C7FFC5C5C5FFC3C3C3FFC1C1C1FFBEBE
      BEFFBBBBBBFFB8B8B8FFB5B5B5FFB2B2B2FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FF0303033500000015000000080202021E09090941DCA0
      9EFFDEAAA3FFDFA9A1FFE1A9A0FFE4A99EFFE5AA9CFFE6AC9BFFE6AD9AFFE7B0
      9AFFE8B39BFFE9B59BFFEAB79CFFEAB99CFFEBBB9CFFEBBC9CFFECBD9CFFECBD
      9CFFECBD9CFFECBD9CFFEBBC9CFFEBBB9CFFEABA9CFFEAB89CFFE9B69BFFE8B3
      9BFFE8B19BFFE7AE9AFFE6AC9AFFE5A99AFFE3A699FFE1A499FFDEA298FFDEA6
      9FFFDDA4A0FFDA9A99FF0606063501010115000000080202021E0909094199AC
      98FF99C498FF99C498FF99C498FF99C698FF99C898FF99CD98FF99CF98FF99D6
      98FF99DD98FF99E198FF99E598FF99E898FF99EC98FF99ED98FF99EE98FF99EE
      98FF99EE98FF99EE98FF99ED98FF99EC98FF99EA98FF99E798FF99E298FF99DF
      98FF99D898FF99D298FF99CB98FF99C498FF99BD98FF99B498FF99AE98FF99BB
      98FF99B698FF99A298FF06060635010101150000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000B0101012412121265B1B1
      B1FFB2B2B2FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB2B2B2FFB3B3B3FFB5B5
      B5FFB8B8B8FFBBBBBBFFBDBDBDFFBFBFBFFFC1C1C1FFC2C2C2FFC3C3C3FFC4C4
      C4FFC4C4C4FFC3C3C3FFC2C2C2FFC1C1C1FFBFBFBFFFBDBDBDFFBCBCBCFFB9B9
      B9FFB6B6B6FFB4B4B4FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB8B8B8FFB6B6B6FF0404043C0000001A0000000B020202241C181865DEA4
      A3FFDEABA5FFE0A9A2FFE2A9A1FFE4A89FFFE4A99DFFE5AA9CFFE5AA9AFFE6AC
      9AFFE7AF9AFFE8B19BFFE8B39BFFE9B49BFFE9B69BFFEAB79CFFEAB89CFFEAB8
      9CFFEAB89CFFEAB89CFFEAB79CFFE9B69BFFE9B59BFFE8B39BFFE8B19BFFE7AF
      9AFFE6AD9AFFE5AB9AFFE4A99AFFE4A699FFE2A499FFE0A299FFDEA098FFDCA4
      9EFFE1B7B2FFE2AFAFFF0808083C0101011A0000000B020202241718176599B8
      98FF99C898FF99C498FF99C698FF99C698FF99C498FF99C898FF99C698FF99CD
      98FF99D498FF99D898FF99DD98FF99E198FF99E298FF99E598FF99E798FF99E7
      98FF99E798FF99E798FF99E598FF99E498FF99E198FF99DD98FF99DB98FF99D6
      98FF99CF98FF99C898FF99C498FF99BD98FF99B898FF99B298FF99AC98FF99B4
      98FF99E898FF99DB98FF0808083C0101011A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000D01010129565656BAB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB4B4B4FFB6B6B6FFB8B8B8FFB9B9B9FFBBBBBBFFBCBCBCFFBDBDBDFFBDBD
      BDFFBDBDBDFFBDBDBDFFBCBCBCFFBCBCBCFFBABABAFFB8B8B8FFB6B6B6FFB4B4
      B4FFB2B2B2FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB9B9
      B9FFB8B8B8FFB6B6B6FF050505420101011E0000000D030303296F5353BADFA7
      A6FFDDADA7FFE0A9A4FFE2A9A3FFE3A8A1FFE4A79EFFE4A79CFFE4A799FFE5A9
      9AFFE5AB9AFFE6AD9AFFE7AE9AFFE7B09AFFE8B19BFFE8B29BFFE8B39BFFE8B3
      9BFFE8B39BFFE8B39BFFE8B29BFFE8B19BFFE7B09AFFE7AF9AFFE6AD9AFFE6AB
      9AFFE5A99AFFE4A79AFFE3A599FFE2A499FFE2A299FFE0A098FFDD9E98FFE2B5
      B0FFE2BAB5FFE2AFAFFF0A0A0A420202021E0000000D03030329515550BA99C4
      98FF99CD98FF99C698FF99C898FF99C698FF99C498FF99C298FF99BF98FF99C4
      98FF99C898FF99CD98FF99D298FF99D698FF99D898FF99DB98FF99DD98FF99DD
      98FF99DD98FF99DD98FF99DB98FF99DB98FF99D698FF99D498FF99CF98FF99CB
      98FF99C698FF99C298FF99BB98FF99B698FF99B298FF99AE98FF99A998FF99E5
      98FF99EE98FF99DB98FF0A0A0A420202021E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000F0202022C939393E9B1B1
      B1FFB4B4B4FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB3B3B3FFB4B4B4FFB6B6B6FFB7B7B7FFB7B7B7FFB8B8
      B8FFB8B8B8FFB8B8B8FFB7B7B7FFB6B6B6FFB5B5B5FFB4B4B4FFB2B2B2FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB7B7
      B7FFB9B9B9FFB6B6B6FF05050545010101210000000F0404042CB68584E9E0A9
      A8FFDFB4AFFFDEABA7FFE0A9A4FFE3A8A2FFE3A7A0FFE3A69DFFE3A49AFFE3A5
      99FFE4A79AFFE5A99AFFE5AA9AFFE6AB9AFFE6AD9AFFE6AD9AFFE6AE9AFFE7AE
      9AFFE7AE9AFFE7AE9AFFE6AD9AFFE6AD9AFFE6AC9AFFE5AB9AFFE5A99AFFE4A8
      9AFFE4A699FFE3A499FFE2A399FFE2A199FFE1A098FFDE9E98FFDEA9A4FFE1B6
      B2FFE2BCB7FFE2B0AFFF0B0B0B45020202210000000F0404042C808D7FE999C8
      98FF99E298FF99CB98FF99C698FF99C698FF99C298FF99BF98FF99B898FF99BB
      98FF99BF98FF99C498FF99C898FF99CB98FF99CD98FF99CF98FF99D298FF99D2
      98FF99D298FF99D298FF99CF98FF99CF98FF99CB98FF99C898FF99C498FF99C2
      98FF99BD98FF99B898FF99B498FF99B298FF99AE98FF99A998FF99C498FF99E7
      98FF99F198FF99DD98FF0B0B0B45020202210000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000100202022EB1B1B1FFB3B3
      B3FFC0C0C0FFB3B3B3FFB5B5B5FFB4B4B4FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB2B2B2FFB4B4B4FFB4B4B4FFB6B6B6FFB6B6B6FFB7B7B7FFB7B7
      B7FFB8B8B8FFB7B7B7FFB7B7B7FFB6B6B6FFB4B4B4FFB4B4B4FFB2B2B2FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB8B8
      B8FFBBBBBBFFB6B6B6FF0505054601010122000000100404042EDDA2A1FFE0AB
      ABFFE4C4BFFFDEB2ADFFE0B0ACFFE2ADA9FFE3AAA6FFE4A9A2FFE3A69EFFE4A8
      9EFFE4A99FFFE5AA9FFFE5AB9FFFE6AC9FFFE6AD9FFFE6AE9FFFE7AF9FFFE7AF
      9FFFE7AFA0FFE7AF9FFFE6AE9FFFE6AD9FFFE6AD9FFFE6AB9FFFE5AA9FFFE4A9
      9FFFE4A89EFFE3A79EFFE3A59EFFE2A49EFFDFA39EFFDCA39EFFDEAFAAFFE1BA
      B6FFE2BFBBFFE2B0AFFF0B0B0B4602020222000000100404042E99B298FF99CF
      98FF99FC98FF99DD98FF99DB98FF99D498FF99CD98FF99C898FF99BF98FF99C4
      98FF99C898FF99C898FF99CD98FF99CF98FF99D298FF99D498FF99D698FF99D6
      98FF99D698FF99D698FF99D498FF99D498FF99D298FF99CD98FF99CB98FF99C8
      98FF99C698FF99C298FF99BD98FF99BB98FF99B498FF99B298FF99D498FF99ED
      98FF99F698FF99DD98FF0B0B0B46020202220000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000100202022DA5A5A5F6B5B5
      B5FFC9C9C9FFB4B4B4FFB3B3B3FFB4B4B4FFB4B4B4FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB2B2B2FFB4B4B4FFB4B4B4FFB4B4
      B4FFB4B4B4FFB4B4B4FFB4B4B4FFB3B3B3FFB2B2B2FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFADADADFFB0B0B0FFB5B5
      B5FFBABABAFFB6B6B6FF0505054601010122000000100404042DCC9695F6E1AE
      ADFFE5C7C3FFDEB5B1FFDFB3AFFFE0B0ACFFE1ADA9FFE0A6A1FFE3A6A0FFE3A6
      9FFFE4A7A0FFE4A8A0FFE4A9A0FFE5AAA0FFE5ABA0FFE5ABA0FFE5ACA0FFE5AC
      A0FFE5ACA0FFE5ACA0FFE5ABA0FFE5ABA0FFE5AAA0FFE4A9A0FFE4A9A0FFE4A7
      A0FFE3A79FFFE2A59FFFE1A49FFFDEA49FFFDCA49FFFDBA7A4FFDCAFABFFE0BA
      B6FFE2C0BCFFE2B0AFFF0B0B0B4602020222000000100404042D8FA18EF699D8
      98FF99FF98FF99E498FF99DF98FF99DB98FF99D298FF99BF98FF99C298FF99BF
      98FF99C498FF99C698FF99C898FF99CB98FF99CD98FF99CF98FF99CF98FF99CF
      98FF99CF98FF99CF98FF99CF98FF99CD98FF99CB98FF99C898FF99C698FF99C4
      98FF99C298FF99BF98FF99B898FF99B698FF99B498FF99BD98FF99D498FF99ED
      98FF99F798FF99DD98FF0B0B0B46020202220000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000E0202022A707070D0B6B6
      B6FFD2D2D2FFB4B4B4FFB3B3B3FFB3B3B3FFAFAFAFFFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB0B0B0FFACACACFFACACACFFACACACFFB4B4
      B4FFB9B9B9FFB6B6B6FF050505440101011F0000000E0404042A8F6C6BD0E2B0
      AFFFE6CBC8FFDEB8B4FFDEB6B2FFDEB3B0FFDCABA7FFDDA7A3FFE0A9A5FFE1A5
      A1FFE2A5A0FFE3A7A0FFE4A7A0FFE4A8A0FFE4A9A0FFE4A9A0FFE4A9A0FFE4A9
      A0FFE4A9A0FFE4A9A0FFE4A9A0FFE4A9A0FFE4A8A0FFE4A7A0FFE3A7A0FFE3A6
      A0FFE1A4A0FFDFA4A0FFDDA4A0FFDAA4A0FFD8A4A0FFDAADA9FFDAB0ACFFDEBB
      B7FFE2C0BCFFE2AFAFFF0A0A0A440202021F0000000E0404042A657164D099DD
      98FF99FF98FF99E898FF99E598FF99E198FF99C898FF99BF98FF99C698FF99BD
      98FF99BF98FF99C298FF99C498FF99C698FF99C698FF99C898FF99C898FF99C8
      98FF99C898FF99C898FF99C898FF99C698FF99C698FF99C498FF99C498FF99C2
      98FF99BB98FF99B898FF99B698FF99B498FF99B298FF99CD98FF99D498FF99ED
      98FF99F798FF99DB98FF0A0A0A440202021F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000C0101012629292989B7B7
      B7FFD7D7D7FFB4B4B4FFB3B3B3FFB2B2B2FFAEAEAEFFB1B1B1FFB0B0B0FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB0B0B0FFADADADFFAAAAAAFFA6A6A6FFAAAAAAFFABABABFFB4B4
      B4FFB6B6B6FFB6B6B6FF0404043F0000001C0000000C03030326382D2D89E2B1
      B1FFE8CFCBFFDEBBB7FFDEB9B6FFDEB7B4FFDBAFABFFDDB0ACFFDDACA8FFDEAA
      A5FFDEA5A1FFE0A5A1FFE1A5A1FFE2A6A1FFE3A7A1FFE3A7A1FFE3A8A1FFE3A8
      A1FFE3A8A1FFE3A8A1FFE3A7A1FFE3A7A1FFE2A6A1FFE2A5A1FFE0A5A1FFDEA5
      A1FFDDA5A1FFDBA5A1FFDAA5A1FFD8A5A1FFD6A5A1FFD8AEAAFFD9B1ADFFDEBB
      B7FFE0BCB8FFE2AFAFFF0909093F0101011C0000000C030303262B2D2B8999E1
      98FF99FF98FF99EE98FF99EA98FF99E798FF99D298FF99D698FF99CB98FF99C6
      98FF99BB98FF99BD98FF99BF98FF99BF98FF99C498FF99C498FF99C698FF99C6
      98FF99C698FF99C698FF99C498FF99C498FF99C298FF99BF98FF99BD98FF99BB
      98FF99BB98FF99B898FF99B698FF99B498FF99B298FF99CD98FF99D498FF99EE
      98FF99F098FF99DB98FF0909093F0101011C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000090101012005050544B4B4
      B4FFD7D7D7FFB8B8B8FFB4B4B4FFB4B4B4FFB4B4B4FFB1B1B1FFB0B0B0FFB0B0
      B0FFB0B0B0FFB0B0B0FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFAFAF
      AFFFACACACFFAAAAAAFFA7A7A7FFA5A5A5FFA3A3A3FFA9A9A9FFACACACFFB7B7
      B7FFB5B5B5FFB6B6B6FF030303380000001700000009020202200A0A0A44E2AE
      ADFFE8CFCCFFE0C0BDFFDEBFBBFFDEBDB9FFDEBAB6FFDDB5B2FFDCB1ADFFDCAD
      A9FFDDABA7FFDCA7A3FFDEA7A3FFDEA7A3FFDFA7A3FFE0A7A3FFE1A7A3FFE1A7
      A3FFE1A7A3FFE1A7A3FFE0A7A3FFE0A7A3FFDFA7A3FFDEA7A3FFDDA7A3FFDBA7
      A3FFDAA7A3FFD8A7A3FFD7A7A3FFD6A7A3FFD4A7A3FFD8B0ACFFD9B2AFFFE0BE
      B9FFE0B9B5FFE2AFAFFF070707380101011700000009020202200A0A0A4499D6
      98FF99FF98FF99F698FF99F498FF99F198FF99EC98FF99E498FF99D898FF99CF
      98FF99CB98FF99BD98FF99BF98FF99BF98FF99C298FF99C298FF99C298FF99C2
      98FF99C298FF99C298FF99C298FF99C298FF99BF98FF99BF98FF99BD98FF99BD
      98FF99BB98FF99BB98FF99B898FF99B698FF99B698FF99D298FF99D898FF99F2
      98FF99EC98FF99DB98FF07070738010101170000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000005000000190404043CB1B1
      B1FFC5C5C5FFC5C5C5FFC1C1C1FFB7B7B7FFBABABAFFB4B4B4FFB1B1B1FFAEAE
      AEFFADADADFFACACACFFACACACFFACACACFFAEAEAEFFAFAFAFFFB0B0B0FFB0B0
      B0FFB0B0B0FFB0B0B0FFAFAFAFFFAEAEAEFFADADADFFACACACFFABABABFFA9A9
      A9FFA8A8A8FFA6A6A6FFA4A4A4FFA3A3A3FFA2A2A2FFAAAAAAFFADADADFFB4B4
      B4FFB5B5B5FFABABABFA0202022F0000001100000005010101190808083CDFA9
      A8FFE4C6C2FFE3C6C2FFE1C5C1FFDFBFBDFFE0C1BEFFDEBDB9FFDDB7B4FFDBB2
      AFFFDBB0ACFFDAABA7FFDAA9A5FFDBA9A5FFDCA9A5FFDCA9A5FFDDA9A5FFDDA9
      A5FFDDA9A5FFDDA9A5FFDCA9A5FFDCA9A5FFDBA9A5FFDBA9A5FFDAA9A5FFD8A9
      A5FFD7A9A5FFD6A9A5FFD5A9A5FFD4A9A5FFD3A9A5FFD8B2AEFFDAB5B0FFDEBB
      B6FFE2AEADFFD7A8A7FA0505052F0000001100000005010101190808083C99C8
      98FF99FE98FF99FE98FF99FC98FF99F598FF99F798FF99F098FF99E798FF99DB
      98FF99D498FF99C698FF99C298FF99C298FF99C298FF99C498FF99C498FF99C4
      98FF99C498FF99C498FF99C498FF99C298FF99C298FF99C298FF99BF98FF99BF
      98FF99BD98FF99BD98FF99BB98FF99BB98FF99BB98FF99D698FF99DF98FF99ED
      98FF99D898FF93D092FA0505052F000000110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000030000001202020230AAAA
      AAFAC0C0C0FFDADADAFFCECECEFFC4C4C4FFC5C5C5FFBEBEBEFFB5B5B5FFB0B0
      B0FFADADADFFADADADFFAAAAAAFFA9A9A9FFAAAAAAFFABABABFFABABABFFACAC
      ACFFACACACFFABABABFFABABABFFAAAAAAFFA9A9A9FFA8A8A8FFA8A8A8FFA7A7
      A7FFA6A6A6FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFACACACFFAFAFAFFFB7B7
      B7FFB5B5B5FF0B0B0B57010101250000000B000000030000001205050530D5A1
      A1FAE6BCBBFFE9D1CFFFE4C9C7FFE2C5C2FFE2C6C3FFE1C3C0FFDFBFBCFFDCB9
      B5FFDAB5B1FFDAB2AEFFD9ADA9FFD8ABA7FFD9ABA7FFD9ABA7FFDAABA7FFDAAB
      A7FFDAABA7FFDAABA7FFDAABA7FFD9ABA7FFD8ABA7FFD8ABA7FFD8ABA7FFD7AB
      A7FFD6ABA7FFD5ABA7FFD4ABA7FFD4ABA7FFD4ABA7FFD9B4B0FFDBB7B3FFE0BE
      B9FFE2AFAEFF13121257030303250000000B00000003000000120505053093B6
      92FA99F598FF99FF98FF99FF98FF99FD98FF99FE98FF99FA98FF99F498FF99E8
      98FF99DF98FF99D898FF99C898FF99C498FF99C498FF99C698FF99C698FF99C6
      98FF99C698FF99C698FF99C698FF99C498FF99C498FF99C498FF99C498FF99C4
      98FF99C298FF99C298FF99C298FF99C298FF99C298FF99DD98FF99E498FF99F2
      98FF99DB98FF11121157030303250000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000010000000B010101240707
      074BBCBCBCFFDEDEDEFFD8D8D8FFD8D8D8FFD7D7D7FFD0D0D0FFC6C6C6FFB8B8
      B8FFB2B2B2FFAEAEAEFFADADADFFABABABFFA8A8A8FFA8A8A8FFA9A9A9FFAAAA
      AAFFAAAAAAFFA9A9A9FFA9A9A9FFA8A8A8FFA8A8A8FFA7A7A7FFA7A7A7FFA7A7
      A7FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7A7FFAFAFAFFFB4B4B4FFB6B6
      B6FFB4B4B4FF0404043B0000001A00000006000000010000000B020202240D0D
      0D4BE5B9B8FFECD6D4FFE7CFCCFFE7CFCCFFE6CECCFFE4CAC7FFE2C6C3FFDFC0
      BDFFDDBBB8FFDBB7B3FFDAB4B0FFD9B1AEFFD8AEA9FFD8AEA9FFD8AEA9FFD8AE
      A9FFD8AEA9FFD8AEA9FFD8AEA9FFD8AEA9FFD7AEA9FFD6AEA9FFD6AEA9FFD6AE
      A9FFD6AEA9FFD6AEA9FFD6AEA9FFD6AEA9FFD6AEA9FFDBB7B2FFDEBBB7FFE0B9
      B6FFE1ADACFF0808083B0101011A00000006000000010000000B020202240D0D
      0D4B99EE98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FE98FF99F6
      98FF99ED98FF99E498FF99DF98FF99D698FF99CB98FF99CB98FF99CB98FF99CB
      98FF99CB98FF99CB98FF99CB98FF99CB98FF99CB98FF99CB98FF99C898FF99C8
      98FF99C898FF99C898FF99C898FF99C898FF99C898FF99E498FF99ED98FF99ED
      98FF99D498FF0808083B0101011A000000060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000006000000180505
      053BB5B5B5FFD0D0D0FFDEDEDEFFDFDFDFFFE1E1E1FFDEDEDEFFD9D9D9FFCCCC
      CCFFBEBEBEFFB4B4B4FFB0B0B0FFAEAEAEFFACACACFFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFACACACFFB2B2B2FFB7B7B7FFB6B6
      B6FF606060C40202022C00000010000000030000000000000006010101180808
      083BE2AEADFFEAC9C7FFEBD6D3FFEBD7D5FFECD9D8FFEBD7D6FFE7D0CDFFE3C8
      C5FFE0C3BFFFDEBDBBFFDCB9B6FFDAB7B3FFDAB5B2FFD7B0ADFFD7B0ACFFD7B0
      ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0
      ACFFD7B0ACFFD7B0ACFFD7B0ACFFD7B0ACFFDAB5B1FFDDB9B5FFE0C0BDFFE2B0
      AFFF7F6463C40404042C00000010000000030000000000000006010101180808
      083B99D898FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99F998FF99F298FF99E898FF99E498FF99E198FF99D298FF99D298FF99D2
      98FF99D298FF99D298FF99D298FF99D298FF99D298FF99D298FF99D298FF99D2
      98FF99D298FF99D298FF99D298FF99D298FF99DF98FF99E898FF99F698FF99DD
      98FF5A6F59C40404042C00000010000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000020000000E0202
      022B0F0F0F5DC1C1C1FFE3E3E3FFE3E3E3FFFFFFFFFFEAEAEAFFE5E5E5FFDADA
      DAFFCFCFCFFFC3C3C3FFB7B7B7FFB2B2B2FFB0B0B0FFAFAFAFFFAEAEAEFFACAC
      ACFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAA
      AAFFAAAAAAFFAAAAAAFFAAAAAAFFABABABFFB0B0B0FFB6B6B6FFB7B7B7FFB1B1
      B1FF0404043D0101011D000000080000000100000000000000020000000E0404
      042B1716165DE7BFBEFFEEDCDAFFEEDCDAFFFFFFFFFFF0E3E1FFEEDEDCFFE8D2
      D0FFE4C9C7FFE2C5C2FFDFC0BCFFDDBCB8FFDCB9B6FFDBB7B4FFDBB7B4FFDAB5
      B1FFD8B2AFFFD8B2AFFFD8B2AFFFD8B2AFFFD8B2AFFFD8B2AFFFD8B2AFFFD8B2
      AFFFD8B2AFFFD8B2AFFFD8B2AFFFD9B2AFFFDCB9B5FFDFBEBAFFE1B8B6FFE0AA
      A9FF0808083D0101011D000000080000000100000000000000020000000E0404
      042B1315135D99F998FF99FF98FF99FF98FFAFFFABFF9AFF9AFF99FF99FF99FF
      98FF99FF98FF99FC98FF99F598FF99EE98FF99E898FF99E598FF99E498FF99DF
      98FF99D898FF99D898FF99D898FF99D898FF99D898FF99D898FF99D898FF99D8
      98FF99D898FF99D898FF99D898FF99D898FF99E898FF99F298FF99EC98FF99CB
      98FF0808083D0101011D00000008000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000060101
      01190606063CB4B4B4FDD6D6D6FFEFEFEFFFFFFFFFFFFFFFFFFFEDEDEDFFE3E3
      E3FFDADADAFFD3D3D3FFC9C9C9FFBDBDBDFFB4B4B4FFB3B3B3FFB2B2B2FFB1B1
      B1FFB0B0B0FFB0B0B0FFACACACFFACACACFFACACACFFACACACFFACACACFFACAC
      ACFFACACACFFACACACFFADADADFFAEAEAEFFB5B5B5FFC1C1C1FFB5B5B5FF1C1C
      1C770202022A0000001000000003000000000000000000000000000000060101
      01190909093CDEAEAEFDEED0CFFFF3E7E5FFFFFFFFFFFFFFFFFFF2E5E4FFEDDC
      DAFFE8D1CFFFE5CBC9FFE3C7C5FFE0C2BFFFDEBFBBFFDEBCB9FFDDBBB8FFDCBB
      B7FFDCBAB7FFDCB9B5FFDAB5B1FFDAB5B1FFDAB5B1FFDAB5B1FFDAB5B1FFDAB5
      B1FFDAB5B1FFDAB5B1FFDAB5B1FFDAB6B2FFDFBDB9FFE3C5C1FFE2AFAEFF2922
      22770404042A0000001000000003000000000000000000000000000000060101
      01190808083C97DA96FD99FF98FF9CFF9BFFAFFFABFFAFFFABFF9CFF9BFF99FF
      98FF99FF98FF99FF98FF99FF98FF99F998FF99F498FF99F098FF99ED98FF99EC
      98FF99EA98FF99E898FF99DF98FF99DF98FF99DF98FF99DF98FF99DF98FF99DF
      98FF99DF98FF99DF98FF99E198FF99E298FF99F198FF99FC98FF99D898FF2121
      21770404042A0000001000000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      000D020202260A0A0A4ABEBEBEFFE2E2E2FFF2F2F2FFFFFFFFFFFFFFFFFFE7E7
      E7FFDFDFDFFFD9D9D9FFD7D7D7FFCFCFCFFFC5C5C5FFBDBDBDFFB8B8B8FFB5B5
      B5FFB4B4B4FFB3B3B3FFAEAEAEFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAF
      AFFFAFAFAFFFAFAFAFFFAFAFAFFFB6B6B6FFC1C1C1FFB6B6B6FFA7A7A7F80303
      0335000000180000000700000001000000000000000000000000000000020000
      000D030303260E0E0E4AE6BBBAFFF1DBDAFFF5EBEAFFFFFFFFFFFFFFFFFFEFE0
      DEFFEBD8D6FFE8D0CEFFE6CECCFFE4CAC7FFE2C5C3FFE0C2BFFFDFC0BDFFDFBF
      BCFFDEBEBAFFDEBDB9FFDBB8B5FFDBB8B4FFDBB8B4FFDBB8B4FFDBB8B4FFDBB8
      B4FFDBB8B4FFDBB8B4FFDBB8B4FFDFBEBAFFE3C4C1FFE2B0AFFFD19C9BF80606
      0635010101180000000700000001000000000000000000000000000000020000
      000D030303260C0E0C4A99F298FF99FF98FF9DFF9CFFAFFFABFFAFFFABFF99FF
      99FF99FF98FF99FF98FF99FF98FF99FF98FF99FD98FF99F998FF99F698FF99F4
      98FF99F298FF99F098FF99E598FF99E598FF99E598FF99E598FF99E598FF99E5
      98FF99E598FF99E598FF99E598FF99F298FF99FC98FF99DD98FF91B190F80606
      0635010101180000000700000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0005000000130404043010101057C2C2C2FFE5E5E5FFEEEEEEFFFAFAFAFFE3E3
      E3FFE3E3E3FFDDDDDDFFDCDCDCFFD9D9D9FFD5D5D5FFCFCFCFFFC9C9C9FFC5C5
      C5FFC1C1C1FFBCBCBCFFB2B2B2FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB2B2B2FFB2B2B2FFB4B4B4FFC5C5C5FFB7B7B7FFB1B1B1FF0404043C0101
      011F0000000B0000000200000000000000000000000000000000000000000000
      0005000000130606063015151557E8C0BFFFF2DFDEFFF2E6E4FFF9F3F2FFEDDC
      DAFFECDAD8FFEAD5D3FFE9D4D1FFE7D0CDFFE6CCCAFFE4CAC7FFE3C7C5FFE2C6
      C3FFE1C4C1FFE0C1BFFFDDBBB8FFDCBBB7FFDCBBB7FFDCBBB7FFDCBBB7FFDCBB
      B7FFDDBBB7FFDDBBB7FFDEBDB9FFE3C6C2FFE2B1B0FFDEA4A4FF0808083C0202
      021F0000000B0000000200000000000000000000000000000000000000000000
      000500000013050605301119115799FB98FF99FF99FF9CFF9BFFA2FFA0FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FE
      98FF99FC98FF99F898FF99ED98FF99EC98FF99EC98FF99EC98FF99EC98FF99EC
      98FF99EC98FF99EC98FF99F198FF99FE98FF99DF98FF99BB98FF0808083C0202
      021F0000000B0000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000007010101180505053517171765C1C1C1FFE0E0E0FFEBEBEBFFE7E7
      E7FFE3E3E3FFDFDFDFFFDEDEDEFFDDDDDDFFDADADAFFD8D8D8FFD6D6D6FFD5D5
      D5FFCFCFCFFFC9C9C9FFB5B5B5FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB4B4
      B4FFB4B4B4FFB9B9B9FFCACACAFFB7B7B7FFB1B1B1FF0404043E010101230000
      000E000000030000000000000000000000000000000000000000000000000000
      00010000000701010118070707351D1C1C65E8BFBEFFF1DAD9FFF1E4E2FFEFDF
      DEFFEDDCDAFFECD8D6FFEAD7D5FFE9D4D2FFE8D2CFFFE7CFCDFFE6CDCBFFE5CC
      C9FFE4C9C7FFE3C7C4FFDFBFBCFFDEBDBAFFDEBDBAFFDEBDBAFFDEBDBAFFDEBD
      BAFFDEBEBAFFE0C1BDFFE4C8C5FFE2B1B0FFDDA2A1FF0808083E020202230000
      000E000000030000000000000000000000000000000000000000000000000000
      00010000000701010118060706351820176599F998FF99FF98FF9BFF9AFF99FF
      99FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99F498FF99F198FF99F198FF99F198FF99F198FF99F1
      98FF99F298FF99F798FF99FF98FF99DF98FF99B498FF0808083E020202230000
      000E000000030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000002000000090101011A050505350E0E0E53BCBCBCFFDADADAFFE8E8
      E8FFE7E7E7FFE2E2E2FFE1E1E1FFDEDEDEFFDEDEDEFFDCDCDCFFDADADAFFDADA
      DAFFD7D7D7FFD2D2D2FFBDBDBDFFB9B9B9FFB8B8B8FFB8B8B8FFB8B8B8FFBCBC
      BCFFC5C5C5FFC1C1C1FFB7B7B7FFB1B1B1FF0404043D01010124000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      000000000002000000090101011A0707073512121253E5B7B7FFEFD3D3FFF0E1
      E0FFEFDFDCFFECDAD8FFECDAD8FFEBD7D5FFEAD5D3FFE9D4D1FFE8D2D0FFE8D1
      CEFFE7CFCCFFE5CBC9FFE0C2BFFFDFC1BDFFDFC0BDFFDFC0BDFFDFC0BDFFE1C2
      BFFFE3C6C2FFE4C3C1FFE2B1B0FFDCA09FFF0808083D02020224000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      000000000002000000090101011A0607063510140F5399ED98FF99FF98FF9AFF
      99FF99FF99FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99F998FF99F698FF99F698FF99F698FF99F698FF99F9
      98FF99FE98FF99FC98FF99DF98FF99AE98FF0808083D02020224000000100000
      0004000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008010101180404042F09090948B7B7B7FFCDCD
      CDFFDDDDDDFFE8E8E8FFE4E4E4FFDEDEDEFFDEDEDEFFDFDFDFFFDEDEDEFFDDDD
      DDFFDADADAFFD8D8D8FFC4C4C4FFC0C0C0FFC0C0C0FFC5C5C5FFCCCCCCFFD3D3
      D3FFB7B7B7FFB1B1B1FF494949AD03030337010101210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008010101180505052F0D0D0D48E2B1B1FFEAC6
      C5FFEFD6D5FFF0E1DFFFEEDCDAFFEAD5D3FFEAD5D2FFEBD7D6FFEAD6D4FFEAD5
      D3FFE9D2D0FFE7CFCDFFE2C5C2FFE1C3C1FFE1C4C0FFE2C5C2FFE4C8C5FFE6CC
      C8FFE2B1B1FFDCA1A0FF5E4747AD07070737020202210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000008010101180505052F0C0D0C4899E198FF99FF
      98FF99FF98FF9AFF99FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FD98FF99FB98FF99FB98FF99FD98FF99FF98FF99FF
      98FF99E198FF99B098FF464845AD07070737020202210000000F000000050000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001202020225050505390E0E
      0E5DB6B6B6FFCECECEFFD7D7D7FFE7E7E7FFE7E7E7FFE2E2E2FFDEDEDEFFDDDD
      DDFFDBDBDBFFD9D9D9FFD5D5D5FFD6D6D6FFD6D6D6FFC3C3C3FFB9B9B9FFB1B1
      B1FFAAAAAAFB040404410202022E0000001B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001203030325080808391715
      155DE2B0B0FFEAC7C7FFEED1D0FFEFDFDEFFEFDFDDFFECDAD8FFEBD6D4FFEAD5
      D3FFE9D3D1FFE8D0CDFFE6CDCAFFE6CDC9FFE7CDCBFFE5C4C1FFE3B4B3FFDDA2
      A1FFD29696FB090909410404042E0101011B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000070000001203030325070707391315
      135D99DD98FF99FF98FF99FF98FF99FF99FF99FF99FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99FF98FF99FF98FF99FF98FF99FD98FF99E598FF99B4
      98FF959B94FB090909410404042E0101011B0000000C00000004000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C000000180202
      0229040404390808084CB3B3B3FFB5B5B5FFC8C8C8FFD5D5D5FFD5D5D5FFD4D4
      D4FFD2D2D2FFCDCDCDFFBFBFBFFFBCBCBCFFB1B1B1FFB1B1B1FF6F6F6FCD0404
      0441020202320101012200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C010101180404
      0429070707390E0D0D4CE0ACABFFE1AEADFFE9C3C3FFEDCFCEFFEDCECEFFECCD
      CDFFECCBCBFFEAC7C6FFE6BBB9FFE5B7B6FFDFA7A7FFDA9A99FF886362CD0909
      0941050505320202022200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000050000000C010101180304
      0329070707390D0D0D4C99D298FF99D898FF99FF98FF99FF98FF99FF98FF99FF
      98FF99FF98FF99FF98FF99F298FF99ED98FF99C498FF99A298FF626761CD0909
      0941050505320202022200000013000000080000000300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0000001801010124020202300404043B050505431E1E1E7A747474D48484
      84E0B1B1B1FF828282DE535353B60D0D0D5B04040441030303370202022C0101
      0120000000150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0101011802020224050505300808083B0A0A0A432B24247A957372D4A881
      80E0DEA6A5FFA37B7ADE694F4EB61513135B09090941070707370404042C0202
      0220010101150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000060000
      000E0101011802020224050505300808083B0A0A0A432224227A697D68D4768F
      76E099BF98FF748273DE4D514CB61313135B09090941070707370404042C0202
      0220010101150000000B00000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120000001901010120010101250202022A0202
      022C0202022D0202022C01010129010101240101011D00000017000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120101011902020220030303250404042A0404
      042C0404042D0404042C03030329020202240101011D01010117000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000060000000B000000120101011902020220030303250404042A0404
      042C0404042D0404042C03030329020202240101011D01010117000000100000
      0009000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000000300000005000000080000000B0000000E0000
      0010000000100000000F0000000D0000000A0000000800000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000A0000000280000000100010000000000200300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object dlgOpenPic: TOpenPictureDialog
    Left = 512
    Top = 582
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 374
    Top = 118
  end
  object cdsFeriasClone: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 196
    Top = 572
  end
end
