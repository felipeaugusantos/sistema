inherited frmCadMetasClientes: TfrmCadMetasClientes
  Left = 418
  Top = 238
  Width = 643
  Height = 675
  BorderIcons = [biSystemMenu]
  Caption = 'Metas de Clientes'
  Position = poScreenCenter
  ExplicitWidth = 643
  ExplicitHeight = 675
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 604
    Width = 637
    Height = 26
    TabOrder = 5
    ExplicitTop = 604
    ExplicitWidth = 637
    ExplicitHeight = 26
    DesignSize = (
      637
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 633
      Height = 22
      ExplicitWidth = 633
      ExplicitHeight = 22
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnGerarCredito: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F9 ] Gerar Cr'#233'dito'
        TabOrder = 1
        OnClick = btnGerarCreditoClick
      end
      object btnCredRealizados: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F8 ] Cr'#233'd. Realizados'
        TabOrder = 2
        OnClick = btnCredRealizadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 558
      Top = 2
      ExplicitLeft = 558
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 630
    Width = 637
    TabOrder = 6
    ExplicitTop = 630
    ExplicitWidth = 637
    inherited pnlNomeForm: TPanel
      Left = 466
      ExplicitLeft = 466
    end
    inherited pnlInfo: TPanel
      Width = 466
      ExplicitWidth = 466
    end
  end
  object pnlCliVen: TPanel [2]
    Left = 0
    Top = 0
    Width = 637
    Height = 97
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 45
      Top = 40
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 30
      Top = 66
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label7: TLabel
      Left = 8
      Top = 14
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 83
      Top = 36
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object edtDesCli: TEditFocus
      Left = 164
      Top = 36
      Width = 434
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 83
      Top = 62
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object edtDesVen: TEditFocus
      Left = 164
      Top = 62
      Width = 434
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 83
      Top = 10
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
    end
    object edtDesRed: TEditFocus
      Left = 164
      Top = 10
      Width = 434
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
  object dbgMetas: TDBGridCitel [3]
    Left = 0
    Top = 414
    Width = 637
    Height = 159
    Align = alClient
    DataSource = dtsMetas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgMetasKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODMAR'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 274
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAINI'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAFIN'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPMET'
        Title.Caption = 'V/L'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 20
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALMET'
        Title.Alignment = taRightJustify
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALDES'
        Title.Alignment = taRightJustify
        Title.Caption = '% Desc.'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end>
  end
  object pnlMetas: TPanel [4]
    Left = 0
    Top = 252
    Width = 637
    Height = 162
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label4: TLabel
      Left = 39
      Top = 40
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label6: TLabel
      Left = 33
      Top = 13
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label9: TLabel
      Left = 346
      Top = 136
      Width = 62
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% Desc.:'
    end
    object Label1: TLabel
      Left = 157
      Top = 13
      Width = 11
      Height = 14
      AutoSize = False
      Caption = #224
    end
    object Label2: TLabel
      Left = 218
      Top = 136
      Width = 45
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Vr. Meta:'
    end
    object lbl2: TLabel
      Left = 10
      Top = 64
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
    object lbl3: TLabel
      Left = 13
      Top = 88
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lbl4: TLabel
      Left = 23
      Top = 136
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Meta:'
    end
    object ColorLabel2: TColorLabel
      Left = 105
      Top = 136
      Width = 98
      Height = 14
      Caption = '(V)alor (L)itros/Kilos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblCodDep: TLabel
      Left = 2
      Top = 112
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object Label5: TLabel
      Left = 257
      Top = 13
      Width = 187
      Height = 14
      Alignment = taRightJustify
      Caption = 'Perc. Heran'#231'a aplic. sobre '#250'lt. per'#237'odo:'
    end
    object mskLinGru: TMaskEditFocus
      Left = 74
      Top = 60
      Width = 60
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 6
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 74
      Top = 36
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 4
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtValDes: TEditFocus
      Tag = 99
      Left = 409
      Top = 132
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 14
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
    object edtDesMar: TEditFocus
      Left = 135
      Top = 36
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 74
      Top = 9
      Width = 74
      Height = 22
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 173
      Top = 9
      Width = 74
      Height = 22
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtValMet: TEditFocus
      Tag = 99
      Left = 265
      Top = 132
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 13
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
    object edtDesGru: TEditFocus
      Left = 135
      Top = 60
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 74
      Top = 84
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 8
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesFor: TEditFocus
      Left = 135
      Top = 84
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTipMet: TEditFocus
      Tag = 99
      Left = 74
      Top = 132
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 12
      Text = 'V'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 135
      Top = 108
      Width = 359
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
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 74
      Top = 108
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 10
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 497
      Top = 60
      Width = 129
      Height = 22
      Caption = '&Adicionar'
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
      TabOrder = 15
      OnClick = btnAdicionarClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 497
      Top = 84
      Width = 129
      Height = 22
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
      TabOrder = 16
      OnClick = btnCancelarClick
    end
    object edtPercHeranca: TEditFocus
      Tag = 99
      Left = 448
      Top = 9
      Width = 46
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
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
    object btnHerdar: TBitBtnLocked
      Left = 497
      Top = 9
      Width = 129
      Height = 22
      Caption = '&Herdar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006714F44BE9E6D5DFF9E6C5DFF9D6C
        5CFF9D6B5BFF9C6B5BFF9C6B5BFF9C6A5AFF9B6959FF704B41BE000000000000
        000000000000000000000000000000000009DCC8BFFFF8F1ECFFF7EEE9FFCCAB
        9FFFF7EEEAFFF7EEE9FFCCAB9FFFF7EEE9FFF7EEE9FF9D6C5CFF000000000000
        0000000000000000000000000000000000095B997BFFE4E0D9FFF8F0EBFFDCC3
        BAFFF7EEEAFFF7EEEAFFCCACA0FFF8EEEAFFF9F2EFFF9F7061FF000000000000
        000000000000000000000000000000000008137248FF184E30FFA4AFA2FFF8F0
        EBFFEADBD4FFD1B3A7FFCEADA2FFCDADA2FFD9BFB6FFA37464FF000000000000
        0000000000000000000103190C5C052D17AD147449FF2ECA96FF126B45FF4F6F
        58FFE4E0D9FFF8F0EBFFDCC5BCFFF8F0EBFFFAF4F1FFA67969FF000000070000
        000B0000000C052714861F8259FF30AF82FF3CD4A3FF3EDDABFF3BDCA8FF2EA8
        7DFF1B5033FFA4B0A2FFDDC6BDFFF8F0ECFFF9F3F1FFAA7E6FFF856053BEE3CD
        C3FFA2B8A7FF2B8A64FF6CECC7FF69EBC6FF6EEBC7FF4DE4B5FF5DE7BFFF4AC3
        9BFF2D8860FFAEC6B4FFDEC6BEFFD0B2A7FFDBC4BAFFAE8274FFBB8978FFF8F0
        ECFF5C8D70FF4BB68FFF2A8E64FF298E63FF197A4EFF6BE4C1FF359E76FF61A0
        81FFE5E6DEFFF8F0EBFFDDC6BDFFF8F0EDFFFAF5F2FFB28879FFBE8E7EFFF8F0
        ECFF45946EFF8AB89EFFD4DDD1FFF8F0EBFF1B7D4FFF348F66FFB1CBB9FFF8F0
        EBFFF9F2EDFFFAF5F1FFDCC5BDFFFAF5F2FFFAF4F2FFB68D7FFFC19383FFF1E5
        E0FF90B69DFFEEE1DBFFDDC8C0FFF8F0EBFF66A685FFE6E7DEFFF3E9E3FFCFB2
        A7FFBC9487FFBB9487FFBB9385FFBA9285FFBA9184FF8A6C61C0C59A89FFF9F2
        EEFFF8F0ECFFDCC6BDFFF8EFEBFFF8F0ECFFEDE1DCFFF8F2EDFFFAF6F4FFDCC7
        BEFF0000000B0000000300000004000000040000000300000002C89E8FFFF9F4
        F2FFF8F0EDFFC6A599FFF7F0ECFFF8F0EDFFC5A499FFF8F0ECFFF9F3F1FFC397
        87FF000000070000000000000000000000000000000000000000C48F63FFDBB5
        8FFFCF9F71FFCF9E6FFFCF9D6EFFCF9D6EFFCE9B6EFFCE9A6CFFDAB089FFC28B
        5FFF000000070000000000000000000000000000000000000000C79469FFEEDA
        B8FFE9CEA3FFCDA381FFE8CEA3FFE8CEA3FFCCA27EFFE8CDA3FFEED9B7FFC491
        65FF000000060000000000000000000000000000000000000000CA9A6EFFEFDA
        B9FFEEDAB8FFDBBA9EFFEEDAB8FFEEDAB8FFDAB89BFFEEDAB8FFEEDAB8FFC897
        6BFF000000050000000000000000000000000000000000000000987655BFCC9E
        71FFCC9D71FFCC9C70FFCB9B6FFFCA9A6EFFC9986DFFC9986CFFCC9C70FF9774
        53C0000000030000000000000000000000000000000000000000}
      TabOrder = 3
      OnClick = btnHerdarClick
    end
    object btnImportacao: TBitBtnLocked
      Left = 497
      Top = 136
      Width = 104
      Height = 22
      Caption = 'Importar Excel'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006714F44BE9E6D5DFF9E6C5DFF9D6C
        5CFF9D6B5BFF9C6B5BFF9C6B5BFF9C6A5AFF9B6959FF704B41BE000000000000
        000000000000000000000000000000000009DCC8BFFFF8F1ECFFF7EEE9FFCCAB
        9FFFF7EEEAFFF7EEE9FFCCAB9FFFF7EEE9FFF7EEE9FF9D6C5CFF000000000000
        0000000000000000000000000000000000095B997BFFE4E0D9FFF8F0EBFFDCC3
        BAFFF7EEEAFFF7EEEAFFCCACA0FFF8EEEAFFF9F2EFFF9F7061FF000000000000
        000000000000000000000000000000000008137248FF184E30FFA4AFA2FFF8F0
        EBFFEADBD4FFD1B3A7FFCEADA2FFCDADA2FFD9BFB6FFA37464FF000000000000
        0000000000000000000103190C5C052D17AD147449FF2ECA96FF126B45FF4F6F
        58FFE4E0D9FFF8F0EBFFDCC5BCFFF8F0EBFFFAF4F1FFA67969FF000000070000
        000B0000000C052714861F8259FF30AF82FF3CD4A3FF3EDDABFF3BDCA8FF2EA8
        7DFF1B5033FFA4B0A2FFDDC6BDFFF8F0ECFFF9F3F1FFAA7E6FFF856053BEE3CD
        C3FFA2B8A7FF2B8A64FF6CECC7FF69EBC6FF6EEBC7FF4DE4B5FF5DE7BFFF4AC3
        9BFF2D8860FFAEC6B4FFDEC6BEFFD0B2A7FFDBC4BAFFAE8274FFBB8978FFF8F0
        ECFF5C8D70FF4BB68FFF2A8E64FF298E63FF197A4EFF6BE4C1FF359E76FF61A0
        81FFE5E6DEFFF8F0EBFFDDC6BDFFF8F0EDFFFAF5F2FFB28879FFBE8E7EFFF8F0
        ECFF45946EFF8AB89EFFD4DDD1FFF8F0EBFF1B7D4FFF348F66FFB1CBB9FFF8F0
        EBFFF9F2EDFFFAF5F1FFDCC5BDFFFAF5F2FFFAF4F2FFB68D7FFFC19383FFF1E5
        E0FF90B69DFFEEE1DBFFDDC8C0FFF8F0EBFF66A685FFE6E7DEFFF3E9E3FFCFB2
        A7FFBC9487FFBB9487FFBB9385FFBA9285FFBA9184FF8A6C61C0C59A89FFF9F2
        EEFFF8F0ECFFDCC6BDFFF8EFEBFFF8F0ECFFEDE1DCFFF8F2EDFFFAF6F4FFDCC7
        BEFF0000000B0000000300000004000000040000000300000002C89E8FFFF9F4
        F2FFF8F0EDFFC6A599FFF7F0ECFFF8F0EDFFC5A499FFF8F0ECFFF9F3F1FFC397
        87FF000000070000000000000000000000000000000000000000C48F63FFDBB5
        8FFFCF9F71FFCF9E6FFFCF9D6EFFCF9D6EFFCE9B6EFFCE9A6CFFDAB089FFC28B
        5FFF000000070000000000000000000000000000000000000000C79469FFEEDA
        B8FFE9CEA3FFCDA381FFE8CEA3FFE8CEA3FFCCA27EFFE8CDA3FFEED9B7FFC491
        65FF000000060000000000000000000000000000000000000000CA9A6EFFEFDA
        B9FFEEDAB8FFDBBA9EFFEEDAB8FFEEDAB8FFDAB89BFFEEDAB8FFEEDAB8FFC897
        6BFF000000050000000000000000000000000000000000000000987655BFCC9E
        71FFCC9D71FFCC9C70FFCB9B6FFFCA9A6EFFC9986DFFC9986CFFCC9C70FF9774
        53C0000000030000000000000000000000000000000000000000}
      TabOrder = 17
      OnClick = btnImportacaoClick
    end
    object btnHlpImp: TBitBtnLocked
      Left = 603
      Top = 136
      Width = 23
      Height = 22
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      OnClick = btnHlpImpClick
    end
  end
  object pnlRodape: TPanel [5]
    Left = 0
    Top = 579
    Width = 637
    Height = 25
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    object dbtxt1: TDBText
      Left = 8
      Top = 5
      Width = 573
      Height = 15
      DataField = 'DESMAR'
      DataSource = dtsMetas
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlClientes: TPanel [6]
    Left = 0
    Top = 97
    Width = 637
    Height = 124
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object dbgClientes: TDBGridCitel
      Left = 1
      Top = 1
      Width = 635
      Height = 122
      Align = alClient
      DataSource = dtsClientes
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgClientesDrawColumnCell
      OnKeyDown = dbgClientesKeyDown
      OnTitleClick = dbgClientesTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'MARCA'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODCLI'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 490
          Visible = True
        end>
    end
  end
  object pgbProgresso: TProgressBar [7]
    Left = 0
    Top = 573
    Width = 637
    Height = 6
    Align = alBottom
    TabOrder = 8
  end
  object pnlMarcacao: TPanel [8]
    Left = 0
    Top = 221
    Width = 637
    Height = 31
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object btnMarcaTodos: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 91
      Height = 23
      Caption = '&Marcar Todos'
      TabOrder = 0
      OnClick = btnMarcaTodosClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 94
      Top = 3
      Width = 109
      Height = 23
      Caption = '&Desmarcar Todos'
      TabOrder = 1
      OnClick = btnDesmarcaTodosClick
    end
    object btnInverteSelecao: TBitBtnLocked
      Left = 204
      Top = 3
      Width = 111
      Height = 23
      Caption = '&Inverter Sele'#231#227'o'
      TabOrder = 2
      OnClick = btnInverteSelecaoClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 87
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 87
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 87
  end
  object dtsMetas: TDataSource
    DataSet = cdsMetas
    Left = 520
    Top = 87
  end
  object cdsMetas: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODCLI'
        DataType = ftString
        Size = 8
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
        Name = 'DTAINI'
        DataType = ftDateTime
      end
      item
        Name = 'DTAFIN'
        DataType = ftDateTime
      end
      item
        Name = 'VALMET'
        DataType = ftFloat
      end
      item
        Name = 'VALDES'
        DataType = ftFloat
      end
      item
        Name = 'CODEMP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODGRU'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESGRU'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODFOR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMFOR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPMET'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'LITRAG'
        DataType = ftFloat
      end
      item
        Name = 'CODDEP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'DESDEP'
        DataType = ftString
        Size = 70
      end>
    IndexDefs = <>
    IndexFieldNames = 'DTAINI;CODMAR'
    Params = <>
    StoreDefs = True
    Left = 551
    Top = 87
    object cdsMetasCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsMetasCODMAR: TStringField
      DisplayLabel = 'Marca'
      DisplayWidth = 6
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsMetasDESMAR: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESMAR'
      Size = 200
    end
    object cdsMetasDTAINI: TDateTimeField
      DisplayLabel = 'Dt. Inicial'
      FieldName = 'DTAINI'
      EditMask = 'dd/mm/yyyy'
    end
    object cdsMetasDTAFIN: TDateTimeField
      DisplayLabel = 'Dt. Final'
      FieldName = 'DTAFIN'
      EditMask = 'dd/mm/yyyy'
    end
    object cdsMetasVALMET: TFloatField
      DisplayLabel = 'Vr. Meta'
      FieldName = 'VALMET'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsMetasVALDES: TFloatField
      DisplayLabel = '% Desconto'
      FieldName = 'VALDES'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsMetasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsMetasAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsMetasCODGRU: TStringField
      FieldName = 'CODGRU'
      Size = 6
    end
    object cdsMetasDESGRU: TStringField
      FieldName = 'DESGRU'
      Size = 70
    end
    object cdsMetasCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsMetasNOMFOR: TStringField
      FieldName = 'NOMFOR'
    end
    object cdsMetasTIPMET: TStringField
      FieldName = 'TIPMET'
      Size = 1
    end
    object cdsMetasLITRAG: TFloatField
      FieldName = 'LITRAG'
    end
    object cdsMetasCODDEP: TStringField
      FieldName = 'CODDEP'
      Size = 3
    end
    object cdsMetasDESDEP: TStringField
      FieldName = 'DESDEP'
      Size = 70
    end
  end
  object popSelecao: TPopupMenu
    Left = 392
    Top = 87
    object mniMarcarTodos: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = mniMarcarTodosClick
    end
    object mniDesmarcarTodos: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = mniDesmarcarTodosClick
    end
    object mniInverterSelecao: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = mniInverterSelecaoClick
    end
  end
  object cdsClientes: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsClientesAfterScroll
    Left = 359
    Top = 87
    object cdsClientesMARCA: TStringField
      DisplayLabel = ' '
      FieldName = 'MARCA'
      Size = 1
    end
    object cdsClientesCODCLI: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsClientesNOMCLI: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCLI'
      Size = 60
    end
  end
  object imgLista: TImageList
    DrawingStyle = dsTransparent
    Left = 295
    Top = 87
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000FDFDFD00F3F3
      F300BEBCD300655BA600352892001D0E89001C0E8900332790006459A300B8B5
      CD00F1F1F100FCFCFC000000000000000000000000000000000000000000FDFD
      FD00F8F8F800F3F3F300EFEFEF00EDEDED00EEEEEE00F1F1F100F7F7F700FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC00E7E7EB006960
      AB00211593002225AE002430C2002535CB002535CC002430C3002225AF002115
      94006157A500E2E2E600FBFBFB000000000000000000FEFEFE00FBFBFB00EDEE
      EE0093B0A30050876F00216B4B00216B4B00216C4B00477F670089AA9C00EAEB
      EB00FAFAFA00FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EBEBED004D44A2002522
      A6002D3DCC00394BD3003445D1002939CD002839CD003344D000394AD4002D3C
      CD002523A800483E9C00E3E3E700FCFCFC0000000000FAFAFA00CFD9D4003F7E
      630024805C0029AC7E002CC592002DC894002DC693002AAE8000258560004581
      6800C7D3CE00F8F8F800FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F6F6F600716AB2002A27AA002F41
      D0003541C7002726AB003137BC00384AD300384BD3003137BC002726AB003540
      C7002E40D0002927AC00685FAC00F2F2F200FCFCFC00D2DCD80032765A00299D
      74002FC896002EC9960056D4AC0068DAB5003BCD9D0030C9960032CA99002BA4
      790028775700C7D3CE00FAFAFA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CAC8DE00332BA4002C3CCC003842
      C6005F5DBD00EDEDF8008B89CE003337B9003437B9008B89CE00EDEDF8005F5D
      BD003741C6002B3ACD003028A400BEBCD500F5F5F50048856B002EA57C0033CA
      99002EC896004CD2A80020835C0000673B0045BE960031CB990031CB980034CC
      9C0031AD830046886D00ECEDED00FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007E78BF00373BBC003042D0002621
      A500ECE7EC00F5EBE400F8F2EE009491D1009491D100F8F1ED00F3E9E200ECE6
      EB002621A5002E3FCF00343ABE006F69B400ACC4B9002E8A66003BCD9E0030CA
      97004BD3A9003495710087AF9D00B1CFC100238A600045D3A80036CF9F0033CD
      9B003ED0A300319470008FB2A300F8F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004F48B1003542CB003446D1002C2F
      B5008070AD00EBDBD300F4EAE400F7F2ED00F8F1ED00F4E9E200EADAD1007F6F
      AC002B2EB5003144D0003040CB004A43AE00619580003DB38C0039CD9F004BD5
      A90043A3820069978200F8F1EE00F9F3EE00357F5D0056C4A10043D5A8003ED3
      A4003CD1A40041BC95004D8E7500F4F4F4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000433CB3003648D000374AD3003A4E
      D5003234B4008A7FB900F6ECE700F5ECE600F4EBE500F6EBE500897DB8003233
      B400384BD3003547D2003446D100433CB3003C8466004BCAA40044D2A8004FB3
      92004E826A00F0E9E600C0C3B500EFE3DD00CEDDD4001B754F0060DCB80048D8
      AC0047D6AA0051D4AC002B815F00F1F1F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A44B8004557D7003B50D5004C5F
      DA004343B7009189C700F7EFE900F6EEE900F6EFE800F7EDE8009087C5004242
      B700495DD800394CD4003F52D4004944B7002D7D5D0066D9B80046D3A8000B67
      4100D2D2CB006A8F7700116B430073967E00F1E8E30072A28B0046A685005EDF
      BA004CD9AF006BE2C20027846000E8ECEA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000635FC3005967DA005B6EDD004F4D
      BA008F89CA00FBF6F400F7F1EC00EDE1D900EDE0D900F7F0EA00FAF5F2008F89
      CA004E4DB900576ADC005765D9005E5CC100408B6C0078D9BE0052DAB1003DBA
      9200096941002F9C760057DEB8002D99730073967E00F0EAE7004F886C005ABB
      9A005BDEB9007FE2C7002E896500F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009594D6007C85DD008798E800291D
      9B00E5DADE00F6EEEB00EDDFDA00816EA900816EA900EDDFD800F4ECE700E5D9
      DC00291D9B008494E7007A81DD008684CE006DA68E0077C8B00062E0BC0056DD
      B70059DFBA005CE1BD005EE2BE005FE4C100288C6700698E7600E6E1DC00176B
      47005FD8B40083D5BD00579F8400F6F6F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBDBEF006A6BD3009EACED00686F
      CE005646A100CCB6BC007A68A8004C4AB6004D4BB7007A68A800CBB5BC005646
      A100666DCC009BAAEE006A6DD100D2D2E700C1D8CF00439C7B0095ECD6005ADF
      BA005EE2BD0061E4BF0064E6C10067E6C50067E8C70039A17E001F6D4A00288B
      640098EFD9004DAC8C00A2C8BA00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFBFB00A3A3E1007D84DF00A5B6
      F1006D74D0002D219B005151B9008EA2EC008EA1EC005252BB002D219B006B72
      D000A2B3F0008086E0009899DB00F7F7F700FBFBFB0066A8900078C6AD009AEE
      D90065E5C00064E7C30069E7C6006BE8C8006CE9C9006BEAC9005ED6B60097ED
      D70086D3BB0050A48600F4F5F400FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F6F6F8009093DF008087
      E200AEBDF300A3B6F1009DAFF00095A9EE0095A8EE009BADEF00A2B3F000ACBC
      F300838AE3008D90DE00F1F1F300FDFDFD00FEFEFE00EAF1EE00499F800070C1
      A800B5F2E30098F0DA0085EDD40075EBCE0088EFD6009CF2DD00BAF4E70078CD
      B3003EA48100D7E6E100FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FAFAFA00B8BA
      EA007A7FE000929CEA00A1AEEF00B0BFF300B0BFF400A2AEEF00939DE9007B80
      E100B4B6E600F7F7F700FDFDFD000000000000000000FEFEFE00EBF2EF0065B0
      960044AB870085D2BB00A8E6D600C5F4EB00ABE9D80089D8C1004BB6920056B3
      9400DDEBE600FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00E4E5F500ACAFE9008C8FE300767BE100767BE1008C8FE300AAADE600E1E1
      F100FBFBFB00FEFEFE0000000000000000000000000000000000FEFEFE00FCFC
      FC00C8E2D9007CC1A90055B494003DAE880055B896006DC0A500B7DBCF00F9F9
      F900FDFDFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C003E00F000000008001800300000000
      0000800100000000000000010000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000100000000
      8001800300000000E003C0070000000000000000000000000000000000000000
      000000000000}
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 327
    Top = 87
  end
  object frxHelp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42496.335923645800000000
    ReportOptions.LastChange = 43446.605427349500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 550
    Top = 144
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 250.000000000000000000
      PaperSize = 256
      LeftMargin = 3.000000000000000000
      RightMargin = 3.000000000000000000
      TopMargin = 3.000000000000000000
      BottomMargin = 3.000000000000000000
      EndlessHeight = True
      LargeDesignHeight = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 18.897650000000000000
        Width = 1099.843230000000000000
        PrintChildIfInvisible = True
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 1489.134820000000000000
        Width = 1099.843230000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 1383.850650000000000000
        ParentFont = False
        Top = 83.149660000000000000
        Width = 1099.843230000000000000
        object Memo1: TfrxMemoView
          Left = 11.338597320000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'O layout do Excel esperado para a importa'#231#227'o dos dados.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 680.102828420002200000
          Top = 29.236239999999990000
          Width = 62.015770000000000000
          Height = 178.858380000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Coluna A'
            'Coluna B'
            'Coluna C'
            'Coluna D'
            'Coluna E'
            'Coluna F'
            'Coluna G'
            'Coluna H'
            'Coluna I'
            'Coluna J'
            'Coluna K'
            ''
            '')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 749.134368420002600000
          Top = 30.236239999999990000
          Width = 11.338590000000000000
          Height = 177.637910000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '-'
            '-'
            '-'
            '-'
            '-'
            '-'
            '-'
            '-'
            '-'
            '-'
            '-')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 230.000000000000000000
          Top = 306.346630000000000000
          Width = 652.646260000000000000
          Height = 638.000310000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000480
            0000028808020000008749165A000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            0064C349444154785EEDFD0DB424D7412778BE1EF069EF9C9E59669ADD31D3DA
            E9658ECFE9A17B6064A9DBB3ADE96DB67DBACF4E8B338D06B666BA2C18C4186A
            D6D8F843F8A8457B450BB057068C2D404019A964B7CBB2BDA805B44125635132
            6059FE92CB186CD956A96A30FEC21F25A954C6A592755C7B23EE8D881B1199F9
            F2BD97F92233E3F73B7F9722236E44464666BE8C7F45D6F3D61F02002BE92200
            1BA72860FFCDA5978B8888C84A450103D848A980DD0E004CF20357FCB7EF79FE
            554B4DB88B746715050C6053296000308B0206C002296000308B0206C0022960
            00308B0206C002296000308B0206C002296000308B0206C002EDB8806D6D6D1D
            7AC3C5903011A4B900B0A1E62C60F163319831675A143080F1D859010B9F22B1
            7D85BCE1C1A283A50500B0A1E6BF0256B6AD42677ADB286000E3B18302163E45
            42E9CADAD7836574300036D9FC052CA4EC5C8DCED26951C000C6630705ECF243
            1763B2F6E522189BEFE5DF1D5EE6CF3EF89A7433532EF9EE97A75BFBE835079F
            BD8BFB2DD66AA4F5C363A81FDB608F0756DB8E0A58487C8F059DF933A280018C
            C76E0A5848D5BE5C0163F395B56442030B7D26D8BEB0E4156741765EC062F9CA
            D679F977C71B0BDBBB253C4C58110A18000B346F010B1F2455F52A261430C6A3
            6816A168751B4F5169D6A58095FB3A791F1430D8D68E0A5851BC329DA5D3A280
            018CC7BC05AC6E5F41983854FC16C4D0BE620DD3C1D86465B37879B7F24C9A1B
            2F3395521709A31A716436A8D5589AA1937B4CBE7CDBFB6D2B569DD6D7CAC791
            D6C9A783499B2DE67DF7CBEB25697EB36F41754F93F72A7F18CD5DC14A9BBF80
            A55777D9BBD2D47C1D4C0103188FB90A58F8FCA80B58A85E0A18A3126B495127
            DA3D22CDCCFB463DA0A819D58238344E17C3BEBBBA513694382A5FF9E5079BD1
            95627BAD8DB77BCEC4FBAD4D9C59C9F72E9F9EB2D9729FAB05C5EC892B4F5B7D
            BB8709AB69CE0256BC314B33E64C8B0206301E7315B0D8BE3AA9DA57F8530163
            9355CD226B184591281A45F5DFA0DD3F662CC9D58BB2E1937437116E6F7FBFB5
            6C745FBE7E363D6DB3C544B320BFB7D61A53569FB477B0FAE6BF02B6EB286000
            E3B17D010BFD2A6B5C695A01633CEA32514FB4EA482C1461594FAA1A9D3212D7
            AAA54569DEE476D2EB2D73DD6FAD183379C341BE77CDF4D4CDB677A5B855ADDD
            D9504FBD7A350D6B4301036081B62F6055DD0A8AAEF5AFFED5BF0A7F8639BE85
            C84834CD22B58FF09FF68CA0A81C536A45DE4C6235C98B4AB3687A3DE96D7CAE
            FBAD15A3F3BB69C977A1999EBAD9E69E0BF9963B1B9AB157D31E26AC2A050C80
            059AEB0A582DB4AF69052C482BC066C99A45593FBEBB73BBEC117915E9C89B49
            B34261D24A73CD6B0ACE8CFB6D1483A6F59D4E6F4AD353375B2C98FC00BA0F73
            E2EAB5ED47C0EA50C00058A0B9FE0D58102B56ADBA2C16DB57F8B3E9666905D8
            1479B328AB4FBB685475A45C527793EC776D140BAAF979EF28A6AB6D55FFAF5C
            ED4D368A6DD4F75ADED3F6F7DB528E6A1E46738F6141BEE1F69DF437DBDEBDFC
            E1142B344B26AFBEDDC384D5A48001B040F316B08E76014BED2B08D369046C8A
            BC9694B7DA0524AB1165EB48B2558A5185726475A31C516FBA999BAF98CB46C4
            5F03BFFDFD76645B08AA71F9A3CBA783499B6DDF7371AB5EA3DA7EB578C2EAD9
            2EE477042B4E010360817659C0E22954F92D44ED0B804D16DAD13E24DD594501
            03D854BB2C6051D9C21A692E00B0370A18C0A6DA5301030096410103D8540A18
            00AC1C050C6053296000B0721430804DA58001C0CA51C00036950206002B4701
            03D8540A1800AC1C050C6053296000B0721430804D35B5801D3EF2965F3E72A7
            8888882C35E103377DF4661430804D35EB0A581A02002CC79BDEF4A6F4A1DBA6
            80016CAA6D0AD8C73F2B222222CB8A020630360A988888C86051C000C6460113
            1111192C0A18C0D8286022222283450103181B054C444464B028600063A38089
            88880C16050C606CC65BC0FEEBFFF517C693F890EF7AC7DD222252A7FE441830
            0A18C0D88CBA805DBCF8E931242F60EFFCDF2F8A8848880206C02014B0CD8F02
            2622D28F0206C02014B04F6F6DFD177557D961EE3F7FE5B3CF5CF26317BAF357
            2B0A9888483F0A18008350C07A05ECDE1F3B7349A85565AEFCF9A7F345DD2CBB
            80C5EDEFF52E143011917E14300006A180B50AD8D387FF795178AE7D7B7DF3EC
            E1FBEBA5BD2CB9809DFAF9B3973CFBEC95C52E9DBBB7B774EE28602222FD2860
            000C4201CB0BD8DBCF4DBDDC1417C5FCF3F3A7E2CCAC809565A96A6E717E1C56
            AC78F6F0DBAB6B595995CA2EB54DAC79651BFCB10BAD2DEF260A9888483F0A18
            008358A90276F2FACBB7A20347CB39F7DF7CE9E537DF13FF6C8D9C966307E61D
            39A980C54634A1EAE4C52C2F57F316B0AA7765DB09E3D3F71BB38DB4520E2E36
            386DC0BC51C04444FA51C00018C4EA14B0A27D5D7AE3C972FAD881AD2BAEBFBF
            2A60AD6133B393F1FD02D6F9FE6193B298D517A9E2B0F2E6DC05ACFAB76417AE
            ADE737993833BFD3EC1EDB63E68B022622D28F0206C02056A680B5BBD33DF71F
            BBA72E60F5A2A387D205B2AB8FA555AE3E74A099535D409B38B82875870E971B
            8F99FF0A58B7FF34D5684F05AC9CAE33B395C58D6FF31B41A646011311E94701
            0360102B53C0425F4A4D294B5EC0EA1AF6D98B87AF2EBFA318E6A44E5595AB7A
            4C7F70399D6742018B3DA7FF65BF4957C0CAAF14EEBE80651B9978052C7E59B1
            936E499B330A9888483F0A180083589F02565FD12A155F566C5AD6C9EB2F6F7F
            65B13FB8DE66950905ACBE2A555F04BBF7C7CADE9597A8AC74B5A663652AA7E3
            95B4ED0B5836A053AEDA952F642FDF4254C04444FA51C00018C48A7E05B135B3
            2E609D8636BB80F5EB5C3B130B5848AC3A29F5B7FED2C5B198FA12595EC0EADE
            55AC75A1D3AF7A05ACEA5D45CE5D1B56CC0B587E01ADCAB4AB737344011311E9
            47010360102BFB4B38B26B5CF59FF137739423D35710A715B0FEE0742F4DA615
            B0CD8B022622D28F0206C02056A7808514BD2B4A4DACAE5EB156D55F2C8C57B7
            FA052C6E61E2E0797E09C78646011311E947010360102B55C0F6350A9888C898
            A380013008054C011311196314300006A1806D7E143011917E14300006A1806D
            7E143011917E14300006A1806D7E143011917E14300006A1806D7E143011917E
            1430000631EA02369EC4871CCE364444A44EFD893060143080B1196F01131111
            193C0A18C0D8286022222283450103181B054C444464B028600063A380898888
            0C16050C606CC65BC05E3626F12177FEF5B988C8C8537F220C18050C606C465D
            C0E221D8787901EBFC16661191D146010360100AD8E653C04444FA51C0001884
            02B6F9143011917E14300006A180EDC8E9F3573EFBCC25D75D4837D783022622
            D28F0206C02014B08B17EFBDEECC25A15695B9F2D6A7D3DC899657C08E9FABF7
            A1C822EF42011311E94701036010632F604F1FBEAA283CD71E2F8F4671F3ECE1
            D3717A922517B058FF4EDD7AB69E5E04054C44A41F050C80412CB1805D7FF9D6
            A5379ECCE7DC73E3155B97DF7C4F3667BB9C0C1B3970B433B39379C64C4859C0
            E275A789852ABF2475D5F953716656C0624D4ACD2DCE8FC38A15CF1E3E5ECE29
            72EEDE7248905D6AEBD5BCAC80CDDAABDD50C04444FA51C00018C432AF801D3D
            D4AE5BBB684A4B2E60B1115597BF327905CACBD5BC05ACEA5DD976C2F8D4AFB2
            8D34B202D6DAF20228602222FD2860000C62A95F410CD5E88AEBEFAF6EDE7FF3
            A5B18F8562165D7D2CCDBFFAD0817C4EBC56165C7EE8405DAE3A6B4D1A93E66C
            5557DE8A7B2C966E6D1D3AFCD963078A3FCB4D9509B5A4F3FDC34659CCEA8B54
            71587973EE02567D81F0C2B5F5FCC6A499A9B6D569AE9BED99022622D28F0206
            C02096FB6FC08A4654F5A5C35797BDA8AE61E59CA2388539A91A551DA99E534C
            5463A6AD958F69B65316BF624ED600DB9971052C6B5CA5A68FEDA98095D37526
            15B0D625B2857530054C44A41F050C80412CFB9770D4D79DAA89FA4256A95DC9
            D215B350DBEA7F3C96EA566FADC963B2B2D7A96DFD14052C96A8EEB701275F01
            2BEBD0EE0B58B691E957C0AAB5BA0D706F143011917E14300006B1EC0296BA50
            73292CAB49297316B0F65A8B2960F555A9FA22D8BDD795B5A77F3D2A96B47CBA
            1C13A7E395B4ED0B58366066019BD4D0764F011311E947010360104B2F60650B
            3A74A0FEC760E166FA5A60F5CB337A05AC1C535F37ABC6F4D79A30A6F715C4ED
            0A58102F37A55415A8BA3816535F22CB0B58DDBB8AB52E74FAD5842A157B5791
            73D786152715B02CFE0D9888C852A380013088E517B0B232B57E1D62FD7DC278
            C1AAA94955016B7E9DC615976EFB4B38B231D59C6A955601ABBF0C995217B08D
            A7808988F4A3800130887D28602B1A054C4464CC51C000188402B6F914301191
            7E14300006A1806D3E054C44A41F050C804128609B4F011311E947010360100A
            D8E653C04444FA51C000188402B6F9143011917E1430000631EA02361EF12187
            B30D1111A9537F220C18050C606CC65BC0444444068F020630360A988888C860
            51C000C64601131111192C0A18C0D8286022222283450103181B054C444464B0
            2860006333AB80854F050060A9D2876E9B0206B0A9B6B90206002C8F02063036
            DB14B03BEFFA5D1111115952143080B1D9BE80C57100C062296000233457017B
            1C00565BF9A1B6661430801152C000D804E587DA9A51C000464801036013941F
            6A6B4601031821050C804D507EA8AD19050C6084D6AD80DD79CDD6D6736F3A91
            6E0140547EA8AD19050C608456B0809DB8E9B95B956ED70AFDEB9A3BD3744B51
            CCCA45E5DA93C7AC85F8E8E303D03601E6567EA8AD19050C608456AD8095FDA3
            2A1DAD1BB3D5056CDDA5FA593E14050C606EE587DA9A51C0004668C50AD88CCA
            5156ACA82E5AA9AD8439D75405AC9C15074C581A4CDACE0A89A5F3B9CF2DF62D
            3F1AFDDD8E8FB47C6885E7DE745333591DC1157FB0008B537EA8AD19050C6084
            56AB80C5F631A180E50BCA5251F593D42B62D128A6632D99B9B4BB9D9512F7FF
            A69B8A0656EC61B9B31377BB9C191F409C8C03E206EAB9E901D69B02D850E587
            DA9A51C00046683D0A585E25EA32D19AD9AE256162E2D289DB49B75644B58B77
            5E132F69153B3879B7F3B9F5C3CF8E6139D1526F0260F3941F6A6B46010318A1
            15FC0AE2849E30B181B466D62B5673272E9DB89D746B45D4BB181AD873C3E4FC
            052C3D947276BD7CE51E1FC092941F6A6B46010318A135F9251CF9ECBA6C9433
            6303291B56395DCF2C674D5CDADDCE4A691E54DCEBB91E7EFE589AB1D95AF958
            808D547EA8AD19050C608456AD800565594852A928C43E52AA9B443D74C37E09
            47DCB1724FAB23D0DFED6CE4E40296E647D99104D844E587DA9A51C000466805
            0BD81264FD04808D547EA8AD19050C608436B780D5D7BF4AEA17C0662B3FD4D6
            8C02063042E3B80206C0A62B3FD4D68C020630420A18009BA0FC505B330A18C0
            082960006C82F2436DCD28600023B4B002566E6D97F6B8FA06700400F6624D7F
            8A2A600023B41205CC678C2300B0176BFA535401031821056C253802007BA180
            01B02E7656C0B6B6B6D2544FB9B55DF219E30800EC850206C0BAD871019BD6C1
            CAADED92CF184700602F143000D6C56E0A58906E67CAADED92CF184700602F14
            3000D6C52E0B58906655CAADED92CF184700602F143000D6C5EE0B5890E696CA
            ADED92CF184700602F143000D6C59E0A58901628607BE30800EC850206C0BA70
            056C253802007BA18001B02EFC1BB095E00800EC850206C0BAD865014BB733E5
            D676C9678C2300B0170A1800EB6237052CDD682BB7B64B3E631C0180BD50C000
            58173B2E6069AAA7DCDA2EF98C710400F6420103605DECAC80CD506E6D977CC6
            3802007BA18001B02E14B095E00800EC850206C0BA50C056822300B0170A1800
            EB62AE0206002C9C020630420A18000C4301031821050C0086A180018C900206
            00C350C00046480103806128600023A48001C0301430801152C00060180A18C0
            08296000300C050C60841430001886020630420A18000C4301031821050C0086
            A180018C90020600C350C00046480103806128600023A48001C0301430801152
            C00060180A18C008296000300C050C60841430001886020630420A18000C4301
            031821050C0086A180018C90020600C350C00046480103806128600023A48001
            C0301430801152C00060180A18C008296000300C050C60841430001886020630
            420A18000C4301031821050C0086A180018C90020600C350C000464801038061
            28600023A48001C0301430801152C00060180A18C008296000300C050C608414
            30001886020630420A18000C4301031821050C0086A180018C90020600C350C0
            0046480103806128600023A48001C0301430801152C00060180A18C008296000
            300C050C60841430001886020630420A18000C4301031821050C0086A180018C
            90020600C350C00046480103806128600023A48001C0301430801152C0006018
            0A18C008296000300C050C60841430001886020630420A18000C430103182105
            0C0086A180018C90020600C350C00046480103806128600023A48001C0301430
            801152C00060180A18C008296000300C050C60841430001886020630420A1800
            0C4301031821050C0086A180018C90020600C350C00046480103806128600023
            A48001C0301430801152C00060180A18C008296000300C050C60841430001886
            020630420A18000C4301031821050C0086A180018C90020600C350C000464801
            03806128600023A48001C0301430801152C00060180A18C008296000300C050C
            60841430001886020630420A18000C4301031821050C0086A180018C90020600
            C350C00046480103806128600023A48001C0301430801152C00060180A18C008
            296000300C050C60841430001886020630420A18000C4301031821050C0086A1
            80018C90020600C350C0004668FB02262222224B8A02063036B30A58F8540000
            962A7DE8B62960009B6A9B2B6000C0F228600063B34D01FBF867454444645951
            C000C64601131111192C0A18C0D8286022222283450103189B790BD8CBA83820
            0BE1A5B558F5F11491F58A020630363B2860A73875AA3ED37540F6222F0C8EE4
            DEE5C75344D62B0A18C0D828603B539FE93A207B9117064772EFF2E32922EB15
            050C606C14B09DA9CF741D90BDC80B8323B977F9F11491F58A020630360AD8CE
            D467BA0EC85EE485C191DCBBFC788AC87A450103181B056C67EA335D07642FF2
            C2E048EE5D7E3C4564BDA280018C8D02B633F599AE03B217796118EF913C7270
            6BEBB21BEEBBEF86CB0E1E49B376293F9E22B25E51C000C666A1052C9C496E6D
            D5E792ED5B8B566EBD2D9CCBA6853DC5E885EC4A7DA6BBFD01294EAF6B33F66D
            50431FC6795F5AB5B00B8B3996470EEE743BD9133AF520EC64F7CA3D289F803D
            1FD3FC788AC87A450103189B4517B0209D4DB66E2CCF7C67BCC569EE629BC3F6
            07249CAFD777B9B0FB5F96A10EE3BC2FADDA7C3BBABD9D6E277FE8C5F4949517
            B57B3B941F4F1159AF28600063B3F0027643509E801E3978F086FABB55C5296B
            7EEDA01879F06031AFBCDD5DBCDDF84CB1A43AE3ADD7EACE29D7ADB7540EA9C7
            D433E6BA4A559FE96E7F40F20296DFAA2FA4A4DBBD1D0833D2830D738EA44750
            2E6A86D60F66CD0FE3BC2FAD5ADCD1F0E7C183E938560F3DDFDB34DD39D4C582
            F8F02FBB2CEE6D1C3775587694F23BC84D5877D23683B0A83DAB37A39933F1AE
            66C88FA788AC57143080B1597C013B72C3C1E2ECB1F87E55280FE5A9657D565A
            9C9656739A93CC30334D17B3C3F26DC6B73463D3CA41B5C17A4E31514EF5C754
            F7904FCD509FE96E7F40DADB4BFB99FE5348CBFB3B50EC64BDFFD544F86FB36E
            6F649A99A68BD961F936E35B9AB169E5A0DA603DA79828A7FA63AA7BC8A766C8
            0BC35C2FAD5ADCD1D60E9413717E33229F530D2AD6AA66D54B670FCB84A5A5EC
            D14D5C37CCE9CF2FFE9B66159B0FB39A31D590B420CEA9D69F4F7E3C4564BDA2
            80018CCDE20BD87D470E96A797A18685DBF184329E5C46E5996573F6D99EAECD
            18DFD62CA9CE63EBC97CA5B4B037A6B9A36AFE6CF599EEF60724BBAF20ED4C98
            9929E6F477A0DEEF891371F0A61CC6795F5AB5B837CD3EE53B5E4E8419711FC2
            9E658A65CDD86CBDD9C326882B94F7316DDD39B7196666438AAD758EEADCF2E3
            2922EB15050C606C9650C0C2D963FAF261B85D9FA7C6F3C930559E6BE6E7A3FD
            73D3D9E3DB9A25D9496B9CCC574A0B7B639230B43C116EE64C519FE96E7F405A
            773061075AF21DA8F7BB3311D64D2B87A972413D20C8A7A3D9E3DB9A25D91EC6
            C97CA5B4B037260943EB4731535E18E67A69D5E2DE34FB94ED5DB92BCDFEB4F6
            AC943F927A7AF6B029D29069EBCEB3CD30260D0A53E5B26CADFE0666CB8FA788
            AC57143080B1594601BBEF86839795CD2BDC2E4F23EBD3C9E2A4B33CD76C9D8F
            5627A0F5E436E35B9A2561AA7346DB9A534EF5C634339AD566A9CF74B73F2061
            73D5969BBB2926E29DA459137620CCAA87E413F506C344FD00E38034B7BA1127
            B719DFD22C0953CD6AD55AD9868AA9DE986646B3DA2C796198EBA5558B3B1AFF
            6C6E978BC23D17FF76ABDA8F629FE2A26AEFF2B1F5F4EC61B5EAA197B29113D7
            EDCFCF8F4A9C0C7FC6ED155B2E17D563F3C1F3C98FA788AC57143080B1594601
            CBFFDB9C639657468A5F9CD09CA7962B158A53CF3462AEF1997C49BD99B8956C
            4EF14B17E2CCFE98EACED269F06CF599EEF607A4D96E906DBA9E5FED417707EA
            87D49DD8EEB0D48F2D6D7ABBF1997C49BD99FA105573167F18E77D69D5E28E36
            BBDB4C05C53ED43B14D4FB54EF747B6CDAD559C31A61761A963FC469EB76E607
            CDFA715635A27E76B221F54A73CA8FA788AC57143080B15968011B81FA4CD701
            D98BBC308CE84896FF32324D2F547E3C4564BDA280018CCD220B58FCCBFBBEB4
            7823D467BADB1E90F4E0DBD2B2D1CB0BC33C2FADDABA1FC62957D7F62A3F9E22
            B25E51C000C6C615B09DA9CF741D90BDC80BC3688E64FC82E132FA970226B2C6
            51C000C64601DB99FA4CD701D98BBC3038927B971F4F1159AF28600063A380ED
            4C7DA6EB80EC455E181CC9BDCB8FA788AC57143080B1D9410123724016C24B6B
            B1EAE32922EB15050C606CE62D60222222B2F028600063A3808988880C16050C
            606C1430111191C1A280018C8D022622223258143080B151C0444444068B0206
            3036B30A58F8540000962A7DE8B62960009B6A9B2B6000C0F228600063E32B88
            22222283450103181B054C444464B028600063A3808988880C16050C606C1430
            111191C1A280018C8D022622223258143080B151C0444444068B020630360A98
            8888C86051C000C64601131111192C0A18C0D88CB780BD6CA3751EEC5E92B6B8
            A13A0F56645149AFB015D0D93159B52860006333EA02160FC1E659EC29970325
            B28BACC81B67DA8B3CCC6740F973A180018C8D02B6813A9FEE7B8C0325B28BAC
            C81B67DA8B3CCC3FC5403A4F8A020630360AD8069A76CAB5BB385022BBC88ABC
            71A6BDC8C3FCD406F6CB81EB0EBFFCF6075F7EE4C197DDF6E04B6FFDD04B7EE3
            833F7EF8032F3EFC8170F3FB5FF1EB5B5B5B69DC08749E14050C606C14B00D34
            ED946B7771A04476911579E34C7B9187F9A90DEC97D0B87EFFE1C7DEF9F0A3B7
            BFEB64F833E4D6773E1C275EF4EBEF57C0FA1430804DA580EDD4E9F3573EFBCC
            25D75D483757D1B453AEDD65B707AA6FE50EDD620F94489EC5BD71F664DA8B3C
            CC4F6D60BFBCF096F785AE75F4C4177FFAE8878F9EF8CB909F7AF383473FFC97
            F77CEAD11FFDA5FB15B03E050C6053AD5F01BBE7C62BB6AE3ED699B98BB44E8F
            EEBDEECC25A11B94B9F2D6A7D3DC8996DC2276B027534D3BE5CA72ECC0D615D7
            DFDF993939AD03D5B71287EEF8B97A1FCA9C3D7C3A2D99698E0325AB94FB6FBE
            74EBD0E1CECCC565513F5B62B679E3CCE9D8A1D04C8243C7D28C467FD1A4C1D3
            5EE4617E6A03FBE505AFBFFFF5779F7CF91B3FF2D2DB3FF29223656E3DF1E2DF
            38F173BFF3F00FFDC21F87DD4EE346A0F3A4286000633374012BCEA86A735582
            C357CF1E76F2FACBB70E1CEDCC9C90FAF4E8E9C3571567EDD71EAF6FCE3C7D5F
            6201DBE19E4C35ED94AB95A3872EBDF16477E6A4D407AA6F650E5D59C0AAFAD7
            D9AB19B63F503B7F7D6E9FB0CDCB6FBEA73FBD6A89FBB6D83DDCDBD642416ADE
            DA6953C70E2C6EF716F5B32566C61B676EA1515D71F3C98B174FDE7C45B782F5
            174D1E3CED451EE6A736B05F5E7FFBFB9FF8EA85338F3FF9863B1EF8CAE3E78B
            89B7BCF72B8F3F79F6DC859B7EFD3DE10D96C64D74DF0D975D76C37DFDE9B984
            15B60E1E49375641E74951C000C666050A587DFE74F4D0D602CEA5E63D49AAC4
            8B27135B417E5DE5AAF3A7E2CCAC459CBAF56C73A21FE7C761C58A670F1F2FE7
            1439776F3924C8AE17F5BACA8C3DD999ED7B45997BEEDF63015BB143975D7FBB
            706D7BDD29B63F508B7F7DB6B7B9B742B2DC2C63DFF6B6CDD62B366E6A5F0FE0
            BE17B050A5CA4A954F25FD4553064F7B9187F9A90DEC979FFB8DF73EFAC485D0
            B88E3FF0C8971F7B324C3CF2E933679E78F2AB5F7BEABEF73D12FF922397568B
            14300036C82A15B07A3A9CE946F1EB40C5FC43072E0FB70F1DAEC6145F162AD5
            9771D29C72643C49EA8D397620FBFE52124FEB275C2DC9DB45DE10E66D115501
            C8B613C6A792906DA436754F766CDB5E511F9979BE7035F53C72750E5D1C9915
            B078116CDBEB87DB1EA81DBF3EE3CDB874DA97E5266E3364E666BB4F59587AF5
            A103F99C3833CEA9EE7AC6133D6183E9EEF23959C3E96DBC97A29F44DD77653D
            67F2BD6447AF7310EAD4BB51DC4B799D2ADF547D0CF3F4EF2B645F7EB6C44C7D
            E3CCEFD8A1FA52563659EA2F9A3278DA8B3CCC4F6D60BFFCECAFFCD19F7FEEEC
            9163379FFCF4A37FF8FE535F7EFCC957BFF5D0E92F7CFE335F3CF7B6777CE4A6
            5BFEE0A65BEE7DF5AFDCFBEA5F7ED7AB7EE95D3FFCE29F4FAB45D30AD89183F1
            894805AB5874F0E065E97651BC82724EBDBC98134C1ABF6F3A4F8A02063036AB
            77052C9B73F8EAF27427CCA9BFFD15971673E2E94EF56F99EA39C544BD567B4C
            B9CD3AD1D4AFAB95EDA23E83CF4EE8E76E11551F28AFC6C4F98DFECCF9BF38B7
            AD6D7A453C86C5F484B3C67EA69D47AECEA1EB17B0CE3E4CB3CD810A698ED57C
            AFCFECC5569CA3775A444C313E13B7367BB3CDD2EA292B96D62FEFEEEB3CDD75
            7FAD3A93371857AFAEF3C43169646FE3F5A6EA84E393E6E7DB6CEF5B31A7DC78
            7E2F131E667510CAE9F6A2BC80B59E8E6E9A2DB71F51B974A93F5B62A6BD7176
            604AA72AF4174D193CED451EE6A736B05F7EEA75F77DE5F1275F72CB3FBBFD9D
            3FFFD1531F0B05EC7B6FF85B875EFFF77FFF43FF3E4C9F79E2C2D9BF7AEAF87B
            1F79E2AF9E7AE2AB4FFD9B5F3C96568B9AE6548A05ACA84FA98985225655AE6A
            56315DD6AA72DDB4342D4CC35BE3F751E74951C000C666F5FE0D58FD57D4A5E2
            2F98C398FA1C2B4E37A77AE9442A9C14D67F5D9D4EAD7A63E2749D64CA659CAC
            36949A13FA3DB58872BA4EBB454CD9935D98AB57A4033CF5F4B1CED4F3C8D539
            74BD02D6DD87297672A082B95F9FF5EA133371FCECCDC6916961D50AD2D27621
            A9C7C774D69AB1285B3DBD9BE29CFCCF7CF57EEA0DD6F5ACFF1E2CC6C4EAD2BE
            977A7CA67E47176986EDA480558BD27DCDF3DCF5F679173F5B62A6BE71E637E5
            5B8585FEA22983A7BDC8C3FCD406F6CBF53F776F28602FFBC51F78FDB1EFF991
            D7FDDD17BCEE3BFEC5BFFEB63FFAEC8BAEBBFD1FFCF49B7EF8F4E73F176AD8F1
            074E9D79FCC9D0C17EF235EF48AB454D77CAA6EBCB5FA5625E362C5FA3EA5BB1
            7135C35B83F651E74951C000C66695AE80C564273729CB39494A6213E87EA52D
            AF0D8578425F7E2F6EF72D22DB48AB5A24D3F664E7B6E915E1C8CCF1F7F775A6
            9E47AECEA1EB15B0496326D8E64085ECEEF5592F9A9889E3676FB6FF94354BA7
            17B0194FF4AC0DEEB680C58491E5E9EDE4F760B1746601EB1C843ACDB0F60EE7
            AB77922D6A0AD8B6CF5D6F9F872C60C5A5ACAA5CB52F804D5A3479F0B4177998
            9FDAC07EF9FE6B5EFD9E0F7FE66DEF7CF38FFCFCDF7BDF575EFCC0975FF8BE2F
            BFE4EECFFE0FEFFEC20FDEFA9E2BAF79CD77FEDE03BF75DF03A7DFF68E3F79D7
            FD275FF133BF95568BF2A6544F37BDAA920DCBD748038BC216570853E542050C
            8021AC5E010B73D2C9E2842F0EA5E9624CEFF4B199D339D5EB9D7D96A99527EB
            D9959C7BAF2BCB437E4E9F3587D67439264EC7CB41DBB7886C40AF214CD9931D
            DBA657D4A78F6162D291E964C679E4CA1CBAD65AB1AD357B35DD36072A247FED
            D57366BC3EF3175B38BC9D7563F2F1F5F4ECCDF69FB2666955C0FA77DD5FAB18
            5F0DE86F70E20EA43BDAFE7185A292D79254AE26BC4FCB8D4F7B7777F621CE4F
            8BCA4DD563E28AF9EA9DF4B736714E7EEF71837BFED91233E38DB303A1559526
            7CBBB0BB68D29C552A6071DF826FFD3BCF38F8337FFB677EFBD2A31FFB47779E
            FAC76F7FE4BFBBE1EDDF75F9557FEBCDBFF396E30F9C8ABF17F1A53FF59B69B5
            6862010B13E90B84C55451AD3AC39ABA5515B06646392E1FBF8F3A4F8A020630
            36AB57C0428A93C2523C9FCBC754D3C5D95EA93E4BABE65C716975EAD61B13CE
            96E26953915C3A658FA9CEE3AB2B3C31B13604798BA8CB43B1D6854E49E8B588
            AA3C1439776D58B1D3220A93F76487B6EB15C57964A1FC2D0EF5019C96D9E791
            AB71E89AA5317316D7ED0ED4CE5F9FF1665A5C9FA337AFBAEEF87C7AD6667B4F
            59B3347489AA034CB8EBD284277AE206DBBFB222DE457D471336DE7E5C65EF4A
            AA3DEFBE07A7DD4BB585EE41C892365EAC5EF5A262C5F281A489FE716EDF57C8
            BEFC6C8999FDC6D9B56387F27AB5BD692FF2303FB5817D178EDBDFF8B66FFACF
            BEF319FFFC15DFFA6B1FFCAE7FF6A2FFF45FBEF47B3FF5E79FFDF2E34FFEC17B
            1F097F9EFDEA532FFCC9B7A6D151A759D5D345952AC566D52E5445052B5C7659
            AA62D5E88307532553C00018C2D0056CB86CB0ED7BC54EB2A4F3C855B0D803B5
            12B9FFE603D5F7E576964E11DA800CFD8896F3C63979F3CD3BEA5F535FE4617E
            6A0303093DE8BFBFF66F5EFA2F9EF5E6DF7E4B285D1F3BF9A5B7FDEE47DF7CD7
            8937DFF5E163EFFED48FBCE2681AB7893A4F8A020630360AD8065A6CAF58CE79
            E44A58EC815A91DC93FD9BA51D44015B7456E48D33ED451EE6A736309050C05E
            F986ABE385AF77BDE7912F3D7A3EE44DFFEEC12F3DFAE4634F5CF8E197BD318D
            2B95D7ADBAD2B235D47952143080B1196F015B91D3A3659876CAB5BB3850EB93
            E29F3675FFB9970C941579E34C7B9187F9A90D0C24BC52DFFDFE47BE72F6C92F
            3E7AFE8D7786DE753E4E843F437EE0C5E5570A3754E74951C000C64601DB40D3
            4EB97617074A6417599137CEB41779989FDAC0404201FBA7DFFBF21FFCF1DB7F
            F0C5B787BA75F58B426E0B79FE8FDD76F085B7FE93EF1978F796AAF3A4286000
            63A3806DA069A75CBB8B0325B28BACC81B67DA8B3CCC4F6D807DD77952143080
            B151C036D0B453AEDDC58112D94556E48D33ED451EE633A0FCB950C000C666D4
            056C83751EEC5E92B6B8A13A0F56645149AFB015D0D93159B52860006333DE02
            2622223278143080B151C0444444068B020630360A988888C86051C000C64601
            131111192C0A18C0D8286022222283450103189BF116B0F40BC2D64AD8EDBBDE
            71B788C8FCC97FEEC90A460103189B5117B07808D6455DC0DEF9BF5F14119927
            0AD8EA470103181B056C6D286022B2D32860AB1F050C606C14B0B5A18089C84E
            A380AD7E143080B151C0D6860226223B8D02B6FA51C000C64601DB85D3E7AF7C
            F6994BAEBB906EEE13054C44761A056CF5A380018C8D0256B9F7BA3397845A55
            E6CA5B9F4E73275A5E013B7EAEDE87986B8FA7250A9888EC3C0AD8EA47010318
            9BD52B60F7DF7CE9D6D681A3E9E63D375EB1B575E8703E6041C90BD8D387AFCA
            DB4EB879F6F0E9383DC9920BD894FAA78089C84EA380AD7E143080B159C90276
            F915975E7DACBC79F2FA307DF9B20B58BCEE34B150E597A4AE3A7F2ACECC0AD8
            A95BCF8645A9B9C5F97158B1E2D9C3C7CB3945CEDD5B0E09B24B6DBD9AA78089
            C822A380AD7E143080B159CD0276F3F537DE7C4F71F3D881AB6FBEBE2A60E5D5
            B052AC67C5C843072E0FB7CB01E5A5B3D294F1616BD9C5B4A680C546947DD9AF
            9217B3BC5CCD5BC0AADE956D278C4FFD2ADB48430113914546015BFD28600063
            B3A205ECF08D87AEBFFFE2C78F1EBAF4C663A98095F3532B6B1AD715C5B03433
            4D17BD2B34AEFEF876EA02D6F9FE61A32C66F545AA38ACBC397701ABAAD4856B
            EBF98D4933536DABD25AAA8089C84EA380AD7E143080B159D10276CFD143078E
            862A156AD8C9FA0A58D9B8A2B26B3515AB3D5DA733BEBD74DB2B6059E32A357D
            6C4F05AC9CAE33A980B90226220B8A02B6FA51C000C666550B58F3E5C3AA801D
            3D547DB7B0BAD835BB80F5C7E74BF302164B54F7DB8093AF80955F29DC7D01CB
            3632FD0A980226220B8A02B6FA51C000C666650BD8C9EBAF8EBF8A232B60F19F
            7215CDAA57C0F296150684F9FDF169644A53C0EAAB52F545B07BAF2B7B575E87
            B2D2D59A2EC7C4E978256DFB02960D50C044649951C0563F0A18C0D8AC6C012B
            FE29D7A5379E6C0A5851B14A571F0A13C5EFA9EF5CF50A37E380E6C257A91E5F
            CC898B8AE4052C88D7A652EA0A942E8EC5D497C8F20256F7AE62AD0B9D7ED52B
            6055EF2A72EEDAB0E2A4029627FB62A40226223B8D02B6FA51C000C666F50AD8
            7EA553C0569F0226223B8D02B6FA51C000C646015B1B0A9888EC340AD8EA4701
            03181B056C6D286022B2D32860AB1F050C606C14B0B5A18089C84EA380AD7E14
            3080B151C0D6860226223B8D02B6FA51C000C646015B1B0A9888EC340AD8EA47
            0103189B5117B0B513763B9C4E8988CC9FFCE79EAC60143080B1196F01131111
            193C0A18C0D8286022222283450103181B5F415C2761B73B5F2E1211999DFCE7
            9EAC60143080B1F14B38D6465DC03AFFC85E44645AA615B0F2AF74184CFE5C28
            600063A380AD8DF899AD8089C8FC9951C04E3110050C60E414B0B5A18089C84E
            A380AD20050C60E414B0B5A18089C84E336001FB7FBFEE23F3248D1E13050C60
            E414B0DD397DFECA679FB9E4BA0BE9E67E50C04464A719B680C59F5D4F5FBCF8
            D4D317BFF6F56F3CFEE4371E3DFFF417BFFAF5CF3CF1F5538F7DFD93679EBCE6
            A56F4CA3C74401031839052C73EF75672E09B5AACC95B7869386E99657C0E296
            9B9CBB372D50C04464A719B280FDC283E107D7D3DF08EDEB1B5F2DDBD799AF3D
            FD85AF3EFD174F3CF5C8634F7DE2CC931FFD920256440103189B3D14B0FB6FBE
            F4F29BEF993D2766DAFC6E4E5E7FF915D7DF1F27B62A71CEE2D329604F1FBEAA
            283CD71EAF6F9E3D7C3A4E4FB2EC023661CB0A9888EC340316B0FFEDE73EF0F5
            A7BFF1777EFAE3D3F2C1CF9D9F51C08E1CDCBAEC86FBD28D96FB6EB86CEBE091
            F2BF13474C9BBF32143080915B68019B963947A66145FBBAF4C69369E6D1435B
            5B870ED763169776013B7EAEB8DC34B150C54531579D3F15676635E9D4AD679B
            E616E7C761C58A670F1FAFAF68D5D7B2F24B6DBD9AA78089C8C2326401BBE9FE
            27BFFE8D734F7DE3B1F3DFF8D2579FFEFC135FFFF3C79E7AF8CC931FFBD2931F
            F9E2F90F7CEEFCFD7FF1B5A9052C94A8833784FF859ED55315B0B5A580018CDC
            12AE80853FAF3E74205EBEBAFA5835FFD08178512BCEF9ECC57B6EBCA2BCDD9A
            53F4AED0B8DA9B3D7C757911ACD9C8A1C3CD5D5717CD66DE4555E78E1DC8BA5C
            AB80C546545DFECAE4C52C2F57F316B0AA7765DB09E3D3F71B27762D054C4416
            96010BD8A19FFDC3734F3EFDD8F9A743FBFADC135F3FFDD8D73F15DAD7979F3C
            F18527DFF799F37FFCE9AFDD7BFAABD30AD8918345C52A5A5856B48AE2155C76
            F060E70A585A1094C3ABF9F5EC743D2CDC3E78F0609C556DB7B36AB96EB1FD66
            C41228600023B79C02967A4E55788A39F19B84D99CB46E538A62D14A35AC9CD3
            4AB3917CF5AC80A5A5C505B40347E39C7A37AA15B3E405ACF3FDC34659CCEA8B
            5471587973EE0256FD5BB20BD7D6F31B9366C62DD469962A6022B2D30C58C07E
            F4C67BCF9C7FBAF3B5C33CC71E3E37A580C5FED554A9425195AA99B11EA5A5CD
            7715D39038BF1E5F0F68CDA9369556CDE64CFBE6E3E228600023B79C02D66F47
            9D397170FC7BC77637CB0BD8E1ABD38854A8EABB9B7517D995B4EA5258D84EB1
            85B86E95BC804DBB029635AE52D3C7F654C0CAE93A130B982B6022B2800C58C0
            7EE486BBBF70EEE9CF3CFEF5538F3DF5C9334F7DF48BE73FF4F927DFFB99AFFD
            E1A7BFF6AED35FBDFBE1AFDEF589C905ACA9454D319A3433CECA1744714EBD66
            677C31235B274CA6CF99724E7F6B4BA080018CDC4005ACF9975DD5E5A9BA2F4D
            F80AE28C0256AD9E2DDD4D018B25AA5F7B265D012BBF52B8FB02966D64C61530
            054C441690210BD8F5BFF3178F3FF5C8A34F7DFCCB4FFEC9179FFCE0E7CF87F6
            F57B9FFCFCD64F6F85DCF58927DEF6B1272615B05097DA7ACD686105ACB8AB38
            284C9573FA5B5B02050C60E4862B6075DD2A1B54D691C298EC977014156B5201
            ABBFCA5817B07425AD583D8D9FFB2B8841BA2A555F04BBF7BAB277E5252AAF46
            F974F6EFBBE295B4ED0B583640011391A565C002F682EBEE7CB8685F4F85BAF5
            C77FF1D81FFFC5D77EF69D6F8BEDEBFFF7B1336FFDD8E3FFF6A38F4F28605971
            2A559528FCB7294B79A1AABA535C1226E3FCD6F86A0B69603555DF57B1C9CE98
            258A3FCCEB28600063B3B70296FE7EB2140A55983367012B6B55B956F1EB3A0E
            1CADE7A7D45F3E0C52316B36920D287EF1467D17537F094755EDC29DC64A5624
            7C04C643508BD7A652AAE2545D1C8BA97B51BB26A5DE55AC75A1D3AF267C0531
            F6AE22E7AE0D2B2A6022B2AC0C58C0FED76BDFFAB12F3D79E20BE743E3FABBFF
            FAD2EFF9E51F0A13FFE83557DDF9F127EEF8B3C7DFF4278FDFF691C77A052C14
            A056FD2A5435A9A85485CB2E8BD5AA2E4BD5827439AB9A5FCF4E5BACC7375345
            F12A4714BF9CA3B5CD6552C000466E0F056CA5D2AE67F3A45FC0569C0226223B
            CD8005EC9A97FCDB139F3FFFBECF7DED8F3EFDD578E12BE4CE8F9F0BEDEB8D1F
            7DEC374E3CF66B1FEA17B05150C000464E015B1B0A9888EC344316B0171F79E0
            33A17D7DEDDE535FFDBD47CE85F6F59B1F7FE22DA17D7DE4F1373CF8D8AF7EE8
            B19B3FF068BF80C52B527D69F14650C000466E530AD8CEA38089C8C667C002F6
            432F7CC3BBFFFC6BEF0CEDEBE173777DE2DCDB3EFEC4D13F7BFCF63F09EDEBD1
            5FF9E0A3377FE0CC6B1F38E30A5888020630360AD8DA50C04464A719B080FD2F
            FFDBAF857EB56DD2E83151C000464E015B1B0A9888EC34031630A651C000464E
            015B1B0A9888EC34330A1803CA9F0B050C606C465DC0D64ED8ED703A2522327F
            F29F7BB28251C000C666BC054C444464F028600063A3808988880C16050C606C
            7C05719D84DDEE7CB948446476F29F7BB28251C000C6C62FE1581B7501EBFC23
            7B1191699956C0CABFD26130F973A180018C8D02B636E267B6022622F3674601
            4BBF139D7DA780018C9C02B636143011D96914B015A480018C9C02B636143011
            D96956AA807DD3FFF4D7EAA459A3A480018C9C02B636143011D96956A480C5D2
            F5375EF58CFFE475CFFCCF7FFD3F0A19730753C000464E01DB85D3E7AF7CF699
            4BAEBB906EEE13054C44769A552860A16B3DE305FFC1FFE9F07FF8B7DFF47FFC
            CF7FEE3FFADBAFFB96BFFFD64BAE3CFE7747DBC1143080915B4401BBFFE64BB7
            1A97DE78B23B60E93979FDE55B078E76666E936E01BBF7BA3397845A55E6CA5B
            9F4E73275A76018BDBAF73D5F953C55C054C44769A610B58BCF0F5D77FF49BFE
            CBA3FFC977BCE5FFFCD7AFF9E66FFE97FFC137FFCF7FED993FF4CDDF76FD7F7C
            E00FFE9B991DECBE1B2E4B1F2B078FA4598B11367CD90DF7A51B0350C000466E
            4105ECF29BEFE9CCDCD7ECB5803D7DF8AAA2EA5C7BBCBE79F6F0E9383DC9320B
            58EA81D9C64FDD7AB6BCA98089C84E337801BBE4F5FFF173EEFCB67F7CF77FF9
            D7FF976F4A732BFFE10B9E71D53DDF39A58315EDAB6A49470ED6930BA1800130
            A86515B07B6EBC22FECD65BA20568C3974E0F230E3D0E1307DF5A10371F1D5C7
            D22A470FC519CD9CE6C2DAA1C353C6A47B29B71C0BD8ACFBFDECB103F5A65A05
            ECF8B94EE769C44531E94A54AB8015EDA86E6E717E1C56AC78F6F0F1FA5AD6B9
            7BCB214176A9AD57F366EC890226223BCEB0052C08FDEAAAFBBFF3074FFC83FF
            FAF5CFEA77ADFFC30F7DF3DF7BDD84F99D8E74DF7D47EE2B6F742F8A85DB070F
            1ECCE7C499714E3D2B34B87C46B5F1095B0B9B2BE6D5DB5A0A050C60E416FD15
            C4D8C48A39B1EA84CE73C5F5F7C739E54477693951D4A454E10E5F1DAB54B562
            EC54A171F5C7D4DB2926DA7326DE6F3B4D018B8DA8BAFC95C9EB505EAEE62D60
            55EFCAB613C6A7EF37661BA94DDD93820226223BCD2A14B057FCF93FF97FFEBB
            FF2A4C4C285AA74E3DE3F9DF34617EA84CFD125415A7667151A1E2B87A85E672
            595AD8AC550D8A73266FAD1ABA4C0A18C0C82DE70AD8D143F545AAA62CD5639A
            E993D75F5EB6A3FAD256A9B87835719B99302614B3FADF9BA57B997DBFEDD405
            ACF3FDC3465987EA8B5471587973EE0256FD5BB20BD7D6F31B1366E6F718B79C
            52DC970226223BCDE0052C9856BD66A9FB5447D191A2B2293525AA9A6AE654C2
            A632C5C27ACCD4AD2D97020630722B53C0AAF12933B719B3A80236EDBA53D6B8
            4A4D3BDA53012BA7EB4C2860ED3D69AE9E296022B2D3AC4201DB8D895DA8A852
            EDCB5CCDB06AAABF62BFCBC531B3B6B65C0A18C0C82DA7808539FDAF02CE2860
            C5F8F845C1FAD769345F412C6A5518DF1FD3BA97FE9CDEFDB6D314B074ADA9FD
            6DC060D215B0F22B85BB2F60D946265E16CBBEAC98286022B2FB0C58C0E285AF
            FAF2D7CF6C6DCD4E5CAB12CA506C454151958AE9BA4A5533B2CA544F556DAA9E
            6CB6544C151B8863676D6DB9143080915BFA2FE128DB547B4C335D15B0301D5A
            56545FE62ADA54143BD58431D5BD5C7169EF97704CB8DFA295559BCA0B587D55
            AABEF474EF7565EFCA4B5456BA5AD359658AD7AFB62F60D9806E01AB3652ADA8
            8089C85E326C01FBF14F7DF7FFF4814BEB02F6F5FFEB5F7BFABF7AC6D3FFB76F
            FDC6FFEB3917FFCD3517EFB9E3E2535F8B3FE97A052C288A5154D5A26A4EF98B
            379A2A552CCACA53D1B3D2B8B260655B8A33D2D8195B5B2E050C60E41651C0D6
            3379010BE2B5A994BAFFF4FE2156292F6075EF2AD6BAD0E957BD025615AA22E7
            AE0D2BF60A58A11993523643054C44769A610BD8FFF8C0773EF71DFF97BA809D
            FB2FFEDAD7FFCE33BEFEDFFECDA7BFEFD26FDCF043177FEFDF5EFCDA13F1A7DE
            A402B6B11430809153C0D6860226223BCDB005AC4EB8192AD6ECC4B5A27869AA
            232D5B7F0A18C0C829606B430113919D66C002C6340A18C0C829606B43011391
            9D46015B410A18C0C829606B430113919D46015B410A18C0C829606B43011391
            9D6646016340F973A180018CCDA80BD8DA09BB1D4EA74444E64FFE734F56300A
            18C0D88CB7808988880C1E050C606C1430111191C1A280018C8DAF20AE93B0DB
            9D2F178988CC4EFE734F56300A18C0D8F8251C6BA32E609D7F642F22322D0AD8
            EA470103181B056C6D286022B2D32860AB1F050C606C14B0B5A18089C84EA380
            AD7E143080B151C0D6860226223B8D02B6FA51C000C64601DBA9D3E7AF7CF699
            4BAEBB906EEE1F054C44761A056CF5A380018C8D0256BAF7BA3397845A55E6CA
            5B9F4E73275A5E013B7EAE75EFDD3B52C04464A751C0563F0A18C0D8CC51C08E
            1EDA6A5C71FDFDAD4F8E3DE4D881CB6FBEA73B73EF9977B375017BFAF05545EF
            BAF6787DF3ECE1D3717A12054C44D6260AD8EA470103189BF90AD8D5C7D247C5
            FD375FBA75E870F5B1B1A7844D2DA380CDBDD9AA8095B56772A18A8B62AE3A7F
            2ACECC7AD1A95BCF8645A9B9C5F97158B1E2D9C3C7CB3945CEDD5B0E09B24B6D
            BD9AA78089C882A380AD7E143080B1D96101FBECC5C3576F1D385ACD8FE2D2A2
            F91C3A707936E7B317EFB9F18AF2767FCC1597C69165599A3E6CEBD21B8F5D9F
            264E168BFA777AF5A103CD9C93717067B369DDCF1E3B90B5C754C06223AA2E7F
            65F2629697AB790B58D5BBB2ED84F1A95F75CB55490113910547015BFD286000
            63B3E302165A4DD167B20B4DA9928539E90B8A450B4A73D298AAF93463B2A533
            86E513614C3332BFD3D8A9B275EBCD368B267C733216B0CEF70F1B6531AB2F52
            C561E5CDB90B5855A52E5C5BCF6F4C9A996A5B3B0A9888EC3E0AD8EA47010318
            9BDD16B0FA4A54A953C9D298305DB4A028EB5171539DE989C33A13B3EE34B4BE
            F6BAD96E3757EDB2CCBE029635AE52D3C7F654C0CAE93A930A982B6022B2B828
            60AB1F050C606C76FB15C4F6CC224D17CA4B5AFB1A5436A6D594A60DEB4CCCBA
            D3DD16B058A2B29E934CBA02567EA570F7052CDBC8F42B600A98882C2E0AD8EA
            470103189BDDFE128E62A22C3CF9170E3B73EA158B8A35B3804D1BD699087FF6
            EF346DB057C08AC1DB7F05314857A5EA8B60F75E57F6AEBC0EE55D289F2EC7C4
            E978256DFB02960D50C04464C951C0563F0A18C0D8CC57C01A5993A9E7C7FA54
            349FCE2FE108CD27DE2C7E4F46BB2F554B8B9BD387F52726DC69DC6055C09ACD
            36BF84A3D86631262C8A95AC485DC082786D2AA5AE40E9E2584C5D84DABD28F5
            AE62AD0B9D7ED52B6055EF2A72EEDAB0A2022622CB8D02B6FA51C000C6668E02
            36675AE56A0D9217B0B5A08089C84EA380AD7E143080B151C0D6860226223B8D
            02B6FA51C000C66671056CDDA28089C8C647015BFD28600063A380AD0D054C44
            761A056CF5A380018C8D02B636143011D96914B0D58F020630360AD8DA50C044
            64A751C0563F0A18C0D88CBA80AD9DB0DBE1744A4464FEE43FF76405A380018C
            CD780B988888C8E051C000C64601131111192C0A18C0D8F80AE2E275EE48362F
            E9991EABCED158FDA4FD1EABCED190558B020630367E09C78239DD194396F4E2
            590BEBF80AF77CC92A470103181B056CC19CEE8C214EE8D72B9E2F59E5286000
            63A3802D98D39D45E59E2F75E7AC4E9CD0AF573C5FB2CA51C000C646015B30A7
            3B8B8A02B69AD6F115BE87E7EBF4F92B9F7DE692EB2EA49BEBC74FA4D58F0206
            30360AD85E4C383973BAB3A82860AB691D5FE1DDE7EBDEEBCE5C12DEB965AEBC
            F5E93477A2E515B0E3E78A1D485B7EFAF055C5CE5C7BBCBCB548D39EAF309F9D
            5AE0D1AB3715A280018C8D02D6B3B793B3FC93750F9A93B37A6B638B02B614C7
            0E6D950E1D4B331AFD45930677CE1DD722F9F3D5A93AE1E6D9C3A7E3F424FB52
            C04EDD7AB69EEE58DAF315E69F6227F223B9C7A3D77952143080B1597A01BB34
            9E1134AEB8FEE8CD975E7EF33DBD91B372FFCD613B078EA69BF7DC784538C738
            9C0F6872ECC07C1B0F1F81F110E4F67E72967FB2EE810236B1809DBCFEF2AD4B
            6F3C99CF2C5E0CB39FF1FD7AF1ECC4F24EEB670B67E857DC7CF2E2C593375FD1
            3DA5EF2F9A3CB873EEB85D8AA7AC70F5B138A738FED57493A3A93994AEB8FEFE
            F6D23D277BBE5AD79DDAE2A298ABCE9F8A33B3672AD6A4F4C321CE8FC38A15CF
            1E3E5ECE2972EEDE724890FD6D4EEF2749BD27F9A63A96F87C85F9A90DB41DB8
            EEF0CB6F7FF0E5471E7CD96D0FBEF4D60FBDE4373EF8E3873FF0E2C31F0837BF
            FF15BF1E9E9E346E7CF22339EDE83D523A79F2E4C30F3F1CFE0CC2CDB42CD379
            52143080B1D9A72B60E1ACAB73DEBCB38473E8CBAFB8349DB78553BA2B2EBD7C
            CA39743172D7E7D00B38392B3F594F7FFA9FD6C3F67872D6DDEDF164F215B070
            A6DE7A7E8BF3FBBA5C4DCE3EBD7856E48B6DC1F4977138352F4FD1F3A9A4BF68
            CAE0CEB9E33609CF5771E48BC35ED6AA630726B6DF34AC9C2E0AF3B486BCCB34
            CF577C8E267CD32F3F6879239AF01E2F86B4C6A41F0EE55B3BDB4E189F5E0613
            9FEE34F2DCB5F5BA3D539E82427FD194C1D39EAF303FB581B6D0B87EFFE1C7DE
            F9F0A3B7BFEB64F833E4D6773E1C275EF4EBEF57C0661CBDD0B54E7CEC536F7D
            F7C75FFBDB7FFA6BEFFAD4EB7EE7A3BF72E7FBDFF7E18F851A9646543A4F8A02
            0630364314B0789A5BFC79E840FF6FC74BDDB656AE72FD8DF1E4F8D881AB6FBE
            BE3E87AEFFEE3C9DE795D3E56974BDB56AFBAD93BFF011180F4163112767E566
            1776721666C6BD1D61A67C05B13E952F5357A6E6E5D43B77DF9717CFCA7CB12D
            C85FAE6DC70ED59746B2C9527FD194C19D73C76DD22E6087AFEEBDB563F202F6
            D962582AD5AD2728CCA99EA3FC4744787ED3BCCE53DF3C65F5F3D5799A1AE57B
            BF7ECAE2B0F2E684F77839A4F71EAF2AF785A250C5F98D4933D34F8632535E09
            539E82427FD194C1D39EAF303FB581B617DEF2BED0B58E9EF8E24F1FFDF0D113
            7F19F2536F7EF0E887FFF29E4F3DFAA3BF747F38CA69DCF8E447B27FF442FBFA
            C09F7CE2578E3DF4BB7FFA97AF79FB875EF16BEF7EEFA71FBFFDDDA77EF4E7FF
            E0F8FD1FE95C07EB3C290A18C0D80C5AC0D2778D8A93AAE27CAB98134F98C299
            53FB6B48E52A876F3C54CC3C7AE8D21B8FA573E8B8A9724C3A69ABE7348B26FF
            A57BF8088C87A0B67A2767D7DD7FA6BBDBE3C9B47F035654A3EA64BD39A12F5E
            3CEDD74C9DFD78F14CEF3CADF3ECFA599EF795B3F36BA7C1F49D99728E5EE82F
            9A32B873EEB85DAACA149EB2EC8077D32E60E9C745FF096A86D5CF4BF3B3227F
            6174D23C5F53FE92257B53979AB7FC9EDEE3E5749DC9EFF10B7197AAD55BA63C
            0585FEA22983A73D5F617E6A036D2F78FDFDAFBFFBE4CBDFF89197DEFE91971C
            2973EB8917FFC6899FFB9D877FE817FE58019B76F41E7EF8E15FFC771F7AF7A9
            C77EE6AD1F7CCDBFFDA3371FFFD397FDFA1FDDFF950B6F79F02F0FBDFAEE4F7D
            EA53695CA9F3A42860006333EC15B074769596662761CD5F81E7AB1C3D1466DE
            539C4987B3BAF2F4ABFE0BF252E7A4AD984E4B269C9A878FC078081AAB7772A6
            804D4A7EF25DB5A3FC79EF641F5E3C535E39ED2E94BF2AE67EE5ECF8DA6990DF
            69DB946FA915FA8BA60CEE9C3BCE9FF8A60E7F163A4FD6C40236F1098A37EAC1
            339EF72CCDF3158F76FFE0346FEA427CCB97477EEE67AAF71ECF36D27AE3579A
            A729FE28687EC2D4A63C0585FEA22983A73D5F617E6A036DAFBFFDFD4F7CF5C2
            99C79F7CC31D0F7CE5F1F3C5C45BDEFB95C79F3C7BEEC24DBFFE9E70ECD3B889
            EEBBE1B2CB6EB82FDDD8BB230777B4B52307E3ABA3B487FD98F228F223D93F7A
            A1621D7AEDF1777CEC2FBFFF5FFFF61DBFF347B7FDCEFBAFBBF5BD7FF085277F
            F5C173CF7BE1DB3EF1894FA471A5CE93A280018CCD5A15B070C29DBE3F969D43
            77FECEBBDE6C71F6569FA6CF57C056EFE44C019B98F8F2082F9BB94EC497FFE2
            89CFE6840236E99553DEDCFD2B273771667E66DF736C79BFD4619BC4635B1DE1
            EE1BBCFD5CA4A5FD2728266CA43CC52EC6D44FD9CCE4CF576C3BCD9375EF75E5
            33921FEDECD9694D67073656EE99CF54F9746703BACF54FE344D1C102CF1F90A
            F3531B68FBB9DF78EFA34F5C088DEBF8038F7CF9B127C3C4239F3E73E68927BF
            FAB5A7EE7BDF23E5816F49AB458B2D603BDD5A2860078FA4E9BDD855017BF8E1
            877FE9E8BBBFF7256F79E5CDBFFBE18FFCC9353F73F76FFEE9576EFBB3AFBDEC
            2D9F7CC14FFDD6273FF9C934AED47952143080B159A7AF20DE13465E1D7F9B42
            750E3D7123F184AC3E7B2B4EA6E72B60AB7772A6804D4EF12C1F3A30F11F83F5
            B30F2F9EF88CF70A58D6B84A4D1FCB5E393B2F60E9559AD279E504D94BB12F9C
            A597AA33F4703B9B6C2D9A346797052C1CE1F23056477856012B9E97C94F505E
            B9C316CA1F29D9CF8AB09129AF81CEF3950A734C7584ABBF7F89A98F5EFE1EAF
            DFDAC55A173A6FE109CF547C228A9CBB36ACD879A6DA4F53DC72BD33B5A53D5F
            617E6A036D3FFB2B7FF4E79F3B7BE4D8CD273FFDE81FBEFFD4971F7FF2D56F3D
            74FA0B9FFFCC17CFBDED1D1FB9E9963FB8E9967B5FFD2BF7BEFA97DFF5AA5F7A
            D70FBFF8E7D36A51AC2EC59F070F5E56ECC965371CB9214DDC572E4DF3EBA614
            E695B7AB2B56CD98CB2E8B4BCA05F5B0B462332CAB5CBD02565C126BB69B4F46
            D5E8FAD259B3F138B4253F92FDA3F7C8238F840E168AD6430F3DF4D6DF3FF1FF
            BDEBA137FEC9D9EFF957BFF7633FFBDB0F7CE044E7F770749E14050C606C56F4
            9770B44ECEEA559AED54E7D021C52972296D249C90C52F389513C5FC4361A2DC
            609853AD35A580052B7572A6804D497146DE3ADBAE5E219D67395FB4C4174F7A
            79D42F8C4AD3B80AF1A5B5E46BA741FBCC7E3BC70EE5A7EBDBEB9C3BCE95AC5F
            85E254C89FBB38A09135DEEE1354AD1ED45B08CF6F9A159FA0FA996A9EB2696F
            F675B4A8E72BCC4F6DA0EDA75E77DF571E7FF225B7FCB3DBDFF9F31F3DF5B150
            C0BEF786BF75E8F57FFFF73FF4EFC3F499272E9CFDABA78EBFF79127FEEAA927
            BEFAD4BFF9C56369B5285697BAECE413F9FC72415176AAFF961DA8BD4A1C550F
            4FF3AA8E950FABD53D2AA816C6ED164B52DBAAEEA8BEF366E3D5D6B339B9FC48
            4E3B7AC1273EF1891B6EFBE35F7EF7E7FEC79F3C76E7EFFE71E8637E0B22001D
            FB54C026A439631E26E123301E8285EBDC91EC2E330BD8C0E9BF78D255A9E1AF
            9D06AD15B773F2E69B77743E3FF5847E95B3BC37FBBE5BD8F315E6A736D076FD
            CFDD1B0AD8CB7EF1075E7FEC7B7EE4757FF705AFFB8E7FF1AFBFED8F3EFBA2EB
            6EFF073FFDA61F3EFDF9CF851A76FC8153671E7F3274B09F7CCD3BD26A51AC2E
            7581E94C64C5264DA6C65398507E3AD379B5CA17D5B2AD65CA35276E330A6B65
            8A8513373E7701FBE4273FF9EA5BEFFDAEEF7FC32FDCFACE50C6FCFF8001D0A7
            802D58E75E64D759AF0216ACC0B5D37A51BF952D4CE7DC712DB2A437FB5A98F6
            7C85F9A90DB47DFF35AF7ECF873FF3B677BEF9477EFEEFBDEF2B2F7EE0CB2F7C
            DF975F72F767FF87777FE1076F7DCF95D7BCE63B7FEF81DFBAEF81D36F7BC79F
            BCEBFE93AFF899DF4AAB45B1BAD405A63391159B343967012B3A521C17A6CA59
            F9B05AB6B546185915AB74B3B3627FAD891B9FAF8085BA150AD88913271E7CF0
            C18F7D6CC2FF0358946F2A440103189BE10AD8D0091F81F1102C56E75E64D759
            BB0236129D73C7B588E7AB9F303FB581B6F23A50E15BFFCE330EFECCDFFE99DF
            BEF4E8C7FED19DA7FEF1DB1FF9EF6E78FB775D7ED5DF7AF3EFBCE5F803A7E2EF
            457CE94FFD665A2D8AD5A52E309D89F0672A42C554AA5B339A553D5D77A430B1
            B30256DD41B5F97C2A4D1643E29C6AF0C48DCF57C03EF5A94FDDF3EE0FBEFE37
            3FF09AB7BCF7DFBFEB81CE6F9FAFE59B0A51C000C646015BB0CEBDC8AEA380AD
            A6CEB9E35AC4F3D54F989FDAC014A183FD8D6FFBA6FFEC3B9FF1CF5FF1ADBFF6
            C1EFFA672FFA4FFFE54BBFF7537FFED92F3FFEE41FBCF791F0E7D9AF3EF5C29F
            7C6B1A1DC5EA521798CE44F1E7D45FC29166D4AB148ABE5596A372A21874305D
            0B6B0DAB54A3A28347CA6D5777542C8CD3F55DB6966533266E7CBE02F6677FF6
            672F79FD1FFCD6A7FEEAD5EF38FDFFB8E6C89FFEE99FA6056DF9A642143080B1
            51C016AC732FB29159D28B672D74CE1DD7229EAF7EC2FCD406660AADE4BFBFF6
            6F5EFA2F9EF5E6DF7E4B285D1F3BF9A5B7FDEE47DF7CD78937DFF5E163EFFED4
            8FBCE2681A378F29C5665DE44772DAD10B8DEBEAFFCFBF7FF95B3EF94387FFEC
            1FFECFBFFAD18F7E342D68EB3C290A18C0D828600BD6B917D9C82CE9C5B3163A
            E78E6B11CF573F617E6A03338502F6CA375C1D2F7CBDEB3D8F7CE9D1F3216FFA
            770F7EE9D1271F7BE2C20FBFEC8D69DC3C4650C03EF9C94F1E79FBBDFFF71FF8
            8DE71EF8D55FBDFD1D9DFFFFE55AE74951C000C666D4056C193AF7B2BB6CF691
            DF80A4277BAC3A4763F593F67BAC3A472326CC4F6D60A650C0DEFDFE47BE72F6
            C92F3E7AFE8D7786DE753E4E843F437EE0C5E94B7C63901FC96947EF91471E79
            E8A1873E520A13137F0562D07952143080B1196F015BC1449D9922220BCFFC05
            EC9F7EEFCB7FF0C76FFFC117DF1EEAD6D52F0AB92DE4F93F76DBC117DEFA4FBE
            67AE8D6C86790AD89C1430809153C0444446973D56881152C0005814054C4464
            74091D809D5AE0D1AB3715A280018C8D022622223258143080B151C044444406
            8B020630360A988888C86051C000C64601131111192C0A18C0D8CC2A60E15301
            0058AAF4A1DBA680016CAA5905ECCEBB7E57444444969AF4A1DBA680016CAA6D
            0A581A05002C8102063036DB17B0C701604DC4CFB635A280018C8D0206C0E688
            9F6D6B440103181B050C80CD113FDBD688020630360A18009B237EB6AD11050C
            606C14301A276E7AEED6D635773E7EE735CFBDE9449A07B04EE267DB1A51C000
            C646015B316507AA8532B46055C79AE8CE6BC2926284FEB52AA6BD1EC2FCE9CF
            626B64C78C17C0EE16EDC52E1E5D7B95E285BAD37DDBC363E91DDA6C46D86CB1
            37B38FFE2ECDBADF6D9423B3C1D5F19BB97218B48B8790365DFDF098F8D738D5
            DD47BBB89379C4CFB635A280018C8D02B662CA1394785E524EAA42E336F9F590
            CDED5B4605987987BBB78B47B7F73DD9CB163AC736BF19A68BA9651CFD99F7BB
            8D62E8739F5BFF9D4AF1E08B9BB3D6DEE5010AF714EE24FE596E64D226B26D97
            9369B7162B7EB6AD11050C606C14B015D33AF9294F9EE2194A79CA15D5E735E5
            D864C2CC34ABDCC835D79473AFB9B37B0254CAEF2FAACF8B26DD2FFB67C2EBE1
            CEE6699F78FA5A3E65C52AE5BAD553DF7AD6B3C9C98BBAAF84D66E2C4E6BB3F3
            3DBAFE9ED473CA89EEE35DF063893B99BF39D296C256CBF9F9BC059A76BFE5FC
            FADD5D2E6D8B2BDE14DB6179F39A9BF203506E2B2A679547276A1E4FA9BEFB29
            C2C83024FE196E4C1EDE3AF8C5B6D3B0EE6E14B25D9934B39ED5133FDBD68802
            0630360AD88A699DA05437F299F5494B39339EBE342732139696A7367169506F
            AA3F32CC89C3266C246D66FA390FCB513F5FAD1BADB95DF533558E8AC39A67B2
            5EB5FF2CE78BE2B3DE1E33ED0E77AFB5D9FAC6CC3B2B1756CA41EDF5B279E59E
            2FFAB1D49B696F284C3777B3FBAD4F37E57ECBBB4BF3278AEB855A5B3DF6D471
            9BC3946D296E289B1B66360F6BD6DD14CAF5CA61616ACA21C8EFB1BE91CFACEF
            A89CD9BDF3494BFBE267DB1A51C000C646015B31934E50CAFFB494039AD9D5F8
            F6DA4971CED21F316964BEC9FE98794EC158B4D67350DF98FCEC25F5135E8E4A
            4F59FBCC352C9DB0897C56391DD59B6A8F5E84D666EB1B33EFACBFB0BD5EF7F1
            5603A26D37BFBDD691ACEEA2981B37591FFD459B7ABFB3EF2EAD96F6AFFC4F7D
            00B20393945B6A1FA06CD0ACFBC9C5CB5FE5AE75576A6D3BDD98B51BCDCD426B
            EDE9E267DB1A51C000C646015B31AD538C74F254CEAB4FB93AD2694E5C69D209
            4ADA48BA558DE88F6CEEA5DC646F4C7B3BEC8FD673503F05FD672F533D7DD933
            3A61D5099B682D6ABD12268D5E84D666E77B74FD85F59C72A2F3789B790B7B2C
            69D3C566D29D95F3D216EBBB59B849F75BCD4CB726A806947B58FE31F980659A
            03D40C283633E7C30A2B85558A5563B76AADD56C3B48FBD6DCCB04E51D17EA1D
            DE7E2FE267DB1A51C000C646015B31F929463A3FC9CF83B2E5F9694B3DB2394F
            6ACD4AC3827AFDDEC87A4639A499EADE05FBA979BEF3A7209B9B0F88DA4F64F7
            E9ABC7D7C3EA65D5A2F6069AA972F042E59BADF7309FDBBFDF1973CA89CEE35D
            C66329B75DFCBBAB745FE526ABE9FA0E17AF7FBFF9512B4C7868D5806217C3BA
            69328D2AA7E2EAD9AACD64FD60CA599D2D4F11D6A9D6D8A680D5FB5ECEECEE46
            36B31959EF503D2BDF60257EB6AD11050C606C14B015539E4FD49A138BF2CCA3
            94CE49827C6C3DB799D93D792965E72BDD91F5ED6BAE695669EEB77B96C37EC8
            9FE3EC29484F4B7892B2273429971573CA45DD574136BED976F602A8572CD4AF
            846CAD456AF6A0506F7FD6A39B31A79C98F8780B0B7C2CCDFE3533AA0DA665B5
            66D0DEF5EE377B9CA5090FAD1E1057AE8F537F7F5B0F27CDE81FBDED34BF7D23
            6DA5BD3BF5064BCDB249BB918FADE73633E3ACD68349E267DB1A51C000C64601
            1BB1742ED3397B015863F1B36D8D28600063A3808DDC9DD5AF3903D804F1B36D
            8D28600063A3808D57F345A3340360EDC5CFB635A280018C8D0206C0E6889F6D
            6B440103181B050C80CD113FDBD688020630368B2960715BC0FC36F28DE341F5
            3926FB691D8FB6020630360A180C63234FAD3CA83EC7643FADE3D156C000C646
            018361382F5F177B7C508EC97E5AC7A3AD80018CCD0E0AD8D6D6569AEA89DB02
            E6E7BC7C5DECF1413926FB691D8FB6020630363B2B60D33A58DC16303FE7E5EB
            628F0FCA31D94FEB78B4153080B1D971010BD2ED4CDC16303FE7E5EB628F0FCA
            31D94FEB78B4153080B1D94D010BD2AC4ADC16303FE7E5EB628F0FCA31D94FEB
            78B4153080B1D965010BD2DC52DC16303FE7E5EB628F0FCA31D94FEB78B41530
            80B1D97D010BD202050C76CE79F9BAD8E383724CF6D33A1E6D050C606C5C0183
            61382F5F177B7C508EC97E5AC7A3AD80018C8D7F0306C3705EBE2EF6F8A01C93
            FDB48E475B0103189BDD14B0743B13B705CCCF79F9BAD8E383724CF6D33A1E6D
            050C606C765CC0D28DB6B82D607ECECBD7C51E1F9463B29FD6F1682B600063B3
            B30296A67AE2B680F9392F5F177B7C508EC97E5AC7A3AD80018CCD0E0AD80C71
            5BC0FC9C97AF8B3D3E28C7643FADE3D156C000C646018361382F5F177B7C508E
            C97E5AC7A3AD80018C8D0206C3705EBE2EF6F8A01C93FDB48E475B0103189BED
            0B1800B0240A18C0D82860003018050C606C143000188C020630360A18000C46
            0103181B050C0006A380018C8D0206008351C000C646010380C128600063A380
            01C060143080B151C00060300A18C0D82860003018050C606C143000188C0206
            30360A18000C460103181B050C0006A380018C8D0206008351C000C646010380
            C128600063A38001C060143080B151C00060300A18C0D82860003018050C606C
            143000188C020630360A18000C460103181B050C0006A380018C8D0206008351
            C000C646010380C128600063A38001C060143080B151C00060300A18C0D82860
            003018050C606C143000188C020630360A18000C460103181B050C0006A38001
            8C8D0206008351C000C646010380C128600063A38001C060143080B151C00060
            300A18C0D82860003018050C606C143000188C020630360A18000C460103181B
            050C0006A380018C8D0206008351C000C646010380C128600063A38001C06014
            3080B151C00060300A18C0D82860003018050C606C143000188C020630360A18
            000C460103181B050C0006A380018C8D0206008351C000C646010380C1286000
            63A38001C060143080B151C00060300A18C0D82860003018050C606C14300018
            8C020630360A18000C460103181B050C0006A380018C8D0206008351C000C646
            010380C128600063A38001C060143080B151C00060300A18C0D8286000301805
            0C606C143000188C020630360A18000C460103181B050C0006A380018C8D0206
            008351C000C646010380C128600063A38001C060143080B151C00060300A18C0
            D82860003018050C606C143000188C020630360A18000C460103181B050C0006
            A380018C8D0206008351C000C646010380C128600063A38001C060143080B151
            C00060300A18C0D82860003018050C606C143000188C020630360A18000C4601
            03181B050C0006A380018C8D0206008351C000C646010380C128600063A38001
            C060143080B151C00060300A18C0D82860003018050C606C143000188C020630
            360A18000C460103181B050C0006A380018C8D0206008351C000C646010380C1
            28600063A38001C060143080B1D9BE80BD7BE78EEE5C5A130046237CC82A6000
            633357018B43E714C68742756A27C2F8B43200ACA75D7C5C863F153080B151C0
            006001143000E6A18001C002286000CC430103800550C00098C79E0AD8CB4AE9
            464501036084FA1F97133F256B0A18C038EDBE804DFB5C51C00018A1891F97D3
            3E2B03050C609C7659C0667FA22860008CCDC48FCB60DA27A60206304EBB2960
            D33E4B22050C80119A56C082899F9B0A18C038B90206000B30AD804DFBC454C0
            00C6C9BF0103800598F87139EDB33250C000C669F7052C98F8B9A280013042FD
            8FCB899F9235050C609CF654C02652C00018A15D7C5C863F153080B151C00060
            01143000E6A18001C002286000CC430103800550C00098C75C056CA742A1DAA9
            B426008C46F89055C000C666FB0206002C8902063036DB1430111111596AD287
            6E9B0206B0A96615300060100A18C0A6DAA680BDFF031F1411119125257DDCF6
            2860009B4A01131111192CE9E3B6470103D8540A988888C860491FB73D0A18C0
            A652C0444444064BFAB8ED51C00036955FC201002B470103D854B30AD89B0080
            650A9FC4E943B74D0103D854DB14B0340A005834050C6084B62F601FFFAC8888
            882C3E0A18C0082960222222C34401031821054C4444649828600023A4808988
            880C13050C6084143011119161A280018C9002262222324C1430801152C04444
            448689020630420A988888C83051C00046480113111119260A18C00829602222
            22C34401031821054C4444649828600023A4808988880C13050C608414301111
            9161A280018C9002262222324C1430801152C04444448689020630420A988888
            C83051C00046480113111119260A18C0082960222222C34401031821054C4444
            649828600023A4808988880C13050C6084143011119161A280018CD036050C00
            589EF0499C3E74DB1430804D35AB80A52100C0D2A40FDD36050C6053B9020600
            83099FC4E943B74D0103D8540A18000C237E12A70FDD36050C60536D5FC06E04
            0096207E12A70FDD36050C6053CD55C05EC692C54FE27483A5719CF7473CCEB0
            47E9F5B4B9C2638C9FC4E943B74D0103D854F316B0532C4DFC18769C97CD71DE
            1FF571863DDAECB76A7CA7C44FE2F4A1DBA680016C2A056C78F509ABE3BC548E
            F3FEA88F33ECD15EDEAAAFBAE374272FF889BBD2B2D510DF29F193387DE8B629
            60009B4A011B5E7DC2EA382F95E3BC3FEAE30C7BB497B7EA030F7D217DCA954E
            3FF48550C0BEEFB5A7D3E21510DF2971F7D2876E9B0206B0A914B0E1D527AC8E
            F35239CEFBA33ECEB047BB7EAB3E74DB773CF0D063E953AE74A22C60CF7BD5E9
            173CFF781A34B4F84E89BB973E74DB1430804DA5800DAF3E611DF571BEEF86CB
            B60E1E49379662E58EF3F21FF220EAE30C7BB4BBB76A685FE7CFDF565F013B7F
            F1E2171EBBF8D017CE870216F3D06DDF1E92460F27BE53E24EA60FDD36050C60
            532DB9801D39B8155C76C37DE9763CE96C644BC2D0EC6434AEB8D5393F4D2BF7
            4E5A9B8DEEF07CB6DAE00D375C96EFE4FEAA4F58E73DCEF31DD5EA10EEF818B6
            37BD10DB3F4161C4A445C58AC5FCF0DF62A78E1CDCC3AE4D3DCEF31DCF298F21
            CD9E713C77F990FB9A4D96A66DB72FAC181E43FC33CD9AD3F49D99AE3ECEB047
            F3FE486C7BE88EE79C3FFFAA074E9C0E9F7075FB7AE00BE7EF3E7DF1B6872EDE
            75C74F5C7CECF90FDDF6AC34BAAFFED139E34DB69B7753577CA7C44FE2F4A1DB
            A680016CAAE517B0CE27D8E4CFADF889570F0D37CB41934EFF7A9B2C06559BAC
            569CD3223E44F7AE3E619DF738CF73549B2331E141CE3C86E5E2DE61DF83B99E
            A0FBEE9B34B75CB7D995090F6507A61EE7798E6733A7BD4BA599C7736F0F39D7
            DAABA99B9DA0B5E28E4CDF99E9EAE30C7B34EF8FC4B687EEF88E50C08E3FF050
            F884CBDBD7DD0FDCFDD05DCFEBE68EE7A4D5A2FC255F4CEFF29D338FF84E899F
            C4E943B74D0103D854AB50C0C2AC30281BDA8C9930BABBC9F690FBEE3B124F6B
            C3ECF26F30ABCFCFE24E0EA6BFD84CEB872D55B7E3468A3F0F1E2CD68B73E274
            D8C291B8B1B8A97ACB693BF95AC5ED1DAB4F58E73DCE731CD57C466F616F03E1
            767B4473A5293B48C5CDF6830DB7E2C2894B93F6DDA727A833B2732FF596CB31
            E99ED2F8F434A401F5F33B87A9C7798EE399CDE92FEB6DA03D64970FB9AFBDD9
            E64EA76DAA9E13574CABD7A30B717BDDF19376A61E53ED42B352B65385FA38C3
            1ECDFB23B1AD2E60E72F86F675F1F8172EDEFDD0E9BB8FDF16EAD6F92FDCF2C0
            433F71F1FC2D174FBFA8F8F3FCABBA97C2D2DBA4ABFB1E89C38A3FB337F50EC5
            774AFC244E1FBA6D0A18C0A61AA280C58FB1A0F539970D9D3C9974E7F44704C5
            BDC4B961717937AD39D50AF143B49E28C654FB544FE713714C1A526D275F6B57
            E2C7F00E8E73FF2117FB5089FB523DEE89FBD7D940F3983AB20569957C63CDD2
            9987A2BFB7C1E4EDE4F7526FB09A13C6D423EB01C51ABD7B9C62EA71EEEF6179
            BF49BDF93473C2DD7537B09087DC97ADD53CF0899B4A73AAFD88735AAB0755CB
            9E38BEB333F59CFA7EABB1F954541F67D8A3EE5B753EB180DD75FC74EB4AD75D
            CFBB78FEB6F38FBDE859AF7CE6F36F79CEF913DF17DAD76327AE4CEB64C20BBA
            94BDAA27BE47C29CE27D9116EC427CA7C44FE2F4A1DBA680016CAA15F90A6290
            0D9D3C9974E7F44704FD2D34F79BED413D1927F27DEB2CEA4CC40FE8DE19F0EE
            C48FE11D1CE7FE439EB40F6154DCC98307BB0B3B1BC8D7AED62A07D4374AC598
            CE1DCD7328FA7B1B4CBCCB5298DD59D83C7DF5826C9B13373FD1D4E3DCDF44FF
            818431694E58D61DDEDDC0C47DEA3CAA4CFEC8E2C2C98FA8B8E7461ADFDB547B
            6439236E3DBF8FCE9DB4C7E703D3B86C789AAC57E9ED6B7D9C618FBA6FD5F994
            05ECB577DFF1A2B274DD52E462C86B2F9EFF8990E7DCF1ACEFB8E55B9EF7AA67
            9D7FEC950FDD31E35771C4B756F5FA6EBF4726BDA7762CBE53E22771FAD06D53
            C00036D54A16B066CC84D1DD4D4EDC6036284D4EDC663D1927F24D7516D51361
            7369D361AA5C90AFB52BF1637807C7B97B08B6D987FEF0EE9CEAA1D4D280D977
            1496A6C5D5FA137763DB99BD7B99B030CEAA1764ABF4D69E6AEA71EE6FA2B7CF
            AD19BDF1DD19BDD50BF9CCDE16662EAC3483C2906A787F7498936655C3E28ACD
            EAF9BD4D183F6167D27FB23951185A9E933673143016A7FB569D4F51C042B90A
            EDEBE21D172FFEC42D773FEFF9773DE705777D47C803AF7DE63FBCE35BBEEFEE
            677DFB6DCF7CCEABBE25DC4CEB4C91DE0BBDF748EF3DB51BF19D123F89D3876E
            9B0206B0A956B280E51F72DDF5FB9B2C06559B0C0BAB53C8899F97C59C6C0FEA
            C938912DE92EAA27EABBAFEEAA19B05BF1637807C7B9770826EC433D262CEA8E
            EE6FA018946DA0786CC5806676B595FC8EEAAD14C3CBB9F9D246BEF16A683EB2
            595E4C55F7DB6CBAB9DF7AADD6807A43DB987A9CEB0752ABEFA896DD4FFF2E7B
            1B28F62F1B5E4EE7DB6C96578FA4FA6F1CDFD99DA4BB8572547F53F5DE54F79C
            56AC56EFEEEDC4F1D9AC62AA35A718D3CCA86755EAE30C7BD47DABCE2714B0C7
            4E3FBF2C60AF0A79FE2DCFF9BE079EF38287FEE195C7BFE379777F7BC873EEF8
            9667DDF1CC67BE766BEBFBB6D23AB5EA255FAA5EE66166FDF29FF49EDA9DF84E
            899FC4E943B74D0103D854AB59C0E2E75CF76FD6A3FE269BD1E9B3B1507C7296
            D2E0E67EB33DA827E344B6A4BBA899A8F7ACF8951EC5C6F3B576257E0CEFE038
            F70FC1A47DA80FCA7CC7303B88F92A9DADB4EEA85AB6FDA168B69D96774676EE
            A55C5EDEBEECB2780294C697E3CA15AB01D9AE6E67EA710E5BED6C65D203691E
            43EF2EFB1B58C043EE6FB5BD856203F1667753D5EDCEF312FFAC0797CA0DF4C6
            4FD8997A4EB34FCD96B2BD0AEAE30C7B34EF8FC4B687EEF8F6D0BECE9FBFADF8
            CE6159C042F54AEDEBAE67A5F675CBD6D68B7AEDAB54BFD483EAA53DF33D558E
            D885F84E899FC4E943B74D0103D854FB5EC0F66C099B1C587DC23AEF71DEF321
            D8BC63388FA9C7D9F15CA8FA38C31ECDFB23B1EDC42DCF2C2F7F9505ECFC2B6F
            B9FB79CFBBE5DBAF0CB9ED3B9EF7DA6FFF96576E3DF3B55BCF7AE5365F3EDC07
            F19D123F89D3876E9B0206B0A9965FC0823DFC1D615BFAAB49056C0F4775338F
            E13CA61E67C773A1EAE30C7B34EF8FC4B6075EFBCCF35FB8A3F8AD1B175F75F1
            7CCC2B2F9E7E41981FF2CC176D3DF345DF9286F6146FE69EB46CD1E23B257E12
            A70FDD36050C60532DB9803187FA84D5715E2AC7797FD4C719F668776FD5B280
            DDF2D8E9E7C7C655272D5E19F19D123F89D3876E9B0206B0A914B0E1D527AC8E
            F35239CEFBA33ECEB047BB7EABAE66E3EA88EF94F8499C3E74DB1430804DA580
            0DAF3E61759C97CA71DE1FF571863DDAECB76A7CA7C44FE2F4A1DBA680016CAA
            790B184B559E6C38CE4BE738EF8F789C618FD2EB697385C7183F89D3876E9B02
            06B0A9E62A6000C0C2C54FE2F4A1DBA680016CAA6D0A581A05002C47FAD06D53
            C00036D5AC02968600004B933E74DB1430804DA580010CC9770D462EBC00D287
            6E9B0206B0A9B62960C53F02036039E28F593F6C472B3EF5E943B74D0103D854
            DB17B0C701588EF863D60FDBD18A4F7DFAD06D53C000369502063098F863D60F
            DBD18A4F7DFAD06D53C000369502063098F863761F7FD89EB8E9B95BC13577A6
            DBDB49E3E75BA5185C0C2B57AAC7B76F75DC79CD736F3A91A6E7D1DB9F30236C
            21FE59CED8CE4EEF71B9E2539F3E74DB1430804DA580010C26FE98DDBF1FB63B
            282A41D176AAE1775E534F4E558C4F052CC81A527DA36BEFFBB3B32DEC7CFC92
            C5A73E7DE8B62960009B4A0103184CFC31BB5F3F6C4369A9AE1E153DE49A6B8A
            AB49F974E83477C64B4C45496977951327EE3C51DE08B38B1141D5AAD29C7223
            5501BB292887DF79CD3537DD5417B06C179A2D554DAABC915FDB4A33D25E949B
            EDEE4F9C592F6A6DBF5C7ACD356956EF1EBB83FBF7B87CF1A94F1FBA6D0A18C0
            A652C00006137FCCEEDF0FDBBAA8145DA36A19F5743E11FE1BFA496A26997A0B
            457D2917176BD51355CD299ADC35C5B8E21B7FA1D45503AAFB4C2BD7739A45D5
            669B7BEFCFC9C415F33FCBD9CDF6D33AD5CAF598FEE066FB13EF6929E2539F3E
            74DB1430804DA580010C26FE98DDBF1FB693EAC7849971625A0D094BB30B45F9
            96D21AD5EA61FA4451C3C2ED72436171A6BB727BB3CDCD7A1F26EE4FDC42FC73
            D6F6ABA97ACEC4C1F146FF5E96263EF5E943B74D0103D8540A18C060E28FD9FD
            FB615BD78FA6994C9A1927F231B5A2B7C48212A68AC5F9A85491D2ACFACB87E1
            76B94A5A9CA957EE6D360903EA4E94DF532DCE8C7FCED87E3D55CFE90F8EC280
            FA1E972F3EF5E943B74D0103D8540A18C060E28FD9FDFB615BD78FA6994C9A99
            26C27FEA325434A462BAEE2DD58C725433AB98AA57BF26FEF68D70BB1CD06CAF
            5A278DCCEA50B5D96A449A57DF531CDE1A17FE53FF396DFBF5543DA73738FDA7
            54DDE3D2C5A73E7DE8B62960009B4A0103184CFC31BB7F3F6CF3FA51378CFECC
            6669D173A26A7835A7FCE516B1B084E1E5ACE73EB75D7BB2FF66CD264A33CADB
            C5A0099BEDDFF78479F13EAA7BEA6EBF9EDF4CD5F7D81B3CF91E972B3EF5E943
            B74D0103D8540A18C060E28F593F6C472B3EF5E943B74D0103D8540A18C060E2
            8F593F6C472B3EF5E943B74D0103D854DB143000962A1630464B0103189B5905
            2C7C2A00004B953E74DB1430804D35B580BDE1C8D15B8EBC5D444444969AF081
            9B3E7A330A18C0A69A75050C0018840206B0A914300058390A18C0A652C00060
            E52860009B4A01038095A380016C2A050C00568E0206B0A914300058390A18C0
            A64A054C444444562A0A18C046DA4AFF05000060C914300000807DA280010000
            EC13050C0000609F2860000000FB4401030000D8270A180000C03E51C0000000
            F68902060000B04F14300000807DA280010000EC13050C0000609F2860000000
            FBE2E2C5FF3F2159FE5700D4FA790000000049454E44AE426082}
          Stretched = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo4: TfrxMemoView
          Left = 772.244590000002800000
          Top = 29.236239999999990000
          Width = 318.826840000000000000
          Height = 177.637910000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo do cliente '
            'C'#243'digo do vendedor'
            'Data Inicial do Per'#237'odo'
            'Data Final do Per'#237'odo'
            'C'#243'digo da Marca'
            'C'#243'digo da Linha/Grupo'
            'C'#243'digo do Fornecedor'
            'C'#243'digo do Departamento'
            'Tipo de Meta (V)alor (L)itros/Kilos'
            'Valor da Meta'
            '% de Desconto')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 13.779530000000000000
          Top = 1348.685530000000000000
          Width = 1065.827460000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Figura 1 - Geral')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 12.000000000000000000
          Top = 30.094309999999990000
          Width = 393.763760000000000000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '* O campo C'#243'digo do Cliente n'#227'o '#233' obrigat'#243'rio!')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 12.000000000000000000
          Top = 104.787260000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '* O campo C'#243'digo do Vendedor '#233' obrigat'#243'rio!')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 12.000000000000000000
          Top = 144.684910000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* Os campos gerados em branco na planilha n'#227'o ser'#227'o atualizados ' +
              'no banco. ')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 12.000000000000000000
          Top = 84.535250000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* O campo C'#243'digo do Cliente se preenchido deve conter 8 caracter' +
              'es!')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 12.000000000000000000
          Top = 125.432900000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '* O campo C'#243'digo do Vendedor deve conter 3 caracteres!')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 12.000000000000000000
          Top = 49.850340000000000000
          Width = 585.425170000000000000
          Height = 31.078849999999990000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* O campo C'#243'digo do Cliente se n'#227'o for preenchido, ter'#225' um filtr' +
              'o baseado'
            
              '  no c'#243'digo do vendedor que retornar'#225' todos os clientes vinculad' +
              'os a ele! ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 12.000000000000000000
          Top = 166.850340000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* Os campos C'#243'digo da Marca e C'#243'digo do Grupo devem conter 6 car' +
              'acteres. ')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 12.000000000000000000
          Top = 185.850340000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '* O campo C'#243'digo do Fornecedor deve conter 8 caracteres!')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 12.000000000000000000
          Top = 204.850340000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            '* Os campos de Data devem estar no formato dd/mm/yyyy!')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 12.000000000000000000
          Top = 224.850340000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* O campo Tipo da Meta deve levar as informa'#231#245'es: "V" (Valor) ou' +
              ' "L" (Litro/Kilo)!')
          ParentFont = False
        end
        object Picture2: TfrxPictureView
          Left = 17.000000000000000000
          Top = 1010.881880000000000000
          Width = 1060.646260000000000000
          Height = 336.677490000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000480
            0000028808020000008749165A000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            00CA2C49444154785EEC9D075C15C7F6C779793D2FFFF49EBC3C1335DDD811BB
            62EF15052BA262C3865DEC0DC48EA208A2D87B572C888A1D51441151912EBD4B
            B325F99FBD3B77EFDEBDBB7B776F05F77C3F939BD933F5CCCCCECECF5BB0A959
            AB2E060C183060C0800103060C18AC12FE441486CD660441100441100441AC04
            3995238A01051882200882200882580D722A4714030A3004411004411004B11A
            E4548E28061460088220088220086235C8A91C510C28C010044110044110C46A
            905339A21850802108822008822088D520A7724431D87CBEF5AF9C40D6C2E6CD
            BA1604411004411004414C083995238AC1E6A9360B2FCDF82C90282E88D081BE
            4410044110044110C4B4905339A2186C8A593C7BF62C232363FE85699FF9AB35
            98FF5F99388220088220088220A6859CCA11C56053A4C3D3A74F679F9DF4E97A
            A2BB980882200882200822132FA76A3636D59CBCC865A541D56F86E61389D910
            263637B6065D2A54F7A0066366989CCA11C56053C0475252D2CCE0099FFAA0F4
            4210044110043102100A40255360B4BA61699289CD4DAC9F8CA2C2750F051822
            0B9B7C01121212A61E1FFBC92AD46008822008822006421FCDA9F7582A928211
            87D23715583056C0EEA100436461939B9BFBC9B2BFEA06B0C7C5C54D3E3C06E2
            64752008822008822032509FCC29D1C05660F435A5CB1865465F5054739AA8C9
            AE7DB657D7436566D5C7D624549C81DDA65438757311AA9FEEA82695D56B2D1F
            D8E559792463CDEEA912994A35575A35501DA4D1292F003995238AC1262727E7
            63CFBFDE2AB906811D017B767676646424C4C9EA40100441100441A4A3399853
            8775961CA02EAB556BAE7568678EEBF4099EE4D63ADB6BAAD1326B2AD76802DD
            2B8950AD0B9611A99FEEB5BA53DC24A6B35E4E8CD795B17B9491CEAC89B16BD0
            B23AA9ABD2033995238AC10654D6C78BDED20D6007222222204E560782200882
            20082219ED933D5B81B1CFE9003B2305A5164866ED244D2D2C3BAF9146BB5549
            B0DAD641AC7E6E39968B3AC5D408260863F5EE913AB5D23417AC16A5434EE588
            62B0C9CCCCFC68DE5BF41B5FEC08D881EBD7AF439CAC0E0441100441104422AC
            233E85D6A5F6395DE7D4CE32688B00BE048D0D4CDAF50868082A9F1A4E7EDE4A
            D488D6AFD3926012D56106DDDEA99A515301BBA76A076035C5AA819416E9A21A
            4D16722A4714834D7A7AFA47B3DED20D60072E5FBE0C71B23A10044110044110
            69689DE3D5B08FE99A0338752CD73AB1B392B5D501BB1C49D1CEAB5D0FB7B814
            A8FA048A88D6AFD3126F125585269F4E19FD5480EE515DD09666DC8C740E6E67
            0421A7724431D8A4A5A57D3883BCF1C58E801DB878F122C4C9EA401004411004
            4124C1231458262AAA399EEBE4A5740049D63EDBB3124812EBF73A78DAD46E47
            1A5419FE42A2F56B750DE0F541BB3FBAF549C0DADDA3F368A7696AD0C05F9A17
            722A4714834D6A6AEA8753DED20D6007CE9D3B0771B23A1004411004411029F0
            1EBF29237DC0A74FF1B4958292034C76EA8251079A329C04803AF703AC665439
            980C32348036AA6AB4EBA52B15A95FBB73D4153B89C4D925549E69B522158B77
            4F63E78BB16BD0FC45322A9DE98A38E4548E28069B14514E9F3EFDC144146008
            822008822032D03AE06B501DEAA953B9EEE95C954443BFBFA249A6B5034F026F
            33AC8AF8BA201576355A1509D5AF1221D4FB7104ED6E323935C5C1C44E908765
            BB4759A91818345959579A1A58CD6B32EA839CCA11C56073421F1F8C43018620
            088220086239A863BCB63EABF8B0654C05A422778F9CCA11C560F3FEE8B7C403
            591A08822008822088454001667250802115071B32F308822008822048C50005
            98C9410186541C50802108822008822088D520A7724431A00043100441100441
            10AB414EE588624001862008822008822056839CCA11C580020C411004411004
            41AC063995238A01051882200882200882580D722A4714030A30044110044110
            04B11AE4548E28061B9FC0FD183060C0800103060C183060B04A20A7724431D8
            90FF2308822008822008822066C6E60F0441100441100441AC043995238A0105
            1882200882200882580D722A4714030A3004411004411004B11AE4548E280614
            60088220088220086235C8A91C510C28C010044110044110C46A905339A21850
            802108822008822088D520A7724431A0004310044110044110AB414EE5886240
            01862008822008822056839CCA11C5C023C04EBADAD8B89E24170613B7AAA14D
            C35571E4CA0C50DD64D0E92FA4AA5A377B3700F19EA8D07443DD3136A6E924D4
            6CFCB4A930597F34987B0E4C0DBBF34CDFF9E64E049E49975983540C1B6A3375
            86C6B02E556A8C1F4FD3CF08350DEC5D41C6AD6DD6E58120088268414EE58862
            D01160F0846EE8EADAB0E23F7AC5CF07BAA9E63B4FC8AAD9ACDD309100330DE6
            F394C11273CA3AB21ADC1C53D04C1D66570B7189FF8062A6CED098B572C33077
            978CAFDFD43D346A33AF8033882008F2C6424EE58862E00A30EA91BD2A8E7E25
            A60A8AF8F94037D57CE70959359BB51B28C04C05BB66266E7073C6D7208E76B5
            946494B212CCD4191AB3566E18E6EE92F1F59BB887C66DE6157006110441DE58
            C8A91C510C1C01A67E586B3DB4A927B1AB6B43F2EFEAD4F18EFE58D12AF5139A
            FDA866E27484CAAD390C3289EA4A00434503BB5135827D835735AAF634D7A479
            2A9BC64779707A4275825C6B5298982A7292E9275D4C2BD5886ED0A554B5C100
            6835A119715235D7C06EDA54FD5137CEC033EF3AEDAA0707AE99EC4C6F085461
            CD155D97762AA766B9A87A423ACFC43546DEB674C65CB7A02AC29D7DDDDAE4C2
            D44F430D1B5D134FCDEA3165DD23BCF3A23119D4294E975470ABA4F2B0A79E99
            2C9D6EAB6A135E18BC356B4F87A64A3A8B4E1346FA0BA81A557547A772DDFEA8
            E0ED367F0D0600B5AB6A53FF5F05D384A62DADB8BA4BECE5618ACE2008822062
            905339A218B40598E651CD7E6853CF5FF50515A79FC2AA27356DE67D96AB23F0
            7FF5635B1D85FFAB6D542D4C59595095A8A12BD354CBD73726C2869D6A603FE8
            B26A989E40847EA5D16A884435BE6BA51AD10DCD38B0A2AA189348806B753B27
            5D55312AABC6649AFE68507742DD0B2DDFD9EDAA2F585176391570CD645217D5
            C04EE5499686A666D60AD56D4EAB2DD2472ACAC4985456364D94ED14C064930B
            A720D565EDAAB53A402769DF23EAFC8CB760E3F44E1E549D0CAA9A983E505175
            1B2C13CF64314554B5E9445571A89BC9465954315526BAFF240F1D5367D3A036
            C2FF8DF217D0AD9FB14044B43F9A6E0BD5201F984A5254136355C8AE996D249D
            632D0F06233A8320088288424EE58862D01260EC0735F500262712D673979D43
            EBB1CD58758D10511F386803AB6A80499609BB51157AFAA69D1FAE087CA9F2E0
            2BABAA9FE51793472B335CA8F2F0A7CA445D995625EA3835E6ACAA55971AA872
            7CA5B48C72D129CB3FEFBCED0AC4E1FF043A899D475FAA3C3475B1A69155A158
            5B4C5C24A21D872881499505BB5A807527706AE6BD4778E745B542D895CA84D3
            2552A106AA0D761EEDFC7045A08D423955F173062D66B822A88CC6FA0BB0EAE7
            54AED5B43A2E3E20DC1A6403D53325A9A6C80C334D087449D39A293B83200882
            88434EE58862B0F95DC3C9E1E429CB30FC24B1375CF55895E531F584A6A32C3B
            2B039F912EA4290A31523305E4D35CC880DDA80A3D7D63E5D7748029A3539B0C
            F8CA824D3D7C2AF8BAA1E9076FAA5CA02CDD20BB12AD0AA9F6E85E69468081B7
            94567199E894D56E1492B57DD7170F119D354DE57CA9B2E12DAB36EA698B898B
            4458719EDAE4C2AE9655A16ECD5A2DE8768002ACCC0595A2B58CA5A3DD2540BB
            1515EC3CACB82627D35D819C745CB3301878F3B38C3C4D900B43FD05D4F54BEC
            BF261B83480D7281AA38D015323D11E892A635137606411004D1033995238A81
            25C0D84F640AE6C1CB79546B9EC6D43F885276CD235A954E1B59A5A807F7F0E1
            0D49167625ECA23261F78A86B76F4C36567E264AE5D349958D6E59B04047E857
            C6C234A4CEADF19D9D6A4C3738B571E214D45450D760E7B4C45B8A5B5C0EBA65
            A946C988F0F8AE2FBE496DE09D35266AAE3905D4463D6D317191082BCED834B5
            C98553AD7A90796AD6A452361DA3CA4AA2346030A84FEC2ED150AD689BD87958
            7126AAD56DBE9C240EAF1A930ADEFC2C2313D5344130D45FBE76F4F41F221AAB
            0A75124F0D326137484155A49A57ADAA35EB8418A918777918DF19044110441F
            E4548E28068D00E33EB2358F68ED14EA194DD170D52A8D5D6DB4193E5C6D6497
            523DCDD9E73A954105A74DE9304D52905A78FAA6E90649A4BAA16E9E9285DC6C
            F2E1F484FA0779BA2ED68985A99F8A40AB7466F59068A51AD10DBA3E7625EA38
            FC9FA06E533305B48DAF9496512E7C6579E69DB75DDEB8EEAC510914669953DD
            B28C51BC2D262E1261C779FC920954C5C0AE81AF66755EADFB579D51535C53A5
            7AC1C883EDA91A4D2B224B0E9038BCACB8B49A21A6CEA0D30449030CF0972ECC
            B428B9FF82DDD6AD411EECF668A81A392303511ACDA6AD31B29687B19D411004
            41F4424EE58862607F04512EBA4F79044110A4C2029BB6010A13411004312FE4
            548E28068D0053FD23270F2499076B0A30D2391624A102403AC482249813D252
            851907D21B1624A132407AAC0D49AB7890FEE940922B2AA4972A88A9D242DC50
            414C1513F59E4DFAAA0DC983200882581C722A471483310F5D7C070C4110A432
            403E48883B3682204845849CCA11C580FFEA892008822008822056839CCA11C5
            80020C41100441100441AC063995238A01051882200882200882580D722A4714
            030A3004411004411004B11AE4548E28061460088220088220086235C8A91C51
            0C28C010044110044110C46A905339A21850802108822008822088D520A77244
            31A0004310044110044110AB414EE58862B0798D20088220088220889520A772
            4431A0004310044110044110AB414EE588624001862008822008822056839CCA
            11C580020C41100441100441AC063995238A01051882200882200882580D722A
            4714834D505010997C044110044110C47AE4E4E4C06B6E5E1EF59A9BCB79A553
            333333E115799320A77244314815600B77CDAE11F8356FB00BF869EDC15590E7
            E5CB974DFC6BD4D844EC7D033AD3654DC3AB5725C5859C5056F28CA49A93A9A3
            A657FF6B8DEF6C7E3120D87DD9FCF1A3C7A422A4327021EC7C727212B9E0E34E
            54E4B61D95E09F2D6E47466CDE1A10B0D98F0E108FBA7787A4218895B81693BD
            F240ECE0A5D71B8E3B6B37EEEC40AF6BCBF7C75E89CE22C98882497D9A3A63E6
            347825D792B97EFF699FB9C721408498B4292C2AF8FDF7DFA9D8EFAFF30B2861
            2317BD4D980A5A59E5E5E733AFBA4A2C3B9BD260089B23478E6C340228FEEAD5
            2B52979520A7724431481560B502AAA409101517691F5477C98E05906DF96ECF
            1F577CF9ABDFD7BFFA53812E6B12362F775BE3E1E833BB1F3BAC98DE332EE626
            C96136AABD556349F7B56B876C39BFFBF2ADD0DB748880700EC22D3ADC0C6185
            B3B76E9CBEE9EFB6DDAB876F976F9D5679AD2115999313274EF889E23363C6A2
            9A357D972C99FBD9677408EAD2851446D4646767AD5AB37CF3167FA1BDB8ACAC
            CC77BDCFB6ED41714FE288491AB722C3CF860673C2E99013A7CE1E3F79FAD889
            53478E071FBE7AE332C96D0A56FBAC484C8ACFCECEA4436262BCCF5AEA1F4A2A
            26059909E7025CFD867F18BA7974514E0AB1226F10F945E5137DC3EDC79F719B
            7F6BC9EA471B3725056E49DA1894B464436C4F8F0B63D65CCF2E2825590D2223
            2373D2B4E9104E9D39434CAF5F4F983CF5B77AB6B76E47926B9302BB44A91198
            E4C0A7DB877AC377880492498DC50E9D7A2550724AF2A8D12376ECDC3E76FCE8
            D454793B40DF7927E03413722B190412AF47E9194FA1F557AF5E423C2555ECDF
            D784D0DB0460B080E490924AD5909E9101AF69E9E9F09AFA94527DA9A9D42B9D
            1A9F9000AFC6733BF25660E0462FEFC50607280E9590EA24F3B2BC3C71DFBE3B
            B3668576EF7EF8B7DF2040042E93F6EF7FF5FC39C924071051AA33AD81407152
            91293876FCF830D711BDFA3A366961FF6BEDBA75EC1AB5EFD26D84DBD8B5EB37
            3C4D4B239974205D411483D4EF8081A64A49E1DF130B0A0A2262C39BFAD65A18
            34072EE707CEAEE6F1E9AFBE5F43113A83495836B5DB839BC71EDD3EC584C791
            A76F5FDCB5764EFFACB4C4D292679C37C720BC7CF18214368EEF6C7E593368D3
            BFFFF976FCE3B8BCBCACDCDC6CBD213525B9D96F2D5B7FD7B9CFCF43962D5C41
            2A32942B57AE90983020B1FE10252728A8F8C60D084F67CFA6C39CCF3E2385DF
            74A40C20CD8DF0EBE1E1D78E1E3B1C7597FFCDA20B17CF4746463C88BD0F1162
            9206C82D72CF09B3FFD01E92DB20729E5C09DFD4FBE2CAA6175734BDB0A2C99C
            F91E77EEDE82734F71C9337885385842BC1A4038EB697B797DD7CCC761A4A4D1
            481F61218EAFE87E63C7E8CCA83DE77D7B1D5FDE8D582B06D2BD2B2978F430CC
            E9E6BEAFE3AE8D282B36EFBF941B80D01E6E2452C6E7E683CCC6630E0F9E1EB6
            C42BAA9BE3EA9A0D0655F9A96DD51A9D1BB5183E6EEACEE05359CB37C5341A73
            F4CA3DEAB849F1E245F9D1A3E57BF7BE7A26F5630E9BB76E03AD05C1A1DF0062
            32850013F16EFFFEFDAA7F3D379083070F928A8C40B70F1CC5C50924931AE3FB
            20F1EE1097402929C963DC4685DFBCFEEC59E1CD881B93A7B83F55490E89803A
            026924A28E1E3F898587E08B1770B27F75FFC13D629583DE2640348274040109
            3212C424B1CAE74638F56FCA5177A94EDEBB7F9F89B35F6F47CA5BCF227304F2
            E9416CCCF3E7E586059853280E9590EAA4911B1919DCACD9957AF51EB66B97DE
            B76FD1A04145830743E451FBF657EAD73FDDA2455E5414C92A1958CCF00CEDE3
            D8DBA16F2F3AC08CB32F4502E484E222FF1821FD111076E9926DC386D57EFCB9
            96AD1D84DA0D1A366FD3AE49CB5635EAD4AB59BF01581A346DEE31771EADAE39
            D0C7004439487D070C04556262224448391660CCCBCBBB117DADE1D25FE76F9A
            0D97F336CDFAD1FB4B284295341120C02E1D5E7EF9C80A3A9C3FE07D6E9F7744
            E8AED023EBBDA7F65E39B31F13567B506F8EADF170F45F328C14360E1060ABFA
            077874F74C887B525CFC4C3414AAC2B3B4D4D4AD0BF6CEEEE4EDF093B36504D8
            860D1BC8BF2FF2517CE7CEBD1A355E1614248C1871F7FBEF21A4CE9EBDA0766D
            922C81AEBD7AD7B16B644068DDA153494909A94514F335217DF704E995919156
            909FEBB37655595919B1AAC92FC8DF18B0A1BCBC0CF2ECD9B39358A571F2F451
            B859400B153D2B2C28CCCBCDCFC9CECDCCC87AFA343D3939352121F931A4EEDC
            B395E43688EBFE3DE34F4EC909F74D0CF3D9B971DEE42913226EDFB87D278279
            05CB4EBFB9891756665F5FFDF8D8848B3E1D4949A3913EC2426C74FD24377A5F
            4AF0C48450AF0DC33E2056E38007EAE52B57478F1BDFAE73D7C62DED7B3BF55B
            BE6A757676CEFA8DFE0D9A34B36DD264CCF80924AB2812BD2BCEBB1FB1EFABE2
            9C1BBFBF2ECD7CB4FEC90D37925031C8CACA7AF9F265616161529221EF0088A0
            777CF20A4BED46EC1D3FEBAACB887D3FDA0D6ED57BBCFBACE54B57AEF75EB57E
            DC744FFB1EA36A34EABF7DF7FDBD0753ED5CF765E597BC7CFE3C6FC2841C7BFB
            C25EBD8ADAB57B2DED5FC41D070E06ADD5A16B77784D503DAD005A805DBC7479
            F5DA7573172EBA7B4F73F80EBB7C79B1D7D2E9B3E6046DDF414C7C8878E7E7E7
            A77A066A21CB482A3202DD9A69A175E5410E27D07692498DF17D9078778848A0
            9494947113DCAEDDB8929D9399901C07AFE111D73CE6CC484B177CAF8083DECF
            07C2EE07AD979597C22D70E5BA21FFF024DE04C845108D201D4140828C043109
            9292A4C9E7D88913F07AEACC59783D7D3684F37A26E41CBC1E3B79125E252232
            475EDE8B616456AF59E1BDDCD380B0DA6705AC22A88454A78F572F5FDE5BB2E4
            D80F3F2475E952D0B56B5EC38679BFFE9A5BBD7AEEF7DFE7D5A891DFA85161B7
            6EC9DDBA9DF8E9A7684F4FC84C8A498011605E4B9740A065157329124C28C0E6
            CC9DFBE1C79FD4B26D002AABB763BFF09B1124E1F5EB67CF9ECD9C35EB971ABF
            D56E40A9B286CD5ADCB8C9FDF496EA8E4414845401F6CBBAAF9F3C79021138E5
            EB02F6DCDCDCCB5161F5E6FDB430702E5C7AEE58D8726D7DAAA489F09EAC1160
            9EF3270E1D3678D4E8E15418E3CA09C3860F59BD7C41ECCD63DE534CF3EFE820
            C056F6DBE8F0934BFCE3B8C7F1B1D1B17774C3C3C7A71F26EC3D1AE737F7FEB2
            A38F36A5A65CF571DF38D66E66EF1F075B5280C10EA2CB8BE2E287BD7A25BABB
            BF2C2FBF5BABD69DEAD521A4CC9AB57CF87052581F69E9E92DDBB5F7DBB8FED2
            A58B7979B912C3F5EB57D7FAAEE9D4A347F4FD18529130666D42E2EE09046CF2
            CBCC487BF9F2C5A54BE743CE693EC84473F8E8A1C4C4272F9E9727C63F5EB77E
            35B14AE3F0B1FD70BFE5E667EFDCB563C7CE6DDB766CDDBA7DCB96AD9B376F09
            0CDCE2FF24F111A46ED91640721BC4B9A576D9E1EB928F8F1931624868E899D4
            D4A4CC8CA7EC009690B3C1900A79B2AEAD3A31FF3752D268A48FB010EB5DDECB
            BFB7277E8F43FCD905BECEEF10AB113C7B563CC47544BFC1CED3664C5FEAEDB5
            62D58A39F3E60C1B39A249CB56F6ED3B2C5FB9DCC5D5150EE524B72852BCA3D5
            57697EC41FBF17BD7E99FAA2E4E1CD7D5F91B40A407272726969E98B172FE000
            5A5454645A0DA6777CDC569CEB3DEE84CBA8833F3475993A6FC5F1E3C7C2C2C2
            EEDD8D4A4B4B4B494EBE70E1C2B4B9CB7E68E0B062CDB5392B6EB92E39B57399
            E732EFC5DBE7CD7EB862457ED3A62F63F46F20098949F47B5F5B54EF8381C6A6
            EDB4006BD5A1637787BEB56CEDEA356AF2388EFAF0F02A9FB560B76B469D93E0
            B44467E645C43B5AFCD00F411AB89465241519816ECDB4D00ABD9779F07A2A13
            E092B6934C2A4CD20789F7BE90044A4D4D993869FCE5AB614F3352621F47C73C
            BAFB302E06E2D7C3AF2C583C2F2343FD8EA8719CBB701A9C7D565C04B7C0B1E0
            C3F0582409A6008422C845108D8C8004310992D2B0379C030237C36BD0B6EDF0
            BA7DE72ECEEBCE3D7B9957E988CC116827188DA5CB96B80CEA0161E8A01E4306
            74EFDDBD4DE7F6CDFAF5E90871DA4EC240D6E540EA158AC3C04A1760D14B965C
            FCEDB79C5EBD726C6DB3BEFB2EBB6A554DA8562D4715F2ECEC721D1CC26AD5BA
            EFE5458A49C0EA026CE5AAD5EFBEFFFEAFAA77BA7AF6758495461258C4C7C7BF
            FBDE7B3FFE5613369F86CD5BDED27E2713FA8F280AC9026CCDD78F1F3F165AA0
            6007727272C2222FD82DFED52B682149301DA0A62E1D5A061A0C425F2707B861
            44800C90D984026CB9A35FD75FFBC7C7C59596969495956A879282A22B8FF30F
            1C4F0FEC1439FB54CEAD9E51F34F256F3A18E839AAE1945E3F0CB28C00F3F5F5
            8529807B9EC3F3F2F23857D7C85F7E79F6E851514CCCEDEAD5E990B268D1BA35
            52BF9C76E5EAB501CE43366CF43D7FF15C4A6AD228B7114EFDFBEA868E9DDBC3
            C8430432C427C4C14368CDDA55CEC3861D39769C54248CB4261C3B76EE604013
            128F08C0B2155EA9C909A525C5C5CF0A57FB2CCFC9C92609AF5F3F4D7BBA77DF
            4E18D18CB4E4B8C70FD6AE93F77DAABD0776C2FD9696999A4E85A76919A970C8
            484D4F4A799A9894129F901407A91B037C496E8338B3A47EF68DB529C747CD9E
            E8040F15A13067623FC893756DE5D139BF909246237D8485D835B34ED205EFA4
            23C3A3760DDB31AD06B11A4A567676DFFE03274F9FB672F58AB113C675EBEDD0
            B865AB361D3AF41FE834DA6DD482850B162E5ED8A8794BFA3BEE7AD1EB9D4A7D
            7D59927BF9F757992F4BC25E95DFCD885D52D1DE01CBCCCC2C830DABB4F4F9F3
            E7A67D1F4C7C7CAE44A5D80EDA3261F2B95F5A8CF158B4262CEC624C4C4C7272
            524141013C3A60D99797974745452D5CE657A3A9F3E6C0476B164EF5F1595952
            52B2C177CD8E29EEF975EBBE2A2C247509B361A33F9C69366E0A4C494D850350
            B7DE7D683B2DC0683DE6EBB711E29ECB9667646482186BD8AC05FDA51AF19F34
            10F18E9634C6045291116CD8B0817A92B3A06B0EBE9DCE09B49D645203C54945
            8622F1DEE7954019191953A6BA5FBD7E89525F71D199D9E920C09E3F2F873858
            6EDEBAEEBDDC2B9BB5091BCC91E307A1F582C2BCF2E7653BF76EA35B37092011
            4128825C840E837484FE838C8438484A109672BFCC56DF75273D4DD283145F44
            E6881160138777A383BB2BBC761DD0B379AD9FABF4EC60E736A493CAD20D2263
            9C3B429C0E10876CB204586E64E4916AD5B2BA76CDFCFEFB8C2A5532217CFB2D
            13408F3121FBC71F73BA773F5ABD3A142185F5C10830E649074741F6A548809C
            460AB08888887FFFFBED5F6AD7A5FF59273E81BC03AFCBFEFDFBDFFECF7F6AD4
            AD0F39E1A9949EAEF92C22F41F511452BF03F6CBAAAF6363636181BE140652B3
            B2B22EDE3EDF7859CD953BBD494913016AEAE27EAF8B079642801B06BA9E9393
            C51B2009324066130AB0657D36B4ABD11B0458797919FB03D0109E15DF7C90BF
            F744D6E689B10B77A48542EB27732246C478065F5FBE6CECF85EDF5B5480C1D1
            8A43FCCC9911D5AB27AF5801F1DC0B17204E879CC387A10829AC8FA0EDDBC74E
            18BFDE6FED95AB61172F85C2F02EF15AC87985D0AE43DB1EBDBA410434D28D9B
            57236E5F5FEDB362DCC409CB57E97FB348A4899E8EFD1DA66C6DE8BAABF6C8E0
            DA234FDA0DDFD9C27979EF7E03A53721F188006CDEEC7F3FFA4EDAD324105A91
            9137F7ECD57CCE70EBF62DA0C70A0BF25292E242424E855DBA4012A4B17DE716
            581BA96949415B37076DDDB275DB96202A6CDEB275F396A0C0E4A78990BAD6D7
            A81FC938B5B04EF60D1F1057D1BB5D6E6D1D2C142095126057571CF6F8919434
            1AE9232CC469DF01517B47A7044F085BDBFE94AFE63B3C0600A7EA765DBA4C9B
            397DC1A2F9BDFAF6E9D0B57BC4ADDB69E9E94B97AF68D6AA752F879E20E03B74
            E90C97747EBD887B47ABAFE29C73BFBF4C7A51B8E755C9F99CF8E557B6BE7525
            C84637DC3A58F56158BFECC403A4B019484B4BBBC747747434ECCFC5C5C5CF9E
            3D03CD03FAC7541A4C7C7C966EBDDC79D8EEF68EEB3AF69F141616F6E4495C6E
            4E4E497131F481CE005B537A7A5A78787817C7717B46350F5EECB06FFD2C9F35
            DE8B162F5C3F7FCE8B08CDC77844E8EED0070E3401819B4F9D396BDFBE23C463
            1E3C003B2DC0AEDF0887F8B51B37203E66FCC4F08808880C1D394A55540F22DE
            718EC206045291118082E2C0698213482616A422439178EFF34AA05DBB77865E
            0849CB7CFA28FE41F9F3F2B2F2D2D8B8FB900DE26049CF4CBBFFE0DEA123FA6F
            16BD1F41DC776837549B9B9F0D4D046DDF2472D41682B709108720114128D202
            12CE0320C04046D202128425C84B109924B7044080FD011D95C69DB82C985029
            BE88CC915A802D9E37AE0B3B2C18DFD573728F09CEAD1C3BD69B32AC2D04E79E
            0DC1386F6C9759A33B7A8CEE38D4A1F194E1EDA40BB057E5E5271A377ED4A245
            46CD9A69DF7C03219D0EFFFB1F840C3A54A94207D066D975EA3CB1B73FD9A4C9
            4BF546210E2DC064F187EA1F80688C14608EFDFA7DF2D9E7B0AB4068D6BAADF8
            A4FCF35FFFFAFE975F2167FD464DD89F7F265D411483D477C07E5EFEF5FDFBF7
            6155A94EF5824006D86ECEDF3CD7744DED4D874DF9AB32A0A6CEEF5D727E9F27
            04389743D743424F9C0939A61BCACB8A1D9D7A9ED9391F8A88DF06120101E6DD
            7B3D2DC09E243E647FF230E6D1B5F50FD774BB33B7C3ED99C3EFAF28FFFD0574
            ECE51FAF87C7AC6C7FDBA3F7D5993D278CB08C005BB76E1D686038D3B0495CBE
            FC46F5EA77ECEDCB0A0BE1327DEF5EB8A443516424142185F5317DD6EC058B17
            AEF55D733DFCF2D1138779FF55A9FF40A7191ED30E1CDE7B2FE64EF483BB8F9E
            3CB87D277CC52AEFB90BE60E1B359A54248C5013ED9C26D476D9376171F8E69D
            49C1A7B3AE5CCBBF1A9EBBF5585C93B1C7B79E0897D884C42302101111BE7FFF
            AEF4A78979B95965A5257EFEBE7171D45F1178F02026F4FC5938213C791C9396
            9AB8D677B5EADFEF6510B8857A3C24A52680067B9A9E4CBF0F969195064F6B3A
            40EAF2554B496E833831EFB7ECEBAB415C49095957961D985E9D94341AE9232C
            C4C5FD4B8F7A777914BA76C3F89A970E2E2756838083F5E8B16E73E7CDEED6B3
            BB7DFB0EEC3F98D3B947AF8E5D3AF6ECDDA341936659D952FF655DC4BBE2FCD8
            F0BD5F15679D78FD3CB63C77CDABD2CB7FBCCA160ABFBFCA7A59FAE059E6F13B
            477E8EBB36E6D54B49070BE93C7CF8302F2FAFA4A484BEFD85000D06ABB7B4B4
            14329B448389CF7E9F293B9D461E6CD8D163E18A4D701FE5E5E6421F5EBC78FE
            82FA3CA4EA5DFAE7E54585854F9E3C0A195FEFE1DC1AAFC2C614EDE9BADC7BE1
            AA959EF74E1C23B588F22036963EFAB0C3CA353E90440B30FA1DF2C3478F417C
            D6BCF9F109091069DFA51BB4AEAA400C11EF6849A3FB552B8E05026F3608A422
            230005055B071BBA664E7310683BC9A4C662028C5702CD9EEB015B5F4A5A12AC
            819CDCECBCFC9CC7F1B154B6BC1CB0A465A6FEF1C7EFEB37EA7F4EE9FD89C21D
            7BB64286AC9C8C92D262FFC00D061C0C789B007108121184222D202103084870
            901690202C415E82C8A4334B81166031A9454FF3CA9E95BD840AE13529BBE4C6
            E3DC13B7D3F75E4DDE7D2579C399B8C5076366EDBA7723360D26548A2F227344
            0B30EF658B574DE9C40EABA7765EE6DE61ED8CAEB386B76C52FB9B11BDEB8FEF
            D768EDF42ECB27751CDDD76EA483ED906EB5C73A35942EC012F7EC09F9FEFB8C
            C68D53BFFA0AC2D3AFBF6642DA7FFFAB098C30FBE69BECE6CD437FFC3169AFA4
            CF5BF2BE030616214A93EEC4B8572B8D0FA72F8D14601F7DFCF1B7D57FA0779E
            414387894FCA575F7FFDCD7755E9CCDD1DFA3299E99E20CA41B200F3FEFAEEDD
            BB70C46F77A15EDF2B6D47DC749C766794678CC786B8151020322D6AF4C89B4E
            8E57DBB5BF609B9E9E1E1A1E62E7FD2B296C0ABC27773DBB7B111DE0D67AF220
            62D50C07DFF98375C3FAF98357CF7484D4E5537B042E33C1A78040802DEDE54B
            0B30FA8D3E86C2D2E8B6B76616BD2A25C3C9E68FD24C48BD3A75F14263DF0C94
            F284A30558999AE29C9C0723475EAB5EFDFA0F3F645FB8401B137D7CC04287B2
            9C1CE902CCA15F7FBF00BF0DFEEB6E47853F78742FFAC19D7B31919C703FF62E
            24B10318D7AE5FEDBBD1B775874EA42261789BD87CF45223D7035EABEF8F723F
            F2637DD74FBE6CFDC1A78DABD7725AEE139C9852DC6DDAF12D472F496942E211
            018039DDB4C92F2A322235E9497979D9E3C7B11B36FAC2D0F907F89550BFAD92
            F83425E1DCB9D3C74E1C260524B37EE35A5814A0BEB66EDFB27DC7D61DBBB6EF
            DABD63D79E5DBBF7ECDAB367577E611EA42E59BAD077838FC1BF4D7F74CE2F59
            D7567184D6B5733BD83F7C4F0793FFFCBDF411E67079E7D4B583DE5EE5F4D611
            EF2E10AE1F5800AF7009C167D0BFC3B649FA910C36172F5DEEE6D0C763D60CA7
            014E764D9B27256BBE0A7F3B32B2494BFBDE7D7AB56ADF6EC1E225C42A0111EF
            228ED83EBED2ED55594469D6B4D28C097A42E694F2DCD52F8B835F3F7FF2E486
            F3838B43482DA600A41448AFA2A2A2FCFCFC5C6980124B4C4C2C94F0013F71C4
            67FF979EDE23C606D76B3F63F7FE13A9A9292525C520B9407AA93F4E4169B0B2
            D292872BBAC42FAC0DEAAB784FE7F48DDD76CE71BA1D7A8854A10FD05A709499
            B770F1D5EBD7219C3C751A2EDB75EE0AB733F31D30AF65CBEDDB7580F8B9F317
            C0EE3CCC15E2AE63DCFC0236B98E1E432AE243C43B5AD2E87ED58AF7FB571C23
            5D96546404EBD7AF87AD831E4A1ABA66DE3E402099544041284E2A321489F73E
            AF043A74F8C0A3C7B1A0B23232D3E7CE9F9D5F981B9F447D1BD66BD9E2CCAC0C
            3840A7A4269D3B4FFD1685387A7FA270CBB600A836232BADB8E4D9BA0D6B78F3
            88C3DBC4067F5FE83C0845908B201AA10910902023414C82058425C8CB597366
            4A6F2E242291D660F199C5D945709FBC860062EC567CFE99A88C8337520343E3
            971D8D9DB7EF7E486422CCE6D99B927E8C5E648E1801B6794E0776089AD3D177
            6A9BA5635BEC5AD8C5F6E7CF21BE7D7EE72D733A04CEEA30A97FFD61DD7F5B37
            A5CDD6799DA40BB0882953226AD54AFDE187E42FBE4881F0E5974CA02599AE30
            4BFFE5973B75EADC9E3E9D54210A23C0D8DFEC020B2FC5897722477E5A7878F8
            BD511FD31ACC4801F68F7FFCE3875F7F832D05C2A469D3C567FCE75F7EF9EA9B
            2A7466BB66CD99CC74DF10E5400930987EBDFCB4F4EBC8C848D8B27F9CF3754D
            9F2AB6BBAB373CFA0327801192200364BB73E70E14218585B1D1865875800ABD
            27773912E87178D34C08C39D7BAC5F30383B25A6BC28BBAC284B371465C5673C
            BC9212756AE9A42EA40A3E48AB6A88550710605E3DD681004B507D7B9B7C7F59
            456979E4F0FB8B57271DFAFD4FCEADFEFB9FAF733627EFEC7ADA7DE982E5A422
            3E48DB6A88551BB8F9494C181F1F9FE7CF9FC3090CC8B97D3BA265CB2BD5AA5D
            A95E3D65F76EDA083CF4F0A08CD5AA85376A0499A10829AC8F86CD5B9EBF0867
            F6A3705AFAFD771801A9E1C4A96350B08E5DA3F2F272529700BA4DE415963618
            BE63FA829BADBAAFF9BED608C751E396AD5F7AF0C8D171D3BCFEFB43EF9E0356
            845DCD68E8BA73DFE1A37A9B9032800C1919E9EBD6AF79FC30262BF3697959E9
            B66D9BF7ECDB7DEF5E14F5E1C3C4B8C8DBE1019B36D07F3F4716ABD752BF1695
            9E990A4790DCBCEC82C2BCA26785701A282D2B81008712489DB770F6AD5BB754
            EB47C3FE437B4815FA38ECF163D6B5951C0106728B54248C78136469AA21566D
            648D309BB583DFCE8AD894171994736B5356F8868C6B3E699757A45C5C9A1CBA
            28EEE42C9F41FF22F9A40152B95D97AE63C6B98D1835DCBE6D3B1FDFF5244145
            BFC1CEED3B75E8E5D0A341D36669E9E9C42A0111EF9EE5C55EDEF1657AF4F0F2
            1CAFE2D4FEE5B93EAF4AC39EE7FBF3873CBFF2DC95A5E9E3CBB2E6BD7EFEF0FA
            DEFF1564DD2215F141465C0DB1F2111313F3ECD9B39C9C9CACAC2C7825028B0F
            905BF09A999909D9525252121212481502C003820DB16A233EFB3F765D3474D4
            B1469D161C381A929999515E56F6E20508303520BFCACB12D6F64E5854F7D545
            95FAF2EF76D3E5BDDCBBE74879098C9F34A5EF80818FE3E2C8B5C6F264D9CA55
            10D9B36F7FA7EE3D1AB5B05FB3CE17DA840C5959D91E73E7B568DBAE5EA32603
            870CA54BF122E21D2D6974BF6AC5B140E0CD068154C407997535C4AA83AFAF2F
            B98DD5D035739A8340DB492635F467D785206DAB21566D24DEFB1C0944CF427E
            41FEE1A30797AD587AE0D0BE058BE71614E527A63C816CCB572D3D773E24708B
            FF85B0D0A2A222BA0611AE45A7822E82001162D266E3264AA63ECD4879565CB4
            72CD32BA7559F03611127A0624221CF4412E826884264040828C0431099212B4
            19C8CB8387F693DCD2088F49A33518FD2618549E51504E0BB07DD7527C821F2F
            D84FD4D78DFB4F49197D88CC112DC0962E5B7268713B4D5842BD6E9B653F7B70
            9D95631B756D5CE5A8677BDA78D4ABFD96192D1D5B555D3DAE115C32028CAE4D
            8433EDDAC5D6AF9FF4F5D7499F7D46C2E79F4348A6C3175FD081ADCD9E7EF34D
            5CC386673A7694325FD2055851FCED2B433F2E39D2F775CCA6B26BCBEE8DF9AC
            34F1162DC084D0BBC8BFAD5AF5EB2ADFD29AAA675F47F10E7FF8D147DF7DFF23
            9D79E8C8514C66D23F4431883DD4D9FCB4E46B381AC242A93AF5B3FB19776372
            EE3DC88BAEB3EB5B786522608424C800D9203314218545215BBBE8F162D3D2D1
            AB67F65937A73F1DD62F189295125390F630F94EB07810176000695BB4751060
            4BBAFAB4AFE170FF5674627C3C3B2427875C4DDF32E2FEFCF529C7C888027F3C
            07F5B53179E7C0708FE983A9EF80918A04203D10EE8394271C2DC00AD3D39FAC
            5B77E5975F2E55AB06213130B098C583E9D3697BF4C891B20418C89BD53E2B67
            CE9A76F3D6F5DB776E4A0F1EB3A77B2FF7AC6BD7A8449F62D16D62EAAA43DD47
            1D1A3CE2D0AFF5DCDDE6392FDF39F9F2FD6325E5CF72F372FC033657FD75C87C
            CF33D3BC2F761D41FD18AE7813128F080C8F1E3FDCE0B7362921AEA4F85964E4
            4D3FFFF52525C52949714FE262D7F9AEC9CECE22F9E4E0BDC21396464676DACE
            5D3B76EFD9B577FF9E0307F73F7F5EFEF2D5CB57D46FF3521F5E05F74342CFEA
            FE363DA9421F07A657CFBABA8223C024FEFC3DA94200B2408D5BA2BCAC727A2B
            EFD6FAE4830312F6F47EBCBD73ECE6D6D17E8DEFACAD7B6BE52F8F8FB8412AC9
            278D73E72F74E9D973FC84B1DD7B756F6ADF1A34094978F5EAFA8DF0E6ADDB38
            F6EBD3B663078FB97389551AE2DE15E5DEBFB8F5F3A7779D4A33A71425B57959
            7CA6307DDB990D6F9D5E6FC30921017FBF7DEC87D29C2D25E9639E176CCD4B5A
            7F376400A9450032EEA21B1490919191979747CBAAD8D8D8A8A8A83B7C803C2B
            2828484F4F879CC9C9C9F1F1F1A4BC28447B09FF539DF8F8741BB3BEFBC06DED
            7BFBAF5C7F382B2BB3BCBC1C361FFACC01AF2F5F9427AEEB93B0B80E515F1BBB
            DD1AF6E10897B174D98A808877B4A43126908A0420732F3AFBA0A038709AE004
            928905A94800D203A3EF7DBD1268E9F22545CF0A5254DF86F5F15DA59BC118D6
            AE5F0DD542E5D004282553550EE21024220845908B201AA10910902023414C82
            A4046109F2124426C92D19468365173D2F2E7F054AECDAA35C1060BB2E272D3F
            F6F09C4CF50588CC915A802D0E5DD9267485269C5DD6FAC0BC664717B558E852
            B3EEF71F9DF16E757E651B3AAC1A53DF7378ED534B5B4111E9026CF7B7DF26D5
            AF9FF0C9279AF0E9A7894CF8EC3308BAC2EC69C3867BAA5797325FD205D8F991
            558B76B70201F6475E74D935EFB2A8ED31EEDF1929C0A64E9FFEDEFB1FD09AAA
            510B7BF10EFFEDEF7FFFE9B75A90B361F396478E1D23561460CA43F23B600BBF
            0A0F0F8755F5BFB11F559BFBE94F6BBEF8D5FF2B4E0023244106C80699A10829
            AC0F91CD9D067454715E6A59611613F29F3E488A3CA937E8156080DED641802D
            EEB2A6EF4FC3DBD6E8D9E6D7EEEC30B87DCFC05DEE1E8FBD36A5EC07D1F5E7EF
            397FBECEF8E355D21F2F637C12FC6606CF1CDEB49F5E010688F741CA136ED9F4
            E969070E5CFEF5D7B06AD5205CFAE597F880003880B2895DB0804E7DBC62051C
            83D6ACA13E8921055047A3DC46F574E871FED2D9B0ABA1D243EFBEBD5C860F81
            E2520418A789F6A336BA8C3F65D76659EF6193BDB74DDC726EDEAE6B8B1FA6DD
            CCCECBB872E592F3A8450D5BCF5FB3F14EAD9EF3F53621F188C0E6FA8D6B41DB
            3667A4A56CD91A18FB30F6C2857349894F3606F8C53CA0BE0969008B96CC87FB
            2D333B2D272F2BBF30EF5971616959C9F317D4BB76AF5FBF061906A993A74E9C
            BF60AEEE6FD3D335E865EF946FB3AE2CE30830893F7F4FAA10C6F825CACBA913
            BB0E1DDDB765DBA6356B572E583477D2D489C347B8309FE31FD88FFA1AA7747C
            7CD7F770E83D64E8E0D6EDDBAF59A775B2ECD37F8053FF7EFD073A356CD62225
            95FF9FC985D0EB5D61CEFDD0CD9FA7DCE95A92E652F0E4E71745877213D7449E
            E94792D59497E6C75E9B991839F97941E0B3941E6585672EEDAE45D284D1BB41
            65676783FA0259959B9B9B949444AC3A4086FCFCFCD4D454882426264A545F34
            E28F09F1F159E07BA445AF35BD071E7319139096F6B4B4B484FA7707D50FE2BF
            7CF13CC1B72F5B7D45B8BC3F76E0F4E92BE4BD69601865CF4B979D1EECB8F18B
            B5A1A389890F11EFD8C2C6B0402A1246EFEC8382825B980D5D33E70B6010683B
            C9A446AF00034C72EFEB9540AB7C968336038506D9FC02C81B95C66026752484
            69351EA3C1729F3DCF2A2C0701762CE2E9E6F309617753601265A92F40648E68
            EDE4BD6CF1ADF5AD6EF9B682D7C88DADEEF8DBDFF6B78F0A681DE5DFFAF2CA16
            3D1A7F39B24BD5B8A0F67737B6D932A5DED2E1352EAF6A11B9A13564962EC076
            55A99258ABD6930F3F7CF2D147748887F0F1C7102EDB7FE5B270AFA36728139C
            A870DEC9EBFCD8F5573A392F903298D20558C888AA191BEC2E0FFABF3FF2EE45
            B9BE5F10B2C87801F6FCF9F3F73FF8E0BB1FA8F7B51AB76C959B9B47127478F0
            E0C1DFFEF6375AAA75EADE130A92041460CA43AA00FB71FE57D7AE5D7BF1E2C5
            57AEEFDF7B1A159D11753F2BEAFB559FC22B130123244106C80699A108296C34
            A0A3126F9F30204811607A0101B6B0D3EA9155678CF876BA6EF09F3E75CCAD79
            A159875F3D8F0CC93A3AEBD1CAF399FB5E979F3FFA74E3E883D3BA54719222C0
            C491F2849BF4E9A78F66CDBA50AD1A84DB830665C7C4C0E387C3C3E5CBE90C4F
            366E9429C01A0E741ED8B95BE7F05B576F4785C3F318F8CB5BEAF017DAA021F4
            C219C806A15BAF6E7DFBF5ADDDA0A10401C66DE27FEDE68E9970AE5E53AF798B
            5682253BF7694E417A5C7A54766EDAFDFBF79678AFAB693BDD2FE0C1779D16E8
            6D42E21181C3B9D0B301817ECB572E7DF0E03EBC066CF20BBF7983A4C967CE3C
            0F72CF09336EC298E03327757F9B9E54A18F5DEEDF645EF1E60830893F7F4FAA
            3014C346183873EE646E6E765A7A6A62D293878F62EE464746DCBE7EE57AD8F9
            8B67CF8606C34394E493C6D011A3FA3A39F61BE0D8A845CBC7714F88F5D5AB8B
            972E75EAD66356AFEEFB6C6C20DCF7F22209AF5E419C36A69D3D4B4C3A48F10E
            34D8994D9F27DDB22F4EEE5EF8A4F6CB929B67027936C067F90997F6FEF2AAF4
            6AE1C32F9F17EC3DE1FBEF57AF8C3D6846474783F44A4E4E2E2828A07F2A4997
            8484044805F5F5F4E953905E4F9E6806C778C4C7E7FC8D981A9D660F1A7AAAFF
            E0D31B83CE1716143C57BD09F6E2F9F3445FA7F8456AF5E54FA9AFD94397D4EE
            B2E0545814296C36320B93C7EFB65B72A9F3B6476E8E1B3F27563E44BC5BB76E
            1DDC3EB09732C0A52C23A9C808746BA68596D077C048261526E983C8F8C04347
            BA04F2F5F3292E7996919506D9366FF59725602CF0F940DE26D818FF29470E8C
            06030116F124EF7078EAF518EA5737E4AA2F40648E1801161768FF24A865C2CE
            16A9473A645D70CA3CD73BE5A07DE25EFBC41DAD2FAF68D8B6EE27EB46FFBAC4
            F9270FC7EA777C9B2504B582FC10167B2D04AFA508B0936DDADCFDE187B88F3F
            7EFCC10710E2E8F0E18710FCBCABCE9AEDD67BE159550871584482E392734396
            9E1AE23CDFB402AC243D2EE1E8F2F30E362F52C26EF6FB4BD6C9E5CF33E3A038
            1C5C495D3A4879046C09DAFA9F77FEAF46DDFA8D5AD89F090921561DE6CD9F4F
            BF57D6B0598BA87BF7885505E91FA218240BB0B95F5DBE7C1916E86783FEF3E5
            D8FFFB66D67B5516BDCF09608424C800D920331421858D067454C2ADE3060453
            09B0051D5681005BECEA0D277238AD6ED8B8D677C31A1FDF55ABD7AEF00F5CE2
            1336BBF3AD699D6E4F1F1D337F75E2B2E1F7E7778E98DAFEDAA471C32C27C026
            7EFA69ECAC59A1D5AA853B38E4AB3E68A4CBA3F5EB210384273B76949696AE5A
            B58A141605F63E50475D7B76EFD8B573DD868D6AD66FE0B3764D4A5AC29EEB4B
            032E4EA5C3B62B0B1E24DECACCCC80B079CBA61A75EA42910E5D3AB6EBD4014A
            813A7A565C4CAAE383B7899FBB2E183AEA849DFDAA252B7CF65E5C535892FD38
            EBD6AE8885FB6E795DBE7372B1D7FA3A8D17782E8BF8B6CD0CBD4D4819409AB2
            BCBC9B63C6ECFBCF7FF6FCEB5FBBFFF18F9DFFFBDFC1FD7B96ADF05AEBBB7A63
            9F5E6001FBDEB7DFBE3E644849662629230DFF4D7E33664D9B3E73CAB41993A7
            4C9F3479EAC44953264C701F3B7E2204B7B1E347BB8D1D0996858B17E8FE363D
            A9421F3BC67F95797929478049FCF97B5285A1481F610EA1E783418341387864
            EF96AD017043CD5F3407C66198AB0B3C41870D1B4CF249A375878E8EFDFBF672
            E8D9B0790BDA929797BF64A977DBCE5D264D99BCC3C6E6CFD050081059D7A5AB
            5F40C05D2F2FB6912EA28B44EF0AB2EF9FF2FF3CEE5AB367A99353A2A7DF3EEB
            4A12D43C7F5E127FD73FE1F6F417855B8BE2AAE6C5F73F1DF00D493382C4C444
            505629292920C32042AC3A80424B4F4F07E9655AF505E81D1FE7E9014D7BAE1C
            E07C75A8EB99ADBBAF3E2B2A2A2F2B4B5CDF9FADBE6EBABCE7DE6F72F3EE3EBF
            B61929721292CBD3BCB81D3716A61724926B15F7522EB96CA9BE296A7478E1B6
            09C7EA8CDF654712F810F18E163F1C6419494546A05B332DB4385F008340DB49
            2635C6F741647C6449A080CD7E25A5C5593919906DFBEE20590286FD13854C41
            89BF9021B121DE26D8F07EC9CD48180D762FB9F0D6A30CC3D4172032478C00CB
            D9D33CEF88FDB36BFD5EA42D7D9DB7E955CEFAF2F89985A1EDF28EB7CA3BD032
            64619D5ADFFDDF80965FC46E6854B0A765CEAE1674902EC0AE4D9810F6D5578F
            3EFBECE1BBEF3E7AEF3D264456FF68D6F99F977AB6EC3EEF740FEDE0B838A4D7
            CC3DB3C74B52B3D20518CDF93E7FF923FB7678BFBFFCA9CA06C5D96F467190F8
            086869DFEACBFF7E03E26AF0B0E1427DAEF25DD5AFFE57C5AE5973CE579401BA
            638872D0F3F106861F677F75F1E245782E7ED8E79F514991775323EF3E8DFC62
            C6DBF0AA89A446421264806C616161508414361AD051F111C70C08A61260F3DB
            AD0401E6E3B33A3CF26A524A7C7A466A4E5E76D1B3C2BCFCDCACECCCF48CE8C4
            8C63B1997BCEDE5B71E8ECE2BD5BE66E9C3DC3A5C140979FC677FEA6AF6504D8
            844F3E79E0E11152B52A842BEDDAE53C7D9AAFC3E32D5BE80C09870F4B176030
            9B2DDAB4ABDDC0AE45EB56F51B35EEDDB74FD4BD3B7712CE67E5A646269C3F7B
            7FEB89A80DA7EE0526663C282CCC8710FBF041D71EDD1B3469DAB845F3A6F62D
            A160C3E62D4B4A4A48757CF036D169A457F7015B9B77DC3070B4D7E6D30B13B2
            EE3E2BCD3F7ECF776F8467C0A979DD07783469B76AE4C4933FD88FD2DB84C4DD
            F3594ACAC18F3FBE51B3664EE7CEF9DDBBE7F7E871E3871F0E7DF3CDA695CB36
            F777BC5CAD1A58C09ED3A5CBAD3A750E7CF861C1C387A4A404603B2E8753271D
            D4CC9E33E3E6CD9B478F1F3E7EF2E889E063E742CF3C7CF440F7B7E94915FAD8
            EAF679E6252F8E0093F8F3F7A40A439138C21CB2B2B2DE7AEBADFF08F0EFB7DF
            FEE73FFF49B24A63FCA4C9ED3B75ECE9D0C3AE598BDCBCBCA06DDBDB75E93663
            96C712AF2563C68EDC045A6BD8302A6CDB0671CF56AD29CBB66DB411E2A4161D
            A47B5794F7F8D6D95127367C753B644C71A1460B15E6C426DEDF7EFFF2ACD458
            DF97A577CA9EF6287BDA3D25B2F3F5638E248771242424A4A5A581BE2A2A2A82
            7545AC3AC8FAD8A174F48E4F765EE1CF9D66767208EC37E8E2A06167C74F3F70
            6156C7270BEBBCBA309A525F01DD417D8D759CD8B9CF961FDB4DEED4A1FD54F7
            F1A4A4D10C0EFC6ECCFE5F070456B9F288FAE3BFC0D13BEB9CFCBF0CBA3BF15A
            61E08463BF8DDE5EB7B034974EE245C43B502F46422A320252110B5A68090592
            8905A9C85044C667FDC675D225D0D61D8165E5A5B9F9D9906DEFC15DB2040CFB
            270A9982527E237EE72EFD9F02A5E16D820DE7671E65F51FA859BF0114615ECB
            CBCBE1151ED3F00AB376E13EF527BFE0644F5B402AC02B3C37E19529452AE243
            648E68EDB46CF9E217C79BBFB8D4F9F71CDF3FCA4FFD511EFAC7F3D03F4A0FBE
            8A9FF422ACCD8B532D737736EA54EFC3C9DDFFFBE729FB17079B3141BA007BBC
            63C7A10F3F7CF4D5570FDE7927F6FFFE8F09BBDCFEEB71E167AF2DBF76997592
            84D9C110BACE0E765A1CD27A94EF41DF5DA40A51C404D81FBFA76E1B1735E45F
            697B67D086DF5F3EBFD8FF9F7F644784F7FF2B23C044C650E22300B6DFF73FF8
            A0FA4FBF80BE82DD9858593C7AF4E8EF7FFFFBAF75EAF6E8E3A8ABF7E8BE21CA
            41EA3B603FCCFCEAFCF9F370C3FF5FD7BFBDDFFF6F1F8EFCFB47E3B8018C9004
            19201B648622A4B0D1808E7A72F3A801C154026C6E9B1520C0962F5B16FB38FA
            DCA553AB7D562EF65AB070C9BCB0CBE72E5D3D7F26F4E4D51B973232EE1F3DEC
            E339CC7DAAEDE4F135E6F6AD326CC88FE33BFDD74202CC7BEEDCAC1B37AE3B39
            9DA95A15C2ADD1A3F37488DBBB974E4D3A7B16E4CACA952B4961516036EFDCB9
            53D7AE518D3AF53B74ED3A64F8B0A4E4A49C67694939313169579373638B4AF3
            2293CF5D8B3F0A11D8C2323233FAF6EFD7A5478F1A75EAFD56B77EED060DAFDF
            B821F26F4B006F135E9B0EDA75F3ECD16F4FD376FE878E9E4A7B9A5A54082A32
            273AEEE696BDDB1BB65CE53CE268B35E2BABDBF5D0DB84C4DDF3C1AA5537EAD4
            891F39F2C0BBEFEEFADBDF76FDE31FCF7AF53A04F1B163F6FEFBDFA593261DF9
            EA2BB0EF7DE79D283BBBDBB6B651B367939286E2EBE7F3FBEFBF27A726046DDB
            BC6D7B90D06FD393DCFAD83CEAE3CC4B4BD8EA0B82C49FBF2755188AC411E6B0
            60C1824F3EFD6C615FC75F7EFCB99F7DAB2AD5BEFF5FD5EA8ECD5B7CF35D3508
            0E8D1A7FF5D1C724AB34422F5C68D9B66D5F2707FB76ED9AB76EEB3E756AE0E6
            C0A9D3A7F4EEDB7BE468D7E1D5ABAD05C555A70E15162DA2E28B16D197103FE8
            E6466AD1C130EFD8BC7E55FEFA65C1EB9799AFCB2EBDC819FB3CBD6379F6EC93
            7E1FA63D394D72184754545446460668B0EC6C38DA8ADD6BE640CAF88445C4FE
            D4714693EE2B1C071C0D1A641F3BA716515FFEDD2386BE3FD9717AC34ECBBE69
            3EBE5B9FFE5B36AC68D9ACA1EF5AA91F901607B4D6BEE4296733560EDCF48D7F
            D894556787F5DFF4D5E1C78BCEE7AD1E7DA4BADBAEFAF9C57A7E5347C4BBB56B
            A99B0BCE790C70491B390819494546A0DB075A6871BE000681B6D34D3318DF07
            91F191258176EDDB5EFEBCAC40B5231D3E76405C5170E0FD7CA0C4BF924C72EB
            43EF4710F769FFA13359FD6703F72FA8AC67CF9EC1D32E2B2BEB52446C7DD79D
            B400BB7DEF61666666414101A4421EC829B11591396204D8EB332D5FDF1BFCE7
            CBE37FBEBCF2E78B4B7FBEB8FCE7CBB03F9EF9BFBED1EE75A87DDEDEC6ED6A7D
            E0DAF68B3FCFD8BF3EDC8C09D205D88BB2B2BDBFFD76EDB3CF1E7CF041CCDB6F
            C7FCE73F10EE7DF0CE82633F82009B15FA738F193B3BCC380EA1A32A749B73B2
            EBF4BD3D7B4D85E12055882228C0FEF83D3960E8E3B9B5FF480B8B1AFA0EDC2A
            BFBF7A11BF6F41D4AC7A650F8FDF19F31523C048457CE8DDE2EE464727AABE7F
            7BE0E0C1B7FFF39FBA0D1BFB05507FEC8EC3C04183DFFFF0A386CD5B262452EF
            C9C7272440413A09A07A8B2809C9026CC65721212170C353DF25D2076483CC50
            8414360ED86240473D0E3F6240808206EF830C20C0E6B45A467D0471C9C2C74F
            1E5CB97161C9E285636A4F9F336D4EF099E3E72E9EBE70F95C44E48DACECCC00
            7FFF514D268DF876BA7BED05FDAB8E72F96962C7AFFB584680819A024D052AEB
            819FDF999F7F3E55B56AEA8D1BB4EE6248387102EC10522E5F962EC0600061D3
            DFBA756B83468DC74E18376888333CD8403295961517971646A55C7892752735
            EFF191BB3EC7EFF982BDB0B0A06BCF1EE3268CAB55B7DEFC050B8E1C39020F39
            F159E06DA2B0A8B84E8F399DFA6C6ADB2BA845C720B7693B36EF3EB179D7C9F1
            D377366DEBD7A17750DF217BFEDB649483431FBD4D481940E074CD9A496DDAEC
            79FBED42D5EF59EF7CEBAD673D7B82F4CA898DDDFD8F7F1475EBB6FFFFFEEF59
            66E6B39494BD6FBF9DD2BEFDF16FBFA50B1A8CC4DFA627B9F5B169C40719618B
            938F8F22E118154CDB84101247188069A281A532CCD9B9EDB7DF06F61F70AF75
            EBC51D3B79B5EBB0AF751BCF7EFD037EFA39F0E75FC6346BF6D3975F96959549
            3F6740E6561D3AB6EDD4B18FA343BF814E3D1D7AB5EBD4B9A97D6B90E863C68E
            1C3A6CC8B83A35BD4077BDF71E15C68FA72360D9EBE6F6F4A9E0677BA47B27C8
            8B945725A12F0BFC5FE4CE7F9D3FFD45EED22B076A469C9D40524DC1FDFBF7E1
            26020126F20E989990383E99390503A7F8AD9F3E2065C740E6BDAF88A11FB874
            1F51BDF5B42A0D07B6E8DCAF6D77A7A1831CFC7CBCEAD5AC71ECD81189F32EC2
            F13BBE8E9B3EDB933AEE724EE0F0ED3F0EDBF6E3C50CFF2399D3871FF89FDBCE
            7AD945FA3FD025E29D8F8F0FDC3EB09732C0A52C23A9C808746BA68596D077C0
            48261526E983C8F8C89240C74F1D813DE1597111F42AE4FC29E3A71EC8C8485F
            B078DEF5F02BD0DCC3B818683DF631D5F4E5AB6113278D4F4D4D21F94CC191E3
            07A1E7B0C1828CDCB9779B61FD8711807901E905F732FD75CD3B77EE80000B8D
            A604D8F5EBD71F3D7A949A9A0AC20C1EE820C3606F2425451199235A3B792D5D
            5072B8795968F7570FA6BC7E34FBF59359AF9FCC7E1D37E7E5BDD1C5275A4252
            EAD64675BE7DBB73FD0FFE38615FB2B72913A40B3020EBE6CDA0F7DEBBF7C927
            D16FBF1DFDAF7F45FFFBDFC7BB7C02EA8B0E13A68E693BE548DBA9546837ED58
            578F63B64E8B2F075F2685F5C12FC068F535E3FB3FE2F63E9EF5D3A5016F1FEA
            6A73A2E7DF2266D42C8BDA9CB47968E2A6E120D1A0A09102EC9B6FBF6BD3B133
            3DE9FFABF2EDFFAA56EBDACB41770D7CF6D9E755AA559F30792A9D54F5FB1F40
            AA31D9A01B88A2902CC0A67E75FAF469B8DB132400D920331421858D03CE13A0
            A31E5C3BF2E0BACC708D1260C61F474080CD6EE93DAADACCB973663F497C1C11
            757DDEDCD9A36A4D9B3E61DAD1E307CF9E0FBE167EF9DEFD3BE9194F7DD7F9BA
            369C08026C72BD4583BF1F3BEC27F78E5F3958588051422B3838B87AF5A8C58B
            E94B86A4F3E74F56AD0A21EEC001C82C5180013086E1E1E1B5EBD75FB37655A7
            AE5D0A0AF20A0AF2454233FB567E1BD7FFFC5BCDF3E7CFE7E6E64A7948F03671
            F1C6BDEFDB4E6BD37343B7BE3B5A75DF6ADF79BB7DE76DADBA07F5EABFB7AB53
            D077AD264D9B31FBD71FABEFD9BD4BBC092903089CAA5123B575EBC31F7F9C79
            F56A5A48C881F7DE4B6BDFFE58952A393939277EF925A975EBA39F7FFE68D7AE
            9C3B770E7CF0C1D376ED8E7D63EC177824FE363DC92D0A6CE21B87BD9B7E7161
            D2F1D149C74632C1844D88207184E178515C5C5C505040EB6D073BBB8B6DDB46
            4F9ABCA671E3076DDA84B66973D5D1F156DB762BBEFEFA4E9BB6D1C38635FFE5
            17386D4066E977714E6EEECCD973DB77E9DAA24DBB1163DC76EDDD074BBD63B7
            EE75EC1A41A851B75EFFEFBF9F0D1A4C1D20BE43547D0112BD13A1A4382D3FFB
            665EC6899C64DFA428D7836BDE3FBB77407A7A8AF1BB139BC8C8C89494141861
            726D29A48F0FACD2D4A3639E3FBDF12AED467A408F7097F7460E18326EC196A0
            FD67FD36F856FFAE4AC3662D9AB56E3F6248DF959E737FF9A1EAD52B57CACBCB
            75CF31B208BC3C63E0D62F76A58DBC96BDF57266D0DEF4F1AE87FF376A47ADF4
            7CAD2F860921E21D2D7E38C832928A8C40B7665A6871BE000681B6934C6A8CEF
            83F8EC4B974057AE87C144979597C2B939E2B6E13F77C4212D3DCD63CE8CF088
            6BD9399909C971F07AEDC6957113DCE04E21394CC4B90BA7613C4140C22E772C
            F8B0618B161E64454545B0E3C1BE07EAEBFEFDFB30BC20C0CEA9F473484808DC
            E34F9E3C81CE8370059D565A5A2AA521913902ED0403BEC473BE9BDB7003C252
            AF05E0B5440106847B78ECFED7BFA24086BDFDF6BD7FFE73C5C6AA8C005B38BF
            A5BDFB21086D261F6E3FE5508341CB174E582A7D18790558DEA52D5143FEF9FB
            DD35CF0F77787DB2338457C1DD7EBF39B7EC8677C246A788D15FBF2CA07EF405
            305280BDF5D65B76CD5AC4A9BE5E1BB495FA358EFA8D9AC0ECD0A934B0DBFFE3
            1FFFA8DFB8E9A3C78FE132F4FC792885024CC948FD0ED80F93BE3A79F224EC0E
            1281CC508414360ED88FD6CE1D74F5C4867B97F7C80A578EFBAE9BEF0CC54945
            8652FDAF3546D79A3ED56EC9F469531353E2EF3F885AB060DEB8896E63278C39
            747CFFC52BA1B7EE843F78783FE569F2EA552B87351807026C6A83C52E3F4E18
            F6C3E40ED61060409497D7397B7B72A126253CFC78D5AA10EEAE58214B80C113
            E5E6CD9B5FFFAFCA9469937FAE51A377DF9ECE4307EB86499BC3A704DD721CD8
            AFEAF7DF8F1D3FFAEBFFFDEFD2E5CB707E22B58822D4448FFE2ED5ECC7D5683B
            B745379FCEBD377771086AD5633D5C7EDD70783DFBEE6EA3872F5D30E3D79FAA
            5DBA14462AE243CA000277E7CC89AC5327AE61C383EFBD175CA5CAC366CDC26B
            D78E5CB8303B3BFB96B7F795DF7E7BD2A2C5E9AA55F7BFFBEEC3060DEED5AF7F
            63B4D8AF574B41E26FD3D3994580D10355B3D5FDFB5B41FDD2CECF7F4A8579AA
            30D7544D88236584E131535858989494141B1B7BE3C68D73C1C15EDF7C13396C
            D8AD29538EB66D7BCBC5E5DAD0A1175AB4BCD4BA7548870E0FDCDD235BB576EE
            D6EDD6AD5B313131B07A492DD2105A7567BDBC2682EE7275650418C4C1027692
            830F89EB4784B4E4C888B075A776391FF26F7B7063874B21818F1E3D4A4F4F87
            DB90E4301130C812EF381322717CA06F31B7CE1F5BEE509A18961BB634C9BFF3
            83539BA3A3A3232222A086D0D0D0756BD77E5FEDBB1ABFFED2C0CE6EF4B001F3
            3D2681068B89B96FA4472F5E3E5F78DC61D8FEFF06A60C084C1A30E6E4B7AEDB
            7E4DCD7B4492F521E2DDBE7DFB40C0180C14271519816E1F68A12514482635C6
            F741EFEC4B9440D13177618D3C7F5EFEFBEFBF3F8A7B40ACD210FF7CE0D3A74F
            274F71BF1971E3D9B3C2F09BD7C7B88D4A4949266992D1FB1144108D70E20701
            09EB1CC424B1CA010AC2D9094E2CF0C4813E272424C0DD71F9F265FA7738EA0F
            DF71EEDCB9DBB76FD3020C449A4904D8A640BF07B131D02E6CCE06F0FCC57328
            0E9590EAF4F2F265F8CC999BDE7EFBE2BFFF7DA1E6FBB32EFE3AEBC22FB4005B
            12F06B8BF1075A4E3CD074D496DABDE6AD98B0E4A59C1FE3117A072C61E3D0E8
            F11FFF7E6D6AD4844F4EF5FDE7A1AE36C7BBDB5C70FE30D677F08B7CA2BE0023
            05D85FFEF2979AF56C6D9B346BDDA153CFBE8E6FFFE73FD57FFAE54E94D6AFB9
            1E3B7EE29D77DFADDDA0216468D5A1E3FFBEABF6D1279F824E6366907405510C
            52DF01FB655295E3328122A4B071C07E74FAD89ED5B3FA2F9BD243565835ABFF
            D993FB8D17603BB6ECFCED1DDB91BF4D75779F98FA34A9B0B020BF202F3B272B
            3D23ED697A6A5676265CE6E5E56466652C5BEA3DAAC5A4497516CE6BB76A9CAD
            C7A85FA7B5FEACFB2A2F63BFCCA0F7E60738022C372727A455ABD49B37C9B58A
            F4E8E8A355AB42B8317EBC5C0176FDFAF58F3FFDAC61B3E6DF54F9B67BCF6E4E
            FDFB32C1B15F1F12FA3B39F677ECD1BBFB675F7C59C7AE21E43F7FFEBC740126
            D444DF7E7D9B761D52B3DDC8EF5A8EFDAEE5B89AED4635EC38F0F32FBEFCFA8B
            4F7FFBADC668D7C173674EF8BE9AD8A701A50C2090111E7EE0FDF79F346992D3
            B9737AAB56B77EFB6DEFFBEFDFBE78111E87B9A9A987BEF822FCD75FD3ECED73
            BA74496CD66CFFFBEF5FDEB4099E82A4B04148FC6D7A925B9867CF9E3D7CF8F0
            70D012FFD1DFAC1DF80F9F0110FEBEA6FFDF56F7FF9BA99A1047CA08C3333E2B
            2B0B4E0FF7B66F0F69D6EC74952A37EDED63A64E3DEBEC7CDAC9E9629B36A7FB
            F58BECDBF7B293D3FE8E1D0F74E800F26CDAF8F1274F9E040D06470D528B28D3
            67CDFE4DF5F75578439BAFFFEB0A8A6BC4883FDF7A0B02155745C002F193C21A
            4CE2FA11075678717131DC86B09CA49F9C2A0512C707FC1D3DA8C3671FBD9372
            626AEAB91571374FDDBF7F1FD4D7A54B97CE9E3D7BE4C891C0C0C0193366FCFC
            23DCCDDFD4FAED27B711833BB76BE9E5B9C478995A589A3B6E97DD98E0EFDC4E
            571D1AF44342B6E67B177A11F70EE691FEF14958D8E00E9C8F611F038F60EB83
            E3320011B80423244106C80699A108E75FC78D81D3078EE2E20493F741CAEC4B
            914029A949AF5FBF866502022C3D43DE6FFDE9FD89C2D4D494B1E347EFD8B97D
            D4E811C9F2D517A0B709108DD0731090E0824A4C1A02EC123029706881D9494B
            4B83998A8C8C040146CFDD8D1B37609F87C1A4F710D84F60532525451199A3DB
            91B7403E79792F36384071A88454270C9C04727272403A820B9777EC08A852C5
            63E86763777F3FF9C44F1EE77F8530F5C88F0D9D97D7EAEBD9BADDD84D6B7740
            B6E4E4642822F108C10830905E74A00418F0C7EF0F370CBD3DE6FDD721FDCE38
            FD87FEC6972EC60BB05F6AD5619E35BFD6AE5BD7AED1D61D3B61EF8269022032
            DACDED93CF3EA733D4A85B9F8EA00053325205D8B2CD5E3F4FAC527DFC97D5C6
            7D01A1EAB8CFBF1BFB19846FDD3E85F09D1B1507239D0AD920331421858D036E
            3FB8696FDEBC19161676513290198A404123FFF59466CD329FEA7FAD3164B0F3
            F0914387BA0E193274F0E02103070EEEDF7FA013A5109C1C987BFED7CF6A7D6D
            53950E556C7EACF7699333A705FFBE9044A43CE16801C626E5F4E99453A7C885
            8AA29C9C280F0F08B1EBD7C3A52C01161515F5E9E79FBFF3EEBBFFF7FEFB9F7F
            F5D5175F7F2D12DE7DFF7DC8F9E1C71F8787874B7C4218D0C47BEFBFF7C5A71F
            356DDCA073FB16102115F1216500019031E15BB71EF8FEFB5DFFFCE7AE8F3EDA
            6167777CE74EE8157D4CC97FFAF44C8F1EFBBFF8025277FEF7BF3BA74DBB7CF9
            323C26E9B286C1FBDBF413278D9FE03E6E82FBD87113DCC68E1BBD6A8DFE7750
            610787CED30FECC7DAF8AC5B6D9226C49132C2A5BB77E70D1E9CDEBE7D5AAB56
            8FAB558B69D3E6FA77DF45B46A75B36EDD1B75EB5E87F0DB6F110D1B46D6AC19
            55B52A24AD6ED3E6E2BC797017C38143E22A82E7D982C5F338E70326F407C535
            6EDC9FEFBE0B01E2EBDCDC288BEA12EC1027B5E82071FD281689E303ABF4CAB9
            C379B9D90505051919194949498F1E3D82FB0B8E95B05D83063B76ECD88E1D3B
            D6AC596DDFB23968B01A3F7F5FADCA7F4343CF99640F4FC97D387E7743B79DF5
            1E67DC262669E0EC8B23717CF44AA0BCFCDC57A0BF54EFCC1714CAFBFBC87A7F
            A210487D9A3A63E6347825D732D1DB0488461060B0CCA1FF202689552650333C
            0A61BB83870E6CE97979797086816D7CC192252048121212407A813C83C77799
            9C2FC7EA9D23A80AEA841B13040FDC9BB0E582F881E6E8BF190840042EC10849
            9001B2416628227167865B187A0E3580FE87FB3D3434F4C8C1836BE7F6993DA3
            F6E87955062FFE66A8C7976EB3AB8CE83F60D9A8299074EEDC39C806996997A5
            EC00B4002B2C2C60027DC605FEF8E3F7984DE34E38FC2B661BF915445D8C1160
            306520C06ADBDAD11F74A743BD868D8F9F3809D3078346337CB8EBC79F7DA695
            A75193A6ADDA30DE91AE208A41AA0003E056871D016E06FA5FDA1E3C7870F7EE
            DD481510814B30421264806C12F705294055B04061D3811B5E1650040A9AA427
            B1B1B1A0250C034686D4624E0E1C3800828A8DD7CC99E37FFA895CD02C5B36EA
            934F20B87DF30D5C411152581F3086595959C78F1F5FB76EDDEAD5ABC9875784
            813C6BD7AE95F2F31B0C8635E1BF7163D34676D5BFFB9F7D8BA6A422E3809D34
            3F3F1F8E86717171A0676009B1FB0F0F1B505CB0CEE1A920FD5FE64480CA757F
            9B9E83C401042027F49F83EA595E5242076DE0192FB709C328F5F129F8E9272A
            D4AD9BDFBA757ECB96F90D1A14D4AA95D7B061AEAD6DB6AD6D96BD7D56870E10
            721D1DF3A74C7976FC38EC21700B171616C2148017A4227D88BF03D613E45695
            2A1020E258BF3E9C2456BBB9B18DA416C46CD04B146E9C62D55701E196874706
            DC4D70BB81188323260011B8C50EECDFE7367AE4D933D4178FCDBD3E11CB60A4
            041241EFE7038D476F13201A55EFE051BF794A89492380054FDF29B42E823D10
            94186C8670D7C0BD03763A03C95D49809EC343137408DCE37068BC76EDDAF9F3
            E74F9D3A050F7D382A0010814B30421264806C9059FA73F6E8D1A320A20C063A
            60D890C274C09981FED7CF989818380C03D1D1D170F003E50C4606D8D920C3BD
            7BF7A254400690B550108AD3CF38722A47148321670E582B7068A39FA0701E05
            2002072630D2CB0879F3802701CC72666626682A29D09F508752A4BC042CD004
            A26476FBFA76B4B181B05CFDAB1BF00A71DA08A97436C4DCD0C7477858C0D10A
            9E1AA5D4BF10501FD461FE51A0F29E3211C41C1C3C4CC98337E676A085253CEE
            E937DC52554044EE1B6BBAD0A3C481A4A9CEAE5033DB623C501BEC5DD4573CD2
            D3939292405301F41FC7A78F2800A4C239191C4C494981241063900732830552
            C15FBA2A722A4714838D6A7D22088220088220086205C8A91C510C28C0100441
            10044110C46A905339A21850802108822008822088D520A7724431A000431004
            4110044110AB414EE588624001862008822008822056839CCA11C580020C4110
            0441100441AC063995238A01051882200882200882580D722A4714030A300441
            1004411004B11AE4548E28061460088220088220086235C8A91C510C28C01004
            4110044110C46A905339A21850802108822008822088D520A7724431A0004310
            044110044110AB414EE588624001862008822008822056839CCA11C580020C41
            100441100441AC063995238A01051882200882200882580D722A4714834D5050
            D00B1DF61F3C8EC102810CB70E9C6C560CA443088220088220887920A7724431
            080A30928E980D11795341C61F0598B518BAF44CDD61DBD9C176C4CE2663764F
            5C7B3E36319B64323527AEC6B59B74B0DEF01DB202148182A40A04411084C5AD
            DB112B5679C32BB956C16B34158B8ED51DBCCE860E0B8FD679FEFC3949402A36
            E4E085280614602660827CA09425051869550E500A0598B5A8E3B235FC71DED5
            87B9613139E7EE659DBE9379F466DACE4B49B3B746B49EB03733B788E433296D
            271D78925E545CFE4A568022509054812056024E99294F93236E875FB8147A21
            ECDCF9B073A11743422F9C3D77FE6CC8F93321A1A7CF9E3B7DE6DCA93321A74E
            9F0D3E75E624844B57C2E213E2A51F4FDF8C26100BB37CE5D22BD7C296ADF062
            CF11AFD1540CF0F9CB8532173AF45F63836BA3B2409FD610E540DD9CBAA00093
            052D57A4C3C81B32DC3A984380919834747B78E5CA1512430C42D6003A2F3E59
            D725A8D1881DCDC7EC02C5D571F2C16E338F4E0CB8B9F16CFCD8B5611E7E1749
            3E93526FF88EC2D29719F9E5F199C5120364862250905461047AC72768EBE689
            93C64B099B3607903286B2455A5B9B02FD490143D91214C8A95328046CDA48CA
            08203E809B2537C409C60FA649D0BB3C5252921EC4DE7FF94AC6F7285EBE7C79
            272A323EFE09A9421F95BA09DCC02DC69D107F9F81FF5CE9F4161D76EEDE5E5A
            56BA656B2063E1354291A8103DFB89C449745AF997D3CF1C7D726CE0D571854D
            79793949A8D8887BB770E17CCED6241426B88FE558E8A0770B356B137AE76EE9
            B225E496461403F50E18997F1628C06481028C4DFFC1437EAB67CB09B56CEDEA
            366C64DBA4598F3E7D17792D8D79F080E4361A78BA5C0CBB346AECB8B69DBA34
            6E69DFDBA99FF78A95191999EB36F83568D2CCB64993D1E3C693ACF2D1F5A576
            8386E085DB8489725D907B002A2E29CBCE2B4ACEC87F989875E761DA9E90FB2D
            C6ED1E177867DECEA8BE738F924C260574547EF18BF8CC1259018A584680B56E
            D3EA4258C8F9B0B3A7CF9D3C1E7CF8E0917DBBF7EFD8B673CBA62D1BD76F5CBB
            66DDCA652BBD167B2D9C33CF037292328602351C3EB65FA889790B66CF9C3DCD
            7DCA049334B463F756A126264F731F37D16DD498112EC39CF5B6253E80ADDBD8
            6FDBB979C7EEA06DBBB66CDDB13968FBA6CD5B03A051FFC00D7E01BED0F4DAF5
            ABA1F5556B962F5FB574E9724F4FEF458B3CE7CF5D301B0A922AF4919E9E4E7D
            915C9BB8B8381263C16B4C4B4B2315F1A17779DC08BF06BAE5D5AB57E41F9325
            0099A1DDD00BE74815FAA8D44D080DE05C7FD7391B87CDF273F1D8E03C63C3A0
            19EB074CF3ED3FD5D769CABABE93D63AB8AFED05AF109FE2EB34CDB7DF74DF01
            33D60F829CB336B8CCF61B3A67E370931FEE73727356AF593568F000873EBDC6
            8E1B73E8F041DE26AE5FBF3679AAFBA9D3C1E4BA22B176D0BF62F6BA241C1F0F
            21F1F878CFA58BC078F8E8C1A41313924E4E4C3A31115E196372B07B4AB07BF2
            29F78707868306131F4F890F91DECBFF7238BFDBB20C1B78EDB5CCD202ACB8B8
            98C4D4E85A7811F7AE4DDBD6EB36AC3126E8DD42CDDA84DEB94301A640508099
            0014606C40A56CF4F7E3840D1B37ACDFE0BB769DCFFC45F3878F1AD9AC759BCC
            CC4C52C008F2F30B9C87BBF61BEC3C6DC6F4A5DE5E2B56AD98336FCEB091239A
            B46C65DFBEC3F295CB5D5C5D57AEF121B9E5A3EBCB063FDF556B568D9B38B145
            DB76B25C903E80BC64E515D51FBAC56955F8DCDD775B8DDB45AC26057454EEB3
            E7F119C56BFD0338FFB0C71B56F96E80CC50C43202CCD575F8679F7D2A25B80C
            7521650C65F8F0619C3A79838BCB1052C05024360461C81067524600F1011C36
            6C28A7428961A8E4C1A4651591052AE052969154C487DEE57126E4146C59E442
            3250E4C0A1FDE4421F95BA09A10104011695792632E36444FAF1F0B4C3D79F1E
            B89ABAF752F2CE8B495B4313378724F8872404D0AFE7A8B02914426220249D4F
            DC0C02EC5E5CB8E7E649A63AE23F7BF66CB8EBD0F61DDA2E5AB460C78EEDEE93
            26F676E8E9E7B78124ABC9CDCD9D367D8AA7D7A292921262AA48ACEAF757905E
            0E7D7BD101B4565676E66A9F958C85D798123C69A5D35B060BB0A9BBEA74F7B2
            61C2AEECB68B53A857B611F2B0EB8F8D8DAD5FBFFE3BEFBC636F6F9F9C9C4CAC
            4610131353B366CDBFFFFDEFB56AD57AF4E811AF4504F17BDCD6B63E676B120A
            5F7EF939C74207BD5BA8599BD0BB83A10053209400837B92030A3059182C6FC8
            70EB50710418E95079396C1F24A60F102DD3674E659E2B10FA38F6EEEBE4E0D8
            AFCF20E701E3C6BB792F5FEA3C6CD8F459B3490143494B4FEFD36FC0E4E9D356
            AE5E3176C2B86EBD1D1AB76CD5A64387FE039D46BB8D5AB070C1C2C50B1B356F
            99959D4D0AC8A7FFE021B56CEDEA376EDAB0598BA6F6ADECDBB56FDBB1D3A021
            8396ADF01E317AB42C17A40F605A56C1A22D97862C3AD661E2EE7A43026BF4DF
            488706C3833A2EBE3C73C73D3092AC26057454761108B092D66DEC8F9E3878F8
            F881BD07766DDBB92560B3DFBA0D6B56ACF6A6DE5F9AEF3175C6E4F113DD5C47
            0E836C90198A4041528511481F1F8417AB0FE0E3C78F414A91D3840AB8946524
            15F1A1D7BBE0D32760CBA2E35EB054F5053A2714D9B77F2F1DD70BBB09E95490
            2684061004D89DCC53C71E2F3FF2C8FBD043CF83B18BF63F58B03766EECE7B1E
            EB42C72D39E802AF10DF1333775FCCFC030F161D8A5D72E4E1D2A38F96830C03
            0136627E3708656565A43AE33874E8508B96CDBDBD97D297A0C7468E72050D96
            9494445B6836F8F98E1A33E2E1C358722D87CD9B37B769D3C6CECE0E5E214EAC
            3A6467672F5AB408B2013D7AF43875EA144990804A808D8307DF9F7FFE015303
            5A2BEA5E24BC429C816374E8DB3BE51425C0C44752E42EE8BCC826F069137698
            FB846B813CECFADDDCDCC035D0454E4E4E1E1E1EC46A04EEEEEE7DFAF4494F4F
            879A274E9CC86B11E1CD7E04E8F50E059802A1DE9ED60505982C5080B101D152
            B37E837A8D9A3468DABC710BFB66AD5AB768D3D6BE6DBBCE5D3BD37ACC75E4F0
            C9D3A6807622050C223131A96DE7CED3664E5FB0687EAFBE7DDA77E976FD4678
            724A8AA7F73268B197434FA7FE7D3B74E90C97A480A1C021203B3B272939F941
            ECC3C8A8A85D7BF735B56FED3A62D8EC797364B9207100EF3E4E6BE21A347AF5
            79CFBD77971F8E597DE2D1CAE38FBD0E3F9CBFFF41AB79614D675D70DB74E717
            A70D24B749011D9559487D01ACDF2017CE3FECF1863EFD064166288202AC2260
            F501A4651507594652111F7ABD3B71F2186C59E5E570BE2C53ED617A6072EEDE
            B38B54A10F7613D243056942680041804566048300DB786EBAEF99498C005B7F
            7EFCA2BD2ECB8E0F87578833026CC3D9C9EBCF4C0101762E210004D8FED88526
            1460F3E7CF6BD2B4D1D5AB57C97579B9BFFFC6AEDDBA84849C25D7E5E537C26F
            0C7119BC7DC736722D075A53D1D28B96616021692C407D0D1A340852E175CD9A
            359408B3B3DBBF7F3F49D60708B044B500CBCFCFF75EEE79E8E83E7885384811
            806384E90301967ACADD1801D661BECDBAC4BA33626D8402A4421E76FD75EBD6
            0D0B0B8348545454D3A64D8D9FC4264D9A84868642E4C99327503954A86B5165
            E4E7CD7E04E8F50E05980291F10E58B0AB8D8D6B30B9E010B7BA914DA3D571E4
            4A1B282794F486600901C6197DEA9242E2C85A528001C5C5C53939394FD3D29E
            C4C7DF8F89B91D19B9EFC0C1462D5AD202ACDF00C76933A6B5EAD091E4360897
            1123478F759B3B6F76B79EDD5BB66BFFF4E95392505EDEA97BCF8E5D3AF6ECDD
            A341936669E9E9C46A22B2B2B3EB376E0A2E2C5CBC50960B120770D1E68B5D67
            1D1FB22EA2C39CD34D476EB71BB6A5FE90C03A83FC7FEBB7A1AE736083E9A1A3
            03227FEEEB4B729B14D0511905327E81830E50C43202CCE09F91F00FF02355E8
            A3523761F5E3CB5DA32115F1A1D7BBA3C70EC3965556562A2B40911D3BB7932A
            F451A99B101A401060B7334E8000F30B99C61660DE874730020CE28C005B7F86
            08B090047F930BB01933A637B0B38DB81541AECBCBB76CD9DCB153FB1327C993
            08E4CA18B751E326B81514E4D316E980CC68D8B02148297A28E095565677EEDC
            A13330803C033B28345062EC4B896EB2DF01830EDFBA1DB17CE55278650B30C6
            58585808D367BC006B33D7C6FBF1CFEC30299A6B813C4CFD10F9F7BFFF9D9595
            05F1D2D2D28F3FFED8F849FCECB3CF929393E9F8471F7D04D5EA5AE8382FE2F7
            785AF0AAE8715F27EF9C525EA655C9E62D527754A9BB745929B4026D418BB4C1
            244D887B07A00053209400831B8F038F000089D5C8D5B59101524A7102CCD9D9
            99C4D4702C8CBC21C3AD83F6F853EAD6C6D5D55523C06048E9B8D4B135BE87B0
            7D90982820BA16797A8D1833B6675F47FB761DEA356C5CB37E835AB676104080
            F571EC0DC1A97FDF6933A7DA36A6FEC9CD30CE9DBFD0CDA18FC7AC194E039CEC
            9A368F7BF284249495DD080F6FD2D2BE779F5EADDAB79BBB6021B11A04F8B270
            89A7F370D70E5DBBD56FD484FE110E0876CD9A3BF6EBB3C46BB12C17240EA0CB
            C2A34D261D6F352FCC76E8E643E7EF3F88CF4848CD4ECBCACFCD2FFAA9CFBA96
            732FBA05444284E43629A0A3D2A99F40E4FECC8678802250905461047AC7A775
            9B56C1678F9F3A7BFC58F0E14347F7ED3DB073C7EEA0CDDB02366E5ABF6EC39A
            956B96C1036CE1927973E6794CF798E23E65C2D8F1A3478C1A3E64E8202848AA
            D047A56E42E202331FA0A0E0C0CA0067BB7BF7EE910B1D20336420172AC0422A
            E243AF77870E1F842D0B4E7800E7D3861068BB2E5064EBB6ADA40A7DB09B904E
            05694268004180DDCA38AEFB11445A802DD833185E971E740D8A98B92DC2635B
            F8ACBDF7161C8EF502017636DE8F1160D007529D71AC5BB7B66EBD3A5B82B690
            EBB2B2C95326B569D7FAD6ED5BF4A5AFEF5A873EBD6EDE0CA72F6541EB2880E9
            2DADC7C04E5F328C1E3D1AECF04A5F5EBE7C5955CE0E22B4451CEA1DB0636EB4
            0003B905CDFDFEFBEFF04AAB2F1ADA089973727260FA1801263E922277C128FF
            DA2D3D6C98302FBACAD8DBD42BDB0879D8F5DBDADA8685854104A469A3468DC4
            9B9642DBB66D8383832112131303954385BA1655467EC4EFF1E889DFFE91FFF0
            F13CBB840D834A4B8A89B5AC4CFA2F6748DAA54B4B12FD063F9ED7E08F8287D0
            6299AAC3266942EF0E86024C8148156094FE5A1D47BF1293549428C0D87A8673
            09C81460348CE8D28A4A9C11E37BA877FB00EEDEBBD7BC4DBBC55E5E870E1F0A
            3E151C7CEAE4FE03FB360705AEF1593D7BEE2C9761CE20BDFA0D70843065DA24
            5032A4984C8A8A8ADA76EE32669C1B1C4CEDDBB65BBD564B8D380D1ADCBE5387
            5E0E3D1A346D969C9242ACF2015F9AB56E3362CCE8858B17792FF75EE3B3CA67
            EDEAD56B56AE58B90CD41738B2C473912C17A40C20D0DA6D5B9D09279A7A5CA8
            336823E82E6255F1436F9F4E8B2F8F0FBC0311629200FD4E2903B1F2013A2A2D
            AF2C2153C68F70406628A2578091B6D510AB367AC7C7E09F9170761E4CAAD047
            A56E427C0003B76CE24C9F480808F48722F7DCAB3F98552F61F398E2AC64BA12
            71D8022C3333F3D6AD5B70BC23D73A40D2CD9B37333232C8B5D1020CB61AD8B2
            4A4B4B20A8F6302D68BB6E80A4CD5BB8E76F21D84D70041E6F30B209E9414A13
            420308022C22FDA8AE00A33F82B860F7E0999BFACD0DE8BB7295BDEF325BBF95
            75376E68BAEBF294230F979D89DF204580917B5E0DB10AF024FE498306F59B35
            6B7AECD85138B26FF0DBD0AC79D3A1C35C4A4A4A20F5F6ED5B5DBB7759B16219
            9D592EA3468D020D00AFE49ACF42D3A04103B0070606926B3E8B081C01C6B060
            F112B709EE23DDC61D3B7102567E5656566E6E6E4141014C1F08B0A7A78D1260
            6C9ACFF8CB94DB9F8DB86103AFCDA6DB08D53969D2A4BE7DFB2626260E1E3C78
            CA9429C46A107413F3E6CD03C50572CEC9C969E2C489BC1611C4BD4BDC3CFAF1
            ACDFFE48BBF878564DB60693BEA3EADFA569F5A56E055AA4CD266942EFDCA100
            5320FC1BA28E00509FF3B5CEFB94B27275A5DE9D0966A92C88118848D024BDA9
            F0CA1B8013673052807127412DC64430BE8752B6FE25DECB060D719E3C751268
            AD0183FAF51FE844078843183818427F08839CFBBB4F9A60B0003B1372AE4BCF
            9EE3278CEDDEAB7B9396ADF2F2F2484259D9E52B579BB76E0302A96DC70E3366
            CF265683005F7AF4EE3562E4F09E0EBDECDBB56F6ADFAA51F396B64D9AD5B16B
            D4A8454B7067D1E2F9E61060351C7D9BCE3C37CA3FF2973E6B0B8B34FFCE77EA
            6A6CADFE1B1C965F73DF72E7FB9EAB89551AE47ED477FA011DF534B72C3153C6
            8F7040662822E51D30D203E13E481C1F4408F10184C9DABA73F3F65D41F0BA65
            FBA6C0207F9856BF005F5F3F1F1FDF55AB7CE85F9F5FB2C46BE1BC85D44FCF43
            91F07E36C50FCFA7EC981839FA8BEC3BA7E97A44600BB0DBB76F83C4D20B6423
            058C16607BF6EE812DABA4A4585680229B366D2255E883DD0444F4626413D283
            942684061004D8CDF423BC3FC2B1EAD4E8A97E7DA6AEEEE9B3B4C9A9FDFDE222
            67C747CDBC72AAFF36DF9A076E7A9C7EE22BF11D3072E7EBDB7F684243435BB4
            6C5EAB76CDBAF5EAD836A8EFE23224292909EC8585852E2ECE7D1D1D40B7D039
            8B8A8A40C63C7BF68CBED48BD50518CDBDE8E821AE2360C1D3EA0BFA0FD3675A
            01D678DA5F465D7FD7F98A0DBC369ACA23C03C3C3CE0F5C99327CD9A357BF7DD
            77E115E2749261CC9A350B5ED3D2D27AF4E8F1D5575F75ECD811741DAF45043D
            DE9596C46F18FC7846F53FE2F6C22BE77D301340AB2F75FD4FD69BB87EBD7387
            024C8150EF80C1FDC9812B0034477EF6E19F925AEA0B5D95C5587493DE3438F2
            06209A460DB1AA61E40D196E1DCC2DC000D23335C4AA46B787B07D909830C347
            8DEED2BD1B2DB106390FE8D6AB478B366D4123D9356D5EB761E3C62D5A3ABB0C
            1A327430847113DC40BD90623259E5B3B687436FA8A475FBF62BD7F810AB0A87
            7EFD9DFA53C2AF61B3164FE2E389D520C097CEDDBA40554DEC5B1D3E7A2CF6E1
            C3F88404789CE4E4E442CF070F19387FE15C592E481940E0E7DE6B3A2E0C9BB1
            E35EF3515BB79FB8753B26D9EFC0F51E9377DAB904745F10E2BC367CEAB6A8EA
            DD5792DC9281D30F8909A31260A5895925D27F84033243112848AA1045BC0F12
            C70711427C00870E9534A77480532F14091FFE719C8F43F1FD1305377784BB7E
            5294994C5725445454141C8E69E0A079F3E6CD8B172F926B1D2029222202B291
            EBAC2C284E2AE243EFF2D8B56B276C59C5C5CF64052812101040AAD047A56E42
            68004180A97E7D7EFF95D43D9752765C4C0A0A4D0C0C49D878EAF1BAA0B0F94B
            778F5DEAD53678FFA0949845F1118E2951FD8BB3F6DFBE3862D7B616A79EAC63
            0458494909A94E0029FB0F0368ADEBD7AF878484DC8FB94F4CA5A5BEBEEBEC5B
            B538752A18E23939394B977A3AF4E9D5DBA1E7C041FD37FA6F0025436713C1D5
            D5B54E9D3AF04AAEF92C3475EBD605BBBFBF3FB9E6B3884009B0E3FC026CBAC7
            AC361D3B5F080BCBCBCB0337417D417E983E1060692A01263E921237C90693FE
            32F0C2DFE960EB6EA377762A08E2DE95941447AF1D7467ECC7BF5F9B123DFEE3
            C7BE034B8AA9D1332171EB0741CD503FB472CF6720DC5924C114E89D3B14600A
            449200639FF821CEF7D6162B0E51026D61677B33D195370051363ADA06A80802
            0C20FD93D643295B7FE71E3DFB38F519329452596EE346DB36691A7CFACCC347
            8F525252AE5CBD56CBD66E98AB0B84E1235CC68C1D65B00073711DD9D789FA1C
            63A3162D631EC4126B69E9B9F3E73B75EB01D2AE53B72E93A64D275643015F1C
            FA3A406F1BB7B007DD45AC2AA0E72EC39CE7CE9F650E01567FD0FAAE0B4267EE
            BC37627558F3119B9B8F08ECE57164E8CA0BA337DE1AB121628CFF6D8F9DF76A
            F5F7ADDA7579AF293B491913013A2A5525C064052822518089A3777C36CBF910
            1D04FF4D1B494999C86AC832AD40F00FF023250590B8C0A45394959A7070C9B5
            A11F15856F7EE2372076E3089220005B80019999991C0B9B7BF7EE410672A1C2
            4801B67DFB36D8B29E3D2B9215A0887475C46E82F36943084C9D9C60C2267483
            F4268406100418CF1F625EE7E4E6D5BDDF24FBDE639B2E5BD034F6D6E2473706
            3EBED621E3E1B482D4F5F94F776E5BFB23FD8798250A302381D5D2B459934993
            DD210E6D4D9830BE43A7F6CB962D3D7DFAD4A2C50BFBF4EDBD7CC5323AA708CB
            972FAF59B36693264D98DE366DDA142C60A72F191C1D1DC1EEEE4E3507444646
            D6AA550B2CC78F0B3EB2D980004B121060B0E6EFDEBBE7347030A8AFE2E262C8
            FC5CF567DC54EF804D3495001BB8A64E9DF1367418B0BAF69B21C0EE6D9E7C6D
            C47BAF43FADD1AF5DE7D1F8DFA5AB8703E67AB140AB3E7CEA48BF053520C2166
            ED20A81F5A81B6A0453AC5244DE89D3B14600A448A00D3282A35F4919FADACD4
            718D3E6364023BDB9B09AFBC0178B50D60A4006347B5C49830C6F750CAD60F8A
            CB79E8605A622D5BE1EDD0AFFFEEBDFBAE87877BCC99DBBC4D5B07C73E23460D
            1F391A82EBA831AE060BB056ED3B38F6EFDBCBA167C3E62D680B1CE416797AB5
            EDDC65D294C9D07AA3E62D631F3E84C7DBD2E52B7CFDF41C5B85005F06390F58
            B4787E1DBB46EC7F5E3D131262D7ACF9F0114367CFF530AD00830E8352F5F43F
            51ABDFBAC12BC2A66F8F9AB6F5CE18DF2B8E8B4EB79DB8A79693CF2F0EABDCFC
            6F4FD81439D2F796F3CA9BDF75F186FCF453DC2450022CA734255B5E80229611
            60ADDBB43A7078CFC1237BF71DDCB56BEFF66D3B370706F9FB6DF25DB761CD2A
            9FE5DECB3D17792E98BB60D6CC59D3A64C731F3BC10DF2939232818250BFDE26
            C6BB8F85656C4C2BDB7706E96D62B4DB0858D2B014F53624E50E3580270716C7
            78B52EBCBC32DCFD67621200149491908AF8D0EB1D3CC860CB7AF6AC50568022
            D2D511BB09887060EAE40448325513BA486F427C00472EE80E528A091BF70E58
            38B3E9AEC0E19B7D7BAF5ADC343E7A65DCAD118991437392D614A50516A5EFDC
            B1EEE7DDF7E66DBE3EC3C37F90B905186C71FDFA39366FDE342131012E2F5FBE
            64DFAAE5F419D3E8544A8FB98F77E8D3EBD1A387B4458863C78ED550F1E8D123
            B8BC7DFBF66FBFFD069760A72F2FAA80B8B7B737D8DBB76F4FFBE5E7E7A72A57
            232323032EF52224C0B2B2B2727272D2D2D2070D1D064E95A97E75F0D5AB572F
            5EBC183D7664D2C9C9A6126022E8D66FD6B99385B8772786FCF7F5E1E6975DDF
            8B5CA5F5DE94AC5FC8206584292929BEB37A10B4026D9D70FE1AAEC1689226F4
            CE1D0A3005C2FFC1002D01C015508CC66227A8E38C8DCA45C7B8E5DF3C84E48D
            10C60A308DCA953AB6C6F750CAD66FDFAEC3E0218368893567DEEC751B7C4183
            F5ED3FC07DCAE429D3A68C193B720C1C59C78E721B076174A3162D41C00C7076
            2185253376A27BFB4E1D7B3AF4B06BD622233373D3E62DEDBA749B31CB6389D7
            1268A27BEF9EDD1DFA80D171E020D04ED33D66936232A9DBB0B1CB30E7652B96
            76E8D67DD7DEBD77A2A2366DA1EA6CD9B65DFF41FDC1418FD933CC21C0A2A3A3
            67AFDEDF7090CF779DBDBEEFE65DCF7185BDB377CF118B2779783619B8E2DB4E
            5E4C683FDADFB402ACADFB813337534050C90A50040A922A8C40EFF8C8FDF90A
            67676752522643E534E4EC3C981493C9D0A172DDD1D390943B540F25C5899B47
            474FA8F2F4A4E633AE7989F72F0C7CF7F96D9F737DFF414C023C7CF890FEABCA
            6C641949457CE8F52E303010B6ACA2A24259018A48574795BA09F1010401063A
            8A091E536C0FEC700D5CD371C1F47A016BDA1EDEDEF7C1AD05F9E9270BB34EE7
            A61E88081DB9C6BBC6A8853D272C759CE737263CFA02A9C53C6CDCE8F75BCD1A
            DB776CA72FD7F9AE6BD6ACC9E12387E84B60FB8E6DDD7B743D76EC28B916A657
            AF5E3FFDF453CF9E3D8F1E3D0AAF749C5620B05DC0250097A0D01A346800F199
            3367EED8B1C3D6D616E25E5E5E74257A5109B0316C0146FFE4C6883163C7B94F
            9E3C6DC6F90B17417D81EEDA7B60CF067F5FBF80F5DE2BBCD24DF711445EE0FE
            0247FEF18F7F806B8F1F3FE6B5989CD8D8D8C68D1BBFF3CE3BF6F6F6C9C97A3E
            C32CEEDDFD832B8F0DA912E13B1A341231A9B0B5ADCFD92A8542EDDA35491951
            A07E6805DA8216698B499AD03B7728C01408F50E18DCF31CD80240F78CAF3EFF
            B35398389548A1F9CD7AA922A1F262B0BC21C3AD831E0106C0950A96490CE37B
            08DB0789093363F69CEEBD7B31126B53A0FF8E9DDB56AE5A3E69CAC47113C68C
            1D3F66FC44375518BB60D1DC75BE3E1040C390C292397DF66C8B366DFA3A39D8
            B76BD7BC755BF7A9530337074E9D3EA577DFDEA08B7AF6E9DDA663A7BEFDFB0D
            1FE9DAA5478FA06DDB493199B468D36EA0F340CFA58B274E72EFD8BD7BA7EE3D
            060E711E33CE6D02F5A6C448707086C77446439232A24819400004556E6EEED3
            A74F1F3C7818151575E3C60D2878F9F26578853858E07000A9900772923226E2
            D8A587ED261DA8377C87AC0045A020A9C208248E0F2284B10358FC2C7EFD40D5
            EF2F3F8A1EF73531C261F480E79D79B6F927C65E1AF7233109F0E0C183F2F272
            72A1022E6519C9051F7ABD0305025B56616181AC0045A020A9421F166E82F369
            43084C9D9C20A509E9CBA3203F7BF664DB7B37BC177B3438B0B57FEC4D8F0DCB
            1A6F5DDF25F8C0B8D013D3F66FEEB07D6DADF06B27486E330322A156AD9A4E4E
            8ECC76B7C47349C34676212167E94BE0D0E1439DBB74DCB153FF560F4268E0C0
            813FA8813858E824C64E37141111D1AA552BDA022C59B284CE26058E008326D8
            3FB9011960B5BF7CF9F2F5EBD741DBB75CB8781ED4D7D80963D2541F4114DFD5
            8DB9C7274F9EDCB56B57504483060D72777707CB942953381671F6B56EBDF2D3
            CFC403E461BBE0E6E6D6BD7B77B8B51D1D1D3D3C3C88558037FB11A0D73B1460
            0A44BF0043F4621101661496116011B76FDB356BDEC7A9EF906143C68C1B3576
            FC68D791C307BB0C7670EADBBA43C786CD5AB84F1EEF3E79C2A429102642983C
            75A201020C1E63F6ED3BB4EDD4B18FA343BF814E3D1D7AB5EBD4B949CB56B51B
            341C337624C83C6865EA8CA98EFDFB77E9D90B1E7BA4984CB66CDBDEB455EB11
            A35C67CF9D356BCECCF1EEE3070D19DCB5678FE6ADDB808F2023A7CF9C3A6DFA
            E4C953DD25BAF0663F5D8C07C7C748C40790F767E80302FD49B24A7D3DA27E7F
            390C5E93764C065B414672ECBEC567067E9077A0FF03AF86777C87D17985A818
            022C5F568022F2D511B712F160701310E1C0D4C90990A4B70959F797D7DCD677
            AF2F9C3BA5C1FDF0458F6E0CBC7BBEFDE1ADAD82D6D86D5BDB2068758D5327B6
            E7E4E490AC66C6A14FEF1F7FFA213A3A9A5C9794AC5DEB53DFB6DEEEDDBBC935
            3568FEEDDAB73D72F408B9D6C7CD9B37434343E1955CABA08D00B956415B4004
            926B6980004B560B307AE278010DB662F5B28D011B8E9D380699E977C0CC27C0
            9A356B76E6CC1988C08D56AF5E3D6848D7A2CA28C8D20F3ECC71E8231E200FBB
            9EBA75EB9E3F7F1E229191914D9B36359F77151FBDDEA100532028C04C000A30
            86F3172E8E739FD4ADB74383A6CDEB376EDAAE739701435CA679CC3A73360422
            A0553861E010496F1F71484B4F9F36731654DEBC75DBE1A3466FDBB92B2F2FAF
            43D76E75EC1AD1A1BB439F8D9B02D3D2D2480183D8B425A84B8F5EB56CEDC091
            CE3D7AB94D98E8E3EB1B79E70EC711B8240544111AC0C8CFBF314920D519C49F
            CF6C4C12487506A17781E9FD4B561A39610A0237EBF96368019B3692ACA66053
            A03FA77E4EF00FF0235905101FC0D66DEC83B6076ED9B6C93F70C33AD51F1558
            E4391F8C541AADBE54BFBF0CAF97FAFEE548F7BF1EE9F69763BDFE1131FDC79C
            1D1DB3B7B53FD9FF83FCF444554D82D0B28A832C23A9880FBDCB83962E050579
            B2021491AB8E3835E80D15A409891B384DF061CF150B5BCC99D2E0C9DD1571B7
            463CB9D9272DC62D377E566ED2DA350B7ECCCACAD27B5837098181815F7DF5E5
            F2E5CBC9B58A6BD7AED6AA5D73D0E041F4BB49050505FDFA3BC24A7EF2248ECE
            60751801161D7B476280CC1967CD2BC03EFDF4D3C444720B7FF8E187307ABA16
            3A2EC4E277FE2FA5815DFCC79F080548853C8C0B10F9F7BFFF4DBFC708957FFC
            F1C7C67827BEFF4F1088B383BFBE1DDBAC4D0879072353545454585888024C81
            D8C02DA10B0A3059182C6FC870EB50710418E95071316C1F24A630E0014F62C6
            2134801C1D657020D519044747191C487506A17781B56ED36AEB8ECDDB766E01
            15B169CBC68D9BD6FBFAF9AC59B772C52A6FAF658BE72F9A0B1948565300B5AD
            DFB896DDC4C225F3E7CED7FA910F92D514406D4B962E643741FD02C7D891C347
            0C757619D46F001C31F534273E802E2E43385F57803064883324A587F8450DF9
            FBEF77D794EE6BFBFA64E79747DBBF3AD6FEF5F10EF09ABFADE9FD053F1E737A
            3FF1DA51BA1E11E0A40522CA60A038A9880FBDCBE3C08103A0E24A4B4BF2F373
            2586D2D2E2E7CF9F434152853E2A7513B236F0C2C2FC1D01AEB327D7DDBABE7B
            F48DB919F15BB29383921FAC3AB5D761FB86CE706424F9CC497C7CFC77DF7DD7
            AC79B3FC827C6252336AF4A89AB57E1B3A6CA8EF7ADFC1CE831B3769B46CF932
            925601600498533F0708FDFAF7D11B1801263EB6B2269143EBD6AD8383832172
            FFFEFDBA75EB4243BA16554641E6FFF35F8F3EFF423C401E763DF5EBD7BF78F1
            22442223231B366C688C77D27F094328E8DD42CDDA849077E9E9E9717171D1D1
            D128C01408F50E1859082C5080C90205D89BC7941933D96F738904C849CA8822
            34801C1D657020D519044747191C487506A17781F14A0876A0E584A9D0DBDCE0
            C183495653009DE7D4CF0983070F22590530FC0E7D56F468DD00E60FE004F7FC
            CBBEAE7FA3C389215F5D5DDA2727E531C9693DF47A17151575E1C205502FF40E
            2605C80C45A020A9421F95BA090396C7958BDBE74DADEF39AB91EFB28EFEABBB
            AE5E547FD5FC5FE21F87936433E3E0E0F0E1871FF0763B2F2FCFCBCBB375EB56
            F56DEB75E9DA79D3A680A2A222925601F019F8CFD83D03138F8D5105B7A4E36E
            89C7C7269D80302E19C2C971C9C1E3934F8E4F3939212578622A15DC9F9E727F
            7268D89A01FFB875EB16A9850FC3EFF1E2E2D9B36777EDDAF5C1830703070E1C
            3B762CAF459C80BAF566BDF557F10079D82A6BE2C489FDFAF5032D0D4DB8BBBB
            13AB00E2DE89FF25C32FBFFC9237CE0E7A776CB33621E41DA85FD0A8C78E1D43
            01A64050809900902B7281521616607281524A1660A0AC162C9EC77CFD5D2840
            1EC849CA882234801C1D657020D519044747191C487506A1B40566728C1AC067
            45D16B06307F0027729D6B615E4E91CE3B0F5644AF7770EC031172E0C08100C9
            ECDFBF1F8AE8FD877F864ADD8461CB23EE51E4C6D58E4B67D55F36B76ED0FA1E
            F17162F200A1D9B97AFCEAFE7F5FE9F496AC0045668F6C77F4A8D85BCD864DE2
            CC99D43F11262626DADBDBBFF3CE3B8D1A358A8989E1B59890193366C0EBA347
            8F9A3469F2AF7FFDAB7EFDFAA0F4E82421DEEC47809077D1D1D1E7CF9F877947
            01A6402801067B37071460160006990CB70E1564FC457AF8C623EB1D3052C620
            383ACAE040AA33088E8E323890EA904A485151E1AD9503E83F8073D2E57FC48A
            20884C6EDDBA15191909AA582E870E1D82B2A4963788A2A22212437478FAF469
            6C6CECBD7BF7222222C8C10B510CFC6726387963B04020C3AD03279B1503E910
            6236383ACAE040AA33088E8E323890EA90CA0968B0DB01938E0EFAFADEFEE5C4
            84200882988DC2C2C2BCBCBCFCFC7C7825A7724431E0990941100441100441AC
            063995238AC1A60841100441100441102B414EE5886240018620088220088220
            56839CCA11C580020C41100441100441AC063995238AC1A61041100441100441
            102B414EE588624001862008822008822056839CCA11C580020C411004411004
            41AC063995238AC1E608822008822008822056829CCA11C580EF802108822008
            822088D520A7724431D8EC3F781C836502B9C910359CF1C1800103060C183060
            506020A7724431D890FF236606EE2E223B1035B8E3200882200882204A030598
            6C26C8074AA100D3050518822008822008A2345080C9861654D2410126040A30
            0441100441104469A000938D850458C15312010A327213E7E5675D81085CE5A7
            4C2FC88DA6CCF959AA6441F2F3F33DBDBC667ACC9A3E63E694A9D3DC274F9EE0
            EE3E6EC2843163C78D1AE33662D4E861AE23162C5C44725B1C14600882200882
            2088D24001261BE305D8952B57484C98BCD41DD97143B39ECC2D28C8CE783CA7
            247D6172780D3A29E751DF8CE8C6C9E13FA43F5A405B44D8B96BD7E8B1637D7C
            7DA7CD98317CE42897E1C3070F193A60F0E0C12E43264D9D3A71CAE401CE8349
            56F3C3711C0518822008822008A2345080C9C602022C3F3B3A39DCB6347558CA
            DDB1F9F9796971BB9F5CFCE4E1F9DAB9E957D2A27BE5C60D79993B27FEFCBB79
            39F1A48030F9F9F9DECB974F99366DB4DBD88993261D3F7EFCE8B1E3478E1EDB
            B2756BF7DEBD5D478D76ECDF9F64353F28C0100441100441108583024C36E617
            60F9F05F66D2F1FB671AEFF4EC34A4D16808CB4639ACF5F04F4F4DCD8CDF9270
            AD79764CBBE8E36F274579D205C4C9CCCA9AE83EC963CE6C0747A7E0E060622D
            2C0C0B0B6B6EDFAA77DFBEE4DAFCA00043100441100441148E8DAB4DA3D571E4
            4245B09605AE6C5C83C945DCEA4636348C498198598015643F1E939DE893121F
            E7D6DE6DDBFCED67379C3AE67568F5F03513BBCFA4733CB93931F662DFCC942B
            E9F1A7688B5EE21312060C1A3469CAD42EDD7BDCBD778F580B0B5D86BB0E1936
            8C5CE8A3DEF01D7A03C92A000A3004411004411044E188083095DC727575D5A8
            ADE0603A46A5285782710498B3B33389A9E1586409B0D4E89985F1231322FA87
            1C3CEF357CF9E59DE7BD87AD18DA64ECD0C663F6F91DA6F364A6DC28C8CFA6E3
            D2B975FB76D71E3DC68C1FEFD0D7313D3D9D58E55077E8D6F5C18FFC4F3DDE10
            FC68F9A107B377DC1FEB1F357AC39D11BE91437D6E3BAFBE0519485601508021
            0882200882200A47DF3B60D4A5AED6E2352A055D01C6565C9C4B40E63B60858F
            AF8F4B4F38BD7ECEA6A0B95B8FAE3A3CA1EBF4270FE21FDE7B9C9D295B747138
            7CE448BB8E9D1C1C9DDCC68D2F28282056C9D4760ED41B485601508021088220
            0882200AC72001A668FDC52FC0004E9C41AE00A3993570E1C165FB0326FBAF9D
            B991984C81CBB061835D86FE56A7EE8D1BE1C464415080210882200882200A07
            04982E82028C7C094CC1EA0BE0083080A82E35C4AA46AE005B3169DD80FAAE10
            4EAE3EBAA8BF271DA7C3E2512BD252D3A738CCA62F5D9ABA9132D2387EE24483
            464DDA77EA34DA6D1C315916146008822008822088C231F41D306E2905A12BC0
            00A2BD74D4172057804DED3367CF825DA7561D3DBEF4E0C1B97B9870CCFBF0DA
            09EBE70DF6BCB833F4C0B2FDAE2DC6478445923212484A4A6AD1BA4D4F87BE2D
            5BB7494B4B235639D4705CA53790AC02A00043100441100441148E61DF0113B0
            2A035E0106F0AA2F409600CBCFCF776E3C7A407DD7A99D3D0ECCDDEDD2680CFD
            661784D9BDE6EFF5D8B967CE8E4DEE01C39B8FBB79F116292381828282A1AEAE
            1DBA74F9B556EDCB57AE12AB4C7E71F09E16746F7C40D4C8F5914356DF725A76
            B3E7921B9DE65DEB309704C840B20A80020C4110044110045138720498FA4710
            75F2280B21012684DC77C080A0653B970CF00A9A14C8FCF4FCC99D675C9B8D3B
            3067F7F6A94183ED46859F8FA0ED12D9B4794B3D3BBBDAB60D7CD6AE2326150B
            162D5AB47811B9D0C7CFBD3CF506925500146008822008822088C29123C0347F
            064CB96F7F0166156005050571314FA638CCDEE8E6B77CC80A9F197E60BC1612
            3EA2E5846D538240921D98BB7B5C9B2927779DA1F34B21EAEEDDDAF56DDB75EC
            E4326C38FBC70FEFDDBB67DFA6F500E781E4DAFCA00043100441100441148E0D
            F93F2219B30AB0933BCFB8341C3DA7F7828373F7B877981172E842D48DE8316D
            266D9FBAC57FACDFC4AE337D5CD7044E0818DD6652667A1629234A4E4E4ECFDE
            BDDB77EADCB859B3AB57AFC6A878F0E041585858BF01FD878D183E64D81092D5
            FCA00043100441100441140E0A30D9985580AD9DB971513FCFA0C981B37BCD9F
            D97FC1833B0F47B49A407F070C228971C973862CA12F377B6D27654459E2E5D5
            A255AB814306376AD6AC59CB162D5BB76EDDBE6DFB4E1DBBF7EA3E79DAE4D9F3
            660F1F399C64353F28C0100441100441108583024C36661560937A7A38371A3D
            A5F76CBFF99B73B27288D55072737341713568D4A851B326CD5A346FD9AA55EB
            766DDB75E8D0A94BA72EDDBB74EFD9BD9743CF4993DD496EF383020C41100441
            1004513828C06463BC0043685080210882200882204A0305986C4050C9054AA1
            00D3050518822008822008A234508059081460BAA0004310044110044194860D
            1C8231582610D981A8E18C0F060C183060C080018302033995238AC1869C8511
            04411004411004B138E4548E28061460088220088220086235C8A91C510C3641
            08822008822008825809722A4714834D99A919356A1489290C653A8E5E2B07F4
            5A3928D36B4BF2EB92A4B917FE545A00AF89FF4A02F710E5608CD7E4548E2806
            14602603B71BE5805E2B07F41A310728C09403EE21CAC118AFC9A91C510C28C0
            4C066E37CA01BD560EE835620E50802907DC439483315E935339A2185080990C
            DC6E94037AAD1CD06BC41CA000530EB887280763BC26A7724431A0003319B8DD
            2807F45A39A0D788394001A61C700F510EC6784D4EE5886278D304D811171B1B
            9723E4C2B258C971CA6306CBBB6ED5E98EF6B6238EDBD8794713A325B086D75A
            136D597709B8C22D8895A7DBAAF7B57C583B8175EE0DF95845803D80677EC99F
            BEEACBB012EA1010765393C1DCC1AA020CEE29EB1C0EAC7A3781D7D6B925ACB7
            7332FEAAF605CBCEB9315E537723A224DE2C0106B79B9D8B8B9D52B71B6AB7B1
            F403C66AD3CDD95AA3BDBD2DE8B935BC663F57206E052D62FD156E0DD0EB8A0E
            B51568C6EA888B750ED97241016671E09EB2CEDAB0EADD64B59DC4EA3BA7553C
            37C66BEA6E4494C41B25C028FDE51D4DBF129305B1FA7663950DC74A5E5B436B
            B2B086D7DA936B8D01A8002BDC0AA0D7151B2B6F05068302CCE2C03D8502CC72
            5877E7B4D6BE608CD7D4DD8828093D02AC583EB0FE48CCD2DC5D6A6BBBF4AEE6
            FF16C64A8E1F1A62A3F616A2430EA96296C33A5EC3145BDE5516D6F09A35D114
            561802EBAF706B805E5768ACBD15180C4811A7037F5A3844C033FFD99FD3D597
            479F518780A3673519CC1DC06BE2BF15B0C603528555EF26ABED24D6DC39975A
            6DFB34C66BEA6E4494847E01562813587F246661223D6D6D3D23B56396C44A8E
            EF77A6BFF940E1BC9F182D8775BCB6CE0C6BB086D730D16C9F61082C3DDFB8C2
            2D08DB6B2BB86D25AFE5C3DA0AA85B82C2AA5B8364408AD4DDF8A785431879EE
            6B11B49F9BCD7C01BC26FE5B01B8A7ACB0810056BD9B380F0ECB61DD9DD33A33
            6D9CD7E4864414C39B23C0D867722B1C4EADB9DDB00F2096DE6AADE3B5552698
            8535BCE63C47D9EBDD42587F855B03F4BA42C3DD0AAC3C6ED2B19A00CBFFB39F
            FA32289F3A04A000333756BD9BAC76475873E7DC6F85B3108D315E537723A224
            DE180106771D074B6FB5D6DC6EC84663055D6225AFADACC0ACE1B5F673D41A03
            500156B81540AF2B369C81B2F2B849070598C581B58102CC725879E784FF5B63
            BA8DF19ABA1B1125F1A60830EE26A31C29C2F29C72DAD25BADD51E2DD4F6CA9A
            E2484F4F0B4EB735BC662F71EB3C5BACBFC2AD017A5DC1A1B63DCDDD60E57193
            0E0A308B036BC30A2772C09A7793F56E08ABEF9CD6381019E5357537224AE20D
            1160BA9B8CE51598F5B61B062B6CB4D67CB4A84E5E04CBBA6E0DAFAD3CD14005
            58E156F0DC7A5E5B679669AC795F1B006B8D5873D4E48002CCE2C02A519400A3
            EF0AABDD101561E7A486C0B203608CD7D4DD88288937E84738AC8D321D47AF95
            037AAD1C94E9B525B18A00B37AB0AA00B31AB887280763BC26A7724431A00033
            19B8DD2807F45A39A0D788394001A61C700F510EC6784D4EE588624001663270
            BB510EE8B57240AF117380024C39E01EA21C8CF19A9CCA11C58002CC64E076A3
            1CD06BE5805E23E600059872C03D443918E3353995238AC106960B8220088220
            1603A4883203F11F41106DC8A91C510C6679078CD4AD302E5EBC48624A02BD56
            0EE8B57250A6D79604D7957240AF9503EE9C88745080990CDC6E94037AAD1CD0
            6BC41CE0BA520EE8B572C09D13910E0A309381DB8D7240AF95037A8D98035C57
            CA01BD560EB87322D231A7008B5BDD48F597316D1AAD8E232696916DB56E4E13
            A1B9F1C49BE6EF8F397A6409D45E339EB806ABAE2958DEB1AC2A3B7156B41467
            409852FCD58A56A537A74C0CDC64835DE986051681767FC05CC14689E5355F3D
            461A191BA0EB9456718B6290D72AB8DD36B2B84531EF5CF31A191BC02C005E23
            0D95C4AEB39261BA7555995079AD724DC7036A77ACC4F329066BAE2D05679130
            AB0960EE23DEE7116F4E2D981CECD9E2315AC16B83E17F34B3E01F964AEE3562
            6DF409B043436C64FEF178B500A35634BD50A9454AD6A7668F55AD5C3A6ADD9C
            26437DE30936AD6354994DDC0B4B437BCD8CAC6688B951DA7B0A1801FA42A814
            CF40694AF1572B5495B49CB2316493A5FC217DE0ED25A73F15709418AF79538D
            3452174C5C0B2A172B9FA531C06B15DC6E1B59DCC29875AE798DD4051367E035
            52504559852B1FA65A57950BE2B58E57BCA6370666AE2D85CE2201036770059E
            473C39B561F2720AE91A2DEEB5A1080D051BB0EB982BB7D74805404480457BDB
            D9D80C19E26C9800D33A18C2FA54ADEF0A68341DE4C693D3B4E93B617168AF35
            7E309E6AF9C6F61FE274022B07932E30509A52FCD5F255253DA77C8CDE64996E
            08F5072E843368E564FBA92EC5B66972F355253DA7C66BDE54238D6CAB062A1D
            44A1AB2B93CDF2C8F79AB7DB4616B734E69C6B7EAF59560DBC46AA90B5C7C778
            4CB4AE2A192CAFB57DD031BC49A8BDB604BC8B84F73E62A149979E53EF72B5A4
            D7A6837F00F8AC6F92D78875D0FB11C443A614606C2B9FCD0A394D07B9F1789B
            16EC8FA93B617168AFF9BC6303462647B02BE3BDD48152C579864A5DAD602906
            E9392561E4264BF5826E59AFBFBC19F496D242BAEF7A72CA5EE1D28D9495B4C2
            262E3898246A8A581AF9F7355FB78D2C6E71CC38D7BC46CA4A47D8F01A2BC4F8
            188F69D6556583D939C12BB6131A27DF4418AF2D00DF22810BB1D1A5F2AA9798
            9E338956B57A96AB25BD3615ACA160C3372C6F90D788B5309B00636DB0D442D5
            6CB6F4950D6B955B37A7C950DF78BC4D0B191B35A2FB638E0E5904DA6BDE9D88
            817299B141BA6620744BF10E14AB140B4DB5FC5569909E5322866FB2B4574CBB
            42FD61FCE5CF001156BAA5468978CD9B6AA4511511BC17B48A581AD95E33B053
            8D2C6E71CC38D7BC4655446701F01AD568D553F930CDBAAA6C68764E704BC4C7
            370B8DD716436709F1DF475436B65138278D9CE56A05AF8D813B146CF886E5CD
            F01AB12AE61360CC82868519AC5EAAB04CC93A5525AA97AF75739A08CD8DC7D3
            349F91B2909B56D53713F7C732D05E335EAA1C619CA2E00CB5C64F2A81AF14DF
            E8E98E8E56B54255A9909E533AC66EB2D032DD0D81FE68FC15EAB0CA2B0B8F12
            F19A37D50446D28ACAC86450A155C4D2C8F69A819D6A64718B63E6B9E635AA22
            C4A8CAC06B64D0AAA7F2619A7555D960ED9C2C37745C7CC360796D29D88B848A
            0BDF4700D868A3DE9C5A6B4F3D6DBC46AB786D3CCC50B0E11D9637C96BC44A98
            538069D073A3B2B06E4EA3E0BBF144FBA385E9FB631968AF8506961A722DBF20
            559D53FAC4B14BA9E0562B5C95F49CB2307A935537CDDF1F96BFFA3BCC574A85
            74DF25E6245EF3A61A69D442C7A855C4D2C8F69A819D6A64718B63C6B9E6356A
            21CDA8554FE5C334EBAAB2C1DE39193F78E7FB4D82EDB585105C24D26E2E0A3E
            A39CE56A05AF4D00EF50B07923BD46AC83450418B3520596AC06EBE6340E9E1B
            4FAB4535BC4633F4C732D05E6B3ACFF28E8A723C052F350696CBE203A5558AAF
            5A81AAA4E7948BD19B2CD30DBEFE68F9ABAFC3FCA564F82E3DA7DA6BDE54238D
            6C581968F8B35908F95EABD1B21859DCD29873AE45BDA66065D0A063E42F5B69
            30D1BAAA6468ED9CB423957C1EA5A0E5B565101C55693717853EA3A609FEE56A
            05AF4D00AFD76C980C6F92D7887530EB77C0C8EA84987A7152EB94B652319DBB
            D71A394D86EE0395D5349F91954C7588A4573268AF1957343E69065B03D8D40E
            53F094A2A2DC81D22AC5572DC05395F49CF231649365B7077D53774DB73F1576
            9418AF79538D32B293598343A03AA94EB53806784DD0EEB691C52D8C19E79AD7
            C84E661600AF91C1AAE3633CA65A57950BED9D93F284FA6E4D65F5462ADA5E5B
            04F622E1BD8FA41BB5E15D99BC462B786D187ABD16C850B9BD462A00E67C078C
            5A95E47B2A9A050DCB57D76ADD9C264273E3F136CD67D47487B97D2B1B6AAF19
            F78823CC3583EA9F3A39C3CE2D45C11D28AD527CD57252443AA04AE06D542686
            6DB202D3CDE94FC51D2596D73CA9461A0506470595A663B4140679AD82DB6D23
            8B5B14B3CE35AF91770154D855613CA65B579509EECEA9F2B212CFA234B85E5B
            00ED4522FDE6E235C22CB19E495297AB15BC3614BD5EF366A8EC5E235647AF00
            2B26BA4A327CDF015304CABCF1D06BE5805E2B07657A6D49705D29874AEF75DC
            6A57ED7F1494027A8D20E2A0003319F868510EE8B57240AF117380EB4A395476
            AF0D5222E83582E8010598C9C0478B7240AF95037A8D98035C57CA01BD560EB8
            7322D2B101BD647260092208822008822008A217722A471403BE0366329479FF
            A0D7CA01BD560ECAF4DA92E0BA520EE8B572C09D13910E0A309381DB8D7240AF
            95037A8D98035C57CA01BD560EB87322D24101663270BB510EE8B57240AF1173
            80EB4A39A0D7CA01774E443A661560CCDF4E60FFE504E38C9A3FC7C0FE5B4946
            36641AB8371ED59435FB631970939501F35743F4AF5E9599E4E2CBC0D8D83501
            4C2926037F313E9BBE9C2CAFF9EA318791B1011C4F2D85415EABA0520CF25AA4
            4E4B6185B996615441A5E8182B0F9A11665C642F7171A395EE05E3215E57F2B9
            930BEB6E323F329E32D28D6CA496B2A8D726817242C06BDE51659C06D4E6CAE7
            35623DC404D81117B2B46C3D2389BA920023C0A815AB5ACC4CC468A326AA5AF9
            5CABBEE2FC4653A17DE3512DB0DBB07C7F2C83DA6BBE4D99B53D69390776B25B
            8996E21C329852FCD58A56A537A74C0CD964A966D52EB1E65B680D40763A375F
            062AAA190C9E52BC7905AB929653E3356FAA398CD40513B7120678AD8232B04D
            D28BF31A2D8CE5E75ABA510565E0982A17EA11D678A6DA98E8A8A091F7AEAF44
            10AF2BAF0306C1DC4D66871A58B287B3EF1926CAB2C930B2915ECA725E9B06AA
            EFFC3E0B8C2A15D7C95ED9BC46AC89B0008BF6F63E42BF03B6DF598E04530B30
            589BEA25ABD96D8D336A52012683910D990CE6C6A3EA8627A5AB2B5F6F2DD71F
            CB407B0D9ED0DD67223A51B5A72A5FE90BA152742A6748D4A5F8AB15AA4A5A4E
            D918BDC942E3CC18908E693BCC1E249D0C5A395919D883C4D834B9F9AA929E53
            E3356FAA398C6CABD590EFB52A6AF80EC05FA785B1F85C4B37AAA2DCE1AD7C90
            1166F9A5F157BAB1B2C1E7F59B8FFA6EB230CC22E1BD8FA41BD9C8286525AF0D
            81EAB5D42D45E32CCB6D0D95C86BC4EA48F90862A4A7AD7C01A675F7AA17AA91
            46B695CF66509D2683B9F1E28283B91DB3467F2C03EDB5A6F38C535A0E71C682
            4E60E560D205C7445D8ABF5ABEAAA4E7948F919B2CD532DD0BAD3EB07B1CEC2A
            92416F292D20832AB76029063D3989D7D2BB64A491B2D2116B22DB6B301BB303
            08D469612C3DD7D28D60D61DDE4A887A0F61B9C17291C728301A950BBE75F5E6
            A39E6B8B428DB1C8CA916E6423A79455BC360CE95B0A9585F807519DF1A9545E
            2356478A00DBEF6CE3BC9FC82BFD9853800154028596C1C83A4D03F7C6633767
            8DFE5806DA6B7D8E8091C95111A5855C0CDF64A90EB096AF507F204A9BF933A8
            DD51D7477230A5585019E842426DA9D19B9378CD9B6A0EA32AD288BEDF89C50A
            C8F69A819D2ABDB8789D96C2D2732DDDC8A0955AF960ED2194273A6B5CD70823
            401CA6D32AA3F37CEBEACD8735D71681AC1DF5D2D11A6D23EE38404E294B7B6D
            3C5A8EE840A5B26F48CA53DDC753E5F31AB11EFA0598BC0F209A57804184C454
            F7822A83B1759A0CEE8DC76ECE1AFDB10CB4D7E28E508E323648A7F3F2BB0F11
            56BAA5A4855C8CDD64192F05FAA37157A8C3949DDEF883991C9A526A54B9D436
            51DFA5E4245EF3A69ACBA88A102393C1A2C8F69A819D2ABDB8789D96C21A732D
            CDC8A0955AF950EF21E017718C728878C46B24179CBBBE72C1B7AEDE7CD4736D
            59A845A41A64ADD116BDB9788D6CE494B28ED7C6A0E58800E01F9D87CACC8C0F
            5849C1CAE735623DC40558F4525B79EA0B30A3003387D174706F3C7673D6E88F
            65A0BD167184F252934A25930B21F7550538870C4D29355AD58A8EA4F49CD231
            7A935537CDDF1F96BBFA3BCC574A85CA71567EE1AA24E6245EF3A69AC3A805AF
            D112C8F69A819D2ABDB8789D96C2D2732DDDC8A0955AF9307C5D51F01A2B017C
            5EBFF910AF2D8DE872326CE1C9296525AF8D40CB1121F886A5527B8D580F1101
            16ED6D67B7F4AEC13F43CF5AA69A656D9C51EBF6603218D990C9E0DE78FCBDB5
            5C7F2C03ED35BFA7B45BAC4B55AA3AA7D0F868608CAC522AB8D50A57253DA72C
            8CDE64D9AEA9FBC0F44DCB5DBE0C6CF84BD18E7332F357253DA7DA6BDE547318
            D9B0325816F95EABD1B2482F2E5AA7A5B0F85C4B37AAD1B5542AC8086B79A1F6
            97D7C8A6D2FACEE7F59B8FFA6EB230CCCA917E73F11AD9C8286525AF8D80DF65
            0E2C6735688C95CF6BC47A080BB0232E362E478CF93B60B024E9C5CC448C3652
            F707BDCCA998DA2AB938BFD154706F3CED9BD9F2FDB10CB4D7BCFB2F7B8E08E0
            A7C600173CA5343046AD527CD50A54253DA75C0CD964A165A639685ADD0BC6CC
            442091DD2DDD0CAA2829CF5F8A724DDD000B9EAAA4E76479CD9B6A7A233B9935
            6216C600AF09D4D86A4CD28BF31A2D8CA5E75A8E91A03DBC950EF5086BEE402A
            463CE235C218907B8067342A09C4EB4A3E777261EE26B3C35E1930C8EA3D93F7
            3E926E6423BD94E5BC361542CB92ED1533AABCC6CAE835623D040558B4B79DEA
            836004E91F44640418BD4255B0D7B47146EA0EA151AF770A231B320DDC1B8F7B
            335BBA3F9681F69A7243E5011351B9CF9E230AB0719DE794A2A2A41463D42AC5
            572DC05395F49CF2316C93A57A4460374C758465845C9C6E7332A8606C24AF56
            292691415D925B95F49C00CB6B9E5473180546CCA218E4B50AAAF77A73CAACD3
            52587EAEE518557087B792A11961CD2A67DDF8BC466630383B44E58178CDBAB1
            692AAD439260DD4D668735B426BBE3C0C4B70AF594B2A4D7A6417B4B617BCD3B
            AABCC6CAE735623DF4FF0807D1559261093065A1CC1B4FED3577FF65AE195C83
            61BFE23C67F9B672C646F26A95E2AB969322D20155026FA33251F65C2B0BF41A
            3107B8AE9443A5F73A6EB5ABF6935B0AE83582888302CC64E0A34539A0D7CA01
            BD46CC01AE2BE550D9BD364889A0D708A207146026031F2DCA01BD560EE83562
            0E705D2907F45A39E0CE8948C706F492C981258820088220088220885EC8A91C
            510CF80E98C950E6FD835E2B07F45A3928D36B4B82EB4A39A0D7CA01774E443A
            28C04C066E37CA01BD560EE835620E705D2907F45A39E0CE8948070598C9C0ED
            4639A0D7CA01BD46CC01AE2BE5805E2B07DC3911E9985580317F2681FD7BDFC6
            19353F2ECEFA417326233BAB74A389D0DC784C2BEC1F5D1737026C7BE581B5DD
            30CEB0865668C0C14EFC152DC51913A6147FB5A255E9CD2907033759DED52BD4
            193057B021D233D76631AAA052748C96C220AF5570BB6D64718B628DB9966E54
            41A5E8182B0FA65B57950995D72AD7743CA076C74A3C9F62B0E6DA82E8AE13AE
            85778DF11A59E83B833166EB786D18ACFEF3BBCD9F8167AC2A93D788B5111160
            9A3FC5ECBC9F882B2930028CD94FD91BAB51466AB5AB6F6E8D9555888AD219A4
            1B4D86FAC6D3544DF557A73D96516566E2951366BB61069789E84435030E83C0
            9912DEAC5A63A529C55FAD5055D272CAC3904D9672867480B78B9CCE54C02112
            9D6BB3185550068EC99218E0B50A6EB78D2C6E612C3FD7D28D2A2803C754B930
            745DD19E5756C789D7BA5EF199DE1898B9B620AA65A235A25C0B33E2ECA1E735
            6A10788A51719DCCD6F0DA30589E5051B5831AF8333056567225F21AB13E2202
            ECC89123AA77C0223D6DE54830B5008335A95EC79A43A2914636EA0CAC8C9AAC
            D28DA683DC785A15AB9BE435727A5439516F372C57186705071CE274025F2981
            B1D294E2AF567A07F872CAC4E84D96E9835067E0423883564EB693EA526C9B26
            375F55D2738ACFB5598CAA283CEE5C5D198BE591EF356FB7DF78AF2D665445AD
            3D3EC663C0BAA2A0521A555EC7595E6BFBA0637893507B6D21746F10BE5B46E6
            C2E3419399554C8385BD361CADDEF3B9CD9F817FAC2A8DD7480540CA4710F73B
            1B20C0B496B17AA51A696441A5736D00E4D4145323DD6814E4C693E10E58797C
            A85C8879AD057BC0835D9901903A56AA38CF68A9AB95DE01FD39F563E4264B75
            816E56AFB3BC19F496D242BAE37A72CA5EE1461AC11C1C4CFD5F2BD5D2C8BFAF
            F9BA6D64718B63E9B9966E047305181FE331605DA9125C832BB3E3CCCE095EB1
            9D603BF9E6C1786D19746F102377245EA8BC241DA23C392DECB589E02C4C5DD4
            1904C6AA727A8D580709024C9EFE32BF00A392A87FCDD158D450293A66E94623
            51DF78D05BD275BAA7AAB89091FAC74C15A6EE8DA5205E535E09CC970AAD0187
            74CD58E896E21D2B5629169A6AA577405F4E2918BEC9D22E318D0A758671963F
            034458E9961A22B1B9368791412BD5D2C8F69A819D6A64718B63E9B9966E64D0
            4AAD7C18B0AEC04CC52AB3E39A9D13DC1299DC370B8DD79644779DB02DBC6B8C
            D7A80B958DF51453E5D43DC958C76BE3A03C135D899A0C02635519BD46AC8598
            00235F0293F50D304BBD0346D9341928A812DA1640BAD17834379EAA01D55614
            AC7143D7485918BFC01FD377C90210AF295F98FE73E78B33E01A57854AE98E15
            DF0069552BBD03A2392562EC260BCDD27D10E88CC659A1DEAA5CB2F01089CDB5
            398C0C5AA99646B6D70CEC54238B5B1C4BCFB5742383566AE543FEBAE27D57BC
            92C1DA39596EE8CCED1B06CB6B0BA2BB4ED816DE35C66B1402D2E9CC54292627
            58490DD6F1DA08283F34EEF3A0954160AC2A9DD7881591F60E988DAD6724D157
            7AB19000D33652D975F248379A04BE1B4F7FCFD5F01A2B01C46BE1F9D2197048
            55E7142EA58631B24AA9E0562BBD03FA1BD58FD19BACBA5DFECEB09CD5DF5BBE
            522AA43B2E31A7D85C9BC3C8A0956A69647BCDC04E35B2B8C5B1F45C4B373268
            A5563EE48E30FC8F982AB3E3EC9D93F143676ADF34D85E5B0EDD75C2B6F0AD31
            7EA320BC193446EB786D2894EBA2FE7233088C55E5F21AB12E52BE0326EF4388
            96FE110E3A5D278374A3A9E0B9F1787BAECF9DCA85DA6BFEF9E21970C8A831E8
            9B65C6A8558AAF5AE91DD0DBA8048CDE64993EF07546CB597DBDE52F25C371E9
            3945E7DA1C4635BA160B22DF6B355A9637DE6B8B19D5E85A2A153247182C5C2A
            A3F35A3B27ED5A259F472968796D31740756CB22FF8EE3C2CAAC4163B48ED706
            41F92AEA2C5F06FEB1AA445E2356475880513F82C8FC0887FC77C054CB935E93
            4CC458233B19563CBDF8A9A5AFB30B48379A0EDD072AABBF7C465E772A1BCC76
            C378A3718B6FC0C1A6F69982A71415E58E9556298179E4A94A7A4E9918B2C9B2
            1B838EA9FBA5DB990A3B4462736D1E2381EA24C764390CF09AA0DD6D238B5B18
            CBCFB57423C1AAE3633CA65A57950BED9D93F2A432FFA6A354B4BDB614BAEB44
            DB227BE1016C2BD4463F3A788DD6F2DA0054CB50F721A8412003EF58551AAF91
            0A80B000D3FC193079DF02630418BD2C55B0EF63A38CD48D4020462613032448
            379A10CD8DC7B4C4BE67F98CBAEE543A58DB0DE3A1C8D4B0B66702B7140577AC
            B44AF155CB4911E9802A81B7513918B6C90A4C37A73315778844E65A85398C2A
            A881D3315A0A83BC56C1EDF61BEFB5C58C2AAC3A3EC663BA755599E0EE9C2A2F
            2BF12C4A83EBB565D05D2786EE4860629E2E541D044D065EA375BC960FE33003
            ED03E3B55006DEB1AA2C5E231501491F4194054B80290B65DE78E8B57240AF95
            8332BDB624B8AE9443A5F73A6EB5ABF63F0A4A01BD4610715080990C7CB42807
            F45A39A0D78839C075A51C2ABBD7062911F41A41F48002CC64E0A34539A0D7CA
            01BD46CC01AE2BE5805E2B07DC3911E9D8805E3239B0041104411004411004D1
            0B3995238A01DF013319CABC7FD06BE5805E2B07657A6D49705D2907F45A39E0
            CE8948070598C9C0ED4639A0D7CA01BD46CC01AE2BE5805E2B07DC3911E9A000
            33199A1B8FF94D56F6CF898B1B01B6BDF2809BAC7240AF958332BDB624B8AE94
            037AAD1C70E744A4635601C6C80BCD1F4930D6A8F98B0C2CBDC292319AACD28D
            26427DE3515DA43B47B5469AE135AACC26EF8765616D37CCE0B25C121A70B093
            09142DC511A54C29FE6A45ABD29B530E066EB2BCAB57A83360AE6043A467AECD
            625441A5E8182D85415EABE0765B7A71E13A2D8535E65ABA510595A263AC3C98
            6E5D5526545EAB5CD3F180DA1D2BF17C8AC19A6B4BC15D24D2D718AF918DD452
            56F0DA60F81FCD6CDE44AF116BA35F80457ADADAD87A461279A51F468031FB29
            7B6335CA48AD76F5EDA1B1B20A51513A8374A3C920371ED549D288AA19552BBC
            4676ACD2C26C37CCE032119DA8C657180FFA42A8149DAA356C9A52FCD50A5525
            2DA73C0CD9642967480778BBC8E94C051C22D1B9368B510565E0982C89015EAB
            E0765B7A715EA385B1FC5C4B37AAA00C1C53E5C254EBAA7241BCD6F18AD7F4C6
            C0CCB5A5E02E126670D9A32CDDC8467A298B7B6D28028F66366FA0D7480540AF
            003BE40C37B221020CD6A47A4D6B0E89461AD9A833B0326AB24A379A0E72E369
            55AC6E92D74859351DAAA4A8B71BD6E032CE0A0E38E3385F297646AD2AD4A5F8
            AB95DE01BE9C32317A9365FA20D419B810CEA09593EDA4BA14DBA6C9CD5795F4
            9CE2736D16A32A0AA2D0D595B1581EF95EF376DBD8A1B030169F6BE94655D4DA
            ABC2784CB4AE2A192CAFB57DD031BC49A8BDB6047C8B44FA1AE35F782C6494B2
            A4D7A683E58B8637DE6BC43AE811607797DA3A7B7ADA1A20C0B4EE5EF54A35D2
            C8824AE7DA00C8A929A646BAD128741F2D5427495CC8D8A8117505F038532920
            5EEB9B2FED010F76A5D3794B0956A52EA585BA5AE91DD09F533F466EB25417E8
            66F53ACB9B416F292DA43BAE27A7D85C9BC308E6E060EAFF5AA99646B6D7BCDD
            965E5CA04E0B63E9B9966E0473055815C6639A7555D960764EF08AED84C6C937
            11C66B0B60DECD474E294B7A6D2A2857749C7EE3BD46AC85A8008BF6B61D72A8
            30B28209302A895FB150293A66E94623D1DC78A487D04230C4881BBA46AD4E80
            8F8CBF9509E235E58BC07CA9E0F795BF144458E9CC639A6F8434D54AEF80BE9C
            52307C93A55D621A15EA0CE32C7F0688B0D22D354462736D0E238356AAA591ED
            35033B557A71F13A2D85A5E75ABA91412BB5F2619A7555D9D0EC9CE096888F6F
            161AAF2D067B91485F63E20B0F9053CA0A5E1B03E505EBD1CCE60DF61AB12A22
            022CDADBCE6EE9DDE20A27C068C0A6C9404195D0B600D28DC6C377E3F1F55C86
            B11240BC169D2FCE804332B9102AA52AA0DA0B350A56534A8D56B5D23B209A53
            22C66EB2D02CDD0781CE689C15EAADCA250B0F91D85C9BC3C8A0956A69647BCD
            C04E955E5CBC4E4B61E9B9966E64D04AAD7C98665D5536583B27CB0D1D17DF30
            585E5B0AF62291BEC6788D6CE494B282D7C603DDD7F8A2E68DF71AB11282028C
            925FDED1D4AF20564C01A66DA4B2EBE4916E34093C379E96176A788DFC3E5602
            88D75A4E894F0DA4AA730A9752C31859A55470AB95DE01FD8DEAC7E84D56DD2E
            7F6758CEEAEF2D5F2915D21D9798536CAECD6164D04AB534B2BD6660A74A2F2E
            5EA7A5B0F45C4B373268A5563E4CB3AE2A1BEC9D93F143C7C3370DB6D71682BD
            48A4AF315E231B39A5ACE0B50950A6D78875101260475C54FFBEAE41B206B3F4
            8F70D0E93A19A41B4D85FAC6D3740C62EAD6F88CAC64AA676A772B17BA5EB3E7
            8B67C021A3C6C05F4A0363D42AC557ADF40EE86D5402466FB24C1FF83AA3E5AC
            BEDEF29792E1B8F49CA2736D0EA31A5D8B0591EFB51A2D8B8986C252587CAEA5
            1BD5E85A2A15265A57950CAD9D9376A492CFA314B4BCB60C5AA36AA23B8E4246
            292B786D0258BE6878E3BD46AC839E1FE130FC1D30D5F2A4D7241331D6C84E86
            154F2F7E6AE9EBDC30D28DA64373E351FD54C16E8DCF48F588A0F6ABB2C178CD
            335F7C030E36B6AB3CA5A82829C518B54A09CC234F55D273CAC4904D96DD1874
            4CDD2FDDCE54D821129B6BF3180954273926CB6180D704ED6E4B2FCE6BB43096
            9F6BE94682555785F1986A5D552EB4774ED5EED3A8524FA324B4BDB60866DB7C
            A497B282D786C1EE348C1BCFF3F04DF41AA900985180D1CB52475D1865A47615
            02313299182041BAD18428F3C66379CD9D2FBE01D7DDDEB8A528181BC9AB554A
            781EA5744095C0DBA81C0C9B6BDDD5AB82D3998A3B442273ADC21C4615D4C0E9
            182D85415EABE076DB14436129AC31D7D28D2AACBA2A8CC774EBAA32C1DD3955
            5E56E2599406D76B0B60D2CD074CAC6792D45256F0DA50A8D12228C86BC4EA48
            10603261093065A1CC1B0FBD560EE8B57250A6D79604D79572A8F45EC7AD76D5
            FE474129A0D708220E0A3093818F16E5805E2B07F41A3107B8AE944365F7DA20
            25825E23881E5080990C7CB42807F45A39A0D78839C075A51CD06BE5803B2722
            1D1BD04B2607962082200882200882207A21A772443154C477C0F2BEAE460772
            5D4950E6FD835E2B07F45A3928D36B4B82EB4A39A0D7CA01774E443A154E8031
            EAABD26930DC6E94037AAD1CD06BC41CE0BA520EE8B572C09D13914E0512601C
            E9C50E2447C506B71BE5805E2B07F41A3107B8AE94037AAD1C70E744A4535104
            184771E90692AF0283DB8D7240AF95037A8D98035C57CA01BD560EB87322D211
            1360D1DE76E4AFCCD938EF27F24A3F0608308ED6120A24774505B71BE5805E2B
            07F41A3107B8AE94037AAD1C70E744A42326C08EB8D80C3964F677C0382A4B3C
            90321512DC6E94037AAD1CD06BC41CE0BA520EE8B572C09D13918EB800B35B7A
            D78C028C23AE9840922564A850E076A31CD06BE5805E23E600D7957240AF9503
            EE9C8874440498E61388B69E91445D4940A200E3682A269064359C542690E48A
            046E37CA01BD560EE835620E705D2907F45A39E0CE894847CA8F70EC779623C1
            A408308E9A620249D68693870924B9C280DB8D7240AF95037A8D98035C57CAA1
            827B6DA63315CE358288234580C95360E2028CB9D57503C9C10727273B901C15
            00DC6E94037AAD1CD06BC41CE0BA520E15D96BF31DA870AE11441CA9024CFACF
            208A0830CEADCE0492AC0F4E292690646B83DB8D7240AF95037A8D98035C57CA
            A1C27ACD394AD181A4190DCE358288234180457ADA9AE223889C9B9C0924591A
            9CB24C20C95605B71BE5805E2B07F41A3107B8AE944385F59A738E620249368E
            4A34D7CAF41AB13A2202EC880BF90D0E397F054C408031373627906439706A60
            0249B61EF868510EE8B57240AF117380EB4A39544CAF3927287620398CA3B2CC
            B5691DC79D13918EA48F20CA8223C0D88B9B1D48B2A1706A630249B606F86851
            0EE8B57240AF117380EB4A395440AF390727DD40F21941A5986B8ED7104882A1
            E0CE8948C7BC028CB3B29940928D8353271348B2C5C1478B7240AF95037A8D98
            035C57CAA1A279CD39324110321A43C59F6B8EBF4C20C906813B27221D330A30
            CE9AE6043A8F6170AAD20D249F65C1478B7240AF95037A8D98035C57CAA14279
            CD392CD141C46E30157CAE399E7202C9241FDC3911E9D8805E3239B00439AB59
            28404EB9706A100A2437822008822088E2E11C93E840D2F4A5BE49707CE40D24
            AB0521A772443198E51D30CE3A160FA423D2E094150FA48CA550E6FD835E2B07
            F45A3928D36B4B82EB4A39541CAF3967240824410D27150249904F859D6B8E83
            2281149003EE9C88745080990C7CB42807F45A39A0D78839C075A51C2A88D79C
            03120492A00D270F049220930A3BD71CEF2088DB65813B27221D737D078CB38E
            4502DD0F8970CA8A0452C082E0A34539A0D7CA01BD46CC01AE2BE55011BCE61C
            902090043E38392190043954CCB9E6F8058124A8E02441200992C19D13918E79
            7F05911763D6B73165CD0D3E5A94037AAD1CD06BC41CE0BA520E56F79A7370A2
            0349138093190249904C059C6B8E471048020B4E060824411AB87322D2D123C0
            0E0DA1FF14B3AD6724D1577A4101A628D06BE5805E2B07657A6D49705D2907EB
            7ACD3935D181A409C3C94F0792268D8A36D71C5FE840D2587032D081A4490077
            4E443A6202EC888B8DEDD2BB445749060598A240AF95037AAD1C94E9B525C175
            A51CACE835E7C8440792A60F4E293A90340954A8B9E678410792A603271B1D48
            9A3E70E744A42322C08EB8D879DFC58F204A061F2DCA01BD560EE835620E705D
            29072B7ACD3932412009D2E094854012245071E69AE3021D489A009CCC742069
            A2E0CE89484758801D71B1717191FF09441460CA02BD560EE8B57250A6D79604
            D79572B096D79CF312049220074E0D1048823E2ACE5C73FA0F812488C2294207
            92260CEE9C88744405988DDDD2BBD43B60FB9D65483014608A02BD560EE8B572
            50A6D79604D79572B08AD79CC3120492201F4E3D104882281564AE393D874012
            24C02908812408833B27221DF177C08E905F410405E6BC5F25AFF483024C51A0
            D7CA01BD560ECAF4DA92E0BA520E96F79A7352A20349930FA71E3A9034612AC2
            5C73FA0C81244886531C02491000774E443A28C04C063E5A94037AAD1CD06BC4
            1CE0BA520E16F69A734CA2034933144E6D74206902587DAE39BDA503499303A7
            060824810FDC3911E988FE0807F90862A4A7AD74FD85024C59A0D7CA01BD560E
            CAF4DA92E0BA520E16F69A734C8240128C8353271D481A1FD69D6B4E3FE940D2
            64C2A9840E244D07DC3911E98808B0B2B2686F5BFA4738A4CB2F14600A03BD56
            0EE8B57250A6D79604D79572B0A4D79C33120492600A38354320097C5871AE39
            9DA4034933084E55742069DAE0CE89484754809595918F20CA010598A240AF95
            037AAD1C94E9B525C175A51C2CE635E780048124980E4EFD1048820ED69A6B4E
            F7E840D28C8053211D481A0BDC3911E9585F801913488D15037CB42807F45A39
            A0D78839C075A51C2CE335E7744407926652384D402009DA586BAE397D834012
            8C86532D0492C002774E443A28C04C063E5A94037AAD1CD06BC41CE0BA520E16
            F09A7334A2034933359C56E840D2585865AE39BD8240124C04A7720824410DEE
            9C88746C402F991C5882227096AF3181D4882008822008A23C38E7223A9034F3
            C0698B0E24CD7A70FA03812498144E13104882D1905339A218F01D3093A1CCFB
            07BD560EE8B57250A6D79604D7957230B7D79C73110492604E382D4220096A2C
            3CD79CCED081A499144E13742069B8732272B0820003386BD7B040EAAA30E0A3
            4539A0D7CA01BD46CC01AE2BE56056AF39E7220824C1FC70DA854012545872AE
            39DDA0034933039C86E84027E1CE8948C73A02EC8D041F2DCA01BD560EE83562
            0E705D2907F379CDD10022811430144E6D228114B0E05C733AC01B485623E054
            C81B201BEE9C88745080990C7CB42807F45A39A0D78839C075A51CCCE435E7F4
            AF379062F2E1D4A337D0A52C36D79CD645022920134E25220132E3CE89484750
            80457BDBD17F84598DD43FC65CF105D86BBFEED4DDD231E0F59FA1C55F4F7D41
            CCC6A2BEF112CA3BC2AD28A55A685D4A4EBA4289759A10BADDEEE5F1E49A1733
            6F37ECC194385CE643D30153782D7D9D0092E6C2DCC8F45A6E9F2B848FBA28F3
            81AA4CAF2D09AE2BE56026AF9973BFC4408AC9845389944017B4CC5C739AD61B
            4831C9708AEB0DB87322D291F40E58A4A7ADAD6724ADAFF4224F80854CD5AC5D
            4A11590038E75187BC17EEAA46DD4389D968D4379EF483B5244541CBC5E21072
            6941241D88CDBCDDB007D31801267D5244400126CB6BB97DAE103EEAA2CC07AA
            32BDB624B8AE948399BCD69C9DA405524C269C4AA404BAA065E69AD3B4DE408A
            4986535C6FC09D13918E1401B6DF59F2DB5F80740146DE89524B20B82CF24BA0
            E3951133DD7828C08C164E80A9EA2198C26B595DAA10E244A6D772FB5C217CD4
            45990F54657A6D49705D2907F379CD9CFBA5045246269C4AF40652CC8273CDE9
            8078206524C3292E1E203FEE9C88742408B0FDCED2DFFE02240B30E13734586F
            8B31928CBC610541F39E155D031D74CF6D546A915FA8EA5447058D86E1AB5F5F
            6DBC1DA08F8CA448EC1EFAC6D33E58F3B745C3CEC9DF5B4DA310C83B847CFD8C
            0F28A28A07A892A6BE20975AB53155E91907C6D8716A31559C190AFEF121DB8D
            AA45F5C8B04ED2127BC240D7A349650F91F6C0924B3A6875526718D9399961E4
            2D4E4327A98D7497A8529A0E5CBCB88677BE28382E088D0CAB360A53CC8506FE
            5527524AC86526890EF6EC0EF0BB2FD867763DACD665F9A8EA98669DAB6C7CE8
            1B1F39E091113107B8AE9483B5BC56EF812410AB4C0CAEA482CCB5C1FDA7915B
            1C774E443A7A05D85D391F3FA4902AC0E8839746CCA8813396D6C94F75CC5265
            A68F92AFFDA6AA4E54F4198B3E84691F1F09E410A63A1AB232F3D6AFB7369E0E
            B08BD3A26220ABB8485B0CBA1DD0E92DF71D30817ED22766261BB9D44A52755E
            DA38D0767232A6C741A05D66BBA15B1110607A7AA281D53AC4A908BB6F42717A
            F0E9385DADEE306AE5172E4EA0C79C4817CDD46B4AD1028CAF211D17844686DD
            0713CD0541A436E1527A5D06EE38716A13755FABCF5AF570E74BBA8FEA25A4BE
            1D7811286B28786444CC01AE2BE5602DAF553BAA2610AB4C0CAEA482CCB5C1FD
            A7915B1C774E443AFA04D8DDA5B6323E7E48215180D1073E1E01C6427550531D
            9EE8C3193956AAD09C1129B48E8F04D6D98E5D150B4EFD62B5E97640EB604D32
            A8CE855A674D06BE0EB0730AF696EE0C39710AF593EE0CD33DAD4BDDB3AFC471
            601D5E85C7876C375AA3C12A28AB27DAADA8601761C505075F6818B59A162EAE
            86D56DDE4A8800D36D48D705A191E174498D3173A18B50C7784AF1BAAC3D5017
            570D845262E32CD467A10197EB23AB9382E8F55426786444CC01AE2BE5602DAF
            61EB6307629589C1955490B936B8FF34728BE3CE8948478F0093AFBF8C7E078C
            9CE798A03A906919A9332BF75CA57DEA5221286974EB97501BB703A4FFDA4175
            36D53A58F3FAA2869D53920013EC27E780AB754ED5ED8FC471D01C8845C6876C
            375A1D609DA4A5F58486EDA91A7611565C70F0A50930C1E20C4C7E76859A4A84
            04188F0B4223A3DD2593CC0583BEDA784BF1B92C739C85FA2C548F6C1F39EB9C
            0F29E3230B3C3222E600D79572B096D7B0F5B103B1CAC4E04A2AC85C1BDC7F1A
            B9C571E744A4232EC0A297CAFCFC21205580D16729E64CAC863E3FD14758D601
            9AA0395D699FABD8A5D4889D11B9F5EBAF8D20D401407DE3690ED6FC6D69D0E4
            9428C004FBC939984A903DFC7DD3AA9F7B80E61D1FE2B590CC90D01306BA5AF6
            906A1761C575065F8DD0306A352D5C5C03F1D18FEABFF6805095880B30AD9A85
            4686559BA9E68246426D3CA5006264BBAC5D8AF568111867697DD6202DBFA6B7
            9C75CE8B50594351E603158F11E606D79572B096D7B0F5B103B1CAC4E04A2AC8
            5C1BDC7F1AB9C571E744A4232EC08E0CB11922F30D30E93FC2419FDB58C7A990
            A9706C521D98548730FA90A78A83919CA834A72BF61150739665C17F46E4AD5F
            6F6D821D606553DF789AE2026D31B01BE2EF2DA0AA8439410AF493733095207B
            F8FBC62EA8F2542B0F5F856AAFE94A54467641093DD1A09559FC3B60ACE6B460
            F753AB09EDE6848AB3A03B4305A694A603821F41E47141606458B5996A2E6804
            569D9E52143C2EB33AAFF56861D726E0BE6E9F855A94EE239D5F23C0E824A6B7
            34123C9583321FA8788C3037B8AE9483B5BC56EDA89A40AC3231B8920A32D706
            F79F466E71DC3911E9E8FD118E62A2AB24235D8001B4BA20819C99E8B31A158A
            DDE14C469FAEE883942A70640609BA672C8133227FFD7A6BE3EB00AB2A55D0F9
            110EA1B6083A39797ACB116002FDE41C4CE94BBE33A8FE7120E760AAF80BCD51
            5E707C34DB0D6F41493D61A169854E6217D12AAE33F8B45D701835359354DEE2
            6CE8E634B5B13B2028C000AE0B4243CA76C73473A146A0363DA5005D970199E3
            2CD467A10197E5236DE40A301D5FF47B2A033C3222E600D79572B096D7EA3D90
            04629589C1955490B936B8FF34728BE3CE8948C7CA02EC4D427DE3091C0ADF50
            F081AA1C2A9CD72AA145DE9A361B38D78839C075A51CACE5B55CF1C08BC19554
            90B936B8FF34728BE3CE8948070598C950DF785A6F0EBCF1E00355395434AFA9
            77DECC7FA3E15C23E600D79572B096D772C5032F06575241E6DAE0FED3C82D8E
            3B27221D1BD04B260796A042D9333D5D759726AC22060441100441100BC3560E
            1088552626A9C48A18D97F238BCB829CCA11C580EF80990C65DE3FE8B57240AF
            958332BDB624B8AE9483B5BCE68807629589C1955490B936B8FF34728BE3CE89
            48070598C9C0478B7240AF95037A8D98035C57CAC15A5ECB150FBC185C490599
            6B83FB4F23B738EE9C88745080990C7CB42807F45A39A0D78839C075A51CACE5
            B55CF1C08BC1955490B936B8FF34728BE3CE8948070598C9C0478B7240AF9503
            7A8D98035C57CAC15A5ECB150FBC185C4905996B83FB4F23B738EE9C88744405
            D811171B15B69E91445D49000598A240AF95037AAD1C94E9B525C175A51CACE5
            B55CF1C08BC1955490B936B8FF34728BE3CE894847448081FCB25B7AB7B8B070
            BFB31C09668400A3FF546B85FA0B5A12BA44FFD5D78E01372AE58D47FFD532E6
            AFE5CAC614DB8DEE9F24AEE87F454DDB6BE3FFF29B69BD96D51F190B40998F16
            F41A3107B8AE9483B5BC962B1E7831B8920A32D706F79F466E71DC3911E9080B
            B0686F3B3BEFBBAA8F20820273DE4FCB2BFD984D80197FCC3500BD276355AFDC
            4321A67DE359A5B706342AE3FCCD8B29B61B76B78D9122961B7353CF350AB08A
            0B7A8D98035C57CAC15A5ECB150FBC185C4905996B83FB4F23B738EE9C887444
            DE01A31498FA1D30E9FACB7C1F41B4DCF1DA30B46F3CABF4D68046659CBF7931
            C57663AAB1B2DC985780B91641567F642C00653E5AD06BC41CE0BA520ED6F25A
            AE78E0C5E04A2AC85C1BDC7F1AB9C571E744A423FA1DB0686F5BD577C064C82F
            3902EC85BB7A59ABDE41E21C1CB553E92475E818F05A939F0EEA13A4EA038145
            7EA14C527188A62A881342A6D21608457E09C4C803AB4BA4E600CD9B15FFDFDE
            1DA438925C6100EEC3F80C4D2F7C02AFBCF5AEE8237831CC0D1A7AE7DD1C61A0
            C1CC050CB3F4AA67D10BEF7C03836160C030304E65A6A44829530A554B7FD5F0
            BE8F04AB5299A178995131F15B52F5B291E617EFACB7D7CEDD9DD4EC19B67D57
            2FD4D8B4B6B37A89A6B756A6AD59641F5EEB4FDFFCBC3BEBF0D4FAF16777EAE8
            C71FFF76EB29F38736C76D2CB3B9C88BC7871FA76DD1C9935BBC51FEEAE917FB
            766560AC36D8D3E7C9F4D47EE7741D765D6D5B58AD6E7472DDA61F17BF3B53CB
            CBFEAC5674E30098583CD56119F168C6551D2F55F57E269FB779EF8D9EDDC82B
            B9D7CFEEFFE4D6D3CD9CF47BB98F208E4BC06945F8EB77DF9C2E1C2F3FBBB3F8
            715C528F8FE745EAB876DC2F58C776A695E5FE98C502FDD0E6B9E6807D6BF382
            F8AC919F16BF78CB96AF9DDB74A0E9E7F2D9B31A9BA5F9ECA4B5F3A6A625F5B8
            7FEAC0BC106FF69F1FBF722F0EFEF1EFDB4F39BEFAF078F7A0EDF6D6E3A6FCB9
            9F53F9E77D9E8FDF3CFD42DF2EDD97C171E730C936FD690FDE78D1BD5FBFFBF3
            E1D59B9EB4676D557776DDA661703980AD57D434D53300F62C9EEAB08C7834E3
            AA8E97AA7A9CDB8FDBBCF746CF6EE495DCEB67F77F72EBE9664EFA6D06B0317F
            7D99FF0CFD2D09ECA600B65F504E9A35E2E567078BD5E77CFC6ECD3AED5F5974
            4EABE1C58272B0BAB3D1B4B06879616AE45FDFB7BF786BBDDD3EF7D08169817E
            CC69D76B6C2D5F743C7E5EEBB74BFFC5FEE994B103178F5FEDFCD79F326ABB7D
            76C1CFCB5F4491F602AE5DF3F3D32FF4ADB132309A067793ECB13F3D7DDE6BEE
            DD46CF37AA1B9B5A5CB7C56B4D2DAC5D87BD8DA69A13972FB1C88A238BA73A2C
            231ECDB8AAE3A5AA1E26F0769BF7DEE8D98DBC927BFDECFE4F6E3DDDCC49BFED
            77C0767F04F1F80E58FF9F417CCE4710E7C5E262E178F9D969B178B29D8593F3
            06A7156ADBF871E79AA68593B5F55923D703D8F6B9FB0E2C16DF576A6C5ADB5B
            BCE8E9027ABFBC5EEE9F4ED97560EBF8E1E1D9BD983DFB9445265974BB79BC55
            7E6700DB3C7DB36F838DFB32DA6CB0A7CF078783DB2ADA9EAF57B772DDFA02D8
            7945CF1800138BA73A2C231ECDB8AAE3A5AADE4FFBF336EFBDD1B31B7925F7FA
            A4FF5FB9CD8D6E3373D2EFD277C0BE7C7C377E05ECB62F81DDFA47389A65DF62
            E138D97CF66C7538EB0860ED5AF6B07343D3C232F69C37D21FC0B63AD0EEDFB9
            5CE3B5007672FAB1F1C5FEE994B1035BC7EF4D7B16FDB9FD94954616DD6E1E6F
            957F4B005B3B7DB6D5B7F3FB326B1A5C4EB23D7D3E9A5FE5BBDD4DDC1FD9F6FC
            52005BB4DC11C0D62B5A74B23971D9F9F6DC89C5531D96118F665CD5F152550F
            1378BBCD7B6FF4EC465EC9BD3EE9FF576E73A3DBCC9CF4BBF847387EF965FE08
            E22D3A03D8B0BC9B977AC765DF62E178F6ECC99A785CA71E56DB07BD016C6A67
            6A647ADC2E610F9A165642D4A29165005BF6F6DAB9BBC78B9E4F2ED6B812C0D6
            2ED1F9A5685F68BCBC8BCE9C1DBF7A2FF6C6EF80DD74CAA2CCCBDF01DB287FD1
            CF45C93D23E442DFD6EFCBD1B1C1E524DBD3E7C6740516ED9FB5705EDDCA756B
            5E6B711F173762A5A21B07C0A1A8E5B71CABB064E4118CAB3A5EAAEA716EBFF3
            3637DDE195DCEB93FE7FE53637BACDCC49BF170B60FB15DEB82DFE5FFC69CD77
            FE6CB3723D2C43A71FE76D3C71B14E6D1B6C57E7C7137FFEEBB0003D5DB6369A
            9D53CBC7D873DAC849005BF4F6DAB94307C6B5F2BC73D8F6C160BBC6B500767A
            890E3FEEB6A6B479D9BD3BEC7FC735FAD6F16BF762EFC7EFBFBDF594E655CEAF
            FCC95D582B7FDA39DFE265E83A297FFDF40B7D5BB92F4B171ABCDCE7D6BE03FB
            12962D745477D8B37E1FCF5A1BB74545B70D80A91101AC10CB884733AEEA78A9
            AAF733F93DB7B9E90EAFE45E9FF4FF2BB7B9D16D664EFABD60007B65C6A5E7E2
            BD9A1BF94F4B1DAAAE43D53C827155C74B557D121EEEB2CD4D77783DF7FAA484
            676F7373179939E9F766C84B77370CC1DF9D9FFEF287FFFCF1DB7FCE3F0100FC
            8E9D4488AFDFE676798079554E19DE01BB9B9ABF3FAAAE43D575D4AC3AC9B8AA
            E365AB3E49505FB9CD8D7670AFE13201EC6E4C3775A8BA0E55F308C6551DAAAE
            C3CC493F01EC6E4C3775A8BA0E55F308C6551DAAAEC3CC493F01EC6E4C3775A8
            BA0E55F308C6551DAAAEC3CC49BF8B01EC87F7D3BFC3FCF6C3E7395D7510C04A
            51751DAAAEA366D549C6551DAAAEC3CC49BFED00F6E5E3BB37EFFFBE7B07ECD3
            D32D114C002B45D575A8BA8E9A5527195775A8BA0E3327FD3603D890BFDE7DFC
            327D04F1F387B7FD094C002B45D575A8BA8E9A5527195775A8BA0E3327FD04B0
            BB31DDD4A1EA3A54CD23185775A8BA0E3327FDB63F82B8FB02D8F411C4217FDD
            F0194401AC1455D7A1EA3A6A569D645CD5A1EA3ACC9CF4BBF4473876DF021BFF
            06C7D39377C0AE33DDD4A1EA3A54CD23185775A8BA0E3327FD2E05B0C1F411C4
            4F4F6F9E3E4DF1EA3A01AC1455D7A1EA3A6A569D645CD5A1EA3ACC9CF4EB0860
            B7FD114401AC1655D7A1EA3A6A569D645CD5A1EA3ACC9CF4BB10C0F6FF0AD80D
            EF7EED0860A5A8BA0E55D751B3EA24E3AA0E55D761E6A45FD747106F228095A2
            EA3A545D47CDAA938CAB3A545D8799937E02D8DD986EEA50751DAAE6118CAB3A
            545D8799937E02D8DD986EEA50751DAAE6118CAB3A545D8799937E6F86BC7477
            C310040000AE9A57E594E11DB0BBA9F9FBA3EA3A545D47CDAA938CAB3A545D87
            99937E02D8DD986EEA50751DAAE6118CAB3A545D8799937E02D8DD986EEA5075
            1DAAE6118CAB3A545D8799937E02D8DD986EEA50751DAAE6118CAB3A545D8799
            937E1B016CF78F30BFFFE110C03E3D4DFF24F3DB0F9FC790758900568AAAEB50
            751D35AB4E32AEEA50751D664EFA9D07B02F1FDF0DE1EBFDFB63001BE2D7D3A7
            5DB61A1E5C8F60025829AAAE43D575D4AC3AC9B8AA43D5759839E9B7F511C41F
            8E01EC90BFFEFBDFCF1FDE5E4D60025829AAAE43D575D4AC3AC9B8AA43D57598
            39E9773D802D425713C6B60860A5A8BA0E55D751B3EA24E3AA0E55D761E6A49F
            007637A69B3A545D87AA7904E3AA0E55D761E6A49F007637A69B3A545D87AA79
            04E3AA0E55D761E6A49FEF80DD8DE9A60E55D7A16A1EC1B8AA43D5759839E9D7
            11C086D43527B0218A5DCD5F02582DAAAE43D575D4AC3AC9B8AA43D5759839E9
            D711C00643F21A5DFBF8E18E00568AAAEB50751D35AB4E32AEEA50751D664EFA
            6D05B0D91CC06E218095A2EA3A545D47CDAA938CAB3A545D8799937E02D8DD98
            6EEA50751DAAE6118CAB3A545D8799937E02D8DD986EEA50751DAAE6118CAB3A
            545D8799937E6F86BC7477C310040000AE9A57E594E11DB0BBA9F9FBA3EA3A54
            5D47CDAA938CAB3A545D8799937E6FE6FF050000E0C1043000008010010C0000
            2044000300000811C000000042043000008010010C00002044000300000811C0
            00000042043000008010010C00002044000300000811C0000000420430000080
            10010C00002044000300000811C000000042043000008010010C000020440003
            00000811C000000042043000008010010C00002044000300000811C000000042
            043000008010010C00002044000300000811C000000042043000008010010C00
            002044000300000811C000000042043000008010010C00002044000300000811
            C000000042043000008010010C00002044000300000811C00000004204300000
            8010010C00002044000300000811C000000042043000008010010C0000204400
            0300000811C000000042043000008010010C00002044000300000811C0000000
            42043000008010010C00002044000300000811C000000042043000008010010C
            00002044000300000811C000000042043000008010010C000020440003000008
            11C000000042043000008010010C00002044000300000811C000000042043000
            008010010C00002044000300000811C000000042043000008010010C00002044
            000300000811C000000042043000008010010C00002044000300000811C00000
            0042043000008010010C00002044000300000811C00000004204300000801001
            0C00002044000300000811C000000042043000008010010C0000204400030000
            0811C000000042043000008010010C00002044000300000811C0000000420430
            00008010010C00002044000300000811C000000042043000008010010C000020
            44000300000811C000000042043000008010010C00002044000300000811C000
            000042043000008010010C00002044000300000811C000000042043000008010
            010C00002044000300000811C000000042043000008010010C00002044000300
            000811C000000042043000008010010C00002044000300000811C00000004204
            3000008010010C00002044000300000811C000000042043000008010010C0000
            2044000300000811C000000042043000008010010C00002044000300000811C0
            00000042043000008010010C00002044000300000811C0000000420430000080
            10010C00002044000300000811C000000042043000008010010C000020440003
            00000811C000000042043000008010010C00002044000300000811C000000042
            043000008010010C00002044000300000811C000000042043000008010010C00
            002044000300000811C000000042043000008010010C00002044000300000811
            C000000042043000008010010C00002044000300000811C00000004204300000
            8010010C00002044000300000811C000000042043000008010010C0000204400
            0300000811C000000042043000008010010C00002044000300000811C0000000
            42043000008010010C00002044000300000811C000000042043000008010010C
            00002044000300000811C000000042043000008010010C000020440003000008
            11C000000042043000008010010C00002044000300000811C000000042043000
            008010010C00002044000300000811C000000042043000008010010C00002044
            000300000811C000000042043000008010010C00002044000300000811C00000
            0042043000008010010C00002044000300000811C00000004204300000801001
            0C00002044000300000811C000000042043000008010010C0000204400030000
            0811C000000042043000008010010C00002044000300000811C0000000420430
            00008010010C00002044000300000811C000000042043000008010010C000020
            44000300000811C000000042043000008010010C00002044000300000811C000
            000042043000008010010C00002044000300000811C000000042043000008010
            010C00002044000300000811C000000042043000008010010C00002044000300
            000811C000000042043000008010010C00002044000300000811C00000004204
            3000008010010C00002044000300000811C000000042043000008010010C0000
            2044000300000811C000000042043000008010010C00002044000300000811C0
            00000042043000008010010C00002044000300000811C0000000420430000080
            10010C00002044000300000811C000000042043000008010010C000020440003
            00000811C000000042043000008010010C00002044000300000811C000000042
            043000008010010C00002044000300000811C000000042043000008010010C00
            002044000300000811C000000042043000008010010C00002044000300000811
            C000000042043000008088DF7EFB3FA70D283751FC0F290000000049454E44AE
            426082}
          Stretched = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo16: TfrxMemoView
          Left = 14.000000000000000000
          Top = 982.850340000000000000
          Width = 1067.826840000000000000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '* Exemplo de como dever'#225' ficar o arquivo para a devida importa'#231#227 +
              'o!')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 12.000000000000000000
          Top = 245.850340000000000000
          Width = 546.763760000000100000
          Height = 15.960730000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            
              '* As Colunas "J", "K" devem estar formatas como destacado na ima' +
              'gem!')
          ParentFont = False
        end
      end
    end
  end
end
