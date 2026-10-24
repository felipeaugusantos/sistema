inherited frmCadCidades: TfrmCadCidades
  Left = 393
  Top = 393
  Width = 763
  Height = 495
  Caption = 'Cadastro de Cidades'
  ExplicitWidth = 763
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 425
    Width = 757
    Height = 25
    TabOrder = 1
    ExplicitTop = 425
    ExplicitWidth = 623
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 685
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 551
      ExplicitHeight = 21
      inherited btnCancela: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 363
        Width = 75
        ExplicitLeft = 363
        ExplicitWidth = 75
      end
      object btnFeriados: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 72
        Height = 20
        Caption = '&Feriados'
        TabOrder = 6
        OnClick = btnFeriadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 687
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 553
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 450
    Width = 757
    TabOrder = 3
    ExplicitTop = 450
    ExplicitWidth = 623
    inherited pnlNomeForm: TPanel
      Left = 589
      Width = 168
      ExplicitLeft = 455
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 589
      ExplicitWidth = 455
    end
  end
  inherited pgcDados: TPageControl
    Width = 757
    Height = 425
    Visible = False
    ExplicitWidth = 623
    ExplicitHeight = 425
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 615
      ExplicitHeight = 393
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 757
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 623
    object pnlTopo: TPanel
      Left = 5
      Top = 5
      Width = 747
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 613
      object Label1: TLabel
        Left = 47
        Top = 5
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 1
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_CODCID'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
    object pnlCodCor: TPanel
      Left = 5
      Top = 29
      Width = 747
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 613
      object lblCodCor: TLabel
        Left = 5
        Top = 4
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo Correios:'
      end
      object dbeCodCor: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 0
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_CODCOR'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeCodCorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtNomCid: TEditFocus
        Left = 182
        Top = 0
        Width = 538
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
    object pnlAllClient: TPanel
      Left = 5
      Top = 51
      Width = 747
      Height = 369
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = 4
      ExplicitTop = 52
      ExplicitWidth = 782
      object Label3: TLabel
        Left = 47
        Top = 29
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
      end
      object Label2: TLabel
        Left = 31
        Top = 3
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label4: TLabel
        Left = 63
        Top = 51
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CEP:'
      end
      object Label5: TLabel
        Left = 310
        Top = 51
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr Entrega:'
      end
      object Label6: TLabel
        Left = 599
        Top = 29
        Width = 26
        Height = 14
        Alignment = taRightJustify
        Caption = 'IBGE:'
      end
      object lblCodPai: TLabel
        Left = 321
        Top = 29
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cod.Pa'#237's:'
      end
      object lbl1: TLabel
        Left = 24
        Top = 74
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota ISS:'
      end
      object lbl2: TLabel
        Left = 183
        Top = 74
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblRedISS: TLabel
        Left = 218
        Top = 75
        Width = 146
        Height = 14
        Alignment = taRightJustify
        Caption = 'Redu'#231#227'o Base C'#225'lculo do ISS:'
        Visible = False
      end
      object clbRedISS: TLabel
        Left = 468
        Top = 73
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
        Visible = False
      end
      object lblQtdDia: TLabel
        Left = 563
        Top = 51
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Dias para Entrega:'
      end
      object Label11: TLabel
        Left = 500
        Top = 97
        Width = 123
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota de IBS Municipal:'
      end
      object Label12: TLabel
        Left = 726
        Top = 97
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label13: TLabel
        Left = 454
        Top = 121
        Width = 169
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota de IBS Municipal Redu'#231#227'o:'
      end
      object Label14: TLabel
        Left = 726
        Top = 121
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label15: TLabel
        Left = 726
        Top = 145
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label16: TLabel
        Left = 443
        Top = 145
        Width = 180
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota de IBS Municipal Diferimento:'
      end
      object dbeEstado: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 24
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_ESTADO'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        OnExit = dbeEstadoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNomCid: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 1
        Width = 631
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_NOMCID'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumCep: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 47
        Width = 92
        Height = 22
        DataField = 'CID_C_E_P_'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeValEnt: TDBEditFocus
        Tag = 99
        Left = 370
        Top = 47
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_VALENT'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeCodIbge: TDBEditFocus
        Tag = 99
        Left = 628
        Top = 24
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_COIBGE'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        OnKeyPress = dbeCodIbgeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeCodPai: TDBEditFocus
        Tag = 99
        Left = 370
        Top = 24
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_CODPAI'
        DataSource = dtsCadCid
        TabOrder = 2
        OnKeyPress = dbeCodPaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeAlqIss: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 70
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_ALQISS'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object gpbSIAM: TGroupBox
        Left = 0
        Top = 260
        Width = 747
        Height = 59
        Align = alBottom
        Caption = 'SIAM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        ExplicitWidth = 613
        object Label7: TLabel
          Left = 8
          Top = 29
          Width = 72
          Height = 14
          Caption = 'C'#243'd. Munic'#237'pio:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 199
          Top = 29
          Width = 61
          Height = 14
          Caption = 'C'#243'd. Estado:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeMunSIA: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 24
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CID_MUNSIA'
          DataSource = dtsCadCid
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
        object DBEditFocus1: TDBEditFocus
          Tag = 99
          Left = 264
          Top = 24
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CID_ESTSIA'
          DataSource = dtsCadCid
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
      end
      object dbeRedISS: TDBEditFocus
        Tag = 99
        Left = 370
        Top = 70
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_REDISS'
        DataSource = dtsCadCid
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object rdgTaxEnt: TDBRadioGroup
        Tag = 99
        Left = 0
        Top = 171
        Width = 747
        Height = 48
        Align = alBottom
        Caption = 'Cobrar taxa de entrega para clientes desta cidade'
        Columns = 2
        DataField = 'CID_COBTAX'
        DataSource = dtsCadCid
        Items.Strings = (
          'Para cada entrega, individualmente.'
          'De acordo com a regi'#227'o do cliente.')
        TabOrder = 12
        TabStop = True
        Values.Strings = (
          'I'
          'R')
        OnEnter = rdgTaxEntEnter
        ExplicitWidth = 613
      end
      object gpbSigepWeb: TGroupBox
        Left = 0
        Top = 219
        Width = 747
        Height = 41
        Align = alBottom
        Caption = 'Sigep Web'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        ExplicitWidth = 613
        object Label9: TLabel
          Left = 10
          Top = 19
          Width = 163
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor m'#237'n. p/ seguro dos correios:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 443
          Top = 19
          Width = 179
          Height = 14
          Alignment = taRightJustify
          Caption = '% declarado sobre o valor da venda:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeVrMSeg: TDBEditFocus
          Tag = 99
          Left = 176
          Top = 16
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CID_VRMSEG'
          DataSource = dtsCadCid
          Font.Charset = ANSI_CHARSET
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
          TipoTexto = ttNumerico
        end
        object dbePerSeg: TDBEditFocus
          Tag = 99
          Left = 628
          Top = 16
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CID_PERSEG'
          DataSource = dtsCadCid
          Font.Charset = ANSI_CHARSET
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
      end
      object dbeQtdDia: TDBEditFocus
        Tag = 99
        Left = 677
        Top = 47
        Width = 43
        Height = 22
        DataField = 'CID_QTDDIA'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object btnReducaoBCISS: TBitBtnLocked
        Left = 546
        Top = 70
        Width = 174
        Height = 22
        Caption = '&Redu'#231#227'o Base de C'#225'lculo ISS'
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
        TabOrder = 16
        OnClick = btnReducaoBCISSClick
      end
      object grbPisCof: TGroupBox
        Left = 0
        Top = 319
        Width = 747
        Height = 50
        Align = alBottom
        Caption = 'Cobran'#231'a de PIS/COFINS'
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 15
        ExplicitWidth = 613
        object lblLimJud: TLabel
          Left = 10
          Top = 23
          Width = 314
          Height = 14
          Caption = 'Cidade suspensa de cobran'#231'a de PIS/COFINS por liminar judicial?'
        end
        object ColorLabel29: TColorLabel
          Left = 379
          Top = 23
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
        object lblSitP_C: TLabel
          Left = 457
          Top = 23
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o PIS/COFINS:'
          Visible = False
        end
        object dbeLimJud: TDBEditFocus
          Tag = 99
          Left = 333
          Top = 20
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CID_LIMJUD'
          DataSource = dtsCadCid
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 0
          OnChange = dbeLimJudChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object cbbSitP_C: TDBComboBoxFocus
          Tag = 99
          Left = 566
          Top = 20
          Width = 170
          Height = 22
          Style = csDropDownList
          DataField = 'CID_SITP_C'
          DataSource = dtsCadCid
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object dbeIbsMna: TDBEditFocus
        Tag = 99
        Left = 628
        Top = 93
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_IBSMNA'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeIbsMnr: TDBEditFocus
        Tag = 99
        Left = 628
        Top = 117
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_IBSMNR'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeIbsMnd: TDBEditFocus
        Tag = 99
        Left = 628
        Top = 141
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CID_IBSMND'
        DataSource = dtsCadCid
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
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
    Left = 504
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 0
  end
  object dtsCadCid: TDataSource
    OnDataChange = dtsCadCidDataChange
    Left = 376
  end
end
