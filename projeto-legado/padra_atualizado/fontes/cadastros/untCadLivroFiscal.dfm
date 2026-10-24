inherited frmCadLivroFiscal: TfrmCadLivroFiscal
  Left = 0
  Top = 0
  Width = 1182
  Height = 786
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Livro Fiscal'
  WindowState = wsMaximized
  ExplicitWidth = 1182
  ExplicitHeight = 786
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 716
    Width = 1176
    Height = 25
    TabOrder = 2
    ExplicitTop = 716
    ExplicitWidth = 1176
    ExplicitHeight = 25
    DesignSize = (
      1176
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 1172
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 1172
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 100
        ExplicitWidth = 100
      end
      inherited btnGravar: TBitBtnLocked
        Left = 100
        Width = 100
        ExplicitLeft = 100
        ExplicitWidth = 100
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 200
        Width = 100
        ExplicitLeft = 200
        ExplicitWidth = 100
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 300
        Width = 100
        ExplicitLeft = 300
        ExplicitWidth = 100
      end
      inherited btnCancela: TBitBtnLocked
        Left = 400
        Width = 100
        ExplicitLeft = 400
        ExplicitWidth = 100
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 500
        Width = 100
        ExplicitLeft = 500
        ExplicitWidth = 100
      end
      object btnEventosDeEntrega: TBitBtnLocked
        Left = 600
        Top = 0
        Width = 150
        Height = 20
        Caption = 'Eventos de Entrega'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000513322B74C2C
          1CB700000000412112B73E1D0EB7000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000005B3E2CBD5638
          26BD000000004A2A1ABD452414BD000000000000000000000000000000000000
          0000000000000000000002060B15102D58AE0E2952A8010307120000000D0000
          0013000000160000001800000015000000070000000100000000000000000000
          0000000000000A1C30541D4E89EC4D8EC4FF2069AFFF183969E2885032F98649
          2CFF7D4226FF743920FF6C311AFD0B0502340000000200000000000000000308
          0E1517416CAE2E72AFFF449BD5FF74B7E4FF257EC6FF3D6995FFA97150FFE0A9
          7EFFD79868FFCF9061FF7C4629FF45210FD200000007000000000E273C57296A
          A2EC4597CEFF4FAADFFF4BA6DDFF88C2E8FF2780C7FF646D7BFFC38E6BFFE5B6
          92FFE5B692FFE1B28FFFAE7B5CFF5B2E1AFB03010114000000002B76B4FF5BB6
          E2FF5AB6E4FF54B0E2FF50ABDFFF9DCEEDFF2883C9FF8D6D5DFFA16744FF9C60
          3FFF955A39FF8D5233FF86492DFF683A22F9180C0749000000002D7BB9FF66C3
          EBFF60BDE7FF5BB7E5FF56B1E2FFB1DAF1FF2986CCFF2781C8FF247BC4FF2176
          C1FF1F70BDFF1D6BB7FF133571FF3A241988351E1388000000002F80BDFF6CCA
          EEFF67C4EBFF61BEE8FF5CB8E5FFC3E4F5FF2A89CEFF2885CBFF2680C9FF237B
          C6FF2077C4FF1F72C2FF153C7AFF1D140E3C70462FFF311C127C3085C1FF72D0
          F0FF6DCBEDFF67C5EBFF77C8EBFFF3FAFDFFBADAF0FF3E94D2FF2782CAFF247E
          C8FF2279C5FF2075C3FF16407FFF02010103774F38F770462EFF3288C5FF78D7
          F2FF77D3F0FFADE2F4FFDBEFF7FF88CCE3FF81C8E3FFD1E9F5FF74B2DEFF2680
          C9FF247CC6FF2177C4FF184483FF000000000000000000000000338DC7FF7FCE
          EBFFC1E2F2FF8FC1E2FF4297CFFF3892CCFF3490CDFF3994CEFF97D0E8FFA3D0
          EAFF3C8DCEFF237AC6FF1A4A88FF0000000000000000000000000C22303C2669
          96C055ACD9FF7AD9F2FF7EDDF5FF7AD8F2FF78D3F0FF318FCCFF3CA8D5FF54B1
          DAFF98CEE9FF60A6D9FF1C4F8EFF000000000000000000000000000000000000
          00000C212F3C256693C050A8D5FF77D5F0FF7AD6F1FF318FCDFF3CA8D5FF35A3
          D3FF309ED3FF4799CDFF1E5493FF000000000000000000000000000000000000
          000000000000000000000C202E3C24628FC04198CEFF318FCCFF3AA2D2FF2D88
          C3FF2467A3F514395F9906121F33000000000000000000000000000000000000
          0000000000000000000000000000000000000B1E2D3C235D8CC0225E8FC9102C
          44630205080C0000000000000000000000000000000000000000}
        PopupMenu = popEventosEntrega
        TabOrder = 6
        OnClick = btnEventosDeEntregaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1090
      Top = 1
      ExplicitLeft = 1090
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 741
    Width = 1176
    TabOrder = 3
    ExplicitTop = 741
    ExplicitWidth = 1176
    inherited pnlNomeForm: TPanel
      Left = 957
      Width = 219
      ExplicitLeft = 957
      ExplicitWidth = 219
    end
    inherited pnlInfo: TPanel
      Width = 957
      ExplicitWidth = 957
      object lblWarningCfopInvalida: TLabel
        Left = -131
        Top = 0
        Width = 806
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'CFOP inv'#225'lida para este estado, favor verifique!'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 237
    Width = 1176
    Height = 457
    TabOrder = 4
    Visible = False
    ExplicitTop = 237
    ExplicitWidth = 1176
    ExplicitHeight = 457
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1168
      ExplicitHeight = 425
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1176
    Height = 209
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1176
      209)
    object Label1: TLabel
      Left = 45
      Top = 9
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Documento:'
      ParentShowHint = False
      ShowHint = False
    end
    object lblTip_fc: TLabel
      Left = 32
      Top = 55
      Width = 110
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Fornecedor:'
    end
    object Label6: TLabel
      Left = 27
      Top = 111
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label7: TLabel
      Left = 349
      Top = 111
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label10: TLabel
      Left = 135
      Top = 134
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Doc.:'
    end
    object Label11: TLabel
      Left = 258
      Top = 134
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object Label12: TLabel
      Left = 230
      Top = 8
      Width = 7
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 23
      Top = 134
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entrada:'
    end
    object Label14: TLabel
      Left = 336
      Top = 9
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label15: TLabel
      Left = 349
      Top = 32
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object ColorLabel2: TColorLabel
      Left = 32
      Top = 32
      Width = 110
      Height = 14
      Caption = '(F)ornecedor/(C)liente:'
      ParentShowHint = False
      ShowHint = False
      CorDestaque = clRed
    end
    object Label4: TLabel
      Left = 267
      Top = 111
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label40: TLabel
      Left = 438
      Top = 8
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label41: TLabel
      Left = 645
      Top = 111
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave de Acesso:'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 99
      Width = 1174
      Height = 6
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
    end
    object ColorLabel3: TColorLabel
      Left = 530
      Top = 32
      Width = 83
      Height = 14
      Caption = 'NF Complemento:'
      ParentShowHint = False
      ShowHint = False
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 746
      Top = 32
      Width = 85
      Height = 14
      Caption = 'CST Nf Comp.Ent:'
      Visible = False
    end
    object lblCgcCpf: TLabel
      Left = 529
      Top = 55
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'CNPJ:'
    end
    object Label81: TLabel
      Left = 437
      Top = 32
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'SubS'#233'rie:'
    end
    object ColorLabel1: TColorLabel
      Left = 214
      Top = 32
      Width = 86
      Height = 14
      Caption = '(E)ntrada/(S)a'#237'da:'
      ParentShowHint = False
      ShowHint = False
      CorDestaque = clRed
    end
    object ColorLabel4: TColorLabel
      Left = 660
      Top = 32
      Width = 58
      Height = 14
      Caption = '(S)im (N)'#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblCTComVen: TColorLabel
      Left = 755
      Top = 8
      Width = 88
      Height = 14
      Caption = '(V)enda (C)ompra'
      ParentShowHint = False
      ShowHint = False
      CorDestaque = clRed
    end
    object Label94: TLabel
      Left = 443
      Top = 111
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'N.Protocolo NFe/NFCe:'
      WordWrap = True
    end
    object lblCodMod: TLabel
      Left = 697
      Top = 179
      Width = 37
      Height = 14
      Caption = 'Modelo:'
    end
    object lblVenda: TLabel
      Left = 732
      Top = 56
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Venda:'
    end
    object lblNFCeOffline: TLabel
      Left = 894
      Top = 28
      Width = 111
      Height = 22
      Alignment = taRightJustify
      Caption = 'NFCe Offline'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDataNFCeOffline: TLabel
      Left = 503
      Top = 133
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt. Offline.:'
      Visible = False
    end
    object lblChaveNFCeOffline: TLabel
      Left = 636
      Top = 133
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave NFCe Offline:'
      Visible = False
    end
    object lblStatus: TLabel
      Left = 879
      Top = 8
      Width = 285
      Height = 14
      Caption = 'Aten'#231#227'o! Documento denegado ainda n'#227'o cancelado'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object lblPerfCli: TLabel
      Left = 68
      Top = 79
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Perfil Cliente:'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object Label118: TLabel
      Left = 530
      Top = 81
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero DPS:'
      ParentShowHint = False
      ShowHint = False
    end
    object Label119: TLabel
      Left = 687
      Top = 81
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie DPS:'
    end
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 145
      Top = 5
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_NUMDOC'
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
      OnExit = dbeNumDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNumDo2: TDBEditFocus
      Tag = 99
      Left = 241
      Top = 5
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_NUMDO2'
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
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeEntSai: TDBEditFocus
      Tag = 99
      Left = 303
      Top = 28
      Width = 27
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_ENTSAI'
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
      OnChange = dbeEntSaiChange
      OnExit = dbeEntSaiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTip_Fc: TDBEditFocus
      Tag = 99
      Left = 145
      Top = 28
      Width = 27
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_TIP_FC'
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
      OnChange = dbeTip_FcChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForCli: TDBEditFocus
      Tag = 99
      Left = 145
      Top = 52
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_FORCLI'
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
      OnKeyPress = dbeForCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDtaDoc: TDBEditFocus
      Tag = 99
      Left = 188
      Top = 131
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_DTADOC'
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
    object dbeDtaEnt: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 130
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_DTAENT'
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
      OnExit = dbeDtaEntExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEspDoc: TDBEditFocus
      Tag = 99
      Left = 379
      Top = 5
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_ESPDOC'
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
      OnExit = dbeEspDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNfComp: TDBEditFocus
      Tag = 99
      Left = 379
      Top = 28
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_SERIE_'
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
    object edtNomFor: TEditFocus
      Left = 231
      Top = 52
      Width = 293
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
    object edtCidade: TEditFocus
      Left = 66
      Top = 107
      Width = 187
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
    object edtNumCep: TEditFocus
      Left = 373
      Top = 107
      Width = 65
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
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 485
      Top = 4
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_CODEMP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmp: TEditFocus
      Left = 529
      Top = 4
      Width = 199
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeChaveAcesso: TDBEditFocus
      Tag = 99
      Left = 735
      Top = 107
      Width = 280
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_ACESSO'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 18
      OnExit = dbeChaveAcessoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkCNHREC: TDBCheckBox
      Left = 735
      Top = 154
      Width = 191
      Height = 21
      Caption = 'Canhoto NF j'#225' foi recebido'
      DataField = 'FIS_CNHREC'
      DataSource = dtsTabela
      TabOrder = 23
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      Visible = False
      WordWrap = True
    end
    object dbeNfComple: TDBEditFocus
      Tag = 99
      Left = 615
      Top = 28
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_NFCOMP'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      OnChange = dbeNfCompleChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object edtEstado: TEditFocus
      Left = 306
      Top = 107
      Width = 38
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 27
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNfCstEnt: TDBEditFocus
      Tag = 99
      Left = 834
      Top = 28
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_CSTENT'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtCgcCpf: TMaskEdit
      Tag = 99
      Left = 559
      Top = 52
      Width = 169
      Height = 22
      Color = 16768952
      Enabled = False
      TabOrder = 13
      Text = ''
    end
    object dbeSubSerie: TDBEditFocus
      Tag = 99
      Left = 486
      Top = 28
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_SUBSER'
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
    object dbeCTComVen: TDBEditFocus
      Tag = 99
      Left = 846
      Top = 4
      Width = 27
      Height = 22
      Hint = 'Informar se o Conhecimento '#233' de Venda ou de Compra'
      CharCase = ecUpperCase
      DataField = 'FIS_VENCOM'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProtoc: TDBEditFocus
      Tag = 99
      Left = 553
      Top = 106
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_PROTOC'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbxCodMod: TComboBoxFocus
      Tag = 99
      Left = 735
      Top = 176
      Width = 280
      Height = 22
      Style = csDropDownList
      Enabled = False
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object GroupBox13: TGroupBox
      Left = 4
      Top = 153
      Width = 453
      Height = 44
      Caption = 'Endere'#231'o de Entrega'
      TabOrder = 28
      object Label26: TLabel
        Left = 23
        Top = 21
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label29: TLabel
        Left = 263
        Top = 21
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
      end
      object Label110: TLabel
        Left = 345
        Top = 21
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CEP:'
      end
      object edtCidadeEnt: TEditFocus
        Left = 62
        Top = 18
        Width = 187
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtEstadoEnt: TEditFocus
        Left = 302
        Top = 18
        Width = 38
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
      object edtCEPEnt: TEditFocus
        Left = 369
        Top = 18
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object edtVenda: TEditFocus
      Left = 768
      Top = 52
      Width = 105
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
    object rgpTipoLancamentoCTE: TRadioGroup
      Left = 460
      Top = 158
      Width = 231
      Height = 44
      Caption = 'Tipo de Lan'#231'amento CTE'
      Columns = 2
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Manual'
        'Importado XML')
      TabOrder = 22
    end
    object dbeDataNFCeOffline: TDBEditFocus
      Tag = 99
      Left = 560
      Top = 130
      Width = 65
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'FIS_DTAOFF'
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
      ReadOnly = True
      TabOrder = 29
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeChaveNFCeOffline: TDBEditFocus
      Tag = 99
      Left = 735
      Top = 130
      Width = 280
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'FIS_ACEOFF'
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
      ReadOnly = True
      TabOrder = 30
      Visible = False
      OnExit = dbeChaveAcessoExit
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkDocumentoConferido: TDBCheckBox
      Left = 879
      Top = 53
      Width = 186
      Height = 17
      Caption = 'Documento j'#225' conferido'
      DataField = 'FIS_CONFER'
      DataSource = dtsTabela
      TabOrder = 15
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = chkDocumentoConferidoClick
    end
    object dbmHistor: TDBMemoFocus
      Tag = 99
      Left = 306
      Top = 131
      Width = 192
      Height = 23
      Hint = '[Duplo Clique] para ver o Hist'#243'rico completo'
      DataField = 'FIS_HISTOR'
      DataSource = dtsTabela
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnExit = dbmHistorExit
      OnKeyPress = dbmHistorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtPerfCli: TEditFocus
      Left = 145
      Top = 77
      Width = 379
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 31
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumDPS: TDBEditFocus
      Tag = 99
      Left = 596
      Top = 77
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_NUMDPS'
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
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeSerDPS: TDBEditFocus
      Tag = 99
      Left = 744
      Top = 77
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FIS_SERDPS'
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
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pgcDetalhes: TPageControl [4]
    Left = 0
    Top = 237
    Width = 1176
    Height = 457
    ActivePage = tbsDocs
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    OnChange = pgcDetalhesChange
    object tbsDocs: TTabSheet
      Caption = 'Dados Gerais'
      object pnlDadosGeraisCtnComum: TPanel
        Left = 0
        Top = 0
        Width = 1168
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label16: TLabel
          Left = 125
          Top = 38
          Width = 55
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Base ICMS:'
        end
        object Label9: TLabel
          Left = 111
          Top = 21
          Width = 69
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Cont'#225'bil:'
        end
        object Label8: TLabel
          Left = 81
          Top = 4
          Width = 99
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Classifica'#231#227'o Fiscal:'
        end
        object Label20: TLabel
          Left = 142
          Top = 106
          Width = 38
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Isentas:'
        end
        object Label19: TLabel
          Left = 144
          Top = 89
          Width = 36
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Outras:'
        end
        object Label18: TLabel
          Left = 125
          Top = 72
          Width = 55
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor ICMS:'
        end
        object Label17: TLabel
          Left = 108
          Top = 55
          Width = 72
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Al'#237'quota. ICMS:'
        end
        object Label2: TLabel
          Left = 809
          Top = 1
          Width = 28
          Height = 17
          AutoSize = False
          Caption = 'Totais'
        end
        object dbeClfSc1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 1
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_CLFSC1'
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
          OnChange = dbeClfSc1Change
          OnExit = dbeClfSc1Exit
          OnKeyPress = dbeClfSc5KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeClfSc1ChamaCadastro
        end
        object dbeClfSc2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 1
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_CLFSC2'
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
          OnKeyPress = dbeClfSc5KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeClfSc1ChamaCadastro
        end
        object dbeClfSc3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 1
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_CLFSC3'
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
          OnKeyPress = dbeClfSc5KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeClfSc1ChamaCadastro
        end
        object dbeClfSc4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 1
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_CLFSC4'
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
          OnKeyPress = dbeClfSc5KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeClfSc1ChamaCadastro
        end
        object dbeClfSc5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 1
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_CLFSC5'
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
          OnKeyPress = dbeClfSc5KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeClfSc1ChamaCadastro
        end
        object dbeVlCon1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 18
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCON1'
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
          OnExit = dbeVlCon1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlCon2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 18
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCON2'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlCon3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 18
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCON3'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlCon4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 18
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCON4'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlCon5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 18
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCON5'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBasIc1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 35
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASIC1'
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
          OnExit = dbeBasIc1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBasIc2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 35
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASIC2'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBasIc3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 35
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASIC3'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 13
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBasIc4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 35
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASIC4'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 14
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBasIc5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 35
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASIC5'
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
          OnExit = dbeVlCon2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqIc1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 52
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ALQIC1'
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
          OnEnter = dbeAlqIc1Enter
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqIc2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 52
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ALQIC2'
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
          OnEnter = dbeAlqIc2Enter
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqIc3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 52
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ALQIC3'
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
          OnEnter = dbeAlqIc3Enter
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqIc4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 52
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ALQIC4'
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
          OnEnter = dbeAlqIc4Enter
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqIc5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 52
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ALQIC5'
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
          OnEnter = dbeAlqIc5Enter
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlrIc1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 69
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIC1'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlrIc2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 69
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIC2'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlrIc3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 69
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIC3'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlrIc4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 69
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIC4'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlrIc5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 69
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIC5'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOutra1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 86
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_OUTRA1'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOutra2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 86
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_OUTRA2'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOutra3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 86
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_OUTRA3'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOutra4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 86
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_OUTRA4'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOutra5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 86
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_OUTRA5'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIsent1: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 103
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ISENT1'
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
          OnExit = dbeIsent1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIsent2: TDBEditFocus
          Tag = 99
          Left = 304
          Top = 103
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ISENT2'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIsent3: TDBEditFocus
          Tag = 99
          Left = 425
          Top = 103
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ISENT3'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIsent4: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 103
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ISENT4'
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
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIsent5: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 103
          Width = 84
          Height = 17
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'FIS_ISENT5'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 34
          OnExit = dbeAlqIc5Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtVlrConTot: TEditFocus
          Left = 785
          Top = 18
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 35
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBasIcmTot: TEditFocus
          Left = 785
          Top = 35
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 36
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVlrIcmTot: TEditFocus
          Left = 784
          Top = 69
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 37
          OnChange = edtVlrIcmTotChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtOutrasTot: TEditFocus
          Left = 785
          Top = 86
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 38
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtIsentaTot: TEditFocus
          Left = 784
          Top = 103
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 39
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlCtnICMSSubst: TPanel
        Left = 0
        Top = 120
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object pnlBaseCMSSubst: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label21: TLabel
            Left = 91
            Top = 4
            Width = 89
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base ICMS Subst.:'
          end
          object dbeBcret1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCRET1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBcret2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCRET2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBcret3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCRET3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBcret4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCRET4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBcret5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCRET5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBCRETTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlvalorCMSSubst: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Label22: TLabel
            Left = 91
            Top = 4
            Width = 89
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor ICMS Subst.:'
          end
          object dbeRetid1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_RETID1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRetid2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_RETID2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRetid3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_RETID3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRetid4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_RETID4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRetid5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_RETID5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtRetidTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnICMSAntecipado: TPanel
        Left = 0
        Top = 156
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object pnlBaseCMSAntecipado: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label59: TLabel
            Left = 68
            Top = 4
            Width = 112
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base ICMS Antecipado:'
          end
          object dbeBasAn1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASAN1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasAn2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASAN2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasAn3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASAN3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasAn4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASAN4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasAn5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASAN5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBasAntTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorCMSAntecipado: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label60: TLabel
            Left = 68
            Top = 4
            Width = 112
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor ICMS Antecipado:'
          end
          object dbeAntIc1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_ANTIC1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAntIc2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_ANTIC2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAntIc3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_ANTIC3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAntIc4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_ANTIC4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAntIc5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_ANTIC5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtAnticTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnIcmsStNaoCreditado: TPanel
        Left = 0
        Top = 192
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object pnlBaseIcmsStNaoCreditado: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label85: TLabel
            Left = 20
            Top = 4
            Width = 160
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base ICMS Subst. N'#227'o Creditado:'
          end
          object dbeBaeRe1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAERE1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeRe2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAERE2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeRe3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAERE3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeRe4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAERE4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeRe5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAERE5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBaeRetTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorIcmsStNaoCreditado: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label84: TLabel
            Left = 20
            Top = 4
            Width = 160
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor ICMS Subst. N'#227'o Creditado:'
          end
          object DBEVAERET1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAERE1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAERET2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAERE2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAERET3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAERE3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAERET4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAERE4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAERET5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAERE5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVaeRetTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnIPI: TPanel
        Left = 0
        Top = 228
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        object pnlBaseIPI: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label24: TLabel
            Left = 139
            Top = 4
            Width = 41
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base IPI:'
          end
          object dbeBasIp1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASIP1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasIp2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASIP2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasIp3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASIP3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasIp4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASIP4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBasIp5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BASIP5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBasIpiTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorIPI: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label25: TLabel
            Left = 139
            Top = 4
            Width = 41
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor IPI:'
          end
          object dbeVlrIp1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLRIP1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrIp2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLRIP2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrIp3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLRIP3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrIp4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLRIP4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrIp5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLRIP5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVlrIipiTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnIpiNaoCreditado: TPanel
        Left = 0
        Top = 264
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 5
        object pnlBaseIpiNaoCreditado: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label86: TLabel
            Left = 68
            Top = 4
            Width = 112
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base IPI N'#227'o Creditado:'
          end
          object dbeBaeIP1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAEIP1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeIP2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAEIP2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeIP3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAEIP3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeIP4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAEIP4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBaeIP5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAEIP5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBAEIPITot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorIpiNaoCreditado: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label83: TLabel
            Left = 68
            Top = 4
            Width = 112
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor IPI N'#227'o Creditado:'
          end
          object DBEVAEIPI1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAEIP1'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAEIPI2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAEIP2'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAEIPI3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAEIP3'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAEIPI4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAEIP4'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVAEIPI5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VAEIP5'
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVaeIPiTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnFCP: TPanel
        Left = 0
        Top = 300
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 6
        object pnlBaseFCP: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label43: TLabel
            Left = 21
            Top = 4
            Width = 158
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base Fundo Combate a Pobreza:'
          end
          object DBEBAFCP1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAFCP1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBAFCP2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAFCP2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBAFCP3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAFCP3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBAFCP4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAFCP4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBAFCP5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BAFCP5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBAFCPTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorFCP: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label109: TLabel
            Left = 21
            Top = 4
            Width = 158
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Fundo Combate a Pobreza:'
          end
          object DBEVLFCP1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLFCP1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLFCP2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLFCP2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLFCP3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLFCP3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLFCP4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLFCP4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLFCP5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLFCP5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVLFCPTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnFCPST: TPanel
        Left = 0
        Top = 336
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 7
        object pnlBaseFCPST: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label105: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base FCP ST:'
          end
          object DBEFCPST1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BFCPS1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEFCPST2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BFCPS2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEFCPST3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BFCPS3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEFCPST4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BFCPS4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEFCPST5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BFCPS5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtFCPSTTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorFCPST: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label104: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor FCP ST:'
          end
          object DBEVFCPS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VFCPS1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVFCPS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VFCPS2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVFCPS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VFCPS3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVFCPS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VFCPS4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVFCPS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VFCPS5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVfcPsTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlContainerReforma: TPanel
        Left = 0
        Top = 372
        Width = 1168
        Height = 108
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 8
        object pnlBaseCBS: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblBaseCBS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base CBS:'
          end
          object DBEBCCBS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCCBS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCCBS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCCBS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCCBS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCCBS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCCBS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCCBS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCCBS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCCBS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBCCBSTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorCBS: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lblValorCBS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor CBS:'
          end
          object DBEVLCBS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLCBS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLCBS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLCBS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLCBS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLCBS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLCBS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLCBS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLCBS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLCBS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVLCBSTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlBaseIBS: TPanel
          Left = 0
          Top = 36
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object lblBaseIBS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base IBS:'
          end
          object DBEBCIBS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCIBS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCIBS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCIBS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCIBS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCIBS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCIBS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCIBS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBCIBS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BCIBS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBCIBSTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorIBS: TPanel
          Left = 0
          Top = 54
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object lblValorIBS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor IBS:'
          end
          object DBEVLIBS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLIBS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLIBS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLIBS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLIBS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLIBS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLIBS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLIBS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVLIBS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VLIBS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVLIBSTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlBaseIS: TPanel
          Left = 0
          Top = 72
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object lblBaseIS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Base IS:'
          end
          object DBEBC_IS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BC_IS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBC_IS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BC_IS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBC_IS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BC_IS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBC_IS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BC_IS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEBC_IS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_BC_IS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtBC_ISTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorIS: TPanel
          Left = 0
          Top = 90
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 5
          object lblValorIS: TLabel
            Left = 114
            Top = 4
            Width = 65
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor IS:'
          end
          object DBEVL_IS1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VL_IS1'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVL_IS2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VL_IS2'
            DataSource = dtsAuxFis
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
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVL_IS3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VL_IS3'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVL_IS4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VL_IS4'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVL_IS5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VL_IS5'
            DataSource = dtsAuxFis
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtVL_ISTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlCtnQtdMono: TPanel
        Left = 0
        Top = 480
        Width = 1168
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 9
        object pnlBaseQtdMono: TPanel
          Left = 0
          Top = 0
          Width = 1168
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label116: TLabel
            Left = -3
            Top = 4
            Width = 182
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Quantidade tributada o monof'#225'sica:'
          end
          object DBEQBCMO1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_QBCMO1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEQBCMO2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_QBCMO2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEQBCMO3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_QBCMO3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEQBCMO4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_QBCMO4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEQBCMO5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_QBCMO5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtQtdMonTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValorQtdMono: TPanel
          Left = 0
          Top = 18
          Width = 1168
          Height = 18
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label115: TLabel
            Left = 0
            Top = 4
            Width = 179
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor monof'#225'sica:'
          end
          object DBEVALMO1: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VALMO1'
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
            TabOrder = 0
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVALMO2: TDBEditFocus
            Tag = 99
            Left = 304
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VALMO2'
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
            TabOrder = 1
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVALMO3: TDBEditFocus
            Tag = 99
            Left = 425
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VALMO3'
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
            TabOrder = 2
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVALMO4: TDBEditFocus
            Tag = 99
            Left = 546
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VALMO4'
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
            TabOrder = 3
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEVALMO5: TDBEditFocus
            Tag = 99
            Left = 667
            Top = 1
            Width = 84
            Height = 17
            AutoSize = False
            CharCase = ecUpperCase
            DataField = 'FIS_VALMO5'
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
            TabOrder = 4
            OnExit = dbeAlqIc5Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtValMonTot: TEditFocus
            Left = 784
            Top = 0
            Width = 84
            Height = 17
            TabStop = False
            Alignment = taRightJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlValorLiquido: TPanel
        Left = 0
        Top = 516
        Width = 1168
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 10
        object Label69: TLabel
          Left = 116
          Top = 4
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor L'#237'quido:'
        end
        object edtVlrLiqTot: TEditFocus
          Left = 784
          Top = 0
          Width = 84
          Height = 17
          TabStop = False
          Alignment = taRightJustify
          AutoSize = False
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object DBEVLLIQ1: TEditFocus
          Left = 186
          Top = 0
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object DBEVLLIQ2: TEditFocus
          Left = 304
          Top = 0
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object DBEVLLIQ3: TEditFocus
          Left = 425
          Top = 0
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object DBEVLLIQ4: TEditFocus
          Left = 546
          Top = 0
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
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
        object DBEVLLIQ5: TEditFocus
          Left = 667
          Top = 0
          Width = 84
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsPessoasCTE: TTabSheet
      Caption = 'Pessoas CTE'
      ImageIndex = 9
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlContainerPessoas: TPanel
        Left = 0
        Top = 0
        Width = 1168
        Height = 425
        Align = alClient
        TabOrder = 0
      end
    end
    object tbsServico: TTabSheet
      Caption = 'Servi'#231'o'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tbsImpostos: TTabSheet
      Caption = 'Impostos'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object chkNfExtemporanea: TCheckBox
        Left = 0
        Top = 286
        Width = 1168
        Height = 22
        Align = alTop
        Caption = 'Nota fiscal extempor'#226'nea'
        TabOrder = 0
      end
      object grpEnergiaEletrica: TGroupBox
        Left = 0
        Top = 170
        Width = 1168
        Height = 69
        Align = alTop
        Caption = 'Energia El'#233'trica'
        TabOrder = 1
        object lblCodigoClasseConsumoEnergiaEletrica: TLabel
          Left = 11
          Top = 20
          Width = 195
          Height = 14
          Caption = 'C'#243'digo classe consumo energia el'#233'trica:'
          Visible = False
        end
        object lblCodGrupTensao: TLabel
          Left = 75
          Top = 44
          Width = 136
          Height = 14
          Caption = 'C'#243'digo de grupo de tens'#227'o: '
          Visible = False
        end
        object cmbCodClaConEnergiaEletrica: TComboBoxFocus
          Tag = 99
          Left = 211
          Top = 15
          Width = 275
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          Visible = False
          Items.Strings = (
            '01-Comercial'
            '02-Consumo pr'#243'prio'
            '03-Ilumina'#231#227'o p'#250'blica'
            '04-Industrial'
            '05-Poder p'#250'blico'
            '06-Residencial'
            '07-Rural'
            '08-Servi'#231'o p'#250'blico')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cmbCodGrupTensao: TComboBoxFocus
          Tag = 99
          Left = 211
          Top = 39
          Width = 275
          Height = 22
          Style = csDropDownList
          TabOrder = 1
          Visible = False
          Items.Strings = (
            '01 - A1 - Alta Tens'#227'o (230kV ou mais)'
            '02 - A2 - Alta Tens'#227'o (88 a 138kV)'
            '03 - A3 - Alta Tens'#227'o (69kV)'
            '04 - A3a - Alta Tens'#227'o (30kV a 44kV)'
            '05 - A4 - Alta Tens'#227'o (2,3kV a 25kV)'
            '06 - AS - Alta Tens'#227'o Subterr'#226'neo 06'
            '07 - B1 - Residencial 07'
            '08 - B1 - Residencial Baixa Renda 08'
            '09 - B2 - Rural 09'
            '10 - B2 - Cooperativa de Eletrifica'#231#227'o Rural'
            '11 - B2 - Servi'#231'o P'#250'blico de Irriga'#231#227'o'
            '12 - B3 - Demais Classes'
            '13 - B4a - Ilumina'#231#227'o P'#250'blica - rede de distribui'#231#227'o'
            '14 - B4b - Ilumina'#231#227'o P'#250'blica - bulbo de l'#226'mpada')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object GroupBox14: TGroupBox
        Left = 0
        Top = 0
        Width = 1168
        Height = 65
        Align = alTop
        Caption = 'PIS/COFINS'
        TabOrder = 2
        object LabelBasePis: TLabel
          Left = 190
          Top = 19
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Base PIS:'
        end
        object Label27: TLabel
          Left = 345
          Top = 19
          Width = 37
          Height = 14
          Alignment = taRightJustify
          Caption = 'Alq.PIS:'
        end
        object Label28: TLabel
          Left = 453
          Top = 18
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total PIS:'
        end
        object LabelBaseCofins: TLabel
          Left = 168
          Top = 42
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Base COFINS:'
        end
        object Label30: TLabel
          Left = 323
          Top = 42
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Alq.COFINS:'
        end
        object Label31: TLabel
          Left = 431
          Top = 42
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total COFINS:'
        end
        object Label46: TLabel
          Left = 609
          Top = 21
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nat. Rec. PIS:'
        end
        object Label47: TLabel
          Left = 587
          Top = 45
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nat. Rec. COFINS:'
        end
        object LabelCstCofins: TLabel
          Left = 68
          Top = 45
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'CST COFINS:'
        end
        object LabelCstPis: TLabel
          Left = 90
          Top = 21
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'CST PIS:'
        end
        object dbeBasPis: TDBEditFocus
          Tag = 99
          Left = 237
          Top = 15
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_BASPIS'
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
          OnExit = dbeBasPisExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeTotPis: TDBEditFocus
          Left = 498
          Top = 15
          Width = 83
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'FIS_TOTPIS'
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
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeBasCof: TDBEditFocus
          Tag = 99
          Left = 237
          Top = 38
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_BASCOF'
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
          OnExit = dbeBasCofExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeTotCof: TDBEditFocus
          Left = 498
          Top = 38
          Width = 83
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'FIS_TOTCOF'
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
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeAlqPis: TDBEditFocus
          Tag = 99
          Left = 384
          Top = 15
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_ALQPIS'
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
          OnExit = dbeBasPisExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeAlqCof: TDBEditFocus
          Tag = 99
          Left = 384
          Top = 38
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_ALQCOF'
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
          OnExit = dbeBasCofExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeNatRecCof: TDBEditFocus
          Tag = 99
          Left = 675
          Top = 39
          Width = 53
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_NR_COF'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeNatRecPis: TDBEditFocus
          Tag = 99
          Left = 675
          Top = 15
          Width = 53
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_NR_PIS'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeCstCof: TDBEditFocus
          Tag = 99
          Left = 136
          Top = 39
          Width = 26
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_CSTCOF'
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
          OnKeyPress = dbeCstCofKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeCstPis: TDBEditFocus
          Tag = 99
          Left = 136
          Top = 15
          Width = 26
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_CSTPIS'
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
          OnKeyPress = dbeCstPisKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object btnAtualizaCstAliquotaProdutos: TBitBtnLocked
          Left = 734
          Top = 38
          Width = 249
          Height = 23
          Hint = 'Atualizar CST e Al'#237'quota em todos os produtos'
          Caption = 'Atualizar CST e Al'#237'quota em todos os produtos'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = btnAtualizaCstAliquotaProdutosClick
        end
      end
      object grpCupomFiscal: TGroupBox
        Left = 0
        Top = 98
        Width = 1168
        Height = 72
        Align = alTop
        Caption = 'Cupom Fiscal'
        TabOrder = 3
        object lblNumSer: TLabel
          Left = 19
          Top = 26
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero S'#233'rie:'
        end
        object lblNumCoo: TLabel
          Left = 301
          Top = 26
          Width = 26
          Height = 14
          Alignment = taRightJustify
          Caption = 'COO:'
        end
        object lblCodCon: TLabel
          Left = 162
          Top = 49
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Cont'#225'bil:'
          Visible = False
        end
        object dbeNumSer: TDBEditFocus
          Tag = 99
          Left = 92
          Top = 22
          Width = 201
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_NUMSER'
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
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumCoo: TDBEditFocus
          Tag = 99
          Left = 332
          Top = 22
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_NUMCOO'
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
        object dbeCodCon: TDBEditFocus
          Tag = 99
          Left = 228
          Top = 45
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_CODCON'
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
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
      end
      object grpRetencaoFuntural: TGroupBox
        Left = 0
        Top = 239
        Width = 1168
        Height = 47
        Align = alTop
        Caption = 'Reten'#231#227'o Funrural'
        TabOrder = 4
        object Label23x: TLabel
          Left = 105
          Top = 20
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Base:'
        end
        object Label44: TLabel
          Left = 225
          Top = 20
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = '% Al'#237'quota:'
        end
        object Label67: TLabel
          Left = 333
          Top = 19
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total Funrural:'
        end
        object dbeBasFun: TDBEditFocus
          Tag = 99
          Left = 134
          Top = 16
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_RFRBAS'
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
          OnExit = dbeBasPisExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeTotFun: TDBEditFocus
          Left = 431
          Top = 16
          Width = 83
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'FIS_RFRVAL'
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
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeAlqFun: TDBEditFocus
          Tag = 99
          Left = 281
          Top = 16
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_RFRALQ'
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
          OnExit = dbeBasPisExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object gbxBaseFrete: TGroupBox
        Left = 0
        Top = 65
        Width = 1168
        Height = 33
        Align = alTop
        TabOrder = 5
        object lblCFOP: TLabel
          Left = 69
          Top = 10
          Width = 167
          Height = 14
          Caption = 'C'#243'digo da Base de C'#225'lculo - Frete:'
        end
        object edtDesBasFre: TEditFocus
          Left = 294
          Top = 7
          Width = 689
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeBasFre: TDBEditFocus
          Tag = 99
          Left = 237
          Top = 7
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FIS_CODBFR'
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
          OnKeyPress = dbeBasFreKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsItens: TTabSheet
      Caption = 'Itens Documento'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlItens: TPanel
        Left = 0
        Top = 17
        Width = 1168
        Height = 408
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label117: TLabel
          Left = 1017
          Top = 79
          Width = 59
          Height = 14
          Caption = 'Valor GNRE:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object btnMemCalcGNRE: TSpeedButton
          Left = 1080
          Top = 95
          Width = 23
          Height = 21
          Hint = 'Memoria de C'#225'lculo'
          Enabled = False
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
            300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
            330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
            333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
            339977FF777777773377000BFB03333333337773FF733333333F333000333333
            3300333777333333337733333333333333003333333333333377333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnMemCalcGNREClick
        end
        object Panel1: TPanel
          Left = 2
          Top = 2
          Width = 1164
          Height = 69
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object GroupBox4: TGroupBox
            Left = 0
            Top = 0
            Width = 1164
            Height = 69
            Align = alClient
            Caption = 'C'#243'digos Fiscais'
            TabOrder = 0
            object Label32: TLabel
              Left = 40
              Top = 20
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd. Fiscal:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 471
              Top = 20
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Clas. Fiscal:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label66: TLabel
              Left = 4
              Top = 48
              Width = 90
              Height = 14
              Alignment = taRightJustify
              Caption = 'Abrevia'#231#227'o Fiscal:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label68: TLabel
              Left = 504
              Top = 46
              Width = 25
              Height = 14
              Alignment = taRightJustify
              Caption = 'NCM:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeCodFis: TEditFocus
              Tag = 99
              Left = 98
              Top = 16
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              OnChange = dbeCodFisChange
              OnEnter = dbeCodFisEnter
              OnExit = dbeCodFisExit
              OnKeyPress = dbeCodFisKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtDesCodFis: TEditFocus
              Left = 156
              Top = 16
              Width = 303
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
            object dbeClaFis: TEditFocus
              Tag = 99
              Left = 531
              Top = 16
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              OnChange = dbeClaFisChange
              OnEnter = dbeCodFisEnter
              OnExit = dbeClaFisExit
              OnKeyPress = dbeClaFisKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtDesAbf: TEditFocus
              Left = 98
              Top = 42
              Width = 361
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object dbeNcmIte: TEditFocus
              Tag = 99
              Left = 531
              Top = 42
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 4
              OnKeyPress = dbeNcmIteKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtDesNcm: TEditFocus
              Left = 589
              Top = 42
              Width = 391
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
            object cmbNatOpeItem: TComboBoxFocus
              Tag = 99
              Left = 589
              Top = 16
              Width = 391
              Height = 22
              Style = csDropDownList
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 72
          Width = 1012
          Height = 330
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object lblRICMPR: TLabel
            AlignWithMargins = True
            Left = 20
            Top = 316
            Width = 464
            Height = 14
            Margins.Left = 20
            Align = alBottom
            Caption = 
              'Este produto possui redu'#231#227'o de 33,33% no valor do ICMS conforme ' +
              'decreto 5141/2001 RICM/PR'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object GroupBox7: TGroupBox
            Left = 581
            Top = 103
            Width = 275
            Height = 124
            Caption = 'IPI'
            TabOrder = 3
            object Label35: TLabel
              Left = 8
              Top = 28
              Width = 56
              Height = 14
              Caption = 'Base de IPI:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label37: TLabel
              Left = 32
              Top = 52
              Width = 32
              Height = 14
              Caption = 'Alq IPI:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label39: TLabel
              Left = 33
              Top = 75
              Width = 30
              Height = 14
              Caption = 'Vr. IPI:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label61: TLabel
              Left = 127
              Top = 28
              Width = 79
              Height = 14
              Caption = 'Base N'#227'o Cred.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label62: TLabel
              Left = 133
              Top = 51
              Width = 73
              Height = 14
              Caption = 'Alq. N'#227'o Cred.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label63: TLabel
              Left = 138
              Top = 75
              Width = 68
              Height = 14
              Caption = 'Vr. N'#227'o Cred.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label45: TLabel
              Left = 27
              Top = 99
              Width = 36
              Height = 14
              Caption = 'CST IPI:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeBasIPI: TEditFocus
              Tag = 99
              Left = 68
              Top = 24
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeAlqIPI: TEditFocus
              Tag = 99
              Left = 68
              Top = 48
              Width = 57
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeValipi: TEditFocus
              Tag = 99
              Left = 68
              Top = 72
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeBaeIPI: TEditFocus
              Tag = 99
              Left = 208
              Top = 24
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeAleIpi: TEditFocus
              Tag = 99
              Left = 208
              Top = 48
              Width = 57
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeVaeIpi: TEditFocus
              Tag = 99
              Left = 208
              Top = 72
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object dbeCSTIPI: TEditFocus
              Tag = 99
              Left = 68
              Top = 96
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ReadOnly = True
              TabOrder = 6
              OnKeyPress = dbeCSTIPIKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object GroupBox8: TGroupBox
            Left = 0
            Top = 227
            Width = 654
            Height = 74
            Caption = 'PIS/COFINS'
            TabOrder = 4
            object Label57: TLabel
              Left = 25
              Top = 22
              Width = 41
              Height = 14
              Caption = 'CST PIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label48: TLabel
              Left = 135
              Top = 21
              Width = 46
              Height = 14
              Caption = 'Base PIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label50: TLabel
              Left = 258
              Top = 21
              Width = 40
              Height = 14
              Caption = 'Alq. PIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label52: TLabel
              Left = 371
              Top = 22
              Width = 39
              Height = 14
              Caption = 'Val. PIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label56: TLabel
              Left = 19
              Top = 50
              Width = 47
              Height = 14
              Caption = 'CST COF:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label55: TLabel
              Left = 134
              Top = 49
              Width = 52
              Height = 14
              Caption = 'Base COF:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label53: TLabel
              Left = 256
              Top = 50
              Width = 46
              Height = 14
              Caption = 'Alq. COF:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label51: TLabel
              Left = 371
              Top = 50
              Width = 45
              Height = 14
              Caption = 'Val. COF:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label54: TLabel
              Left = 486
              Top = 21
              Width = 56
              Height = 14
              Caption = 'N. Rec. PIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label49: TLabel
              Left = 485
              Top = 49
              Width = 62
              Height = 14
              Caption = 'N. Rec. COF:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtIteCstPis: TEditFocus
              Tag = 99
              Left = 71
              Top = 18
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ReadOnly = True
              TabOrder = 0
              OnKeyPress = edtIteCstPisKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtIteBasPis: TEditFocus
              Tag = 99
              Left = 191
              Top = 18
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteAlqPis: TEditFocus
              Tag = 99
              Left = 307
              Top = 18
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteValPis: TEditFocus
              Tag = 99
              Left = 421
              Top = 18
              Width = 57
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteCstCof: TEditFocus
              Tag = 99
              Left = 71
              Top = 46
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ReadOnly = True
              TabOrder = 5
              OnKeyPress = edtIteCstCofKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtIteBasCof: TEditFocus
              Tag = 99
              Left = 191
              Top = 46
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteAlqCof: TEditFocus
              Tag = 99
              Left = 307
              Top = 46
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteValCof: TEditFocus
              Tag = 99
              Left = 421
              Top = 46
              Width = 57
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtIteNatRecPis: TEditFocus
              Tag = 99
              Left = 550
              Top = 18
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtIteNatRecCof: TEditFocus
              Tag = 99
              Left = 550
              Top = 46
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              ReadOnly = True
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object btnConfirmar: TBitBtnLocked
            Left = 912
            Top = 306
            Width = 89
            Height = 24
            Caption = '[ F10 ] Confirmar'
            TabOrder = 6
            OnClick = btnConfirmarClick
          end
          object dbeValFreItens: TEditFocus
            Tag = 99
            Left = 931
            Top = -62
            Width = 57
            Height = 22
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 7
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '###,##0.00'
          end
          object dbeValFre: TEditFocus
            Tag = 99
            Left = 931
            Top = -34
            Width = 57
            Height = 22
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 8
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '###,##0.00'
          end
          object dbeDesAce: TEditFocus
            Tag = 99
            Left = 931
            Top = -32
            Width = 57
            Height = 22
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 9
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '###,##0.00'
          end
          object grpDadosCat158: TGroupBox
            Left = 858
            Top = 4
            Width = 151
            Height = 149
            Caption = 'Dados Cat-158:'
            TabOrder = 5
            object Label90: TLabel
              Left = 19
              Top = 96
              Width = 43
              Height = 14
              Caption = 'Base ST:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label91: TLabel
              Left = 21
              Top = 119
              Width = 43
              Height = 14
              Caption = 'Valor ST:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label100: TLabel
              Left = 15
              Top = 25
              Width = 48
              Height = 14
              Caption = 'Base ICM:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label101: TLabel
              Left = 24
              Top = 47
              Width = 39
              Height = 14
              Caption = 'Alq ICM:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label102: TLabel
              Left = 28
              Top = 72
              Width = 36
              Height = 14
              Caption = 'Vl. ICM:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtBaseStCat158: TEditFocus
              Tag = 99
              Left = 65
              Top = 92
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtValorStCat158: TEditFocus
              Tag = 99
              Left = 65
              Top = 116
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtBaseIcmCat158: TEditFocus
              Tag = 99
              Left = 65
              Top = 20
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtAlqIcmCat158: TEditFocus
              Tag = 99
              Left = 65
              Top = 44
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtValorIcmCat158: TEditFocus
              Tag = 99
              Left = 65
              Top = 68
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
          end
          object GroupBox9: TGroupBox
            Left = 3
            Top = 103
            Width = 574
            Height = 125
            Caption = 'Fundo de Combate a Pobreza'
            TabOrder = 2
            object GroupBox5: TGroupBox
              Left = 14
              Top = 17
              Width = 396
              Height = 96
              Caption = ' FCP '
              TabOrder = 0
              object Label103: TLabel
                Left = 263
                Top = 22
                Width = 50
                Height = 14
                Caption = 'Base FCP:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
              end
              object Label74: TLabel
                Left = 277
                Top = 46
                Width = 35
                Height = 14
                Caption = '% FCP:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label75: TLabel
                Left = 269
                Top = 69
                Width = 43
                Height = 14
                Caption = 'Val. FCP:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label73: TLabel
                Left = 4
                Top = 70
                Width = 71
                Height = 14
                Caption = 'Base UF. Dest:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
              end
              object Label79: TLabel
                Left = 12
                Top = 46
                Width = 64
                Height = 14
                Caption = 'ICMS Origem:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
              end
              object Label80: TLabel
                Left = 10
                Top = 22
                Width = 66
                Height = 14
                Caption = 'ICMS Destino:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label76: TLabel
                Left = 141
                Top = 22
                Width = 58
                Height = 14
                Caption = 'Alq. Interna:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
              end
              object Label77: TLabel
                Left = 138
                Top = 46
                Width = 61
                Height = 14
                Caption = 'Alq. Interest:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label78: TLabel
                Left = 164
                Top = 69
                Width = 35
                Height = 14
                Caption = '% Part:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object edtBaseFCP: TEditFocus
                Tag = 99
                Left = 314
                Top = 18
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object edtPercFCP: TEditFocus
                Tag = 99
                Left = 314
                Top = 42
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 5
                OnExit = edtPercFCPExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtValorFCP: TEditFocus
                Tag = 99
                Left = 314
                Top = 66
                Width = 57
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 8
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtBaseUFDest: TEditFocus
                Tag = 99
                Left = 77
                Top = 66
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 6
                OnExit = edtBaseUFDestExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtICMSOrigem: TEditFocus
                Tag = 99
                Left = 77
                Top = 42
                Width = 57
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                ReadOnly = True
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object edtICMSDestino: TEditFocus
                Tag = 99
                Left = 77
                Top = 18
                Width = 57
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtAlqInterna: TEditFocus
                Tag = 99
                Left = 200
                Top = 18
                Width = 58
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                ReadOnly = True
                TabOrder = 1
                OnExit = edtAlqInternaExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object edtAlqInterestadual: TEditFocus
                Tag = 99
                Left = 200
                Top = 42
                Width = 58
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 4
                OnExit = edtAlqInterestadualExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtPercentualPartilha: TEditFocus
                Tag = 99
                Left = 200
                Top = 66
                Width = 58
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 7
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
            object GroupBox6: TGroupBox
              Left = 416
              Top = 16
              Width = 147
              Height = 97
              Caption = 'FCP ST'
              TabOrder = 1
              object Label106: TLabel
                Left = 7
                Top = 17
                Width = 65
                Height = 14
                Caption = 'Base FCP ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
              end
              object Label107: TLabel
                Left = 22
                Top = 40
                Width = 50
                Height = 14
                Caption = '% FCP ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label108: TLabel
                Left = 18
                Top = 64
                Width = 54
                Height = 14
                Caption = 'Vr. FCP ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object edtBFCPST: TEditFocus
                Tag = 99
                Left = 74
                Top = 13
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object edtPFCPST: TEditFocus
                Tag = 99
                Left = 74
                Top = 37
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 1
                OnExit = edtPFCPSTExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object edtVFCPST: TEditFocus
                Tag = 99
                Left = 74
                Top = 61
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
          end
          object GroupBox10: TGroupBox
            Left = 555
            Top = 3
            Width = 299
            Height = 97
            Caption = 'ICMS ST'
            TabOrder = 1
            object GroupBox12: TGroupBox
              Left = 7
              Top = 16
              Width = 147
              Height = 69
              Caption = 'ST N'#227'o Creditado'
              TabOrder = 0
              object Label65: TLabel
                Left = 28
                Top = 18
                Width = 28
                Height = 14
                Caption = 'Base:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label64: TLabel
                Left = 28
                Top = 42
                Width = 28
                Height = 14
                Caption = 'Valor:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object dbeBRetNC: TEditFocus
                Tag = 99
                Left = 58
                Top = 15
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeVRetNC: TEditFocus
                Tag = 99
                Left = 58
                Top = 39
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
            object GroupBox11: TGroupBox
              Left = 158
              Top = 15
              Width = 133
              Height = 69
              Caption = 'ST Creditado'
              TabOrder = 1
              object Label42: TLabel
                Left = 28
                Top = 20
                Width = 28
                Height = 14
                Caption = 'Base:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 28
                Top = 44
                Width = 28
                Height = 14
                Caption = 'Valor:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object dbeBasRet: TEditFocus
                Tag = 99
                Left = 59
                Top = 16
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeValRet: TEditFocus
                Tag = 99
                Left = 59
                Top = 40
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
          end
          object GroupBox1: TGroupBox
            Left = 3
            Top = 2
            Width = 546
            Height = 98
            Caption = 'ICMS'
            TabOrder = 0
            object GroupBox3: TGroupBox
              Left = 14
              Top = 16
              Width = 387
              Height = 69
              Caption = ' ICMS '
              TabOrder = 0
              object Label34: TLabel
                Left = 19
                Top = 17
                Width = 28
                Height = 14
                Caption = 'Base:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label36: TLabel
                Left = 116
                Top = 16
                Width = 42
                Height = 14
                Caption = 'Aliquota:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label38: TLabel
                Left = 263
                Top = 16
                Width = 28
                Height = 14
                Caption = 'Valor:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblOutIcm: TLabel
                Left = 10
                Top = 45
                Width = 36
                Height = 14
                Caption = 'Outras:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblIseIcm: TLabel
                Left = 116
                Top = 41
                Width = 38
                Height = 14
                Caption = 'Isentas:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label92: TLabel
                Left = 228
                Top = 44
                Width = 62
                Height = 14
                Caption = 'Desonerado:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object dbeBasIcm: TEditFocus
                Tag = 99
                Left = 49
                Top = 13
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeAlqIcm: TEditFocus
                Tag = 99
                Left = 160
                Top = 13
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeValIcm: TEditFocus
                Tag = 99
                Left = 296
                Top = 13
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeOutras: TEditFocus
                Tag = 99
                Left = 49
                Top = 41
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeIsenta: TEditFocus
                Tag = 99
                Left = 160
                Top = 41
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 4
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeVICMDe: TEditFocus
                Tag = 99
                Left = 296
                Top = 41
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 5
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
            object grpIcmsAnte: TGroupBox
              Left = 404
              Top = 17
              Width = 135
              Height = 69
              Caption = 'Antecipado'
              TabOrder = 1
              object lblBasAnt: TLabel
                Left = 25
                Top = 21
                Width = 28
                Height = 14
                Caption = 'Base:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblValAnt: TLabel
                Left = 25
                Top = 45
                Width = 28
                Height = 14
                Caption = 'Valor:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object dbeBasAnt: TEditFocus
                Tag = 99
                Left = 55
                Top = 17
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
              object dbeValAnt: TEditFocus
                Tag = 99
                Left = 55
                Top = 41
                Width = 57
                Height = 22
                Alignment = taRightJustify
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
                EditFormat = '###,##0.00'
              end
            end
          end
          object ckbReduzICMS: TCheckBox
            Left = 493
            Top = 313
            Width = 132
            Height = 17
            Caption = 'Reduzir valor de ICMS'
            TabOrder = 10
          end
          object gbxMonofasico: TGroupBox
            Left = 613
            Top = 227
            Width = 243
            Height = 69
            Caption = 'Monof'#225'sico'
            TabOrder = 11
            object Label112: TLabel
              Left = 5
              Top = 22
              Width = 96
              Height = 14
              Caption = 'Qtd.BC.Monof'#225'sico:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label113: TLabel
              Left = 6
              Top = 41
              Width = 34
              Height = 28
              Caption = 'Alq.ad rem:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object Label114: TLabel
              Left = 106
              Top = 38
              Width = 59
              Height = 28
              Caption = 'Vr.ICMS Monof'#225'sico:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object edtQBCMonoRet: TEditFocus
              Tag = 99
              Left = 107
              Top = 18
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtAdRemICMDRet: TEditFocus
              Tag = 99
              Left = 43
              Top = 43
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtVICMSMonoRet: TEditFocus
              Tag = 99
              Left = 178
              Top = 43
              Width = 57
              Height = 22
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
          end
          object gpbReforma: TGroupBox
            Left = 858
            Top = 153
            Width = 151
            Height = 153
            Caption = 'Reforma'
            TabOrder = 12
            object Label120: TLabel
              Left = 10
              Top = 15
              Width = 52
              Height = 14
              Caption = 'Base CBS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label121: TLabel
              Left = 10
              Top = 38
              Width = 52
              Height = 14
              Caption = 'Valor CBS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label122: TLabel
              Left = 15
              Top = 61
              Width = 47
              Height = 14
              Caption = 'Base IBS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label126: TLabel
              Left = 15
              Top = 84
              Width = 47
              Height = 14
              Caption = 'Valor IBS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label123: TLabel
              Left = 22
              Top = 107
              Width = 40
              Height = 14
              Caption = 'Base IS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label124: TLabel
              Left = 22
              Top = 130
              Width = 40
              Height = 14
              Caption = 'Valor IS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtBaseCbs: TEditFocus
              Left = 67
              Top = 12
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtValorCBS: TEditFocus
              Left = 67
              Top = 35
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtBaseIBS: TEditFocus
              Left = 67
              Top = 58
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtValorIBS: TEditFocus
              Left = 67
              Top = 81
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtBaseIS: TEditFocus
              Left = 67
              Top = 104
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
            object edtValorIS: TEditFocus
              Left = 67
              Top = 127
              Width = 78
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '###,##0.00'
            end
          end
        end
        object edtValGNRE: TEditFocus
          Tag = 99
          Left = 1018
          Top = 96
          Width = 57
          Height = 22
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '###,##0.00'
        end
      end
      object dbgItens: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1168
        Height = 17
        Align = alClient
        TabOrder = 0
        OnEnter = dbgItensEnter
        OnExit = dbgItensExit
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgItensDBTableViewCitel1: TcxGridDBTableViewCitel
          OnDblClick = dbgItensDBTableViewCitel1DblClick
          OnKeyDown = dbgItensDBTableViewCitel1KeyDown
          OnKeyUp = dbgItensDBTableViewCitel1KeyUp
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = dbgItensDBTableViewCitel1CellClick
          DataController.DataSource = dtsFisItens
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VLRCON_ITE
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1DESESP
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1TOTITE
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1TOTFRE_ITE
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1DESACE_ITE
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VAEIPI
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VAERET
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VALIPI
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VALRET
            end
            item
              Kind = skSum
              Column = dbgItensDBTableViewCitel1VFCPST
            end>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object dbgItensDBTableViewCitelSEQUENCIA: TcxGridDBColumn
            Caption = 'Sequ'#234'ncia'
            DataBinding.FieldName = 'NROITE'
          end
          object dbgItensDBTableViewCitel1CODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Width = 48
          end
          object dbgItensDBTableViewCitel1DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRI'
            Width = 176
          end
          object dbgItensDBTableViewCitelNCMITE: TcxGridDBColumn
            Caption = 'NCM'
            DataBinding.FieldName = 'NCMITE'
            Width = 70
          end
          object dbgItensDBTableViewCitelCST: TcxGridDBColumn
            Caption = 'CST'
            DataBinding.FieldName = 'CODFIS'
            Width = 26
          end
          object dbgItensDBTableViewCitelCFOP: TcxGridDBColumn
            Caption = 'CFOP'
            DataBinding.FieldName = 'CLAFIS'
            Width = 33
          end
          object dbgItensDBTableViewCitel1Column1: TcxGridDBColumn
            Caption = 'Un.'
            DataBinding.FieldName = 'UNIDAD'
            Width = 31
          end
          object dbgItensDBTableViewCitel1QTDITE: TcxGridDBColumn
            Caption = 'Qtde'
            DataBinding.FieldName = 'QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1UNITAR: TcxGridDBColumn
            Caption = 'Vr. Unitario'
            DataBinding.FieldName = 'UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1TOTITE: TcxGridDBColumn
            Caption = 'Vr. Total'
            DataBinding.FieldName = 'TOTITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1DESESP: TcxGridDBColumn
            Caption = 'Des. Esp'
            DataBinding.FieldName = 'DESESP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1TOTFRE_ITE: TcxGridDBColumn
            Caption = 'Vr. Frete'
            DataBinding.FieldName = 'TOTFRE_ITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1DESACE_ITE: TcxGridDBColumn
            Caption = 'Vr. Desp. Acessorias'
            DataBinding.FieldName = 'DESACE_ITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 114
          end
          object dbgItensDBTableViewCitel1VALIPI: TcxGridDBColumn
            Caption = 'Vr. IPI Cred.'
            DataBinding.FieldName = 'VALIPI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1VAEIPI: TcxGridDBColumn
            Caption = 'Vr. IPI N Cred.'
            DataBinding.FieldName = 'VAEIPI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 79
          end
          object dbgItensDBTableViewCitel1VALRET: TcxGridDBColumn
            Caption = 'Vr. Str Cred.'
            DataBinding.FieldName = 'VALRET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 77
          end
          object dbgItensDBTableViewCitel1VAERET: TcxGridDBColumn
            Caption = 'Vr. ST N Cred.'
            DataBinding.FieldName = 'VAERET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 88
          end
          object dbgItensDBTableViewCitel1VFCPST: TcxGridDBColumn
            DataBinding.FieldName = 'VFCPST'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1VLRCON_ITE: TcxGridDBColumn
            Caption = 'Vr. Contabil'
            DataBinding.FieldName = 'VLRCON_ITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
          end
          object dbgItensDBTableViewCitel1CODFAB: TcxGridDBColumn
            Caption = 'C'#243'd. Fabricante(NF)'
            DataBinding.FieldName = 'CODFAB'
            Width = 120
          end
          object dbgItensDBTableViewCitel1DESCMAR: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'DESMAR'
          end
          object dbgItensDBTableViewCitel1CODFAB2: TcxGridDBColumn
            Caption = 'Cod. Fabricante Cadastro'
            DataBinding.FieldName = 'CODFAB2'
          end
        end
        object dbgItensLevel1: TcxGridLevel
          GridView = dbgItensDBTableViewCitel1
        end
      end
    end
    object pgcAjustes: TTabSheet
      Caption = 'Outras obriga'#231#245'es e Ajustes (SPED FISCAL)'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblCodAju: TLabel
        Left = 13
        Top = 7
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo do Ajuste:'
      end
      object lblDesAju: TLabel
        Left = 99
        Top = 7
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object lblBasIcm: TLabel
        Left = 459
        Top = 7
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base ICMS:'
      end
      object lblAlqIcm: TLabel
        Left = 539
        Top = 7
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota ICMS:'
      end
      object lblValIcm: TLabel
        Left = 621
        Top = 7
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor ICMS:'
      end
      object lblOutros: TLabel
        Left = 698
        Top = 7
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outros:'
      end
      object dbgrFisAju: TDBGridCitel
        Left = 11
        Top = 52
        Width = 864
        Height = 224
        DataSource = dtsFisAju
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'AJU_CD_AJU'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AJU_DESAJU'
            Title.Caption = 'Descri'#231#227'o'
            Width = 365
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AJU_BASICM'
            Title.Caption = 'Base ICMS'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AJU_ALQICM'
            Title.Caption = 'Al'#237'quota ICMS'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AJU_VALICM'
            Title.Caption = 'Valor ICMS'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AJU_OUTROS'
            Title.Caption = 'Outros'
            Width = 79
            Visible = True
          end>
      end
      object btnIncluirFisAju: TBitBtnLocked
        Left = 15
        Top = 279
        Width = 72
        Height = 20
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
        TabOrder = 1
        OnClick = btnIncluirFisAjuClick
      end
      object btnGravarFisAju: TBitBtnLocked
        Left = 89
        Top = 279
        Width = 72
        Height = 20
        Caption = '&Gravar'
        Enabled = False
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
        TabOrder = 2
        OnClick = btnGravarFisAjuClick
      end
      object btnAlterarFisAju: TBitBtnLocked
        Left = 164
        Top = 279
        Width = 72
        Height = 20
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
        TabOrder = 3
        OnClick = btnAlterarFisAjuClick
      end
      object btnExcluirFisAju: TBitBtnLocked
        Left = 238
        Top = 279
        Width = 72
        Height = 20
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
        TabOrder = 4
        OnClick = btnExcluirFisAjuClick
      end
      object btnCancelarFisAju: TBitBtnLocked
        Left = 312
        Top = 279
        Width = 72
        Height = 20
        Caption = '&Cancelar'
        Enabled = False
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
        TabOrder = 5
        OnClick = btnCancelarFisAjuClick
      end
      object edtCodAju: TDBEditFocus
        Tag = 99
        Left = 15
        Top = 22
        Width = 82
        Height = 22
        CharCase = ecUpperCase
        DataField = 'AJU_CD_AJU'
        DataSource = dtsFisAju
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        OnExit = edtCodAjuExit
        OnKeyPress = edtCodAjuKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtBasIcm: TDBEditFocus
        Tag = 99
        Left = 459
        Top = 22
        Width = 77
        Height = 22
        CharCase = ecUpperCase
        DataField = 'AJU_BASICM'
        DataSource = dtsFisAju
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        OnExit = edtBasIcmExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtAlqIcm: TDBEditFocus
        Tag = 99
        Left = 539
        Top = 22
        Width = 77
        Height = 22
        CharCase = ecUpperCase
        DataField = 'AJU_ALQICM'
        DataSource = dtsFisAju
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        OnExit = edtAlqIcmExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtValIcm: TDBEditFocus
        Tag = 99
        Left = 619
        Top = 22
        Width = 77
        Height = 22
        CharCase = ecUpperCase
        DataField = 'AJU_VALICM'
        DataSource = dtsFisAju
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 9
        OnEnter = edtValIcmEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtOutros: TDBEditFocus
        Tag = 99
        Left = 698
        Top = 22
        Width = 77
        Height = 22
        CharCase = ecUpperCase
        DataField = 'AJU_OUTROS'
        DataSource = dtsFisAju
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        OnExit = edtOutrosExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnDifal: TBitBtnLocked
        Left = 685
        Top = 279
        Width = 150
        Height = 20
        Caption = 'DIFAL - SPED'
        TabOrder = 11
        Visible = False
        OnClick = btnDifalClick
      end
      object edtDesAju: TEditFocus
        Left = 99
        Top = 22
        Width = 357
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object tbsAcumContDom: TTabSheet
      Caption = 'Dom'#237'nio Acumulador'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dbgDomAcu: TDBGridCitel
        Left = 0
        Top = 37
        Width = 1168
        Height = 388
        Align = alClient
        DataSource = dtsDomAcu
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgDomAcuKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'ACU_CLAFIS'
            Title.Caption = 'Classifica'#231#227'o'
            Width = 128
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACU_ALQICM'
            Title.Caption = 'Al'#237'quota de Icms'
            Width = 184
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACU_CODACU'
            Title.Caption = 'C'#243'digo do Acumulador'
            Width = 188
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACU_PERACU'
            Title.Caption = 'Percentual do Acumulador'
            Width = 158
            Visible = True
          end>
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 1168
        Height = 37
        Align = alTop
        TabOrder = 1
        object Label87: TLabel
          Left = 304
          Top = 11
          Width = 111
          Height = 14
          Caption = 'C'#243'digo do Acumulador:'
        end
        object Label88: TLabel
          Left = 499
          Top = 11
          Width = 129
          Height = 14
          Caption = 'Percentual do Acumulador:'
        end
        object Label89: TLabel
          Left = 14
          Top = 11
          Width = 99
          Height = 14
          Caption = 'Classifica'#231#227'o Fiscal:'
        end
        object edtCodAcu: TEditFocus
          Tag = 99
          Left = 418
          Top = 7
          Width = 71
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPerAcu: TEditFocus
          Tag = 99
          Left = 630
          Top = 7
          Width = 71
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 6
          TabOrder = 2
          OnExit = edtPerAcuExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object cbxClaFisAcu: TComboBoxFocus
          Tag = 99
          Left = 116
          Top = 7
          Width = 177
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'Proporcional ao Valor do Item'
            'Proporcional ao Peso do Item')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnConfAcumulador: TBitBtnLocked
          Left = 709
          Top = 7
          Width = 95
          Height = 25
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
          TabOrder = 3
          OnClick = btnConfAcumuladorClick
        end
      end
    end
    object tbsDadosCpl: TTabSheet
      Caption = 'Dados Complementares'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblInfCpl: TLabel
        Left = 24
        Top = 8
        Width = 143
        Height = 14
        Caption = 'Informa'#231#245'es Complementares'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblInfAdiFisco: TLabel
        Left = 24
        Top = 180
        Width = 219
        Height = 14
        Caption = 'Informa'#231#245'es Adicionais de Interesse do Fisco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label93: TLabel
        Left = 22
        Top = 355
        Width = 206
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chave de acesso da Nota Fiscal de origem'
      end
      object memInfCpl: TMemo
        Left = 22
        Top = 24
        Width = 736
        Height = 153
        TabOrder = 0
      end
      object memInfAdicFisco: TMemo
        Left = 22
        Top = 196
        Width = 736
        Height = 153
        TabOrder = 1
      end
      object dbeAcenfo: TDBEditFocus
        Tag = 99
        Left = 22
        Top = 369
        Width = 315
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_ACENFO'
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
    end
    object tbsNotaAssociadoComplemento: TTabSheet
      Caption = 'Nota Fiscal de Entrada Associada ao Complemento'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label95: TLabel
        Left = 37
        Top = 6
        Width = 25
        Height = 14
        Caption = 'Data:'
      end
      object Label96: TLabel
        Left = 22
        Top = 34
        Width = 40
        Height = 14
        Caption = 'N'#250'mero:'
      end
      object Label97: TLabel
        Left = 21
        Top = 62
        Width = 41
        Height = 14
        Caption = 'Esp'#233'cie:'
      end
      object Label98: TLabel
        Left = 3
        Top = 119
        Width = 59
        Height = 14
        Caption = 'Participante:'
      end
      object Label99: TLabel
        Left = 34
        Top = 90
        Width = 28
        Height = 14
        Caption = 'S'#233'rie:'
      end
      object edtNumeroNfComplementar: TEditFocus
        Tag = 1
        Left = 65
        Top = 31
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEspecieNfComplementar: TEditFocus
        Tag = 55
        Left = 65
        Top = 59
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtParticipanteNfComplementar: TEditFocus
        Tag = 55
        Left = 65
        Top = 116
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSerieNfComplementar: TEditFocus
        Tag = 55
        Left = 65
        Top = 87
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomPartNfComplementar: TEditFocus
        Left = 188
        Top = 116
        Width = 358
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object mskDataNfComplementar: TMaskEditFocus
        Tag = 55
        Left = 65
        Top = 3
        Width = 121
        Height = 22
        Enabled = False
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object btnPesquisarNfEntrada: TBitBtnLocked
        Left = 65
        Top = 144
        Width = 149
        Height = 28
        Caption = '&Pesquisar NF - Entrada'
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
          CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
          1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
          D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
          7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
          E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
          EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
          8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnPesquisarNfEntradaClick
      end
      object btnExcluirNfComplementar: TBitBtnLocked
        Left = 220
        Top = 144
        Width = 149
        Height = 28
        Caption = '&Excluir'
        Enabled = False
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
        TabOrder = 7
        OnClick = btnExcluirNfComplementarClick
      end
    end
    object tbsHistContigencia: TTabSheet
      Caption = 'Hist'#243'rico de Contig'#234'ncia'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dbmHisCon: TDBMemoFocus
        Left = 0
        Top = 0
        Width = 1168
        Height = 425
        Align = alClient
        DataField = 'FIS_HISCTG'
        DataSource = dtsTabela
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsDocumentosCTE: TTabSheet
      Caption = 'Documentos de Origem Associados ao CTE'
      ImageIndex = 10
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGridCitel1: TDBGridCitel
        Left = 0
        Top = 0
        Width = 1168
        Height = 400
        Align = alClient
        DataSource = dtsDocsCTE
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'GER_DTADOC'
            Title.Caption = 'Data'
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GER_NUMDOC'
            Title.Caption = 'Documento'
            Width = 94
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GER_ESPDOC'
            Title.Caption = 'Esp'#233'cie'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GER_SERIE_'
            Title.Caption = 'S'#233'rie'
            Width = 99
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GER_ENTSAI'
            Title.Caption = 'Opera'#231#227'o'
            Visible = True
          end>
      end
      object FlowPanel3: TFlowPanel
        Left = 0
        Top = 400
        Width = 1168
        Height = 25
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object btnDocCTEIncluir: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 72
          Height = 20
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
          OnClick = btnDocCTEIncluirClick
        end
        object btnDocCTEExcluir: TBitBtnLocked
          Left = 72
          Top = 0
          Width = 72
          Height = 20
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
          TabOrder = 1
          OnClick = btnDocCTEExcluirClick
        end
      end
    end
    object tbsChaveRef: TTabSheet
      Caption = 'Chaves de Acesso Referenciadas'
      ImageIndex = 11
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdChaveRef: TcxGrid
        Left = 0
        Top = 0
        Width = 1168
        Height = 425
        Align = alClient
        TabOrder = 0
        object grdChaveRefDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdChaveRefDBTableViewEditKeyPress
          DataController.DataSource = dtsChaveRef
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdChaveRefCHAVES: TcxGridDBColumn
            Caption = 'Chaves de Acesso Referenciadas'
            DataBinding.FieldName = 'CHAVES'
          end
        end
        object grdChaveRefLevel: TcxGridLevel
          GridView = grdChaveRefDBTableView
        end
      end
    end
    object tbsGia: TTabSheet
      Caption = 'Ocorr'#234'ncia GIA'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlGia: TPanel
        Left = 8
        Top = 8
        Width = 573
        Height = 233
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object FlowPanel1: TFlowPanel
          Left = 0
          Top = 208
          Width = 573
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 1
          object btnIncluirGia: TBitBtnLocked
            Left = 0
            Top = 0
            Width = 72
            Height = 20
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
            OnClick = btnIncluirGiaClick
          end
          object btnGravarGia: TBitBtnLocked
            Left = 72
            Top = 0
            Width = 72
            Height = 20
            Caption = '&Gravar'
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
            OnClick = btnGravarGiaClick
          end
          object btnAlterarGia: TBitBtnLocked
            Left = 144
            Top = 0
            Width = 72
            Height = 20
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
            OnClick = btnAlterarGiaClick
          end
          object btnExcluirGia: TBitBtnLocked
            Left = 216
            Top = 0
            Width = 72
            Height = 20
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
            OnClick = btnExcluirGiaClick
          end
          object btnCancelarGia: TBitBtnLocked
            Left = 288
            Top = 0
            Width = 72
            Height = 20
            Caption = '&Cancelar'
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
            OnClick = btnCancelarGiaClick
          end
          object BitBtnLocked1: TBitBtnLocked
            Left = 360
            Top = 0
            Width = 72
            Height = 20
            Caption = '&Pesquisar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
              69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
              CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
              1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
              7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
              D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
              A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
              81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
              7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
              A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
              93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
              E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
              BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
              A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
              EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
              D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
              B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
              8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
              DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
              55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
              E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
              6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
              926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 5
            OnClick = BitBtnLocked1Click
          end
        end
        object pnlCentral: TPanel
          Left = 0
          Top = 0
          Width = 573
          Height = 208
          Align = alClient
          Color = 16770261
          TabOrder = 0
          object Label58: TLabel
            Left = 12
            Top = 8
            Width = 22
            Height = 14
            Caption = 'Data'
          end
          object Label70: TLabel
            Left = 12
            Top = 53
            Width = 66
            Height = 14
            Caption = 'C'#243'd. SubItem:'
          end
          object Label71: TLabel
            Left = 105
            Top = 53
            Width = 69
            Height = 14
            Caption = 'Valor SubItem:'
          end
          object Label72: TLabel
            Left = 12
            Top = 96
            Width = 214
            Height = 14
            Caption = 'Fundamenta'#231#227'o legal associada ao SubItem:'
          end
          object Label82: TLabel
            Left = 12
            Top = 136
            Width = 54
            Height = 14
            Caption = 'Ocorr'#234'ncia'
          end
          object mskDtaMes: TcxDBMaskEdit
            Tag = 99
            Left = 12
            Top = 25
            DataBinding.DataField = 'OCR_DTAOCR'
            DataBinding.DataSource = dtsCadOcr
            Properties.EditMask = '99/99/9999;1;_'
            Style.BorderStyle = ebsUltraFlat
            StyleFocused.TextStyle = []
            TabOrder = 0
            Width = 73
          end
          object edtCodSubIte: TDBEditFocus
            Tag = 99
            Left = 12
            Top = 67
            Width = 84
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OCR_CODITE'
            DataSource = dtsCadOcr
            MaxLength = 5
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtValSubIte: TDBEditFocus
            Tag = 99
            Left = 102
            Top = 67
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OCR_VALITE'
            DataSource = dtsCadOcr
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object lcbFundamentoLegal: TDBLookupComboBox
            Left = 12
            Top = 110
            Width = 536
            Height = 22
            DataField = 'OCR_FLAITE'
            DataSource = dtsCadOcr
            KeyField = 'AUTOINCREM'
            ListField = 'FUL_DESFUL'
            ListSource = dtsDescricaoFundamentoLegal
            TabOrder = 4
          end
          object lcbDescricaoOcorrencia: TDBLookupComboBox
            Left = 12
            Top = 150
            Width = 536
            Height = 22
            DataField = 'OCR_OCORRE'
            DataSource = dtsCadOcr
            KeyField = 'AUTOINCREM'
            ListField = 'DOC_DESDOC'
            ListSource = dtsDescricaoOcorrencia
            TabOrder = 5
          end
          object rgIndicaOperacaoPropriaOuSt: TRadioGroup
            Left = 102
            Top = 8
            Width = 446
            Height = 41
            Caption = 'Opera'#231#227'o'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Pr'#243'pria'
              'Subst. Tribut'#225'ria')
            TabOrder = 1
          end
        end
      end
    end
    object tbsFinanceiro: TTabSheet
      Caption = 'Financeiro'
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 1168
        Height = 425
        Align = alClient
        TabOrder = 0
        object grdFinanceiro: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsFinanceiro
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = grdFinanceiro
        end
      end
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 694
    Width = 1176
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnReconstruir: TBitBtnLocked
      Left = 4
      Top = -1
      Width = 75
      Height = 22
      Caption = 'Reconstruir'
      TabOrder = 0
      OnClick = btnReconstruirClick
    end
    object btnAltData: TBitBtnLocked
      Left = 80
      Top = -1
      Width = 105
      Height = 22
      Caption = 'Alterar Data Entrada'
      TabOrder = 1
      OnClick = btnAltDataClick
    end
    object btnAlterarSerie: TBitBtnLocked
      Left = 186
      Top = -1
      Width = 83
      Height = 22
      Caption = 'Alterar S'#233'rie'
      TabOrder = 2
      OnClick = btnAlterarSerieClick
    end
    object btnAltEspecie: TBitBtnLocked
      Left = 368
      Top = -1
      Width = 97
      Height = 22
      Caption = 'Alterar Esp'#233'cie'
      TabOrder = 4
      OnClick = btnAltEspecieClick
    end
    object btnAltFor: TBitBtnLocked
      Left = 270
      Top = -1
      Width = 97
      Height = 22
      Caption = 'Alterar Fornecedor'
      TabOrder = 3
      OnClick = btnAltForClick
    end
    object btnRefresh: TBitBtnLocked
      Left = 466
      Top = -1
      Width = 76
      Height = 22
      Hint = 
        'Atualiza os dados de movimento com os dados do cadastro do Forne' +
        'cedor/Cliente'
      Caption = 'Atualizar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnRefreshClick
    end
    object edtTotDoc: TEditFocus
      Left = 611
      Top = 0
      Width = 84
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlNatCfo: TPanel [6]
    Left = 0
    Top = 209
    Width = 1176
    Height = 28
    Align = alTop
    TabOrder = 6
    object Label23: TLabel
      Left = 8
      Top = 6
      Width = 113
      Height = 14
      Caption = 'Natureza da Opera'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbeNatCfo: TEditFocus
      Tag = 99
      Left = 125
      Top = 2
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnEnter = dbeNatCfoEnter
      OnKeyPress = dbeNatCfoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object cmbNatOpe: TComboBoxFocus
      Tag = 99
      Left = 185
      Top = 2
      Width = 804
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnChange = cmbNatOpeChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 356
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 848
    Top = 112
  end
  object qryFisItens: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      ' (@NROITE:=(@NROITE + 1))    AS NROITE,'
      '  DET_CODITE      AS CODITE,'
      '  DET_DESCRI      AS DESCRI,'
      '  DET_QTDITE      AS QTDITE,'
      '  DET_UNITAR      AS UNITAR,'
      '  DET_UNIDAD      AS UNIDAD,'
      '  DET_TOTITE      AS TOTITE,'
      '  DET_CODEMP      AS CODEMP,'
      '  DET_CODFIS      AS CODFIS,'
      '  DET_CLAFIS      AS CLAFIS,'
      '  DET_BASICM      AS BASICM,'
      '  DET_ALQICM      AS ALQICM,'
      '  DET_VALICM      AS VALICM,'
      '  DET_BASIPI      AS BASIPI,'
      '  DET_ALQIPI      AS ALQIPI,'
      '  DET_VALIPI      AS VALIPI,'
      '  CAST("" AS CHAR(2)) AS TIPPRO,'
      '  DET_TOTITE      AS VTOTAL'
      '   '
      'FROM                        '
      '  MOVDET')
    Left = 780
    Top = 360
    object qryFisItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object qryFisItensDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 57
    end
    object qryFisItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object qryFisItensUNITAR: TFloatField
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensTOTITE: TFloatField
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensCODFIS: TStringField
      FieldName = 'CODFIS'
      Size = 3
    end
    object qryFisItensCLAFIS: TStringField
      FieldName = 'CLAFIS'
      Size = 4
    end
    object qryFisItensBASICM: TFloatField
      FieldName = 'BASICM'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensALQICM: TFloatField
      FieldName = 'ALQICM'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVALICM: TFloatField
      FieldName = 'VALICM'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensBASIPI: TFloatField
      FieldName = 'BASIPI'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensALQIPI: TFloatField
      FieldName = 'ALQIPI'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVALIPI: TFloatField
      FieldName = 'VALIPI'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVTOTAL: TFloatField
      FieldName = 'VTOTAL'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensDESFIS: TStringField
      FieldName = 'DESFIS'
      Size = 50
    end
    object qryFisItensDESCLA: TStringField
      FieldName = 'DESCLA'
      Size = 50
    end
    object qryFisItensVALRET: TFloatField
      FieldName = 'VALRET'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensBASRET: TFloatField
      FieldName = 'BASRET'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVLRCON: TFloatField
      FieldName = 'VLRCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFisItensAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryFisItensVALFRE: TFloatField
      FieldName = 'VALFRE'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensDESACE: TFloatField
      FieldName = 'DESACE'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensCSTPIS: TStringField
      FieldName = 'CSTPIS'
      Size = 2
    end
    object qryFisItensBASPIS: TFloatField
      FieldName = 'BASPIS'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensALQPIS: TFloatField
      FieldName = 'ALQPIS'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVALPIS: TFloatField
      FieldName = 'VALPIS'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensNR_PIS: TStringField
      FieldName = 'NR_PIS'
      Size = 3
    end
    object qryFisItensCSTCOF: TStringField
      FieldName = 'CSTCOF'
      Size = 2
    end
    object qryFisItensBASCOF: TFloatField
      FieldName = 'BASCOF'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensALQCOF: TFloatField
      FieldName = 'ALQCOF'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVALCOF: TFloatField
      FieldName = 'VALCOF'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensNR_COF: TStringField
      FieldName = 'NR_COF'
      Size = 3
    end
    object qryFisItensBASANT: TFloatField
      FieldName = 'BASANT'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVALANT: TFloatField
      FieldName = 'VALANT'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensOUTICM: TFloatField
      FieldName = 'OUTICM'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensISEICM: TFloatField
      FieldName = 'ISEICM'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensBAEIPI: TFloatField
      FieldName = 'BAEIPI'
    end
    object qryFisItensALEIPI: TFloatField
      FieldName = 'ALEIPI'
    end
    object qryFisItensVAEIPI: TFloatField
      FieldName = 'VAEIPI'
    end
    object qryFisItensDESESP: TFloatField
      FieldName = 'DESESP'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVAERET: TFloatField
      FieldName = 'VAERET'
    end
    object qryFisItensBAERET: TFloatField
      FieldName = 'BAERET'
    end
    object qryFisItensTOTFRE_ITE: TFloatField
      FieldName = 'TOTFRE_ITE'
    end
    object qryFisItensDESACE_ITE: TFloatField
      FieldName = 'DESACE_ITE'
    end
    object qryFisItensVLRCON_ITE: TFloatField
      FieldName = 'VLRCON_ITE'
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensDESABF: TStringField
      FieldName = 'DESABF'
      Size = 50
    end
    object strngfldFisItensRICMPR: TStringField
      FieldName = 'RICMPR'
      Size = 1
    end
    object qryFisItensPERRED: TFloatField
      FieldName = 'PERRED'
    end
    object qryFisItensICD_BCUFDE: TFloatField
      FieldName = 'ICD_BCUFDE'
    end
    object qryFisItensICD_PERFCP: TFloatField
      FieldName = 'ICD_PERFCP'
    end
    object qryFisItensICD_ALQUFD: TFloatField
      FieldName = 'ICD_ALQUFD'
    end
    object qryFisItensICD_ALQINE: TFloatField
      FieldName = 'ICD_ALQINE'
    end
    object qryFisItensICD_PERPAR: TFloatField
      FieldName = 'ICD_PERPAR'
    end
    object qryFisItensICD_VALFCP: TFloatField
      FieldName = 'ICD_VALFCP'
    end
    object qryFisItensICD_VALDES: TFloatField
      FieldName = 'ICD_VALDES'
    end
    object qryFisItensICD_VALORI: TFloatField
      FieldName = 'ICD_VALORI'
    end
    object qryFisItensICD_TEMICD: TStringField
      FieldName = 'ICD_TEMICD'
      Size = 0
    end
    object qryFisItensAUX_DESINC: TStringField
      FieldName = 'AUX_DESINC'
      Size = 1
    end
    object qryFisItensAUX_VENPRE: TStringField
      FieldName = 'AUX_VENPRE'
      Size = 1
    end
    object qryFisItensBCR158: TFloatField
      FieldName = 'BCR158'
    end
    object qryFisItensVLR158: TFloatField
      FieldName = 'VLR158'
    end
    object qryFisItensVICMDE: TFloatField
      FieldName = 'VICMDE'
    end
    object qryFisItensBCI158: TFloatField
      FieldName = 'BCI158'
    end
    object qryFisItensALI158: TFloatField
      FieldName = 'ALI158'
    end
    object qryFisItensVLI158: TFloatField
      FieldName = 'VLI158'
    end
    object qryFisItensBFCPST: TFloatField
      FieldName = 'BFCPST'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensPFCPST: TFloatField
      FieldName = 'PFCPST'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensVFCPST: TFloatField
      FieldName = 'VFCPST'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object qryFisItensICD_BASFCP: TFloatField
      FieldName = 'ICD_BASFCP'
    end
    object qryFisItensTIPPRO: TStringField
      FieldName = 'TIPPRO'
      Size = 2
    end
    object qryFisItensUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 5
    end
    object qryFisItensNAT_CODCFO: TStringField
      FieldName = 'NAT_CODCFO'
    end
    object qryFisItensCODFAB: TStringField
      FieldName = 'CODFAB'
    end
    object qryFisItensCIDADEENT: TStringField
      FieldName = 'CIDADEENT'
      Size = 100
    end
    object qryFisItensESTADOENT: TStringField
      FieldName = 'ESTADOENT'
      Size = 2
    end
    object qryFisItensCEPENT: TStringField
      FieldName = 'CEPENT'
    end
    object qryFisItensNROITE: TLargeintField
      FieldName = 'NROITE'
    end
    object qryFisItensCSTIPI: TStringField
      FieldName = 'CSTIPI'
      Size = 2
    end
    object qryFisItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 50
    end
    object qryFisItensCODFAB2: TStringField
      FieldName = 'CODFAB2'
    end
    object qryFisItensNCMITE: TStringField
      FieldName = 'NCMITE'
      Size = 8
    end
    object qryFisItensNAT_DESCRI: TStringField
      FieldName = 'NAT_DESCRI'
      Size = 150
    end
    object qryFisItensDET_NATOPE: TStringField
      FieldName = 'DET_NATOPE'
      Size = 50
    end
    object qryFisItensOPCDOC: TStringField
      FieldName = 'OPCDOC'
      Size = 2
    end
    object qryFisItensDET_QBCMON: TCurrencyField
      FieldName = 'DET_QBCMON'
    end
    object qryFisItensDET_ADREMN: TCurrencyField
      FieldName = 'DET_ADREMN'
    end
    object qryFisItensDET_VALMON: TCurrencyField
      FieldName = 'DET_VALMON'
    end
    object qryFisItensDET_VLGNRE: TCurrencyField
      FieldName = 'DET_VLGNRE'
    end
    object qryFisItensBASCBS: TFloatField
      FieldName = 'BASCBS'
    end
    object qryFisItensVALCBS: TFloatField
      FieldName = 'VALCBS'
    end
    object qryFisItensBASIBS: TFloatField
      FieldName = 'BASIBS'
    end
    object qryFisItensVALIBS: TFloatField
      FieldName = 'VALIBS'
    end
    object qryFisItensBAS_IS: TFloatField
      FieldName = 'BAS_IS'
    end
    object qryFisItensVAL_IS: TFloatField
      FieldName = 'VAL_IS'
    end
  end
  object dtsFisItens: TDataSource
    DataSet = qryFisItens
    OnDataChange = dtsFisItensDataChange
    Left = 700
    Top = 300
  end
  object dtsTabela: TDataSource
    OnDataChange = dtsTabelaDataChange
    Left = 708
    Top = 216
  end
  object dtsAuxFis: TDataSource
    Left = 764
    Top = 216
  end
  object dtsFisAju: TDataSource
    DataSet = qryFisAju
    OnDataChange = dtsFisAjuDataChange
    Left = 808
    Top = 104
  end
  object qryFisAju: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT *'
      '  FROM FISAJU'
      'WHERE FALSE')
    Left = 872
    Top = 316
    object qryFisAjuAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryFisAjuAJU_SEQGER: TStringField
      FieldName = 'AJU_SEQGER'
    end
    object qryFisAjuAJU_CD_AJU: TStringField
      FieldName = 'AJU_CD_AJU'
    end
    object qryFisAjuAJU_DESAJU: TStringField
      FieldName = 'AJU_DESAJU'
    end
    object qryFisAjuAJU_BASICM: TFloatField
      FieldName = 'AJU_BASICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFisAjuAJU_ALQICM: TFloatField
      FieldName = 'AJU_ALQICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFisAjuAJU_VALICM: TFloatField
      FieldName = 'AJU_VALICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFisAjuAJU_OUTROS: TFloatField
      FieldName = 'AJU_OUTROS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 32
    Top = 256
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
  end
  object dtsDomAcu: TDataSource
    DataSet = cdsDomAcu
    Left = 751
    Top = 80
  end
  object cdsDomAcu: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ACU_CLAFIS; ACU_ALQICM'
    Params = <>
    StoreDefs = True
    Left = 292
    Top = 202
    object cdsDomAcuAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDomAcuACU_SEQFIS: TStringField
      FieldName = 'ACU_SEQFIS'
    end
    object cdsDomAcuACU_CLAFIS: TStringField
      FieldName = 'ACU_CLAFIS'
      Size = 4
    end
    object cdsDomAcuACU_ALQICM: TFloatField
      FieldName = 'ACU_ALQICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsDomAcuACU_CODACU: TStringField
      FieldName = 'ACU_CODACU'
      Size = 5
    end
    object cdsDomAcuACU_PERACU: TFloatField
      FieldName = 'ACU_PERACU'
      DisplayFormat = '#,##0.00'
    end
    object cdsDomAcuACU_CODEMP: TStringField
      FieldName = 'ACU_CODEMP'
      Size = 3
    end
  end
  object cdsDocsCTE: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 892
    Top = 402
    object cdsDocsCTEGER_DTADOC: TDateField
      FieldName = 'GER_DTADOC'
    end
    object cdsDocsCTEGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Size = 12
    end
    object cdsDocsCTEGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Size = 2
    end
    object cdsDocsCTEGER_SERIE_: TStringField
      FieldName = 'GER_SERIE_'
      Size = 3
    end
    object cdsDocsCTEGER_ENTSAI: TStringField
      FieldName = 'GER_ENTSAI'
    end
    object cdsDocsCTETABELA: TStringField
      FieldName = 'TABELA'
    end
    object cdsDocsCTEAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Size = 40
    end
  end
  object dtsDocsCTE: TDataSource
    DataSet = cdsDocsCTE
    Left = 512
    Top = 312
  end
  object cdsChaveRef: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 68
    Top = 306
    object cdsChaveRefCHAVES: TStringField
      FieldName = 'CHAVES'
      Size = 50
    end
  end
  object dtsChaveRef: TDataSource
    DataSet = cdsChaveRef
    Left = 68
    Top = 370
  end
  object dsFinanceiro: TDataSource
    Left = 532
    Top = 446
  end
  object dtsDescricaoFundamentoLegal: TDataSource
    Left = 232
    Top = 560
  end
  object dtsDescricaoOcorrencia: TDataSource
    Left = 232
    Top = 504
  end
  object dtsCadOcr: TDataSource
    AutoEdit = False
    OnStateChange = dtsCadOcrStateChange
    Left = 344
    Top = 504
  end
  object cxEditRepository1: TcxEditRepository
    Left = 712
    Top = 472
    PixelsPerInch = 96
    object cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxEditRepository1ButtonItem1PropertiesButtonClick
    end
  end
  object popEventosEntrega: TPopupMenu
    Left = 1096
    Top = 520
    object popConfirmaoEntrega: TMenuItem
      Caption = 'Confirma'#231#227'o de Entrega'
      OnClick = popConfirmaoEntregaClick
    end
    object popCancelamentoConfirmacaoEntrega: TMenuItem
      Caption = 'Cancelamento Confirma'#231#227'o de Entrega'
      OnClick = popCancelamentoConfirmacaoEntregaClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object popInsucessoEntrega: TMenuItem
      Caption = 'Insucesso na Entrega'
      OnClick = popInsucessoEntregaClick
    end
    object popCancelamentoInsucessoEntrega: TMenuItem
      Caption = 'Cancelamento Insucesso na Entrega'
      OnClick = popCancelamentoInsucessoEntregaClick
    end
  end
end
