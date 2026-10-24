inherited frmLiberacaoAcompEntregas: TfrmLiberacaoAcompEntregas
  Width = 965
  Height = 600
  Caption = 'Libera'#231#227'o e Acompanhamento das Entregas'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitLeft = -170
  ExplicitTop = -165
  ExplicitWidth = 965
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 959
    TabOrder = 1
    ExplicitTop = 527
    ExplicitWidth = 959
    inherited FlwBotoes: TFlowPanel
      Width = 955
      ExplicitWidth = 955
      object btnMarDes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F1] Marcar/Desmarcar Romaneio'
        TabOrder = 0
        OnClick = btnMarDesClick
      end
      object btnMarTod: TBitBtnLocked
        Left = 167
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F2] Marcar Todos Romaneios'
        TabOrder = 1
        OnClick = btnMarTodClick
      end
      object btnAtuali: TBitBtnLocked
        Left = 334
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F5] Atualizar'
        TabOrder = 2
        OnClick = btnAtualiClick
      end
      object btnLibEnt: TBitBtnLocked
        Left = 501
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F10] Liberar Entrega'
        TabOrder = 3
        OnClick = btnLibEntClick
      end
      object btnExpRec: TBitBtnLocked
        Left = 668
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F11] Expandir'
        TabOrder = 4
        OnClick = btnExpRecClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 856
      Top = 2
      Width = 100
      ExplicitLeft = 856
      ExplicitTop = 2
      ExplicitWidth = 100
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 959
    TabOrder = 2
    ExplicitTop = 555
    ExplicitWidth = 959
    inherited pnlNomeForm: TPanel
      Left = 788
      ExplicitLeft = 788
    end
    inherited pnlInfo: TPanel
      Width = 788
      ExplicitWidth = 788
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 959
    Height = 527
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 957
      Height = 365
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 79
        Top = 8
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 8
        Top = 46
        Width = 107
        Height = 14
        Caption = 'Empresa do Romaneio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 83
        Width = 32
        Height = 14
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 403
        Top = 46
        Width = 47
        Height = 14
        Caption = 'Romaneio'
      end
      object Label2: TLabel
        Left = 8
        Top = 121
        Width = 33
        Height = 14
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 159
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motorista'
      end
      object lbl1: TLabel
        Left = 401
        Top = 121
        Width = 47
        Height = 14
        Caption = 'Vendedor'
      end
      object lbl2: TLabel
        Left = 401
        Top = 159
        Width = 98
        Height = 14
        Caption = 'Regi'#227'o do Romaneio'
      end
      object lblTransp: TLabel
        Left = 401
        Top = 234
        Width = 75
        Height = 14
        Caption = 'Transportadora'
      end
      object lbl3: TLabel
        Left = 8
        Top = 197
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ajudante'
      end
      object lbl4: TLabel
        Left = 8
        Top = 234
        Width = 37
        Height = 14
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 401
        Top = 82
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ve'#237'culo'
      end
      object lblRegiaoCli: TLabel
        Left = 401
        Top = 197
        Width = 83
        Height = 14
        Caption = 'Regi'#227'o do Cliente'
      end
      object Label7: TLabel
        Left = 157
        Top = 25
        Width = 87
        Height = 14
        Caption = '(FATURAMENTO)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 22
        Width = 69
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
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
        Left = 79
        Top = 22
        Width = 70
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 8
        Top = 97
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 6
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCliente: TEditFocus
        Left = 79
        Top = 97
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 8
        Top = 60
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 79
        Top = 60
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodCid: TEditFocus
        Tag = 99
        Left = 8
        Top = 135
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 10
        OnKeyPress = edtCodCidKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCidade: TEditFocus
        Left = 79
        Top = 135
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
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
      object edtNumRom: TEditFocus
        Left = 403
        Top = 60
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtCodMot: TEditFocus
        Tag = 99
        Left = 8
        Top = 173
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 14
        OnKeyPress = edtCodMotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomMot: TEditFocus
        Left = 79
        Top = 173
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 401
        Top = 135
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 12
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 472
        Top = 135
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodReg: TEditFocus
        Tag = 99
        Left = 401
        Top = 173
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 16
        OnKeyPress = edtCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomReg: TEditFocus
        Left = 472
        Top = 173
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 17
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 401
        Top = 248
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 24
        OnKeyPress = edtCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 472
        Top = 248
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodAju: TEditFocus
        Tag = 99
        Left = 8
        Top = 211
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 18
        OnKeyPress = edtCodAjuKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomAju: TEditFocus
        Left = 79
        Top = 211
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 19
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 8
        Top = 248
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 22
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesIte: TEditFocus
        Left = 79
        Top = 248
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        TabOrder = 23
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskPlaVei: TMaskEditFocus
        Tag = 99
        Left = 402
        Top = 97
        Width = 68
        Height = 22
        Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
        AutoSelect = False
        AutoSize = False
        CharCase = ecUpperCase
        EditMask = 'aaa-9a99;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        Text = ''
        OnKeyPress = mskPlaVeiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesVei: TEditFocus
        Left = 472
        Top = 97
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtRegCli: TEditFocus
        Tag = 99
        Left = 401
        Top = 211
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 20
        OnKeyPress = edtRegCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomRegCli: TEditFocus
        Left = 472
        Top = 211
        Width = 318
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 21
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gpbDocumento: TGroupBox
        Left = 480
        Top = 28
        Width = 186
        Height = 59
        Caption = 'Documento'
        TabOrder = 5
        object Label10: TLabel
          Left = 7
          Top = 17
          Width = 54
          Height = 14
          Caption = 'Documento'
        end
        object Label11: TLabel
          Left = 91
          Top = 17
          Width = 38
          Height = 14
          Caption = 'Esp'#233'cie'
        end
        object Label12: TLabel
          Left = 134
          Top = 17
          Width = 42
          Height = 14
          Caption = 'Empresa'
        end
        object edtDocFat: TEditFocus
          Tag = 99
          Left = 7
          Top = 32
          Width = 81
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 6
          TabOrder = 0
          OnExit = edtDocFatExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttInteiro
        end
        object edtEspFat: TEditFocus
          Tag = 99
          Left = 91
          Top = 32
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 2
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtEmpFat: TEditFocus
          Tag = 99
          Left = 134
          Top = 32
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttInteiro
        end
      end
      object rdgCtrEnt: TRadioGroup
        Left = 8
        Top = 274
        Width = 541
        Height = 35
        Caption = 'Controle de baixa do romaneio ( Entregas )'
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Aguardando Libera'#231#227'o'
          'Entrega em Andamento'
          'Entregue / Baixado')
        TabOrder = 26
        OnClick = rdgCtrEntClick
      end
      object btnFiltrar: TBitBtnLocked
        Left = 705
        Top = 325
        Width = 85
        Height = 28
        Caption = '&Consultar'
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
        OnClick = btnFiltrarClick
      end
      object chkBaixaApp: TCheckBox
        Left = 555
        Top = 279
        Width = 144
        Height = 32
        Caption = 'Somente Entregas feitas via aplicativo'
        Enabled = False
        TabOrder = 27
        WordWrap = True
      end
      object gbxTipoBaixa: TGroupBox
        Left = 8
        Top = 315
        Width = 541
        Height = 42
        Caption = 'Exibir romaneios Entregues/Baixados'
        Enabled = False
        TabOrder = 28
        object chkEntregue: TCheckBox
          Left = 36
          Top = 19
          Width = 97
          Height = 17
          Caption = 'Entregue'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 0
        end
        object chkEntregueParc: TCheckBox
          Left = 128
          Top = 19
          Width = 145
          Height = 17
          Caption = 'Entregue parcialmente'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 1
        end
        object chkNaoEntregue: TCheckBox
          Left = 279
          Top = 19
          Width = 97
          Height = 17
          Caption = 'N'#227'o entregue'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 2
        end
        object chkDesconsiderados: TCheckBox
          Left = 387
          Top = 19
          Width = 115
          Height = 17
          Caption = 'Desconsiderados'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 3
        end
      end
      object chkReagendados: TCheckBox
        Left = 555
        Top = 326
        Width = 144
        Height = 32
        Caption = 'Somente Reagendamentos'
        Enabled = False
        TabOrder = 29
        WordWrap = True
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 366
      Width = 957
      Height = 160
      Align = alClient
      Caption = 'pnlGrid'
      TabOrder = 1
      object cxgDados: TcxGridCitel
        Left = 1
        Top = 1
        Width = 955
        Height = 88
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDadosTableView1: TcxGridDBTableViewCitel
          OnKeyDown = cxgDadosTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgDadosTableView1CustomDrawCell
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          OnCustomDrawGroupCell = cxgDadosTableView1CustomDrawGroupCell
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosTableView1GER_ROMIMP: TcxGridDBColumn
            Caption = 'Imp'
            DataBinding.FieldName = 'GER_ROMIMP'
            Width = 20
          end
          object cxgDadosTableView1GER_DTAENT: TcxGridDBColumn
            Caption = 'Emiss'#227'o'
            DataBinding.FieldName = 'GER_DTAENT'
            MinWidth = 64
            Options.Editing = False
            Options.ShowEditButtons = isebNever
          end
          object cxgDadosTableView1DOCUME: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'DOCFAT'
            MinWidth = 130
            Width = 130
          end
          object cxgDadosTableView1CLIENT: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CLIENT'
            MinWidth = 150
            Width = 249
          end
          object cxgDadosTableView1CID_NOMCID: TcxGridDBColumn
            Caption = 'Cidade'
            DataBinding.FieldName = 'CID_NOMCID'
            MinWidth = 128
            Width = 128
          end
          object cxgDadosTableView1GER_ESTADO: TcxGridDBColumn
            Caption = 'UF'
            DataBinding.FieldName = 'GER_ESTADO'
            MinWidth = 25
            Width = 25
          end
          object cxgDadosTableView1GER_CODVEN: TcxGridDBColumn
            Caption = 'Ven.'
            DataBinding.FieldName = 'GER_CODVEN'
            MinWidth = 35
            Width = 36
          end
          object cxgDadosTableView1GER_VLRCON: TcxGridDBColumn
            Caption = 'Vr. Documento'
            DataBinding.FieldName = 'GER_VLRCON'
            MinWidth = 82
            Width = 82
          end
          object cxgDadosTableView1ROMANE: TcxGridDBColumn
            Caption = 'Romaneio'
            DataBinding.FieldName = 'ROMANE'
            Visible = False
            GroupIndex = 0
          end
          object cxgDadosTableView1STAENT: TcxGridDBColumn
            Caption = 'Status Entrega'
            DataBinding.FieldName = 'STAENT'
            MinWidth = 170
            Width = 230
          end
          object cxgDadosTableView1MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
          end
        end
        object cxgDadosLevel1: TcxGridLevel
          GridView = cxgDadosTableView1
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 89
        Width = 955
        Height = 70
        Align = alBottom
        TabOrder = 1
        object Label8: TLabel
          Left = 2
          Top = 27
          Width = 67
          Height = 14
          Caption = 'Recebido por:'
        end
        object Label9: TLabel
          Left = 246
          Top = 27
          Width = 64
          Height = 14
          Caption = 'Status Baixa:'
        end
        object Label13: TLabel
          Left = 14
          Top = 49
          Width = 55
          Height = 14
          Caption = 'Ajudante 1:'
        end
        object Label14: TLabel
          Left = 255
          Top = 49
          Width = 55
          Height = 14
          Caption = 'Ajudante 2:'
        end
        object Label15: TLabel
          Left = 487
          Top = 27
          Width = 57
          Height = 14
          Caption = 'Motivo/Obs:'
        end
        object Label16: TLabel
          Left = 726
          Top = 27
          Width = 51
          Height = 14
          Caption = 'Data/Hora:'
        end
        object lblAjudante4: TLabel
          Left = 722
          Top = 49
          Width = 55
          Height = 14
          Caption = 'Ajudante 4:'
        end
        object lblAjudante3: TLabel
          Left = 489
          Top = 49
          Width = 55
          Height = 14
          Caption = 'Ajudante 3:'
        end
        object edtRecPor: TEditFocus
          Left = 76
          Top = 24
          Width = 167
          Height = 22
          Alignment = taLeftJustify
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
        object edtStaBai: TEditFocus
          Left = 316
          Top = 24
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAjuda1: TEditFocus
          Left = 76
          Top = 46
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAjuda2: TEditFocus
          Left = 316
          Top = 46
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMotivo: TEditFocus
          Left = 552
          Top = 24
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnRecImg: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 189
          Height = 22
          Caption = 'Assinatura'
          Enabled = False
          TabOrder = 0
          OnClick = btnRecImgClick
        end
        object edtDtaHraBai: TEditFocus
          Left = 781
          Top = 24
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnFacImg: TBitBtnLocked
          Left = 570
          Top = 2
          Width = 189
          Height = 22
          Caption = 'Foto da Entrega'
          Enabled = False
          TabOrder = 3
          OnClick = btnFacImgClick
        end
        object btnItensDaNota: TBitBtnLocked
          Left = 381
          Top = 2
          Width = 189
          Height = 22
          Caption = 'Itens da Nota'
          Enabled = False
          TabOrder = 2
          OnClick = btnItensDaNotaClick
        end
        object btnReagendar: TBitBtnLocked
          Left = 759
          Top = 2
          Width = 189
          Height = 22
          Caption = 'Reagendar'
          Enabled = False
          TabOrder = 4
          OnClick = btnReagendarClick
        end
        object btnDesconsiderar: TBitBtnLocked
          Left = 192
          Top = 2
          Width = 189
          Height = 22
          Caption = 'Desconsiderar'
          Enabled = False
          TabOrder = 1
          OnClick = btnDesconsiderarClick
        end
        object edtAjuda4: TEditFocus
          Left = 781
          Top = 46
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAjuda3: TEditFocus
          Left = 552
          Top = 46
          Width = 167
          Height = 22
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 11
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 880
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 856
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 912
    Top = 16
  end
  object dtsDados: TDataSource
    Left = 240
    Top = 408
  end
end
