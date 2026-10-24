inherited frmDesmembrValores: TfrmDesmembrValores
  Left = 313
  Top = 249
  Width = 780
  Height = 502
  BorderIcons = [biSystemMenu]
  Caption = 'Desmembramento de Valores'
  Position = poMainFormCenter
  ExplicitWidth = 780
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 357
    Width = 774
    ExplicitTop = 357
    ExplicitWidth = 774
    DesignSize = (
      774
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 770
      ExplicitWidth = 770
    end
    inherited btnSair: TBitBtnLocked
      Left = 491
      Top = -22
      ExplicitLeft = 491
      ExplicitTop = -22
    end
  end
  inherited pnlStatus: TPanel
    Top = 457
    Width = 774
    ExplicitTop = 457
    ExplicitWidth = 774
    inherited pnlNomeForm: TPanel
      Left = 602
      Width = 172
      ExplicitLeft = 602
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 602
      ExplicitWidth = 602
    end
  end
  inherited pgcDados: TPageControl
    Top = 133
    Width = 774
    Height = 224
    Visible = False
    ExplicitTop = 133
    ExplicitWidth = 774
    ExplicitHeight = 224
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 766
      ExplicitHeight = 192
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 774
    Height = 133
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 35
      Top = 84
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblTipo: TLabel
      Left = 477
      Top = 84
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Percentual:'
    end
    object lbl1: TLabel
      Left = 6
      Top = 38
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Duplic./Parcela:'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 84
      Top = 80
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 533
      Top = 80
      Width = 86
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtNomEmp: TEditFocus
      Left = 140
      Top = 80
      Width = 316
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object pnlTipo: TPanel
      Left = 2
      Top = 2
      Width = 770
      Height = 30
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label4: TLabel
        Left = 18
        Top = 8
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Informar em:'
      end
      object rdbValor: TRadioButton
        Tag = 99
        Left = 89
        Top = 7
        Width = 67
        Height = 17
        Caption = 'Valor'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbValorClick
      end
      object rdbPorcen: TRadioButton
        Tag = 99
        Left = 164
        Top = 7
        Width = 77
        Height = 17
        Caption = 'Percentual'
        TabOrder = 1
        OnClick = rdbValorClick
      end
      object chkEventos: TCheckBox
        Left = 618
        Top = 7
        Width = 146
        Height = 17
        Caption = 'Habilitar Centro de Custos'
        TabOrder = 2
        OnClick = chkEventosClick
        OnExit = chkEventosClick
      end
    end
    object edtNumDup: TEditFocus
      Left = 84
      Top = 34
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
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
    object edtParcel: TEditFocus
      Left = 201
      Top = 34
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object btnInserir: TBitBtnLocked
      Left = 532
      Top = 105
      Width = 88
      Height = 22
      Caption = '&Inserir'
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
      TabOrder = 8
      OnClick = btnInserirClick
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = -10
      Top = 103
      Width = 475
      Height = 22
      TabOrder = 5
      ExplicitLeft = -10
      ExplicitTop = 103
      ExplicitWidth = 475
      inherited lblEventos: TLabel
        Left = 18
        Width = 72
        Height = 14
        Caption = 'Centro Custos:'
        ExplicitLeft = 18
        ExplicitWidth = 72
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Height = 22
        OnKeyPress = fraCentroCustoedtCodEveKeyPress
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Width = 316
        Height = 22
        ExplicitWidth = 316
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 11
      Top = 57
      Width = 451
      Height = 22
      TabOrder = 3
      ExplicitLeft = 11
      ExplicitTop = 57
      ExplicitWidth = 451
      inherited lblPlaContas: TLabel
        Left = 0
        Width = 69
        Height = 14
        Caption = 'Plano Contas: '
        ExplicitLeft = 0
        ExplicitWidth = 69
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 129
        Width = 316
        Height = 22
        ExplicitLeft = 129
        ExplicitWidth = 316
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 73
        Width = 55
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 73
        ExplicitWidth = 55
        ExplicitHeight = 22
      end
    end
  end
  object pnlBotoesDesm: TPanel [4]
    Left = 0
    Top = 433
    Width = 774
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    object btnMarDes: TBitBtnLocked
      Left = 203
      Top = 2
      Width = 148
      Height = 20
      Align = alLeft
      Caption = '[ ESPA'#199'O] Marca/Desmarca'
      TabOrder = 2
      OnClick = btnMarDesClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 479
      Top = 2
      Width = 103
      Height = 20
      Align = alLeft
      Caption = '&Desmarca todos'
      TabOrder = 4
      OnClick = btnDesmarcaTodosClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 112
      Height = 20
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAlteraCC: TBitBtnLocked
      Left = 351
      Top = 2
      Width = 128
      Height = 20
      Align = alLeft
      Caption = '&Alterar Plano de Contas'
      TabOrder = 3
      OnClick = btnAlteraCCClick
    end
    object btnCancela: TBitBtnLocked
      Left = 114
      Top = 2
      Width = 89
      Height = 20
      Align = alLeft
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object btnClose: TBitBtnLocked
      Left = 695
      Top = 2
      Width = 77
      Height = 20
      Align = alRight
      Caption = '&Sair'
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
      TabOrder = 5
      OnClick = btnSairClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 582
      Top = 2
      Width = 92
      Height = 20
      Align = alLeft
      Caption = '&Marcar todos'
      TabOrder = 6
      OnClick = btnMarcarTodosClick
    end
  end
  object pnlInformativo: TPanel [5]
    Left = 0
    Top = 357
    Width = 774
    Height = 76
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object Label3: TLabel
      Left = 595
      Top = 29
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total % Digitado:'
    end
    object Label5: TLabel
      Left = 607
      Top = 6
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total % Geral:'
    end
    object Label6: TLabel
      Left = 611
      Top = 52
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Diferen'#231'a %:'
    end
    object Label7: TLabel
      Left = 449
      Top = 52
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Diferen'#231'a:'
    end
    object Label8: TLabel
      Left = 445
      Top = 6
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label9: TLabel
      Left = 433
      Top = 29
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Digitado:'
    end
    object edtPercDup: TEditFocus
      Left = 676
      Top = 26
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
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
    object edtPercGeral: TEditFocus
      Left = 676
      Top = 4
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
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
    object edtPercDiferenca: TEditFocus
      Left = 676
      Top = 49
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtTotGeral: TEditFocus
      Left = 501
      Top = 3
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtTotDup: TEditFocus
      Left = 501
      Top = 26
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtDiferenca: TEditFocus
      Left = 501
      Top = 49
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
  end
  object dbgValores: TDBGridCitel [6]
    Left = 0
    Top = 133
    Width = 774
    Height = 224
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgValoresDrawColumnCell
    OnDblClick = dbgValoresDblClick
    OnKeyDown = dbgValoresKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTP_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd. Empresa'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTP_CODEVE'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd. Ctr.Custos'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODCTA'
        Title.Caption = 'C'#243'd. Plano Contas'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTA_DESCTA'
        Title.Caption = 'Descri'#231#227'o Conta'
        Width = 280
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_VALDUP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERCENTUAL'
        Title.Caption = 'Percentual %'
        Width = 70
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 232
  end
end
