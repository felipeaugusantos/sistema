inherited frmCadProspectos: TfrmCadProspectos
  Width = 800
  Height = 624
  Caption = 'Cadastro de Prospectos'
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 511
    Width = 794
    Height = 52
    ExplicitTop = 511
    ExplicitWidth = 794
    ExplicitHeight = 52
    inherited FlwBotoes: TFlowPanel
      Width = 713
      Height = 48
      ExplicitTop = 2
      ExplicitWidth = 713
      ExplicitHeight = 48
      inherited btnIncluir: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 76
        Height = 24
        Align = alLeft
        ExplicitWidth = 76
        ExplicitHeight = 24
      end
      object btnCadCli: TBitBtnLocked
        Left = 436
        Top = 0
        Width = 142
        Height = 24
        Align = alLeft
        Caption = '[F4] - Cadastro de clientes'
        TabOrder = 6
        OnClick = btnCadCliClick
      end
      object btnImportarCadastrosProspecto: TBitBtnLocked
        Left = 578
        Top = 0
        Width = 121
        Height = 24
        Align = alLeft
        Caption = 'Importar Prospectos'
        TabOrder = 7
        OnClick = btnImportarCadastrosProspectoClick
      end
      object btnVincularProspCli: TBitBtnLocked
        Left = 0
        Top = 24
        Width = 129
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '[ F5] Vincular a Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = btnVincularProspCliClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      Height = 48
      Align = alRight
      ExplicitLeft = 715
      ExplicitHeight = 48
    end
  end
  inherited pnlStatus: TPanel
    Top = 563
    Width = 794
    ExplicitTop = 563
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 447
      ExplicitLeft = 447
    end
    inherited pnlInfo: TPanel
      Width = 447
      ExplicitWidth = 447
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 511
    StyleElements = [seFont, seBorder]
    ExplicitWidth = 794
    ExplicitHeight = 511
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 479
      object pnlGeral: TPanel
        Left = 0
        Top = 0
        Width = 786
        Height = 479
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          786
          479)
        object Label1: TLabel
          Left = 66
          Top = 6
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 499
          Top = 6
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object ColorLabel1: TColorLabel
          Left = 589
          Top = 5
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
          Left = 202
          Top = 6
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data Cadastro:'
        end
        object Label3: TLabel
          Left = 32
          Top = 28
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome / Raz'#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 24
          Top = 50
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fantasia / Sobr.:'
        end
        object Label7: TLabel
          Left = 236
          Top = 72
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label8: TLabel
          Left = 590
          Top = 72
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label9: TLabel
          Left = 80
          Top = 72
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label5: TLabel
          Left = 53
          Top = 94
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label189: TLabel
          Left = 542
          Top = 94
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object Label190: TLabel
          Left = 35
          Top = 116
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label6: TLabel
          Left = 424
          Top = 116
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label12: TLabel
          Left = 14
          Top = 138
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
        end
        object Label62: TLabel
          Left = 355
          Top = 139
          Width = 101
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado Emiss'#227'o CPF:'
        end
        object Label11: TLabel
          Left = 84
          Top = 161
          Width = 18
          Height = 14
          Alignment = taRightJustify
          Caption = 'RG:'
        end
        object Label60: TLabel
          Left = 192
          Top = 160
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Expedi'#231#227'o:'
        end
        object Label10: TLabel
          Left = 11
          Top = 183
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Inscri'#231#227'o Estadual:'
        end
        object Label21: TLabel
          Left = 10
          Top = 205
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Funda'#231#227'o/Nascim.:'
        end
        object Label22: TLabel
          Left = 229
          Top = 205
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cx. Postal:'
        end
        object Label14: TLabel
          Left = 403
          Top = 205
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 1:'
        end
        object Label18: TLabel
          Left = 433
          Top = 227
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'FAX:'
        end
        object Label16: TLabel
          Left = 49
          Top = 227
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 2:'
        end
        object Label20: TLabel
          Left = 66
          Top = 249
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Celular:'
        end
        object lbl7: TLabel
          Left = 402
          Top = 249
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'ID-NEXTEL:'
        end
        object Label24: TLabel
          Left = 55
          Top = 271
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail - 1:'
        end
        object Label23: TLabel
          Left = 416
          Top = 271
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato:'
        end
        object Label200: TLabel
          Left = 49
          Top = 293
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail NFe:'
        end
        object Label192: TLabel
          Left = 394
          Top = 293
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail NFe 2:'
        end
        object Label25: TLabel
          Left = 45
          Top = 316
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Home Page:'
        end
        object Label40: TLabel
          Left = 408
          Top = 316
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
        end
        object lblAtivo1: TLabel
          Left = 109
          Top = 451
          Width = 494
          Height = 14
          Caption = 
            'Prospecto ativado para o Cadastro de Clientes. N'#227'o ser'#225' permitid' +
            'o nenhuma altera'#231#227'o neste cadastro.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblAtivo2: TLabel
          Left = 109
          Top = 464
          Width = 252
          Height = 14
          Caption = 'Fa'#231'a todas as altera'#231#245'es pelo Cadastro de Clientes.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblAtivo3: TLabel
          Left = 367
          Top = 464
          Width = 157
          Height = 14
          Caption = 'C'#243'digo do Cadastro de Clientes: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label36: TLabel
          Left = 406
          Top = 338
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object Label13: TLabel
          Left = 30
          Top = 339
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Rede de Lojas:'
        end
        object Label15: TLabel
          Left = 45
          Top = 361
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Frequ'#234'ncia:'
        end
        object Label17: TLabel
          Left = 428
          Top = 361
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Porte:'
        end
        object lblCategoria: TLabel
          Left = 53
          Top = 384
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria:'
        end
        object lblStatusProspe: TLabel
          Left = 422
          Top = 383
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Status:'
        end
        object Label38: TLabel
          Left = 28
          Top = 408
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Representante:'
        end
        object lblRegiao: TLabel
          Left = 420
          Top = 408
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o:'
        end
        object dbeCodPro: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 0
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODPRO'
          DataSource = dtsTabela
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
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeStatus: TDBEditFocus
          Tag = 99
          Left = 548
          Top = 2
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_STATUS'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaCad: TDBEditFocus
          Left = 284
          Top = 2
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'PRO_DTACAD'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 38
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomCli: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 24
          Width = 577
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_NOMCLI'
          DataSource = dtsTabela
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
          TipoTexto = ttAlfanumerico
        end
        object dbeFanSob: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 46
          Width = 577
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_FANSOB'
          DataSource = dtsTabela
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
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCid: TDBEditFocus
          Tag = 99
          Left = 278
          Top = 68
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODCID'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 5
          OnKeyPress = dbeCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodCidChamaCadastro
        end
        object edtNomCid: TEditFocus
          Left = 321
          Top = 68
          Width = 200
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 34
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstado: TEditFocus
          Left = 631
          Top = 68
          Width = 54
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 35
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
          Left = 108
          Top = 68
          Width = 97
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_C_E_P_'
          DataSource = dtsTabela
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
        object dbeEndere: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 90
          Width = 408
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_ENDERE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndNum: TDBEditFocus
          Tag = 99
          Left = 587
          Top = 90
          Width = 98
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_ENDNUM'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndCom: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 112
          Width = 243
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_ENDCOM'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBairro: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 112
          Width = 314
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_BAIRRO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCgcCpf: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 134
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CGCCPF'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 10
          OnExit = dbeCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNuCnpj: TDBEditFocus
          Tag = 99
          Left = 143
          Top = 134
          Width = 208
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_C_G_C_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 11
          OnEnter = dbeCgcCpfExit
          OnExit = dbeNuCnpjExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtEstEmiCpf: TEditFocus
          Left = 462
          Top = 134
          Width = 314
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 36
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeNumRg: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 156
          Width = 80
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_NUMR_G'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtRgExp: TEditFocus
          Tag = 99
          Left = 249
          Top = 156
          Width = 54
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
          TabOrder = 13
          OnKeyPress = edtRgExpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object cbxRgEst: TComboBoxFocus
          Tag = 99
          Left = 303
          Top = 156
          Width = 48
          Height = 22
          Style = csDropDownList
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          Items.Strings = (
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
            'SE'
            'EX')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeNumIes: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 179
          Width = 243
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_I_E_S_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaNas: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 201
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_NASCIM'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCaiPos: TDBEditFocus
          Tag = 99
          Left = 284
          Top = 201
          Width = 67
          Height = 22
          DataField = 'PRO_CAIPOS'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone01: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 201
          Width = 105
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_FONE01'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumFax: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 223
          Width = 105
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_F_A_X_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone02: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 223
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_FONE02'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumCel: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 245
          Width = 277
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CELULA'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNEXTEL: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 245
          Width = 198
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_NEXTEL'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmail: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 267
          Width = 277
          Height = 22
          CharCase = ecLowerCase
          DataField = 'PRO_EMAIL_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeContat: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 267
          Width = 314
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CONTAT'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmailNFe: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 289
          Width = 277
          Height = 22
          CharCase = ecLowerCase
          DataField = 'PRO_EMAIL3'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 25
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmailNfe2: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 289
          Width = 314
          Height = 22
          CharCase = ecLowerCase
          DataField = 'PRO_EMAIL2'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 26
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHomPag: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 312
          Width = 277
          Height = 22
          CharCase = ecLowerCase
          DataField = 'PRO_HOMEPA'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodAti: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 312
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODATI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 28
          OnKeyPress = dbeCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodAtiChamaCadastro
        end
        object edtAtividade: TEditFocus
          Left = 498
          Top = 312
          Width = 278
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 37
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCodVen: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 335
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODVEN'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 30
          OnKeyPress = dbeCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtVendedor: TEditFocus
          Left = 498
          Top = 335
          Width = 278
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 39
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCodRed: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 335
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODRED'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 29
          OnKeyPress = dbeCodRedKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesRed: TEditFocus
          Left = 164
          Top = 335
          Width = 221
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 40
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmFre: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 358
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CRMFRE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 31
          OnKeyPress = dbeCrmFreKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesFre: TEditFocus
          Left = 164
          Top = 358
          Width = 221
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 41
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmPor: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 358
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CRMPOR'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 32
          OnKeyPress = dbeCrmPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesPor: TEditFocus
          Left = 518
          Top = 358
          Width = 258
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 42
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmCat: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 381
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CRMCAT'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 33
          OnKeyPress = dbeCrmCatKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesCat: TEditFocus
          Left = 164
          Top = 381
          Width = 221
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
        object btnConsultarEndereco: TBitBtnLocked
          Left = 461
          Top = 156
          Width = 164
          Height = 25
          Caption = 'Consultar Endere'#231'o no Google'
          TabOrder = 44
          TabStop = False
          OnClick = btnConsultarEnderecoClick
        end
        object cbStatusProspe: TComboBoxFocus
          Left = 462
          Top = 381
          Width = 314
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 45
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeCodRep: TDBEditFocus
          Tag = 99
          Left = 108
          Top = 404
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODREP'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 46
          OnKeyPress = dbeCodRepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtNomRep: TEditFocus
          Left = 164
          Top = 404
          Width = 221
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
        object dbeCodReg: TDBEditFocus
          Tag = 99
          Left = 462
          Top = 404
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODREG'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 48
          OnKeyPress = dbeCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesReg: TEditFocus
          Left = 518
          Top = 404
          Width = 258
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 49
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object pnlCanalAcesso: TPanel
          Left = 0
          Top = 426
          Width = 386
          Height = 24
          Align = alCustom
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 50
          Visible = False
          object lblCanalAcesso: TLabel
            Left = 18
            Top = 5
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Canal de Acesso:'
          end
          object dbeCodCac: TDBEditFocus
            Tag = 99
            Left = 108
            Top = 1
            Width = 54
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_CODCAC'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnKeyPress = dbeCodCacKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtDesCadCac: TEditFocus
            Left = 164
            Top = 1
            Width = 221
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        end
      end
    end
    object tbsIntVen: TTabSheet
      Caption = '&2 - Intelig'#234'ncia de Vendas'
      ImageIndex = 1
      object Label47: TLabel
        Left = 59
        Top = 40
        Width = 72
        Height = 56
        Alignment = taRightJustify
        Caption = 'Observa'#231#245'es:'#13#10'Pressione TAB'#13#10'para a pr'#243'ximo'#13#10'campo'
      end
      object Label19: TLabel
        Left = 20
        Top = 17
        Width = 111
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faixa de Fat. Estimado:'
      end
      object dbeObserv: TDBMemoFocus
        Left = 137
        Top = 39
        Width = 632
        Height = 67
        BiDiMode = bdLeftToRight
        DataField = 'PRO_OBSERV'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentBiDiMode = False
        ScrollBars = ssVertical
        TabOrder = 1
        OnKeyPress = dbeObservKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object dbeCrmFai: TDBEditFocus
        Tag = 99
        Left = 137
        Top = 14
        Width = 54
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PRO_CRMFAI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCrmFaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtDesFai: TEditFocus
        Left = 193
        Top = 14
        Width = 264
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
      object cxgProFor: TcxGridCitel
        Left = 20
        Top = 149
        Width = 749
        Height = 300
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgProForTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgProForTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgProForTableViewColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'PRF_CRMFOR'
            Width = 82
          end
          object cxgProForTableViewColumn2: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'CRF_NOMFOR'
            Width = 487
          end
        end
        object cxgProForLevel: TcxGridLevel
          GridView = cxgProForTableView
        end
      end
      object Panel1: TPanel
        Left = 20
        Top = 112
        Width = 749
        Height = 37
        TabOrder = 2
        object Label26: TLabel
          Left = 9
          Top = 13
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor Atual:'
        end
        object Label27: TLabel
          Left = 538
          Top = 13
          Width = 190
          Height = 14
          Caption = '[DEL] - Para excluir um Fornecedor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCrmFor: TEditFocus
          Tag = 99
          Left = 101
          Top = 10
          Width = 54
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
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCrmForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDesFor: TEditFocus
          Left = 157
          Top = 10
          Width = 280
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object btnAddCrmFor: TBitBtnLocked
          Left = 439
          Top = 10
          Width = 89
          Height = 22
          Caption = 'Incluir'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000100000003000000080000000C0000
            000E0000000D0000000800000003000000010000000000000000000000020000
            000A00000010000000110000001300000018050E0A3F16412DAC216043EC256A
            48FF216141ED163F2BAC050E09390000000900000001000000000000000A7B50
            43C2AB705CFFAB6F5AFFC29A8CFFA2A191FF307554FF2D9D71FF24BA82FF23CB
            8EFF23BA82FF25986BFF2C7050FD0A1E145C00000006000000000000000EAD73
            5FFFFDFBF9FFFAF4F2FFDCE4DEFF388260FF40C397FF28CD92FF40956DFF487E
            5DFF3F946CFF26CD91FF27BA84FF297150F5050F0A2F000000030000000EB077
            62FFFDFBFAFFF6EFEBFF80AD96FF54B593FF36D29CFF2ECE95FF4A8362FFFFFF
            FFFF4A8161FF2CD096FF2CCF95FF31A87AFF1B4833A1000000060000000CB079
            66FFFDFBFBFFF7F2EFFF499371FF6CDBBBFF469D76FF4D8865FF4D8765FFF6F1
            EBFF4D8665FF4D8664FF459B73FF33C892FF2B7453E7000000080000000BB37C
            69FFFEFCFBFFF8F4F1FF3C926DFF81E9CCFF508C6AFFEADBD3FFF8F3EFFFF9F3
            EFFFF8F3EFFFFFFFFFFF4E8968FF3FD5A3FF348662FA000000080000000AB67F
            6CFFFEFDFCFFF8F3F1FF4FA07DFFB1E9D8FF6CA98CFF528F6EFF528F6DFFFAF5
            F3FF528F6CFF518E6BFF5EA583FF76DCBBFF338260E70000000700000009B983
            71FFFEFDFCFFFAF5F2FF8CC2AAFF94CBB5FFE2FAF5FFC5F5E9FF539371FFECDE
            D8FF539270FFABF0DDFFB0F1DEFF84C6ADFF2358419A0000000400000007BC88
            77FFFEFEFDFFFBF4F0FFE4ECE6FF4EAA84FFC8E7DBFFEEFDFAFF7AB095FF5696
            74FF74AF94FFD9F9F2FFBEE5D8FF3E9873F208130E250000000100000006BF8C
            7AFFFEFEFDFFFBF6F1FFFBF6F4FFC9E2D5FF4FAD85FF93CEB7FFD2ECE3FFF3FC
            FBFFD2ECE3FF92CDB6FF4DA881FF122D2251000000020000000000000005C18F
            7FFFFEFEFEFFFAF6F3FFFAF5F3FFFAF7F4FFE5EEE7FF90CAB1FF5BB48FFF46AB
            82FF5BB48EFF8EC9B1FFC9BDB1FF00000008000000000000000000000004C493
            82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFBF6F3FFFCF8F6FFFCF7F6FFFCF9
            F7FFFBF8F5FFFCFBFAFFC49587FF00000005000000000000000000000003C799
            85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
            F3FFFCF6F2FFFDFCFAFFC28F7FFF00000004000000000000000000000002C99A
            89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFC49382FF000000030000000000000000000000019774
            67BECA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
            87FFC79887FFC89886FF927063BF000000020000000000000000}
          TabOrder = 2
          OnClick = btnAddCrmForClick
        end
      end
    end
    object tsConsultaEndereco: TTabSheet
      Caption = 'Consulta de Endere'#231'o'
      ImageIndex = 2
      object pnlConsultaEndereco: TPanel
        Left = 0
        Top = 0
        Width = 786
        Height = 479
        Align = alClient
        TabOrder = 0
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1004
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 972
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 980
    Top = 24
  end
  object dtsTabela: TDataSource
    Left = 448
    Top = 600
  end
end
