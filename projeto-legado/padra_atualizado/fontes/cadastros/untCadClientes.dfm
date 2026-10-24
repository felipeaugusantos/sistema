inherited frmCadClientes: TfrmCadClientes
  Left = 243
  Top = 127
  Width = 1051
  Height = 768
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Clientes'
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1051
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object Label186: TLabel [0]
    Left = 381
    Top = 290
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#186' Conta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label183: TLabel [1]
    Left = 23
    Top = 193
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cidade:'
  end
  inherited pnlBotoes: TPanel
    Top = 658
    Width = 1045
    Height = 65
    ExplicitTop = 658
    ExplicitWidth = 1045
    ExplicitHeight = 65
    object Panel6: TPanel [0]
      Left = 2
      Top = 2
      Width = 1041
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1041
      Height = 61
      Align = alBottom
      ExplicitTop = 2
      ExplicitWidth = 1041
      ExplicitHeight = 61
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        ExplicitWidth = 76
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 76
        ExplicitLeft = 76
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 152
        Width = 76
        ExplicitLeft = 152
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 228
        Width = 76
        ExplicitLeft = 228
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 304
        Width = 76
        ExplicitLeft = 304
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 380
        Width = 76
        ExplicitLeft = 380
        ExplicitWidth = 76
      end
      object btnObsCli: TBitBtnLocked
        Left = 456
        Top = 0
        Width = 93
        Height = 20
        Caption = '[ F2 ] Observa'#231#227'o'
        TabOrder = 6
        OnClick = btnObsCliClick
      end
      object btnTeleatendimento: TBitBtnLocked
        Left = 549
        Top = 0
        Width = 112
        Height = 20
        Caption = '[ F3 ] Teleatendimento'
        TabOrder = 7
        OnClick = btnTeleatendimentoClick
      end
      object btnCliVen: TBitBtnLocked
        Left = 661
        Top = 0
        Width = 97
        Height = 20
        Caption = '[ F4 ] Vendedores'
        TabOrder = 8
        OnClick = btnCliVenClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 758
        Top = 0
        Width = 77
        Height = 20
        Caption = 'Heran'#231'a'
        Enabled = False
        TabOrder = 9
        OnClick = btnHerancaClick
      end
      object btnContratos: TBitBtnLocked
        Left = 835
        Top = 0
        Width = 86
        Height = 20
        Caption = '[ F5 ] Contratos'
        TabOrder = 10
        OnClick = btnContratosClick
      end
      object btnHisDeb: TBitBtnLocked
        Left = 921
        Top = 0
        Width = 80
        Height = 20
        Caption = '[ F6 ] C./C.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = btnHisDebClick
      end
      object btnResFin: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 129
        Height = 20
        Caption = '[ F7 ] Resumo Financeiro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        OnClick = btnResFinClick
      end
      object btnFichaCli: TBitBtnLocked
        Left = 129
        Top = 20
        Width = 114
        Height = 20
        Caption = '[ F8 ] Ficha Cad.'
        Enabled = False
        TabOrder = 13
        OnClick = btnFichaCliClick
      end
      object btnVenCli: TBitBtnLocked
        Left = 243
        Top = 20
        Width = 97
        Height = 20
        Caption = '[ F9 ] Ven. p/ Cli.'
        Enabled = False
        TabOrder = 14
        OnClick = btnVenCliClick
      end
      object btnInfCobr: TBitBtnLocked
        Left = 340
        Top = 20
        Width = 107
        Height = 20
        Caption = '[ F10 ] Inf. Cobran'#231'a'
        TabOrder = 15
        OnClick = btnInfCobrClick
      end
      object btnLogAlter: TBitBtnLocked
        Left = 447
        Top = 20
        Width = 98
        Height = 20
        Caption = '[ F11 ] Log Alter'
        TabOrder = 16
        OnClick = btnLogAlterClick
      end
      object btnCadDiv: TBitBtnLocked
        Left = 545
        Top = 20
        Width = 100
        Height = 20
        Caption = 'Cadastro Diversos'
        TabOrder = 17
        OnClick = btnCadDivClick
      end
      object btnAltPar: TBitBtnLocked
        Left = 645
        Top = 20
        Width = 100
        Height = 20
        Caption = 'Alt. Particip. Sped'
        TabOrder = 18
        OnClick = btnAltParClick
      end
      object btnCadFor: TBitBtnLocked
        Left = 745
        Top = 20
        Width = 129
        Height = 20
        Caption = 'Cadastro Fornecedores'
        Enabled = False
        TabOrder = 19
        OnClick = btnCadForClick
      end
      object btnCadTransportadora: TBitBtnLocked
        Left = 874
        Top = 20
        Width = 127
        Height = 20
        Caption = 'Cad. Transportadora'
        Enabled = False
        TabOrder = 20
        OnClick = btnCadTransportadoraClick
      end
      object btnPlaNco: TBitBtnLocked
        Left = 0
        Top = 40
        Width = 97
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 21
        OnClick = btnPlaNcoClick
      end
      object btnForMarNaoPermitidos: TBitBtnLocked
        Left = 97
        Top = 40
        Width = 175
        Height = 20
        Caption = '[ ALT+F3 ] Fornecedores e Marcas'
        TabOrder = 22
        OnClick = btnForMarNaoPermitidosClick
      end
      object btnCliOutroVendedor: TBitBtnLocked
        Left = 272
        Top = 40
        Width = 142
        Height = 20
        Align = alCustom
        Caption = 'Cliente de outro vendedor'
        Layout = blGlyphBottom
        ParentShowHint = False
        ShowHint = True
        TabOrder = 23
        TabStop = False
        WordWrap = True
        OnClick = btnCliOutroVendedorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 964
      Top = 42
      Width = 79
      Height = 20
      ExplicitLeft = 964
      ExplicitTop = 42
      ExplicitWidth = 79
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1045
    ExplicitTop = 723
    ExplicitWidth = 1045
    inherited pnlNomeForm: TPanel
      Left = 845
      Width = 200
      ExplicitLeft = 845
      ExplicitWidth = 200
    end
    inherited pnlInfo: TPanel
      Width = 845
      ExplicitWidth = 845
    end
  end
  inherited pgcDados: TPageControl
    Width = 1045
    Height = 658
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    StyleElements = []
    OnChange = pgcDadosChange
    OnMouseDown = pgcDadosMouseDown
    OnMouseLeave = pgcDadosMouseLeave
    OnMouseMove = pgcDadosMouseMove
    ExplicitWidth = 1045
    ExplicitHeight = 658
    inherited tbsGeral: TTabSheet
      Caption = '1 - Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1037
      ExplicitHeight = 626
      object pnlFundo1: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 485
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 58
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
        object Label2: TLabel
          Left = 18
          Top = 28
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data Cadastro:'
        end
        object Label3: TLabel
          Left = 24
          Top = 72
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
          Left = 16
          Top = 93
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fantasia / Sobr.:'
        end
        object Label5: TLabel
          Left = 45
          Top = 138
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label6: TLabel
          Left = 556
          Top = 160
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object LabelRg: TLabelRg
          Left = 70
          Top = 225
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'RG:'
          Pais = opcBrasil
        end
        object Label12: TLabelCgcCpf
          Left = 24
          Top = 50
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = '1-CNPJ/2-CPF:'
          Pais = opcBrasil
        end
        object Label10: TLabel
          Left = 3
          Top = 247
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Inscri'#231#227'o Estadual:'
        end
        object Label13: TLabel
          Left = 575
          Top = 225
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Insc. Munic. Prod.:'
        end
        object Label14: TLabel
          Left = 713
          Top = 269
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 1:'
        end
        object Label15: TLabel
          Left = 907
          Top = 268
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ramal:'
        end
        object Label16: TLabel
          Left = 41
          Top = 293
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 2:'
        end
        object Label17: TLabel
          Left = 239
          Top = 291
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ramal:'
        end
        object Label18: TLabel
          Left = 743
          Top = 291
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'FAX:'
        end
        object Label19: TLabel
          Left = 907
          Top = 290
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ramal:'
        end
        object Label20: TLabel
          Left = 58
          Top = 313
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Celular:'
        end
        object Label21: TLabel
          Left = 2
          Top = 269
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Funda'#231#227'o/Nascim.:'
        end
        object Label22: TLabel
          Left = 221
          Top = 269
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cx. Postal:'
        end
        object Label23: TLabel
          Left = 581
          Top = 337
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato:'
        end
        object Label24: TLabel
          Left = 47
          Top = 337
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail - 1:'
        end
        object Label25: TLabel
          Left = 564
          Top = 379
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Home Page:'
        end
        object Label26: TLabel
          Left = 9
          Top = 379
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Consumidor Final:'
        end
        object Label36: TLabel
          Left = 44
          Top = 401
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object Label38: TLabel
          Left = 547
          Top = 401
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Representante:'
        end
        object Label40: TLabel
          Left = 46
          Top = 445
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
        end
        object Label42: TLabel
          Left = 13
          Top = 466
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'Limite de Cr'#233'dito:'
        end
        object Label43: TLabel
          Left = 473
          Top = 27
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = #218'lt. Altera.:'
        end
        object Label37: TLabel
          Left = 667
          Top = 5
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object ColorLabel1: TColorLabel
          Left = 755
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
        object ColorLabel2: TColorLabel
          Left = 138
          Top = 379
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
        object Label27: TLabel
          Left = 541
          Top = 445
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tabela de Pre'#231'o:'
        end
        object clbPrcVenda: TColorLabel
          Left = 662
          Top = 444
          Width = 120
          Height = 14
          Caption = 'Pre'#231'o de Venda (1) a (7)'
          CorDestaque = clRed
        end
        object Label189: TLabel
          Left = 549
          Top = 138
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object Label190: TLabel
          Left = 27
          Top = 160
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label192: TLabel
          Left = 559
          Top = 357
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail NFe 2:'
        end
        object Label198: TLabel
          Left = 9
          Top = 423
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Supervisor Geral:'
        end
        object Label199: TLabel
          Left = 521
          Top = 423
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Supervisor Regional:'
        end
        object Label200: TLabel
          Left = 41
          Top = 357
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail NFe:'
        end
        object spbFone2: TSpeedButton
          Left = 211
          Top = 288
          Width = 23
          Height = 21
          Hint = 'ID_FO2'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            2702272727022727270227272702272727022727270227272702272727023333
            33028A786183A28967B8A28966B8937E62A04040400600000000423E3917A790
            71C3A78F70C5A68E6FC5A68E6EC5A68D6DC5A68D6CC5A58C6BC5A58C6AC5A48B
            69C6BC9B6EEECFA874FFCEA772FFBE9B6AF7907C60AF3434340748433C21D4B0
            83FFD1B187FFCCAD86FFD2AD7FFFCDB089FFCDAA7CFFCFAD81FFCAAA80FFCFA9
            77FFCAA574FFD0AA77FFCFA976FFC5A06EFFB19268E13434340948433C21D5B2
            86FFE3D1BBFFDDD3C6FFD5B58CFFE8DDD0FFD1B897FFE2D0B9FFD9CAB6FFD0AB
            79FFCBA677FFD1AC7BFFD0AB79FFC6A171FFB1936AE13434340949433D21D6B4
            89FFDBC7ADFFD1C2AFFFD5B48BFFD9CBB8FFCDB390FFD9C5AAFFCEBCA4FFD1AC
            7CFFCCA87AFFD2AD7EFFD1AC7CFFC7A374FFB2946CE13434340949443D21D7B6
            8DFFDAC2A5FFD2BFA7FFD5B48AFFDAC9B3FFD0B38EFFD8C0A0FFD1BCA1FFD2AE
            7EFFCDAA7DFFD3AF81FFD2AE7FFFC8A477FFB3956EE13434340949443E21D8B8
            91FFE4D3BDFFDDD0C0FFD8BA94FFE8DDD0FFD3BB9CFFE3D2BCFFDACBB8FFD3AF
            81FFCEAC81FFD4B185FFD4B083FFC9A67AFFB39670E13434340949443F21DABB
            95FFDECBB5FFD2C4B4FFD8BA95FFDBCFBFFFCFB798FFDCC9B1FFD0BFABFFD4B0
            84FFCFAE84FFD6B489FFD5B286FFCAA87DFFB49772E13434340949453F21DBBD
            99FFDFC6A7FFDDC5A9FFD9BA95FFE0C9ACFFD7BA95FFDCC19FFFDABF9FFFD5B2
            87FFD0B089FFD7B68EFFD6B58BFFCBAA81FFB59874E1343434094A454021DCC0
            9DFFE6D6C3FFEEE5DBFFEDE5DBFFEDE4DAFFEDE4D9FFEDE4D9FFE8DCCDFFD6B5
            8BFFD2B38DFFD9B993FFD8B890FFCCAC85FFB59A76E1343434094A454121DEC2
            A2FFE4D9CDFFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFE6E1DCFFD7B7
            8FFFD3B692FFDBBC98FFDABB95FFCEAF89FFB69B78E1343434094A464121DFC4
            A6FFDEC8AEFFDDCAB3FFDDC9B1FFDCC8AFFFDCC7AEFFDBC6ACFFDAC3A7FFD9B9
            93FFD5B896FFDCBF9DFFDBBE9AFFCFB28EFFB79C7BE1343434094A464219C0AC
            96C9BFAB94C9BEAA92C9BEA990C9BDA88EC9BDA68CC9BCA58AC9BBA489C9BBA3
            87C9CEB497F0DEC2A2FFDDC19FFFCDB291F8A18D74B034343405000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000A0928291C1AC95CDC0AB92CDAB9985B1403F3E0400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbFone1Click
        end
        object spbFone1: TSpeedButton
          Left = 878
          Top = 266
          Width = 23
          Height = 21
          Hint = 'ID_FO1'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            2702272727022727270227272702272727022727270227272702272727023333
            33028A786183A28967B8A28966B8937E62A04040400600000000423E3917A790
            71C3A78F70C5A68E6FC5A68E6EC5A68D6DC5A68D6CC5A58C6BC5A58C6AC5A48B
            69C6BC9B6EEECFA874FFCEA772FFBE9B6AF7907C60AF3434340748433C21D4B0
            83FFD1B187FFCCAD86FFD2AD7FFFCDB089FFCDAA7CFFCFAD81FFCAAA80FFCFA9
            77FFCAA574FFD0AA77FFCFA976FFC5A06EFFB19268E13434340948433C21D5B2
            86FFE3D1BBFFDDD3C6FFD5B58CFFE8DDD0FFD1B897FFE2D0B9FFD9CAB6FFD0AB
            79FFCBA677FFD1AC7BFFD0AB79FFC6A171FFB1936AE13434340949433D21D6B4
            89FFDBC7ADFFD1C2AFFFD5B48BFFD9CBB8FFCDB390FFD9C5AAFFCEBCA4FFD1AC
            7CFFCCA87AFFD2AD7EFFD1AC7CFFC7A374FFB2946CE13434340949443D21D7B6
            8DFFDAC2A5FFD2BFA7FFD5B48AFFDAC9B3FFD0B38EFFD8C0A0FFD1BCA1FFD2AE
            7EFFCDAA7DFFD3AF81FFD2AE7FFFC8A477FFB3956EE13434340949443E21D8B8
            91FFE4D3BDFFDDD0C0FFD8BA94FFE8DDD0FFD3BB9CFFE3D2BCFFDACBB8FFD3AF
            81FFCEAC81FFD4B185FFD4B083FFC9A67AFFB39670E13434340949443F21DABB
            95FFDECBB5FFD2C4B4FFD8BA95FFDBCFBFFFCFB798FFDCC9B1FFD0BFABFFD4B0
            84FFCFAE84FFD6B489FFD5B286FFCAA87DFFB49772E13434340949453F21DBBD
            99FFDFC6A7FFDDC5A9FFD9BA95FFE0C9ACFFD7BA95FFDCC19FFFDABF9FFFD5B2
            87FFD0B089FFD7B68EFFD6B58BFFCBAA81FFB59874E1343434094A454021DCC0
            9DFFE6D6C3FFEEE5DBFFEDE5DBFFEDE4DAFFEDE4D9FFEDE4D9FFE8DCCDFFD6B5
            8BFFD2B38DFFD9B993FFD8B890FFCCAC85FFB59A76E1343434094A454121DEC2
            A2FFE4D9CDFFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFE6E1DCFFD7B7
            8FFFD3B692FFDBBC98FFDABB95FFCEAF89FFB69B78E1343434094A464121DFC4
            A6FFDEC8AEFFDDCAB3FFDDC9B1FFDCC8AFFFDCC7AEFFDBC6ACFFDAC3A7FFD9B9
            93FFD5B896FFDCBF9DFFDBBE9AFFCFB28EFFB79C7BE1343434094A464219C0AC
            96C9BFAB94C9BEAA92C9BEA990C9BDA88EC9BDA68CC9BCA58AC9BBA489C9BBA3
            87C9CEB497F0DEC2A2FFDDC19FFFCDB291F8A18D74B034343405000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000A0928291C1AC95CDC0AB92CDAB9985B1403F3E0400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbFone1Click
        end
        object spbCel: TSpeedButton
          Left = 320
          Top = 310
          Width = 23
          Height = 21
          Hint = 'ID_CEL'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            2702272727022727270227272702272727022727270227272702272727023333
            33028A786183A28967B8A28966B8937E62A04040400600000000423E3917A790
            71C3A78F70C5A68E6FC5A68E6EC5A68D6DC5A68D6CC5A58C6BC5A58C6AC5A48B
            69C6BC9B6EEECFA874FFCEA772FFBE9B6AF7907C60AF3434340748433C21D4B0
            83FFD1B187FFCCAD86FFD2AD7FFFCDB089FFCDAA7CFFCFAD81FFCAAA80FFCFA9
            77FFCAA574FFD0AA77FFCFA976FFC5A06EFFB19268E13434340948433C21D5B2
            86FFE3D1BBFFDDD3C6FFD5B58CFFE8DDD0FFD1B897FFE2D0B9FFD9CAB6FFD0AB
            79FFCBA677FFD1AC7BFFD0AB79FFC6A171FFB1936AE13434340949433D21D6B4
            89FFDBC7ADFFD1C2AFFFD5B48BFFD9CBB8FFCDB390FFD9C5AAFFCEBCA4FFD1AC
            7CFFCCA87AFFD2AD7EFFD1AC7CFFC7A374FFB2946CE13434340949443D21D7B6
            8DFFDAC2A5FFD2BFA7FFD5B48AFFDAC9B3FFD0B38EFFD8C0A0FFD1BCA1FFD2AE
            7EFFCDAA7DFFD3AF81FFD2AE7FFFC8A477FFB3956EE13434340949443E21D8B8
            91FFE4D3BDFFDDD0C0FFD8BA94FFE8DDD0FFD3BB9CFFE3D2BCFFDACBB8FFD3AF
            81FFCEAC81FFD4B185FFD4B083FFC9A67AFFB39670E13434340949443F21DABB
            95FFDECBB5FFD2C4B4FFD8BA95FFDBCFBFFFCFB798FFDCC9B1FFD0BFABFFD4B0
            84FFCFAE84FFD6B489FFD5B286FFCAA87DFFB49772E13434340949453F21DBBD
            99FFDFC6A7FFDDC5A9FFD9BA95FFE0C9ACFFD7BA95FFDCC19FFFDABF9FFFD5B2
            87FFD0B089FFD7B68EFFD6B58BFFCBAA81FFB59874E1343434094A454021DCC0
            9DFFE6D6C3FFEEE5DBFFEDE5DBFFEDE4DAFFEDE4D9FFEDE4D9FFE8DCCDFFD6B5
            8BFFD2B38DFFD9B993FFD8B890FFCCAC85FFB59A76E1343434094A454121DEC2
            A2FFE4D9CDFFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFE6E1DCFFD7B7
            8FFFD3B692FFDBBC98FFDABB95FFCEAF89FFB69B78E1343434094A464121DFC4
            A6FFDEC8AEFFDDCAB3FFDDC9B1FFDCC8AFFFDCC7AEFFDBC6ACFFDAC3A7FFD9B9
            93FFD5B896FFDCBF9DFFDBBE9AFFCFB28EFFB79C7BE1343434094A464219C0AC
            96C9BFAB94C9BEAA92C9BEA990C9BDA88EC9BDA68CC9BCA58AC9BBA489C9BBA3
            87C9CEB497F0DEC2A2FFDDC19FFFCDB291F8A18D74B034343405000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000A0928291C1AC95CDC0AB92CDAB9985B1403F3E0400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbFone1Click
        end
        object Label60: TLabel
          Left = 359
          Top = 225
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Expedi'#231#227'o:'
        end
        object lblEstadoEmissor: TLabel
          Left = 3
          Top = 203
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado Emiss. CPF:'
        end
        object lbl5: TLabel
          Left = 592
          Top = 27
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object lbl7: TLabel
          Left = 712
          Top = 313
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'ID-NEXTEL:'
        end
        object spbNex: TSpeedButton
          Left = 973
          Top = 310
          Width = 23
          Height = 21
          Hint = 'ID_NEX'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            2702272727022727270227272702272727022727270227272702272727023333
            33028A786183A28967B8A28966B8937E62A04040400600000000423E3917A790
            71C3A78F70C5A68E6FC5A68E6EC5A68D6DC5A68D6CC5A58C6BC5A58C6AC5A48B
            69C6BC9B6EEECFA874FFCEA772FFBE9B6AF7907C60AF3434340748433C21D4B0
            83FFD1B187FFCCAD86FFD2AD7FFFCDB089FFCDAA7CFFCFAD81FFCAAA80FFCFA9
            77FFCAA574FFD0AA77FFCFA976FFC5A06EFFB19268E13434340948433C21D5B2
            86FFE3D1BBFFDDD3C6FFD5B58CFFE8DDD0FFD1B897FFE2D0B9FFD9CAB6FFD0AB
            79FFCBA677FFD1AC7BFFD0AB79FFC6A171FFB1936AE13434340949433D21D6B4
            89FFDBC7ADFFD1C2AFFFD5B48BFFD9CBB8FFCDB390FFD9C5AAFFCEBCA4FFD1AC
            7CFFCCA87AFFD2AD7EFFD1AC7CFFC7A374FFB2946CE13434340949443D21D7B6
            8DFFDAC2A5FFD2BFA7FFD5B48AFFDAC9B3FFD0B38EFFD8C0A0FFD1BCA1FFD2AE
            7EFFCDAA7DFFD3AF81FFD2AE7FFFC8A477FFB3956EE13434340949443E21D8B8
            91FFE4D3BDFFDDD0C0FFD8BA94FFE8DDD0FFD3BB9CFFE3D2BCFFDACBB8FFD3AF
            81FFCEAC81FFD4B185FFD4B083FFC9A67AFFB39670E13434340949443F21DABB
            95FFDECBB5FFD2C4B4FFD8BA95FFDBCFBFFFCFB798FFDCC9B1FFD0BFABFFD4B0
            84FFCFAE84FFD6B489FFD5B286FFCAA87DFFB49772E13434340949453F21DBBD
            99FFDFC6A7FFDDC5A9FFD9BA95FFE0C9ACFFD7BA95FFDCC19FFFDABF9FFFD5B2
            87FFD0B089FFD7B68EFFD6B58BFFCBAA81FFB59874E1343434094A454021DCC0
            9DFFE6D6C3FFEEE5DBFFEDE5DBFFEDE4DAFFEDE4D9FFEDE4D9FFE8DCCDFFD6B5
            8BFFD2B38DFFD9B993FFD8B890FFCCAC85FFB59A76E1343434094A454121DEC2
            A2FFE4D9CDFFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFE6E1DCFFD7B7
            8FFFD3B692FFDBBC98FFDABB95FFCEAF89FFB69B78E1343434094A464121DFC4
            A6FFDEC8AEFFDDCAB3FFDDC9B1FFDCC8AFFFDCC7AEFFDBC6ACFFDAC3A7FFD9B9
            93FFD5B896FFDCBF9DFFDBBE9AFFCFB28EFFB79C7BE1343434094A464219C0AC
            96C9BFAB94C9BEAA92C9BEA990C9BDA88EC9BDA68CC9BCA58AC9BBA489C9BBA3
            87C9CEB497F0DEC2A2FFDDC19FFFCDB291F8A18D74B034343405000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000A0928291C1AC95CDC0AB92CDAB9985B1403F3E0400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbFone1Click
        end
        object lblLatitu: TLabel
          Left = 630
          Top = 182
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Latitude:'
        end
        object lblLongit: TLabel
          Left = 755
          Top = 182
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Longitude:'
        end
        object lblRaio__: TLabel
          Left = 897
          Top = 182
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Raio: '
        end
        object spbDicaAbas: TSpeedButton
          Left = 837
          Top = 3
          Width = 20
          Height = 20
          Flat = True
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
          ParentShowHint = False
          ShowHint = False
          OnClick = spbDicaAbasClick
        end
        object spbFax: TSpeedButton
          Left = 878
          Top = 288
          Width = 23
          Height = 21
          Hint = 'ID_FAX'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            2702272727022727270227272702272727022727270227272702272727023333
            33028A786183A28967B8A28966B8937E62A04040400600000000423E3917A790
            71C3A78F70C5A68E6FC5A68E6EC5A68D6DC5A68D6CC5A58C6BC5A58C6AC5A48B
            69C6BC9B6EEECFA874FFCEA772FFBE9B6AF7907C60AF3434340748433C21D4B0
            83FFD1B187FFCCAD86FFD2AD7FFFCDB089FFCDAA7CFFCFAD81FFCAAA80FFCFA9
            77FFCAA574FFD0AA77FFCFA976FFC5A06EFFB19268E13434340948433C21D5B2
            86FFE3D1BBFFDDD3C6FFD5B58CFFE8DDD0FFD1B897FFE2D0B9FFD9CAB6FFD0AB
            79FFCBA677FFD1AC7BFFD0AB79FFC6A171FFB1936AE13434340949433D21D6B4
            89FFDBC7ADFFD1C2AFFFD5B48BFFD9CBB8FFCDB390FFD9C5AAFFCEBCA4FFD1AC
            7CFFCCA87AFFD2AD7EFFD1AC7CFFC7A374FFB2946CE13434340949443D21D7B6
            8DFFDAC2A5FFD2BFA7FFD5B48AFFDAC9B3FFD0B38EFFD8C0A0FFD1BCA1FFD2AE
            7EFFCDAA7DFFD3AF81FFD2AE7FFFC8A477FFB3956EE13434340949443E21D8B8
            91FFE4D3BDFFDDD0C0FFD8BA94FFE8DDD0FFD3BB9CFFE3D2BCFFDACBB8FFD3AF
            81FFCEAC81FFD4B185FFD4B083FFC9A67AFFB39670E13434340949443F21DABB
            95FFDECBB5FFD2C4B4FFD8BA95FFDBCFBFFFCFB798FFDCC9B1FFD0BFABFFD4B0
            84FFCFAE84FFD6B489FFD5B286FFCAA87DFFB49772E13434340949453F21DBBD
            99FFDFC6A7FFDDC5A9FFD9BA95FFE0C9ACFFD7BA95FFDCC19FFFDABF9FFFD5B2
            87FFD0B089FFD7B68EFFD6B58BFFCBAA81FFB59874E1343434094A454021DCC0
            9DFFE6D6C3FFEEE5DBFFEDE5DBFFEDE4DAFFEDE4D9FFEDE4D9FFE8DCCDFFD6B5
            8BFFD2B38DFFD9B993FFD8B890FFCCAC85FFB59A76E1343434094A454121DEC2
            A2FFE4D9CDFFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFEAEAE9FFE6E1DCFFD7B7
            8FFFD3B692FFDBBC98FFDABB95FFCEAF89FFB69B78E1343434094A464121DFC4
            A6FFDEC8AEFFDDCAB3FFDDC9B1FFDCC8AFFFDCC7AEFFDBC6ACFFDAC3A7FFD9B9
            93FFD5B896FFDCBF9DFFDBBE9AFFCFB28EFFB79C7BE1343434094A464219C0AC
            96C9BFAB94C9BEAA92C9BEA990C9BDA88EC9BDA68CC9BCA58AC9BBA489C9BBA3
            87C9CEB497F0DEC2A2FFDDC19FFFCDB291F8A18D74B034343405000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000A0928291C1AC95CDC0AB92CDAB9985B1403F3E0400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = spbFone1Click
        end
        object lblNire: TLabel
          Left = 385
          Top = 247
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'NIRE:'
        end
        object lblValLim: TLabel
          Left = 532
          Top = 466
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Validade do Limite:'
        end
        object lblDtDEPS: TLabel
          Left = 747
          Top = 466
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltima consulta Sistema DEPS:'
        end
        object lblQntCaracteresEnd: TLabel
          Left = 270
          Top = 181
          Width = 250
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total de caracteres do end. de entrega para Nfe: 00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object imgWpp: TImage
          Left = 5
          Top = 312
          Width = 16
          Height = 16
          AutoSize = True
          Center = True
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            000000100803000000282D0F530000000467414D410000B18F0BFC6105000000
            206348524D00007A26000080840000FA00000080E8000075300000EA6000003A
            98000017709CBA513C00000285504C5445EDEDEDFEFEFEFDFDFDFFFFFFEFEFEF
            FBFBFBEEEEEEF0F0F0F1F1F1ECECECE0E0E0F7F8F7FFFEFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFEFFF9FAF9FBFBFBFFFFFFFCFEFCFAFEFAFFFFFFFB
            FBFBF9F9F9FFFEFFFFFFFFFAFAFAE7E7E7FFFDFFFFFEFFF1F1F1FBFAFAFDFEFD
            FBFDFBFBFBFBFFFDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFD
            FFFFFDFFFBF9FBFCFAFBF3F3F3FEFDFDF3F3F3FAFAFAFEFEFEF8F7F8BCBCBCFE
            FDFEF3FBF4F7FBF8F9F8F9E8E9E8FDFDFDF6FBF7FEFDFDFFFDFFF1F9F2FEFCFD
            F7F6F6E6E7E6F8F8F8F8F8F8F6F5F6F0F0F0EEEEEEF6F5F6FCF9FCFEFBFEFEFB
            FEFCFAFCF7F6F7DAF5DDB0EAB598E39FADE9B3D7F4D9EDFAEE9AE3A261D36C55
            D06154D0605FD36B94E19CE9F9EAEEFAEF83DC8C50CD5D55CF6152CE5F7CDA86
            E9F9EB9DE3A54CCB5A89DD93C4EEC967D3734DCB5B4ECB5C93E09CE1F6E35BCE
            6954CC62DAF4DDFFFFFF9FE3A748C8574AC95949C95857CD64D9F4DCB9EABF45
            C65554CB62DEF5E1A6E4AD46C65646C75644C654AFE7B6A2E2AA3FC35042C453
            A7E4AFFBFEFB7CD6873EC34F42C45241C45240C3513FC34F97DFA0A5E2AD3BC1
            4D3CC14E53C862D5F2D9D8F3DB5ECC6C39C04B49C55A59CA683FC2503DC14F3B
            C14C99DFA2C1EBC73DC04F39BF4C37BE4A62CC71DFF4E2E2F6E48BDA96B1E6B8
            EAF8ECA4E2AC43C255B6E8BD5AC96933BC4735BD4859C869BFEAC5F5FCF6D6F1
            DA42C15550C561E4F6E798DDA22FB94331BA4538BD4C64CB7397DCA29FDFA95A
            C86A33BB47A5E1AD80D48D27B53C2BB7412AB7402CB7412AB73F28B63D2FB844
            8BD897F6FBF782D48F89D7959FDEA95CC76D33B9482AB54029B53F32B84757C5
            68AFE4B7FDFEFDCEEED3B4E5BCB3E5BBCCEDD1EFF9F0D58BAB87000000527452
            4E5300000000000000000000000445A5E3FBFCE5AB4C06148DEDF0971A13AAB6
            1A038998063FEAF14E9BADD8E6F1FCEFFBD2E190A036EA3F2AE2830263FAFE9E
            0FA9FCE7E5FEE27A0EC6AE6B323182C4E2E3C788B6487A6D00000001624B4744
            03110C4CF20000000970485973000014C3000014C30115704D42000000077449
            4D4507E60A11142219762A9F280000011B4944415418D3011001EFFE00000102
            0B0C0D0E0F101112131402030400020215161752535454555618191A02030005
            1B1C5758595A5B5B5A5C5D5E1D1E05001F205F60616263636363636164652122
            002324666768696A6B6C6C6C6C676D252600276E6F7071727374757575757677
            78280029797A7B7C727D7A7E7F7F7F7F80812A002B82838485868788898A8B89
            898C8D2C002D8E8F909192939495969798999A9B2E002F9C9D9E9FA0A1A2A3A4
            A5A6A79EA8300031A5A9AAABAAACADAE7272AFB0B1B23200332AB3B4B5B5B4B6
            B7B8B9BABBBC3435003637BDBEBFC0C1C1C2C2C3C4C5C63839003A3BC7C8C9CA
            CBCCCDCECFD03C3D3E06003FD140414243D2D3D4D5D64445460708004748494A
            4B4C4D4E4F50514B0309040AD48F69A2B3084A4B000000257445587464617465
            3A63726561746500323032322D31302D31375432303A33333A34332B30303A30
            301BEDAACA0000002574455874646174653A6D6F6469667900323032322D3130
            2D31375432303A33333A34332B30303A30306AB012760000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000000049
            454E44AE426082}
          Visible = False
        end
        object lblLimiteAlpe: TLabel
          Left = 417
          Top = 466
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Limite Alpe:'
          Visible = False
        end
        object Label8: TLabel
          Left = 606
          Top = 116
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label7: TLabel
          Left = 193
          Top = 116
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label9: TLabel
          Left = 72
          Top = 116
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object spdHelpLimCre: TSpeedButton
          Left = 323
          Top = 464
          Width = 20
          Height = 20
          Flat = True
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
          ParentShowHint = False
          ShowHint = False
          OnClick = spdHelpLimCreClick
        end
        object lblIDEstrangeiro: TLabel
          Left = 233
          Top = 27
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'ID Estrangeiro:'
        end
        object dbeCpfDev: TDBEditCgcCpf
          Tag = 99
          Left = 187
          Top = 46
          Width = 374
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CPFDEV'
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
          Visible = False
          OnExit = dbeNuCpnjExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
          Tipo = C_G_C_
        end
        object dbeCodCli: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 2
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODCLI'
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
        object dbeDtaCad: TDBEditFocus
          Left = 100
          Top = 24
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CLI_DTACAD'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomCli: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 68
          Width = 757
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_NOMCLI'
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
          OnChange = dbeNomCliChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFanSob: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 90
          Width = 757
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_FANSOB'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndere: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 134
          Width = 420
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_ENDERE'
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
          OnChange = dbeEndereChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBairro: TDBEditFocus
          Tag = 99
          Left = 591
          Top = 156
          Width = 407
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_BAIRRO'
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
        object dbeNumRg: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 221
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_NUMR_G'
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
        object dbeCgcCpf: TDBEditTipoCgcCpf
          Tag = 99
          Left = 100
          Top = 46
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CGCCPF'
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
          OnExit = dbeCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNuCpnj: TDBEditCgcCpf
          Tag = 99
          Left = 187
          Top = 46
          Width = 374
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_C_G_C_'
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
          OnExit = dbeNuCpnjExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
          Tipo = C_G_C_
        end
        object dbeNumIes: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 243
          Width = 243
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_I_E_S_'
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
          OnExit = dbeNumIesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumImp: TDBEditFocus
          Tag = 99
          Left = 667
          Top = 221
          Width = 204
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_I_M_P_'
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
        object dbeFone01: TDBEditFocus
          Tag = 99
          Left = 772
          Top = 265
          Width = 105
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_FONE01'
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
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeRamal1: TDBEditFocus
          Tag = 99
          Left = 944
          Top = 265
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_RAMAL1'
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
        object dbeFone02: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 287
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_FONE02'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeRama2: TDBEditFocus
          Tag = 99
          Left = 276
          Top = 287
          Width = 67
          Height = 22
          DataField = 'CLI_RAMAL2'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 35
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumFax: TDBEditFocus
          Tag = 99
          Left = 772
          Top = 287
          Width = 105
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_F_A_X_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 36
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeRama3: TDBEditFocus
          Tag = 99
          Left = 944
          Top = 287
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_RAMAL3'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 37
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumCel: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 309
          Width = 218
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CELULA'
          DataSource = dtsTabela
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
        object dbeDtaNas: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 265
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_NASCIM'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCaiPos: TDBEditFocus
          Tag = 99
          Left = 276
          Top = 265
          Width = 67
          Height = 22
          DataField = 'CLI_CAIPOS'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeContat: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 331
          Width = 376
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CONTAT'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 41
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmail: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 331
          Width = 420
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_EMAIL_'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 254
          ParentFont = False
          TabOrder = 40
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHomPag: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 375
          Width = 376
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_HOMEPA'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 45
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConsum: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 375
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CONSUM'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 44
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeCodVen: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 397
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODVEN'
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
          OnKeyPress = dbeCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodVenChamaCadastro
        end
        object dbeCodRep: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 397
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODREP'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 47
          OnKeyPress = dbeCodRepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodVenChamaCadastro
        end
        object dbeCodAti: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 441
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODATI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 52
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
        object dbeLimCre: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 463
          Width = 93
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_LIMCRE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 55
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUltAlt: TDBEditFocus
          Tag = 99
          Left = 527
          Top = 24
          Width = 60
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CLI_DTAALT'
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
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeStatus: TDBEditFocus
          Tag = 99
          Left = 716
          Top = 2
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_STATUS'
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
        object edtVendedor: TEditFocus
          Left = 136
          Top = 397
          Width = 384
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 50
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAtividade: TEditFocus
          Left = 136
          Top = 441
          Width = 384
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 53
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRepresentante: TEditFocus
          Left = 658
          Top = 397
          Width = 340
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 51
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeTabPre: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 441
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_TABPRE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 54
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeEndNum: TDBEditFocus
          Tag = 99
          Left = 591
          Top = 134
          Width = 98
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_ENDNUM'
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
          OnChange = dbeEndNumChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndCom: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 156
          Width = 420
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_ENDCOM'
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
          OnChange = dbeEndComChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmailNfe2: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 353
          Width = 376
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_EMAIL2'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 254
          ParentFont = False
          TabOrder = 43
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSupGer: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 419
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_SUPGER'
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
          OnKeyPress = dbeSupGerKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodVenChamaCadastro
        end
        object edtSupGer: TEditFocus
          Left = 136
          Top = 419
          Width = 384
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 58
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeSupReg: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 419
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_SUPREG'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 49
          OnKeyPress = dbeSupRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodVenChamaCadastro
        end
        object edtSupReg: TEditFocus
          Left = 658
          Top = 419
          Width = 340
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 59
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeEmailNFe: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 353
          Width = 420
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_EMAIL3'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 254
          ParentFont = False
          TabOrder = 42
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object cbxRgEst: TComboBoxFocus
          Tag = 99
          Left = 472
          Top = 221
          Width = 48
          Height = 22
          Style = csDropDownList
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 23
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
        object edtRgExp: TEditFocus
          Tag = 99
          Left = 416
          Top = 221
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
          TabOrder = 22
          OnKeyPress = edtRgExpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstEmiCpf: TEditFocus
          Left = 100
          Top = 199
          Width = 420
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 60
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeOpeAlt: TDBEditFocus
          Tag = 99
          Left = 647
          Top = 24
          Width = 54
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CLI_CODOPE'
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
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 704
          Top = 24
          Width = 153
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 63
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeNEXTEL: TDBEditFocus
          Tag = 99
          Left = 772
          Top = 309
          Width = 199
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_NEXTEL'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 39
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object chkIESUni: TDBCheckBox
          Tag = 99
          Left = 667
          Top = 246
          Width = 111
          Height = 16
          Caption = 'N'#227'o contri. ICMS?'
          DataField = 'CLI_IESUNI'
          DataSource = dtsTabela
          TabOrder = 28
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object chkProRur: TDBCheckBox
          Tag = 99
          Left = 900
          Top = 224
          Width = 98
          Height = 17
          Caption = 'Produtor Rural?'
          DataField = 'CLI_PRORUR'
          DataSource = dtsTabela
          TabOrder = 25
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnExit = chkProRurExit
        end
        object chkMicEmp: TDBCheckBox
          Tag = 99
          Left = 797
          Top = 245
          Width = 201
          Height = 17
          Caption = 'MEI - Micro Empreendedor Individual?'
          DataField = 'CLI_MICEMP'
          DataSource = dtsTabela
          TabOrder = 29
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object chkCpfDev: TCheckBox
          Left = 100
          Top = 180
          Width = 172
          Height = 16
          TabStop = False
          Caption = 'CPF somente para Devolu'#231#245'es'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 62
          Visible = False
          OnClick = chkCpfDevClick
        end
        object dbeLatitu: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 179
          Width = 66
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_LATITU'
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
        object dbeLongit: TDBEditFocus
          Tag = 99
          Left = 811
          Top = 179
          Width = 66
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_LONGIT'
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
        object dbeRaio__: TDBEditFocus
          Tag = 99
          Left = 932
          Top = 179
          Width = 66
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_RAIO__'
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
        object btnConsultaFit: TBitBtnLocked
          Left = 561
          Top = 46
          Width = 27
          Height = 22
          Hint = 'Consulta Dados Cadastrais do CNPJ.'
          Enabled = False
          Glyph.Data = {
            36060000424D3606000000000000360000002800000020000000100000000100
            1800000000000006000000000000000000000000000000000000A449A3DC7D47
            D35C18D55D18D35C18D15B17D35C18C35516F1AA81CA5817D55D18D35C18D35C
            18D35C18F0A173A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
            C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3DA7B44DC6019
            D35C18E97837F9DDCDE97939C65616F1AB83FDF2ECEF9C6CCF5A17DC6019DC60
            19DC6019DC6019F5C2A5C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3
            C3C3FFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E76A22D15B17
            EA7E40DA5F18E36319FAE2D4FBE8DDC15416FBE5D8FAE2D4E8722ED15B17DA5F
            18DA5F18DA5F18F1AB82C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3
            C3C3FFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F1A87ECE5A17
            F8D4BFE76B24EC8D56E97736F9DAC8CA5817FDF1EAFDF1EAFADFCFE76C25D55D
            18DC6019DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3C3C3FFFFFFC3
            C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F0A173F7CEB7
            F6C8ADE76A22F9DBC9EA7D3FC15416FDF3EDFDF1EAFDF1EAFCEEE6FDF1EAF9D9
            C6E76920DC6019F1AB83C3C3C3FFFFFFC3C3C3C3C3C3FFFFFFC3C3C3C3C3C3FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3FFFFFFEF9F71F4BB9B
            F8D6C2E76D27F5BFA0E97939C35516FDF2ECFBE8DDFCEBE1FDF2ECFCEDE4FDF2
            ECEF9F71DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFC3C3C3C3C3C3FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C85716D75E18
            D35C18DC6019D15B17E16219F7D0B9CE5A17E97736E97736C65616FDF2ECFDF1
            EAFAE0D1D35C18F1AB83C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3
            C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3D15B17CC5917
            E76D27CE5A17F3B795FDF2ECF6C8AEDE6119EC8A51ED905BED935FFDF1EAFCEE
            E6FDF1EAE16219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3
            C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3FFFFFFCE5A17EC8A52
            FBE5D8F1A97FFDF2ECFDF1EAF8D3BDDC6019EE9866E06219C35516FDF2ECFCED
            E4FCEEE6F5C2A4F1A87EC3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFC3
            C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C35516FDF2EC
            FCEDE4FCEEE6FCEDE4FCEDE4FDF1EAE97532E56319CC5917EE9664FCEFE8FCED
            E4FCEDE4FDF2ECF0A579C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3
            C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3D15B17CF5A17
            FCEBE1FCEFE8FCEDE4FCEDE4FCEDE4FDF1EAFDF2ECFDF2ECFDF1EAFDF1EAFCEF
            E8FBE8DDDA5F18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3FFFFFFD15B17CE5A17
            FAE1D2FDF1EAFCEDE4FCEDE4FCEDE4FCEDE4FBE9DFF6C6ABFCEDE4F6C5A9EB82
            46E8702BD85E18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3D35C18D55D18
            F6CAB0F2AE87F9DCCBFCEDE4F8D1BBFCEFE8FDF2ECE97736CA5817DA5F18E062
            19E06219E06219F2AD85C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3D35C18E06219
            DE6119D55D18F4BB9BFBE6DAE8712DED905AF2AE87E76A22D85E18E16219E062
            19E06219E06219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3C3C3C3
            C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E08049E16219
            E16219E16219D75E18E06219E16219E16219DE6119E16219E06219E06219E062
            19E06219E16219F6C8ADC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
            C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3EE9561
            E56319E56319E56319E56319E56319E56319E56319E56319E56319E56319E563
            19E56319F4B997A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
            C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3A449A3}
          NumGlyphs = 2
          TabOrder = 9
          TabStop = False
          OnClick = btnConsultaFitClick
        end
        object pnlImgCli: TPanel
          Left = 872
          Top = 12
          Width = 131
          Height = 95
          BevelInner = bvLowered
          BorderWidth = 2
          BorderStyle = bsSingle
          Color = clWhite
          DoubleBuffered = True
          ParentBackground = False
          ParentDoubleBuffered = False
          TabOrder = 61
          OnDblClick = imgCliDblClick
          object lblErrImg: TLabel
            Left = 4
            Top = 4
            Width = 119
            Height = 83
            Align = alClient
            Alignment = taCenter
            Caption = 
              'N'#227'o foi poss'#237'vel carregar a imagem do cliente. Verifique o forma' +
              'to do arquivo!'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            Visible = False
            WordWrap = True
            OnDblClick = imgCliDblClick
            ExplicitHeight = 36
          end
          object imgCli: TcxImage
            Left = 4
            Top = 4
            Align = alClient
            Properties.FitMode = ifmProportionalStretch
            Properties.PopupMenuLayout.MenuItems = []
            TabOrder = 0
            OnDblClick = imgCliDblClick
            Height = 83
            Width = 119
          end
        end
        object dbeNire: TDBEditFocus
          Tag = 99
          Left = 416
          Top = 243
          Width = 104
          Height = 22
          Hint = 'NIRE (N'#250'mero de identifica'#231#227'o do registro de empresas)'
          CharCase = ecUpperCase
          DataField = 'CLI_NONIRE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 11
          ParentFont = False
          TabOrder = 27
          OnExit = dbeNumIesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValLim: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 463
          Width = 101
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_VALLIM'
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
          TabOrder = 56
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDTDEPS: TDBEditFocus
          Tag = 99
          Left = 898
          Top = 463
          Width = 101
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_DTDEPS'
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
          TabOrder = 57
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnConsultarEndereco: TBitBtnLocked
          Left = 591
          Top = 201
          Width = 161
          Height = 20
          Caption = 'Consultar Endere'#231'o no Google'
          TabOrder = 64
          TabStop = False
          OnClick = btnConsultarEnderecoClick
        end
        object btnLimiteAlpe: TBitBtnLocked
          Left = 473
          Top = 463
          Width = 47
          Height = 21
          Caption = 'Verificar'
          TabOrder = 65
          Visible = False
          OnClick = btnLimiteAlpeClick
        end
        object chkUtiAlp: TDBCheckBox
          Left = 348
          Top = 465
          Width = 62
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Util. Alpe'
          DataField = 'CLI_UTIALP'
          DataSource = dtsTabela
          TabOrder = 66
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeCodCid: TDBEditFocus
          Tag = 99
          Left = 233
          Top = 112
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODCID'
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
        object edtEstado: TEditFocus
          Left = 647
          Top = 112
          Width = 54
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 67
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomCid: TEditFocus
          Left = 320
          Top = 112
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 68
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
          Left = 100
          Top = 112
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_C_E_P_'
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
          OnKeyPress = dbeNumCepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnLimCre: TBitBtnLocked
          Left = 193
          Top = 463
          Width = 133
          Height = 22
          Caption = 'Atualizar Limite de Cr'#233'dito'
          TabOrder = 69
          OnClick = btnLimCreClick
        end
        object dbeIDEstrangeiro: TDBEditFocus
          Tag = 99
          Left = 309
          Top = 24
          Width = 145
          Height = 22
          Hint = 'ID Estrangeiro'
          DataField = 'CLI_IDESTR'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ParentFont = False
          PopupMenu = popVazio
          TabOrder = 3
          OnKeyPress = dbeIDEstrangeiroKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object chkRecWpp: TDBCheckBox
          Left = 359
          Top = 312
          Width = 113
          Height = 17
          Caption = 'Receber Whatsapp'
          DataField = 'CLI_RECWPP'
          DataSource = dtsTabela
          TabOrder = 70
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object pnlForPag: TPanel
        Left = 0
        Top = 485
        Width = 1037
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lblForPag: TLabel
          Left = 16
          Top = 4
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Forma de Pagto:'
        end
        object Label35: TLabel
          Left = 467
          Top = 3
          Width = 256
          Height = 16
          Caption = '(NAO ADICIONAR COMPONENTES AQUI!)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object dbeCodFpg: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 0
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODFPG'
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
          OnKeyPress = dbeCodFpgKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodFpgChamaCadastro
        end
        object edtDesFpg: TEditFocus
          Left = 136
          Top = 0
          Width = 207
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
      object pnlTipCli: TPanel
        Left = 0
        Top = 507
        Width = 1037
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label41: TLabel
          Left = 21
          Top = 4
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Cliente:'
        end
        object Label45: TLabel
          Left = 467
          Top = 3
          Width = 256
          Height = 16
          Caption = '(NAO ADICIONAR COMPONENTES AQUI!)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object dbeTipCli: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 0
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_TIPCLI'
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
          OnKeyPress = dbeTipCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeTipCliChamaCadastro
        end
        object edtDesTpc: TEditFocus
          Left = 136
          Top = 0
          Width = 207
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
      object pnlCadPor: TPanel
        Left = 0
        Top = 529
        Width = 1037
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object Label50: TLabel
          Left = 30
          Top = 5
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador (1) :'
        end
        object Label52: TLabel
          Left = 557
          Top = 5
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador (2) :'
        end
        object dbeCodPor: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 0
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODPOR'
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
          OnKeyPress = dbeCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodPorChamaCadastro
        end
        object edtDesPor: TEditFocus
          Left = 136
          Top = 0
          Width = 384
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
        object dbeCodPor2: TDBEditFocus
          Tag = 99
          Left = 622
          Top = 0
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CODPO2'
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
          OnKeyPress = dbeCodPor2KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodPor2ChamaCadastro
        end
        object edtDesPor2: TEditFocus
          Left = 658
          Top = 0
          Width = 341
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
      end
      object pnlNeocredit: TPanel
        Left = 0
        Top = 551
        Width = 1037
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object Label301: TLabel
          Left = 2
          Top = 7
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = #218'lt. Con. Neocredit:'
        end
        object Label300: TLabel
          Left = 522
          Top = 7
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Stat. Con. Neocredit:'
        end
        object edtUltimaConsultaNeocredit: TEditFocus
          Left = 100
          Top = 2
          Width = 109
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
        object edtStatusConsultaNeocredit: TEditFocus
          Left = 622
          Top = 2
          Width = 279
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
    object tbsGeral2: TTabSheet
      Caption = '2 - Complementos'
      ImageIndex = 7
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 626
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Bevel1: TBevel
          Left = 5
          Top = 260
          Width = 762
          Height = 6
          Shape = bsTopLine
        end
        object pnlCompGrp1: TPanel
          Left = 1
          Top = 1
          Width = 1035
          Height = 140
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object lblDesCon: TLabel
            Left = 17
            Top = 7
            Width = 139
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto para Profissionais:'
          end
          object lblPerDes: TLabel
            Left = 226
            Top = 7
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label57: TLabel
            Left = 71
            Top = 99
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Canal de Acesso:'
          end
          object lblRegiao: TLabel
            Left = 120
            Top = 30
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Regi'#227'o:'
          end
          object Label58: TLabel
            Left = 84
            Top = 75
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Rede de Lojas:'
          end
          object lblPerEmp: TLabel
            Left = 517
            Top = 122
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permite empr'#233'stimo:'
          end
          object dbePeEmp_S_N_: TColorLabel
            Left = 654
            Top = 122
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
          object lbl12: TLabel
            Left = 97
            Top = 53
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Sub-Regi'#227'o:'
          end
          object lbl15: TLabel
            Left = 117
            Top = 124
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Revista:'
          end
          object ColorLabel28: TColorLabel
            Left = 206
            Top = 122
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
          object lblFabDes: TLabel
            Left = 505
            Top = 53
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ident. Fabrica:'
          end
          object lblTipAti: TLabel
            Left = 488
            Top = 75
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Atividade:'
          end
          object shpDesPro: TShape
            Left = 218
            Top = 3
            Width = 5
            Height = 22
            Brush.Color = clGreen
          end
          object Label166: TLabel
            Left = 781
            Top = 29
            Width = 149
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cobrar Despesas Acess'#243'rias?'
          end
          object ColorLabel9: TColorLabel
            Left = 971
            Top = 29
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
          object lblTaxEnt: TLabel
            Left = 809
            Top = 52
            Width = 121
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Cobrar Taxa de Entrega?'
            Layout = tlBottom
          end
          object clbTaxEnt: TColorLabel
            Left = 971
            Top = 52
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
          object lblDesOpe: TLabel
            Left = 778
            Top = 75
            Width = 152
            Height = 14
            Alignment = taRightJustify
            Caption = 'Despesas Oper. Complementar:'
          end
          object lblDesOpePer: TLabel
            Left = 991
            Top = 75
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object cllCliMon: TColorLabel
            Left = 971
            Top = 98
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
          object lblCliMon: TLabel
            Left = 838
            Top = 98
            Width = 92
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cliente Montadora?'
          end
          object cllLayCFF: TColorLabel
            Left = 971
            Top = 123
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
          object lblLayCFF: TLabel
            Left = 760
            Top = 123
            Width = 170
            Height = 14
            Alignment = taRightJustify
            Caption = 'Utilizar layout complementar de FF?'
          end
          object dbeDescon: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 3
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_DESCON'
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
            TipoTexto = ttNumerico
          end
          object edtCadCac: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 94
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODCAC'
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
            OnExit = edtCadCacExit
            OnKeyPress = edtCadCacKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
            OnChamaCadastro = edtCadCacChamaCadastro
          end
          object edtDesCadCac: TEditFocus
            Left = 217
            Top = 95
            Width = 268
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 18
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
            Left = 162
            Top = 26
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODREG'
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
            OnKeyPress = dbeCodRegKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCodRegChamaCadastro
          end
          object edtDesReg: TEditFocus
            Left = 217
            Top = 26
            Width = 268
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object dbeCodRed: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 72
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODRED'
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
            OnExit = dbeCodRedExit
            OnKeyPress = dbeCodRedKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCodRedChamaCadastro
          end
          object edtDesRed: TEditFocus
            Left = 217
            Top = 72
            Width = 268
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 20
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbePeEmp: TDBEditFocus
            Tag = 99
            Left = 616
            Top = 118
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PEREMP'
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
            TipoTexto = ttAlfabetico
          end
          object pnlPerCom: TPanel
            Left = 486
            Top = 22
            Width = 178
            Height = 26
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 3
            object Label207: TLabel
              Left = 6
              Top = 8
              Width = 81
              Height = 14
              Alignment = taRightJustify
              Caption = 'Comiss'#227'o Vend.:'
            end
            object Label208: TLabel
              Left = 168
              Top = 7
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbePerCom: TDBEditFocus
              Tag = 99
              Left = 91
              Top = 4
              Width = 75
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_PERCOM'
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
              TipoTexto = ttNumerico
            end
          end
          object dbeCodSub: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 49
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODSUB'
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
            OnKeyPress = dbeCodSubKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCodSubChamaCadastro
          end
          object edtDesSub: TEditFocus
            Left = 217
            Top = 49
            Width = 268
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object pnlAtrMax: TPanel
            Left = 302
            Top = 118
            Width = 147
            Height = 22
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 15
            object lblAtrMax: TLabel
              Left = 0
              Top = 5
              Width = 98
              Height = 14
              Alignment = taRightJustify
              Caption = 'Atraso M'#225'ximo dias:'
            end
            object dbeAtrMax: TDBEditFocus
              Tag = 99
              Left = 102
              Top = 0
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ATRMAX'
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
              TipoTexto = ttNumerico
            end
          end
          object dbeRevist: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 118
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_REVIST'
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
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeFabDes: TDBEditFocus
            Tag = 99
            Left = 577
            Top = 49
            Width = 75
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_FABDES'
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
          object pnlComPro: TPanel
            Left = 347
            Top = -1
            Width = 322
            Height = 26
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object Label226: TLabel
              Left = 10
              Top = 7
              Width = 216
              Height = 14
              Alignment = taRightJustify
              Caption = 'Comiss'#227'o do Profissional Indicado na Venda:'
            end
            object Label227: TLabel
              Left = 307
              Top = 8
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbeComPro: TDBEditFocus
              Tag = 99
              Left = 230
              Top = 4
              Width = 75
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_COMPRO'
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
              TipoTexto = ttNumerico
            end
          end
          object dbcTipAti: TDBComboBoxFocus
            Tag = 99
            Left = 577
            Top = 72
            Width = 126
            Height = 22
            Style = csDropDownList
            DataField = 'CLI_TIPATI'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Items.Strings = (
              'Atacado'
              'Varejo'
              'SM')
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object pnlGrupoRisco: TPanel
            Left = 485
            Top = 95
            Width = 225
            Height = 22
            BevelOuter = bvNone
            TabOrder = 12
            object Label264: TLabel
              Left = 13
              Top = 4
              Width = 75
              Height = 14
              Alignment = taRightJustify
              Caption = 'Grupo de risco:'
            end
            object shpGrupoRisco: TShape
              Left = 219
              Top = 0
              Width = 5
              Height = 22
              Brush.Color = clGreen
            end
            object cbxGrupoRisco: TDBLookupComboBoxFocus
              Left = 92
              Top = 0
              Width = 126
              Height = 22
              DataField = 'CLI_CODGRR'
              DataSource = dtsTabela
              KeyField = 'GRR_CODIGO'
              ListField = 'GRR_DESCRI'
              TabOrder = 0
              OnClick = cbxGrupoRiscoClick
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object dbeCoDeAc: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 26
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODEAC'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeTaxEnt: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 49
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_TAXENT'
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
            TipoTexto = ttAlfabetico
          end
          object dbeDesOpe: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 72
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_DESOPE'
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
            OnEnter = dbeDesOpeEnter
            OnExit = dbeDesOpeExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeCliMon: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 95
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CLIMON'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeLayCFF: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 118
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_LAYCFF'
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
            TipoTexto = ttAlfabetico
          end
        end
        object pnlCompGrp3: TPanel
          Left = 1
          Top = 185
          Width = 1035
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 4
          object lblEmpRCF: TLabel
            Left = 14
            Top = -3
            Width = 142
            Height = 28
            Alignment = taRightJustify
            Caption = 'Empresa respons'#225'vel pela'#13#10'Confirma'#231#227'o de Documentos:'
          end
          object dbeCodEmpRCF: TDBEditFocus
            Left = 162
            Top = 1
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_EMPRCF'
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
            OnExit = dbeCodEmpRCFExit
            OnKeyPress = edtCodEmpresaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtDesEmpRCF: TEditFocus
            Left = 217
            Top = 1
            Width = 435
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
        object pnlCompGrp4: TPanel
          Left = 1
          Top = 209
          Width = 1035
          Height = 186
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 5
          object Bevel2: TBevel
            Left = 5
            Top = 1
            Width = 762
            Height = 6
            Shape = bsTopLine
          end
          object lblDesPlaCon: TLabel
            Left = 84
            Top = 9
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Conta Cont'#225'bil:'
          end
          object Label156: TLabel
            Left = 479
            Top = 10
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Categoria:'
          end
          object Label148: TLabel
            Left = 43
            Top = 52
            Width = 113
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa Identificadora:'
          end
          object lbl6: TLabel
            Left = 579
            Top = 10
            Width = 93
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cart'#227'o DoctorCred:'
          end
          object lblCorres: TLabel
            Left = 28
            Top = 74
            Width = 128
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Cliente Correspondente:'
            Layout = tlBottom
          end
          object lblImpLau: TLabel
            Left = 777
            Top = 83
            Width = 153
            Height = 28
            Alignment = taRightJustify
            Caption = 'Cliente necessita de impress'#227'o de laudo?'
            WordWrap = True
          end
          object cllImpLau: TColorLabel
            Left = 971
            Top = 90
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
          object lblEtiDes: TLabel
            Left = 774
            Top = 115
            Width = 156
            Height = 28
            Alignment = taRightJustify
            Caption = 'Cliente necessita de etiqueta de despacho?'
            WordWrap = True
          end
          object cllEtiDes: TColorLabel
            Left = 971
            Top = 122
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
          object lblAgruparDocAppTaEntregue: TLabel
            Left = 810
            Top = 51
            Width = 120
            Height = 28
            Alignment = taRightJustify
            Caption = 'Agrupar documentos no App T'#225' Entregue?'
            WordWrap = True
          end
          object cllAgruparDocAppTaEntregue: TColorLabel
            Left = 971
            Top = 58
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
          object lblDestino: TLabel
            Left = 841
            Top = 161
            Width = 39
            Height = 14
            Caption = 'Destino:'
          end
          object edtCodEmpresa: TDBEditFocus
            Left = 162
            Top = 47
            Width = 55
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_EMPIDE'
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
            OnExit = edtCodEmpresaExit
            OnKeyPress = edtCodEmpresaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
            OnChamaCadastro = edtCodEmpresaChamaCadastro
          end
          object dbcCategoria: TDBComboBoxFocus
            Tag = 99
            Left = 534
            Top = 6
            Width = 39
            Height = 22
            Style = csDropDownList
            DataField = 'CLI_CATEGO'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Items.Strings = (
              'A'
              'B'
              'C'
              'D'
              'E'
              'F'
              ' ')
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtDesEmpresa: TEditFocus
            Left = 218
            Top = 47
            Width = 434
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object gbCluFid: TGroupBox
            Left = 46
            Top = 94
            Width = 331
            Height = 89
            Caption = 'Clube Fidelidade:'
            TabOrder = 9
            object Label158: TLabel
              Left = 29
              Top = 19
              Width = 81
              Height = 14
              Alignment = taRightJustify
              Caption = 'Clube Fidelidade:'
            end
            object ColorLabel18: TColorLabel
              Left = 160
              Top = 19
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
            object Label163: TLabel
              Left = 30
              Top = 43
              Width = 80
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data da Ades'#227'o:'
            end
            object dbeCluFid: TDBEditFocus
              Tag = 99
              Left = 116
              Top = 15
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CLUFID'
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
              TipoTexto = ttAlfabetico
            end
            object dbeDtaFid: TDBEditFocus
              Tag = 99
              Left = 116
              Top = 39
              Width = 84
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DTAFID'
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
            object pnlCliCluFid: TPanel
              Left = 2
              Top = 61
              Width = 327
              Height = 26
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 2
              object lblCliFid: TLabel
                Left = 7
                Top = 5
                Width = 101
                Height = 14
                Alignment = taRightJustify
                Caption = 'Cliente para Creditar:'
              end
              object dbeCliFid: TDBEditFocus
                Tag = 99
                Left = 114
                Top = 2
                Width = 55
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_CLIFID'
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
                OnKeyPress = dbeCliFidKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                PanelInfo = pnlInfo
                TipoTexto = ttAlfanumerico
                OnChamaCadastro = dbeCliFidChamaCadastro
              end
              object edtCliFid: TEditFocus
                Left = 169
                Top = 2
                Width = 150
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
          object dbeCodDcr: TDBEditFocus
            Tag = 99
            Left = 675
            Top = 6
            Width = 119
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CODDCR'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 16
            ParentFont = False
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object gpbServico: TGroupBox
            Left = 381
            Top = 92
            Width = 378
            Height = 89
            Caption = 'Servi'#231'o:'
            TabOrder = 10
            object lbl10: TLabel
              Left = 11
              Top = 19
              Width = 63
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo Obra:'
            end
            object lbl11: TLabel
              Left = 13
              Top = 47
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo ART:'
            end
            object ColorLabel7: TColorLabel
              Left = 6
              Top = 72
              Width = 328
              Height = 14
              Caption = 
                '* Utilizado na venda quando n'#227'o informado no endere'#231'o de entrega' +
                '.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object Label165: TLabel
              Left = 157
              Top = 19
              Width = 43
              Height = 14
              Alignment = taRightJustify
              Caption = 'CNO/CEI:'
            end
            object lblCodCIB: TLabel
              Left = 277
              Top = 19
              Width = 19
              Height = 14
              Alignment = taRightJustify
              Caption = 'CIB:'
            end
            object lblInsImo: TLabel
              Left = 155
              Top = 47
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ins.Imob.:'
            end
            object dbeCodObr: TDBEditFocus
              Tag = 99
              Left = 77
              Top = 15
              Width = 70
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODOBR'
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
            object dbeCodART: TDBEditFocus
              Tag = 99
              Left = 77
              Top = 43
              Width = 70
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODART'
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
            object dbeCodCNO: TDBEditFocus
              Tag = 99
              Left = 201
              Top = 15
              Width = 70
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODCNO'
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
            object dbeCodCIB: TDBEditFocus
              Tag = 99
              Left = 297
              Top = 15
              Width = 70
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODCIB'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeInsImo: TDBEditFocus
              Tag = 99
              Left = 201
              Top = 43
              Width = 70
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_INSIMO'
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
          end
          object dbchkDesmembr: TDBCheckBox
            Left = 162
            Top = 30
            Width = 149
            Height = 15
            Caption = 'Conta Cont'#225'bil / Empresa?'
            DataField = 'CLI_DESMEM'
            DataSource = dtsTabela
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dbeCorres: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 70
            Width = 75
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CORRES'
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
            OnKeyPress = dbeCorresKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtCorres: TEditFocus
            Left = 238
            Top = 70
            Width = 414
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
          object dbeConCon: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 6
            Width = 168
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CONCON'
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
          object edtDesPlaNco: TEditFocus
            Left = 300
            Top = 6
            Width = 164
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 2
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbePlaNco: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 6
            Width = 135
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PLANCO'
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
            OnKeyPress = dbePlaNcoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeImpLau: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 87
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_IMPLAU'
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
            TipoTexto = ttAlfabetico
          end
          object dbeEtiDes: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 119
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_ETIDES'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeAgruparDocAppTaEntregue: TDBEditFocus
            Tag = 99
            Left = 933
            Top = 55
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_AGRUDOC'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object cbbDestino: TComboBoxFocus
            Left = 885
            Top = 158
            Width = 145
            Height = 22
            TabOrder = 15
            Items.Strings = (
              'ENTREGA'
              'RETIRA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlPeMIFF: TPanel
          Left = 1
          Top = 163
          Width = 1035
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 2
          object lblPermFF: TLabel
            Left = 54
            Top = 3
            Width = 102
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir FF (A Prazo):'
          end
          object clbPermFF: TColorLabel
            Left = 206
            Top = 3
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
          object lblPermFV: TLabel
            Left = 297
            Top = 3
            Width = 100
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir FF ('#192' Vista):'
          end
          object clbPermFV: TColorLabel
            Left = 448
            Top = 3
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
          object dbePermFF: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 0
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERMFF'
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
            TipoTexto = ttAlfabetico
          end
          object dbePermFV: TDBEditFocus
            Tag = 99
            Left = 404
            Top = 0
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERMFV'
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
            TipoTexto = ttAlfabetico
          end
        end
        object pnlObserv: TPanel
          Left = 1
          Top = 395
          Width = 1035
          Height = 140
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 6
          object Label47: TLabel
            Left = 84
            Top = 3
            Width = 72
            Height = 56
            Alignment = taRightJustify
            Caption = 'Observa'#231#245'es:'#13'Pressione TAB'#13'para a pr'#243'ximo'#13'campo'
          end
          object Label204: TLabel
            Left = 3
            Top = 61
            Width = 153
            Height = 14
            Alignment = taRightJustify
            Caption = 'Mens. impress'#227'o pedido venda:'
          end
          object lblMarca: TLabel
            Left = 123
            Top = 107
            Width = 33
            Height = 14
            Caption = 'Marca:'
          end
          object dbeObserv: TDBMemoFocus
            Left = 162
            Top = 1
            Width = 597
            Height = 53
            BiDiMode = bdLeftToRight
            DataField = 'CLI_OBSERV'
            DataSource = dtsTabela
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentBiDiMode = False
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
            OnKeyPress = dbeObservKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object dbeMsgPed: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 58
            Width = 598
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_MSGPED'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 200
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeMarca: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 104
            Width = 598
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_MARCA_'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 80
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeMsgPe2: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 81
            Width = 598
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_MSGPE2'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 80
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object grbLGPD: TGroupBox
            Left = 772
            Top = 34
            Width = 258
            Height = 92
            Caption = 'Lei LGPD'
            TabOrder = 4
            object lblLeiLGPD: TColorLabel
              Left = 8
              Top = 19
              Width = 135
              Height = 14
              Alignment = taRightJustify
              Caption = 'Libera'#231#227'o para a Lei LGPD?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
              CorDestaque = clRed
            end
            object lblLeiLGPDSN: TColorLabel
              Left = 190
              Top = 19
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
            object ColorLabel33: TColorLabel
              Left = 75
              Top = 42
              Width = 68
              Height = 14
              Alignment = taRightJustify
              Caption = 'Termo Aceito?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
              CorDestaque = clRed
            end
            object ColorLabel34: TColorLabel
              Left = 190
              Top = 42
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
            object lblStatusLGPD: TLabel
              Left = 148
              Top = 67
              Width = 81
              Height = 14
              Caption = 'Termo Enviado'
              Color = 16770261
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = True
            end
            object dbeLeiLGP: TDBEditFocus
              Tag = 99
              Left = 148
              Top = 16
              Width = 36
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_LEILGP'
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
              OnChange = dbeLeiLGPChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeTerAce: TDBEditFocus
              Tag = 99
              Left = 148
              Top = 39
              Width = 36
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_TERACE'
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
              TipoTexto = ttAlfabetico
            end
            object btnArquivosAceiteLGPD: TBitBtnLocked
              Left = 11
              Top = 62
              Width = 131
              Height = 23
              Caption = 'Arquivos de Aceite'
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
              TabOrder = 2
              OnClick = btnArquivosAceiteLGPDClick
            end
          end
          object btnObsClientes: TBitBtnLocked
            Left = 767
            Top = 0
            Width = 28
            Height = 25
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
              00000000000100000004000000090000000D0000000F0000000F0000000C0000
              00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
              0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
              1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
              02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
              50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
              3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
              C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
              7CFFEFE6DFFFCDA67CFFCDA36EFFE4C693FFEFD9ABFFEAD2A8FFD4B284FFD0AE
              88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
              C9FFDDC1A8FFC99966FFE8C085FFE9C388FF8F4B24FFF1D8B1FFF3DDB8FFD6B3
              8AFFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
              F2FFC79873FFDEAB77FFEFCDABFFF1D2B5FF8F4524FFEDC99EFFF1D4B2FFECCF
              AEFFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
              FCFFBE875FFFEDCFB9FF682612FF8A3F22FF8C4024FF8F4225FF924427FFF1CE
              AEFFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
              F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FF8B3C23FFF1CEB6FFEBB78FFFE7BC
              9AFFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
              D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FF6A2213FFF1C8B2FFEBB08AFFCA8F
              6FFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
              A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88967FFCE9D
              84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
              4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
              F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
              020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
              A2FC62504B900404031000000002000000000000000000000000000000000000
              000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
              1F3E000000060000000100000000000000000000000000000000}
            TabOrder = 5
            OnClick = btnObsClientesClick
          end
        end
        object pnlCompGrp2: TPanel
          Left = 1
          Top = 141
          Width = 1035
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object pnlPermut: TPanel
            Left = 0
            Top = 0
            Width = 506
            Height = 22
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object lbl9: TLabel
              Left = 107
              Top = 2
              Width = 291
              Height = 14
              Alignment = taRightJustify
              Caption = 'Permuta para isen'#231#227'o do pagamento de comiss'#227'o de venda:'
            end
            object ColorLabel8: TColorLabel
              Left = 449
              Top = 2
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
            object dbePermut: TDBEditFocus
              Tag = 99
              Left = 404
              Top = 0
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_PERMUT'
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
              TipoTexto = ttAlfabetico
            end
          end
          object pnlLimitaContratoLocacao: TPanel
            Left = 506
            Top = 0
            Width = 248
            Height = 22
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object lblLimiteLocacaoCtr: TLabel
              Left = 19
              Top = 3
              Width = 137
              Height = 14
              Alignment = taRightJustify
              Caption = 'Limite de Loca'#231#227'o de Equip.:'
            end
            object dbeLimCtr: TDBEditFocus
              Tag = 99
              Left = 162
              Top = 0
              Width = 75
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_LIMCTR'
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
              TipoTexto = ttNumerico
            end
          end
        end
        object pnlPerEntFut: TPanel
          Left = 1
          Top = 535
          Width = 1035
          Height = 117
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 7
          object lblRemOut: TLabel
            Left = 9
            Top = -2
            Width = 162
            Height = 28
            Alignment = taRightJustify
            Caption = 'Cliente de controle para remessa fora do estabelecimento?'
            WordWrap = True
          end
          object cllRemOut: TColorLabel
            Left = 218
            Top = 5
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
          object lblCarExc: TLabel
            Left = 16
            Top = 28
            Width = 155
            Height = 28
            Alignment = taRightJustify
            Caption = 'Cliente com controle de carga e entrega exclusiva?'
            WordWrap = True
          end
          object clbCarExc: TColorLabel
            Left = 218
            Top = 34
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
          object lblAguardandoSN: TColorLabel
            Left = 218
            Top = 63
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
          object lblPrevisaoSN: TColorLabel
            Left = 518
            Top = 67
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
          object lblFaltaSN: TColorLabel
            Left = 834
            Top = 57
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
          object lblAguardando: TColorLabel
            Left = 2
            Top = 57
            Width = 169
            Height = 28
            Alignment = taRightJustify
            Caption = 'Permitir Entrega Futura com Status "Aguardando o Cliente"?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
            CorDestaque = clRed
          end
          object lblPrevisao: TColorLabel
            Left = 302
            Top = 61
            Width = 169
            Height = 28
            Alignment = taRightJustify
            Caption = 'Permitir Entrega Futura com Status "Previs'#227'o de Entrega"?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
            CorDestaque = clRed
          end
          object lblFalta: TColorLabel
            Left = 618
            Top = 51
            Width = 169
            Height = 28
            Alignment = taRightJustify
            Caption = 'Permitir Entrega Futura com Status "Falta de Produto"?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
            CorDestaque = clRed
          end
          object lblObrPDCSN: TColorLabel
            Left = 557
            Top = 34
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
          object lblObrPDC: TColorLabel
            Left = 286
            Top = 28
            Width = 220
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Tornar obrigat'#243'rio o operador digitar o Pedido de Compra dos ite' +
              'ns no faturamento?'#31
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
            CorDestaque = clRed
          end
          object cllOSNFEn: TColorLabel
            Left = 557
            Top = 6
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
          object lblOSNFEn: TLabel
            Left = 299
            Top = -2
            Width = 211
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Obrigar nota de entrada emitida pelo cliente para conserto de eq' +
              'uipamentos?'
            WordWrap = True
          end
          object gpbVMINFC: TGroupBox
            Left = 618
            Top = -1
            Width = 266
            Height = 41
            Caption = 'Valor m'#237'nimo para emitir Nota Fiscal:'
            TabOrder = 2
            object Label245: TLabel
              Left = 8
              Top = 20
              Width = 40
              Height = 14
              Alignment = taRightJustify
              Caption = 'Entrega:'
            end
            object Label246: TLabel
              Left = 145
              Top = 20
              Width = 31
              Height = 14
              Alignment = taRightJustify
              Caption = 'Retira:'
            end
            object dbeVLMINE: TDBEditFocus
              Tag = 99
              Left = 52
              Top = 16
              Width = 75
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_VLMINE'
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
              TipoTexto = ttNumerico
            end
            object dbeVLMINR: TDBEditFocus
              Tag = 99
              Left = 180
              Top = 16
              Width = 75
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_VLMINR'
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
              TipoTexto = ttNumerico
            end
          end
          object dbeRemOut: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 2
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_REMOUT'
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
            TipoTexto = ttAlfabetico
          end
          object dbeCarExc: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 31
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CAREXC'
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
            TipoTexto = ttAlfabetico
          end
          object dbePerAgu: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 60
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERAGU'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbePerPre: TDBEditFocus
            Tag = 99
            Left = 477
            Top = 64
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERPRE'
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
            TipoTexto = ttAlfabetico
          end
          object dbePerFal: TDBEditFocus
            Tag = 99
            Left = 793
            Top = 54
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERFAL'
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
            TipoTexto = ttAlfabetico
          end
          object dbeObrPDC: TDBEditFocus
            Tag = 99
            Left = 515
            Top = 30
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_OBRPDC'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeOSNFEn: TDBEditFocus
            Tag = 99
            Left = 516
            Top = 2
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_OSNFEN'
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
            TipoTexto = ttAlfabetico
          end
        end
        object btnAbrirPastaCliente: TBitBtnLocked
          Left = 675
          Top = 2
          Width = 101
          Height = 39
          Caption = 'Arquivos de Cadastro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
            00FFFF00FFFF00FFFF00FF93655EF2D9B0F2D7ABF0D4A9F0D1A5EFD1A1F0CF9E
            EFCE9CEFCB98EECA95EDC992EDC78FEDC68EEDC58BEBC488EBC286EBC184EBC0
            829F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF3DAB5F2D8B0F2D7ADF2
            D5AAF0D3A5EFD1A3EFD09FEFCE9DEFCC99EFCB97EDCA93EEC991EDC68EEBC58B
            EBC489EBC287EBC2869F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF4DD
            BAF3DAB6008100008100F2D5AAF0D4A7811E00811E00811E00811E00811E0081
            1E00811E00811E00811E00EDC58AEDC4889F6F60FF00FFFF00FFFF00FFFF00FF
            FF00FF93655FF4E0BDF3DEBB008100008100F3D8B0F2D5ACF0D4A9F2D3A4F0D1
            A1EFCF9FEFCE9CEECC98EECA96EEC992EDC990EDC68CEDC58B9F6F60FF00FFFF
            00FFFF00FFFF00FFFF00FF654441A79A86A69882A6977FA5967EA5957BA59378
            A59276A59173A59072A48F6EA48E6CA38C6AA38B68A18A66A18965A18862A188
            606C4C41FF00FFFF00FFFF00FF004B00004B00004B00004B00004B00004B0000
            4B00004B00004B00004B00004B00004B00004B00004B00004B00004B00004B00
            004B00004B00004B00004B00004B00004B00FF00FF004B00FF00FF986963F7E6
            CCF7E5C9F6E2C5F6E1C1F4DEBFF4DDBAF3DCB6F3D9B2F2D7AFF2D5ABF0D4A9F0
            D3A4F0D0A1EFCF9EEFCE9AEFCB98EECB969F6F60FF00FF004B00FF00FF004B00
            FF00FF9E6E64F8E9D0F7E6CE004B00004B00F6E2C2F4E0BF004B00004B00004B
            00004B00004B00004B00004B00004B00004B00EFCE9CEECC999F6F60FF00FF00
            4B00FF00FF004B00FF00FFA37266FAEBD7F8EAD3004B00004B00F6E3C7F6E2C4
            F4E0C0F4DEBCF3DCB8F3DCB5F2D8B1F2D7ADF2D4AAF0D3A6F0D1A4F0D0A0EFCE
            9D9F6F60FF00FF004B00FF00FF004B00FF00FF724F46AAA195A99F91A79E8FA9
            9E8EA99D8BA79A89A79A86A79983A79881A6977FA6967BA59379A59377A59175
            A59072A48F70A48F6D6C4C42FF00FF004B00FF00FF004B00004B00004A000049
            00004800004800004900004A00004B00004B00004B00004B00004B00004B0000
            4B00004B00004B00004B00004B00004B00004B00004B00004B00FF00FFFF00FF
            FF00FFA77766DED7CAD4CCBFD4CABBDCD1C1EBE0CAF4E6CFF7E9CFF7E6CAF6E3
            C7F4E2C4F4E0C0F4DEBCF4DCB8F3DCB5F3D9B1F2D7ADF0D5AAA07264FF00FFFF
            00FFFF00FFFF00FFFF00FFA1735FBFBAB0ABA59C005800006200DDD1C1F0E3D0
            801E00811E00811E00811E00811E00811E00811E00811E00811E00F3D9B2F3D8
            AFA07264FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B00004B00004B0000
            5600CEC5B6E7DCCBF0E5D1F6E7D1F6E7D0F7E6CEF7E5CAF6E3C6F6E1C2F4E0BF
            F3DEBBF4DCB6F3D9B4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B000895
            1106900E004B0098938BB8B0A6CEC5B8DDD4C2EBE1CEF6E9D3F8EAD3F7E7CEF7
            E6CBF6E3C6F6E1C4F6E0C0F4DEBCF3DDB8A07264FF00FFFF00FFFF00FFFF00FF
            FF00FF004B000C9D190A9814004B008A888198938CA7A198BFB6AADDD4C4F2E6
            D4F8EBD7F8EAD3F8E9D0F7E6CCF6E5C9F6E2C5F4E1C1F4E0BDA07264FF00FFFF
            00FF004B00004B00004B00004B0011A6240EA11D004B00004B00004B00004B00
            ABA59CD5CCC1F0E6D7F8EDD9FAEDD8F8EAD5F8E9D1F7E6CCF6E5CAF6E3C6F6E1
            C1A07264FF00FFFF00FF004B0025C74720C1401CBA3818B23014AC2911A5220D
            A01C0A9A17004B005814006E19007D1D00801E00811E00811E00811E00811E00
            811E00F7E6CAF6E3C6A07264FF00FFFF00FF004B002CD35528CC4D23C5451FBF
            3E1BB73517B02E13AB2710A520004B00BFBBB4DEDAD0F3EDE0FBF2E3FBF0E1FA
            EFDDF8EDDAF8EBD7F8EAD3F7E9CFF7E6CBA07264FF00FFFF00FF004B00004B00
            004B00004B0027CB4B22C443004B00004B00004B00004B00E0DCD7EFEAE2FAF3
            E9FBF4E9FBF2E5FAF2E2FBEFE0FAEEDAF8EBD8F8EAD4F7E7D0A07264FF00FFFF
            00FFFF00FFFF00FFFF00FF004B002DD45829CF52004B00AAA9A7D0CFCCEBE9E5
            F6F2EDFAF6EFFBF6EEFCF6EDFCF4E9FBF2E6FAF0E2FAEFE0FAEEDDFAEDD8F8EA
            D4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B0034DE6530D95E004B009D
            6B4FB77E5CC98965CE8C67CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68
            CF8E68CF8E68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B
            00004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentFont = False
          TabOrder = 8
          WordWrap = True
          OnClick = btnAbrirPastaClienteClick
        end
        object pnlIgnoraTravaMargemCondPag: TPanel
          Left = 786
          Top = 141
          Width = 243
          Height = 27
          BevelOuter = bvNone
          TabOrder = 3
          object lblIgtVmk: TLabel
            Left = -1
            Top = 0
            Width = 147
            Height = 28
            Alignment = taRightJustify
            Caption = 'Ignorar trava de Margem M'#225'xima/M'#237'nima da Cond. Pag.?'
            WordWrap = True
          end
          object cllIgtVmk: TColorLabel
            Left = 187
            Top = 6
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
          object dbeIgtVmk: TDBEditFocus
            Tag = 99
            Left = 149
            Top = 1
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_IGTVMK'
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
            OnEnter = dbeIgtVmkEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
      end
    end
    object tbsContato: TTabSheet
      Caption = '3 - Contatos'
      ImageIndex = 8
      object pnlDadosContatos: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 626
        Align = alClient
        BorderWidth = 2
        TabOrder = 0
        object pnlContatos: TPanel
          Left = 3
          Top = 42
          Width = 1031
          Height = 351
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 2
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label169: TLabel
            Left = 48
            Top = 5
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Nome:'
          end
          object Label170: TLabel
            Left = 29
            Top = 28
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Endere'#231'o:'
          end
          object Label171: TLabel
            Left = 46
            Top = 51
            Width = 32
            Height = 14
            Alignment = taRightJustify
            Caption = 'Bairro:'
          end
          object Label172: TLabel
            Left = 710
            Top = 5
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fone:'
          end
          object Label174: TLabel
            Left = 42
            Top = 75
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cidade:'
          end
          object Label175: TLabel
            Left = 453
            Top = 73
            Width = 25
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'UF:'
          end
          object Label176: TLabel
            Left = 47
            Top = 97
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'E-Mail:'
          end
          object Label178: TLabel
            Left = 719
            Top = 28
            Width = 18
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cel:'
          end
          object Label179: TLabel
            Left = 716
            Top = 51
            Width = 21
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fax:'
          end
          object Label180: TLabel
            Left = 447
            Top = 97
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'Depto:'
          end
          object Label184: TLabel
            Left = 44
            Top = 144
            Width = 32
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cargo:'
          end
          object Label211: TLabel
            Left = 46
            Top = 168
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'Depto:'
          end
          object Label212: TLabel
            Left = 516
            Top = 75
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dt. Nascim.'
          end
          object Label213: TLabel
            Left = 14
            Top = 191
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = 'Time Futebol:'
          end
          object Label214: TLabel
            Left = 43
            Top = 214
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Hobby:'
          end
          object Label215: TLabel
            Left = 12
            Top = 236
            Width = 65
            Height = 14
            Alignment = taRightJustify
            Caption = 'Escolaridade:'
          end
          object Label216: TLabel
            Left = 584
            Top = 168
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tempo Segmento:'
          end
          object lblTempEmp: TLabel
            Left = 590
            Top = 144
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tempo Empresa:'
          end
          object Label218: TLabel
            Left = 6
            Top = 260
            Width = 71
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gosto Musical:'
          end
          object Label219: TLabel
            Left = 19
            Top = 284
            Width = 58
            Height = 14
            Alignment = taRightJustify
            Caption = 'Estado Civil:'
          end
          object Label220: TLabel
            Left = 609
            Top = 191
            Width = 60
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtde. Filhos:'
          end
          object Label221: TLabel
            Left = 10
            Top = 315
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Certifica'#231#245'es:'
          end
          object lbl14: TLabel
            Left = 9
            Top = 120
            Width = 69
            Height = 14
            Alignment = taRightJustify
            Caption = 'Observa'#231#245'es:'
          end
          object imgWppCtt: TImage
            Left = 648
            Top = 27
            Width = 16
            Height = 16
            AutoSize = True
            Center = True
            Picture.Data = {
              0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
              000000100803000000282D0F530000000467414D410000B18F0BFC6105000000
              206348524D00007A26000080840000FA00000080E8000075300000EA6000003A
              98000017709CBA513C00000285504C5445EDEDEDFEFEFEFDFDFDFFFFFFEFEFEF
              FBFBFBEEEEEEF0F0F0F1F1F1ECECECE0E0E0F7F8F7FFFEFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFEFFF9FAF9FBFBFBFFFFFFFCFEFCFAFEFAFFFFFFFB
              FBFBF9F9F9FFFEFFFFFFFFFAFAFAE7E7E7FFFDFFFFFEFFF1F1F1FBFAFAFDFEFD
              FBFDFBFBFBFBFFFDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFD
              FFFFFDFFFBF9FBFCFAFBF3F3F3FEFDFDF3F3F3FAFAFAFEFEFEF8F7F8BCBCBCFE
              FDFEF3FBF4F7FBF8F9F8F9E8E9E8FDFDFDF6FBF7FEFDFDFFFDFFF1F9F2FEFCFD
              F7F6F6E6E7E6F8F8F8F8F8F8F6F5F6F0F0F0EEEEEEF6F5F6FCF9FCFEFBFEFEFB
              FEFCFAFCF7F6F7DAF5DDB0EAB598E39FADE9B3D7F4D9EDFAEE9AE3A261D36C55
              D06154D0605FD36B94E19CE9F9EAEEFAEF83DC8C50CD5D55CF6152CE5F7CDA86
              E9F9EB9DE3A54CCB5A89DD93C4EEC967D3734DCB5B4ECB5C93E09CE1F6E35BCE
              6954CC62DAF4DDFFFFFF9FE3A748C8574AC95949C95857CD64D9F4DCB9EABF45
              C65554CB62DEF5E1A6E4AD46C65646C75644C654AFE7B6A2E2AA3FC35042C453
              A7E4AFFBFEFB7CD6873EC34F42C45241C45240C3513FC34F97DFA0A5E2AD3BC1
              4D3CC14E53C862D5F2D9D8F3DB5ECC6C39C04B49C55A59CA683FC2503DC14F3B
              C14C99DFA2C1EBC73DC04F39BF4C37BE4A62CC71DFF4E2E2F6E48BDA96B1E6B8
              EAF8ECA4E2AC43C255B6E8BD5AC96933BC4735BD4859C869BFEAC5F5FCF6D6F1
              DA42C15550C561E4F6E798DDA22FB94331BA4538BD4C64CB7397DCA29FDFA95A
              C86A33BB47A5E1AD80D48D27B53C2BB7412AB7402CB7412AB73F28B63D2FB844
              8BD897F6FBF782D48F89D7959FDEA95CC76D33B9482AB54029B53F32B84757C5
              68AFE4B7FDFEFDCEEED3B4E5BCB3E5BBCCEDD1EFF9F0D58BAB87000000527452
              4E5300000000000000000000000445A5E3FBFCE5AB4C06148DEDF0971A13AAB6
              1A038998063FEAF14E9BADD8E6F1FCEFFBD2E190A036EA3F2AE2830263FAFE9E
              0FA9FCE7E5FEE27A0EC6AE6B323182C4E2E3C788B6487A6D00000001624B4744
              03110C4CF20000000970485973000014C3000014C30115704D42000000077449
              4D4507E60A11142219762A9F280000011B4944415418D3011001EFFE00000102
              0B0C0D0E0F101112131402030400020215161752535454555618191A02030005
              1B1C5758595A5B5B5A5C5D5E1D1E05001F205F60616263636363636164652122
              002324666768696A6B6C6C6C6C676D252600276E6F7071727374757575757677
              78280029797A7B7C727D7A7E7F7F7F7F80812A002B82838485868788898A8B89
              898C8D2C002D8E8F909192939495969798999A9B2E002F9C9D9E9FA0A1A2A3A4
              A5A6A79EA8300031A5A9AAABAAACADAE7272AFB0B1B23200332AB3B4B5B5B4B6
              B7B8B9BABBBC3435003637BDBEBFC0C1C1C2C2C3C4C5C63839003A3BC7C8C9CA
              CBCCCDCECFD03C3D3E06003FD140414243D2D3D4D5D64445460708004748494A
              4B4C4D4E4F50514B0309040AD48F69A2B3084A4B000000257445587464617465
              3A63726561746500323032322D31302D31375432303A33333A34332B30303A30
              301BEDAACA0000002574455874646174653A6D6F6469667900323032322D3130
              2D31375432303A33333A34332B30303A30306AB012760000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000000049
              454E44AE426082}
            Visible = False
          end
          object lblRamFon: TLabel
            Left = 849
            Top = 5
            Width = 32
            Height = 14
            Caption = 'Ramal:'
          end
          object lblRamFax: TLabel
            Left = 849
            Top = 51
            Width = 32
            Height = 14
            Caption = 'Ramal:'
          end
          object edtNomCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 1
            Width = 554
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 50
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEndCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 24
            Width = 554
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 50
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtBaiCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 47
            Width = 554
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 40
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesCidCtt: TEditFocus
            Left = 132
            Top = 70
            Width = 309
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtCidCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 70
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 8
            OnEnter = edtCidCttEnter
            OnExit = edtCidCttExit
            OnKeyDown = edtCidCttKeyDown
            OnKeyPress = edtCidCttKeyPress
            OnKeyUp = edtCidCttKeyUp
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtEstadoCtt: TEditFocus
            Left = 480
            Top = 69
            Width = 34
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 10
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEmaCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 93
            Width = 359
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecLowerCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 255
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDepCtt: TEditFocus
            Tag = 99
            Left = 480
            Top = 93
            Width = 156
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 80
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtNasCtt: TMaskEditFocus
            Tag = 99
            Left = 571
            Top = 70
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 11
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object edtCgoCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 140
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 15
            OnKeyPress = edtCgoCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCgoCtt: TEditFocus
            Left = 132
            Top = 140
            Width = 447
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
          object edtDptCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 163
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 18
            OnKeyPress = edtDptCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesDptCtt: TEditFocus
            Left = 132
            Top = 163
            Width = 447
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtTfuCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 186
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 21
            OnKeyPress = edtTfuCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesTfuCtt: TEditFocus
            Left = 132
            Top = 186
            Width = 447
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 22
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtHobCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 209
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 24
            OnKeyPress = edtHobCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesHobCtt: TEditFocus
            Left = 132
            Top = 209
            Width = 447
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
          object edtEscCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 232
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 26
            OnKeyPress = edtEscCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesEscCtt: TEditFocus
            Left = 132
            Top = 232
            Width = 447
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
          object edtDesGmuCtt: TEditFocus
            Left = 132
            Top = 255
            Width = 639
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 29
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtGmuCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 255
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 28
            OnKeyPress = edtGmuCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtEciCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 278
            Width = 49
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 30
            OnKeyPress = edtEciCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesEciCtt: TEditFocus
            Left = 132
            Top = 278
            Width = 639
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 31
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTemSeg: TEditFocus
            Tag = 99
            Left = 672
            Top = 163
            Width = 99
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 20
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object edtTemEmp: TEditFocus
            Tag = 99
            Left = 672
            Top = 140
            Width = 99
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 17
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object edtQtdFil: TEditFocus
            Tag = 99
            Left = 672
            Top = 186
            Width = 99
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 23
            Text = '0'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttNumerico
          end
          object mmCerCtt: TMemoFocus
            Tag = 99
            Left = 82
            Top = 301
            Width = 689
            Height = 47
            ScrollBars = ssVertical
            TabOrder = 32
            OnKeyPress = mmCerCttKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object btnAdicionarCtt: TBitBtnLocked
            Left = 741
            Top = 71
            Width = 99
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
            TabOrder = 33
            OnClick = btnAdicionarCttClick
          end
          object btnCancelaCtt: TBitBtnLocked
            Left = 741
            Top = 93
            Width = 99
            Height = 22
            Caption = 'Ca&ncelar'
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
            TabOrder = 34
            OnClick = btnCancelaCttClick
          end
          object edtObsCtt: TEditFocus
            Tag = 99
            Left = 82
            Top = 116
            Width = 689
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 100
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 100
            TipoTexto = ttAlfanumerico
          end
          object mskTelCtt: TMaskEditTelefone
            Tag = 99
            Left = 740
            Top = 1
            Width = 99
            Height = 22
            CharCase = ecUpperCase
            EditMask = '!\(99\)9999-9999;0;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 13
            TabOrder = 1
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
            Pais = opcBrasil
          end
          object mskCelCtt: TMaskEditTelefone
            Tag = 99
            Left = 740
            Top = 24
            Width = 99
            Height = 22
            CharCase = ecUpperCase
            EditMask = '!\(99\)9999-9999;0;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 13
            TabOrder = 4
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
            Pais = opcBrasil
          end
          object mskFaxCtt: TMaskEditTelefone
            Tag = 99
            Left = 740
            Top = 47
            Width = 99
            Height = 22
            CharCase = ecUpperCase
            EditMask = '!\(99\)9999-9999;0;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 13
            TabOrder = 6
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
            Pais = opcBrasil
          end
          object edtRamFon: TEditFocus
            Tag = 99
            Left = 883
            Top = 0
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 4
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 4
            TipoTexto = ttNumerico
          end
          object edtRamFax: TEditFocus
            Tag = 99
            Left = 883
            Top = 47
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 4
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 4
            TipoTexto = ttNumerico
          end
        end
        object Panel1: TPanel
          Left = 3
          Top = 393
          Width = 1031
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object Label177: TLabel
            Left = 4
            Top = 4
            Width = 261
            Height = 14
            AutoSize = False
            Caption = 'Lista de Contatos (ALT + 4 pr'#243'xima p'#225'gina):'
          end
          object btnGatWpp: TBitBtnLocked
            Left = 792
            Top = 0
            Width = 239
            Height = 22
            Align = alRight
            Caption = 'Whatsapp - Gatilhos para envio de mensagens'
            TabOrder = 0
            Visible = False
            OnClick = btnGatWppClick
          end
        end
        object dbgContatos: TDBGridCitel
          Left = 3
          Top = 415
          Width = 1031
          Height = 208
          Align = alClient
          DataSource = dtsCliCtt
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 3
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnEnter = dbgContatosEnter
          OnKeyDown = dbgContatosKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'CLI_AUTCTT'
              Title.Caption = 'Aut.'
              Width = 27
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_CPFCTT'
              Title.Caption = 'CPF'
              Width = 97
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_RG_CTT'
              Title.Caption = 'R.G.'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMCTT'
              Title.Caption = 'Nome'
              Width = 205
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CLI_TELCTT'
              Title.Alignment = taCenter
              Title.Caption = 'Telefone'
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_RAMFON'
              Title.Caption = 'Ramal Fone'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CLI_CELCTT'
              Title.Alignment = taCenter
              Title.Caption = 'Celular'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CLI_FAXCTT'
              Title.Alignment = taCenter
              Title.Caption = 'Fax'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_RAMFAX'
              Title.Caption = 'Ramal Fax'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CLI_DEPCTT'
              Title.Alignment = taCenter
              Title.Caption = 'Departamento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_ENDCTT'
              Title.Caption = 'Endere'#231'o'
              Width = 162
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_BAICTT'
              Title.Caption = 'Bairro'
              Width = 115
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMCID'
              Title.Caption = 'Cidade'
              Width = 129
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_ESTCID'
              Title.Caption = 'UF'
              Width = 24
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_EMACTT'
              Title.Caption = 'E-Mail'
              Width = 255
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMCGO'
              Title.Caption = 'Cargo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMDPT'
              Title.Caption = 'Departamento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMTFU'
              Title.Caption = 'Time de Futebol'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMHOB'
              Title.Caption = 'Hobby'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMESC'
              Title.Caption = 'Escolaridade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMGMU'
              Title.Caption = 'Gosto Musical'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NOMECI'
              Title.Caption = 'Estado Civil'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_NASCTT'
              Title.Caption = 'Data de Nascimento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_TEMEMP'
              Title.Caption = 'Tempo de Empresa'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_TEMSEG'
              Title.Caption = 'Tempo de Segmento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLI_QTDFIL'
              Title.Caption = 'Qtde. Filhos'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AUTOINCREM'
              Visible = False
            end>
        end
        object pnlAutCtt: TPanel
          Left = 3
          Top = 3
          Width = 1031
          Height = 39
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object LabelCgcCpf1: TLabel
            Left = 56
            Top = 23
            Width = 22
            Height = 14
            Alignment = taRightJustify
            Caption = 'CPF:'
          end
          object lblRG: TLabelRg
            Left = 209
            Top = 23
            Width = 24
            Height = 14
            Alignment = taRightJustify
            Caption = 'R.G.:'
            Pais = opcBrasil
          end
          object edtRg_Ctt: TEditFocus
            Tag = 99
            Left = 239
            Top = 17
            Width = 161
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 15
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskCpfCtt: TMaskEditC_G_C_
            Tag = 99
            Left = 82
            Top = 17
            Width = 118
            Height = 22
            CharCase = ecUpperCase
            EditMask = '999.999.999-99;0;'
            MaxLength = 14
            TabOrder = 1
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object chkAutCtt: TCheckBox
            Tag = 99
            Left = 82
            Top = 0
            Width = 145
            Height = 17
            Caption = 'Autorizado comprar'
            TabOrder = 0
          end
        end
      end
    end
    object tbsEntregas: TTabSheet
      Caption = '4 - Endere'#231'os de Entrega'
      ImageIndex = 9
      OnHide = tbsEntregasHide
      OnShow = tbsEntregasShow
      object pnlEntregas: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 544
        Align = alClient
        Caption = 
          'AQUI SERA EXIBIDO O FORM DE CADASTRO DE ENDERECOS DE ENTREGA, NA' +
          'O COLOCAR NADA NESTE PANEL....'
        ParentColor = True
        TabOrder = 0
      end
      object pnlOrientacoes: TPanel
        Left = 0
        Top = 544
        Width = 1037
        Height = 82
        Align = alBottom
        TabOrder = 1
        object lblOrientacoes: TLabel
          AlignWithMargins = True
          Left = 6
          Top = 4
          Width = 127
          Height = 77
          Margins.Left = 5
          Align = alLeft
          Caption = 'Orienta'#231#245'es para entrega:'
          Layout = tlCenter
          ExplicitHeight = 14
        end
        object memOrientacoes: TDBMemoFocus
          Left = 136
          Top = 1
          Width = 441
          Height = 80
          Align = alLeft
          DataField = 'CLI_ORIENT'
          DataSource = dtsTabela
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
    object tbsCbrEnt: TTabSheet
      Caption = '5 - Dados de Cobran'#231'a'
      ImageIndex = 2
      object grbConsulta: TGroupBox
        Left = 28
        Top = 304
        Width = 761
        Height = 315
        Caption = 'Consulta de Cr'#233'dito'
        TabOrder = 1
        object Label150: TLabel
          Left = 8
          Top = 27
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Tipo de Pesquisa:'
        end
        object pnlConsulta: TPanel
          Tag = 99
          Left = 0
          Top = 50
          Width = 734
          Height = 262
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 3
          object Label151: TLabel
            Left = 8
            Top = 25
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Data da Consulta:'
          end
          object Label152: TLabel
            Left = 22
            Top = 52
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Protestos:'
          end
          object Label153: TLabel
            Left = 145
            Top = 52
            Width = 102
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cheques Devolvidos:'
          end
          object Label154: TLabel
            Left = 9
            Top = 72
            Width = 85
            Height = 61
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Observa'#231#245'es:'#13#10'Pressione TAB'#13#10'para a pr'#243'xima'#13#10'p'#225'gina'
          end
          object lblQtdDiasRestantesConsultaCredito: TLabel
            Left = 188
            Top = 30
            Width = 169
            Height = 14
            Caption = '100 Dia(s) restante(s) para expirar'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object lblPerfin: TLabel
            Left = 304
            Top = 52
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'Perfin:'
          end
          object dbeDtaCon: TDBEditFocus
            Tag = 99
            Left = 95
            Top = 24
            Width = 87
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_DTACON'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeQrdPro: TDBEditFocus
            Tag = 99
            Left = 95
            Top = 48
            Width = 32
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_QTDPRO'
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
          object dbeCheDev: TDBEditFocus
            Tag = 99
            Left = 251
            Top = 48
            Width = 32
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_CHEDEV'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeObsCon: TDBMemoFocus
            Tag = 99
            Left = 95
            Top = 72
            Width = 637
            Height = 185
            DataField = 'CLI_OBSCON'
            DataSource = dtsTabela
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 7
            OnKeyPress = dbeObservKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object btnConSCPC: TBitBtnLocked
            Left = 623
            Top = 47
            Width = 109
            Height = 23
            Caption = '&Consultar SCPC'
            Enabled = False
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B
              00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF004B00004B00FF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B00004B0034CB
              5C17A72B004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FF004B003ED76D3ED76D25BA430C9718004B00FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B00004B003ED7
              6D34CB5B004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF004B00004B00FF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF035A9102416A045486FF00FFFF00FF004B
              00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF02558E28
              82A55339240911140B5B88FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF02558E1CBFFF3692ADFFCF8962442D0D2433FF00FF0038
              6C00386CFF00FFFF00FFFF00FFFF00FFFF00FF02558E1BADEB1697D53FC5FE5D
              BAE0DAA976CB925E161D230E609600386C00386C033E64FF00FFFF00FFFF00FF
              02558E2BC2FE51D4FF41A0D099D3EFEDFFFFD4D0C9836E5818445B44ABDE4AAD
              D7695A460A0A09013B650460991680B85CD3FF8CDDFFC1EDFFD0EBF74093B89D
              CCE272BBDD2182B60C96CF31C2FF1AA5E0C2AC86623C2300243D03518802558E
              BFE5F7F8FFFFEEFBFFD0F2FF45ABD7027FB60075AA006FA50493C91FB7F81EC1
              FF64A5AD725033002A4702558EAAD0E302558E8AC5DE7ACEF457D0FF39CAFF1E
              AFED0B84C00173AA0089BC0FA1DC21BCFB129DDD0C4B6D004476FF00FF02558E
              02558E02558E148AC51498D71CB1F221BAFA1FB4F417A1E00774AC00578A0660
              9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF056BA504649E08
              7AB50474AF005188FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 6
            OnClick = btnConSCPCClick
          end
          object btnAbrirPastaCredito: TBitBtnLocked
            Left = 478
            Top = 47
            Width = 140
            Height = 23
            Caption = 'Arquivos de Consulta'
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
            TabOrder = 5
            OnClick = btnAbrirPastaCreditoClick
          end
          object pnlProdutoSerasa: TPanel
            Left = 47
            Top = -3
            Width = 408
            Height = 25
            BevelOuter = bvNone
            ShowCaption = False
            TabOrder = 2
            object Label76: TLabel
              Left = -1
              Top = 5
              Width = 48
              Height = 15
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Produto:'
            end
            object cbProdutoSerasa: TComboBoxFocus
              Tag = 99
              Left = 48
              Top = 3
              Width = 137
              Height = 22
              Style = csDropDownList
              TabOrder = 0
              OnChange = cmbTipoPesquisaChange
              Items.Strings = (
                'Portal'
                'PowerCurve'
                'Experian')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object btnConsultaSerasaPowerCurve: TBitBtnLocked
              Tag = 99
              Left = 187
              Top = 3
              Width = 92
              Height = 23
              Hint = 'Atualiza Limite de Cr'#233'dito'
              Caption = 'PowerCurve'
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00004463D8FF00000000000000004463D8FF0000000000000000000000000000
                0000848484FF848484FF848484FF848484FF848484FF848484FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF4463D8FF4463D8FF000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
                C1FFC1C1C1FFC1C1C1FFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FF848484FFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF848484FF848484FF0000000000000000000000000000
                00000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF00000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
                0000000000000000000000000000000000000000000000000000}
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = btnConsultaSerasaPowerCurveClick
            end
            object BtnConsultaSerasaExperian: TBitBtnLocked
              Tag = 99
              Left = 279
              Top = 2
              Width = 123
              Height = 23
              Hint = 'Serasa Experian'
              Caption = 'Serasa Experian'
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00004463D8FF00000000000000004463D8FF0000000000000000000000000000
                0000848484FF848484FF848484FF848484FF848484FF848484FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF4463D8FF00000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF4463D8FF4463D8FF000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4463
                D8FF4463D8FF4463D8FF4463D8FFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
                C1FFC1C1C1FFC1C1C1FFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
                0000848484FF848484FFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF848484FF848484FF0000000000000000000000000000
                00000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF00000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
                0000000000000000000000000000000000000000000000000000}
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = BtnConsultaSerasaExperianClick
            end
          end
          object dbePerfin: TDBEditFocus
            Tag = 99
            Left = 339
            Top = 48
            Width = 32
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CLI_PERFIN'
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object cmbTipoPesquisa: TComboBoxFocus
          Tag = 99
          Left = 96
          Top = 24
          Width = 137
          Height = 22
          TabOrder = 0
          Text = 'NENHUM'
          OnChange = cmbTipoPesquisaChange
          Items.Strings = (
            'NENHUM'
            'SERASA'
            'EQUIFAX'
            'SINDCOMERCIO'
            'CHECKCHECK'
            'MASTER LITE E A'#199#213'ES'
            'SCPC'
            'AN'#193'LISE INTERNA'
            'SPC')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object pnlTipoCreditoBV: TPanel
          Left = 238
          Top = 21
          Width = 261
          Height = 25
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 1
          object Label73: TLabel
            Left = 2
            Top = 5
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Tipo de Cr'#233'dito:'
          end
          object cmpTipoCreditoBV: TComboBoxFocus
            Tag = 99
            Left = 89
            Top = 2
            Width = 121
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = cmbTipoPesquisaChange
            Items.Strings = (
              'Cr'#233'dito Direto'
              'Cr'#233'dito Pessoal'
              'Cr'#233'dito de Ve'#237'culos '
              'Cart'#227'o de Cr'#233'dito '
              'Cheque'
              'Outros')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlTipoConsultaPOA: TPanel
          Left = 494
          Top = 22
          Width = 243
          Height = 52
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 2
          object Label79: TLabel
            Left = 2
            Top = 5
            Width = 47
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Consulta:'
          end
          object lblTipoConsulta: TLabel
            Left = 0
            Top = 30
            Width = 88
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Tipo da Consulta:'
            Visible = False
          end
          object cmpConsultaPOA: TComboBoxFocus
            Tag = 99
            Left = 51
            Top = 2
            Width = 187
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = cmpConsultaPOAChange
            Items.Strings = (
              'Familia Positivo'
              'Rede Positivo'
              'Define Risco Positivo'
              'Define Neg'#243'cio Positivo'
              'Define Limite Positivo')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmpTipoConsultaPOA: TComboBoxFocus
            Tag = 99
            Left = 90
            Top = 26
            Width = 148
            Height = 22
            Style = csDropDownList
            ItemIndex = 1
            TabOrder = 1
            Text = 'CPC - Consulta Completo'
            Visible = False
            Items.Strings = (
              'CPE - Consulta Essencial'
              'CPC - Consulta Completo'
              'CPM - Consulta Mais')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
      object grbDadosCobranca: TGroupBox
        Left = 28
        Top = 0
        Width = 761
        Height = 301
        Caption = '   Dados de Cobran'#231'a   '
        TabOrder = 0
        object Label48: TLabel
          Left = 23
          Top = 46
          Width = 106
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cobran'#231'a - Endere'#231'o:'
        end
        object Label49: TLabel
          Left = 237
          Top = 24
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label51: TLabel
          Left = 530
          Top = 24
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label53: TLabel
          Left = 107
          Top = 24
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label54: TLabel
          Left = 97
          Top = 68
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label55: TLabel
          Left = 405
          Top = 68
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato:'
        end
        object Label56: TLabel
          Left = 85
          Top = 91
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone:'
        end
        object Label167: TLabel
          Left = 39
          Top = 114
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail Cobran'#231'a 1:'
        end
        object Label168: TLabel
          Left = 39
          Top = 137
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail Cobran'#231'a 2:'
        end
        object Label28: TLabel
          Left = 11
          Top = 160
          Width = 118
          Height = 14
          Alignment = taRightJustify
          Caption = 'Enviar boleto por e-mail?'
        end
        object ColorLabel27: TColorLabel
          Left = 159
          Top = 160
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lbl24: TLabel
          Left = 244
          Top = 160
          Width = 252
          Height = 14
          Alignment = taRightJustify
          Caption = 'Impress'#227'o do boleto pelo faturamento ser'#225' feita por:'
        end
        object clb3: TColorLabel
          Left = 523
          Top = 160
          Width = 92
          Height = 14
          Caption = '(E)mpresa (B)anco'
          CorDestaque = clRed
        end
        object lblPerDPo: TLabel
          Left = 16
          Top = 183
          Width = 113
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto Pontualidade:'
        end
        object lblPercn2: TLabel
          Left = 212
          Top = 183
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblQtdDAV: TLabel
          Left = 235
          Top = 183
          Width = 428
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Qtde de Dias de Antecipa'#231#227'o do Vencimento para Concess'#227'o do Desc' +
            'onto Pontualidade:'
        end
        object Label263: TLabel
          Left = 44
          Top = 206
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data da Consulta:'
        end
        object Label67: TLabel
          Left = 44
          Top = 230
          Width = 426
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Na impress'#227'o de boletos, exibe a parcela no n'#250'mero do documento ' +
            'para vendas '#224' vista:'
        end
        object ColorLabel6: TColorLabel
          Left = 499
          Top = 230
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblPesFit: TLabel
          Left = 450
          Top = 253
          Width = 213
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltima consulta de situa'#231#227'o cadastral na FIT:'
        end
        object ColorLabel21: TColorLabel
          Left = 330
          Top = 253
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label71: TLabel
          Left = 44
          Top = 253
          Width = 258
          Height = 14
          Alignment = taRightJustify
          Caption = 'Utilizar senha ao abrir pdf de boleto banc'#225'rio no email'
        end
        object lblQtdDiasRestantesConsulta: TLabel
          Left = 226
          Top = 206
          Width = 169
          Height = 14
          Caption = '100 Dia(s) restante(s) para expirar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object ColorLabel35: TColorLabel
          Left = 330
          Top = 277
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label74: TLabel
          Left = 44
          Top = 277
          Width = 256
          Height = 14
          Alignment = taRightJustify
          Caption = 'Utilizar controle de protesto personalizado por cliente'
        end
        object btnHlpEmailCob: TSpeedButton
          Left = 623
          Top = 113
          Width = 20
          Height = 20
          Flat = True
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
          ParentShowHint = False
          ShowHint = False
          OnClick = btnHlpEmailCobClick
        end
        object dbeEndCob: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 42
          Width = 484
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_ENDCOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCidCob: TDBEditFocus
          Tag = 99
          Left = 276
          Top = 20
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CIDCOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          OnKeyPress = dbeCidCobKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCidCobChamaCadastro
        end
        object dbeCepCob: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 20
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CEPCOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnKeyPress = dbeCepCobKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBaiCob: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 64
          Width = 239
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_BAICOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConCob: TDBEditFocus
          Tag = 99
          Left = 448
          Top = 64
          Width = 169
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CONCOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTelCob: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 87
          Width = 141
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_TELCOB'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCidCob: TEditFocus
          Left = 321
          Top = 20
          Width = 194
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
        object edtEstCob: TEditFocus
          Left = 571
          Top = 19
          Width = 46
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
        object dbeEMCOB1: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 110
          Width = 484
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_EMCOB1'
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
        object dbeEMCOB2: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 133
          Width = 484
          Height = 22
          CharCase = ecLowerCase
          DataField = 'CLI_EMCOB2'
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
        object dbeEnvBol: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 156
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_ENVBOL'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePesFit: TDBEditFocus
          Tag = 99
          Left = 669
          Top = 249
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'CLI_PESFIT'
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
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBolImp: TDBEditFocus
          Tag = 99
          Left = 497
          Top = 156
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_BOLIMP'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePerDPo: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 179
          Width = 74
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_PERDPO'
          DataSource = dtsTabela
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeQtdDAV: TDBEditFocus
          Tag = 99
          Left = 669
          Top = 179
          Width = 74
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_QTDDAV'
          DataSource = dtsTabela
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDtCoCb: TDBEditFocus
          Tag = 99
          Left = 133
          Top = 203
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_DTCOCB'
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
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBolPar: TDBEditFocus
          Tag = 99
          Left = 476
          Top = 226
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_BOLPAR'
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
        object dbeBolSen: TDBEditFocus
          Tag = 99
          Left = 307
          Top = 249
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_BOLSEN'
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
        object dbeProper: TDBEditFocus
          Tag = 99
          Left = 307
          Top = 273
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_PROPER'
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
      end
    end
    object tbsObservacoes: TTabSheet
      Caption = '6 - Informa'#231#245'es de Compra'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 626
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label29: TLabel
          Left = 14
          Top = 6
          Width = 137
          Height = 14
          Caption = 'Informa'#231#245'es de Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GroupBox1: TGroupBox
          Left = 14
          Top = 24
          Width = 257
          Height = 97
          Caption = #218'ltima Compra:'
          TabOrder = 0
          object Label44: TLabel
            Left = 57
            Top = 47
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data:'
          end
          object Label46: TLabel
            Left = 53
            Top = 70
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor:'
          end
          object Label33: TLabel
            Left = 25
            Top = 23
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Documento:'
          end
          object dbeUltCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 43
            Width = 91
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_ULTCOM'
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
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrUco: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 66
            Width = 91
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_VRUCOM'
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
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDouCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 19
            Width = 138
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_DOUCOM'
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
            TabOrder = 2
            OnKeyPress = dbeDouComKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox2: TGroupBox
          Left = 280
          Top = 24
          Width = 257
          Height = 97
          Caption = 'Maior Compra:'
          TabOrder = 1
          object Label30: TLabel
            Left = 57
            Top = 47
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 55
            Top = 70
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor:'
          end
          object Label34: TLabel
            Left = 25
            Top = 23
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Documento:'
          end
          object dbeVrmCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 66
            Width = 91
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_VRMCOM'
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
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtmCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 43
            Width = 91
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_DTMCOM'
            DataSource = dtsTabela
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDomCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 19
            Width = 138
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_DOMCOM'
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
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object grbMedCom: TGroupBox
          Left = 14
          Top = 132
          Width = 523
          Height = 105
          Caption = 'M'#233'dia Mensal de Compra'
          TabOrder = 2
          object Label252: TLabel
            Left = 23
            Top = 48
            Width = 28
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Valor:'
            ParentBiDiMode = False
          end
          object lblMar03M: TLabel
            Left = 10
            Top = 76
            Width = 41
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Margem:'
            ParentBiDiMode = False
          end
          object Label254: TLabel
            Left = 13
            Top = 20
            Width = 153
            Height = 14
            Alignment = taCenter
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '3 Meses'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentBiDiMode = False
            ParentFont = False
          end
          object Bevel3: TBevel
            Left = 176
            Top = 9
            Width = 13
            Height = 93
            Shape = bsLeftLine
          end
          object Label255: TLabel
            Left = 196
            Top = 48
            Width = 28
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Valor:'
            ParentBiDiMode = False
          end
          object lblMar06M: TLabel
            Left = 183
            Top = 76
            Width = 41
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Margem:'
            ParentBiDiMode = False
          end
          object Label257: TLabel
            Left = 186
            Top = 20
            Width = 153
            Height = 14
            Alignment = taCenter
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '6 Meses'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentBiDiMode = False
            ParentFont = False
          end
          object Bevel4: TBevel
            Left = 349
            Top = 8
            Width = 13
            Height = 93
            Shape = bsLeftLine
          end
          object Label258: TLabel
            Left = 371
            Top = 48
            Width = 28
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Valor:'
            ParentBiDiMode = False
          end
          object lblMar12M: TLabel
            Left = 358
            Top = 76
            Width = 41
            Height = 14
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Caption = 'Margem:'
            ParentBiDiMode = False
          end
          object Label260: TLabel
            Left = 361
            Top = 20
            Width = 153
            Height = 14
            Alignment = taCenter
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '12 Meses'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentBiDiMode = False
            ParentFont = False
          end
          object edtVal3Me: TEditFocus
            Tag = 50
            Left = 57
            Top = 44
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
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
          object edtMar3Me: TEditFocus
            Tag = 50
            Left = 57
            Top = 72
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
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
          object edtVal6Me: TEditFocus
            Tag = 50
            Left = 230
            Top = 44
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
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
          object edtMar6Me: TEditFocus
            Tag = 50
            Left = 230
            Top = 72
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtVal12M: TEditFocus
            Tag = 50
            Left = 405
            Top = 44
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ReadOnly = True
            TabOrder = 4
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtMar12M: TEditFocus
            Tag = 50
            Left = 405
            Top = 72
            Width = 109
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ReadOnly = True
            TabOrder = 5
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
        object btnCalcCompraMensal: TBitBtnLocked
          Tag = 50
          Left = 147
          Top = 126
          Width = 33
          Height = 27
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000020000
            000A000000160000001B000000170000000B0000000200000000000000010000
            00060000000B0000000F0000000C0000000600000001000000000000000F2616
            1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
            1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
            70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
            72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
            D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
            D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
            F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
            F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
            E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
            E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
            A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
            CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
            5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
            CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
            3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
            D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
            1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
            E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
            0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
            C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
            0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
            58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
            0000000000010000000400000006000000050000000200000000000000000000
            0001000000010000000100000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 3
          OnClick = btnCalcCompraMensalClick
        end
        object GroupBox4: TGroupBox
          Left = 547
          Top = 24
          Width = 257
          Height = 97
          Caption = 'Primeira Compra:'
          TabOrder = 4
          object Label265: TLabel
            Left = 57
            Top = 47
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data:'
          end
          object dbePriCom: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 43
            Width = 91
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'CLI_PRICOM'
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
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
    object tbsDadosFiscais: TTabSheet
      Caption = '7 - Dados Fiscais'
      ImageIndex = 11
      object pnlMsgDirAlqRet: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 18
        Align = alTop
        Caption = 'SEM DIREITO DE ACESSO PARA ALQ. RETEN'#199#195'O'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object pnlTipAbf: TPanel
        Left = 0
        Top = 18
        Width = 1037
        Height = 20
        Align = alTop
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblAbfTit: TLabel
          Left = 10
          Top = 3
          Width = 139
          Height = 14
          Caption = 'Tipo de Abrv. Fiscal de ICMS:'
          Visible = False
        end
        object lblAbfDes: TLabel
          Left = 151
          Top = 3
          Width = 433
          Height = 14
          Caption = 
            'PER - ENTRADAS PESSOA JUR'#205'DICA (DISTRIBUI'#199#195'O/REVENDA/COMERCIALIZ' +
            'A'#199#195'O)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          Visible = False
        end
        object btnAbf: TBitBtnLocked
          Left = 679
          Top = 0
          Width = 113
          Height = 19
          Caption = 'Cad Abrv. ICMS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
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
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Visible = False
          OnClick = btnAbfClick
        end
      end
      object pgDadosFiscais: TPageControl
        Left = 0
        Top = 38
        Width = 1037
        Height = 588
        ActivePage = TabBeneficiosDescontos
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 2
        object TabBeneficiosDescontos: TTabSheet
          Caption = 'Resumo Benef'#237'cios/Descontos'
          ImageIndex = 11
          inline fraClienteResumo: TfraClienteResumo
            Left = 3
            Top = 5
            Width = 1022
            Height = 193
            TabOrder = 0
            ExplicitLeft = 3
            ExplicitTop = 5
            ExplicitWidth = 1022
            ExplicitHeight = 193
            inherited cxDBVerticalGrid: TcxDBVerticalGrid
              Width = 1022
              Height = 193
              OptionsView.RowHeaderWidth = 293
              ExplicitWidth = 1022
              ExplicitHeight = 193
              Version = 1
              inherited cxDBVerticalGridTipodeAbrevFiscaldeICMS: TcxDBEditorRow
                ID = 0
                ParentID = -1
                Index = 0
                Version = 1
              end
              inherited cxDBVerticalGridZonaFranca: TcxDBEditorRow
                ID = 1
                ParentID = -1
                Index = 1
                Version = 1
              end
              inherited cxDBVerticalGridSuframa: TcxDBEditorRow
                ID = 2
                ParentID = -1
                Index = 2
                Version = 1
              end
              inherited cxDBVerticalGridValidadeSuframa: TcxDBEditorRow
                ID = 3
                ParentID = -1
                Index = 3
                Version = 1
              end
              inherited cxDBVerticalGridIndstria: TcxDBEditorRow
                ID = 4
                ParentID = -1
                Index = 4
                Version = 1
              end
              inherited cxDBVerticalGridrgoPblico: TcxDBEditorRow
                ID = 5
                ParentID = -1
                Index = 5
                Version = 1
              end
              inherited cxDBVerticalGridUtilizardiferimentodeICMS: TcxDBEditorRow
                ID = 6
                ParentID = -1
                Index = 6
                Version = 1
              end
              inherited cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial: TcxDBEditorRow
                ID = 7
                ParentID = -1
                Index = 7
                Version = 1
              end
              inherited cxDBVerticalGridIsenodeIPI: TcxDBEditorRow
                ID = 8
                ParentID = -1
                Index = 8
                Version = 1
              end
              inherited cxDBVerticalGridBenefcioREIDI: TcxDBEditorRow
                ID = 9
                ParentID = -1
                Index = 9
                Version = 1
              end
            end
            inherited DataSource: TDataSource
              Left = 216
            end
          end
        end
        object TabGeral: TTabSheet
          Caption = 'Dados Gerais'
          object pnlDadosGerais: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label39: TLabel
              Left = 97
              Top = 20
              Width = 68
              Height = 14
              Alignment = taRightJustify
              Caption = 'Zona Franca?'
            end
            object ColorLabel10: TColorLabel
              Left = 217
              Top = 20
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
            object Label181: TLabel
              Left = 121
              Top = 45
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Suframa:'
            end
            object lbl13: TLabel
              Left = 79
              Top = 91
              Width = 86
              Height = 14
              Alignment = taRightJustify
              Caption = 'Regime Tribut'#225'rio:'
            end
            object clb2: TColorLabel
              Left = 217
              Top = 90
              Width = 224
              Height = 14
              Caption = '(S)imples  /  Lucro (R)eal  /  Lucro (P)resumido'
              CorDestaque = clRed
            end
            object lblInd: TLabel
              Left = 118
              Top = 113
              Width = 47
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ind'#250'stria?'
            end
            object clbInd: TColorLabel
              Left = 216
              Top = 113
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
            object lblIndCom: TColorLabel
              Left = 8
              Top = 135
              Width = 157
              Height = 14
              Caption = 'Sugest'#227'o para Indus. ou Comer.:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object Label142: TLabel
              Left = 72
              Top = 158
              Width = 93
              Height = 14
              Alignment = taRightJustify
              Caption = 'Seguridade Social?'
            end
            object ColorLabel11: TColorLabel
              Left = 215
              Top = 158
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
            object lbl25: TLabel
              Left = 93
              Top = 181
              Width = 72
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo IBAMA:'
            end
            object Label116: TLabel
              Left = 134
              Top = 204
              Width = 31
              Height = 14
              Alignment = taRightJustify
              Caption = 'CNAE:'
            end
            object Label201: TLabel
              Left = 136
              Top = 228
              Width = 29
              Height = 14
              Alignment = taRightJustify
              Caption = 'TARE:'
            end
            object clbDesZon: TColorLabel
              Left = 909
              Top = 366
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
            object lblDesZon: TLabel
              Left = 8
              Top = 368
              Width = 845
              Height = 14
              Caption = 
                'Aplicar desconto especial somente da diferen'#231'a entre aliquota pr' +
                'aticada e aliquota interestadual, e destacar o icms da aliquota ' +
                'praticada na venda, para produtos importados ?'
            end
            object lblMsgAtoDDF: TLabel
              Left = 22
              Top = 394
              Width = 143
              Height = 28
              Alignment = taRightJustify
              Caption = 'Mensagem a ser inclu'#237'da nos dados adicionais da NF-e:'
              WordWrap = True
            end
            object clbExpInd: TColorLabel
              Left = 215
              Top = 252
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
            object lblExpInd: TLabel
              Left = 69
              Top = 252
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'Exporta'#231#227'o Indireta:'
            end
            object lblNaturezaServico: TLabel
              Left = 8
              Top = 483
              Width = 269
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo da Natureza da Opera'#231#227'o para Nota de Servi'#231'o:'
            end
            object Label75: TLabel
              Left = 77
              Top = 67
              Width = 88
              Height = 14
              Alignment = taRightJustify
              Caption = 'Validade Suframa:'
            end
            object dbeZonFra: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 17
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ZONFRA'
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
              TipoTexto = ttAlfabetico
            end
            object dbeSuframa: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 39
              Width = 125
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_SUFRAM'
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
            object dbeRegTri: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 86
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_REGTRI'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeIndust: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 109
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_INDUST'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbcIndCom: TDBComboBoxFocus
              Tag = 99
              Left = 171
              Top = 132
              Width = 137
              Height = 22
              Style = csDropDownList
              DataField = 'CLI_INDCOM'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Items.Strings = (
                'Comercializa'#231#227'o'
                'Industrializa'#231#227'o')
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeSegSoc: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 155
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_SEGSOC'
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
              TipoTexto = ttAlfabetico
            end
            object dbeCodIba: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 178
              Width = 138
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODIBA'
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
            object dbeCNAE: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 201
              Width = 69
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CODCNA'
              DataSource = dtsTabela
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 7
              ParentFont = False
              TabOrder = 8
              OnKeyPress = dbeCNAEKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCNAEChamaCadastro
            end
            object dbeTare__: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 224
              Width = 125
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_TARE__'
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
            object grbNotaEspecial: TGroupBox
              Left = 5
              Top = 266
              Width = 416
              Height = 96
              Caption = 'Nota Especial'
              TabOrder = 10
              object lblFtNfEs: TLabel
                Left = 65
                Top = 19
                Width = 96
                Height = 14
                Alignment = taRightJustify
                Caption = 'Fator Nota Especial:'
              end
              object lbl8: TLabel
                Left = 27
                Top = 43
                Width = 134
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tipo de Fator Nota Especial:'
              end
              object clb1: TColorLabel
                Left = 214
                Top = 43
                Width = 100
                Height = 14
                Caption = '(V)alor (Q)uantidade'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                CorDestaque = clRed
              end
              object lblTipFatPed: TLabel
                Left = 88
                Top = 65
                Width = 73
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tipo de Pedido:'
              end
              object lblTipFat: TColorLabel
                Left = 211
                Top = 65
                Width = 129
                Height = 14
                AutoSize = False
                Caption = '(A) - Nota Fiscal  (B) - FF'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                CorDestaque = clRed
              end
              object dbeFtNfEs: TDBEditFocus
                Tag = 99
                Left = 166
                Top = 16
                Width = 72
                Height = 22
                Hint = 'Informe valor zero para n'#227'o utilizar este fator para o cliente'
                CharCase = ecUpperCase
                DataField = 'CLI_FTNFES'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 6
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnEnter = dbeFtNfEsEnter
                OnExit = dbeFtNfEsExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeTFtNEs: TDBEditFocus
                Tag = 99
                Left = 166
                Top = 39
                Width = 39
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_TFTNES'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 6
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnEnter = dbeTFtNEsEnter
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfabetico
              end
              object dbeTipFat: TDBEditFocus
                Tag = 99
                Left = 166
                Top = 62
                Width = 39
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_TIPFAT'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 6
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfabetico
              end
            end
            object dbeDesZon: TDBEditFocus
              Tag = 99
              Left = 864
              Top = 362
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DESZON'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbmMsgAtoDDF: TDBMemoFocus
              Tag = 99
              Left = 171
              Top = 394
              Width = 827
              Height = 80
              DataField = 'CLI_MSATDF'
              DataSource = dtsTabela
              MaxLength = 255
              ScrollBars = ssVertical
              TabOrder = 12
              StyleElements = []
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object edtDesCna: TEditFocus
              Left = 241
              Top = 201
              Width = 482
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
            object dbeExpInd: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 247
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_EXPIND'
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
              TipoTexto = ttAlfabetico
            end
            object dbeNaturezaServico: TDBEditFocus
              Tag = 99
              Left = 281
              Top = 479
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_NATSER'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeValSuf: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 63
              Width = 125
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_VALSUF'
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
        end
        object TabOrgPublico: TTabSheet
          Caption = 'Org'#227'o P'#250'blico'
          ImageIndex = 1
          object pnlOrgaoPublico: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label31: TLabel
              Left = 93
              Top = 15
              Width = 73
              Height = 14
              Alignment = taRightJustify
              Caption = #211'rg'#227'o P'#250'blico?'
            end
            object ColorLabel3: TColorLabel
              Left = 212
              Top = 15
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
            object Label140: TLabel
              Left = 79
              Top = 38
              Width = 87
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tipo de Desconto:'
            end
            object ColorLabel12: TColorLabel
              Left = 212
              Top = 38
              Width = 138
              Height = 14
              Caption = '(R)ateio (D)esconto Especial'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object Label143: TLabel
              Left = 51
              Top = 61
              Width = 115
              Height = 14
              Alignment = taRightJustify
              Caption = 'Calcula Desconto Icms?'
            end
            object ColorLabel15: TColorLabel
              Left = 212
              Top = 61
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
            object Label236: TLabel
              Left = 5
              Top = 84
              Width = 161
              Height = 14
              Alignment = taRightJustify
              Caption = 'Aplicar desconto de PIS/COFINS?'
            end
            object ColorLabel31: TColorLabel
              Left = 212
              Top = 84
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
            object Label68: TLabel
              Left = 17
              Top = 108
              Width = 149
              Height = 14
              Alignment = taRightJustify
              Caption = 'Gera Difal para '#211'rg'#227'o P'#250'blico?'
            end
            object ColorLabel17: TColorLabel
              Left = 212
              Top = 108
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
            object Label72: TLabel
              Left = 52
              Top = 132
              Width = 114
              Height = 14
              Alignment = taRightJustify
              Caption = 'Motivo da Desonera'#231#227'o'
            end
            object ColorLabel23: TColorLabel
              Left = 212
              Top = 132
              Width = 183
              Height = 14
              Caption = '(8)-Venda Org'#227'o Publico - (9)-Outros.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object lblOrgFde: TLabel
              Left = 22
              Top = 156
              Width = 144
              Height = 14
              Alignment = taRightJustify
              Caption = 'Org'#227'o P'#250'blico fora do Estado:'
            end
            object clrOrgFde: TColorLabel
              Left = 212
              Top = 156
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
            object lblEntGov: TLabel
              Left = 43
              Top = 180
              Width = 123
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tipo Ente Governamental:'
            end
            object clrEntGov: TColorLabel
              Left = 212
              Top = 180
              Width = 238
              Height = 14
              Caption = '(U)ni'#227'o - (E)stado - (D)istrito Federal - (M)unicipio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object dbeOrgPub: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 11
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ORGPUB'
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
              TipoTexto = ttAlfabetico
            end
            object dbeOrPuRD: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 34
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ORPURD'
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
              TipoTexto = ttAlfabetico
            end
            object dbeCalIcm: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 57
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CALICM'
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
              TipoTexto = ttAlfabetico
            end
            object dbeDesPis: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 80
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DESPIS'
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
              TipoTexto = ttAlfabetico
            end
            object gbAlqRet: TGroupBox
              Left = 355
              Top = 5
              Width = 388
              Height = 68
              Caption = 'Al'#237'quotas de Reten'#231#227'o'
              TabOrder = 9
              object Label237: TLabel
                Left = 16
                Top = 21
                Width = 68
                Height = 14
                Caption = 'Al'#237'quota CSLL'
              end
              object Label238: TLabel
                Left = 11
                Top = 44
                Width = 73
                Height = 14
                Caption = 'Al'#237'quota Cofins'
              end
              object Label239: TLabel
                Left = 163
                Top = 21
                Width = 56
                Height = 14
                Caption = 'Al'#237'quota Pis'
              end
              object Label240: TLabel
                Left = 157
                Top = 44
                Width = 62
                Height = 14
                Caption = 'Al'#237'quota IRPJ'
              end
              object Label241: TLabel
                Left = 142
                Top = 20
                Width = 10
                Height = 14
                Caption = '%'
              end
              object Label242: TLabel
                Left = 142
                Top = 44
                Width = 10
                Height = 14
                Caption = '%'
              end
              object Label243: TLabel
                Left = 275
                Top = 21
                Width = 10
                Height = 14
                Caption = '%'
              end
              object Label244: TLabel
                Left = 275
                Top = 44
                Width = 10
                Height = 14
                Caption = '%'
              end
              object sbAlqRet: TSpeedButton
                Left = 285
                Top = 17
                Width = 97
                Height = 43
                Cursor = crHandPoint
                Caption = 'Mais Informa'#231#245'es'
                Flat = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000020000
                  000A000000160000001B000000170000000B0000000200000000000000010000
                  00060000000B0000000F0000000C0000000600000001000000000000000F2616
                  1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
                  1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
                  70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
                  72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
                  D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
                  D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
                  F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
                  F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
                  E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
                  E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
                  A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
                  CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
                  5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
                  CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
                  3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
                  D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
                  1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
                  E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
                  0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
                  C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
                  0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
                  58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
                  0000000000010000000400000006000000050000000200000000000000000000
                  0001000000010000000100000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                Layout = blGlyphTop
                OnClick = sbAlqRetClick
              end
              object dbeAlqCsl: TDBEditFocus
                Tag = 99
                Left = 90
                Top = 17
                Width = 43
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_ALQCSL'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 6
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeAlqCof: TDBEditFocus
                Tag = 99
                Left = 90
                Top = 41
                Width = 49
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_ALQCOF'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeAlqPis: TDBEditFocus
                Tag = 99
                Left = 223
                Top = 16
                Width = 49
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_ALQPIS'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeAlqIrf: TDBEditFocus
                Tag = 99
                Left = 223
                Top = 41
                Width = 43
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_ALQIRF'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 6
                ParentFont = False
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
            object dbeOrgPubDifal: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 104
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ORPUDF'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeMotDes: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 128
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_MOTDES'
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeOrgFde: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 152
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ORGFDE'
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
              TipoTexto = ttAlfabetico
            end
            object rdgTpOpEg: TDBRadioGroup
              Left = 5
              Top = 202
              Width = 316
              Height = 107
              Caption = 'Tipo Opera'#231#227'o com Ente Governamental:'
              DataField = 'CLI_TPOPEG'
              DataSource = dtsTabela
              Enabled = False
              Items.Strings = (
                'N'#227'o aplic'#225'vel'
                'Fornecimento com pagamento posterior'
                'Recebimento do pagamento com fornecimento j'#225' realizado'
                'Fornecimento com pagamento j'#225' realizado'
                'Recebimento do pagamento com fornecimento posterior'
                'Fornecimento e recebimento do pagamento concomitantes')
              TabOrder = 8
              TabStop = True
              Values.Strings = (
                '0'
                '1'
                '2'
                '3'
                '4'
                '5')
            end
            object dbeEntGov: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 176
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ENTGOV'
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
              TipoTexto = ttAlfabetico
            end
          end
        end
        object TabConstrutora: TTabSheet
          Caption = 'Regras Fiscais x Endere'#231'o'
          ImageIndex = 2
          object pnlRegrasFiscais: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label262: TLabel
              Left = 4
              Top = 19
              Width = 300
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Calcular as regras fiscais ( CFOP e impostos ) considerando:'
            end
            object ColorLabel32: TColorLabel
              Left = 352
              Top = 19
              Width = 392
              Height = 14
              Caption = 
                '(1) Endere'#231'o principal do cliente   (2) Endere'#231'o de entrega dete' +
                'rminado na venda'
              CorDestaque = clRed
            end
            object dbeRegFis: TDBEditFocus
              Tag = 99
              Left = 310
              Top = 16
              Width = 34
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_REGFIS'
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
              TipoTexto = ttNumerico
            end
          end
        end
        object TabIcms: TTabSheet
          Caption = 'ICMS'
          ImageIndex = 3
          object pnlICMS: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label197: TLabel
              Left = 125
              Top = 25
              Width = 136
              Height = 14
              Alignment = taRightJustify
              Caption = 'Utilizar diferimento de ICMS?'
            end
            object ColorLabel24: TColorLabel
              Left = 312
              Top = 25
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
            object Label206: TLabel
              Left = 8
              Top = 48
              Width = 253
              Height = 14
              Alignment = taRightJustify
              Caption = 'Redu'#231#227'o de Base de ICMS para produtos tributados:'
              WordWrap = True
            end
            object ColorLabel26: TColorLabel
              Left = 311
              Top = 48
              Width = 10
              Height = 14
              Caption = '%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object dbeDiferi: TDBEditFocus
              Tag = 99
              Left = 266
              Top = 22
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DIFERI'
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
              TipoTexto = ttAlfabetico
            end
            object dbeRedIcm: TDBEditFocus
              Tag = 99
              Left = 266
              Top = 45
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_REDICM'
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
              TipoTexto = ttNumerico
            end
          end
        end
        object TabSt: TTabSheet
          Caption = 'ST'
          ImageIndex = 4
          object pnlST: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object lblRecali: TLabel
              Left = 193
              Top = 113
              Width = 164
              Height = 14
              Alignment = taRightJustify
              Caption = 'Utilizar redu'#231#227'o de carga L'#237'quida?'
              WordWrap = True
            end
            object lbl26: TLabel
              Left = 102
              Top = 45
              Width = 255
              Height = 14
              Alignment = taRightJustify
              Caption = 'Sujeito passivo por ST atribuida por regime especial?'
            end
            object lbl27: TColorLabel
              Left = 409
              Top = 45
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
            object lblDif_ST: TLabel
              Left = 232
              Top = 21
              Width = 125
              Height = 14
              Alignment = taRightJustify
              Caption = 'Utilizar diferimento de ST?'
            end
            object clbDif_ST: TColorLabel
              Left = 409
              Top = 21
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
            object lblSibIcm: TLabel
              Left = 104
              Top = 90
              Width = 253
              Height = 14
              Alignment = taRightJustify
              Caption = 'Quando IVA Especial MT, somar ipi na base de icms?'
              WordWrap = True
            end
            object cllRecali: TColorLabel
              Left = 409
              Top = 113
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
            object lbl28: TLabel
              Left = 5
              Top = 67
              Width = 352
              Height = 14
              Alignment = taRightJustify
              Caption = 
                'C'#243'digo do processo Sujeito passivo por ST atribuida por regime e' +
                'special:'
            end
            object ColorLabel25: TColorLabel
              Left = 409
              Top = 90
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
            object dbeStReEs: TDBEditFocus
              Tag = 99
              Left = 363
              Top = 41
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_STREES'
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
              TipoTexto = ttAlfabetico
            end
            object dbePrStRe: TDBEditFocus
              Tag = 99
              Left = 363
              Top = 64
              Width = 209
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_PRSTRE'
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
              TipoTexto = ttAlfanumerico
            end
            object dbeDif_ST: TDBEditFocus
              Tag = 99
              Left = 363
              Top = 18
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DIF_ST'
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
              TipoTexto = ttAlfabetico
            end
            object GroupBox7: TGroupBox
              Left = 8
              Top = 248
              Width = 1000
              Height = 57
              Caption = 'Para itens sem NCM no CEDEM para "MT/CE"'
              TabOrder = 3
              object Label223: TLabel
                Left = 13
                Top = 21
                Width = 172
                Height = 28
                Alignment = taRightJustify
                Caption = 'IVA Especial com carga m'#233'dia para "MT/CE" (Produtos Importados):'
                WordWrap = True
              end
              object lblIvaEspInfo: TLabel
                Left = 755
                Top = 21
                Width = 238
                Height = 28
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                Alignment = taCenter
                Caption = 
                  '  IVA = ( Aliq.Icms Interestadual + Aliq.Icms Carga Media ) / Al' +
                  'iq.Icms Opera'#231#227'o Interna  '
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                Transparent = True
                Visible = False
                WordWrap = True
              end
              object Label195: TLabel
                Left = 277
                Top = 21
                Width = 169
                Height = 28
                Alignment = taRightJustify
                Caption = 'IVA Especial com carga m'#233'dia para "MT/CE" (Produtos Nacionais):'
                WordWrap = True
              end
              object Label261: TLabel
                Left = 529
                Top = 21
                Width = 141
                Height = 28
                Alignment = taRightJustify
                Caption = 'Percentual carga m'#233'dia para "MT/CE" (CNAE Simplificado):'
                WordWrap = True
              end
              object dbeIvaEsp: TDBEditFocus
                Tag = 99
                Left = 192
                Top = 27
                Width = 74
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_IVAESP'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeIvaNac: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 27
                Width = 74
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_IVANAC'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeIvaSim: TDBEditFocus
                Tag = 99
                Left = 674
                Top = 27
                Width = 74
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_IVASIM'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
            object dbeRecali: TDBEditFocus
              Tag = 99
              Left = 363
              Top = 110
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_RECALI'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeSibIcm: TDBEditFocus
              Tag = 99
              Left = 363
              Top = 87
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_SIBICM'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object grbCEDEM: TGroupBox
              Left = 8
              Top = 177
              Width = 1000
              Height = 57
              Caption = 'Para itens com NCM no CEDEM para "MT/CE"'
              TabOrder = 6
              object Label256: TLabel
                Left = 14
                Top = 20
                Width = 172
                Height = 28
                Alignment = taRightJustify
                Caption = 'IVA Especial com carga m'#233'dia para "MT/CE" (Produtos Importados):'
                WordWrap = True
              end
              object Label69: TLabel
                Left = 278
                Top = 20
                Width = 169
                Height = 28
                Alignment = taRightJustify
                Caption = 'IVA Especial com carga m'#233'dia para "MT/CE" (Produtos Nacionais):'
                WordWrap = True
              end
              object Label70: TLabel
                Left = 530
                Top = 20
                Width = 141
                Height = 28
                Alignment = taRightJustify
                Caption = 'Percentual carga m'#233'dia para "MT/CE" (CNAE Simplificado):'
                WordWrap = True
              end
              object dbeIvaEspCEDEM: TDBEditFocus
                Tag = 99
                Left = 191
                Top = 23
                Width = 76
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_CEDESP'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeIvaNacCEDEM: TDBEditFocus
                Tag = 99
                Left = 450
                Top = 23
                Width = 74
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_CEDNAC'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeIvaSimCEDEM: TDBEditFocus
                Tag = 99
                Left = 675
                Top = 23
                Width = 74
                Height = 22
                Hint = 
                  'IVA = ( ALIQ.ICMS INTERESTADUAL + ALIQ.ICMS CARGA MEDIA ) / ALIQ' +
                  '.ICMS OPERACAO INTERNA'
                CharCase = ecUpperCase
                DataField = 'CLI_CEDSIM'
                DataSource = dtsTabela
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                OnEnter = dbeIvaEspEnter
                OnExit = dbeIvaEspExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
          end
        end
        object TabIpi: TTabSheet
          Caption = 'IPI'
          ImageIndex = 5
          object pnlIPI: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label59: TLabel
              Left = 10
              Top = 70
              Width = 91
              Height = 14
              Alignment = taRightJustify
              Caption = 'Enquadramento IPI:'
            end
            object Label196: TLabel
              Left = 43
              Top = 47
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o IPI:'
            end
            object Label194: TLabel
              Left = 29
              Top = 24
              Width = 72
              Height = 14
              Alignment = taRightJustify
              Caption = 'Isen'#231#227'o de IPI?'
            end
            object ColorLabel20: TColorLabel
              Left = 151
              Top = 24
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
            object Label266: TLabel
              Left = 33
              Top = 91
              Width = 68
              Height = 14
              Alignment = taRightJustify
              Caption = 'Mensagem IPI:'
            end
            object lblMsgRetImposto: TLabel
              Left = 664
              Top = 11
              Width = 341
              Height = 42
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Caption = 
                'Empresa configurada como Simples Nacional. Os campos de reten'#231#227'o' +
                ' do cliente ficar'#227'o bloqueados e n'#227'o ser'#225' realizada nenhuma rete' +
                'n'#231#227'o destes impostos no faturamento.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
              Visible = False
              WordWrap = True
            end
            object dbeEnqIPI: TDBEditFocus
              Tag = 99
              Left = 107
              Top = 66
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ENQIPI'
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
              OnKeyPress = dbeEnqIPIKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
            end
            object cbxTributacaoIPI: TDBComboBoxFocus
              Tag = 99
              Left = 107
              Top = 43
              Width = 115
              Height = 22
              Style = csDropDownList
              DataField = 'CLI_SITIPI'
              DataSource = dtsTabela
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpFixed
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnChange = cbxTributacaoIPIChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeIseIpi: TDBEditFocus
              Tag = 99
              Left = 107
              Top = 20
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ISEIPI'
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
              TipoTexto = ttAlfabetico
            end
            object dbeMensagemIPI: TDBMemoFocus
              Left = 107
              Top = 90
              Width = 894
              Height = 130
              BiDiMode = bdLeftToRight
              DataField = 'CLI_MENIPI'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 255
              ParentBiDiMode = False
              ScrollBars = ssVertical
              TabOrder = 3
              OnKeyPress = dbeObservKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object dbeDescEnqIPI: TEditFocus
              Left = 148
              Top = 66
              Width = 853
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
          end
        end
        object TabPisCofins: TTabSheet
          Caption = 'PIS/COFINS'
          ImageIndex = 6
          object pnlPISCOFINS: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label141: TLabel
              Left = 124
              Top = 23
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ret'#233'm Pis e Cofins?'
            end
            object ColorLabel13: TColorLabel
              Left = 270
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
            object lbl17: TLabel
              Left = 68
              Top = 46
              Width = 152
              Height = 14
              Alignment = taRightJustify
              Caption = 'Utilizar diferimento PIS/COFINS?'
            end
            object Label193: TLabel
              Left = 6
              Top = 70
              Width = 214
              Height = 14
              Alignment = taRightJustify
              Caption = 'Calcula desconto de PIS/COFINS/IRPJ/CSLL?'
            end
            object ColorLabel19: TColorLabel
              Left = 270
              Top = 70
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
            object ColorLabel29: TColorLabel
              Left = 270
              Top = 46
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
            object Label267: TLabel
              Left = 117
              Top = 95
              Width = 103
              Height = 14
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o PIS/COFINS:'
            end
            object Label268: TLabel
              Left = 107
              Top = 142
              Width = 113
              Height = 14
              Alignment = taRightJustify
              Caption = 'Mensagem PIS/COFINS:'
            end
            object lblMsgRetImposto1: TLabel
              Left = 672
              Top = 19
              Width = 341
              Height = 42
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Caption = 
                'Empresa configurada como Simples Nacional. Os campos de reten'#231#227'o' +
                ' do cliente ficar'#227'o bloqueados e n'#227'o ser'#225' realizada nenhuma rete' +
                'n'#231#227'o destes impostos no faturamento.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
              Visible = False
              WordWrap = True
            end
            object lblTributacaoPisCofinsVendaPresencial: TLabel
              Left = 30
              Top = 120
              Width = 190
              Height = 14
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o PIS/COFINS Venda Presencial:'
            end
            object dbeRetPCo: TDBEditFocus
              Tag = 99
              Left = 226
              Top = 19
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_RETPCO'
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
              TipoTexto = ttAlfabetico
            end
            object dbeDif_PC: TDBEditFocus
              Tag = 99
              Left = 226
              Top = 42
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_DIF_PC'
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
              TipoTexto = ttAlfabetico
            end
            object dbeCDesPI: TDBEditFocus
              Tag = 99
              Left = 226
              Top = 67
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_CDESPI'
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
              TipoTexto = ttAlfabetico
            end
            object cbxTributacaoPisCofins: TDBComboBoxFocus
              Tag = 99
              Left = 226
              Top = 92
              Width = 167
              Height = 22
              Style = csDropDownList
              DataField = 'CLI_SITP_C'
              DataSource = dtsTabela
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpFixed
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnChange = cbxTributacaoPisCofinsChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeMensagemPisCofins: TDBMemoFocus
              Left = 226
              Top = 143
              Width = 769
              Height = 87
              BiDiMode = bdLeftToRight
              DataField = 'CLI_MENP_C'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 255
              ParentBiDiMode = False
              ScrollBars = ssVertical
              TabOrder = 5
              OnKeyPress = dbeObservKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object cbxTributacaoPisCofinsVendaPresencial: TDBComboBoxFocus
              Tag = 99
              Left = 226
              Top = 117
              Width = 167
              Height = 22
              Style = csDropDownList
              DataField = 'CLI_SITPCP'
              DataSource = dtsTabela
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpFixed
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
        end
        object TabIrpj: TTabSheet
          Caption = 'IRPJ'
          ImageIndex = 7
          object pnlIRPJ: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object ColorLabel14: TColorLabel
              Left = 114
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
            object Label144: TLabel
              Left = 8
              Top = 23
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ret'#233'm IRPJ:'
            end
            object lblMsgRetImposto2: TLabel
              Left = 656
              Top = 3
              Width = 341
              Height = 42
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Caption = 
                'Empresa configurada como Simples Nacional. Os campos de reten'#231#227'o' +
                ' do cliente ficar'#227'o bloqueados e n'#227'o ser'#225' realizada nenhuma rete' +
                'n'#231#227'o destes impostos no faturamento.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
              Visible = False
              WordWrap = True
            end
            object dbeRetIrf: TDBEditFocus
              Tag = 99
              Left = 70
              Top = 19
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_RETIRF'
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
              TipoTexto = ttAlfabetico
            end
          end
        end
        object TabIss: TTabSheet
          Caption = 'ISS'
          ImageIndex = 8
          object pnlISS: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object lblCobIss: TColorLabel
              Left = 16
              Top = 146
              Width = 328
              Height = 14
              Caption = 
                '* Utilizado na venda quando n'#227'o informado no endere'#231'o de entrega' +
                '.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
              CorDestaque = clRed
            end
            object clbRedISS: TLabel
              Left = 209
              Top = 46
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object lblRedISS: TLabel
              Left = 12
              Top = 46
              Width = 146
              Height = 14
              Alignment = taRightJustify
              Caption = 'Redu'#231#227'o Base C'#225'lculo do ISS:'
            end
            object Label61: TLabel
              Left = 82
              Top = 23
              Width = 76
              Height = 14
              Alignment = taRightJustify
              Caption = 'Al'#237'quota de ISS:'
            end
            object Label145: TLabel
              Left = 103
              Top = 69
              Width = 55
              Height = 14
              Alignment = taRightJustify
              Caption = 'Retem ISS?'
            end
            object Label139: TLabel
              Left = 217
              Top = 31
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object ColorLabel16: TColorLabel
              Left = 211
              Top = 69
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
            object dbeAlqIss: TDBEditFocus
              Tag = 99
              Left = 165
              Top = 19
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ALQISS'
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
              TipoTexto = ttNumerico
            end
            object dbeRedISS: TDBEditFocus
              Tag = 99
              Left = 165
              Top = 42
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_REDISS'
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
              TipoTexto = ttNumerico
            end
            object rdgCobIss: TDBRadioGroup
              Tag = 99
              Left = 16
              Top = 93
              Width = 318
              Height = 47
              Caption = 'ISS Cobrado'
              DataField = 'CLI_COBISS'
              DataSource = dtsTabela
              Items.Strings = (
                'ISS Cobrado sobre Total da Nota Fiscal'
                'ISS Cobrado sobre Valor dos Servi'#231'os')
              TabOrder = 2
              TabStop = True
              Values.Strings = (
                'T'
                'S')
            end
            object dbeRetIss: TDBEditFocus
              Tag = 99
              Left = 165
              Top = 65
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_RETISS'
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
              TipoTexto = ttAlfabetico
            end
          end
        end
        object TabBeneficios: TTabSheet
          Caption = 'Benef'#237'cios'
          ImageIndex = 9
          object pnlBeneficios: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object Label253: TLabel
              Left = 88
              Top = 21
              Width = 81
              Height = 14
              Alignment = taRightJustify
              Caption = 'Benef'#237'cio REIDI ?'
            end
            object ColorLabel22: TColorLabel
              Left = 219
              Top = 21
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
            object Label66: TLabel
              Left = 6
              Top = 44
              Width = 163
              Height = 14
              Alignment = taRightJustify
              Caption = 'Deduzir ICMS do Benef'#237'cio REIDI ?'
            end
            object ColorLabel5: TColorLabel
              Left = 219
              Top = 44
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
            object lblRECAP_: TLabel
              Left = 23
              Top = 239
              Width = 119
              Height = 14
              Alignment = taRightJustify
              Caption = 'Benef'#237'cio Fiscal RECAP?'
            end
            object lblRECAP__S_N: TColorLabel
              Left = 194
              Top = 239
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
            object lblNotDes: TLabel
              Left = 24
              Top = 197
              Width = 627
              Height = 14
              Alignment = taRightJustify
              Caption = 
                'Cliente enquadrado no art. 7'#186' do Anexo XVIII da Parte II da Reso' +
                'lu'#231#227'o SEFAZ n'#186' 720/14, inclu'#237'do pela Resolu'#231#227'o SEFAZ n'#186' 13/19 ?'
            end
            object clbNotDes: TColorLabel
              Left = 701
              Top = 196
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
            object lblNatRec: TLabel
              Left = 297
              Top = 21
              Width = 159
              Height = 14
              Alignment = taRightJustify
              Caption = 'Natureza de Receita PIS/COFINS:'
            end
            object dbeBenRei: TDBEditFocus
              Tag = 99
              Left = 175
              Top = 17
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_BENREI'
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
              TipoTexto = ttAlfabetico
            end
            object dbeIcmRei: TDBEditFocus
              Tag = 99
              Left = 175
              Top = 40
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_ICMREI'
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
              TipoTexto = ttAlfabetico
            end
            object GroupBox8: TGroupBox
              Left = 5
              Top = 68
              Width = 269
              Height = 117
              Caption = 'Liminar'
              TabOrder = 3
              object Label235: TLabel
                Left = 9
                Top = 22
                Width = 77
                Height = 14
                Alignment = taRightJustify
                Caption = 'N'#250'mero Liminar:'
              end
              object dbeDefit_: TDBEditFocus
                Tag = 99
                Left = 92
                Top = 19
                Width = 125
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_DEFIT_'
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
              object rdgTipLim: TDBRadioGroup
                Left = 92
                Top = 47
                Width = 69
                Height = 66
                Caption = 'Tipo Liminar'
                DataField = 'CLI_TIPLIM'
                DataSource = dtsTabela
                Items.Strings = (
                  'DEFIT'
                  'COFIT')
                TabOrder = 1
                Values.Strings = (
                  'D'
                  'C')
              end
            end
            object pnlAtoDeclaratorioDF: TPanel
              Left = 24
              Top = 213
              Width = 379
              Height = 25
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 4
              object lblAtoDDF: TLabel
                Left = 0
                Top = 4
                Width = 265
                Height = 14
                Caption = 'Decreto 34063/12 para o estado DF - Ato Declarat'#243'rio?'
              end
              object clbAtoDDF: TColorLabel
                Left = 316
                Top = 3
                Width = 55
                Height = 14
                Caption = '(S)im (N)'#227'o'
                CorDestaque = clRed
              end
              object dbeAtoDDF: TDBEditFocus
                Tag = 99
                Left = 271
                Top = 0
                Width = 39
                Height = 22
                CharCase = ecUpperCase
                DataField = 'CLI_ATODDF'
                DataSource = dtsTabela
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfabetico
              end
            end
            object dbeRECAP_: TDBEditFocus
              Tag = 99
              Left = 148
              Top = 236
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_RECAP_'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 5
              OnChange = dbeRECAP_Change
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object btnRECAP: TBitBtnLocked
              Left = 255
              Top = 236
              Width = 226
              Height = 22
              Caption = 'RECAP - Definir Classifica'#231#227'o de IPI / NCM'
              Enabled = False
              TabOrder = 6
              OnClick = btnRECAPClick
            end
            object dbeNotDes: TDBEditFocus
              Tag = 99
              Left = 657
              Top = 193
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_NOTDES'
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
              TipoTexto = ttAlfabetico
            end
            object dbeNatRec: TDBEditFocus
              Tag = 99
              Left = 462
              Top = 17
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_NATREC'
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
              ReadOnly = True
              TabOrder = 1
              OnEnter = dbeNatRecEnter
              OnKeyPress = dbeNatRecKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
        end
        object TabRegimeEspecial: TTabSheet
          Caption = 'Regime Especial'
          ImageIndex = 10
          object pnlregimeEspecial: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 556
            Align = alClient
            ParentColor = True
            TabOrder = 0
            object lblRegDes: TLabel
              Left = 15
              Top = 16
              Width = 432
              Height = 42
              Alignment = taRightJustify
              Caption = 
                'Permitir desmembrar pedido com itens que s'#227'o do Regime Especial ' +
                'com itens que n'#227'o s'#227'o (neste caso, ser'#227'o emitidos dois pedidos) ' +
                'e cada um ter'#225' a emiss'#227'o da nota conforme as empresas definidas ' +
                'nas configura'#231#245'es CFG_EMPRES e CFG_EMPREN?'
              WordWrap = True
            end
            object clbRegDes: TColorLabel
              Left = 502
              Top = 30
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
            object dbeRegDes: TDBEditFocus
              Tag = 99
              Left = 456
              Top = 27
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_REGDES'
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
              TipoTexto = ttAlfabetico
            end
          end
        end
        object TabBenCst: TTabSheet
          Caption = 'Benef'#237'cio Fiscal (cBenef)'
          ImageIndex = 12
          object pnlBeneficioFiscal: TPanel
            Left = 0
            Top = 0
            Width = 1029
            Height = 95
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object clbBenCst: TColorLabel
              Left = 187
              Top = 11
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
            object lblBenCst: TLabel
              Left = 9
              Top = 10
              Width = 128
              Height = 14
              Alignment = taRightJustify
              Caption = 'Benef'#237'cio Fiscal (cBenef)?'
            end
            object Label77: TLabel
              Left = 46
              Top = 38
              Width = 93
              Height = 14
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o Tribut'#225'ria:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label78: TLabel
              Left = 40
              Top = 66
              Width = 99
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo do Benef'#237'cio:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeBenCst: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 7
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CLI_BENCST'
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
              TipoTexto = ttAlfabetico
            end
            object edtBenCodCst: TEditFocus
              Tag = 99
              Left = 143
              Top = 35
              Width = 100
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtBenCodBen: TEditFocus
              Tag = 99
              Left = 143
              Top = 63
              Width = 100
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object BtnAdicionaBeneficio: TBitBtnLocked
              Left = 257
              Top = 63
              Width = 99
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
              TabOrder = 3
              OnClick = BtnAdicionaBeneficioClick
            end
            object BtnCancelaBeneficio: TBitBtnLocked
              Left = 362
              Top = 63
              Width = 99
              Height = 22
              Caption = 'Ca&ncelar'
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
              OnClick = BtnCancelaBeneficioClick
            end
          end
          object DBGridCliBen: TDBGridCitel
            Left = 0
            Top = 95
            Width = 1029
            Height = 461
            Align = alClient
            DataSource = dtsCliBen
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = DBGridCliBenKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'BEN_CODCST'
                Title.Caption = 'Situa'#231#227'o Tribut'#225'ria'
                Width = 100
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'BEN_CODBEN'
                Title.Caption = 'C'#243'digo do Benef'#237'cio'
                Width = 150
                Visible = True
              end>
          end
        end
      end
    end
    object tbsQuadSoc: TTabSheet
      Caption = '8 - Quadro Societ'#225'rio'
      Enabled = False
      ImageIndex = 3
      object pnlTopoQuadSco: TPanel
        Left = 0
        Top = 45
        Width = 1037
        Height = 104
        Align = alTop
        TabOrder = 1
        object lblNomSocio: TLabel
          Left = 26
          Top = 10
          Width = 75
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome do S'#243'cio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object LabelRg1: TLabelRg
          Left = 469
          Top = 35
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'R.G.:'
          Pais = opcBrasil
        end
        object lblDataNascimentoSocio: TLabel
          Left = 17
          Top = 58
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Nascimento:'
        end
        object lblParticipacaoSocio: TLabel
          Left = 188
          Top = 58
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Participa'#231#227'o (%):'
        end
        object lblCNPJ_CPF_Socio: TLabel
          Left = 13
          Top = 35
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel4: TColorLabel
          Left = 148
          Top = 80
          Width = 207
          Height = 14
          Caption = '(C)asado (S)olteiro (O)utros (M)aritalmente'
          CorDestaque = clRed
        end
        object lblEstadoCivil: TLabel
          Left = 43
          Top = 80
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado Civil:'
        end
        object edtNomSco: TEditFocus
          Tag = 99
          Left = 105
          Top = 7
          Width = 554
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRGSco: TEditFocus
          Tag = 99
          Left = 498
          Top = 30
          Width = 161
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDataNascimento: TMaskEditFocus
          Tag = 99
          Left = 105
          Top = 53
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 4
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtParticipacaoSco: TEditFocus
          Tag = 99
          Left = 276
          Top = 53
          Width = 79
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 5
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtCnpjCpfSco: TMaskEditFocus
          Tag = 99
          Left = 141
          Top = 30
          Width = 323
          Height = 22
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtOpcCnpjCpfSco: TEditFocus
          Tag = 99
          Left = 105
          Top = 30
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 1
          OnExit = edtOpcCnpjCpfScoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnConfirmaQuadSoc: TBitBtnLocked
          Left = 462
          Top = 67
          Width = 99
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
          TabOrder = 7
          OnClick = btnConfirmaQuadSocClick
        end
        object btnCancelarQuadSoc: TBitBtnLocked
          Left = 560
          Top = 67
          Width = 99
          Height = 22
          Caption = 'Ca&ncelar'
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
          TabOrder = 8
          OnClick = btnCancelarQuadSocClick
        end
        object edtEstadoCivil: TEditFocus
          Tag = 99
          Left = 105
          Top = 76
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 6
          OnExit = edtOpcCnpjCpfScoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object dbgQuadSoc: TDBGridCitel
        Left = 0
        Top = 149
        Width = 1037
        Height = 477
        Align = alClient
        DataSource = dtsCadSco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgQuadSocKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'SCO_NOMSCO'
            Width = 460
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'SCO_DTANAS'
            Title.Alignment = taCenter
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SCO_PER_PS'
            Title.Alignment = taRightJustify
            Width = 108
            Visible = True
          end>
      end
      object pnlTopoQuadScoCapSoc: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 45
        Align = alTop
        TabOrder = 0
        object Label191: TLabel
          Left = 34
          Top = 15
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Capital Social:'
        end
        object dbeCapSoc: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 11
          Width = 125
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CAPSOC'
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
      end
    end
    object tbsRefBan: TTabSheet
      Caption = '9 - Ref. Banc'#225'rias'
      ImageIndex = 4
      object Label85: TLabel
        Left = 14
        Top = 14
        Width = 137
        Height = 14
        Caption = 'REFER'#202'NCIAS BANC'#193'RIAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label86: TLabel
        Left = 14
        Top = 35
        Width = 17
        Height = 14
        Caption = '1'#186' )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label87: TLabel
        Left = 23
        Top = 60
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label88: TLabel
        Left = 14
        Top = 82
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label89: TLabel
        Left = 13
        Top = 148
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label90: TLabel
        Left = 17
        Top = 115
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Contato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label91: TLabel
        Left = 14
        Top = 171
        Width = 17
        Height = 14
        Caption = '2'#186' )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label92: TLabel
        Left = 23
        Top = 196
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label93: TLabel
        Left = 14
        Top = 218
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label94: TLabel
        Left = 13
        Top = 284
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label95: TLabel
        Left = 17
        Top = 251
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Contato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label96: TLabel
        Left = 14
        Top = 308
        Width = 17
        Height = 14
        Caption = '3'#186' )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label97: TLabel
        Left = 23
        Top = 333
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label98: TLabel
        Left = 14
        Top = 355
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label99: TLabel
        Left = 13
        Top = 422
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label100: TLabel
        Left = 17
        Top = 388
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Contato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label185: TLabel
        Left = 317
        Top = 82
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#186' Conta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label187: TLabel
        Left = 317
        Top = 218
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#186' Conta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label188: TLabel
        Left = 317
        Top = 355
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#186' Conta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object dbeNomBc1: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 56
        Width = 428
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NOMBC1'
        DataSource = dtsCadFic
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
      object dbeAgeBc1: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 78
        Width = 246
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_AGEBC1'
        DataSource = dtsCadFic
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
      object dbeTelBc1: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 144
        Width = 120
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_TELBC1'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNomBc2: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 192
        Width = 428
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NOMBC2'
        DataSource = dtsCadFic
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
      object dbeAgeBc2: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 214
        Width = 246
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_AGEBC2'
        DataSource = dtsCadFic
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
      object dbeTelBc2: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 280
        Width = 120
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_TELBC2'
        DataSource = dtsCadFic
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
      object dbeNomBc3: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 329
        Width = 428
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NOMBC3'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAgeBc3: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 351
        Width = 246
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_AGEBC3'
        DataSource = dtsCadFic
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
      object dbeTelBc3: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 418
        Width = 120
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_TELBC3'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFicNCom01: TDBEditFocus
        Tag = 99
        Left = 365
        Top = 78
        Width = 124
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NCON01'
        DataSource = dtsCadFic
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
      object dbeFicNCom02: TDBEditFocus
        Tag = 99
        Left = 365
        Top = 214
        Width = 124
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NCON02'
        DataSource = dtsCadFic
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
      object dbeFicNCom03: TDBEditFocus
        Tag = 99
        Left = 365
        Top = 351
        Width = 124
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIC_NCON03'
        DataSource = dtsCadFic
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
      object dbeConBc1: TDBMemoFocus
        Tag = 99
        Left = 61
        Top = 100
        Width = 428
        Height = 44
        DataField = 'FIC_CONBC1'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 3
        OnKeyPress = dbeConBc1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object dbeConBc2: TDBMemoFocus
        Tag = 99
        Left = 61
        Top = 236
        Width = 428
        Height = 44
        DataField = 'FIC_CONBC2'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 8
        OnKeyPress = dbeConBc1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object dbeConBc3: TDBMemoFocus
        Tag = 99
        Left = 61
        Top = 373
        Width = 428
        Height = 44
        DataField = 'FIC_CONBC3'
        DataSource = dtsCadFic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 13
        OnKeyPress = dbeConBc1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsRefCom: TTabSheet
      Caption = '10 - Ref. Comerciais'
      ImageIndex = 5
      object pnlRefComerciais: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 240
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label103: TLabel
          Left = 51
          Top = 34
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label105: TLabel
          Left = 9
          Top = 56
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label104: TLabel
          Left = 618
          Top = 36
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label106: TLabel
          Left = 57
          Top = 126
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label182: TLabel
          Left = 63
          Top = 185
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail:'
        end
        object Label101: TLabel
          Left = 14
          Top = 6
          Width = 142
          Height = 14
          Caption = 'REFER'#202'NCIAS COMERCIAIS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label102: TLabel
          Left = 594
          Top = 14
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Consulta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label107: TLabel
          Left = 42
          Top = 78
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Informante:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label108: TLabel
          Left = 581
          Top = 57
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Primeira Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label109: TLabel
          Left = 568
          Top = 79
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Prim. Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label110: TLabel
          Left = 594
          Top = 102
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'Maior Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label111: TLabel
          Left = 566
          Top = 125
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Maior Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label112: TLabel
          Left = 592
          Top = 146
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ultima Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label113: TLabel
          Left = 564
          Top = 169
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Ultima Compra:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label115: TLabel
          Left = 47
          Top = 208
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object edtEmpRco: TEditFocus
          Tag = 99
          Left = 100
          Top = 30
          Width = 412
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 100
          Top = 51
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 1
          OnExit = edtCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mmConEmp: TMemoFocus
          Tag = 99
          Left = 100
          Top = 95
          Width = 412
          Height = 87
          ScrollBars = ssVertical
          TabOrder = 4
          OnKeyPress = mmConEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object edtEmaEmp: TEditFocus
          Tag = 99
          Left = 100
          Top = 182
          Width = 412
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCgcEmp: TMaskEditFocus
          Tag = 99
          Left = 136
          Top = 51
          Width = 376
          Height = 22
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDtaCon: TMaskEditFocus
          Tag = 99
          Left = 668
          Top = 7
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 7
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtNomInf: TEditFocus
          Tag = 99
          Left = 100
          Top = 73
          Width = 412
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPriCom: TMaskEditFocus
          Tag = 99
          Left = 668
          Top = 52
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 9
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtMaiCom: TMaskEditFocus
          Tag = 99
          Left = 668
          Top = 96
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 11
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtVMaCom: TEditFocus
          Tag = 99
          Left = 668
          Top = 118
          Width = 91
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 12
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
        object edtUltCom: TMaskEditFocus
          Tag = 99
          Left = 668
          Top = 140
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 13
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtVUlCom: TEditFocus
          Tag = 99
          Left = 668
          Top = 162
          Width = 91
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
        object edtCodOpe: TEditFocus
          Tag = 99
          Left = 100
          Top = 204
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 6
          OnEnter = edtCodOpeEnter
          OnExit = edtCodOpeExit
          OnKeyDown = edtCodOpeKeyDown
          OnKeyPress = edtCodOpeKeyPress
          OnKeyUp = edtCodOpeKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesCodOpe: TEditFocus
          Left = 150
          Top = 204
          Width = 362
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtVPrCom: TEditFocus
          Tag = 99
          Left = 668
          Top = 74
          Width = 91
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 10
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
        object btnAdicionarRco: TBitBtnLocked
          Left = 662
          Top = 187
          Width = 100
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
          OnClick = btnAdicionarRcoClick
        end
        object btnCancelaRco: TBitBtnLocked
          Left = 662
          Top = 209
          Width = 100
          Height = 22
          Caption = 'Ca&ncelar'
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
          OnClick = btnCancelaRcoClick
        end
        object edtTelEmp: TMaskEditTelefone
          Tag = 99
          Left = 668
          Top = 30
          Width = 91
          Height = 22
          CharCase = ecUpperCase
          EditMask = '!\(99\)9999-9999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 13
          TabOrder = 8
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
          Pais = opcBrasil
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 240
        Width = 1037
        Height = 18
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label114: TLabel
          Left = 4
          Top = 2
          Width = 261
          Height = 14
          AutoSize = False
          Caption = 'Lista de Contatos (ALT + N pr'#243'xima p'#225'gina):'
          Visible = False
        end
      end
      object dbgCliRco: TDBGridCitel
        Left = 0
        Top = 258
        Width = 1037
        Height = 368
        Align = alClient
        DataSource = dtsCliRco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnEnter = dbgCliRcoEnter
        OnKeyDown = dbgCliRcoKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'EMPRCO'
            Title.Caption = 'Empresa'
            Width = 211
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNPJ_CPF'
            Title.Caption = 'CNPJ/CPF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CGCCPF'
            Title.Caption = 'CNPJ/CPF'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CGCEMP'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'TELEMP'
            Title.Caption = 'Telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL_'
            Title.Caption = 'Email'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DTACON'
            Title.Caption = 'Data Consulta'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMINF'
            Title.Caption = 'Informante'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DTAPCO'
            Title.Caption = 'Data Primeira Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALPCO'
            Title.Caption = 'Valor Primeira Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DTAMCO'
            Title.Caption = 'Data Maior Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALMCO'
            Title.Caption = 'Valor Maior Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DTAUCO'
            Title.Caption = 'Data Ultima Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALUCO'
            Title.Caption = 'Valor Ultima Compra'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODOPE'
            Title.Caption = 'Operador'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODEMP'
            Title.Caption = 'Empresa'
            Visible = True
          end>
      end
    end
    object tbsCrediario: TTabSheet
      Caption = '11 - Informa'#231#245'es de Credi'#225'rio'
      ImageIndex = 6
      object Label117: TLabel
        Left = 48
        Top = 16
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome do Pai:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label118: TLabel
        Left = 42
        Top = 40
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome da M'#227'e:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label119: TLabel
        Left = 23
        Top = 65
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome do Conjuge:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label120: TLabel
        Left = 499
        Top = 65
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nascimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label121: TLabel
        Left = 61
        Top = 159
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label122: TLabel
        Left = 39
        Top = 180
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Emp. Trabalho:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label123: TLabel
        Left = 41
        Top = 201
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'End. Trabalho:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label124: TLabel
        Left = 473
        Top = 159
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cart. Profissional:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label125: TLabel
        Left = 468
        Top = 180
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data de Admiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label126: TLabel
        Left = 514
        Top = 201
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label127: TLabel
        Left = 74
        Top = 224
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sal'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label128: TLabel
        Left = 268
        Top = 224
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outras Rendas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label129: TLabel
        Left = 278
        Top = 275
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Aluguel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label130: TLabel
        Left = 533
        Top = 224
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label131: TLabel
        Left = 15
        Top = 390
        Width = 88
        Height = 14
        Caption = 'BENS MATERIAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label132: TLabel
        Left = 61
        Top = 409
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label133: TLabel
        Left = 445
        Top = 409
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label134: TLabel
        Left = 61
        Top = 430
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label135: TLabel
        Left = 445
        Top = 430
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label136: TLabel
        Left = 72
        Top = 451
        Width = 38
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ve'#237'culo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label137: TLabel
        Left = 445
        Top = 451
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label138: TLabel
        Left = 38
        Top = 472
        Width = 72
        Height = 56
        Alignment = taRightJustify
        Caption = 'Observa'#231#245'es:'#13#10'Pressione TAB'#13#10'para a pr'#243'xima'#13#10'p'#225'gina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label164: TLabel
        Left = 52
        Top = 87
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado Civil:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label173: TLabel
        Left = 69
        Top = 275
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Moradia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label63: TLabel
        Left = 530
        Top = 86
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sexo:'
      end
      object Label64: TLabel
        Left = 45
        Top = 139
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Escolaridade:'
      end
      object Label65: TLabel
        Left = 444
        Top = 275
        Width = 114
        Height = 14
        Alignment = taRightJustify
        Caption = 'Reside '#224' quantos anos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label147: TLabel
        Left = 68
        Top = 301
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Avalista:'
      end
      object Label149: TLabel
        Left = 53
        Top = 323
        Width = 51
        Height = 14
        Caption = 'CART'#213'ES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label157: TLabel
        Left = 390
        Top = 337
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outros:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label202: TLabel
        Left = 40
        Top = 109
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nacionalidade:'
      end
      object Label203: TLabel
        Left = 365
        Top = 109
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Naturalidade:'
      end
      object Label205: TLabel
        Left = 1
        Top = 248
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motivo Outras Rendas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object dbeNomPai: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 12
        Width = 557
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_NOMPAI'
        DataSource = dtsInfCre
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
      object dbeNomMae: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 35
        Width = 557
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_NOMMAE'
        DataSource = dtsInfCre
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
      object dbeConjug: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 58
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_CONJUG'
        DataSource = dtsInfCre
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
      object dbeNasCon: TDBEditFocus
        Tag = 99
        Left = 562
        Top = 58
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_NASCON'
        DataSource = dtsInfCre
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
      object dbeProfis: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 155
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_PROFIS'
        DataSource = dtsInfCre
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
      object dbeTrabal: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 176
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_TRABAL'
        DataSource = dtsInfCre
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
      object dbeEndSer: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 197
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_ENDSER'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeC_Prof: TDBEditFocus
        Tag = 99
        Left = 562
        Top = 155
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_C_PROF'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTemSer: TDBEditFocus
        Tag = 99
        Left = 562
        Top = 176
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_TEMSER'
        DataSource = dtsInfCre
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
      object dbeTelSer: TDBEditFocus
        Tag = 99
        Left = 562
        Top = 197
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_TELSER'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalari: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 220
        Width = 99
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_SALARI'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 15
        OnExit = pCalculaTotalRenda
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeOutRen: TDBEditFocus
        Tag = 99
        Left = 347
        Top = 220
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_OUTREN'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 16
        OnExit = pCalculaTotalRenda
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeVrAlug: TDBEditFocus
        Tag = 99
        Left = 347
        Top = 269
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_VRALUG'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 19
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEndIm1: TDBEditFocus
        Left = 113
        Top = 405
        Width = 323
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_ENDIM1'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 28
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValIm1: TDBEditFocus
        Left = 477
        Top = 405
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_VALIM1'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 29
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEndIm2: TDBEditFocus
        Left = 113
        Top = 426
        Width = 323
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_ENDIM2'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 30
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValIm2: TDBEditFocus
        Left = 477
        Top = 426
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_VALIM2'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 31
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeVeicul: TDBEditFocus
        Left = 113
        Top = 447
        Width = 323
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_VEICUL'
        DataSource = dtsInfCre
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
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValVei: TDBEditFocus
        Left = 477
        Top = 447
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_VALVEI'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 33
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtTotRen: TEditFocus
        Left = 562
        Top = 220
        Width = 108
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object cbxSexo: TComboBoxFocus
        Tag = 99
        Left = 562
        Top = 80
        Width = 108
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        Items.Strings = (
          'MASCULINO'
          'FEMININO')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbxEscolaridade: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 133
        Width = 557
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        Items.Strings = (
          'MASCULINO'
          'FEMININO')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeReside: TDBEditFocus
        Tag = 99
        Left = 562
        Top = 269
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_RESIDE'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        ParentFont = False
        TabOrder = 20
        OnKeyPress = dbeResideKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object cbxEstCiv: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 80
        Width = 319
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        Items.Strings = (
          'MASCULINO'
          'FEMININO')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbxMoradia: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 269
        Width = 99
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 18
        Items.Strings = (
          'MASCULINO'
          'FEMININO')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeAvalis: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 295
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_AVALIS'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 21
        OnKeyPress = dbeAvalisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeAvalisChamaCadastro
      end
      object edtDesAvalis: TEditFocus
        Left = 168
        Top = 295
        Width = 502
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
      object dbcVisa__: TDBCheckBox
        Left = 113
        Top = 334
        Width = 99
        Height = 17
        Caption = 'Visa'
        DataField = 'CLI_VISA__'
        DataSource = dtsInfCre
        TabOrder = 22
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcMaster: TDBCheckBox
        Left = 113
        Top = 351
        Width = 99
        Height = 17
        Caption = 'Master Card'
        DataField = 'CLI_MASTER'
        DataSource = dtsInfCre
        TabOrder = 23
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcHiperc: TDBCheckBox
        Left = 113
        Top = 368
        Width = 99
        Height = 17
        Caption = 'Hiper Card'
        DataField = 'CLI_HIPERC'
        DataSource = dtsInfCre
        TabOrder = 24
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcAmeric: TDBCheckBox
        Left = 218
        Top = 334
        Width = 113
        Height = 17
        Caption = 'American Express'
        DataField = 'CLI_AMERIC'
        DataSource = dtsInfCre
        TabOrder = 25
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcDiners: TDBCheckBox
        Left = 218
        Top = 351
        Width = 113
        Height = 17
        Caption = 'Diners'
        DataField = 'CLI_DINERS'
        DataSource = dtsInfCre
        TabOrder = 26
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBEditFocus4: TDBEditFocus
        Tag = 99
        Left = 430
        Top = 331
        Width = 240
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_OUTROS'
        DataSource = dtsInfCre
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
      object dbeNacion: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 103
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_NACION'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        OnKeyPress = dbeNacionKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtDesNacion: TEditFocus
        Left = 156
        Top = 103
        Width = 200
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
      object dbeNatura: TDBEditFocus
        Tag = 99
        Left = 431
        Top = 103
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_NATURA'
        DataSource = dtsInfCre
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        OnEnter = dbeNaturaEnter
        OnExit = dbeNaturaExit
        OnKeyPress = dbeNaturaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeNaturaChamaCadastro
      end
      object edtDesNatura: TEditFocus
        Left = 474
        Top = 103
        Width = 196
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 38
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeMotOut: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 243
        Width = 557
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_MOTOUT'
        DataSource = dtsInfCre
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
      object dbeObs_Fc: TDBMemoFocus
        Tag = 99
        Left = 113
        Top = 470
        Width = 456
        Height = 140
        DataField = 'CLI_OBS_FC'
        DataSource = dtsInfCre
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 34
        OnKeyPress = dbeObs_FcKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsClienteProduto: TTabSheet
      Caption = '12 - Relacionamento Cliente-Produto'
      ImageIndex = 10
      object dbgProdutos: TcxGrid
        Left = 0
        Top = 144
        Width = 1037
        Height = 461
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgProdutosDBTableView1: TcxGridDBTableView
          OnKeyDown = dbgProdutosKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCliPro
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.Visible = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object dbgProdutosCODPRO: TcxGridDBColumn
            Caption = 'C'#243'd. Item'
            DataBinding.FieldName = 'CODPRO'
            Width = 75
          end
          object dbgProdutosNOMPRO: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'NOMPRO'
            Width = 210
          end
          object dbgProdutosUNIDAD: TcxGridDBColumn
            Caption = 'Unid.'
            DataBinding.FieldName = 'UNIDAD'
            Width = 35
          end
          object dbgProdutosCOD_NF: TcxGridDBColumn
            Caption = 'C'#243'digo de F'#225'brica *'
            DataBinding.FieldName = 'COD_NF'
            Width = 150
          end
          object dbgProdutosDES_NF: TcxGridDBColumn
            Caption = 'Descri'#231#227'o de F'#225'brica *'
            DataBinding.FieldName = 'DES_NF'
            Width = 210
          end
          object dbgProdutosCODBAR: TcxGridDBColumn
            Caption = 'C'#243'd. Barras'
            DataBinding.FieldName = 'CODBAR'
            Width = 140
          end
        end
        object dbgProdutosLevel1: TcxGridLevel
          GridView = dbgProdutosDBTableView1
        end
      end
      object pnlProdutos: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 126
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl2: TLabel
          Left = 8
          Top = 15
          Width = 47
          Height = 14
          Caption = 'C'#243'd. Item:'
        end
        object lbl3: TLabel
          Left = 587
          Top = 15
          Width = 42
          Height = 14
          AutoSize = False
          Caption = 'Unidade:'
        end
        object lbl4: TLabel
          Left = 8
          Top = 53
          Width = 90
          Height = 14
          Caption = 'C'#243'digo de F'#225'brica:'
        end
        object lblBar_CP: TLabel
          Left = 587
          Top = 53
          Width = 87
          Height = 14
          Caption = 'C'#243'digo de Barras:'
        end
        object Label247: TLabel
          Left = 144
          Top = 52
          Width = 106
          Height = 14
          Caption = 'Descri'#231#227'o de F'#225'brica:'
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 8
          Top = 29
          Width = 74
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 83
          Top = 29
          Width = 502
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 87
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
        object edtCod_NF: TEditFocus
          Tag = 99
          Left = 8
          Top = 68
          Width = 135
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 4
          OnEnter = edtCod_NFEnter
          OnExit = edtCod_NFExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAdicionarProd: TBitBtnLocked
          Left = 624
          Top = 95
          Width = 75
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
          TabOrder = 7
          OnClick = btnAdicionarProdClick
        end
        object btnCancelaProd: TBitBtnLocked
          Left = 698
          Top = 95
          Width = 75
          Height = 22
          Caption = 'Ca&ncelar'
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
          TabOrder = 8
          OnClick = btnCancelaProdClick
        end
        object edtBar_CP: TEditFocus
          Tag = 99
          Left = 587
          Top = 68
          Width = 150
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 15
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDes_NF: TEditFocus
          Tag = 99
          Left = 144
          Top = 68
          Width = 442
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 120
          TabOrder = 5
          OnEnter = edtDes_NFEnter
          OnExit = edtDes_NFExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnHerancaCliPro: TBitBtnLocked
          Left = 803
          Top = 95
          Width = 75
          Height = 22
          Caption = 'Heran'#231'a'
          TabOrder = 9
          OnClick = btnHerancaCliProClick
        end
        object btnImpExcel: TBitBtnLocked
          Left = 877
          Top = 95
          Width = 121
          Height = 22
          Caption = 'Importar do Excel'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000020000
            00090000000E0000000F00000010000000100000001100000011000000110000
            001200000012000000110000000C000000030000000000000000000000087B50
            43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
            59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
            5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
            ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
            62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
            2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
            66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
            F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
            69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
            F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
            6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
            F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
            71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
            F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
            77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
            F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
            7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
            32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
            7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
            EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
            82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
            F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
            85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
            F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
            89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
            67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
            87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
            0002000000030000000400000004000000050000000500000005000000060000
            0006000000060000000600000005000000010000000000000000}
          TabOrder = 10
          OnClick = btnImpExcelClick
        end
        object edtDesUni: TEditFocus
          Left = 627
          Top = 29
          Width = 183
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
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 587
          Top = 29
          Width = 39
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 2
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl2: TPanel
        Left = 0
        Top = 126
        Width = 1037
        Height = 18
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lbl1: TLabel
          Left = 4
          Top = 2
          Width = 84
          Height = 14
          Caption = 'Lista de Produtos'
        end
        object lblBar_CP_Legenda: TLabel
          Left = 651
          Top = 2
          Width = 115
          Height = 14
          Caption = '* Campos Impress'#227'o NF'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 605
        Width = 1037
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 3
        object Label222: TLabel
          Left = 298
          Top = 3
          Width = 185
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pressione [DELETE] para excluir o item'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tbsCliVei: TTabSheet
      Caption = '13 - Ve'#237'culos'
      ImageIndex = 12
      object pnlCliVei: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 104
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl16: TLabel
          Left = 13
          Top = 11
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Placa Ve'#237'culo'
        end
        object lbl18: TLabel
          Left = 235
          Top = 11
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Modelo'
        end
        object lbl19: TLabel
          Left = 87
          Top = 11
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca'
        end
        object lbl21: TLabel
          Left = 12
          Top = 51
          Width = 17
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cor'
        end
        object lbl22: TLabel
          Left = 160
          Top = 51
          Width = 20
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ano'
        end
        object lbl23: TLabel
          Left = 308
          Top = 51
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ativo'
        end
        object ColorLabel30: TColorLabel
          Left = 339
          Top = 70
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
        object btnAddVei: TBitBtnLocked
          Left = 450
          Top = 38
          Width = 100
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
          TabOrder = 6
          OnClick = btnAddVeiClick
        end
        object btnCanVei: TBitBtnLocked
          Left = 450
          Top = 66
          Width = 100
          Height = 22
          Caption = 'Ca&ncelar'
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
          TabOrder = 7
          OnClick = btnCanVeiClick
        end
        object mskPlaVei: TMaskEditFocus
          Tag = 99
          Left = 12
          Top = 26
          Width = 72
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
          TabOrder = 0
          Text = ''
          OnKeyPress = mskPlaVeiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtModVei: TEditFocus
          Left = 235
          Top = 26
          Width = 192
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
        object edtMarVei: TEditFocus
          Left = 87
          Top = 26
          Width = 148
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCorVei: TEditFocus
          Left = 12
          Top = 66
          Width = 148
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtAnoVei: TEditFocus
          Left = 160
          Top = 66
          Width = 148
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtVeiAti: TEditFocus
          Tag = 99
          Left = 308
          Top = 66
          Width = 27
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 5
          Text = 'S'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
      end
      object pnl3: TPanel
        Left = 0
        Top = 104
        Width = 1037
        Height = 18
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lbl20: TLabel
          Left = 4
          Top = 2
          Width = 82
          Height = 14
          Caption = 'Lista de Ve'#237'culos'
        end
      end
      object dbgCliVei: TDBGridCitel
        Left = 0
        Top = 122
        Width = 1037
        Height = 504
        Align = alClient
        DataSource = dtsCliVei
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnEnter = dbgCliVeiEnter
        OnKeyDown = dbgCliVeiKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'PLAVEI'
            Title.Caption = 'Placa'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESMAR'
            Title.Caption = 'Marca'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESMOD'
            Title.Caption = 'Modelo'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCOR'
            Title.Caption = 'Cor'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ANOVEI'
            Title.Caption = 'Ano'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VEIATI'
            Title.Caption = 'Ativo?'
            Visible = True
          end>
      end
    end
    object tbsCliCnd: TTabSheet
      Caption = '14 - Condi'#231#245'es de Pagamento'
      ImageIndex = 13
      object pnlCodCnd: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 32
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblCndPag: TLabel
          Left = 13
          Top = 12
          Width = 122
          Height = 14
          Alignment = taRightJustify
          Caption = 'Condi'#231#227'o de  Pagamento:'
        end
        object edtCodCnd: TEditFocus
          Tag = 99
          Left = 138
          Top = 6
          Width = 40
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnEnter = edtCodCndEnter
          OnExit = edtCodCndExit
          OnKeyPress = edtCodCndKeyPress
          OnKeyUp = edtCodCndKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesCnd: TEditFocus
          Left = 179
          Top = 6
          Width = 380
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
        object btnIncCnd: TBitBtnLocked
          Left = 561
          Top = 6
          Width = 41
          Height = 22
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
          OnClick = btnIncCndClick
        end
      end
      object pnlConPag: TPanel
        Left = 0
        Top = 32
        Width = 1037
        Height = 32
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label210: TLabel
          Left = 13
          Top = 10
          Width = 122
          Height = 14
          Alignment = taRightJustify
          Caption = 'Condi'#231#227'o de  Pagamento:'
        end
        object mskConPag: TMaskEditFocus
          Tag = 99
          Left = 138
          Top = 4
          Width = 538
          Height = 22
          CharCase = ecUpperCase
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 98
          TabOrder = 0
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object cxgConPag: TcxGrid
        Left = 0
        Top = 64
        Width = 1037
        Height = 460
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCliCndView: TcxGridDBTableView
          OnKeyDown = cxgCliCndViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCliCnd
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.GroupByBox = False
          object cxgColCodCnd: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CND_CODCND'
            Options.Editing = False
            Width = 46
          end
          object cxgColDescri: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CND_DESCRI'
            Options.Editing = False
            Width = 372
          end
          object cxgColCndPag: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CND_CNDPAG'
            Options.Editing = False
            Width = 537
          end
          object cxgColSugest: TcxGridDBColumn
            Caption = 'Sugerir esta'
            DataBinding.FieldName = 'CND_SUGEST'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxgColSugestPropertiesChange
            Width = 71
          end
        end
        object cxgCliCnd: TcxGridLevel
          GridView = cxgCliCndView
        end
      end
      object pnlDiaFix: TPanel
        Left = 0
        Top = 524
        Width = 1037
        Height = 102
        Align = alBottom
        ParentColor = True
        TabOrder = 3
        object gpbDiaMes: TGroupBox
          Left = 512
          Top = 1
          Width = 524
          Height = 100
          Align = alRight
          Caption = 'Pagamento em dia Fixo do M'#234's:'
          TabOrder = 1
          object lstDiaMes: TCheckListBox
            Tag = 99
            Left = 2
            Top = 16
            Width = 520
            Height = 82
            OnClickCheck = lstDiaMesClickCheck
            Align = alClient
            Columns = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemHeight = 15
            Items.Strings = (
              '01'
              '02'
              '03'
              '04'
              '05'
              '06'
              '07'
              '08'
              '09'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
            ParentFont = False
            TabOrder = 0
          end
        end
        object gpbDiaFix: TGroupBox
          Left = 1
          Top = 1
          Width = 511
          Height = 100
          Align = alClient
          Caption = 'Pagamento em dia Fixo da Semana:'
          TabOrder = 0
          object lstDiaFix: TCheckListBox
            Tag = 99
            Left = 2
            Top = 16
            Width = 507
            Height = 82
            OnClickCheck = lstDiaFixClickCheck
            Align = alClient
            Columns = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemHeight = 14
            Items.Strings = (
              'segunda-feira'
              'ter'#231'a-feira'
              'quarta-feira'
              'quinta-feira'
              'sexta-feira')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object tbsConVis: TTabSheet
      Caption = '15 - Visitas'
      ImageIndex = 14
      object rdgDiaVis: TGroupBox
        Left = 14
        Top = 3
        Width = 227
        Height = 84
        Caption = 'Dias de Visita no Cliente'
        TabOrder = 0
        object chkSeg: TCheckBox
          Tag = 99
          Left = 14
          Top = 20
          Width = 92
          Height = 17
          Caption = 'Segunda-feira'
          TabOrder = 0
        end
        object chkTer: TCheckBox
          Tag = 99
          Left = 14
          Top = 38
          Width = 92
          Height = 17
          Caption = 'Ter'#231'a-feira'
          TabOrder = 1
        end
        object chkQua: TCheckBox
          Tag = 99
          Left = 14
          Top = 56
          Width = 92
          Height = 17
          Caption = 'Quarta-feira'
          TabOrder = 2
        end
        object chkSab: TCheckBox
          Tag = 99
          Left = 116
          Top = 56
          Width = 92
          Height = 17
          Caption = 'S'#225'bado'
          TabOrder = 5
        end
        object chkSex: TCheckBox
          Tag = 99
          Left = 116
          Top = 38
          Width = 92
          Height = 17
          Caption = 'Sexta-feira'
          TabOrder = 4
        end
        object chkQui: TCheckBox
          Tag = 99
          Left = 116
          Top = 20
          Width = 92
          Height = 17
          Caption = 'Quinta-feira'
          TabOrder = 3
        end
      end
      object rdgPerVis: TGroupBox
        Left = 247
        Top = 3
        Width = 130
        Height = 84
        Caption = 'Periodicidade Visitas'
        TabOrder = 1
        object rdbSemanal: TRadioButton
          Tag = 99
          Left = 14
          Top = 20
          Width = 96
          Height = 14
          Caption = 'Semanal'
          TabOrder = 0
        end
        object rdbQuinzenal: TRadioButton
          Tag = 99
          Left = 14
          Top = 38
          Width = 96
          Height = 14
          Caption = 'Quinzenal'
          TabOrder = 1
        end
        object rdbMensal: TRadioButton
          Tag = 99
          Left = 14
          Top = 56
          Width = 96
          Height = 14
          Caption = 'Mensal'
          TabOrder = 2
        end
      end
    end
    object tbsCliDiv: TTabSheet
      Caption = '16 - Profissionais'
      ImageIndex = 15
      object pnlCodDiv: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 49
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label224: TLabel
          Left = 48
          Top = 21
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Profissional:'
        end
        object edtCodDiv: TEditFocus
          Tag = 99
          Left = 112
          Top = 15
          Width = 66
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          OnKeyPress = edtCodDivKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomDiv: TEditFocus
          Left = 179
          Top = 15
          Width = 380
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
        object btnIncDiv: TBitBtnLocked
          Left = 561
          Top = 15
          Width = 41
          Height = 22
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
          OnClick = btnIncDivClick
        end
      end
      object cxgCliDiv: TcxGrid
        Left = 0
        Top = 49
        Width = 1037
        Height = 559
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgCliCndViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCliDiv
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DIV_CODDIV'
            Width = 60
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'DIV_NOMDIV'
            Options.Editing = False
            Width = 328
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Atividade'
            DataBinding.FieldName = 'DIV_NOMATI'
            Options.Editing = False
            Width = 300
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Sugerir esta'
            DataBinding.FieldName = 'DIV_SUGEST'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxGridDBColumn4PropertiesChange
            Width = 71
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
      object pnlInfDeletar: TPanel
        Left = 0
        Top = 608
        Width = 1037
        Height = 18
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object Label225: TLabel
          Left = 530
          Top = 5
          Width = 240
          Height = 14
          Alignment = taRightJustify
          Caption = 'Para Deletar um Profissional Utilize a Tecla [ DEL ] '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tbsCliConconEmp: TTabSheet
      Caption = '17 - Conta cont'#225'bil / Empresa'
      ImageIndex = 16
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 68
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label228: TLabel
          Left = 66
          Top = 17
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label229: TLabel
          Left = 39
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Cont'#225'bil:'
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 115
          Top = 13
          Width = 55
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnExit = edtCodEmpExit
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 171
          Top = 13
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
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtConcon: TEditFocus
          Tag = 99
          Left = 115
          Top = 36
          Width = 372
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlCampos: TPanel
        Left = 0
        Top = 596
        Width = 1037
        Height = 30
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object btnIncluirCC: TBitBtnLocked
          Left = 4
          Top = 4
          Width = 76
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
          OnClick = btnIncluirCCClick
        end
        object btnGravarCC: TBitBtnLocked
          Left = 81
          Top = 4
          Width = 76
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
          OnClick = btnGravarCCClick
        end
        object btnAlterarCC: TBitBtnLocked
          Left = 158
          Top = 4
          Width = 76
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
          OnClick = btnAlterarCCClick
        end
        object btnExcluirCC: TBitBtnLocked
          Left = 235
          Top = 4
          Width = 76
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
          OnClick = btnExcluirCCClick
        end
        object btnCancelarCC: TBitBtnLocked
          Left = 312
          Top = 4
          Width = 76
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
          OnClick = btnCancelarCCClick
        end
      end
      object grdEmpCli: TDBGridCitel
        Left = 0
        Top = 68
        Width = 1037
        Height = 528
        Align = alClient
        DataSource = dtsEmpCli
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyPress = grdEmpCliKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CodEmp'
            Title.Caption = 'C'#243'd. Emp.'
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomEmp'
            Title.Caption = 'Empresa'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Concon'
            Title.Caption = 'Conta Cont'#225'bil'
            Width = 115
            Visible = True
          end>
      end
    end
    object tbsBairroAtende: TTabSheet
      Caption = '18 - Bairros Atendidos'
      ImageIndex = 17
      object dbgCliBat: TDBGridCitel
        Left = 0
        Top = 63
        Width = 1037
        Height = 541
        Align = alClient
        BorderStyle = bsNone
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgCliBatKeyDown
        OnKeyUp = dbgCliBatKeyUp
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'BAT_CODBAI'
            Title.Caption = 'C'#243'digo'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAI_DESCRI'
            Title.Caption = 'Nome'
            Width = 307
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAI_CODCID'
            Title.Caption = 'C'#243'd. Cid.'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CID_NOMCID'
            Title.Caption = 'Cidade'
            Width = 245
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CID_ESTADO'
            Title.Caption = 'Estado'
            Width = 39
            Visible = True
          end>
      end
      object Panel8: TPanel
        Left = 0
        Top = 604
        Width = 1037
        Height = 22
        Align = alBottom
        Color = clGray
        ParentBackground = False
        TabOrder = 1
        object Label234: TLabel
          Left = 11
          Top = 4
          Width = 240
          Height = 14
          Caption = 'Precione [DELETE] sobre um registro para apagar.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
      object pnlTopoBairrosAtendidos: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 63
        Align = alTop
        TabOrder = 2
        object Label230: TLabel
          Left = 6
          Top = 12
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
        end
        object Label231: TLabel
          Left = 127
          Top = 12
          Width = 30
          Height = 14
          Caption = 'Nome:'
        end
        object Label232: TLabel
          Left = 6
          Top = 35
          Width = 36
          Height = 14
          Caption = 'Cidade:'
        end
        object Label233: TLabel
          Left = 379
          Top = 36
          Width = 16
          Height = 14
          Caption = 'UF:'
        end
        object edtNomCidBat: TEditFocus
          Left = 96
          Top = 32
          Width = 277
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEstadoBat: TEditFocus
          Left = 401
          Top = 32
          Width = 34
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCodBai: TEditFocus
          Tag = 99
          Left = 45
          Top = 8
          Width = 76
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 2
          OnKeyPress = edtCodBaiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtDescri: TEditFocus
          Tag = 99
          Left = 160
          Top = 8
          Width = 275
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCodCidBat: TEditFocus
          Tag = 99
          Left = 45
          Top = 32
          Width = 47
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          MaxLength = 5
          ReadOnly = True
          TabOrder = 4
          OnKeyPress = dbeCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnAdicionaBat: TBitBtnLocked
          Left = 450
          Top = 8
          Width = 100
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
          TabOrder = 5
          OnClick = btnAdicionaBatClick
        end
        object btnCancelBat: TBitBtnLocked
          Left = 450
          Top = 32
          Width = 100
          Height = 22
          Caption = 'Ca&ncelar'
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
          TabOrder = 6
          OnClick = btnCancelBatClick
        end
      end
    end
    object tbsFazendas: TTabSheet
      Caption = '18 - Fazendas'
      ImageIndex = 17
      OnHide = tbsFazendasHide
      object pnlFazendas: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 626
        Align = alClient
        Caption = 
          'AQUI SERA EXIBIDO O FORM DE CADASTRO DE FAZENDAS, NAO COLOCAR NA' +
          'DA NESTE PANEL....'
        ParentColor = True
        TabOrder = 0
      end
    end
    object tbsIntVen: TTabSheet
      Caption = '19 - Intelig'#234'ncia de Vendas'
      ImageIndex = 19
      object Panel9: TPanel
        Left = 0
        Top = 82
        Width = 1037
        Height = 37
        Align = alTop
        TabOrder = 0
        object Label250: TLabel
          Left = 9
          Top = 13
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor Atual:'
        end
        object Label251: TLabel
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
      object cxgCliFor: TcxGridCitel
        Left = 0
        Top = 119
        Width = 1037
        Height = 507
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCliForTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgCliForTableViewKeyDown
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
          object cxgCliForTableViewColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CLF_CRMFOR'
            Width = 82
          end
          object cxgCliForTableViewColumn2: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'CRF_NOMFOR'
            Width = 487
          end
        end
        object cxgCliForLevel: TcxGridLevel
          GridView = cxgCliForTableView
        end
      end
      object pnlInteligenciaDeVendas: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 82
        Align = alTop
        TabOrder = 2
        object Label209: TLabel
          Left = 61
          Top = 10
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Frequ'#234'ncia:'
        end
        object Label248: TLabel
          Left = 90
          Top = 34
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Porte:'
        end
        object Label249: TLabel
          Left = 7
          Top = 57
          Width = 111
          Height = 14
          Alignment = taRightJustify
          Caption = 'Faixa de Fat. Estimado:'
        end
        object lblCategoria: TLabel
          Left = 588
          Top = 11
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria:'
        end
        object dbeCrmFre: TDBEditFocus
          Tag = 99
          Left = 124
          Top = 7
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CRMFRE'
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
          OnKeyPress = dbeCrmFreKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesFre: TEditFocus
          Left = 179
          Top = 7
          Width = 400
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
        object dbeCrmPor: TDBEditFocus
          Tag = 99
          Left = 124
          Top = 30
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CRMPOR'
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
          OnKeyPress = dbeCrmPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesCrmPor: TEditFocus
          Left = 179
          Top = 30
          Width = 400
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
        object dbeCrmFai: TDBEditFocus
          Tag = 99
          Left = 124
          Top = 53
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CRMFAI'
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
          OnKeyPress = dbeCrmFaiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesFai: TEditFocus
          Left = 179
          Top = 53
          Width = 400
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object dbeCrmCat: TDBEditFocus
          Tag = 99
          Left = 643
          Top = 7
          Width = 54
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CRMCAT'
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
          OnKeyPress = dbeCrmCatKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesCat: TEditFocus
          Left = 699
          Top = 7
          Width = 298
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
      end
    end
    object tshEmbarcacoes: TTabSheet
      Caption = '20 - Embarca'#231#245'es'
      ImageIndex = 20
      OnShow = tshEmbarcacoesShow
      object grbEmbarcacoes: TGroupBox
        Left = 0
        Top = 0
        Width = 1037
        Height = 60
        Align = alTop
        Caption = '   Embarca'#231#245'es   '
        TabOrder = 0
        object lblEmbarcacao: TLabel
          Left = 8
          Top = 26
          Width = 88
          Height = 14
          Caption = 'C'#243'd. Embarca'#231#227'o:'
        end
        object edtCodEmb: TEditFocus
          Tag = 99
          Left = 99
          Top = 23
          Width = 60
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 6
          TabOrder = 0
          OnKeyPress = edtCodEmbKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDesEmb: TEditFocus
          Left = 161
          Top = 23
          Width = 512
          Height = 22
          Alignment = taLeftJustify
          Color = 16770261
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16770261
          FocusColor = 16770261
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnGravarEmb: TBitBtnLocked
          Left = 679
          Top = 23
          Width = 41
          Height = 22
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
          OnClick = btnGravarEmbClick
        end
      end
      object grdCadEmb: TcxGridCitel
        Left = 0
        Top = 60
        Width = 1037
        Height = 566
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdCadEmbDados: TcxGridDBTableViewCitel
          OnKeyDown = grdCadEmbDadosKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCadEmb
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'AUTOINCREM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object grdCadEmbDadosEMB_CODEMB: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EMB_CODEMB'
          end
          object grdCadEmbDadosEMB_NOMEMB: TcxGridDBColumn
            Caption = 'Nome da Embarca'#231#227'o'
            DataBinding.FieldName = 'EMB_NOMEMB'
          end
          object grdCadEmbDadosEMB_NUMIMO: TcxGridDBColumn
            Caption = 'N'#250'mero da IMO'
            DataBinding.FieldName = 'EMB_NUMIMO'
          end
          object grdCadEmbDadosEMB_INSCRI: TcxGridDBColumn
            Caption = 'N'#250'mero da Inscri'#231#227'o'
            DataBinding.FieldName = 'EMB_INSCRI'
          end
          object grdCadEmbDadosEMB_INDEMB: TcxGridDBColumn
            Caption = 'Indicativo do Navio'
            DataBinding.FieldName = 'EMB_INDEMB'
          end
          object grdCadEmbDadosEMB_PORTOI: TcxGridDBColumn
            Caption = 'Porto de Inscri'#231#245'es'
            DataBinding.FieldName = 'EMB_PORTOI'
          end
          object grdCadEmbDadosEMB_PORTE_: TcxGridDBColumn
            Caption = 'Porte do Navio'
            DataBinding.FieldName = 'EMB_PORTE_'
          end
          object grdCadEmbDadosEMB_COMPRI: TcxGridDBColumn
            Caption = 'Comprimento do Navio'
            DataBinding.FieldName = 'EMB_COMPRI'
          end
          object grdCadEmbDadosEMB_ARQBRU: TcxGridDBColumn
            Caption = 'Arquea'#231#227'o Bruta'
            DataBinding.FieldName = 'EMB_ARQBRU'
          end
          object grdCadEmbDadosEMB_OBSERV: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'EMB_OBSERV'
          end
        end
        object grdCadEmbLvl1: TcxGridLevel
          GridView = grdCadEmbDados
        end
      end
    end
    object tbsDatasControle: TTabSheet
      Caption = '21 - Datas de Controle'
      ImageIndex = 21
      object gpbCtrFat: TGroupBox
        Left = 0
        Top = 0
        Width = 1037
        Height = 283
        Align = alTop
        Caption = 'Datas permitidas para faturamento ( Emiss'#227'o de Faturamento )'
        TabOrder = 0
        object GroupBox6: TGroupBox
          Left = 2
          Top = 16
          Width = 509
          Height = 265
          Align = alClient
          Caption = 'Dia Fixo da Semana:'
          TabOrder = 0
          object lstDiaSemPerFat: TCheckListBox
            Tag = 99
            Left = 2
            Top = 16
            Width = 505
            Height = 247
            Align = alClient
            Columns = 1
            ItemHeight = 14
            Items.Strings = (
              'domingo'
              'segunda-feira'
              'ter'#231'a-feira'
              'quarta-feira'
              'quinta-feira'
              'sexta-feira'
              's'#225'bado')
            TabOrder = 0
          end
        end
        object gpbPagFixMes: TGroupBox
          Left = 511
          Top = 16
          Width = 524
          Height = 265
          Align = alRight
          Caption = 'Dia Fixo do M'#234's:'
          TabOrder = 1
          object lstDiaMesPerFat: TCheckListBox
            Tag = 99
            Left = 2
            Top = 16
            Width = 520
            Height = 247
            Align = alClient
            Columns = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemHeight = 15
            Items.Strings = (
              '01'
              '02'
              '03'
              '04'
              '05'
              '06'
              '07'
              '08'
              '09'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object gpbCtrEnt: TGroupBox
        Left = 0
        Top = 283
        Width = 1037
        Height = 343
        Align = alClient
        Caption = 'Datas permitidas para entrega ( Entrega das Mercadorias )'
        TabOrder = 1
        object gpb: TGroupBox
          Left = 2
          Top = 16
          Width = 509
          Height = 325
          Align = alClient
          Caption = 'Dia Fixo da Semana/Per'#237'odo:'
          TabOrder = 0
          object cxgDiaSemEnt: TcxGridCitel
            Left = 2
            Top = 16
            Width = 505
            Height = 307
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgDiaSemEntView: TcxGridDBBandedTableViewCitel
              OnKeyPress = cxgDiaSemEntViewKeyPress
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsDtaPerEnt
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Bands = <
                item
                  Width = 127
                end
                item
                  Caption = 'Hor'#225'rio 1'
                  Width = 115
                end
                item
                  Caption = 'Hor'#225'rio 2'
                  Width = 115
                end
                item
                  Caption = 'Hor'#225'rio 3'
                  Width = 115
                end>
              Zebra = False
              Destaque = False
              DestacarRegistro = False
              CorZebra = clMoneyGreen
              object cxgDiaSemEntViewColumn1: TcxGridDBBandedColumn
                DataBinding.FieldName = 'MARCAD'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Width = 24
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
                IsCaptionAssigned = True
              end
              object cxgDiaSemEntViewColumn2: TcxGridDBBandedColumn
                Caption = 'Dia Semana'
                DataBinding.FieldName = 'SEMANA'
                Options.Editing = False
                Width = 105
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn3: TcxGridDBBandedColumn
                Caption = 'Hora Inicial'
                DataBinding.FieldName = 'HRAINI'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 58
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn4: TcxGridDBBandedColumn
                Caption = 'Hora Final'
                DataBinding.FieldName = 'HRAFIN'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 54
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn5: TcxGridDBBandedColumn
                Caption = 'Hora Inicial'
                DataBinding.FieldName = 'HRAIN2'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 58
                Position.BandIndex = 2
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn6: TcxGridDBBandedColumn
                Caption = 'Hora Final'
                DataBinding.FieldName = 'HRAFI2'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 54
                Position.BandIndex = 2
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn7: TcxGridDBBandedColumn
                Caption = 'Hora Inicial'
                DataBinding.FieldName = 'HRAIN3'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 58
                Position.BandIndex = 3
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgDiaSemEntViewColumn8: TcxGridDBBandedColumn
                Caption = 'Hora Final'
                DataBinding.FieldName = 'HRAFI3'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.ImmediatePost = True
                Properties.TimeFormat = tfHourMin
                Width = 54
                Position.BandIndex = 3
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
            end
            object cxgDiaSemEntLevel: TcxGridLevel
              GridView = cxgDiaSemEntView
            end
          end
        end
        object GroupBox5: TGroupBox
          Left = 511
          Top = 16
          Width = 524
          Height = 325
          Align = alRight
          Caption = 'Dia Fixo do M'#234's:'
          TabOrder = 1
          object lstDiaMesPerEnt: TCheckListBox
            Tag = 99
            Left = 2
            Top = 16
            Width = 520
            Height = 307
            Align = alClient
            Columns = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemHeight = 15
            Items.Strings = (
              '01'
              '02'
              '03'
              '04'
              '05'
              '06'
              '07'
              '08'
              '09'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object tbsQualificacao: TTabSheet
      Caption = '22 - Qualifica'#231#227'o'
      ImageIndex = 22
      object pnlQualificacao: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 145
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblQualificacao: TLabel
          Left = 44
          Top = 21
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qualifica'#231#227'o:'
        end
        object lblObsQua: TLabel
          Left = 43
          Top = 93
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Observa'#231#227'o:'
        end
        object edtCodQua: TEditFocus
          Tag = 99
          Left = 112
          Top = 15
          Width = 66
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 0
          OnExit = edtCodQuaExit
          OnKeyPress = edtCodQuaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesQua: TEditFocus
          Left = 179
          Top = 15
          Width = 298
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
        object memoObservacao: TMemoFocus
          Tag = 99
          Left = 112
          Top = 44
          Width = 447
          Height = 91
          ScrollBars = ssVertical
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object btnIncluirQuaCli: TBitBtnLocked
          Left = 565
          Top = 113
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
          TabOrder = 4
          OnClick = btnIncluirQuaCliClick
        end
        object chkCertificado: TcxCheckBox
          Left = 483
          Top = 16
          Caption = 'Certificado'
          TabOrder = 2
          OnKeyDown = chkCertificadoKeyDown
        end
        object btnCanQuaCli: TBitBtnLocked
          Left = 565
          Top = 85
          Width = 89
          Height = 22
          Caption = 'Ca&ncelar'
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
          OnClick = btnCanQuaCliClick
        end
      end
      object cxGridQuaCli: TcxGrid
        Left = 0
        Top = 145
        Width = 1037
        Height = 481
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdQuaCli: TcxGridDBTableView
          OnKeyDown = grdQuaCliKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = grdQuaCliCellDblClick
          DataController.DataSource = dtsCadQualificacao
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.GroupByBox = False
          object grdQuaCliQUA_CODQUA: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'QUA_CODQUA'
            MinWidth = 6
            Options.Editing = False
            Width = 59
          end
          object grdQuaCliQUA_DESQUA: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'QUA_DESQUA'
            Options.Editing = False
            Width = 336
          end
          object grdQuaCliQUA_CERQUA: TcxGridDBColumn
            Caption = 'Certificado'
            DataBinding.FieldName = 'QUA_CERQUA'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayChecked = 'S'
            Properties.DisplayUnchecked = 'N'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Options.Editing = False
            Width = 72
          end
          object grdQuaCliQUA_OBSQUA: TcxGridDBColumn
            Caption = 'Observa'#231#227'o'
            DataBinding.FieldName = 'QUA_OBSQUA'
            Options.Editing = False
            Width = 409
          end
        end
        object cxGridLevelQuaCli: TcxGridLevel
          GridView = grdQuaCli
        end
      end
    end
    object tbsDepartamentoCliente: TTabSheet
      Caption = '23 - Relacionamento Cliente-Departamento Prod.'
      ImageIndex = 23
      object cxgCliDep: TcxGrid
        Left = 0
        Top = 32
        Width = 1037
        Height = 573
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvCliDep: TcxGridDBTableView
          OnKeyDown = cxgCliCndViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCliDep
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.GroupByBox = False
          object cxgDEP_CODDEP: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DEP_CODDEP'
            Options.Editing = False
            Width = 46
          end
          object cxgDEP_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Departamento'
            DataBinding.FieldName = 'DEP_DESCRI'
            Options.Editing = False
            Width = 372
          end
        end
        object cxlCliDep: TcxGridLevel
          GridView = cxvCliDep
        end
      end
      object pnlCliDep: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 32
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object lblCliDep: TLabel
          Left = 25
          Top = 12
          Width = 110
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento Produto:'
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 138
          Top = 6
          Width = 40
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesDep: TEditFocus
          Left = 179
          Top = 6
          Width = 380
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
        object btnIncDep: TBitBtnLocked
          Left = 561
          Top = 6
          Width = 41
          Height = 22
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
          OnClick = btnIncDepClick
        end
      end
      object pnlLegendaGrdCliDep: TPanel
        Left = 0
        Top = 605
        Width = 1037
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 2
        object lblLegendaGrdCliDep: TLabel
          Left = 298
          Top = 3
          Width = 185
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pressione [DELETE] para excluir o item'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tbsPrioridadeSaidaEstoque: TTabSheet
      Caption = 
        '24-Empresas que o cliente n'#227'o pode comprar na prioridade de sa'#237'd' +
        'a de estoque'
      ImageIndex = 24
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 41
        Align = alTop
        TabOrder = 0
        object lblEmpresaPrioridade: TLabel
          Left = 17
          Top = 13
          Width = 93
          Height = 14
          Caption = 'Informe a empresa:'
        end
        object edtCodEmpPrioridade: TEditFocus
          Left = 114
          Top = 10
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodEmpPrioridadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesEmpPrioridade: TEditFocus
          Left = 173
          Top = 10
          Width = 411
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object btnAdicionar: TBitBtnLocked
          Left = 586
          Top = 10
          Width = 104
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
          TabOrder = 2
          OnClick = btnAdicionarClick
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 41
        Width = 1037
        Height = 585
        Align = alClient
        TabOrder = 1
        object grdEmpresaPrioridade: TcxGrid
          Left = 1
          Top = 1
          Width = 1035
          Height = 583
          Align = alClient
          TabOrder = 0
          object grdEmpresaPrioridadeDBTableView: TcxGridDBTableView
            OnKeyDown = grdEmpresaPrioridadeDBTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsEmpresaPrioridade
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object grdEmpresaPrioridadeDBTableViewColumn1: TcxGridDBColumn
              Caption = 'Autoincremento'
              DataBinding.FieldName = 'AUTINC'
              Visible = False
            end
            object grdEmpresaPrioridadeDBTableViewColumn2: TcxGridDBColumn
              Caption = 'C'#243'd. Cliente'
              DataBinding.FieldName = 'CODCLI'
              Visible = False
            end
            object grdEmpresaPrioridadeDBTableViewColumn3: TcxGridDBColumn
              Caption = 'C'#243'd. Empresa'
              DataBinding.FieldName = 'CODEMP'
              Width = 90
            end
            object grdEmpresaPrioridadeDBTableViewColumn4: TcxGridDBColumn
              Caption = 'Nome Empresa'
              DataBinding.FieldName = 'NOMEMP'
            end
          end
          object grdEmpresaPrioridadeLevel1: TcxGridLevel
            GridView = grdEmpresaPrioridadeDBTableView
          end
        end
      end
    end
    object tbsEcommerce: TTabSheet
      Caption = '25 - E-Commerce'
      ImageIndex = 26
      object clbObgPdl: TColorLabel
        Left = 488
        Top = 83
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
      object lblObrigarPedidoRotinaLiberacaoEcommerce: TLabel
        Left = 23
        Top = 83
        Width = 413
        Height = 14
        Alignment = taRightJustify
        Caption = 
          'Obrigar pedido passar pela rotina de libera'#231#227'o mesmo que n'#227'o ten' +
          'ha nenhuma trava?'
      end
      object lblPermiteAltercaoViaEcommerce: TLabel
        Left = 206
        Top = 18
        Width = 230
        Height = 14
        Alignment = taRightJustify
        Caption = 'Permite altera'#231#245'es cadastrais via E-Commerce?'
      end
      object clbAltEco: TColorLabel
        Left = 488
        Top = 18
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
      object lblExportarParaEcommerce: TLabel
        Left = 300
        Top = 50
        Width = 136
        Height = 14
        Alignment = taRightJustify
        Caption = 'Exportar para E-Commerce?'
      end
      object clbExpEco: TColorLabel
        Left = 488
        Top = 49
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
      object dbeObgPdl: TDBEditFocus
        Tag = 99
        Left = 443
        Top = 80
        Width = 39
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_OBGPDL'
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
        TipoTexto = ttAlfabetico
      end
      object dbeAltEco: TDBEditFocus
        Tag = 99
        Left = 443
        Top = 14
        Width = 39
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_ALTECO'
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
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeExpEco: TDBEditFocus
        Tag = 99
        Left = 443
        Top = 46
        Width = 39
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_EXPECO'
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
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 247
    Top = 212
  end
  inherited ApplicationEvents: TApplicationEvents
    OnDeactivate = ApplicationEventsDeactivate
    Left = 310
    Top = 212
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 373
    Top = 212
  end
  object dtsCliCtt: TDataSource
    DataSet = cdsCliCtt
    Left = 770
    Top = 110
  end
  object cdsCliCtt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 709
    Top = 111
    object cdsCliCttAUTCTT: TStringField
      FieldName = 'CLI_AUTCTT'
      Size = 1
    end
    object cdsCliCttCPFCTT: TStringField
      FieldName = 'CLI_CPFCTT'
      Size = 11
    end
    object cdsCliCttRG_CTT: TStringField
      FieldName = 'CLI_RG_CTT'
      Size = 15
    end
    object cdsCliCttNOMCTT: TStringField
      FieldName = 'CLI_NOMCTT'
      Size = 50
    end
    object cdsCliCttENDCTT: TStringField
      FieldName = 'CLI_ENDCTT'
      Size = 50
    end
    object cdsCliCttBAICTT: TStringField
      FieldName = 'CLI_BAICTT'
      Size = 30
    end
    object cdsCliCttNOMCID: TStringField
      FieldName = 'CLI_NOMCID'
      Size = 40
    end
    object cdsCliCttESTCID: TStringField
      FieldName = 'CLI_ESTCID'
      Size = 2
    end
    object cdsCliCttTELCTT: TStringField
      FieldName = 'CLI_TELCTT'
      Size = 16
    end
    object cdsCliCttEMACTT: TStringField
      FieldName = 'CLI_EMACTT'
      Size = 255
    end
    object cdsCliCttCODCID: TStringField
      FieldName = 'CLI_CODCID'
      Size = 5
    end
    object cdsCliCttCELCTT: TStringField
      FieldName = 'CLI_CELCTT'
      Size = 16
    end
    object cdsCliCttFAXCTT: TStringField
      FieldName = 'CLI_FAXCTT'
      Size = 16
    end
    object cdsCliCttDEPCTT: TStringField
      FieldName = 'CLI_DEPCTT'
      Size = 25
    end
    object cdsCliCttCGOCTT: TStringField
      FieldName = 'CLI_CGOCTT'
      Size = 5
    end
    object cdsCliCttNOMCGO: TStringField
      FieldName = 'CLI_NOMCGO'
      Size = 50
    end
    object cdsCliCttDPTCTT: TStringField
      FieldName = 'CLI_DPTCTT'
      Size = 5
    end
    object cdsCliCttNOMDPT: TStringField
      FieldName = 'CLI_NOMDPT'
      Size = 50
    end
    object cdsCliCttTFUCTT: TStringField
      FieldName = 'CLI_TFUCTT'
      Size = 5
    end
    object cdsCliCttNOMTFU: TStringField
      FieldName = 'CLI_NOMTFU'
      Size = 30
    end
    object cdsCliCttHOBCTT: TStringField
      FieldName = 'CLI_HOBCTT'
      Size = 5
    end
    object cdsCliCttNOMHOB: TStringField
      FieldName = 'CLI_NOMHOB'
      Size = 30
    end
    object cdsCliCttESCCTT: TStringField
      FieldName = 'CLI_ESCCTT'
      Size = 5
    end
    object cdsCliCttNOMESC: TStringField
      FieldName = 'CLI_NOMESC'
      Size = 30
    end
    object cdsCliCttGMUCTT: TStringField
      FieldName = 'CLI_GMUCTT'
      Size = 5
    end
    object cdsCliCttNOMGMU: TStringField
      FieldName = 'CLI_NOMGMU'
      Size = 30
    end
    object cdsCliCttECICTT: TStringField
      FieldName = 'CLI_ECICTT'
      Size = 5
    end
    object cdsCliCttNOMECI: TStringField
      FieldName = 'CLI_NOMECI'
      Size = 30
    end
    object cdsCliCttNASCTT: TDateField
      FieldName = 'CLI_NASCTT'
    end
    object cdsCliCttTEMEMP: TStringField
      FieldName = 'CLI_TEMEMP'
      Size = 10
    end
    object cdsCliCttTEMSEG: TStringField
      FieldName = 'CLI_TEMSEG'
      Size = 10
    end
    object cdsCliCttQTDFIL: TIntegerField
      FieldName = 'CLI_QTDFIL'
    end
    object cdsCliCttCERCTT: TMemoField
      FieldName = 'CLI_CERCTT'
      BlobType = ftMemo
    end
    object cdsCliCttOBSCTT: TStringField
      FieldName = 'CLI_OBSCTT'
      Size = 100
    end
    object cdsCliCttAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCliCttCLI_IDCIDE: TStringField
      FieldName = 'CLI_IDCIDE'
    end
    object cdsCliCttCLI_RAMFON: TStringField
      FieldName = 'CLI_RAMFON'
      Size = 4
    end
    object cdsCliCttCLI_RAMFAX: TStringField
      FieldName = 'CLI_RAMFAX'
      Size = 4
    end
  end
  object dtsCliPro: TDataSource
    Left = 791
    Top = 276
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    OnDataChange = dtsTabelaDataChange
    Left = 690
    Top = 388
  end
  object dtsCadFic: TDataSource
    Left = 740
    Top = 388
  end
  object dtsInfCre: TDataSource
    Left = 739
    Top = 276
  end
  object mnuOpcoesPageControl: TPopupMenu
    Left = 216
    Top = 212
    object mnuAtivarMododeOrdenacao: TMenuItem
      Caption = 'Ativar modo de ordena'#231#227'o'
      OnClick = mnuAtivarMododeOrdenacaoClick
    end
  end
  object cdsCliCnd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsCliCndAfterPost
    Left = 928
    Top = 468
    object cdsCliCndAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCliCndCND_CODCLI: TStringField
      FieldName = 'CND_CODCLI'
    end
    object cdsCliCndCND_CODCND: TStringField
      FieldName = 'CND_CODCND'
    end
    object cdsCliCndCND_SUGEST: TStringField
      FieldName = 'CND_SUGEST'
    end
    object cdsCliCndCND_DESCRI: TStringField
      FieldName = 'CND_DESCRI'
      ProviderFlags = []
      Size = 100
    end
    object cdsCliCndCND_CNDPAG: TStringField
      FieldName = 'CND_CNDPAG'
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      Size = 100
    end
  end
  object dtsCliCnd: TDataSource
    DataSet = cdsCliCnd
    Left = 965
    Top = 516
  end
  object dtsCliRco: TDataSource
    DataSet = cdsCliRco
    Left = 887
    Top = 335
  end
  object cdsCliRco: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 848
    Top = 319
    object cdsCliRcoAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsCliRcoCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsCliRcoEMPRCO: TStringField
      FieldName = 'EMPRCO'
      Size = 50
    end
    object cdsCliRcoCGCCPF: TStringField
      FieldName = 'CGCCPF'
      Size = 1
    end
    object cdsCliRcoCGCEMP: TStringField
      FieldName = 'CGCEMP'
      Size = 18
    end
    object cdsCliRcoCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      Size = 18
    end
    object cdsCliRcoTELEMP: TStringField
      FieldName = 'TELEMP'
      Size = 15
    end
    object cdsCliRcoCONEMP: TMemoField
      FieldName = 'CONEMP'
      BlobType = ftMemo
    end
    object cdsCliRcoEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 50
    end
    object cdsCliRcoDTACON: TDateTimeField
      FieldName = 'DTACON'
    end
    object cdsCliRcoNOMINF: TStringField
      FieldName = 'NOMINF'
      Size = 40
    end
    object cdsCliRcoDTAPCO: TDateTimeField
      FieldName = 'DTAPCO'
    end
    object cdsCliRcoVALPCO: TFloatField
      FieldName = 'VALPCO'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsCliRcoDTAMCO: TDateTimeField
      FieldName = 'DTAMCO'
    end
    object cdsCliRcoVALMCO: TFloatField
      FieldName = 'VALMCO'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsCliRcoDTAUCO: TDateTimeField
      FieldName = 'DTAUCO'
    end
    object cdsCliRcoVALUCO: TFloatField
      FieldName = 'VALUCO'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsCliRcoCODOPE: TStringField
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsCliRcoCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsCliRcoDESOPE: TStringField
      FieldName = 'DESOPE'
      Size = 50
    end
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 343
    Top = 212
  end
  object dtsCliVei: TDataSource
    DataSet = cdsCliVei
    Left = 544
    Top = 280
  end
  object cdsCliVei: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 490
    Top = 281
    object StringField1: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object StringField2: TStringField
      FieldName = 'PLAVEI'
      Size = 7
    end
    object StringField3: TStringField
      FieldName = 'DESMOD'
      Size = 40
    end
    object StringField4: TStringField
      FieldName = 'DESMAR'
      Size = 40
    end
    object StringField5: TStringField
      FieldName = 'DESCOR'
      Size = 40
    end
    object cdsCliVeiANOVEI: TStringField
      FieldName = 'ANOVEI'
      Size = 5
    end
    object cdsCliVeiVEIATI: TStringField
      FieldName = 'VEIATI'
      Size = 3
    end
  end
  object qryCliDiv: TUniQuery
    Connection = frmModulo.Database
    Left = 958
    Top = 560
  end
  object dtsCliDiv: TDataSource
    DataSet = cdsCliDiv
    Left = 962
    Top = 610
  end
  object cdsCliDiv: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliDiv'
    AfterPost = cdsCliDivAfterPost
    Left = 922
    Top = 564
    object cdsCliDivDIV_CODCLI: TStringField
      DisplayWidth = 20
      FieldName = 'DIV_CODCLI'
    end
    object cdsCliDivDIV_SUGEST: TStringField
      FieldName = 'DIV_SUGEST'
      Size = 1
    end
    object cdsCliDivDIV_NOMDIV: TStringField
      FieldName = 'DIV_NOMDIV'
      Size = 40
    end
    object cdsCliDivDIV_NOMATI: TStringField
      FieldName = 'DIV_NOMATI'
      Size = 80
    end
    object cdsCliDivDIV_CODDIV: TStringField
      FieldName = 'DIV_CODDIV'
      Size = 8
    end
  end
  object dspCliDiv: TUniDataSetProvider
    DataSet = qryCliDiv
    Options = []
    Left = 925
    Top = 610
  end
  object dtsEmpCli: TDataSource
    DataSet = cdsEmpCli
    Left = 669
    Top = 276
  end
  object cdsEmpCli: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 616
    Top = 276
    object cdsEmpCliCodEmp: TStringField
      FieldName = 'CodEmp'
    end
    object cdsEmpCliNomEmp: TStringField
      FieldName = 'NomEmp'
      Size = 100
    end
    object cdsEmpCliConcon: TStringField
      FieldName = 'Concon'
    end
    object cdsEmpCliCodigo: TStringField
      FieldName = 'Codigo'
    end
    object cdsEmpCliAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object dtsCadEmb: TDataSource
    DataSet = cdsCadEmb
    Left = 405
    Top = 254
  end
  object cdsCadEmb: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 446
    Top = 230
    object cdsCadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCadEmbEMB_CODEMB: TStringField
      FieldName = 'EMB_CODEMB'
      Size = 6
    end
    object cdsCadEmbEMB_NUMIMO: TStringField
      FieldName = 'EMB_NUMIMO'
      Size = 7
    end
    object cdsCadEmbEMB_INSCRI: TStringField
      FieldName = 'EMB_INSCRI'
      Size = 14
    end
    object cdsCadEmbEMB_NOMEMB: TStringField
      FieldName = 'EMB_NOMEMB'
      Size = 70
    end
    object cdsCadEmbEMB_INDEMB: TStringField
      FieldName = 'EMB_INDEMB'
      Size = 10
    end
    object cdsCadEmbEMB_PORTOI: TStringField
      FieldName = 'EMB_PORTOI'
      Size = 30
    end
    object cdsCadEmbEMB_LOCEMB: TStringField
      FieldName = 'EMB_LOCEMB'
      Size = 30
    end
    object cdsCadEmbEMB_PORTE_: TStringField
      FieldName = 'EMB_PORTE_'
      Size = 15
    end
    object cdsCadEmbEMB_COMPRI: TFloatField
      FieldName = 'EMB_COMPRI'
    end
    object cdsCadEmbEMB_ARQBRU: TIntegerField
      FieldName = 'EMB_ARQBRU'
    end
    object cdsCadEmbEMB_OBSERV: TStringField
      FieldName = 'EMB_OBSERV'
      Size = 5000
    end
    object cdsCadEmbCLIEMB_AUTINC: TStringField
      FieldName = 'CLIEMB_AUTINC'
    end
  end
  object imglStatus: TImageList
    Left = 278
    Top = 212
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021212100212121002121
      21002121210021212100212121002121210021212100313131008C7B6300A58C
      6300A58C6300947B630042424200000000000000000021212100212121002121
      210021212100212121002121210021212100212121003131310052846B004A9C
      73004A946B004A8C630042424200000000000000000021212100212121002121
      2100212121002121210021212100212121002121210031313100425A9400315A
      AD00395AAD00395A9C0042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042393900A5947300A58C7300A58C
      6B00A58C6B00A58C6B00A58C6B00A58C6B00A58C6B00A58C6B00BD9C6B00CEAD
      7300CEA57300BD9C6B00947B6300313131003142390063A5840063A5840063A5
      84005AA584005AA57B005A9C7B00529C7B00529C7B00529C730052B5840052C6
      84004ABD840042AD73004A84630031313100293142003163BD003163BD003163
      B5003163B5003163B5003163B5003163B5003163B5003163AD002963CE00216B
      DE002163DE002963CE00395A9400313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900D6B58400D6B58400CEAD
      8400D6AD7B00CEB58C00CEAD7B00CEAD8400CEAD8400CEAD7300CEA57300D6AD
      7300CEAD7300C6A56B00B5946B0031313100394A420073D6A50073CEA50073C6
      A5006BCE9C0073C6A50063C694006BC69C0063C694005AC68C0052BD8C005AC6
      8C0052C68C004AB57B004AA573003131310029394A002173F700317BEF00397B
      E7002173EF00427BE700296BE7003173E7003973DE00216BE7002163DE00216B
      E700216BE7002163D600315ABD00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900D6B58400E7D6BD00DED6
      C600D6B58C00EFDED600D6BD9400E7D6BD00DECEB500D6AD7B00CEA57300D6AD
      7B00D6AD7B00C6A57300B5946B0031313100394A42007BD6AD00B5E7CE00C6DE
      D6007BD6AD00CEE7DE008CCEAD00ADDEC600ADD6C6005AC694005AC6940063CE
      94005AC6940052BD84004AA573003131310029394A002173F7008CB5F700ADC6
      E700317BEF00B5CEEF005A8CE7008CB5EF0094B5E700216BE700216BE700216B
      E700216BE7002163D6003163BD00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900D6B58C00DEC6AD00D6C6
      AD00D6B58C00DECEBD00CEB59400DEC6AD00CEBDA500D6AD7B00CEAD7B00D6AD
      7B00D6AD7B00C6A57300B5946B0031313100394A42007BD6B500A5DEC600ADCE
      BD007BD6AD00B5D6C60084CEAD009CD6BD009CCEB50063CE9C0063C69C006BCE
      9C0063CE9C005ABD8C0052A57B003131310029394A00217BF70073A5EF008CAD
      DE00317BF70094B5E7004A84E70073A5EF007B9CDE00216BEF00216BE700216B
      EF00216BEF002163DE002963BD00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900D6B58C00DEC6A500D6BD
      A500D6B58C00DECEB500D6B58C00DEC6A500D6BDA500D6AD7B00CEAD7B00D6AD
      8400D6AD7B00CEA57300B5946B0031313100394A420084D6B5009CDEC600A5D6
      BD007BD6AD00ADDEC60084CEAD0094D6BD0094CEB5006BCE9C006BCE9C006BCE
      A5006BCE9C0063C6940052AD84003131310029394A00297BF7005A9CEF00739C
      E700297BF70084ADEF003984EF005A94EF006B9CE7002173EF00216BE7002173
      EF002173EF00216BDE002963C600313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900DEBD9400E7D6BD00DED6
      C600DEBD9400EFDED600D6BD9C00E7D6BD00DECEBD00D6AD8400CEAD8400D6B5
      8400D6B58400CEA57B00B594730031313100394A420084DEB500BDE7D600BDDE
      CE008CDEB500CEE7DE0094D6B500B5E7CE00B5DEC6006BCEA50073CEA50073D6
      AD0073D6A50063C69C005AAD84003131310029394A00317BF7008CB5F7009CBD
      E7003984F700B5CEF7005294EF008CB5F7008CB5E7002173EF002173EF002173
      F7002173F700216BE7002963C600313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900DEBD9400DECEB500D6C6
      B500DEBD9400DECEBD00CEB59C00DECEB500D6BDAD00D6B58400CEAD8400D6B5
      8C00D6B58400CEAD7B00B594730031313100394A42008CDEBD00ADDECE00B5D6
      C6008CDEBD00BDDECE008CCEB500ADDEC600A5CEBD0073D6AD007BCEAD007BD6
      AD007BD6AD006BC69C005AAD8C003131310031394A003184F7007BADEF008CAD
      DE003984F7009CBDE700528CE7007BADEF007BA5DE002173F7002173EF00217B
      F7002173F700216BE7002963C600313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A423900DEBD9C00DEC6A500DEC6
      AD00DEBD9400E7CEAD00D6BD9400DEC69C00DEBD9C00D6B58400D6B58C00D6B5
      8C00D6B58C00CEAD8400B59C730031313100394A420094DEBD009CE7C600A5DE
      C6008CDEBD00A5E7CE008CD6BD0094DEBD0094DEBD007BD6AD007BD6AD0084D6
      B5007BD6B50073CEA50063B58C003131310031394A003984F7005A94F700639C
      F7003184F700639CF7003984F7004A94F7005294F7002173F7002973EF00297B
      F700297BF7002173E700296BCE00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A424200DEC69C00E7D6C600EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFDECE00D6B58C00D6B58C00DEBD
      9400DEBD9400CEAD8400B59C730031313100394A420094DEC600BDE7D600DEEF
      E700DEEFE700D6EFE700D6EFE700D6EFE700CEEFDE007BD6B50084D6B5008CDE
      BD0084DEB5007BCEAD006BB594003131310031394A00428CF70094BDF700C6D6
      F700C6D6F700C6D6F700C6D6F700BDD6F700ADC6F700297BF700297BEF003184
      F700297BF7002973EF00296BCE00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A424200DEC6A500E7DECE00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7DE00D6B58C00D6B59400DEBD
      9C00DEBD9400CEAD8C00B59C7B0031313100394A42009CDEC600CEE7DE00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00DEE7E70084D6B5008CD6B5008CDE
      BD008CDEBD007BCEAD006BB594003131310031394A00428CF700ADC6EF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00D6DEEF00297BF700317BEF003984
      F7003184F7002973EF00296BCE00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A424200DEC6A500DECEAD00DECE
      B500DECEB500DECEAD00DEC6AD00DEC6AD00DEC6A500DEBD9400D6BD9400DEBD
      9C00DEBD9C00CEB58C00B59C7B0031313100424A42009CE7CE00A5DECE00ADDE
      CE00ADDECE00ADDECE00A5DECE00A5DEC600A5DEC6008CDEBD008CD6BD0094DE
      C60094DEC60084D6B50073B59C003131310031394A004A8CF700639CF70073A5
      EF0073A5EF006BA5EF006B9CEF006B9CEF00639CEF003184F7003984EF00398C
      F7003984F700317BEF00296BCE00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A424200C6AD9400BDAD9400BDAD
      9400BDAD9400BDAD8C00BDA58C00BDA58C00BDA58C00BDA58400CEB59400DEC6
      A500DEC69C00CEB59400A58C730031313100424A42008CC6B5008CC6B5008CC6
      AD008CBDAD0084BDAD0084BDAD0084BDA50084BDA5007BBDA5008CCEBD009CDE
      C60094DEC6008CCEB5006BA58C003131310031394A005284D6004A84D6004A84
      D6004A7BD600427BD600427BD600427BD600427BCE003973CE004284E700428C
      F700428CF700397BE700396BB500313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5948400C6AD
      9400C6AD9400AD9C840042393900000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007BA594008CC6
      B5008CC6AD007BAD9C0039423900000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005273AD004A84
      D6004A84D6004A73BD0039394200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF00008001800180010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFC1FFC1FFC10000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object cdsDtaPerEnt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsDtaPerEntBeforePost
    Left = 613
    Top = 221
    object cdsDtaPerEntMARCAD: TBooleanField
      FieldName = 'MARCAD'
    end
    object cdsDtaPerEntSEMANA: TStringField
      FieldName = 'SEMANA'
    end
    object cdsDtaPerEntHRAINI: TTimeField
      FieldName = 'HRAINI'
    end
    object cdsDtaPerEntHRAFIN: TTimeField
      FieldName = 'HRAFIN'
    end
    object cdsDtaPerEntHRAIN2: TTimeField
      FieldName = 'HRAIN2'
    end
    object cdsDtaPerEntHRAFI2: TTimeField
      FieldName = 'HRAFI2'
    end
    object cdsDtaPerEntHRAIN3: TTimeField
      FieldName = 'HRAIN3'
    end
    object cdsDtaPerEntHRAFI3: TTimeField
      FieldName = 'HRAFI3'
    end
    object cdsDtaPerEntDAYOFW: TIntegerField
      FieldName = 'DAYOFW'
    end
  end
  object dtsDtaPerEnt: TDataSource
    DataSet = cdsDtaPerEnt
    Left = 658
    Top = 181
  end
  object cdsCadSco: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 225
    Top = 255
    object cdsCadScoAUTOINCREM: TStringField
      DisplayLabel = 'Autoincrem'
      FieldName = 'AUTOINCREM'
    end
    object cdsCadScoSCO_CODCLI: TStringField
      DisplayLabel = 'C'#243'digo Cliente'
      FieldName = 'SCO_CODCLI'
      Size = 8
    end
    object cdsCadScoSCO_NOMSCO: TStringField
      DisplayLabel = 'Nome do S'#243'cio'
      FieldName = 'SCO_NOMSCO'
      Size = 40
    end
    object cdsCadScoSCO_PF_PJ_: TStringField
      DisplayLabel = '1 - CNPJ / 2 - CPF'
      FieldName = 'SCO_PF_PJ_'
      Size = 1
    end
    object cdsCadScoSCO_CPFCNP: TStringField
      DisplayLabel = '1 - CNPJ / 2 - CPF'
      FieldName = 'SCO_CPFCNP'
      Size = 18
    end
    object cdsCadScoSCO_NUM_RG: TStringField
      DisplayLabel = 'RG'
      FieldName = 'SCO_NUM_RG'
      Size = 15
    end
    object cdsCadScoSCO_DTANAS: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'SCO_DTANAS'
    end
    object cdsCadScoSCO_ESTCIV: TStringField
      DisplayLabel = 'Estado Civil'
      FieldName = 'SCO_ESTCIV'
      Size = 1
    end
    object cdsCadScoSCO_PER_PS: TFloatField
      DisplayLabel = 'Participa'#231#227'o (%)'
      FieldName = 'SCO_PER_PS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsCadSco: TDataSource
    DataSet = cdsCadSco
    Left = 277
    Top = 255
  end
  object dtsCadQualificacao: TDataSource
    DataSet = cdsCadQualificacao
    Left = 918
    Top = 268
  end
  object cdsCadQualificacao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 864
    Top = 267
    object StringField6: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField7: TStringField
      FieldName = 'QUA_CODQUA'
    end
    object cdsCadQualificacaoQUA_DESQUA: TBlobField
      FieldName = 'QUA_DESQUA'
      BlobType = ftMemo
    end
    object cdsCadQualificacaoCLI_QUACER: TStringField
      FieldName = 'QUA_CERQUA'
      Size = 1
    end
    object cdsCadQualificacaoQUA_CODCLI: TStringField
      FieldName = 'QUA_CODCLI'
      Size = 8
    end
    object cdsCadQualificacaoAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsCadQualificacaoQUA_OBSQUA: TBlobField
      FieldName = 'QUA_OBSQUA'
      BlobType = ftMemo
    end
  end
  object cdsCliDep: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliDep'
    Left = 809
    Top = 197
    object cdsCliDepAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCliDepDEP_CODDEP: TStringField
      FieldName = 'DEP_CODDEP'
    end
    object cdsCliDepDEP_DESCRI: TStringField
      FieldName = 'DEP_DESCRI'
      ProviderFlags = []
      Size = 100
    end
    object cdsCliDepDEP_CODCLI: TStringField
      FieldName = 'DEP_CODCLI'
    end
  end
  object qryCliDep: TUniQuery
    Connection = frmModulo.Database
    Left = 857
    Top = 196
  end
  object dtsCliDep: TDataSource
    DataSet = cdsCliDep
    Left = 857
    Top = 244
  end
  object dspCliDep: TUniDataSetProvider
    DataSet = qryCliDep
    Options = []
    Left = 809
    Top = 244
  end
  object cdsEmpresaPrioridade: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 924
    Top = 181
    object cdsEmpresaPrioridadeAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsEmpresaPrioridadeCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsEmpresaPrioridadeCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEmpresaPrioridadeNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 80
    end
  end
  object dtsEmpresaPrioridade: TDataSource
    DataSet = cdsEmpresaPrioridade
    Left = 972
    Top = 181
  end
  object ImageSefaz: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 14156332
    ImageInfo = <
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300DC7D
          4700D35C1800D55D1800D35C1800D15B1700D35C1800C3551600F1AA8100CA58
          1700D55D1800D35C1800D35C1800D35C1800F0A17300A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300DA7B4400DC60
          1900D35C1800E9783700F9DDCD00E9793900C6561600F1AB8300FDF2EC00EF9C
          6C00CF5A1700DC601900DC601900DC601900DC601900F5C2A500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E76A2200D15B
          1700EA7E4000DA5F1800E3631900FAE2D400FBE8DD00C1541600FBE5D800FAE2
          D400E8722E00D15B1700DA5F1800DA5F1800DA5F1800F1AB8200C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300FFFFFF00FFFF
          FF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F1A87E00CE5A
          1700F8D4BF00E76B2400EC8D5600E9773600F9DAC800CA581700FDF1EA00FDF1
          EA00FADFCF00E76C2500D55D1800DC601900DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300FFFFFF00FFFF
          FF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F0A17300F7CE
          B700F6C8AD00E76A2200F9DBC900EA7D3F00C1541600FDF3ED00FDF1EA00FDF1
          EA00FCEEE600FDF1EA00F9D9C600E7692000DC601900F1AB8300C3C3C300FFFF
          FF00C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300FFFFFF00EF9F7100F4BB
          9B00F8D6C200E76D2700F5BFA000E9793900C3551600FDF2EC00FBE8DD00FCEB
          E100FDF2EC00FCEDE400FDF2EC00EF9F7100DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C8571600D75E
          1800D35C1800DC601900D15B1700E1621900F7D0B900CE5A1700E9773600E977
          3600C6561600FDF2EC00FDF1EA00FAE0D100D35C1800F1AB8300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300D15B1700CC59
          1700E76D2700CE5A1700F3B79500FDF2EC00F6C8AE00DE611900EC8A5100ED90
          5B00ED935F00FDF1EA00FCEEE600FDF1EA00E1621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00CE5A1700EC8A
          5200FBE5D800F1A97F00FDF2EC00FDF1EA00F8D3BD00DC601900EE986600E062
          1900C3551600FDF2EC00FCEDE400FCEEE600F5C2A400F1A87E00C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3551600FDF2
          EC00FCEDE400FCEEE600FCEDE400FCEDE400FDF1EA00E9753200E5631900CC59
          1700EE966400FCEFE800FCEDE400FCEDE400FDF2EC00F0A57900C3C3C300FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300D15B1700CF5A
          1700FCEBE100FCEFE800FCEDE400FCEDE400FCEDE400FDF1EA00FDF2EC00FDF2
          EC00FDF1EA00FDF1EA00FCEFE800FBE8DD00DA5F1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00D15B1700CE5A
          1700FAE1D200FDF1EA00FCEDE400FCEDE400FCEDE400FCEDE400FBE9DF00F6C6
          AB00FCEDE400F6C5A900EB824600E8702B00D85E1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300D35C1800D55D
          1800F6CAB000F2AE8700F9DCCB00FCEDE400F8D1BB00FCEFE800FDF2EC00E977
          3600CA581700DA5F1800E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300D35C1800E062
          1900DE611900D55D1800F4BB9B00FBE6DA00E8712D00ED905A00F2AE8700E76A
          2200D85E1800E1621900E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E0804900E162
          1900E1621900E1621900D75E1800E0621900E1621900E1621900DE611900E162
          1900E0621900E0621900E0621900E0621900E1621900F6C8AD00C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300EE95
          6100E5631900E5631900E5631900E5631900E5631900E5631900E5631900E563
          1900E5631900E5631900E5631900E5631900F4B99700A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300}
        MaskColor = 10766755
      end
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000679C36FFA386
          3BFF4CB122FF65A625FF7EA030FF58AC24FF52AD22FF779F2DFF93AA4BFF7F9E
          2FFF4CB122FF4CB122FF4CB122FF4CB122FF759F31FFA2688EFFAB64A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC8C8C8FFC4C4C4FFC3C3C3FFC3C3C3FFC8C8C8FFC4C4
          C4FFC3C3C3FFC3C3C3FFC3C3C3FFC8C8C8FFE4DBE4FFB26EB1FFA68638FF5AA9
          25FF4CB122FFBC8936FFEBA77EFFCE9553FFAE893BFFD29C65FFF4D0BCFFE8A1
          75FF92912BFF4CB122FF4CB122FF4CB122FF7D9F2DFFD3A989FFC6B5B9FFC2C1
          C2FFC3C3C3FFC7C7C7FFE2E2E2FFD0D0D0FFCBCBCBFFC9C9C9FFE9E9E9FFD0D0
          D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFC0B7C0FF62AA28FF68A3
          24FF88A034FF5DAA25FFB38D34FFDAC194FFEAC5AAFFCE7D4AFFF2CFBBFFF6D1
          BCFFCC9651FF58AC24FF4CB122FF4CB122FF61A926FFA3A954FFC9BFB8FFC3C3
          C3FFC8C8C8FFC4C4C4FFCCCCCCFFEAEAEAFFEFEFEFFFD0D0D0FFF3F3F3FFF3F3
          F3FFD0D0D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF94A23FFFD480
          47FF9BA749FFC58A3AFFAD9C43FF6DB036FFDAB386FFC98D54FFF4DACAFFFBEB
          E2FFF3CFB6FFCC9651FFB68735FF63A624FF61A926FF77A733FFCABFB9FFCECE
          CEFFE3E3E3FFC9C9C9FFCACACAFFCECECEFFE8E8E8FFD6D6D6FFF6F6F6FFFEFE
          FEFFF3F3F3FFD2D2D2FFCBCBCBFFC4C4C4FFC3C3C3FFCBCBCBFF7BAB39FF4CB1
          22FF74AC35FFD38C46FFF1B38FFFC39146FFAE8C40FFF0D1BEFFFAEDE3FFFCEE
          E7FFFBEBE1FFF9DFD0FFF3C5AAFF9E9C3BFF61A926FF77A833FFCEC3BDFFE5E5
          E5FFD3D3D3FFCACACAFFE8E8E8FFCACACAFFCDCDCDFFF1F1F1FFFDFDFDFFFFFF
          FFFFFEFEFEFFF8F8F8FFF1F1F1FFCACACAFFC7C7C7FFE9E9E9FFDE965FFFBAA6
          5EFFC2AB6AFFDF8040FFDFA16DFF7CA430FFB48C43FFEFC8B3FFF6D6C3FFF7D7
          C5FFF5D9CAFFFAEAE1FFFAE5D9FFEBA579FFA98A2EFF77A733FFCABFB9FFCCCC
          CCFFE2E2E2FFCDCDCDFFE6E6E6FFCACACAFFCFCFCFFFEFEFEFFFF4F4F4FFF4F4
          F4FFF5F5F5FFFDFDFDFFF9F9F9FFD1D1D1FFC4C4C4FFC8C8C8FF55AC22FF968E
          29FFA2882CFF61A623FFB3802DFFCA8943FFDAAD7DFFA4933CFFBD8C3CFF969C
          37FFCB864CFFF6DFD1FFFBEDE5FFF4CEB8FFCD7D3AFF77A733FFC9BEB8FFC3C3
          C3FFC7C7C7FFC4C4C4FFC8C8C8FFCECECEFFE4E4E4FFCECECEFFC9C9C9FFC9C9
          C9FFCECECEFFF7F7F7FFFEFEFEFFF2F2F2FFCBCBCBFFC9C9C9FF4CB122FF8394
          26FFBE8A39FFB78637FFDDB083FFF4D8C4FFE2C49EFF62AE2EFF66A626FF4CB1
          22FF81AB40FFF8E1D3FFFBEDE5FFF8DFD0FFD68F50FF76AA33FFC9BEB8FFC3C3
          C3FFC9C9C9FFC4C4C4FFCFCFCFFFECECECFFD7D7D7FFC5C5C5FFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFF8F8F8FFD8D8D8FFE8E8E8FF63A726FFA0A4
          4AFFF4C7ABFFF0B693FFF8DFD1FFFBECE2FFE8CEAEFF6CAC31FF6AA627FF5BAB
          25FF87A23CFFF5DCCFFFFCEDE4FFFAE7DCFFE5C29CFFBCAF6CFFCABEB7FFCECE
          CEFFEAEAEAFFD5D5D5FFF0F0F0FFFCFCFCFFF2F2F2FFCACACAFFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFFDFDFDFFF3F3F3FFCFCFCFFF6FA731FFEDBF
          A5FFF9E5D9FFFAE6DBFFFBEBE2FFFCECE3FFF7E0D0FFD29D5DFFCB8B41FFB48E
          41FFDDA473FFF9E3D7FFFBECE3FFFAE8DEFFF5D1BDFFC2B072FFCEC2BBFFE9E9
          E9FFFAFAFAFFF9F9F9FFFDFDFDFFFFFFFFFFF9F9F9FFD3D3D3FFCCCCCCFFCCCC
          CCFFD2D2D2FFF7F7F7FFFFFFFFFFFDFDFDFFF1F1F1FFD1D1D1FF60A522FFC582
          40FFF4D5C2FFFBEDE5FFFCEDE4FFFCEDE4FFFBEBE2FFF9E2D5FFF8DED1FFF6DB
          CCFFF9E3D7FFFAE8DDFFF9E0D2FFF4CCB5FFCF8C4BFFA9A957FFCABFB8FFCECE
          CEFFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF8F8F8FFF7F7F7FFF7F7
          F7FFF8F8F8FFFCFCFCFFF8F8F8FFF0F0F0FFD4D4D4FFEAEAEAFF4CB122FFA08A
          2FFFF1C8B0FFFAE4D7FFFBE9DEFFFBEBE2FFFBE8DEFFFBEBE3FFFAE5DAFFF4C6
          ABFFF3CDB7FFF0B695FFCF9957FF82A637FF799E28FF61A926FFC9BEB8FFC9C9
          C9FFF3F3F3FFF6F6F6FFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFF5F5
          F5FFF4F4F4FFEFEFEFFFD0D0D0FFC9C9C9FFC4C4C4FFC8C8C8FF4CB122FF978E
          2AFFE6AC82FFE8B38BFFF6D3BFFFFAE4D8FFF6CFB9FFF9DECFFFF8D9C8FFD193
          52FFAD8532FFA4892BFF4CB122FF4CB122FF61A926FF61A926FFC9BEB8FFC8C8
          C8FFE8E8E8FFD5D5D5FFF5F5F5FFFDFDFDFFF8F8F8FFF6F6F6FFF1F1F1FFCFCF
          CFFFC9C9C9FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF4CB122FF56AB
          22FF6BA72AFFAD8830FFECA67FFFF3C1A5FFE88A52FF91A843FFDBA16AFF6AA8
          29FF4CB122FF4CB122FF4CB122FF4CB122FF61A926FFA9AB5CFFCABFB9FFC3C3
          C3FFC7C7C7FFC8C8C8FFECECECFFEFEFEFFFD0D0D0FFC9C9C9FFC8C8C8FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFCBCBCBFFA38B39FF6EA3
          27FF4CB122FF4CB122FFA48728FFA78C2EFF4CB122FF4CB122FF909225FF4CB1
          22FF4CB122FF4CB122FF4CB122FF4CB122FF84A135FFE3A898FFC5B4BAFFC2C0
          C2FFC3C3C3FFC3C3C3FFC7C7C7FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFE5DBE5FF66A133FF859C
          34FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB1
          22FF4CB122FF4CB122FF4CB122FF929428FFCE996CFFB563A0FFAB63A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC0B7C0FFB16BB0FF000000000000
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
      end>
  end
  object cdsCliBen: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 87
    Top = 379
    object cdsCliBenBEN_CODCLI: TStringField
      FieldName = 'BEN_CODCLI'
      Size = 8
    end
    object cdsCliBenBEN_CODCST: TStringField
      FieldName = 'BEN_CODCST'
      Size = 3
    end
    object cdsCliBenBEN_CODBEN: TStringField
      FieldName = 'BEN_CODBEN'
      Size = 10
    end
  end
  object dtsCliBen: TDataSource
    DataSet = cdsCliBen
    Left = 88
    Top = 425
  end
  object frxHelpLimCred: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 256
    PrintOptions.PrintPages = ppEven
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 45247.710909166700000000
    ReportOptions.LastChange = 45247.710909166700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 356
    Top = 513
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo1: TfrxMemoView
        Left = 1.000000000000000000
        Top = 12.000000000000000000
        Width = 715.000000000000000000
        Height = 26.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'Regras de C'#225'lculo para Limite de Cr'#233'dito')
        ParentFont = False
      end
      object Memo2: TfrxMemoView
        Left = 2.000000000000000000
        Top = 58.000000000000000000
        Width = 714.000000000000000000
        Height = 40.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Neste documento ser'#227'o apresentadas as regras utilizadas para a a' +
            'tribui'#231#227'o de limite de cr'#233'dito autom'#225'tico, tanto para novos clie' +
            'ntes (inser'#231#227'o), como tamb'#233'm na altera'#231#227'o de um j'#225' exist'#234'nte.')
        ParentFont = False
      end
      object Memo4: TfrxMemoView
        Left = 2.000000000000000000
        Top = 150.000000000000000000
        Width = 715.220470000000000000
        Height = 55.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'A altera'#231#227'o do limite de cr'#233'dito poder'#225' ser realizada atrav'#233's do' +
            ' bot'#227'o "Atualizar Limite de Cr'#233'dito", exibido ao lado do campo. ' +
            'Nas tabelas abaixo ser'#227'o apresentadas as vari'#225'veis e regras util' +
            'izadas, bem como os c'#225'lculos propriamente ditos.')
        ParentFont = False
      end
      object Memo5: TfrxMemoView
        Left = 1.000000000000000000
        Top = 118.000000000000000000
        Width = 715.000000000000000000
        Height = 21.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haBlock
        Memo.UTF8W = (
          'Altera'#231#227'o:')
        ParentFont = False
      end
      object Memo7: TfrxMemoView
        Left = 13.000000000000000000
        Top = 277.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Consulta_Valida')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo8: TfrxMemoView
        Left = 13.000000000000000000
        Top = 251.000000000000000000
        Width = 133.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Vari'#225'veis')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo9: TfrxMemoView
        Left = 146.000000000000000000
        Top = 251.000000000000000000
        Width = 560.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valores')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo10: TfrxMemoView
        Left = 146.000000000000000000
        Top = 277.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"S" quando a "Data de Consulta" da aba "Dados de Cobran'#231'a" n'#227'o e' +
            'stiver expirada ou "N" quando estiver expirada ou n'#227'o preenchida')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo11: TfrxMemoView
        Left = 13.000000000000000000
        Top = 349.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Qualidade_Serasa')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo12: TfrxMemoView
        Left = 146.000000000000000000
        Top = 349.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"BOM" quando os campos "qtd.Protesto", "Cheque Devolvidos" e "Pe' +
            'rfin" forem iguais a 0 ou "RUIM" quando algum deles for maior qu' +
            'e 0')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo13: TfrxMemoView
        Left = 13.000000000000000000
        Top = 421.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Media_Atraso')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo14: TfrxMemoView
        Left = 146.000000000000000000
        Top = 421.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            'M'#233'dia da quantidade de dias em atraso de t'#237'tulos j'#225' pagos, consi' +
            'derando a configura'#231#227'o "CFG_MEDCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo15: TfrxMemoView
        Left = 13.000000000000000000
        Top = 493.000000000000000000
        Width = 133.000000000000000000
        Height = 44.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Meses_Venda')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo16: TfrxMemoView
        Left = 146.000000000000000000
        Top = 493.000000000000000000
        Width = 560.000000000000000000
        Height = 44.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valor da configura'#231#227'o "CFG_MESCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo17: TfrxMemoView
        Left = 13.000000000000000000
        Top = 537.000000000000000000
        Width = 133.000000000000000000
        Height = 48.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Meses_Cadastro')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo18: TfrxMemoView
        Left = 146.000000000000000000
        Top = 537.000000000000000000
        Width = 560.000000000000000000
        Height = 48.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            'Quantidade de meses entre a data de cadastro do cliente e data a' +
            'tual')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo19: TfrxMemoView
        Left = 13.000000000000000000
        Top = 585.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Limite_Sugerido')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo20: TfrxMemoView
        Left = 146.000000000000000000
        Top = 585.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            'Somat'#243'rio das vendas recebidas nos '#250'ltimos meses (conforme confi' +
            'gurado em "CFG_MESCRE", considerando o m'#234's atual), dividido pela' +
            ' quantidade indicada em "CFG_MESCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo21: TfrxMemoView
        Left = 13.000000000000000000
        Top = 657.000000000000000000
        Width = 133.000000000000000000
        Height = 48.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Limite_Atual')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo22: TfrxMemoView
        Left = 146.000000000000000000
        Top = 657.000000000000000000
        Width = 560.000000000000000000
        Height = 48.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valor atual do campo "Limite de Cr'#233'dito"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo24: TfrxMemoView
        Left = 13.000000000000000000
        Top = 750.000000000000000000
        Width = 478.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Regras')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo25: TfrxMemoView
        Left = 491.000000000000000000
        Top = 750.000000000000000000
        Width = 215.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valor do Limite de Cr'#233'dito')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo26: TfrxMemoView
        Left = 13.000000000000000000
        Top = 776.000000000000000000
        Width = 211.000000000000000000
        Height = 202.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Consulta_Valida" = "S" '
          ''
          '"Qualidade_Serasa" = "BOM" '
          ''
          '"Media_Atraso" <= ao indicado na configura'#231#227'o "CFG_MEDCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo27: TfrxMemoView
        Left = 491.000000000000000000
        Top = 776.000000000000000000
        Width = 215.000000000000000000
        Height = 52.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Limite_Sugerido"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo23: TfrxMemoView
        Left = 224.000000000000000000
        Top = 776.000000000000000000
        Width = 267.000000000000000000
        Height = 52.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Meses_Cadastro" > que o indicado na configura'#231#227'o "CFG_MESCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo28: TfrxMemoView
        Left = 224.000000000000000000
        Top = 828.000000000000000000
        Width = 267.000000000000000000
        Height = 76.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"Meses_Cadastro" < que o indicado na configura'#231#227'o "CFG_MESCRE" e' +
            ' "Limite_Sugerido" < "Limite_Atual"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo29: TfrxMemoView
        Left = 224.000000000000000000
        Top = 904.000000000000000000
        Width = 267.000000000000000000
        Height = 74.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"Meses_Cadastro" < que o indicado na configura'#231#227'o "CFG_MESCRE" e' +
            ' "Limite_Sugerido" > "Limite_Atual"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo30: TfrxMemoView
        Left = 491.000000000000000000
        Top = 828.000000000000000000
        Width = 215.000000000000000000
        Height = 76.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Limite_Sugerido" + "Limite_Atual"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo31: TfrxMemoView
        Left = 491.000000000000000000
        Top = 904.000000000000000000
        Width = 215.000000000000000000
        Height = 74.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Limite_Sugerido"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo32: TfrxMemoView
        Left = 13.000000000000000000
        Top = 978.000000000000000000
        Width = 478.000000000000000000
        Height = 62.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Consulta_Valida" = "N"  ou'
          '"Qualidade_Serasa" = "RUIM" ou'
          '"Media_Atraso" > que o indicado na configura'#231#227'o "CFG_MEDCRE"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo33: TfrxMemoView
        Left = 491.000000000000000000
        Top = 978.000000000000000000
        Width = 215.000000000000000000
        Height = 62.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Limite_Atual"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo34: TfrxMemoView
        Left = 13.000000000000000000
        Top = 722.000000000000000000
        Width = 715.220470000000000000
        Height = 29.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        HAlign = haBlock
        Memo.UTF8W = (
          'C'#225'lculo:')
        ParentFont = False
      end
      object Memo3: TfrxMemoView
        Left = 13.000000000000000000
        Top = 221.000000000000000000
        Width = 715.220470000000000000
        Height = 29.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        HAlign = haBlock
        Memo.UTF8W = (
          'Vari'#225'veis de c'#225'lculo:')
        ParentFont = False
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo6: TfrxMemoView
        Left = 1.000000000000000000
        Top = 32.000000000000000000
        Width = 715.220470000000000000
        Height = 42.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Ao confirmar o cadastro de um novo cliente, automaticamente o si' +
            'stema ir'#225' realizar a atribui'#231#227'o de limite de cr'#233'dito para o mesm' +
            'o, seguindo as regras abaixo:')
        ParentFont = False
      end
      object Memo35: TfrxMemoView
        Width = 715.000000000000000000
        Height = 21.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haBlock
        Memo.UTF8W = (
          'Inser'#231#227'o:')
        ParentFont = False
      end
      object Memo36: TfrxMemoView
        Left = 10.000000000000000000
        Top = 142.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Consulta_Valida')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo37: TfrxMemoView
        Left = 10.000000000000000000
        Top = 116.000000000000000000
        Width = 133.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Vari'#225'veis')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo38: TfrxMemoView
        Left = 143.000000000000000000
        Top = 116.000000000000000000
        Width = 560.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valores')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo39: TfrxMemoView
        Left = 143.000000000000000000
        Top = 142.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"S" quando a "Data de Consulta" da aba "Dados de Cobran'#231'a" n'#227'o e' +
            'stiver expirada ou "N" quando estiver expirada ou n'#227'o preenchida')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo40: TfrxMemoView
        Left = 10.000000000000000000
        Top = 214.000000000000000000
        Width = 133.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Qualidade_Serasa')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo41: TfrxMemoView
        Left = 143.000000000000000000
        Top = 214.000000000000000000
        Width = 560.000000000000000000
        Height = 72.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          
            '"BOM" quando os campos "qtd.Protesto", "Cheque Devolvidos" e "Pe' +
            'rfin" forem iguais a 0 ou "RUIM" quando algum deles for maior qu' +
            'e 0')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo42: TfrxMemoView
        Left = 10.000000000000000000
        Top = 86.000000000000000000
        Width = 715.220470000000000000
        Height = 29.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        HAlign = haBlock
        Memo.UTF8W = (
          'Vari'#225'veis de c'#225'lculo:')
        ParentFont = False
      end
      object Memo43: TfrxMemoView
        Left = 10.000000000000000000
        Top = 341.000000000000000000
        Width = 478.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Regras')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo44: TfrxMemoView
        Left = 488.000000000000000000
        Top = 341.000000000000000000
        Width = 215.488250000000000000
        Height = 25.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valor do Limite de Cr'#233'dito')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo45: TfrxMemoView
        Left = 10.000000000000000000
        Top = 367.000000000000000000
        Width = 478.000000000000000000
        Height = 58.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Consulta_Valida" = "S" '
          '"Qualidade_Serasa" = "BOM" ')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo46: TfrxMemoView
        Left = 488.000000000000000000
        Top = 367.000000000000000000
        Width = 215.000000000000000000
        Height = 58.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'Valor configurado em "CFG_LIMCRN"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo47: TfrxMemoView
        Left = 10.000000000000000000
        Top = 425.000000000000000000
        Width = 478.000000000000000000
        Height = 62.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '"Consulta_Valida" = "N"  ou'
          '"Qualidade_Serasa" = "RUIM"')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo48: TfrxMemoView
        Left = 488.000000000000000000
        Top = 425.000000000000000000
        Width = 215.000000000000000000
        Height = 62.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          'R$ 0,00')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo49: TfrxMemoView
        Left = 10.000000000000000000
        Top = 310.000000000000000000
        Width = 715.220470000000000000
        Height = 29.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        HAlign = haBlock
        Memo.UTF8W = (
          'C'#225'lculo:')
        ParentFont = False
      end
    end
  end
  object popVazio: TPopupMenu
    Left = 476
    Top = 44
  end
  object frxHelpEmailCobranca: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 256
    PrintOptions.PrintPages = ppEven
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 45247.710909166700000000
    ReportOptions.LastChange = 45247.710909166700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 572
    Top = 505
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo1: TfrxMemoView
        Left = 1.000000000000000000
        Top = 12.000000000000000000
        Width = 715.000000000000000000
        Height = 26.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'Regras para E-mail de Cobran'#231'a')
        ParentFont = False
      end
      object Memo2: TfrxMemoView
        Left = 2.000000000000000000
        Top = 58.000000000000000000
        Width = 714.000000000000000000
        Height = 40.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Neste documento ser'#227'o apresentadas as regras utilizadas para o e' +
            '-mail de cobran'#231'a')
        ParentFont = False
      end
      object Memo4: TfrxMemoView
        Left = 2.000000000000000000
        Top = 146.220470000000000000
        Width = 715.220470000000000000
        Height = 323.346630000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Primeiro, ele verifica se o e-mail principal de cobran'#231'a ("E-Mai' +
            'l Cobran'#231'a 1") est'#225' preenchido.'
          'Se sim, usa esse e-mail.'
          ''
          'Segundo, ele verifica um segundo e-mail ("E-Mail Cobran'#231'a 2").'
          
            'Se esse e-mail estiver preenchido, ele adiciona esse e-mail ao f' +
            'inal da lista de e-mails, separando por ponto e v'#237'rgula.'
          ''
          
            'Caso os dois anteriores estejam vazios, ele verifica um terceiro' +
            ' e-mail ("E-Mail - 1").'
          'Se esse estiver preenchido, usa esse e-mail.'
          ''
          
            'Se todos os tr'#234's primeiros estiverem vazios, ele tenta um quarto' +
            ' e-mail ("E-Mail NFe 2").'
          'Se esse estiver preenchido, usa esse e-mail.'
          ''
          
            'Depois de escolher os primeiros e-mails, ele verifica se h'#225' um q' +
            'uinto e-mail ("E-Mail NFe").'
          
            'Se esse e-mail estiver preenchido, ele adiciona esse e-mail ao f' +
            'inal da lista de e-mails, separando por ponto e v'#237'rgula.'
          'Se n'#227'o houver nenhum e-mail ainda, o "E-Mail NFe" ser'#225' o '#250'nico.'
          '')
        ParentFont = False
      end
      object Memo6: TfrxMemoView
        Left = 1.779530000000000000
        Top = 105.826840000000000000
        Width = 714.000000000000000000
        Height = 28.661410000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Color = clNone
        HAlign = haBlock
        Memo.UTF8W = (
          'Quando a configura'#231#227'o CFG_GPEMCB estiver igual a (S)im')
        ParentFont = False
      end
      object Memo3: TfrxMemoView
        Left = 2.220470000000000000
        Top = 516.614410000000000000
        Width = 715.220470000000000000
        Height = 285.551330000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Primeiro, ele verifica se o e-mail principal de cobran'#231'a ("E-Mai' +
            'l Cobran'#231'a 1") est'#225' preenchido.'
          'Se sim, usa esse e-mail.'
          ''
          
            'Se esse n'#227'o estiver preenchido, ele verifica um segundo e-mail (' +
            '"E-Mail Cobran'#231'a 2").'
          'Se esse estiver preenchido, usa esse e-mail.'
          ''
          
            'Caso os dois anteriores estejam vazios, ele verifica um terceiro' +
            ' e-mail ("E-Mail - 1").'
          'Se esse estiver preenchido, usa esse e-mail.'
          ''
          
            'Se todos os tr'#234's primeiros estiverem vazios, ele tenta um quarto' +
            ' e-mail ("E-Mail NFe 2").'
          'Se esse estiver preenchido, usa esse e-mail.'
          ''
          
            'Depois de escolher o primeiro e-mail, ele verifica se h'#225' um quin' +
            'to e-mail ("E-Mail NFe").'
          
            'Se esse e-mail estiver preenchido, ele adiciona esse e-mail ao f' +
            'inal da lista de e-mails, separando por ponto e v'#237'rgula.'
          'Se n'#227'o houver nenhum e-mail ainda, o "E-Mail NFe" ser'#225' o '#250'nico.')
        ParentFont = False
      end
      object Memo5: TfrxMemoView
        Left = 2.000000000000000000
        Top = 476.220780000000000000
        Width = 714.000000000000000000
        Height = 28.661410000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Color = clNone
        HAlign = haBlock
        Memo.UTF8W = (
          'Quando a configura'#231#227'o CFG_GPEMCB estiver igual a (N)'#227'o')
        ParentFont = False
      end
    end
  end
end
