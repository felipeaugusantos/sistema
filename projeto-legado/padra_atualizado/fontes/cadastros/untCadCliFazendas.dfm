inherited frmCadCliFazendas: TfrmCadCliFazendas
  Left = 215
  Top = 205
  Width = 767
  Height = 628
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Fazendas do Cliente'
  ExplicitWidth = 767
  ExplicitHeight = 628
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 225
    Width = 751
    ExplicitTop = 225
    ExplicitWidth = 751
    inherited FlwBotoes: TFlowPanel
      Left = 472
      Width = 200
      Align = alLeft
      ExplicitLeft = 472
      ExplicitWidth = 200
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 105
        Align = alLeft
        ExplicitWidth = 105
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 105
        Width = 93
        Align = alLeft
        ExplicitLeft = 105
        ExplicitWidth = 93
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 670
      Width = 79
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      NumGlyphs = 1
      ExplicitLeft = 670
      ExplicitWidth = 79
    end
    inherited btnCancela: TBitBtnLocked
      Left = 382
      ExplicitLeft = 382
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 287
      Width = 95
      Font.Height = 15
      ParentFont = False
      ExplicitLeft = 287
      ExplicitWidth = 95
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 192
      Width = 95
      ExplicitLeft = 192
      ExplicitWidth = 95
    end
    inherited btnGravar: TBitBtnLocked
      Left = 97
      Width = 95
      ExplicitLeft = 97
      ExplicitWidth = 95
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      Width = 95
      ExplicitLeft = 2
      ExplicitWidth = 95
    end
  end
  inherited pnlHeader: TPanel
    Width = 751
    Height = 185
    ExplicitWidth = 751
    ExplicitHeight = 185
    object Label57: TLabel [0]
      Left = 48
      Top = 87
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label58: TLabel [1]
      Left = 182
      Top = 62
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label60: TLabel [2]
      Left = 435
      Top = 63
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label62: TLabel [3]
      Left = 75
      Top = 63
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label63: TLabel [4]
      Left = 65
      Top = 111
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label149: TLabel [5]
      Left = 370
      Top = 111
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Complemento:'
    end
    inherited lblInf: TLabel
      Left = 555
      ExplicitLeft = 555
    end
    object Label3: TLabel [7]
      Left = 12
      Top = 14
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. da Fazenda:'
    end
    object Label4: TLabel [8]
      Left = 7
      Top = 37
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome da Fazenda:'
    end
    object Label189: TLabel [9]
      Left = 527
      Top = 87
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero:'
    end
    object Label12: TLabel [10]
      Left = 9
      Top = 158
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = '1 - CNPJ / 2 - CPF:'
    end
    object Label10: TLabel [11]
      Left = 346
      Top = 158
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'Inscri'#231#227'o Estadual:'
    end
    object Label64: TLabel [12]
      Left = 397
      Top = 134
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Contato:'
    end
    object Label65: TLabel [13]
      Left = 53
      Top = 134
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone:'
    end
    object Label2: TLabel [14]
      Left = 541
      Top = 63
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'IBGE:'
    end
    inherited pgcDados: TPageControl
      Left = 760
      Top = 0
      TabOrder = 16
      ExplicitLeft = 760
      ExplicitTop = 0
      inherited tbsGeral: TTabSheet
        Caption = 'Digita'#231#227'o:'
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 57
        ExplicitHeight = 15
      end
    end
    object dbeEndere: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 82
      Width = 421
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_ENDERE'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCid: TDBEditFocus
      Tag = 99
      Left = 216
      Top = 58
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_CODCID'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 3
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
    object dbeEndCep: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 58
      Width = 77
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_C_E_P_'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      OnKeyPress = dbeEndCepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBairro: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 106
      Width = 240
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_BAIRRO'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEndCom: TDBEditFocus
      Tag = 99
      Left = 440
      Top = 106
      Width = 222
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_ENDCOM'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEstado: TDBEditFocus
      Left = 475
      Top = 58
      Width = 46
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'CID_ESTADO'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomCid: TDBEditFocus
      Left = 259
      Top = 58
      Width = 167
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'CID_NOMCID'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFaz: TDBEditFocus
      Left = 100
      Top = 11
      Width = 68
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'FAZ_CODFAZ'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomfaz: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 34
      Width = 562
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_NOMFAZ'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEndNum: TDBEditFocus
      Tag = 99
      Left = 570
      Top = 82
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAZ_ENDNUM'
      DataSource = dtsConsulta
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
      TipoTexto = ttAlfanumerico
    end
    object dbeCgcCpf: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 154
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAZ_CGCCPF'
      DataSource = dtsConsulta
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
      Left = 135
      Top = 154
      Width = 205
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAZ_C_G_C_'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumIes: TDBEditFocus
      Tag = 99
      Left = 440
      Top = 154
      Width = 222
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAZ_I_E_S_'
      DataSource = dtsConsulta
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
    object dbeNomCon: TDBEditFocus
      Tag = 99
      Left = 440
      Top = 130
      Width = 222
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_NOMCON'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTelCon: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 130
      Width = 158
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'FAZ_TELCON'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCoIbge: TDBEditFocus
      Left = 570
      Top = 58
      Width = 92
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'CID_ESTADO'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 510
    Width = 751
    Height = 37
    Visible = True
    ExplicitTop = 510
    ExplicitWidth = 751
    ExplicitHeight = 37
    object btnConfAlteracoes: TBitBtnLocked
      Left = 6
      Top = 6
      Width = 162
      Height = 24
      Caption = '[ F10 ] Confirmar altera'#231#245'es '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfAlteracoesClick
    end
    object pnlAviso: TPanel
      Left = 208
      Top = 7
      Width = 473
      Height = 24
      BevelOuter = bvNone
      Caption = 'NENHUMA FAZENDA SELECIONADA - F10 PARA SELECIONAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 253
    Width = 751
    Height = 257
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'FAZ_CODFAZ'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAZ_NOMFAZ'
        Width = 287
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_ESTADO'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAZ_C_E_P_'
        Width = 70
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 185
    Width = 751
    ExplicitTop = 185
    ExplicitWidth = 751
    inherited edtData: TMaskEditFocus
      ParentCtl3D = False
    end
    inherited edtNumero: TEditFocus
      ParentCtl3D = False
    end
    inherited edtString: TEditFocus
      ParentCtl3D = False
    end
    inherited edtValor: TEditFocus
      ParentCtl3D = False
    end
  end
  inherited pnlInfBotoes: TPanel
    Top = 547
    Width = 751
    ExplicitTop = 547
    ExplicitWidth = 751
    inherited Label1: TLabel
      Width = 747
      Height = 22
      Caption = 
        '[F2] Posiciona sobre a grade de registros     [ F3 ] Ordenar reg' +
        'istros pr'#243'xima coluna    [ F5 ] Pesquisar registros'
      ExplicitWidth = 536
    end
  end
  inherited pnlStatus: TPanel
    Top = 573
    Width = 751
    ExplicitTop = 573
    ExplicitWidth = 751
    inherited pnlNomeForm: TPanel
      Left = 580
      ExplicitLeft = 580
    end
    inherited pnlInfo: TPanel
      Width = 580
      ExplicitWidth = 580
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 376
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 384
  end
  inherited qryConsulta: TUniQuery
    Left = 56
    Top = 448
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Left = 88
    Top = 448
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterOpen = cdsConsultaAfterOpen
    AfterScroll = cdsConsultaAfterScroll
    Left = 120
    Top = 448
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object cdsConsultaFAZ_CODCLI: TStringField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'FAZ_CODCLI'
      Visible = False
      Size = 8
    end
    object cdsConsultaFAZ_CODFAZ: TStringField
      DisplayLabel = 'C'#243'd. Faz.'
      FieldName = 'FAZ_CODFAZ'
      Size = 6
    end
    object cdsConsultaFAZ_NOMFAZ: TStringField
      DisplayLabel = 'Nome da Fazenda'
      FieldName = 'FAZ_NOMFAZ'
      Size = 60
    end
    object cdsConsultaFAZ_CODCID: TStringField
      DisplayLabel = 'C'#243'd. Cidade'
      FieldName = 'FAZ_CODCID'
      Visible = False
      Size = 5
    end
    object cdsConsultaCID_NOMCID: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CID_NOMCID'
      OnGetText = cdsConsultaCID_NOMCIDGetText
      Size = 60
    end
    object cdsConsultaCID_ESTADO: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'CID_ESTADO'
      OnGetText = cdsConsultaCID_ESTADOGetText
      Size = 2
    end
    object cdsConsultaCID_COIBGE: TStringField
      FieldName = 'CID_COIBGE'
      OnGetText = cdsConsultaCID_COIBGEGetText
      Size = 30
    end
    object cdsConsultaFAZ_ENDERE: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'FAZ_ENDERE'
      Size = 60
    end
    object cdsConsultaFAZ_ENDNUM: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'FAZ_ENDNUM'
      Size = 10
    end
    object cdsConsultaFAZ_BAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'FAZ_BAIRRO'
      Size = 60
    end
    object cdsConsultaFAZ_C_E_P_: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'FAZ_C_E_P_'
      EditMask = '99999-999;0;_'
      Size = 9
    end
    object cdsConsultaFAZ_ENDCOM: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 50
      FieldName = 'FAZ_ENDCOM'
      Size = 50
    end
    object cdsConsultaFAZ_CGCCPF: TIntegerField
      FieldName = 'FAZ_CGCCPF'
    end
    object cdsConsultaFAZ_C_G_C_: TStringField
      FieldName = 'FAZ_C_G_C_'
      Size = 18
    end
    object cdsConsultaFAZ_I_E_S_: TStringField
      FieldName = 'FAZ_I_E_S_'
      Size = 18
    end
    object cdsConsultaFAZ_NOMCON: TStringField
      FieldName = 'FAZ_NOMCON'
      Size = 25
    end
    object cdsConsultaFAZ_TELCON: TStringField
      FieldName = 'FAZ_TELCON'
      Size = 15
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 152
    Top = 448
  end
  object qryCadCid: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 360
    Top = 376
  end
end
