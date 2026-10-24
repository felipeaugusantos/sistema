inherited frmCadLeads: TfrmCadLeads
  Width = 1040
  Height = 742
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Cadastro de Leads'
  WindowState = wsMaximized
  ExplicitTop = -23
  ExplicitWidth = 1040
  ExplicitHeight = 742
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 335
    Width = 1034
    Height = 9
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -1
    ExplicitTop = 4
  end
  inherited pnlBotoes: TPanel
    Top = 669
    Width = 1034
    ExplicitTop = 669
    ExplicitWidth = 1034
    inherited FlwBotoes: TFlowPanel
      Width = 966
      ExplicitTop = 2
      ExplicitWidth = 966
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
        Width = 81
        Height = 24
        Align = alLeft
        ExplicitWidth = 81
        ExplicitHeight = 24
      end
      object btnOrcamento: TBitBtnLocked
        Left = 441
        Top = 0
        Width = 84
        Height = 25
        Align = alLeft
        Caption = 'Or'#231'amento'
        Enabled = False
        TabOrder = 6
        OnClick = btnOrcamentoClick
      end
      object btnOrcamentos: TBitBtnLocked
        Left = 525
        Top = 0
        Width = 87
        Height = 25
        Align = alLeft
        Caption = 'Or'#231'. Vinculados'
        Enabled = False
        TabOrder = 7
        OnClick = btnOrcamentosClick
      end
      object btnAnexos: TBitBtnLocked
        Left = 612
        Top = 0
        Width = 50
        Height = 25
        Align = alLeft
        Caption = 'Anexos'
        Enabled = False
        TabOrder = 8
        OnClick = btnAnexosClick
      end
      object btnIncOcorrencia: TBitBtnLocked
        Left = 662
        Top = 0
        Width = 116
        Height = 25
        Align = alLeft
        Caption = 'Incluir Ocorr'#234'ncia [F1]'
        Enabled = False
        TabOrder = 9
        OnClick = btnIncOcorrenciaClick
      end
      object btnVincularOrc: TBitBtnLocked
        Left = 778
        Top = 0
        Width = 87
        Height = 25
        Align = alLeft
        Caption = 'Vincular Or'#231'.'
        Enabled = False
        TabOrder = 10
        OnClick = btnVincularOrcClick
      end
      object btnFinalizarLead: TBitBtnLocked
        Left = 865
        Top = 0
        Width = 75
        Height = 25
        Align = alLeft
        Caption = 'Finalizar Lead'
        Enabled = False
        TabOrder = 11
        OnClick = btnFinalizarLeadClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 968
      Width = 64
      Height = 24
      Align = alRight
      ExplicitLeft = 968
      ExplicitWidth = 64
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 697
    Width = 1034
    TabOrder = 3
    ExplicitTop = 697
    ExplicitWidth = 1034
    inherited pnlNomeForm: TPanel
      Left = 687
      ExplicitLeft = 687
    end
    inherited pnlInfo: TPanel
      Width = 687
      ExplicitWidth = 687
    end
  end
  inherited pgcDados: TPageControl
    Left = -80
    Top = 44
    Width = 17
    Height = 25
    Align = alNone
    TabOrder = 4
    ExplicitLeft = -80
    ExplicitTop = 44
    ExplicitWidth = 17
    ExplicitHeight = 25
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 9
      ExplicitHeight = 15
    end
  end
  object pnlTop: TPanel [4]
    Left = 0
    Top = 0
    Width = 1034
    Height = 261
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      1034
      261)
    object Label5: TLabel
      Left = 46
      Top = 8
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label16: TLabel
      Left = 648
      Top = 8
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' do Leads:'
    end
    object Label1: TLabel
      Left = 1091
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Visible = False
    end
    object Label2: TLabel
      Left = 45
      Top = 34
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label3: TLabel
      Left = 9
      Top = 59
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de cliente:'
    end
    object Label4: TLabel
      Left = 625
      Top = 34
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de cadastro:'
    end
    object Label6: TLabel
      Left = 517
      Top = 57
      Width = 194
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de in'#237'cio da obra / Previs'#227'o de Fat.:'
    end
    object Label7: TLabel
      Left = 6
      Top = 83
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs. do cliente:'
    end
    object Bevel2: TBevel
      Left = 0
      Top = 90
      Width = 1031
      Height = 42
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
    end
    object Label14: TLabel
      Left = 7
      Top = 145
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label17: TLabel
      Left = 12
      Top = 241
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object Label18: TLabel
      Left = 414
      Top = 144
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Previs'#227'o or'#231'. R$:'
    end
    object lblCodOpe: TLabel
      Left = 561
      Top = 194
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Kam Fornec.:'
    end
    object Label19: TLabel
      Left = 575
      Top = 217
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233' Venda:'
    end
    object Label20: TLabel
      Left = 883
      Top = 11
      Width = 81
      Height = 14
      Caption = 'Nome do projeto:'
    end
    object lblMarca: TLabel
      Left = 41
      Top = 168
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label26: TLabel
      Left = 413
      Top = 168
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Previs'#227'o or'#231'. U$:'
    end
    object Label27: TLabel
      Left = 601
      Top = 168
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Data cota'#231#227'o U$:'
    end
    object Label28: TLabel
      Left = 757
      Top = 169
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Valor Cota'#231#227'o U$:'
    end
    object lblOrcVin: TLabel
      Left = 297
      Top = 194
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Or'#231'. Vinculado:'
    end
    object lblEmpOrcVin: TLabel
      Left = 327
      Top = 217
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 5
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LDG_CODCLI'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentFont = False
      TabOrder = 0
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 159
      Top = 5
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 712
      Top = 5
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LDG_NUMDOC'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 1137
      Top = 33
      Width = 75
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'LDG_CODEMP'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtCliCid: TEditFocus
      Left = 87
      Top = 29
      Width = 420
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
    object edtCliTip: TEditFocus
      Left = 87
      Top = 53
      Width = 420
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
    object DBEditFocus1: TDBEditFocus
      Tag = 99
      Left = 712
      Top = 29
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LDG_DTACAD'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIniObr: TDBEditFocus
      Tag = 99
      Left = 712
      Top = 53
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LDG_INIOBR'
      DataSource = dtsTabela
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
      TipoTexto = ttAlfanumerico
    end
    object mmoCliObs: TMemoFocus
      Left = 87
      Top = 77
      Width = 619
      Height = 49
      TabStop = False
      Color = 16768952
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtLinGru: TMaskEditFocus
      Tag = 99
      Left = 81
      Top = 141
      Width = 65
      Height = 22
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 10
      Text = ''
      OnKeyPress = edtLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 150
      Top = 141
      Width = 254
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObserv: TEditFocus
      Tag = 99
      Left = 81
      Top = 236
      Width = 529
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 250
      TabOrder = 29
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPrevis: TEditFocus
      Tag = 99
      Left = 502
      Top = 141
      Width = 94
      Height = 22
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      TabOrder = 12
      Text = '0,00'
      OnExit = edtPrevisExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCodPVe: TEditFocus
      Tag = 99
      Left = 631
      Top = 214
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 27
      OnKeyPress = edtCodPVeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomPVe: TEditFocus
      Left = 673
      Top = 214
      Width = 346
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 614
      Top = 236
      Width = 75
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
      TabOrder = 30
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 690
      Top = 236
      Width = 75
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
      TabOrder = 31
      OnClick = btnCancelaItemClick
    end
    object ckbRegist: TCheckBox
      Left = 10
      Top = 194
      Width = 66
      Height = 17
      Caption = 'Registro'
      TabOrder = 19
      OnClick = ckbRegistClick
    end
    object ckbDescont: TCheckBox
      Left = 10
      Top = 217
      Width = 67
      Height = 17
      Caption = 'Desconto'
      TabOrder = 23
      OnClick = ckbDescontClick
    end
    object edtNumReg: TEditFocus
      Tag = 50
      Left = 81
      Top = 189
      Width = 206
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 30
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAutDes: TEditFocus
      Tag = 50
      Left = 81
      Top = 213
      Width = 206
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 30
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNomPro: TDBEditFocus
      Tag = 99
      Left = 883
      Top = 29
      Width = 136
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LDG_NOMPRO'
      DataSource = dtsTabela
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnContatos: TBitBtnLocked
      Left = 883
      Top = 51
      Width = 136
      Height = 74
      Caption = 'Contatos'
      Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000001000000010000000100000001000000010000
        0001000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000100000001000000020000
        0002000000020000000100000000000000000000000000000000000000000000
        00000000000100000003000000070000000B0000000E0000000D0000000A0000
        0005000000020000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000002000000050000000D000000110000
        00120000000F0000000900000004000000010000000000000000000000000000
        0001000000030000000C0000001C0000002D00000035000000350000002A0000
        0015000000070000000200000002000000020000000200000002000000020000
        0002000000020000000200000003000000080000001900000033000000430000
        00460000003C0000002700000011000000050000000100000000000000000000
        0002000000090000001F0406378C0C0F8BFF0B0E87FF0A0D83FF090C7FFF0000
        00370000001B000000110000000F000000100000001000000010000000100000
        00110000001100000011000000130000001F00000042010257FF010157FF0101
        56FF000156FF0000219D0000002E0000000E0000000300000000000000000000
        00040000001302021756131695FC1A1BA6FF090A9EFF090A9AFF0A0D82FF0303
        2692000000480000003E0000003D0000003E0000003F00000040000000410000
        00420000004300000044000000470000005601011BA2020258FF06065FFF0606
        5CFF06055BFF010254FD00000D6E0000001E0000000700000000000000010000
        00070000001E080A5FBC292BB6FF1114BDFF0B0EB7FF090A9EFF090A9AFF0A0D
        80FF0A0B7CFF080B77FF080A72FF07096EFF050869FF050666FF040561FF0404
        5EFF04045DFF03045CFF03035AFF03035AFF02035AFF090868FF090763FF0807
        62FF07065CFF040459FF000136CC000000310000000B00000001000000010000
        0009000000260C0F8CEF3639C8FF0C0FBFFF0C0FBCFF0B0DBAFF090A9EFF090A
        9AFF090996FF080994FF08098FFF08098EFF080989FF080985FF080881FF0707
        7EFF070778FF070775FF070671FF06066EFF080872FF08076DFF090868FF0807
        63FF070661FF06065CFF010150F70000003F0000001000000002000000010000
        000A000000290E129CFF787BE9FF4D50DDFF4245D6FF383BD0FF2F31C8FF2628
        C2FF1F21BAFF181AB2FF1314ADFF0F10A5FF0C0D9EFF0C0C99FF0B0C94FF0C0C
        91FF0D0E8BFF11118DFF15168AFF191A89FF20208BFF26268EFF2C2C90FF3434
        93FF3B3A97FF32338DFF010156FF000000460000001100000002000000010000
        000A000000290E129EFF9A9BF6FF8284F3FF8284F2FF8284F2FF8283F1FF8284
        F0FF8284F0FF8284EFFF6364CCFF3E40A2FF20217EFF0B0C65FF16165DFF1E1D
        78FF383897FF585ABBFF7474DBFF7173D7FF6F70D4FF6C6DD0FF6A6BCDFF6768
        C8FF6565C4FF4A4BA6FF020157FF000000460000001200000002000000010000
        0009000000260E129FFF888BF0FF7274EDFF6D70EBFF6D6FEAFF6D6FE8FF6D6F
        E8FF6D6FE6FF393AA4FF26277AFF242564FF232472FF0F1065FF06085CFF2425
        70FF2F2F76FF20216FFF2F2F8FFF5F60CAFF5C5EC6FF5A5BC2FF585ABEFF5657
        BAFF5454B6FF3F3F9BFF020258FF000000430000001000000002000000010000
        00070000001E0B0F84DF6467DDFF696BE8FF575AE4FF5759E2FF5759E0FF5659
        DFFF282A99FF26277AFF5F5F9BFF9C9DC1FFCFCFE1FFF2F2F7FF969699FFCFCF
        E0FF9B9CBEFF5B5C95FF21216BFF1F1F80FF494AB8FF4848B4FF4646B0FF4444
        ABFF4243A8FF2A2987FF020249E9000000380000000D00000002000000000000
        000400000015060948923438BEFF6265E4FF4346DEFF3F43DBFF4042DAFF2E30
        B4FF3A3C8AFFA8A9CAFFDEDEDEFF5F5F5FFFD9D9D9FFFFFFFFFF414141FFFFFF
        FFFFF1F1F1FF939393FFA0A0BEFF34357CFF242591FF3435A9FF3334A3FF3232
        9EFF2E2E96FF13136EFF010126A9000000270000000900000001000000000000
        00020000000B0101082F101496EF4C50D9FF4448DBFF2A2ED6FF2B2FD3FF1416
        8CFF9FA0C6FFFFFFFFFFFFFFFFFFF3F3F3FFFDFDFDFFDFDFECFFDFDFEAFFFFFF
        FFFFBABABAFFBABABAFFFFFFFFFF9D9DBFFF0C0D70FF22239CFF222297FF2122
        94FF1A1A83FF050556F50000044E000000160000000400000000000000000000
        00020000000B0000001F050739802125B5FF4348DAFF262BD3FF191ECEFF0C0E
        73FFEFEFF5FFAFB0AFFFADADADFFFFFFFFFF4E51A1FF0D1078FF090B6CFF4546
        89FFFFFFFFFF6F706FFF6D6D6DFFEEEEF4FF03045EFF131496FF131490FF1213
        8AFF0D0D6BFF0101209E0000003D000000170000000400000000000000010000
        000B05051C520C0F5FD20607318B090D6BC22C30C5FF373BD7FF1116CDFF0C0E
        8CFFA0A1C7FFFFFFFFFFC5C5C5FFE7E7E7FF43469BFF101480FF0D1178FF3D3E
        8AFFF9F9F9FFFFFFFFFFFFFFFFFF9D9EC0FF05066EFF0A0B94FF0A0A8FFF0A0A
        76FF02033ED4010123AC000142E0000012730000001A00000003000000070809
        2D6B242792FC1C1FA4FF111482FC04052476101392ED363AD2FF3035D5FF0D11
        ADFF3B3D94FFA6A6C7FFAFAFAFFFF8F8F8FFFFFFFFFFC7C7D7FFD8D8EAFFF0F0
        F0FF838382FFDCDCDCFFA7A7C7FF363783FF08088AFF0A0B99FF0A0B8BFF0709
        59F30101199D151569FD141276FF020159FD00011C8C000000120000000E1D20
        85EA585CCFFF1C20B6FF171BA8FF0E1175F104052B79181CA7FC3A3ED7FF2A2E
        D4FF0C10ADFF1B1E8FFF6062A2FF9E9FC6FFD0D0E3FFA7A8AAFFF2F3F7FFCFD0
        E2FF9D9DC2FF5E5F9AFF16177BFF08098EFF0A0BA2FF0B0B9CFF0D0E6BFC0102
        1C9C0D0E5EF635369AFF25248DFF0E0C75FF01014DF300000025000000102C30
        A3FF6367DEFF2429CBFF1C1FB2FF171BA2FF0C0E61D8050639861E22B0FF3A3F
        D9FF252AD3FF0C11C1FF0C10A8FF1D1F93FF13157EFF0C0D71FF0A0C6FFF1113
        79FF191B89FF25279DFF3335B3FF0B0CAAFF0A0BA3FF0E1075FE0202209B0607
        4DE63A3B9CFF32329FFF262795FF1C1B84FF010157FF0000002D0000000E3235
        A9FF656ADFFF3238D3FF2429C8FF1B1FAFFF161999FF090B4BB7070847992327
        B5FF3A3FD9FF0C12CEFF0D108BFF0C0F86FF0C0F82FF0B0D7DFF0A0C79FF0A0D
        76FF0A0B72FF090B6FFF393BC2FF393BBEFF07097CFF030329A704043DCB3D3E
        9AFF3B3BA9FF3030A0FF262695FF1B1A85FF020259FF0000002B0000000B2C2F
        91DA5D62D7FF4B50DBFF282DD2FF2327C3FF1C1FB1FF10137EFF01010A4B0E12
        97FF3739C0FF0D108FFF00000043000000300000002C0000002C0000002E0000
        00300000003900000055090A6DFF3636A8FF070867FF010108700D106CFF5152
        B7FF3637A6FF2D2D9FFF232296FF14147DFF02034BEA00000023000000051B1C
        53824D52C7FF676BE1FF373CD7FF292ED2FF1F23B4FF13168FFF0709399B0E12
        97FF323299FF0D1190FF0000002D000000130000000B0000000B0000000B0000
        000D0000001700000039090B6EFF323295FF070969FF040531B61C1C82FF2121
        9CFF3030A4FF28279DFF1E1F92FF111172FF010129A400000013000000010202
        0412323496D76065D9FF6669E1FF484DDBFF262ABFFF15189CFF141788FB0F12
        8DFF32318EFF0D1190FF0000002C000000110000000700000003000000030000
        00080000001500000039090C6FFF31318DFF080A6BFF191A7EFD0D0D91FF0808
        8DFF181897FF23239AFF2C2B8FFF060651E70000022F00000005000000000000
        000305050D21353899D75457CCFF666ADEFF5E61D8FF3C3FBDFF2123A5FF1619
        90FF161881FF0E1282FF0607318F040520660303185100000325000003260303
        185503041E6E05062E9B0B0E72FF101274FF0D0F7EFF0B0B96FF0A0A95FF1616
        97FF2D2B9CFF2A2A89FF090A54E5010107410000000A00000000000000000000
        00000000000304040B1B212361933E41B2F64D50C5FF585BCFFF585AC7FF484B
        B7FF3537ABFF2829A0FF1C1F91FF151888FF131684FF0F127BFF0F127BFF0F12
        80FF0F1181FF121486FF15168BFF20219BFF2A2AABFF3637AEFF3B3BA5FF2A2B
        8DFF13146FF9090A3CAF01010737000000090000000100000000000000000000
        0000000000000000000200000007060610251D1F5587303393D83F42B7FF4749
        BDFF4B4FBFFF4D50BEFF5154BFFF5153BDFF595BC2FF5859C0FF5859C1FF5658
        C0FF4A4DB6FF484AB4FF3F40ABFF383AA4FF2A2C94FF1E1E85FF14176AE30D0E
        3D9F02020B3F0000001500000006000000010000000000000000000000000000
        000000000000000000000000000000000002000000060000000D080918351617
        4476202266A7242774BD282B86D9272988E12D30A0FF2B2E9DFF292C9AFF282B
        98FF1F217CE41D2076DD181A62C7141553B40D0F36890505134A0000001E0000
        0010000000050000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        00060000000A0000000D0000000F000000110000001500000017000000180000
        0018000000160000001600000014000000110000000C00000005000000010000
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
        0000000000000000000000000000000000000000000000000000}
      Layout = blGlyphTop
      TabOrder = 32
      TabStop = False
      OnClick = btnContatosClick
    end
    object edtNomKam: TEditFocus
      Tag = 99
      Left = 631
      Top = 189
      Width = 388
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 150
      Top = 165
      Width = 254
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 81
      Top = 165
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 13
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtPrevisDolar: TEditFocus
      Tag = 99
      Left = 502
      Top = 165
      Width = 94
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 15
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValorCotacao: TEditFocus
      Tag = 99
      Left = 846
      Top = 165
      Width = 67
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 17
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnCalcPrevOrcDolar: TBitBtnLocked
      Left = 918
      Top = 165
      Width = 101
      Height = 22
      Hint = 'Atualizar cota'#231#227'o para data atual'
      Anchors = [akTop, akRight]
      Caption = 'Atualizar cota'#231#227'o'
      TabOrder = 18
      TabStop = False
      OnClick = btnCalcPrevOrcDolarClick
    end
    object mskDtaCot: TMaskEditFocus
      Tag = 99
      Left = 690
      Top = 165
      Width = 65
      Height = 22
      TabStop = False
      Anchors = [akTop, akRight]
      EditMask = '99/99/9999'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 16
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtOrcVin: TEditFocus
      Tag = 99
      Left = 376
      Top = 189
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 21
      OnKeyPress = edtOrcVinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmpOrcVin: TEditFocus
      Left = 376
      Top = 213
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 25
      OnExit = edtCodEmpOrcVinExit
      OnKeyPress = edtCodEmpOrcVinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpOrcVin: TEditFocus
      Left = 418
      Top = 213
      Width = 139
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBottom: TPanel [5]
    Left = 0
    Top = 344
    Width = 1034
    Height = 325
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 174
      Width = 1034
      Height = 6
      Align = alTop
      Shape = bsTopLine
      ExplicitTop = 176
      ExplicitWidth = 1026
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 180
      Width = 1034
      Height = 145
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Escopo / Acompanhamento'
        DesignSize = (
          1026
          116)
        object Label10: TLabel
          Left = 8
          Top = 0
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Escopo do projeto'
        end
        object Label11: TLabel
          Left = 513
          Top = 0
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hist'#243'rico de acompanhamento'
        end
        object dbmObs001: TDBMemoFocus
          Left = 5
          Top = 19
          Width = 505
          Height = 95
          DataField = 'LDG_OBS001'
          DataSource = dtsTabela
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbmObs002: TDBMemoFocus
          Left = 513
          Top = 19
          Width = 505
          Height = 95
          Anchors = [akLeft, akTop, akRight]
          DataField = 'LDG_OBS002'
          DataSource = dtsTabela
          ScrollBars = ssVertical
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Hist'#243'rico de Ocorr'#234'ncias'
        ImageIndex = 1
        object dbgMovOcorr: TcxGridCitel
          Left = 0
          Top = 0
          Width = 1026
          Height = 116
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object dbgMovOcorrDBTableView1: TcxGridDBTableViewCitel
            OnDblClick = dbgMovOcorrDBTableView1DblClick
            OnKeyDown = dbgMovOcorrDBTableView1KeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMovOcorr
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.PullFocusing = True
            OptionsData.Deleting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.HideSelection = True
            OptionsView.NoDataToDisplayInfoText = '<Nenhuma Ocorr'#234'ncia para exibi'#231#227'o>'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object dbgMovOcorrDBTableView1IMAGEM1: TcxGridDBColumn
              DataBinding.FieldName = 'IMAGEM1'
              PropertiesClassName = 'TcxImageProperties'
              Properties.FitMode = ifmProportionalStretch
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.ReadOnly = True
              Width = 30
              IsCaptionAssigned = True
            end
            object dbgMovOcorrDBTableView1STATUS: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STATUS'
              Visible = False
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 210
            end
            object dbgMovOcorrDBTableView1OCO_DTAINC: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'OCO_DTAINC'
              Options.Editing = False
            end
            object dbgMovOcorrDBTableView1TOC_DESTOC: TcxGridDBColumn
              Caption = 'Tipo'
              DataBinding.FieldName = 'TOC_DESTOC'
              Options.Editing = False
              Width = 200
            end
            object dbgMovOcorrDBTableView1FGO_VLRCON: TcxGridDBColumn
              Caption = 'Vlr. Documento'
              DataBinding.FieldName = 'FGO_VLRCON'
              HeaderAlignmentHorz = taRightJustify
              Width = 100
            end
            object dbgMovOcorrDBTableView1NUMCMP: TcxGridDBColumn
              Caption = 'Pedido Compra'
              DataBinding.FieldName = 'NUMCMP'
              Width = 100
            end
            object dbgMovOcorrDBTableView1ENTRET: TcxGridDBColumn
              Caption = 'Destino'
              DataBinding.FieldName = 'ENTRET'
            end
            object dbgMovOcorrDBTableView1CLILOJ: TcxGridDBColumn
              Caption = 'Cliente na Loja?'
              DataBinding.FieldName = 'CLILOJ'
              Width = 100
            end
            object dbgMovOcorrDBTableView1OPE_NOMOPE: TcxGridDBColumn
              Caption = 'Usu'#225'rio'
              DataBinding.FieldName = 'OPE_NOMOPE'
              Options.Editing = False
              Width = 150
            end
            object dbgMovOcorrDBTableView1OCO_DTACON: TcxGridDBColumn
              Caption = 'Data Conclus'#227'o'
              DataBinding.FieldName = 'OCO_DTACON'
              Options.Editing = False
              Width = 92
            end
            object dbgMovOcorrDBTableView1OCO_HORCON: TcxGridDBColumn
              Caption = 'Hora Conclus'#227'o'
              DataBinding.FieldName = 'OCO_HORCON'
              Options.Editing = False
              Width = 99
            end
            object dbgMovOcorrDBTableView1OCO_EMERGE: TcxGridDBColumn
              DataBinding.FieldName = 'OCO_EMERGE'
              Visible = False
            end
            object dbgMovOcorrDBTableView1OCO_DTALIM: TcxGridDBColumn
              Caption = 'Limite para conclus'#227'o'
              DataBinding.FieldName = 'OCO_DTALIM'
              Options.Editing = False
              Width = 152
            end
            object dbgMovOcorrDBTableView1HOREXC: TcxGridDBColumn
              DataBinding.FieldName = 'HOREXC'
              Visible = False
            end
            object dbgMovOcorrDBTableView1OCO_TMPLIM: TcxGridDBColumn
              DataBinding.FieldName = 'OCO_TMPLIM'
              Visible = False
            end
            object dbgMovOcorrDBTableView1OCO_METLIM: TcxGridDBColumn
              DataBinding.FieldName = 'OCO_METLIM'
              Visible = False
            end
            object dbgMovOcorrDBTableView1STATUSDEPS: TcxGridDBColumn
              Caption = 'Valida'#231#227'o DEPS'
              DataBinding.FieldName = 'STATUSDEPS'
              Visible = False
              VisibleForEditForm = bTrue
            end
            object dbgMovOcorrDBTableView1CAT_DESCRI: TcxGridDBColumn
              Caption = 'Categoria'
              DataBinding.FieldName = 'CAT_DESCRI'
              Width = 200
            end
            object dbgMovOcorrDBTableView1NumDoc: TcxGridDBColumn
              Caption = 'Documento'
              DataBinding.FieldName = 'NUMDOC'
              Width = 135
            end
            object dbgMovOcorrDBTableView1DOCCON: TcxGridDBColumn
              Caption = 'Doc. Confirma'#231#227'o'
              DataBinding.FieldName = 'DOCCON'
            end
          end
          object dbgMovOcorrLevel1: TcxGridLevel
            GridView = dbgMovOcorrDBTableView1
          end
        end
      end
    end
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 1034
      Height = 174
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label25: TLabel
        Left = 207
        Top = 6
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot.Previs'#227'o Or'#231'. R$:'
      end
      object Label15: TLabel
        Left = 26
        Top = 28
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object Label8: TLabel
        Left = 5
        Top = 52
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor ext.:'
      end
      object Label9: TLabel
        Left = 26
        Top = 77
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Instalador:'
      end
      object Label24: TLabel
        Left = 4
        Top = 101
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de cliente:'
      end
      object Label12: TLabel
        Left = 7
        Top = 125
        Width = 69
        Height = 14
        Caption = 'Fase da Obra:'
      end
      object Label13: TLabel
        Left = 252
        Top = 151
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o Or'#231'.:'
      end
      object Label29: TLabel
        Left = 2
        Top = 6
        Width = 105
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Previs'#227'o Or'#231'. U$:'
      end
      object lblDataFlw: TLabel
        Left = 3
        Top = 151
        Width = 170
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Acompanhamento(Follow Up):'
      end
      object pnlCategoria: TPanel
        Left = 419
        Top = -1
        Width = 404
        Height = 25
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 12
        object LbCategoria: TLabel
          Left = 16
          Top = 7
          Width = 49
          Height = 14
          Caption = 'Categoria:'
        end
        object dbeCodCat: TDBEditFocus
          Tag = 99
          Left = 71
          Top = 3
          Width = 47
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LDG_CODCAT'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodCatKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtNomCat: TEditFocus
          Left = 121
          Top = 3
          Width = 273
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      object dbeTotVpr: TDBEditFocus
        Left = 310
        Top = 1
        Width = 95
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'LDG_TOTVPR'
        DataSource = dtsTabela
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TDBEditFocus
        Tag = 99
        Left = 82
        Top = 25
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LDG_CODVEN'
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
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = edtCodVenChamaCadastro
      end
      object edtNomVen: TEditFocus
        Left = 132
        Top = 25
        Width = 272
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
      object edtNomExt: TEditFocus
        Left = 132
        Top = 50
        Width = 272
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
      object dbeVenExt: TDBEditFocus
        Tag = 99
        Left = 82
        Top = 49
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LDG_VENEXT'
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
        OnKeyPress = dbeVenExtKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeVenExtChamaCadastro
      end
      object dbeCodIns: TDBEditFocus
        Tag = 99
        Left = 82
        Top = 74
        Width = 76
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LDG_CODINS'
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
        OnKeyPress = dbeCodInsKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeVenExtChamaCadastro
      end
      object edtNomIns: TEditFocus
        Left = 160
        Top = 74
        Width = 244
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
      object edtTipIns: TEditFocus
        Left = 82
        Top = 97
        Width = 322
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object dbeCodFas: TDBEditFocus
        Tag = 99
        Left = 82
        Top = 123
        Width = 48
        Height = 22
        DataField = 'LDG_CODFAS'
        DataSource = dtsTabela
        TabOrder = 8
        OnKeyPress = dbeCodFasKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtNomFas: TEditFocus
        Left = 132
        Top = 123
        Width = 272
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object dbePreOrd: TDBEditFocus
        Tag = 99
        Left = 327
        Top = 147
        Width = 77
        Height = 22
        DataField = 'LDG_PREORC'
        DataSource = dtsTabela
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object GroupBox1: TGroupBox
        Left = 419
        Top = 25
        Width = 404
        Height = 137
        Caption = 'Concorrentes'
        TabOrder = 13
        object Label21: TLabel
          Left = 14
          Top = 14
          Width = 51
          Height = 14
          Caption = 'Fabricante'
        end
        object Label22: TLabel
          Left = 14
          Top = 54
          Width = 49
          Height = 14
          Caption = 'Integrador'
        end
        object Label23: TLabel
          Left = 14
          Top = 94
          Width = 54
          Height = 14
          Caption = 'Distribuidor'
        end
        object dbeConFab: TDBEditFocus
          Tag = 99
          Left = 14
          Top = 31
          Width = 379
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LDG_CONFAB'
          DataSource = dtsTabela
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConInt: TDBEditFocus
          Tag = 99
          Left = 14
          Top = 69
          Width = 379
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LDG_CONINT'
          DataSource = dtsTabela
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConDis: TDBEditFocus
          Tag = 99
          Left = 14
          Top = 111
          Width = 379
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LDG_CONDIS'
          DataSource = dtsTabela
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object grbStatus: TGroupBox
        Left = 829
        Top = -2
        Width = 197
        Height = 131
        Caption = 'Informa'#231#245'es Gerais do Lead'
        TabOrder = 14
        object lblStatus: TLabel
          Left = 8
          Top = 26
          Width = 34
          Height = 14
          Caption = 'Status:'
        end
        object lblDtaFin: TLabel
          Left = 8
          Top = 52
          Width = 82
          Height = 14
          Caption = 'Data Finaliza'#231#227'o:'
        end
        object lblHorFin: TLabel
          Left = 8
          Top = 80
          Width = 83
          Height = 14
          Caption = 'Hora Finaliza'#231#227'o:'
        end
        object lblOpeFin: TLabel
          Left = 8
          Top = 108
          Width = 57
          Height = 14
          Caption = 'Oper. Final.:'
        end
        object lblStatusLead: TLabel
          Left = 48
          Top = 28
          Width = 142
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          StyleElements = [seClient, seBorder]
        end
        object edtDtaFin: TEditFocus
          Left = 97
          Top = 47
          Width = 93
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtHorFin: TEditFocus
          Left = 97
          Top = 75
          Width = 93
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtOpeFin: TEditFocus
          Left = 65
          Top = 103
          Width = 125
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
      end
      object dbeTotVprDolar: TDBEditFocus
        Left = 108
        Top = 1
        Width = 95
        Height = 22
        TabStop = False
        BiDiMode = bdRightToLeft
        Color = 16768952
        DataField = 'TOT_PREVIS_DLR'
        DataSource = dtsItens
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DEDTAFLW: TDBEditFocus
        Tag = 99
        Left = 173
        Top = 147
        Width = 77
        Height = 22
        DataField = 'LDG_DTAFLW'
        DataSource = dtsTabela
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  object cxgItens: TcxGridCitel [6]
    Tag = 99
    Left = 0
    Top = 261
    Width = 1034
    Height = 74
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel
      OnDblClick = cxgItensDBTableViewCitel1DblClick
      OnKeyUp = cxgItensDBTableViewCitel1KeyUp
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensDBTableViewCitel1CODGRU: TcxGridDBColumn
        Caption = 'Linha/Grupo'
        DataBinding.FieldName = 'CODGRU'
        Width = 73
      end
      object cxgItensDBTableViewCitel1DESGRU: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESGRU'
        Width = 189
      end
      object cxgItensDBTableViewCitel1PREVIS: TcxGridDBColumn
        Caption = 'Previs'#227'o Or'#231'. R$'
        DataBinding.FieldName = 'PREVIS'
        Width = 98
      end
      object cxgItensDBTableViewCitel1LDD_PRVDLR: TcxGridDBColumn
        Caption = 'Previs'#227'o Or'#231'. U$'
        DataBinding.FieldName = 'LDD_PRVDLR'
        Width = 92
      end
      object cxgItensDBTableViewCitel1ORCVIN: TcxGridDBColumn
        Caption = 'Or'#231'amento Vinc.'
        DataBinding.FieldName = 'ORCVIN'
        Width = 110
      end
      object cxgItensDBTableViewCitel1MARCA: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MARCA'
      end
      object cxgItensDBTableViewCitel1KAFORN: TcxGridDBColumn
        Caption = 'Nome Kam'
        DataBinding.FieldName = 'KAFORN'
      end
      object cxgItensDBTableViewCitel1CODPVE: TcxGridDBColumn
        Caption = 'C'#243'd. pr'#233' venda'
        DataBinding.FieldName = 'CODPVE'
        Width = 80
      end
      object cxgItensDBTableViewCitel1NOMPVE: TcxGridDBColumn
        Caption = 'Nome pr'#233' venda'
        DataBinding.FieldName = 'NOMPVE'
        Width = 162
      end
      object cxgItensDBTableViewCitel1REGIST: TcxGridDBColumn
        Caption = 'Reg.'
        DataBinding.FieldName = 'REGIST'
        Width = 31
      end
      object cxgItensDBTableViewCitel1NUMREG: TcxGridDBColumn
        Caption = 'N'#250'mero registro'
        DataBinding.FieldName = 'NUMREG'
      end
      object cxgItensDBTableViewCitel1DESCON: TcxGridDBColumn
        Caption = 'Desc.'
        DataBinding.FieldName = 'DESCON'
        Width = 37
      end
      object cxgItensDBTableViewCitel1AUTDES: TcxGridDBColumn
        Caption = 'Autoriza'#231#227'o do desconto'
        DataBinding.FieldName = 'AUTDES'
      end
      object cxgItensDBTableViewCitel1OBSERV: TcxGridDBColumn
        Caption = 'Observa'#231#245'es'
        DataBinding.FieldName = 'OBSERV'
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensDBTableViewCitel1
    end
  end
  object dtsTabela: TDataSource
    Left = 336
    Top = 92
  end
  object cdsMovOcorr: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 536
    object cdsMovOcorrOCO_CODOCO: TStringField
      FieldName = 'OCO_CODOCO'
      Size = 8
    end
    object cdsMovOcorrOCO_CODTOC: TStringField
      FieldName = 'OCO_CODTOC'
      Size = 5
    end
    object cdsMovOcorrOCO_CODCLI: TStringField
      FieldName = 'OCO_CODCLI'
      Size = 8
    end
    object cdsMovOcorrOCO_DTAINC: TDateField
      FieldName = 'OCO_DTAINC'
    end
    object cdsMovOcorrOCO_HORINC: TTimeField
      FieldName = 'OCO_HORINC'
    end
    object cdsMovOcorrOCO_DTACON: TDateField
      FieldName = 'OCO_DTACON'
    end
    object cdsMovOcorrOCO_HORCON: TTimeField
      FieldName = 'OCO_HORCON'
    end
    object cdsMovOcorrOCO_CODOPE: TStringField
      FieldName = 'OCO_CODOPE'
      Size = 3
    end
    object cdsMovOcorrOCO_DESCRI: TMemoField
      FieldName = 'OCO_DESCRI'
      BlobType = ftMemo
    end
    object cdsMovOcorrOCO_CODEMP: TStringField
      FieldName = 'OCO_CODEMP'
      Size = 3
    end
    object cdsMovOcorrAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMovOcorrCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsMovOcorrTOC_DESTOC: TStringField
      FieldName = 'TOC_DESTOC'
      Size = 40
    end
    object cdsMovOcorrOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsMovOcorrIMAGEM1: TBlobField
      FieldName = 'IMAGEM1'
    end
    object cdsMovOcorrHOREXC: TFloatField
      FieldName = 'HOREXC'
    end
    object cdsMovOcorrOCO_EMERGE: TStringField
      FieldName = 'OCO_EMERGE'
      Size = 1
    end
    object cdsMovOcorrOCO_DTALIM: TDateTimeField
      FieldName = 'OCO_DTALIM'
      DisplayFormat = 'dd/mm/yyyy hh:nn:ss'
    end
    object cdsMovOcorrOCO_TMPLIM: TFloatField
      FieldName = 'OCO_TMPLIM'
    end
    object cdsMovOcorrOCO_METLIM: TFloatField
      FieldName = 'OCO_METLIM'
    end
    object cdsMovOcorrNUMDOC: TStringField
      FieldName = 'NUMDOC'
    end
    object cdsMovOcorrOCO_CODSIT: TStringField
      FieldName = 'OCO_CODSIT'
      Size = 3
    end
    object cdsMovOcorrFGO_VLRCON: TFloatField
      FieldName = 'FGO_VLRCON'
      DisplayFormat = '#,##0.00'
    end
    object cdsMovOcorrOCO_PROTOC: TStringField
      FieldName = 'OCO_PROTOC'
      Size = 22
    end
    object cdsMovOcorrSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 50
    end
    object cdsMovOcorrNUMCMP: TStringField
      FieldName = 'NUMCMP'
      Size = 50
    end
    object cdsMovOcorrENTRET: TStringField
      FieldName = 'ENTRET'
      Size = 10
    end
    object cdsMovOcorrCLILOJ: TStringField
      FieldName = 'CLILOJ'
      Size = 10
    end
    object cdsMovOcorrFGO_STATUS: TIntegerField
      FieldName = 'FGO_STATUS'
    end
    object cdsMovOcorrDOCCON: TStringField
      FieldName = 'DOCCON'
      Size = 200
    end
    object cdsMovOcorrUSADEPS: TStringField
      FieldName = 'USADEPS'
      Size = 1
    end
    object cdsMovOcorrSTATUSDEPS: TStringField
      FieldName = 'STATUSDEPS'
    end
    object cdsMovOcorrAUTOINCREMFATGOR: TStringField
      FieldName = 'AUTOINCREMFATGOR'
    end
    object cdsMovOcorrMOTBAI: TStringField
      FieldName = 'MOTBAI'
      Size = 300
    end
    object cdsMovOcorrCAT_DESCRI: TStringField
      FieldName = 'CAT_DESCRI'
      Size = 60
    end
  end
  object dtsMovOcorr: TDataSource
    DataSet = cdsMovOcorr
    Left = 296
    Top = 536
  end
  object cdsItens: TUniClientDataSet
    PersistDataPacket.Data = {
      350200009619E0BD010000001800000015000000000003000000350206434F44
      4752550100490000000100055749445448020002000700064445534752550100
      490000000100055749445448020002003C000650524556495308000400000000
      00064F4253455256010049000000010005574944544802000200FA0006434F44
      4B414D0100490000000100055749445448020002000300064E4F4D4B414D0100
      490000000100055749445448020002003C00064D4F4544415F01004900000001
      0005574944544802000200010006434F44505645010049000000010005574944
      5448020002000300064E4F4D5056450100490000000100055749445448020002
      003C000652454749535401004900000001000557494454480200020001000644
      4553434F4E0100490000000100055749445448020002000100064E554D524547
      0100490000000100055749445448020002001E00064155544445530100490000
      000100055749445448020002001E00064B41464F524E01004900000001000557
      4944544802000200280006434F444D4152010049000000010005574944544802
      0002000600064445534D41520100490000000100055749445448020002001E00
      0A4C44445F505256444C5208000400000000000A4C44445F445441434F540800
      0800000000000A4C44445F564C52434F5408000400000000000A4C44445F4F52
      4356494E0100490000000100055749445448020002000C000A4C44445F454D50
      4F524301004900000001000557494454480200020003000000}
    Active = True
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'CODGRU'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'DESGRU'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'PREVIS'
        DataType = ftFloat
      end
      item
        Name = 'OBSERV'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'CODKAM'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NOMKAM'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'MOEDA_'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODPVE'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NOMPVE'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'REGIST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESCON'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMREG'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'AUTDES'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'KAFORN'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'CODMAR'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'DESMAR'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'LDD_PRVDLR'
        DataType = ftFloat
      end
      item
        Name = 'LDD_DTACOT'
        DataType = ftDateTime
      end
      item
        Name = 'LDD_VLRCOT'
        DataType = ftFloat
      end
      item
        Name = 'LDD_ORCVIN'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'LDD_EMPORC'
        DataType = ftString
        Size = 3
      end>
    IndexDefs = <>
    FetchOnDemand = False
    Params = <>
    StoreDefs = True
    AfterDelete = cdsItensAfterDelete
    OnCalcFields = cdsItensCalcFields
    Left = 180
    Top = 276
    object cdsItensCODGRU: TStringField
      FieldName = 'CODGRU'
      Size = 7
    end
    object cdsItensDESGRU: TStringField
      FieldName = 'DESGRU'
      Size = 60
    end
    object cdsItensPREVIS: TFloatField
      FieldName = 'PREVIS'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensOBSERV: TStringField
      FieldName = 'OBSERV'
      Size = 250
    end
    object cdsItensCODKAM: TStringField
      FieldName = 'CODKAM'
      Size = 3
    end
    object cdsItensNOMKAM: TStringField
      FieldName = 'NOMKAM'
      Size = 60
    end
    object cdsItensMOEDA_: TStringField
      FieldName = 'MOEDA_'
      Size = 1
    end
    object cdsItensCODPVE: TStringField
      FieldName = 'CODPVE'
      Size = 3
    end
    object cdsItensNOMPVE: TStringField
      FieldName = 'NOMPVE'
      Size = 60
    end
    object cdsItensREGIST: TStringField
      FieldName = 'REGIST'
      Size = 1
    end
    object cdsItensDESCON: TStringField
      FieldName = 'DESCON'
      Size = 1
    end
    object cdsItensNUMREG: TStringField
      FieldName = 'NUMREG'
      Size = 30
    end
    object cdsItensAUTDES: TStringField
      FieldName = 'AUTDES'
      Size = 30
    end
    object cdsItensKAFORN: TStringField
      FieldName = 'KAFORN'
      Size = 40
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensMARCA: TStringField
      FieldKind = fkCalculated
      FieldName = 'MARCA'
      Calculated = True
    end
    object cdsItensLDD_PRVDLR: TFloatField
      FieldName = 'LDD_PRVDLR'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensLDD_DTACOT: TDateTimeField
      FieldName = 'LDD_DTACOT'
    end
    object cdsItensLDD_VLRCOT: TFloatField
      FieldName = 'LDD_VLRCOT'
    end
    object cdsItensORCVIN: TStringField
      FieldKind = fkCalculated
      FieldName = 'ORCVIN'
      Size = 16
      Calculated = True
    end
    object cdsItensLDD_ORCVIN: TStringField
      FieldName = 'LDD_ORCVIN'
      Size = 12
    end
    object cdsItensLDD_EMPORC: TStringField
      FieldName = 'LDD_EMPORC'
      Size = 3
    end
    object cdsItensTOT_PREVIS: TAggregateField
      FieldName = 'TOT_PREVIS'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(PREVIS)'
    end
    object cdsItensTOT_PREVIS_DLR: TAggregateField
      FieldName = 'TOT_PREVIS_DLR'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(LDD_PRVDLR)'
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 232
    Top = 276
  end
end
