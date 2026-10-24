inherited frmAbstractDigTintaAutomotiva: TfrmAbstractDigTintaAutomotiva
  Width = 461
  Height = 702
  BorderIcons = [biSystemMenu]
  Caption = 'Tinta de M'#225'quina - '
  Position = poMainFormCenter
  ExplicitWidth = 461
  ExplicitHeight = 702
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 645
    Width = 455
    ExplicitTop = 645
    ExplicitWidth = 455
    inherited FlwBotoes: TFlowPanel
      Width = 451
      TabOrder = 3
      ExplicitWidth = 451
    end
    inherited btnSair: TBitBtnLocked
      Left = 372
      TabOrder = 2
      ExplicitLeft = 372
    end
    object btnFormulacao: TBitBtnLocked
      Left = 86
      Top = 2
      Width = 91
      Height = 23
      Caption = '&Formula'#231#227'o'
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FEFCFDFFFFFFCAEBF7A4DAF0F4FBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFF2FBFE70CEEA9BDCEBB4DA
        E636BFDABEEEF7FEFBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFF0FAFD5ECDE86EC8DF77DCEB65EAF25AD2E870
        D1E6D9F6FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFDEEEF37BCDE621DFF672F8FEAAECF671ECF923ADCDFFF7F7
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFEBF2F6
        8EDCED13C4E828E0F88EFAFEDFFAFAB0F0F8005065BBACB3DFE0E2FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DBEEF539C8E91CD7F323EAFC60F3
        FDE2FFFF7BBFC2045167967E791579905F97AEF3EDEAFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000A4D8ED2AD5F25FFBFF5BFFFF66FDFFA3F5FF338CA06C
        5B5F4A75820EB6E0187D9BB5B8B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        00009CDFE965EBF66BDAE83F90AB256C7C1868896473806E878A07A8C72FA9CA
        157A9CA3B1BDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00007CC7E144F2FF
        829FB3001A3013446665566492868C149FC836B7CF149BCA2A92A5DCCEC9FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF3393B3006C7C193B53474E
        5E97AAB115B0C01ECBD207AED32DA6BE987E86FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFF74D3EE3A6470332F37969DA440B8C40FC8DA18
        BDD91098B612B0D21692A87F96A1E3DBD9FFFEFDFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFEFEDBF9FFDEF8FAB59B94326C7B00B2CB03BFD60EA0B394A7AC114D55
        13B7E1088EB2367A8DA2B0B6F6F2EFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFEF9F898A8AA4D84915894A2AAB7BCFFFFFFA5969209556A1FACD31CA0
        C4227C9963909DCECDCCFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFCFCFFFEFCFFFFFFFFFFFFFFFFFF938C8B195E7223A8D023A0C81E88B035
        718D99A2A8FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFBF97E7F8103688727AAD4389CC5228DBA0A5D7FCFD0CF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEAE5E559727E0674942BACD83EA1C80986B88992980000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E9
        E65E6D73005D7E089CCE00547DC8C7C80000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAA6A1A25D
        6B6EC8C9CAFFFFFF0000}
      TabOrder = 1
      OnClick = btnFormulacaoClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 81
      Height = 23
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
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 629
    Width = 455
    ExplicitTop = 629
    ExplicitWidth = 455
    inherited pnlNomeForm: TPanel
      Left = 284
      ExplicitLeft = 284
    end
    inherited pnlInfo: TPanel
      Width = 284
      ExplicitWidth = 284
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 455
    Height = 629
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlCabecalho: TPanel
      Left = 1
      Top = 161
      Width = 453
      Height = 192
      Align = alTop
      Color = 16770261
      TabOrder = 3
      object gpbEmbalagem: TGroupBox
        Left = 8
        Top = 3
        Width = 232
        Height = 182
        Caption = 'Embalagem'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 58
          Height = 14
          Caption = 'Quantidade:'
        end
        object lblTipo: TLabel
          Left = 8
          Top = 112
          Width = 23
          Height = 14
          Caption = 'Tipo:'
        end
        object edtQtdEmb: TEditFocus
          Left = 72
          Top = 16
          Width = 49
          Height = 22
          Alignment = taRightJustify
          MaxLength = 4
          TabOrder = 0
          OnExit = edtQtdEmbExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object rdbLitro: TRadioButton
          Left = 8
          Top = 38
          Width = 57
          Height = 17
          Caption = '&Litro'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rdbLitroClick
        end
        object rdbGalao: TRadioButton
          Left = 8
          Top = 73
          Width = 57
          Height = 17
          Caption = '&Gal'#227'o'
          TabOrder = 3
          OnClick = rdbLitroClick
        end
        object rdbCopo: TRadioButton
          Left = 8
          Top = 56
          Width = 57
          Height = 17
          Caption = '&Copo'
          TabOrder = 2
          OnClick = rdbLitroClick
        end
        object rdbSpray: TRadioButton
          Left = 8
          Top = 90
          Width = 57
          Height = 17
          Caption = '&Spray'
          TabOrder = 4
          OnClick = rdbSprayClick
        end
        object rdgAcerto: TRadioGroup
          Left = 6
          Top = 133
          Width = 220
          Height = 41
          Caption = 'Escolha o acerto'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Padr'#227'o'
            'Acerto 1'
            'Acerto 2')
          TabOrder = 12
          OnClick = rdgAcertoClick
        end
        object rdbTambor: TRadioButton
          Left = 81
          Top = 38
          Width = 57
          Height = 17
          Caption = '&Tambor'
          TabOrder = 5
          OnClick = rdbLitroClick
        end
        object rdbLata: TRadioButton
          Left = 81
          Top = 55
          Width = 57
          Height = 17
          Caption = 'L&ata'
          TabOrder = 6
          OnClick = rdbLitroClick
        end
        object cmbTipoEmbalagem: TComboBoxFocus
          Left = 37
          Top = 106
          Width = 189
          Height = 22
          TabOrder = 11
          OnExit = cmbTipoEmbalagemExit
          OnSelect = cmbTipoEmbalagemSelect
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object rdbBalde: TRadioButton
          Left = 81
          Top = 72
          Width = 57
          Height = 17
          Caption = '&Balde'
          TabOrder = 7
          OnClick = rdbLitroClick
        end
        object rdbSpraySint: TRadioButton
          Left = 81
          Top = 90
          Width = 96
          Height = 16
          Caption = 'Spray Sin&t'#233'tico'
          TabOrder = 8
          OnClick = rdbLitroClick
        end
        object rdbSprayPoli: TRadioButton
          Left = 149
          Top = 38
          Width = 71
          Height = 17
          Caption = 'Spray &Poli.'
          TabOrder = 9
          OnClick = rdbLitroClick
        end
        object rdbSprayDuco: TRadioButton
          Left = 149
          Top = 56
          Width = 77
          Height = 14
          Caption = 'Spray &Duco'
          TabOrder = 10
          OnClick = rdbLitroClick
        end
      end
      object pnlPreco: TPanel
        Left = 245
        Top = 9
        Width = 201
        Height = 176
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 111
          Width = 56
          Height = 14
          Caption = 'Pre'#231'o Final:'
        end
        object Label5: TLabel
          Left = 8
          Top = 63
          Width = 100
          Height = 14
          Caption = 'Pre'#231'o da Embalagem'
        end
        object Label2: TLabel
          Left = 8
          Top = 15
          Width = 111
          Height = 14
          Caption = 'Pre'#231'o sem Embalagem:'
        end
        object edtPreco: TEditFocus
          Left = 8
          Top = 127
          Width = 185
          Height = 27
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtPreEmb: TEditFocus
          Left = 8
          Top = 79
          Width = 185
          Height = 27
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtPrecoSemEmb: TEditFocus
          Left = 8
          Top = 31
          Width = 185
          Height = 27
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
    object pnlAdicional: TPanel
      Left = 1
      Top = 353
      Width = 453
      Height = 76
      Align = alTop
      Color = 16770261
      TabOrder = 4
      Visible = False
      object lblAdicional: TLabel
        Left = 8
        Top = 27
        Width = 245
        Height = 14
        Caption = 'O LABEL DA INFORMA'#199#195'O ADICIONAL VEM AQUI.'
      end
      object lblPorcentagemDiluente: TLabel
        Left = 352
        Top = 28
        Width = 54
        Height = 14
        Caption = 'Diluente %:'
        Visible = False
      end
      object lblInfoDilu1: TLabel
        Left = 1
        Top = 1
        Width = 451
        Height = 14
        Align = alTop
        Caption = 
          'O percentual de dilui'#231#227'o sugerido pela ind'#250'stria '#233' de 10% para c' +
          'ores lisas '
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
        ExplicitWidth = 408
      end
      object lblInfoDilu2: TLabel
        Left = 1
        Top = 15
        Width = 451
        Height = 14
        Align = alTop
        Caption = 'e 20% para cores met'#225'licas. '
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
        ExplicitWidth = 155
      end
      object cmbListaAdicional: TComboBoxFocus
        Left = 8
        Top = 44
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 0
        OnChange = cmbListaAdicionalChange
        OnClick = cmbListaAdicionalClick
        OnExit = cmbListaAdicionalExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtDil: TEditFocus
        Left = 352
        Top = 44
        Width = 70
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        Text = '0'
        Visible = False
        OnExit = edtDilExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 429
      Width = 453
      Height = 81
      Align = alClient
      Color = 16770261
      TabOrder = 5
      object Label3: TLabel
        Left = 8
        Top = 57
        Width = 38
        Height = 14
        Caption = 'Volume:'
      end
      object lblQtdMinPermitida: TLabel
        Left = 187
        Top = 55
        Width = 147
        Height = 15
        Caption = 'Volume Min'#237'mo Permitido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblPerf: TLabel
        Left = 155
        Top = 21
        Width = 13
        Height = 14
        Caption = '%:'
        Visible = False
      end
      object lblCatalizador: TLabel
        Left = 8
        Top = 2
        Width = 245
        Height = 14
        Caption = 'O LABEL DA INFORMA'#199#195'O ADICIONAL VEM AQUI.'
        Visible = False
      end
      object edtVolume: TEditFocus
        Left = 53
        Top = 53
        Width = 100
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        Text = '0,900'
        OnExit = edtVolumeExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,###0.000'
      end
      object chkComCat: TCheckBox
        Left = 8
        Top = 20
        Width = 145
        Height = 17
        Caption = 'Com Catalisador?'
        TabOrder = 0
        OnClick = chkComCatClick
      end
      object edtVolMinPermitida: TEditFocus
        Left = 339
        Top = 53
        Width = 90
        Height = 22
        Alignment = taRightJustify
        Color = 16770261
        ReadOnly = True
        TabOrder = 2
        Text = '0'
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,###0.000'
      end
      object chkResina325: TCheckBox
        Left = 232
        Top = 20
        Width = 209
        Height = 17
        Caption = 'Resina 325?'
        Enabled = False
        TabOrder = 3
        Visible = False
        OnClick = chkComCatClick
      end
      object edtPerf: TEditFocus
        Left = 169
        Top = 17
        Width = 35
        Height = 22
        Alignment = taRightJustify
        TabOrder = 4
        Text = '0'
        Visible = False
        OnExit = edtPerfExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object cmbListaCatalizador: TComboBoxFocus
        Left = 8
        Top = 17
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 5
        Visible = False
        OnChange = cmbListaCatalizadorChange
        OnExit = cmbListaCatalizadorExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlTrocaEmb: TPanel
      Left = 1
      Top = 101
      Width = 453
      Height = 60
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblProEmb: TLabel
        Left = 8
        Top = 5
        Width = 54
        Height = 14
        Caption = 'Embalagem'
      end
      object edtProEmb: TEditFocus
        Tag = 99
        Left = 6
        Top = 21
        Width = 50
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnExit = edtProEmbExit
        OnKeyPress = edtProEmbKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProEmb: TEditFocus
        Left = 57
        Top = 21
        Width = 388
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    object pnlConsEmb: TPanel
      Left = 1
      Top = 62
      Width = 453
      Height = 39
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object chkConsEmb: TCheckBox
        Left = 8
        Top = 9
        Width = 145
        Height = 17
        Caption = 'Considerar Embalagem'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkConsEmbClick
      end
    end
    object pnlModoVenda: TPanel
      Left = 1
      Top = 1
      Width = 453
      Height = 61
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object rdgModoVenda: TRadioGroup
        Left = 1
        Top = 1
        Width = 451
        Height = 59
        HelpType = htKeyword
        Align = alClient
        Caption = 'Modo de Venda'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '&Concentrado'
          '&Diluido')
        TabOrder = 0
        OnClick = rdgModoVendaClick
        OnExit = rdgModoVendaExit
      end
    end
    object pnlObservacao: TPanel
      Left = 1
      Top = 510
      Width = 453
      Height = 118
      Align = alBottom
      TabOrder = 6
      object Label6: TLabel
        Left = 8
        Top = 40
        Width = 129
        Height = 14
        Caption = 'Observa'#231#227'o para colorista'
      end
      object lblDesAdc: TLabel
        Left = 8
        Top = 78
        Width = 95
        Height = 14
        Caption = 'Descri'#231#227'o Adicional'
      end
      object rdgTipoFormula: TRadioGroup
        Left = 8
        Top = 0
        Width = 226
        Height = 38
        Color = 16770261
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'F'#243'rmula Original'
          'F'#243'rmula Ajustada')
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
      end
      object edtDescricaoColorista: TEditFocus
        Left = 8
        Top = 56
        Width = 437
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 1
        OnExit = edtDescricaoColoristaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesAdc: TEditFocus
        Left = 8
        Top = 93
        Width = 437
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 2
        OnExit = edtDesAdcExit
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
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 40
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 80
  end
end
