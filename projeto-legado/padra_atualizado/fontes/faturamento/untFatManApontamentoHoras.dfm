inherited frmFatManApontamentoHoras: TfrmFatManApontamentoHoras
  Width = 648
  Height = 371
  Caption = 'Apontamento de Horas'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 648
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 326
    Width = 642
    ExplicitTop = 326
    ExplicitWidth = 642
    inherited FlwBotoes: TFlowPanel
      Width = 638
      ExplicitWidth = 638
    end
  end
  inherited pgcDados: TPageControl
    Width = 642
    Height = 326
    Visible = False
    ExplicitWidth = 642
    ExplicitHeight = 326
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 634
      ExplicitHeight = 294
    end
  end
  inherited pnlStatus: TPanel
    Top = 326
    Width = 642
    ExplicitTop = 326
    ExplicitWidth = 642
    inherited pnlNomeForm: TPanel
      Left = 471
      ExplicitLeft = 471
    end
    inherited pnlInfo: TPanel
      Width = 471
      ExplicitWidth = 471
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 642
    Height = 326
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 642
      Height = 191
      Align = alTop
      Caption = 'Dados da Ordem de Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object pnlNOSCli: TPanel
        Left = 2
        Top = 16
        Width = 638
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          638
          32)
        object lblNumero: TLabel
          Left = 32
          Top = 14
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object lblClient: TLabel
          Left = 149
          Top = 14
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object edtNumero: TEditFocus
          Tag = 99
          Left = 74
          Top = 9
          Width = 65
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttInteiro
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 186
          Top = 9
          Width = 65
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 252
          Top = 9
          Width = 381
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
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
      object pnlDadEqu: TPanel
        Left = 2
        Top = 48
        Width = 638
        Height = 139
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          638
          139)
        object lblEquipa: TLabel
          Left = 8
          Top = 5
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Equipamento:'
        end
        object lblMarca_: TLabel
          Left = 39
          Top = 28
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object lblVoltag: TLabel
          Left = 540
          Top = 28
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Voltagem:'
        end
        object lblNSerie: TLabel
          Left = 29
          Top = 53
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#186' S'#233'rie:'
        end
        object lblNumPat: TLabel
          Left = 224
          Top = 53
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#186' Patrim'#244'nio:'
        end
        object lblDadFab: TLabel
          Left = 441
          Top = 53
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dados Fabr.:'
        end
        object lblDefeit: TLabel
          Left = 29
          Top = 80
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Defeitos:'
        end
        object edtCodEqu: TEditFocus
          Tag = 99
          Left = 74
          Top = 1
          Width = 65
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEqu: TEditFocus
          Left = 140
          Top = 1
          Width = 493
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
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
        object edtDesMar: TEditFocus
          Left = 140
          Top = 25
          Width = 389
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
        object edtVoltag: TEditFocus
          Left = 592
          Top = 25
          Width = 41
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          Color = 16768952
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
        object edtNumPat: TEditFocus
          Tag = 99
          Left = 294
          Top = 49
          Width = 130
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtDadFab: TEditFocus
          Tag = 99
          Left = 503
          Top = 49
          Width = 130
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtNSerie: TEditFocus
          Tag = 99
          Left = 74
          Top = 49
          Width = 130
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtDefeit: TMemoFocus
          Tag = 99
          Left = 74
          Top = 73
          Width = 559
          Height = 64
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ScrollBars = ssVertical
          ShowHint = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 74
          Top = 25
          Width = 65
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 191
      Width = 642
      Height = 135
      Align = alClient
      Caption = 'Apontamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlTecnic: TPanel
        Left = 2
        Top = 16
        Width = 638
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          638
          23)
        object lblTecnic: TLabel
          Left = 31
          Top = 4
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'T'#233'cnico:'
        end
        object edtSenTec: TEditFocus
          Tag = 99
          Left = 74
          Top = 0
          Width = 65
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          PasswordChar = '*'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomTec: TEditFocus
          Left = 140
          Top = 0
          Width = 493
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
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
      end
      object pnlFase: TPanel
        Left = 2
        Top = 39
        Width = 638
        Height = 87
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          638
          87)
        object lblEstPrd: TLabel
          Left = 45
          Top = 4
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fase:'
        end
        object cmbFases: TComboBoxFocus
          Left = 74
          Top = 1
          Width = 559
          Height = 22
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = cmbFasesChange
          OnExit = cmbFasesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnInicio: TcxButton
          Left = 74
          Top = 37
          Width = 199
          Height = 41
          Caption = 'In'#237'cio / Abertura'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000003F744558745469746C6500436F6E646974696F6E616C466F726D6174
            74696E7349636F6E5365745369676E73333B436F6E646974696F6E616C466F72
            6D617474696E673BC5369B60000002EB49444154785E5D536F48536F143EEF76
            27685991058549C36CA985454490CD597D8A82FC4384F8A1A2B0D035B5BEE497
            FA90066626044260189893A00F15094EC2922611A39A12A63FB7F99BD3253A37
            67B9393777DFB7F3BE779A74EECECE3D7F9EE73CEFBD5C70F95F084723E86AE3
            FDFCE2EA26FDD3DAE682AFB75A0C511E795E557FAC04FB123A71F8CCE09833C3
            CD47060067025C663A945ED3A47FDBF0AC9859BE36B0414F1B73CC75F188F93D
            56DF5EC46E341EEF3E5F99B70B01AA315F27E03C08F0E5BA23B9B75A4EF83ADF
            D5B021EF13F6D155C72CA3D758F7F025D63352C1FA9DB7D9E0542B7BDE6B62D5
            0FF4B3A5D70F683989A9311FC8DEBC6DC9A7CB759F0BF30B0EA667A44220E402
            CA647120C6008D89480881B48D5930ED5984BE81819EB6BBB6526CC6C8D53B47
            AFECC9CC68371872617E6902C11484AD81C5BF5242D2B4642D58ADA3E0189BBC
            6A7E68EF90240D29D36569613E3C053295D78657592832204E446E81B0077459
            BBC1EDF69663DA250190C31B360344681498185206293A41350817A4D81391E2
            95B2990251B13CFED624949C4649586C17A66C52404281C884AFF2534D0864C6
            B6F01D523C2ECF8796425B89860F5001123F854C5145D6D50881700417AED05F
            3C55C596E9907F6E09C1042895D119B2D3C43D15A4A246454DA8F0FB22105D8E
            0FF315526831FA7ADC1138B57DE70E04F235CA51D8BFC7614CBC4A3510187706
            617121FA125B2B2AEB2BB7D9EB0DFC3731BE006A2209CC9A028C3246BE5D51AF
            8109D76FF0FC1FE8EBED709AB11457057D91D04FE7E2C541DBB4DF3112048224
            04545C8120E1A6226A017662DF6E9B0DB87F046BB11C29ADDECF54D8973F757B
            86866D3EFDB7CFD3EFFB2D1E98F546418E4990A44981F88A0433DE08F45B26C1
            FE69E6C388CD57F0DD3AE3E038CA95D9A71E0B75892F2DF5645966E5D98A7DD6
            22634EB0C494C3CE19B383672A74D6C20BDA2AEC6F4ACC912F9E662832660329
            36E502614C487ED33ACA8992122E29C4A215478F7147108375F6070B79B97E38
            56EEF50000000049454E44AE426082}
          TabOrder = 1
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          OnClick = btnInicioClick
        end
        object btnTermino: TcxButton
          Left = 370
          Top = 37
          Width = 199
          Height = 41
          Caption = 'T'#233'rmino / Parada'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000044744558745469746C6500436F6E646974696F6E616C466F726D6174
            74696E7349636F6E536574526564546F426C61636B343B436F6E646974696F6E
            616C466F726D617474696E673B98A0D4C8000002D249444154785E4D904D685C
            5518869F7373D330C9CC346D8DC224216A37D5858A228822940856A9687ECD4C
            4B25585D68144A8A15244A37AE224840574550680B75E1602A81800846D4855D
            B8C8A2D4D8665A4D9BA449E6CE4C66EEBD73EEF99CCB3D48CFE1E17DCFE17BBF
            8F73902F67620014D076757C64E8467EECDCCD63AF5F593B3E11940AE357AE4F
            8C9E5B1E191A065C40C9DC19626E4D8CF17F78FEC5177A57F363F3EB6F9D90FA
            D9F7447FF681C8DC872D3D2DF54FA6E4F664415646872E5F3AFC7C1FE0C8EC34
            ABA3C300A85F8EBEF468293FBA519E3E2966F694C8C79322670A22D3E322A7F3
            221F9D10F3E9946CBF3F292BC3AFAE5F7CEED9070167E5B5575047FB7A53734F
            3FF57BCFC1FB1FCFA6814A192203825D0262C000D92C5E0D56AF6D2C3CB1B838
            0284EA8F2347DECCF564BFCA0D7442C54B02912401654004B0670C7465289502
            AEAF974F0EFEBAF48DDB81E4D3FBDA61671B8C80DC8B4930582FE06FB237DB4D
            E71D8E01175C9AD19329F1210C40489A609267401232366C7D574795B6307A0C
            687325D007DCDD2A441AB0C546126F9B8808AA8518137B5C1DA1B5E9069413F8
            CD6D5D6B40D08430408216CDB0A521E8F82E44B520C6FA60D727F49B1E805B0B
            FD3FBD5AC7E0FE94C651A0A2640A765A0CB11A00414542B9EE50F5F53220EE46
            3D28AEADABC103398D510206C4181050242A221069C4FA7FB6DAB9DDF0BF059A
            EECCADBFCF7FA11F9ADABFC73994DB2B104560042199AEAC62042258AB4069CB
            FCF8F6E68DF380765742BFF65BD57BC3D1E985A06EEE1BD86750F6D789C56EA3
            E1A6A7B876D7D95AAC7BA780C60FDD03D206C8CF8DEA467B24C554C37DA4E2F1
            B0AB22DA89708D21080D772BB07C07AEEEF053B1E18D7FED97FF02A2BC9B8166
            E1190005B840E6F3AE07DEB998EE5B2A667A77E6D3FDF25D3AB773A133B7349B
            EA7917C8DA3A15BE7C90622A87FA3EDD0F806018AAFDAB803D16D73616400361
            4C2B24DCB3FE03F304B94D918F11270000000049454E44AE426082}
          TabOrder = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          OnClick = btnTerminoClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 584
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 8
  end
end
