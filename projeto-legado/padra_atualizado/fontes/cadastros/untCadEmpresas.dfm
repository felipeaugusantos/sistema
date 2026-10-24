inherited frmCadEmpresas: TfrmCadEmpresas
  Left = 340
  Top = 141
  Width = 1144
  Height = 780
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Cadastro de Empresas'
  OnDestroy = FormDestroy
  ExplicitWidth = 1144
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 710
    Width = 1138
    Height = 25
    ExplicitTop = 710
    ExplicitWidth = 1138
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 1057
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 1057
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Enabled = False
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      object btnTintas: TBitBtnLocked
        Left = 435
        Top = 0
        Width = 72
        Height = 20
        Caption = '&Tintas'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnTintasClick
      end
      object btnCreditos: TBitBtnLocked
        Left = 507
        Top = 0
        Width = 73
        Height = 20
        Caption = 'Cr'#233'ditos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnCreditosClick
      end
      object btnCertificadoDigital: TBitBtnLocked
        Left = 580
        Top = 0
        Width = 120
        Height = 20
        Caption = 'Certificado &Digital'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003F372E7F7E6F5CFF3F382E800000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000433C327F867864FF433C
          3280000000000000000000000000000000000000000000000000000000010000
          0004000000060000000700000007000000070000000700000007464036838D80
          6CFF4740368203105E800620BAFF03105C800000000000000000000000040000
          000D000000130000001300000013000000130000001300000013000000134942
          398928327EC30621C0FF0620BDFF0620BAFF03105C8000000000000000061049
          8EC71560BAFF1560BAFF1560BAFF1560BAFF1560BAFF1560BAFFD0DFF1FF0E41
          C2FF0722C6FF0621C3FF0621C0FF0620BDFF0620BAFF03105C80000000071A67
          BEFF92C2E9FF8CCBF0FF86C8EFFF86C8EFFF86C8EFFF86C8EFFFEAF6FCFF0723
          CCFF0722CAFF0722C7FF0310627F0310607F0620BEFF0620BBFF000000071F6E
          C3FF94D1F2FF62BCECFF61BBECFF61BBECFFB0DDF6FFB8E0F7FFD6EDFAFF587F
          E2FF0723CDFF0722CAFF0311637F0310627F0621C1FF03105F7F000000072577
          C9FF98D6F4FF70C6EFFF77C9F0FF3D3231FF3D3231FFBCE5F8FF8ED2F3FFE4F4
          FCFF2C5BD2FF0723CDFF0723CAFF0722C8FF0311627F00000000000000072A7F
          CFFFA7E0F7FF93D9F5FFA5DFF7FF563A35FF563A35FFA7E0F7FF98DBF6FFBAE7
          F9FFC7DDF2FF111F758F0723CDFF0311657F0000000000000000000000062F86
          D4FFC0ECFAFFB9EAFAFFC0ECFAFFC2ECFAFFC2ECFAFFC1ECFAFFBBEBFAFFC5ED
          FBFF4391D8FF000000060000000000000000000000000000000000000004348D
          D8FFC4E5F7FFD9F4FCFFD7F4FDFFD7F4FDFFD7F4FDFFD7F4FDFFD9F4FCFFC7E6
          F8FF348DD8FF0000000400000000000000000000000000000000000000012A6E
          A7C53791DBFF3791DBFF3791DBFF3791DBFF3791DBFF3791DBFF3791DBFF3791
          DBFF2A6EA7C50000000100000000000000000000000000000000000000000000
          00046F5951F2F0E1D2FF826C62FF1F1916531F191653816B61FFE7D7C8FF705A
          51F4000000040000000000000000000000000000000000000000000000000000
          00024F403AB0C0AFA2FFD3C3B5FF826C62FF826B62FFCFBEB0FFB8A498FF4F40
          3AB0000000020000000000000000000000000000000000000000000000000000
          0000120E0D29715B53F0C1AFA2FFF0E1D2FFEEE0D0FFBEAB9FFF715B53F0120E
          0D29000000000000000000000000000000000000000000000000000000000000
          000000000000110E0C2750403AAE6F5950F16F5950F150403AAE110E0C270000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 8
        OnClick = btnCertificadoDigitalClick
      end
      object btnENotas: TBitBtnLocked
        Left = 700
        Top = 0
        Width = 90
        Height = 20
        Caption = 'eNotas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00080000001E0000002700000028000000290000002A0000002B0000002C0000
          002C0000002D0000002E0000002F000000250000000A00000000000000000000
          001BB1713EFFB3723FFFB37340FFB47441FFB57643FFB67744FFB77846FFB879
          47FFB87B49FFBA7C49FFBB7E4CFFBC7F4DFF0000002400000000000000000000
          0020B47441FFF7E7D7FFF7E7D8FFF7E8D9FFF8E8DAFFF8E9DBFFF8EADCFFF8EA
          DDFFF9EBDEFFF9ECDFFFF9EDE0FFBE8351FF0000002D00000000000000000000
          001DB67744FFF9EBDDFFF9EBDDFFF9ECDEFFFAEDE0FFFAEDE0FFFAEEE1FFFBEF
          E2FFFBEFE4FFFBF1E5FFFCF1E6FFC18756FF0000002B00000000000000000000
          001BB87B48FFFBEEE1FFFBEEE2FFFCF0E3FFFCF0E5FFFCF1E6FFFDF2E7FFFDF2
          E9FFFDF3E9FFFDF4EBFFFEF4EBFFC48A5AFF0000002900000000000000000000
          0018BB7E4BFFFCEFE3FFFDF3E8FFFEF3E9FFFEF5EAFFFEF5ECFFFEF6ECFFFEF7
          EEFFFFF7EFFFFFF7F0FFFFF9F2FFC78F5EFF0000002600000000000000000000
          0015BE814FFFFBEFE3FFFDF3E9FFFFF6EEFFFFF7EFFFFFF8F0FFFFF8F1FFFFF9
          F1FFFFF9F2FFFFF9F3FFFFFAF4FFCA9362FF0000002400000000000000000000
          0012C18554FFFAEDE0FFFCF1E6FFFEF5ECFFFFF9F1FFFFF9F2FFFFF9F3FFFFFA
          F3FFFFFAF4FFFFFAF5FFFFFAF6FFCD9667FF0000002200000000000000000000
          000FC38958FFF7E8D9FFFAEDE1FFFCF2E8FFFEF7F0FFFFF9F3FFFFFAF5FFFFFA
          F4FFFFFAF5FFFFFBF6FFFFFBF6FFCF9B6CFF0000001F00000000000000000000
          000DC78D5CFFF5E2D1FFF7E8DBFFFAEFE3FFFCF3EBFFFEF7F1FFFFFBF6FFE6E2
          DFFFCFCCC9FFE6E2E0FFFFFCF8FFD29F70FF0000001C00000000000000000000
          000AC99161FFF0DAC6FFF4E1D0FFF6E7DAFFFAEFE4FFFCF4ECFFAC9788FF5536
          24FF9D8D83FFD0CECBFFFFFDFAFFD5A375FF0000001A00000000000000000000
          0005CC9565FFCE9768FFCF9869FFD09A6BFFF7EBDFFFFAF0E7FF6B472EFFC0B9
          B4FF593B29FFCFCDCCFFFFFDFBFFD9A77AFF0000001700000000000000000000
          0001130F0C1EB08B6BD9FFFCF9FFD29E6FFFF5E6D8FFF7EADFFF734C2DFFCDC8
          C3FF644027FFFFFEFBFFFFFEFDFFDBAB7FFF0000001400000000000000000000
          000000000001130F0C1CB08A6CD8D5A274FFF2E0D0FFF4E5D7FF805431FFCCC5
          BFFFF4EFE9FFFEFBF8FFFFFEFCFFDDAF83FF0000001100000000000000000000
          00000000000000000001130F0C1CD8A679FFD8A87BFFDAAA7DFF8E6238FFBB91
          68FFB38D6AFFC99F76FFDFB185FFE0B387FF0000000B00000000000000000000
          00000000000000000000000000000000000200000003000000044F361D869667
          39FF4C351D870000000800000009000000080000000300000000}
        TabOrder = 9
        Visible = False
        OnClick = btnENotasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1059
      Height = 21
      Align = alRight
      ExplicitLeft = 1059
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 735
    Width = 1138
    ExplicitTop = 735
    ExplicitWidth = 1138
    inherited pnlNomeForm: TPanel
      Left = 880
      Width = 258
      ExplicitLeft = 880
      ExplicitWidth = 258
    end
    inherited pnlInfo: TPanel
      Width = 880
      ExplicitWidth = 880
    end
  end
  inherited pgcDados: TPageControl
    Width = 1138
    Height = 710
    OnChange = pgcDadosChange
    ExplicitWidth = 1138
    ExplicitHeight = 710
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1130
      ExplicitHeight = 678
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 1130
        Height = 678
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 100
          Top = 9
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 70
          Top = 32
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Raz'#227'o Social:'
        end
        object Label3: TLabel
          Left = 87
          Top = 78
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label4: TLabel
          Left = 461
          Top = 78
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object Label5: TLabel
          Left = 356
          Top = 101
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label6: TLabel
          Left = 69
          Top = 101
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label7: TLabel
          Left = 100
          Top = 124
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label9: TLabel
          Left = 469
          Top = 124
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label11: TLabel
          Left = 106
          Top = 279
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail:'
        end
        object Label12: TLabel
          Left = 80
          Top = 325
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Home Page:'
        end
        object Label13: TLabel
          Left = 46
          Top = 210
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Inscri'#231#227'o Estadual:'
        end
        object Label15: TLabel
          Left = 83
          Top = 148
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 1:'
        end
        object Label16: TLabel
          Left = 260
          Top = 148
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 2:'
        end
        object Label17: TLabel
          Left = 468
          Top = 147
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'FAX:'
        end
        object Label10: TLabel
          Left = 352
          Top = 124
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label8: TLabel
          Left = 17
          Top = 371
          Width = 119
          Height = 14
          Alignment = taRightJustify
          Caption = 'Utilizar pre'#231'os da Matriz:'
        end
        object ColorLabel2: TColorLabel
          Left = 168
          Top = 371
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label18: TLabel
          Left = 79
          Top = 348
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente Filial:'
        end
        object Label21: TLabel
          Left = 78
          Top = 394
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 35
          Top = 302
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail Depto Vendas:'
        end
        object Label30: TLabel
          Left = 226
          Top = 256
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Reg.Junta Com.:'
        end
        object Label31: TLabel
          Left = 453
          Top = 256
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despacho:'
        end
        object Label32: TLabel
          Left = 57
          Top = 498
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Usar Replicador:'
        end
        object ColorLabel5: TColorLabel
          Left = 168
          Top = 498
          Width = 133
          Height = 14
          Caption = '(S)im (N)'#227'o (P)arcialmente  '
          CorDestaque = clRed
        end
        object Label33: TLabel
          Left = 317
          Top = 498
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'IP Principal:'
        end
        object Label34: TLabel
          Left = 399
          Top = 9
          Width = 77
          Height = 14
          Cursor = crHandPoint
          Alignment = taRightJustify
          Caption = 'Cor de Fundo 1:'
          FocusControl = dbeCorFun
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = Label34Click
        end
        object lblNomFan: TLabel
          Left = 62
          Top = 55
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome Fantasia:'
        end
        object Label43: TLabel
          Left = 231
          Top = 9
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sigla da Empresa:'
        end
        object Label46: TLabel
          Left = 373
          Top = 233
          Width = 60
          Height = 14
          Alignment = taRightJustify
          Caption = 'Insc. Munic.:'
        end
        object Label47: TLabel
          Left = 75
          Top = 256
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'CNAE Fiscal:'
        end
        object lblCodMat: TLabel
          Left = 254
          Top = 371
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa Matriz:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label41: TLabel
          Left = 76
          Top = 417
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Imprime CTP:'
        end
        object ColorLabel6: TColorLabel
          Left = 168
          Top = 417
          Width = 61
          Height = 14
          Caption = '(S)im (N)'#227'o  '
          CorDestaque = clRed
        end
        object LabelCgc1: TLabelCgc
          Left = 405
          Top = 211
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'CNPJ:'
          Pais = opcBrasil
        end
        object Label22: TLabel
          Left = 352
          Top = 296
          Width = 59
          Height = 28
          Alignment = taRightJustify
          Caption = 'E-Mail Depto'#13#10'Compras:'
        end
        object Label39: TLabel
          Left = 46
          Top = 521
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato (Sintegra):'
        end
        object lblWms: TLabel
          Left = 32
          Top = 544
          Width = 104
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa Utiliza WMS:'
        end
        object lblWmsSN: TColorLabel
          Left = 179
          Top = 544
          Width = 58
          Height = 14
          Caption = '(S)im (N)'#227'o '
          CorDestaque = clRed
        end
        object lblCrmCli: TLabel
          Left = 56
          Top = 567
          Width = 80
          Height = 14
          Cursor = crHandPoint
          Alignment = taRightJustify
          Caption = 'Cor CRM Cliente:'
          FocusControl = dbeCrmCli
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = Label34Click
        end
        object lblCrmPro: TLabel
          Left = 186
          Top = 567
          Width = 97
          Height = 14
          Cursor = crHandPoint
          Alignment = taRightJustify
          Caption = 'Cor CRM Prospecto:'
          FocusControl = dbeCrmPro
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = Label34Click
        end
        object lblCrmFor: TLabel
          Left = 331
          Top = 567
          Width = 104
          Height = 14
          Cursor = crHandPoint
          Alignment = taRightJustify
          Caption = 'Cor CRM Fornecedor:'
          FocusControl = dbeCrmFor
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = Label34Click
        end
        object lblNSRBru: TLabel
          Left = 28
          Top = 546
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Receita Bruta Servi'#231'os:'
        end
        object Label91: TLabel
          Left = 498
          Top = 567
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Exibir no APP Citel'
        end
        object ColorLabel20: TColorLabel
          Left = 624
          Top = 567
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label102: TLabel
          Left = 243
          Top = 544
          Width = 106
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bandeira da Empresa:'
        end
        object Label104: TLabel
          Left = 472
          Top = 498
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'IP Secund'#225'rio:'
        end
        object lblCoresIdentificacaoEmpresa: TLabel
          Left = 3
          Top = 592
          Width = 134
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cor Identifica'#231#227'o Nova Tela:'
        end
        object lblPortador: TLabel
          Left = 62
          Top = 620
          Width = 199
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador para Contas a Receber Vendas:'
        end
        object spbDicaPortador: TSpeedButton
          Left = 628
          Top = 614
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
          OnClick = spbDicaPortadorClick
        end
        object lblConsultaPix: TLabel
          Left = 465
          Top = 394
          Width = 119
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centraliza Consultas Pix:'
          Visible = False
        end
        object lblConsultaPixSN: TColorLabel
          Left = 624
          Top = 394
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Visible = False
          CorDestaque = clRed
        end
        object lblRedCarLig: TLabel
          Left = 3
          Top = 640
          Width = 312
          Height = 14
          Alignment = taRightJustify
          Caption = 'Redu'#231#227'o do Regime de Substitui'#231#227'o Tribut'#225'ria por Carga L'#237'quida:'
        end
        object lblSimbolRedCarLiq: TLabel
          Left = 410
          Top = 615
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label115: TLabel
          Left = 65
          Top = 440
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa Ativa:'
        end
        object ColorLabel4: TColorLabel
          Left = 168
          Top = 440
          Width = 61
          Height = 14
          Caption = '(S)im (N)'#227'o  '
          CorDestaque = clRed
        end
        object Label142: TLabel
          Left = 500
          Top = 590
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Gera SPED Fiscal'
        end
        object ColorLabel25: TColorLabel
          Left = 624
          Top = 590
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label143: TLabel
          Left = 19
          Top = 468
          Width = 117
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ind. Ativ. Preponderante:'
        end
        object edtNomCli: TEditFocus
          Left = 208
          Top = 345
          Width = 190
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
        object dbeCodEmp: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 6
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CODEMP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnExit = dbeCodEmpExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeNomEmp: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 29
          Width = 484
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NOMEMP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndere: TDBEditFocus
          Left = 139
          Top = 75
          Width = 309
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ENDERE'
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
        object dbeEndNum: TDBEditFocus
          Left = 503
          Top = 75
          Width = 120
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ENDNUM'
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
        object dbeBairro: TDBEditFocus
          Left = 391
          Top = 98
          Width = 232
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_BAIRRO'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndCmp: TDBEditFocus
          Left = 139
          Top = 98
          Width = 204
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ENDCMP'
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
        object dbeCidade: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 121
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CODCID'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          OnKeyPress = dbeCidadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCidadeChamaCadastro
        end
        object dbeNumCEp: TDBEditFocus
          Tag = 99
          Left = 494
          Top = 121
          Width = 129
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_C_E_P_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          OnKeyPress = dbeNumCEpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmail: TDBEditFocus
          Left = 139
          Top = 276
          Width = 484
          Height = 22
          CharCase = ecLowerCase
          DataField = 'EMP_EMAIL_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHomepa: TDBEditFocus
          Left = 139
          Top = 322
          Width = 259
          Height = 22
          CharCase = ecLowerCase
          DataField = 'EMP_HOMEPA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeInsEst: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 207
          Width = 227
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_I_E_S_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone01: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 144
          Width = 112
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_FONE01'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone02: TDBEditFocus
          Tag = 99
          Left = 318
          Top = 144
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_FONE02'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumFax: TDBEditFocus
          Tag = 99
          Left = 494
          Top = 144
          Width = 129
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_F_A_X_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreMat: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 368
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_PREMAT'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeCliFil: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 345
          Width = 68
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CLIFIL'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 26
          OnKeyPress = dbeCliFilKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCliFilChamaCadastro
        end
        object edtNomCid: TEditFocus
          Left = 183
          Top = 121
          Width = 160
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
        object edtEstado: TEditFocus
          Left = 391
          Top = 121
          Width = 46
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 52
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomFor: TEditFocus
          Left = 208
          Top = 391
          Width = 190
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 54
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeForFil: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 391
          Width = 68
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_FORFIL'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 29
          OnKeyPress = dbeForFilKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeForFilChamaCadastro
        end
        object dbeEmailC: TDBEditFocus
          Left = 413
          Top = 299
          Width = 210
          Height = 22
          CharCase = ecLowerCase
          DataField = 'EMP_EMAILC'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeJucEsp: TDBEditFocus
          Tag = 99
          Left = 306
          Top = 253
          Width = 131
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_JUCESP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaDsp: TDBEditFocus
          Tag = 99
          Left = 508
          Top = 253
          Width = 115
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_DTADSP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUsaRep: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 495
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_USAREP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 36
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNum_IP: TDBEditFocus
          Tag = 99
          Left = 376
          Top = 495
          Width = 79
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NUM_IP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 37
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCorFun: TDBEditFocus
          Tag = 50
          Left = 478
          Top = 6
          Width = 31
          Height = 22
          DataField = 'EMP_CORFUN'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
          OnChange = dbeCorFunChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomFan: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 52
          Width = 484
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NOMFAN'
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
        object dbeSigla: TDBEditFocus
          Left = 320
          Top = 6
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_SIGLA_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object GroupBox4: TGroupBox
          Left = 408
          Top = 324
          Width = 215
          Height = 40
          Caption = 'Registro de Invent'#225'ro'
          TabOrder = 25
          object Label44: TLabel
            Left = 10
            Top = 17
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Livro:'
          end
          object Label45: TLabel
            Left = 105
            Top = 17
            Width = 35
            Height = 14
            Caption = 'P'#225'gina:'
          end
          object dbeInvLiv: TDBEditFocus
            Tag = 99
            Left = 40
            Top = 13
            Width = 50
            Height = 22
            DataField = 'EMP_INVLIV'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 9
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeInvPag: TDBEditFocus
            Tag = 99
            Left = 143
            Top = 13
            Width = 50
            Height = 22
            DataField = 'EMP_INVPAG'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 9
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbeInsMun: TDBEditFocus
          Left = 436
          Top = 230
          Width = 187
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_INSMUN'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCNAE: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 253
          Width = 75
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CNAEFI'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 18
          OnKeyPress = dbeCNAEKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodMat: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 368
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CODMAT'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 28
          Visible = False
          OnKeyPress = dbeCodMatKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomMat: TEditFocus
          Left = 399
          Top = 368
          Width = 224
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 53
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeImpCTP: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 414
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_IMPCTP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 31
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeNumCgc: TDBEditCgcCpf
          Tag = 99
          Left = 436
          Top = 207
          Width = 187
          Height = 22
          DataField = 'EMP_C_G_C_'
          DataSource = dtsTabela
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
          Tipo = C_G_C_
        end
        object grbDac: TGroupBox
          Left = 80
          Top = 166
          Width = 543
          Height = 39
          Caption = 'Dac - Atendimento ao Cliente'
          TabOrder = 14
          object Label14: TLabel
            Left = 181
            Top = 16
            Width = 53
            Height = 14
            Alignment = taRightJustify
            Caption = 'Telefone 1:'
          end
          object Label20: TLabel
            Left = 384
            Top = 16
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = '0800:'
          end
          object dbeFoneDa1: TDBEditFocus
            Tag = 99
            Left = 238
            Top = 13
            Width = 119
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EMP_FONDA1'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeFoneDa2: TDBEditFocus
            Left = 414
            Top = 13
            Width = 124
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EMP_FONDA2'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbeEmailV: TDBEditFocus
          Left = 139
          Top = 299
          Width = 207
          Height = 22
          CharCase = ecLowerCase
          DataField = 'EMP_EMAILV'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeContSintegra: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 518
          Width = 484
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CONTAT'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 39
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUtiWMS: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 541
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_UTIWMS'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 49
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmCli: TDBEditFocus
          Tag = 50
          Left = 139
          Top = 564
          Width = 28
          Height = 22
          DataField = 'EMP_CRMCLI'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 42
          OnChange = dbeCorFunChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmPro: TDBEditFocus
          Tag = 50
          Left = 286
          Top = 564
          Width = 31
          Height = 22
          DataField = 'EMP_CRMPRO'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 43
          OnChange = dbeCorFunChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCrmFor: TDBEditFocus
          Tag = 50
          Left = 438
          Top = 564
          Width = 31
          Height = 22
          DataField = 'EMP_CRMFOR'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 44
          OnChange = dbeCorFunChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNSRBru: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 541
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NSRBRU'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 40
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeExiApp: TDBEditFocus
          Tag = 99
          Left = 587
          Top = 564
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_EXIAPP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 45
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeCodBan: TDBEditFocus
          Tag = 99
          Left = 351
          Top = 541
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CODBAN'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 41
          OnKeyPress = dbeCodBanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesBan: TEditFocus
          Left = 380
          Top = 541
          Width = 243
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 55
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeNumIPSec: TDBEditFocus
          Tag = 99
          Left = 544
          Top = 495
          Width = 79
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NIP_SEC'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 38
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object clbCoresIdentificacaoEmpresa: TColorBox
          Tag = 99
          Left = 139
          Top = 587
          Width = 145
          Height = 22
          Selected = clScrollBar
          Style = [cbCustomColors]
          TabOrder = 46
          OnGetColors = clbCoresIdentificacaoEmpresaGetColors
        end
        object dbeCodPor: TDBEditFocus
          Tag = 99
          Left = 267
          Top = 612
          Width = 49
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CODPOR'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 48
          OnKeyPress = dbeCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtDesPor: TEditFocus
          Left = 317
          Top = 612
          Width = 308
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
        inline fraPlanoDeContasCtp: TfraPlanoDeContasDBEditFocus
          Left = 239
          Top = 414
          Width = 387
          Height = 22
          TabOrder = 32
          ExplicitLeft = 239
          ExplicitTop = 414
          ExplicitWidth = 387
          inherited lblPlaContas: TLabel
            Left = 4
            Top = 3
            Width = 88
            Height = 14
            Caption = 'Plano Contas CTP:'
            ExplicitLeft = 4
            ExplicitTop = 3
            ExplicitWidth = 88
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 95
            Width = 64
            Height = 22
            DataField = 'EMP_CTACTP'
            DataSource = dtsTabela
            OnKeyPress = fraPlanoDeContasCtpdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasCtpdbeCodCtaChamaCadastro
            ExplicitLeft = 95
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 160
            Width = 224
            Height = 22
            ExplicitLeft = 160
            ExplicitWidth = 224
            ExplicitHeight = 22
          end
        end
        object pnlCertificadoDigital: TPanel
          Left = 0
          Top = 659
          Width = 1130
          Height = 19
          Align = alBottom
          BevelOuter = bvLowered
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 57
        end
        object dbeConsultaPix: TDBEditFocus
          Tag = 99
          Left = 587
          Top = 391
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_CONPIX'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 30
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeALQCLI: TDBEditFocus
          Tag = 99
          Left = 317
          Top = 636
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ALQCLI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 56
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object grbGerarPedidoTEs: TGroupBox
          Left = 318
          Top = 436
          Width = 305
          Height = 57
          Caption = 'Gerar Pedido de Compra na(s) TE(s):'
          TabOrder = 35
          object lblGerarPedidoCompraTEDestino: TLabel
            Left = 25
            Top = 14
            Width = 160
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quando a Empresa for o Destino:'
          end
          object lblGerarPedidoCompraTEDestinoColor: TColorLabel
            Left = 233
            Top = 14
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblGerarPedidoCompraTEOrigem: TLabel
            Left = 27
            Top = 36
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quando a Empresa for a Origem:'
          end
          object lblGerarPedidoCompraTEOrigemColor: TColorLabel
            Left = 233
            Top = 36
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeGerCmp: TDBEditFocus
            Tag = 99
            Left = 191
            Top = 10
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EMP_GERCMP'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeGerOri: TDBEditFocus
            Tag = 99
            Left = 191
            Top = 33
            Width = 36
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EMP_GERORI'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlImgEmp: TPanel
          Left = 633
          Top = 34
          Width = 131
          Height = 95
          BevelInner = bvLowered
          BorderWidth = 2
          BorderStyle = bsSingle
          Color = clWhite
          DoubleBuffered = True
          ParentBackground = False
          ParentDoubleBuffered = False
          TabOrder = 59
          OnDblClick = imgEmpDblClick
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
            ExplicitHeight = 36
          end
          object imgEmp: TcxImage
            Left = 4
            Top = 4
            Align = alClient
            Properties.FitMode = ifmProportionalStretch
            Properties.PopupMenuLayout.MenuItems = []
            TabOrder = 0
            OnDblClick = imgEmpDblClick
            Height = 83
            Width = 119
          end
        end
        object dbeEmpAti: TDBEditFocus
          Tag = 99
          Left = 139
          Top = 437
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_EMPATI'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 33
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeGRSPED: TDBEditFocus
          Tag = 99
          Left = 587
          Top = 587
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_GRSPED'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 47
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object cbxIndAtivPrep: TComboBoxFocus
          Left = 139
          Top = 465
          Width = 173
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 34
          OnChange = cbxRegTribChange
          Items.Strings = (
            '0 - Industrial ou equiparado a industrial'
            '1 - Prestador de servi'#231'os'
            '2 - Atividade de com'#233'rcio'
            
              '3 - Pessoas jur'#237'dicas referidas nos '#167#167' 6'#186', 8'#186' e 9'#186' do art. 3'#186' da' +
              ' Lei n'#186' 9.718, de 1998'
            '4 - Atividade imobili'#225'ria'
            '9 - Outros')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object tbsConEmp: TTabSheet
      Caption = '&2 - Configura'#231#227'o de Transf. de Estoque'
      Enabled = False
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pgcTransfEstoque: TPageControl
        Left = 0
        Top = 0
        Width = 1130
        Height = 269
        ActivePage = tbsClaSai
        Align = alTop
        Style = tsFlatButtons
        TabOrder = 0
        object tbsClaSai: TTabSheet
          Caption = 'Classifica'#231#245'es de Sa'#237'da'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlTransfCstSaida: TPanel
            Left = 880
            Top = 0
            Width = 242
            Height = 237
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object gpbCSTVen: TGroupBox
              Left = 0
              Top = 0
              Width = 242
              Height = 47
              Align = alTop
              Caption = 'CST de Venda'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitLeft = 8
              ExplicitTop = -10
              object lbl10: TLabel
                Left = 8
                Top = 27
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object lbl12: TLabel
                Left = 82
                Top = 13
                Width = 57
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Comb./Lub.:'
              end
              object lbl11: TLabel
                Left = 168
                Top = 13
                Width = 38
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Demais:'
              end
              object dbeCSTT01: TDBEditFocus
                Tag = 99
                Left = 57
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTT01'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCSTT02: TDBEditFocus
                Tag = 99
                Left = 142
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTT02'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCSTT03: TDBEditFocus
                Tag = 99
                Left = 209
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTT03'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
            object gpbCSTTra: TGroupBox
              Left = 0
              Top = 47
              Width = 242
              Height = 47
              Align = alTop
              Caption = 'CST de Transfer'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ExplicitTop = 0
              object lbl13: TLabel
                Left = 8
                Top = 27
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object lbl14: TLabel
                Left = 82
                Top = 13
                Width = 57
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Comb./Lub.:'
              end
              object lbl15: TLabel
                Left = 168
                Top = 13
                Width = 38
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Demais:'
              end
              object dbeCSTTT1: TDBEditFocus
                Tag = 99
                Left = 57
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTTT1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCSTTT2: TDBEditFocus
                Tag = 99
                Left = 142
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTTT2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCSTTT3: TDBEditFocus
                Tag = 99
                Left = 209
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTTT3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
            object gpbCSTDpf: TGroupBox
              Left = 0
              Top = 94
              Width = 242
              Height = 47
              Align = alTop
              Caption = 'CST de Transfer'#234'ncia de Dep'#243'sito Fechado'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ExplicitTop = 102
              object Label139: TLabel
                Left = 8
                Top = 27
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label140: TLabel
                Left = 82
                Top = 13
                Width = 57
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Comb./Lub.:'
              end
              object Label141: TLabel
                Left = 168
                Top = 13
                Width = 38
                Height = 28
                Alignment = taRightJustify
                Caption = 'Subst. '#13#10'Demais:'
              end
              object dbeEMP_CSTDFT: TDBEditFocus
                Tag = 99
                Left = 57
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTDFT'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeEMP_CSTDFC: TDBEditFocus
                Tag = 99
                Left = 142
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTDFC'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeEMP_CSTDFS: TDBEditFocus
                Tag = 99
                Left = 209
                Top = 19
                Width = 21
                Height = 22
                DataField = 'EMP_CSTDFS'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
            end
          end
          object pnlTransfCfopSai: TPanel
            Left = 0
            Top = 0
            Width = 709
            Height = 237
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object grpTraDepFecSai: TGroupBox
              Left = 0
              Top = 186
              Width = 709
              Height = 46
              Align = alTop
              Caption = 'Classifica'#231#245'es de Transfer'#234'ncia de Dep'#243'sito Fechado'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              object Label131: TLabel
                Left = 10
                Top = 22
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label132: TLabel
                Left = 126
                Top = 22
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label133: TLabel
                Left = 324
                Top = 22
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object dbeCLTDFT: TDBEditFocus
                Tag = 99
                Left = 60
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLTDFT'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCLTDFC: TDBEditFocus
                Tag = 99
                Left = 254
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLTDFC'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeCLTDFS: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLTDFS'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbClaTraIndTra: TGroupBox
              Left = 0
              Top = 140
              Width = 709
              Height = 46
              Align = alTop
              Caption = 'Classifica'#231#245'es de Transfer'#234'ncia de Produtos Industrializa'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              object Label98: TLabel
                Left = 10
                Top = 22
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label99: TLabel
                Left = 126
                Top = 22
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label100: TLabel
                Left = 324
                Top = 22
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object dbeCltti1: TDBEditFocus
                Tag = 99
                Left = 60
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLTTI1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCltti2: TDBEditFocus
                Tag = 99
                Left = 254
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLTTI2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeCltti3: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLTTI3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbClaTraInd: TGroupBox
              Left = 0
              Top = 47
              Width = 709
              Height = 47
              Align = alTop
              Caption = 'Classifica'#231#245'es de Industrializa'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object Label92: TLabel
                Left = 10
                Top = 23
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label96: TLabel
                Left = 126
                Top = 23
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label97: TLabel
                Left = 324
                Top = 23
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object dbeClati1: TDBEditFocus
                Tag = 99
                Left = 60
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLATI1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeClati2: TDBEditFocus
                Tag = 99
                Left = 254
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLATI2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClati3: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLATI3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbClaTra: TGroupBox
              Left = 0
              Top = 94
              Width = 709
              Height = 46
              Align = alTop
              Caption = 'Classifica'#231#245'es de Transfer'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object Label37: TLabel
                Left = 10
                Top = 22
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label38: TLabel
                Left = 126
                Top = 22
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label42: TLabel
                Left = 324
                Top = 22
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object dbeClatt1: TDBEditFocus
                Tag = 99
                Left = 60
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLATT1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeClatt2: TDBEditFocus
                Tag = 99
                Left = 254
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLATT2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClatt3: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CLATT3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbClaVen: TGroupBox
              Left = 0
              Top = 0
              Width = 709
              Height = 47
              Align = alTop
              Caption = 'Classifica'#231#245'es de Venda'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label19: TLabel
                Left = 10
                Top = 23
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label76: TLabel
                Left = 126
                Top = 23
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label77: TLabel
                Left = 520
                Top = 23
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object Label36: TLabel
                Left = 324
                Top = 23
                Width = 121
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Importa'#231#227'o Direta:'
              end
              object dbeClat01: TDBEditFocus
                Tag = 99
                Left = 60
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLAT01'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeClat02: TDBEditFocus
                Tag = 99
                Left = 254
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLAT02'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClat03: TDBEditFocus
                Tag = 99
                Left = 642
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLAT03'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClat04: TDBEditFocus
                Tag = 99
                Left = 449
                Top = 19
                Width = 55
                Height = 22
                DataField = 'EMP_CLAT04'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
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
        end
        object tbsClaEnt: TTabSheet
          Caption = 'Classifica'#231#245'es de Entrada'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlTransfCfopEnt: TPanel
            Left = 0
            Top = 0
            Width = 533
            Height = 237
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object gbpClaCom: TGroupBox
              Left = 0
              Top = 0
              Width = 533
              Height = 47
              Align = alTop
              Caption = 'Classifica'#231#245'es de Compra'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label49: TLabel
                Left = 23
                Top = 20
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label50: TLabel
                Left = 154
                Top = 20
                Width = 118
                Height = 14
                Caption = 'Subst. Demais Produtos:'
              end
              object Label29: TLabel
                Left = 335
                Top = 20
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object dbeClTeV1: TDBEditFocus
                Tag = 99
                Left = 75
                Top = 16
                Width = 55
                Height = 22
                DataField = 'EMP_CLTEV1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                OnKeyPress = dbeClaTe1KeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeClTeV2: TDBEditFocus
                Tag = 99
                Left = 276
                Top = 16
                Width = 55
                Height = 22
                DataField = 'EMP_CLTEV2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                OnKeyPress = dbeClaTe1KeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClTeV3: TDBEditFocus
                Tag = 99
                Left = 467
                Top = 17
                Width = 55
                Height = 22
                DataField = 'EMP_CLTEV3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gbpClaTraEnt: TGroupBox
              Left = 0
              Top = 47
              Width = 533
              Height = 46
              Align = alTop
              Caption = 'Classifica'#231#245'es de Transfer'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object Label27: TLabel
                Left = 23
                Top = 20
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label28: TLabel
                Left = 154
                Top = 20
                Width = 118
                Height = 14
                Caption = 'Subst. Demais Produtos:'
              end
              object Label112: TLabel
                Left = 335
                Top = 19
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object dbeClaTe1: TDBEditFocus
                Tag = 99
                Left = 75
                Top = 16
                Width = 55
                Height = 22
                DataField = 'EMP_CLATe1'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                OnKeyPress = dbeClaTe1KeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeClaTe2: TDBEditFocus
                Tag = 99
                Left = 276
                Top = 16
                Width = 55
                Height = 22
                DataField = 'EMP_CLATe2'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                OnKeyPress = dbeClaTe1KeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeClaTe3: TDBEditFocus
                Tag = 99
                Left = 467
                Top = 16
                Width = 55
                Height = 22
                DataField = 'EMP_CLATE3'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object grpTraDepFecEnt: TGroupBox
              Left = 0
              Top = 93
              Width = 533
              Height = 46
              Align = alTop
              Caption = 'Classifica'#231#245'es de Transfer'#234'ncia de Dep'#243'sito Fechado'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object Label134: TLabel
                Left = 23
                Top = 22
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tributado:'
              end
              object Label137: TLabel
                Left = 145
                Top = 22
                Width = 127
                Height = 14
                Caption = 'Subst. Comb./Lubrificante:'
              end
              object Label138: TLabel
                Left = 342
                Top = 22
                Width = 118
                Height = 14
                Alignment = taRightJustify
                Caption = 'Subst. Demais Produtos:'
              end
              object dbeCETDFT: TDBEditFocus
                Tag = 99
                Left = 73
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CETDFT'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttNumerico
              end
              object dbeCETDFC: TDBEditFocus
                Tag = 99
                Left = 276
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CETDFC'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeCETDFS: TDBEditFocus
                Tag = 99
                Left = 467
                Top = 18
                Width = 55
                Height = 22
                DataField = 'EMP_CETDFS'
                DataSource = dtsTabela
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 9
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
        end
      end
      object cxgTraEst: TcxGrid
        Left = 0
        Top = 269
        Width = 1130
        Height = 328
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgTraEstDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsConEmp
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          object cxgTraEstDBTableView1Column3: TcxGridDBColumn
            Caption = 'Emp. Dest.'
            DataBinding.FieldName = 'CON_EMPDES'
            Options.Editing = False
            Width = 55
          end
          object cxgTraEstDBTableView1Column1: TcxGridDBColumn
            Caption = 'Empresa Destino'
            DataBinding.FieldName = 'CON_EMPDES'
            RepositoryItem = cxrEmpDes
            Options.Editing = False
            Width = 130
          end
          object cxgTraEstDBTableView1Column2: TcxGridDBColumn
            Caption = 'Opera'#231#227'o'
            DataBinding.FieldName = 'CON_TIPOPE'
            RepositoryItem = cxrTipOpe
            Width = 110
          end
          object cxgTraEstDBTableView1Column4: TcxGridDBColumn
            Caption = 'Permitido (1)'
            DataBinding.FieldName = 'CON_PERTRA'
            RepositoryItem = cxrSimNao
            HeaderAlignmentHorz = taCenter
            Width = 67
          end
          object cxgTraEstDBTableView1Column7: TcxGridDBColumn
            Caption = 'Zerar ICMS (2)'
            DataBinding.FieldName = 'CON_ZERICM'
            RepositoryItem = cxrSimNao
            Width = 70
          end
          object cxgTraEstDBTableView1Column6: TcxGridDBColumn
            Caption = 'Deduzir Pis/Cofins (3)'
            DataBinding.FieldName = 'CON_ULTPIS'
            RepositoryItem = cxrUltPis
            Width = 101
          end
          object cxgTraEstDBTableView1Column8: TcxGridDBColumn
            Caption = 'Deduzir ICMS (4)'
            DataBinding.FieldName = 'CON_ULTICM'
            RepositoryItem = cxrUltICM
            Width = 79
          end
          object cxgTraEstDBTableView1CON_CODTEP: TcxGridDBColumn
            Caption = 'Pr. Transf. n'#227'o Promoc.'
            DataBinding.FieldName = 'CON_CODTEP'
            RepositoryItem = cxlTeprev
            Width = 105
          end
          object cxgTraEstDBTableView1CON_TEPPRO: TcxGridDBColumn
            Caption = 'Pr. Transf. Promoc.'
            DataBinding.FieldName = 'CON_TEPPRO'
            RepositoryItem = cxlTeppro
            Width = 90
          end
          object cxgTraEstDBTableView1CON_TEPDEF: TcxGridDBColumn
            Caption = 'Pr. Transf. Dep. fechado'
            DataBinding.FieldName = 'CON_TEPDEF'
            RepositoryItem = cxlTepdef
            Width = 110
          end
          object cxgTraEstDBTableView1Column5: TcxGridDBColumn
            Caption = 'Fator Pre'#231'o (5)'
            DataBinding.FieldName = 'CON_FAT_TE'
            RepositoryItem = cxrFat_TE
            Width = 75
          end
          object cxgTraEstDBTableView1Column9: TcxGridDBColumn
            Caption = 'Fator Pre'#231'o ST (6)'
            DataBinding.FieldName = 'CON_FATTE2'
            RepositoryItem = cxrFat_TE
            Width = 85
          end
          object cxgTraEstDBTableView1CON_SEQTRA: TcxGridDBColumn
            Caption = 'Seq.'
            DataBinding.FieldName = 'CON_SEQTRA'
            PropertiesClassName = 'TcxSpinEditProperties'
            Width = 25
          end
        end
        object cxgTraEstLevel1: TcxGridLevel
          GridView = cxgTraEstDBTableView1
        end
      end
      object pnlTransLegenda: TPanel
        Left = 0
        Top = 597
        Width = 1130
        Height = 53
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object lbl8: TLabel
          Left = 16
          Top = 37
          Width = 371
          Height = 14
          Caption = 
            '(3) Deduzir Pis/Cofins no pre'#231'o de '#250'ltima compra na Entrada de M' +
            'ercadorias.'
        end
        object Label23: TLabel
          Left = 16
          Top = 3
          Width = 558
          Height = 14
          Caption = 
            '(1) Permitir emiss'#227'o de documentos de transfer'#234'ncia de estoque p' +
            'or Outras Sa'#237'das e/ou Transfer'#234'ncia de Estoque.'
        end
        object Label24: TLabel
          Left = 16
          Top = 20
          Width = 300
          Height = 14
          Caption = '(2) Zerar ICMS nas notas fiscais de transfer'#234'ncia de estoque.'
        end
        object Label86: TLabel
          Left = 588
          Top = 18
          Width = 457
          Height = 14
          Caption = 
            '(5) Fator Pre'#231'o aplicado sobre os pre'#231'os escolhidos para transfe' +
            'r'#234'ncia - produtos Tributados.'
        end
        object Label103: TLabel
          Left = 588
          Top = 2
          Width = 347
          Height = 14
          Caption = 
            '(4) Deduzir ICMS no pre'#231'o de '#250'ltima compra na Entrada de Mercado' +
            'rias.'
        end
        object Label105: TLabel
          Left = 588
          Top = 35
          Width = 510
          Height = 14
          Caption = 
            '(6) Fator Pre'#231'o aplicado sobre os pre'#231'os escolhidos para transfe' +
            'r'#234'ncia - produtos Substitui'#231#227'o Tribut'#225'ria'
        end
      end
      object pnlMltRca: TPanel
        Left = 0
        Top = 650
        Width = 1130
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object lblUtiAbaSN: TColorLabel
          Left = 267
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
        object lblUtiAba: TLabel
          Left = 16
          Top = 6
          Width = 200
          Height = 14
          Caption = 'Utilizar empresa na rotina Citel Abastece?'
        end
        object dbeUtiAba: TDBEditFocus
          Tag = 99
          Left = 222
          Top = 3
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_UTIABA'
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
      end
    end
    object tbsCfgFin: TTabSheet
      Caption = '&3 - Configura'#231#245'es Financeiras'
      Enabled = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgFinEmp: TcxGrid
        Left = 0
        Top = 0
        Width = 1130
        Height = 678
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgFinEmpeView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'Configura'#231#245'es Financeiras'
              Width = 749
            end>
          object cxgFinEmpeViewColumn2: TcxGridDBBandedColumn
            Caption = 'Empresa Destino'
            DataBinding.FieldName = 'FIN_EMPDES'
            RepositoryItem = cxrEmpDes
            Options.Editing = False
            Width = 373
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgFinEmpeViewColumn3: TcxGridDBBandedColumn
            Caption = 'Grava Contas a Receber'
            DataBinding.FieldName = 'FIN_GRVCTR'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 141
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgFinEmpeViewColumn5: TcxGridDBBandedColumn
            Caption = 'Grava Contas a Pagar'
            DataBinding.FieldName = 'FIN_GRVCTP'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 142
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgFinEmpeViewColumn1: TcxGridDBBandedColumn
            Caption = 'C'#243'd.Emp.Dest.'
            DataBinding.FieldName = 'FIN_EMPDES'
            Options.Editing = False
            Width = 93
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
        end
        object cxgFinEmpLevel1: TcxGridLevel
          GridView = cxgFinEmpeView
        end
      end
    end
    object tbsAnaliseResult: TTabSheet
      Caption = '&4 - An'#225'lise de Resultados / DRE'
      ImageIndex = 8
      OnShow = tbsAnaliseResultShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pgcRegTrib: TPageControl
        Tag = 99
        Left = 0
        Top = 41
        Width = 1130
        Height = 637
        ActivePage = tbsLucroPresumido
        Align = alClient
        Enabled = False
        Style = tsFlatButtons
        TabOrder = 1
        object tbsLucroReal: TTabSheet
          Caption = '&Lucro Real'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlLucroReal: TPanel
            Left = 0
            Top = 0
            Width = 1122
            Height = 605
            Align = alClient
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label69: TLabel
              Left = 131
              Top = 17
              Width = 282
              Height = 14
              Caption = 'Subtrair PIS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label62: TLabel
              Left = 109
              Top = 41
              Width = 304
              Height = 14
              Caption = 'Subtrair COFINS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label63: TLabel
              Left = 122
              Top = 65
              Width = 291
              Height = 14
              Caption = 'Subtrair ICMS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label64: TLabel
              Left = 143
              Top = 89
              Width = 270
              Height = 14
              Caption = 'Somar IPI no Faturamento para calcular Receita L'#237'quida?'
            end
            object Label65: TLabel
              Left = 17
              Top = 113
              Width = 396
              Height = 14
              Caption = 
                'Somar SUBSTITUI'#199#195'O TRIBUT'#193'RIA no Faturamento para calcular Recei' +
                'ta L'#237'quida?'
            end
            object Label67: TLabel
              Left = 122
              Top = 137
              Width = 291
              Height = 14
              Caption = 'Somar FRETE no Faturamento para calcular Receita L'#237'quida?'
            end
            object Label68: TLabel
              Left = 200
              Top = 185
              Width = 213
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS RECEBIDOS como:'
            end
            object Label70: TLabel
              Left = 162
              Top = 209
              Width = 251
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS CONCEDIDOS como:'
            end
            object ColorLabel28: TColorLabel
              Left = 464
              Top = 17
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
            object ColorLabel1: TColorLabel
              Left = 464
              Top = 41
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
            object ColorLabel3: TColorLabel
              Left = 464
              Top = 65
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
            object ColorLabel7: TColorLabel
              Left = 464
              Top = 89
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
            object ColorLabel8: TColorLabel
              Left = 464
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
            object ColorLabel9: TColorLabel
              Left = 464
              Top = 137
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
            object Label107: TLabel
              Left = 16
              Top = 161
              Width = 397
              Height = 14
              Caption = 
                'Incluir duplicatas de cliente/fornecedor filial na se'#231#227'o de Cont' +
                'as a Receber/Pagar?'
            end
            object ColorLabel21: TColorLabel
              Left = 464
              Top = 161
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
            object Label125: TLabel
              Left = 221
              Top = 233
              Width = 192
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS PAGOS como:'
            end
            object Label130: TLabel
              Left = 183
              Top = 257
              Width = 230
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS OBTIDOS como:'
            end
            object dbeLrPisL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 14
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRPISL'
              DataSource = dsRegTri
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
            object cbxLrJurR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 182
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 7
              OnChange = cbxLrJurRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxLrDesR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 206
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 8
              OnChange = cbxLrDesRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeLrCofL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 38
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRCOFL'
              DataSource = dsRegTri
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
            object dbeLrIcmL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 62
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRICML'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLrIpiL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 86
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRIPIL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLrRetL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 110
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRRETL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLrFreL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 134
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRFREL'
              DataSource = dsRegTri
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLrCFFD: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 158
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LRCFFD'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object cbxLrJurP: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 230
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 9
              OnChange = cbxLrJurPChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxLrDesO: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 254
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 10
              OnChange = cbxLrDesOChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
        end
        object tbsLucroPresumido: TTabSheet
          Caption = 'Lucro &Presumido'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlLucroPresumido: TPanel
            Left = 0
            Top = 0
            Width = 1122
            Height = 605
            Align = alClient
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label71: TLabel
              Left = 243
              Top = 17
              Width = 172
              Height = 14
              Caption = 'Al'#237'quota de IRPJ sobre faturamento:'
            end
            object Label72: TLabel
              Left = 237
              Top = 41
              Width = 178
              Height = 14
              Caption = 'Al'#237'quota de CSLL sobre faturamento:'
            end
            object Label73: TLabel
              Left = 133
              Top = 65
              Width = 282
              Height = 14
              Caption = 'Subtrair PIS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label74: TLabel
              Left = 111
              Top = 89
              Width = 304
              Height = 14
              Caption = 'Subtrair COFINS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label75: TLabel
              Left = 124
              Top = 113
              Width = 291
              Height = 14
              Caption = 'Subtrair ICMS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label78: TLabel
              Left = 145
              Top = 137
              Width = 270
              Height = 14
              Caption = 'Somar IPI no Faturamento para calcular Receita L'#237'quida?'
            end
            object Label79: TLabel
              Left = 19
              Top = 161
              Width = 396
              Height = 14
              Caption = 
                'Somar SUBSTITUI'#199#195'O TRIBUT'#193'RIA no Faturamento para calcular Recei' +
                'ta L'#237'quida?'
            end
            object Label80: TLabel
              Left = 124
              Top = 185
              Width = 291
              Height = 14
              Caption = 'Somar FRETE no Faturamento para calcular Receita L'#237'quida?'
            end
            object ColorLabel12: TColorLabel
              Left = 464
              Top = 65
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
            object ColorLabel13: TColorLabel
              Left = 464
              Top = 89
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
            object ColorLabel14: TColorLabel
              Left = 464
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
            object ColorLabel15: TColorLabel
              Left = 464
              Top = 137
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
            object Label81: TLabel
              Left = 202
              Top = 233
              Width = 213
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS RECEBIDOS como:'
            end
            object Label82: TLabel
              Left = 164
              Top = 257
              Width = 251
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS CONCEDIDOS como:'
            end
            object ColorLabel16: TColorLabel
              Left = 464
              Top = 161
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
            object ColorLabel17: TColorLabel
              Left = 464
              Top = 185
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
            object Label83: TLabel
              Left = 464
              Top = 17
              Width = 10
              Height = 14
              Caption = '%'
            end
            object Label84: TLabel
              Left = 464
              Top = 41
              Width = 10
              Height = 14
              Caption = '%'
            end
            object Label108: TLabel
              Left = 16
              Top = 209
              Width = 397
              Height = 14
              Caption = 
                'Incluir duplicatas de cliente/fornecedor filial na se'#231#227'o de Cont' +
                'as a Receber/Pagar?'
            end
            object ColorLabel22: TColorLabel
              Left = 464
              Top = 209
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
            object Label40: TLabel
              Left = 223
              Top = 281
              Width = 192
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS PAGOS como:'
            end
            object Label48: TLabel
              Left = 185
              Top = 305
              Width = 230
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS OBTIDOS como:'
            end
            object dbeLpAlqI: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 14
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPALQI'
              DataSource = dsRegTri
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
            object cbxLpJurR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 230
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 9
              OnChange = cbxLpJurRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxLpDesR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 254
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 10
              OnChange = cbxLpDesRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeLpAlqC: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 38
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPALQC'
              DataSource = dsRegTri
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
            object dbeLpPisL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 61
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPPISL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpCofL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 86
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPCOFL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpIcmL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 110
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPICML'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpIpiL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 134
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPIPIL'
              DataSource = dsRegTri
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpRetL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 158
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPRETL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpFreL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 182
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPFREL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeLpCFFD: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 206
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_LPCFFD'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object cbxLpJurP: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 278
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 11
              OnChange = cbxLpJurPChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxLpDesO: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 302
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 12
              OnChange = cbxLpDesOChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
        end
        object tbsSimplesNacional: TTabSheet
          Caption = '&Simples Nacional'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlSimplesNacional: TPanel
            Left = 0
            Top = 0
            Width = 1122
            Height = 605
            Align = alClient
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label85: TLabel
              Left = 232
              Top = 17
              Width = 189
              Height = 14
              Caption = 'Al'#237'quota de Simples sobre faturamento:'
            end
            object Label87: TLabel
              Left = 124
              Top = 41
              Width = 291
              Height = 14
              Caption = 'Subtrair ICMS do Faturamento para calcular Receita L'#237'quida?'
            end
            object Label88: TLabel
              Left = 145
              Top = 65
              Width = 270
              Height = 14
              Caption = 'Somar IPI no Faturamento para calcular Receita L'#237'quida?'
            end
            object Label89: TLabel
              Left = 19
              Top = 89
              Width = 396
              Height = 14
              Caption = 
                'Somar SUBSTITUI'#199#195'O TRIBUT'#193'RIA no Faturamento para calcular Recei' +
                'ta L'#237'quida?'
            end
            object Label90: TLabel
              Left = 124
              Top = 113
              Width = 291
              Height = 14
              Caption = 'Somar FRETE no Faturamento para calcular Receita L'#237'quida?'
            end
            object ColorLabel10: TColorLabel
              Left = 464
              Top = 41
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
            object ColorLabel11: TColorLabel
              Left = 464
              Top = 65
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
            object ColorLabel18: TColorLabel
              Left = 464
              Top = 89
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
            object ColorLabel19: TColorLabel
              Left = 464
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
            object Label93: TLabel
              Left = 202
              Top = 161
              Width = 213
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS RECEBIDOS como:'
            end
            object Label94: TLabel
              Left = 164
              Top = 185
              Width = 251
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS CONCEDIDOS como:'
            end
            object Label95: TLabel
              Left = 464
              Top = 17
              Width = 10
              Height = 14
              Caption = '%'
            end
            object Label109: TLabel
              Left = 16
              Top = 137
              Width = 397
              Height = 14
              Caption = 
                'Incluir duplicatas de cliente/fornecedor filial na se'#231#227'o de Cont' +
                'as a Receber/Pagar?'
            end
            object ColorLabel23: TColorLabel
              Left = 464
              Top = 137
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
            object Label51: TLabel
              Left = 223
              Top = 209
              Width = 192
              Height = 14
              Caption = 'Considerar o '#237'tem JUROS PAGOS como:'
            end
            object Label116: TLabel
              Left = 185
              Top = 233
              Width = 230
              Height = 14
              Caption = 'Considerar o '#237'tem DESCONTOS OBTIDOS como:'
            end
            object dbeSnAlqF: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 14
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNALQF'
              DataSource = dsRegTri
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
            object cbxSnJurR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 158
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 6
              OnChange = cbxSnJurRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxSnDesR: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 182
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 7
              OnChange = cbxSnDesRChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeSnIcmL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 38
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNICML'
              DataSource = dsRegTri
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
            object dbeSnIpiL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 62
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNIPIL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeSnRetL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 86
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNRETL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeSnFreL: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 110
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNFREL'
              DataSource = dsRegTri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeSnCFFD: TDBEditFocus
              Tag = 99
              Left = 421
              Top = 134
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNCFFD'
              DataSource = dsRegTri
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object cbxSnJurP: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 206
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 8
              OnChange = cbxSnJurPChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbxSnDesO: TComboBoxFocus
              Tag = 99
              Left = 421
              Top = 230
              Width = 200
              Height = 22
              Style = csDropDownList
              TabOrder = 9
              OnChange = cbxSnDesOChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
        end
        object tbsCat42: TTabSheet
          Caption = 'C&AT - 42'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlCat42: TPanel
            Left = 0
            Top = 0
            Width = 1122
            Height = 605
            Align = alClient
            TabOrder = 0
            object Label110: TLabel
              Left = 9
              Top = 15
              Width = 357
              Height = 14
              Caption = 
                'Somar no Faturamento o Valor da CAT-42 para Calcular a Receita L' +
                'iquida?'
            end
            object ColorLabel24: TColorLabel
              Left = 418
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
            object dbeSomaFatCAT42: TDBEditFocus
              Tag = 99
              Left = 373
              Top = 12
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TRI_SNRCAT'
              DataSource = dsRegTri
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
              OnExit = dbeSomaFatCAT42Exit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object grbValoresAprovCAT42: TGroupBox
              Left = 8
              Top = 41
              Width = 305
              Height = 343
              Caption = 'Valores Aprovados (CAT - 42):'
              TabOrder = 1
              object Label111: TLabel
                Left = 12
                Top = 29
                Width = 25
                Height = 14
                Caption = 'Ano:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object cxGridEmpCat: TcxGrid
                Left = 8
                Top = 55
                Width = 288
                Height = 278
                TabOrder = 1
                object cxGridEmpCatDBView: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.DataSource = dtsEmpCat
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Inserting = False
                  OptionsView.GroupByBox = False
                  object cxGridEmpCatDBViewMesAno: TcxGridDBColumn
                    Caption = 'M'#234's / Ano'
                    DataBinding.FieldName = 'MESANO'
                    Options.Editing = False
                    Width = 64
                  end
                  object cxGridEmpCatDBViewValor: TcxGridDBColumn
                    Caption = 'Valor Artigo 269'
                    DataBinding.FieldName = 'CAT_TOTVAL'
                    Width = 106
                  end
                  object cxGridEmpCatDBViewCAT_TOTVA2: TcxGridDBColumn
                    Caption = 'Valor Artigo 271'
                    DataBinding.FieldName = 'CAT_TOTVA2'
                    Width = 92
                  end
                end
                object cxGridEmpCatView: TcxGridLevel
                  GridView = cxGridEmpCatDBView
                end
              end
              object mskAnoCat: TMaskEditFocus
                Tag = 99
                Left = 43
                Top = 25
                Width = 45
                Height = 22
                EditMask = '9999'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                MaxLength = 4
                ParentFont = False
                TabOrder = 0
                Text = '    '
                OnExit = mskAnoCatExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                ValidaData = False
              end
            end
          end
        end
      end
      object pnlTopo: TPanel
        Left = 0
        Top = 0
        Width = 1130
        Height = 41
        Align = alTop
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 0
        object Label52: TLabel
          Left = 8
          Top = 14
          Width = 86
          Height = 14
          Caption = 'Regime Tribut'#225'rio:'
        end
        object cbxRegTrib: TComboBoxFocus
          Left = 99
          Top = 11
          Width = 178
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbxRegTribChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnReplicaRegTrib: TBitBtnLocked
          Left = 766
          Top = 11
          Width = 189
          Height = 22
          Caption = '&Replicar Para Demais Empresas'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000001000000050000000D0000000F00000005000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000020000000A170F093B72472CC3A1643DFF00000010000000000000
            0000000000000000000000000000000000000000000000000000000000010000
            00060604031955382594AB754CF9D5A670FFA56942FF00000022000000110000
            000D000000080000000300000000000000000000000000000000000000053525
            195F9A6A48E5CB9C6DFFE8C089FFE8C189FFA86F48FF88512EFC724125E4532E
            17B92F1A0D7B090502270000000700000001000000000000000000000008BD8D
            64FFECD4B3FFF1D8ACFFEBCA95FFEAC68FFFE7CBA4FFF2DBB9FFE1C39EFFC59D
            74FFA16F47FF512C16BE1B0E065200000008000000010000000000000004392C
            1F59A8815EE2DBBB97FFF3DFBDFFF0D4A6FFC69C74FFBB8B62FFC49870FFD3AE
            89FFE0C29BFFB78A60FF5C351CCB120A043E0000000400000000000000010000
            000407050415614B378CC39D76F9E7CEADFFC1936AFF060503242B21174E644A
            359AB48F6BECD7B891FFAB7E56FF3C2110970000000A00000000000000020000
            00080000000B0000000F1A140F328A6C4FBBC79A70FF0000000C000000040000
            000C56412F86D2AD87FFD8BD9DFF60351CD50000000F00000000000000062379
            49F9237B4AFF247A4AFF030A06220000000900000009000000060000000A0000
            000B100C0927C5996FFFC4986EFFAE7C57F90000000D0000000000000005246E
            49CE5BC49EFF308E62FF0D311C7E00000008000000030000000A247B4AFF0A37
            1ABF020B053900000015000000110000000D000000030000000000000003194B
            32885BB691FF6DC3A6FF2F7A54EA103B229107190F470104021C267F4DFF34A5
            78FF17633BF9092B169101030218000000060000000100000000000000010919
            112F2C7451C07AC8AAFF8BD7BFFF56A886FF33875DFF207345FF3A976AFF6ADA
            BBFF4BC89FFF30966AFF145530E5061D0F5F0000000600000000000000000000
            00020E251A41266C4BB263BB96FF8AD3BAFFA8E7D6FFBAF3E7FFA4E4D2FF89EA
            D5FF77E1C6FF75DDBDFF80D7BCFF278551FF0000000A00000000000000000000
            000000000002050D091A17412D6A276D4CAD338E64DF3AA06FFB3AA271FF9EF0
            E0FFB4F1E5FF6EC5A3FF348B60E1102E1F5A0000000500000000000000000000
            000000000000000000010000000200000004000000050000000C3EA977FF9AE0
            C9FF4CAC82F81E52398902060415000000040000000100000000000000000000
            000000000000000000000000000000000000000000000000000541AF7DFF2D79
            56B70816102B0000000500000001000000000000000000000000}
          TabOrder = 1
          OnClick = btnReplicaRegTribClick
        end
      end
    end
    object tbsQuaSoc: TTabSheet
      Caption = '&5 - Quadro Societ'#225'rio'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 1130
        Height = 136
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label26: TLabel
          Left = 8
          Top = 10
          Width = 27
          Height = 14
          Caption = 'Nome'
        end
        object lblTipCgc: TLabel
          Left = 373
          Top = 9
          Width = 20
          Height = 14
          Caption = 'Tipo'
        end
        object lbl2: TLabel
          Left = 94
          Top = 50
          Width = 33
          Height = 14
          Caption = 'Cidade'
        end
        object lbl3: TLabel
          Left = 386
          Top = 50
          Width = 25
          Height = 14
          AutoSize = False
          Caption = 'UF'
        end
        object lbl4: TLabel
          Left = 9
          Top = 50
          Width = 71
          Height = 14
          Caption = #211'rg'#227'o Emissor'
        end
        object lbl5: TLabel
          Left = 425
          Top = 50
          Width = 46
          Height = 14
          Caption = 'Profiss'#227'o'
        end
        object lbl6: TColorLabel
          Left = 53
          Top = 108
          Width = 207
          Height = 14
          Caption = '(C)asado (S)olteiro (O)utros (M)aritalmente'
          CorDestaque = clRed
        end
        object lbl7: TLabel
          Left = 9
          Top = 89
          Width = 40
          Height = 14
          Caption = 'Est. Civil'
        end
        object LabelRg1: TLabelRg
          Left = 522
          Top = 9
          Width = 24
          Height = 14
          Caption = 'R.G.:'
          Pais = opcBrasil
        end
        object lblCgcCpf: TLabelCpf
          Left = 400
          Top = 9
          Width = 22
          Height = 14
          Caption = 'CPF:'
          Pais = opcBrasil
        end
        object edtNomSoc: TEditFocus
          Tag = 99
          Left = 8
          Top = 24
          Width = 361
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 60
          TabOrder = 0
          OnExit = edtNomSocExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNumR_G: TEditFocus
          Tag = 99
          Left = 520
          Top = 24
          Width = 105
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 13
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtOrgEmissor: TEditFocus
          Left = 8
          Top = 64
          Width = 81
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesCidSoc: TEditFocus
          Left = 143
          Top = 64
          Width = 242
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
        object edtCidSoc: TEditFocus
          Tag = 99
          Left = 93
          Top = 64
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = edtCidSocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtEstadoSoc: TEditFocus
          Left = 386
          Top = 64
          Width = 34
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtProfissao: TEditFocus
          Left = 424
          Top = 64
          Width = 201
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstCivil: TEditFocus
          Tag = 99
          Left = 8
          Top = 104
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 8
          OnExit = edtCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object pnlCgcCpf: TPanel
          Left = 371
          Top = 24
          Width = 150
          Height = 22
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object edtCgcCpf: TEditTipoCgcCpf
            Tag = 99
            Left = 0
            Top = 0
            Width = 25
            Height = 22
            Align = alLeft
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 0
            OnExit = edtCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskNumCpf: TMaskEditC_G_C_
            Tag = 99
            Left = 25
            Top = 0
            Width = 124
            Height = 22
            Align = alLeft
            EditMask = '>aa\.aaa\.aaa/aaaa-99;0;'
            MaxLength = 18
            TabOrder = 1
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
            strCgcCpf = '1'
          end
        end
        object btnAdicionarSoc: TBitBtnLocked
          Left = 540
          Top = 103
          Width = 84
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
          TabOrder = 9
          OnClick = btnAdicionarSocClick
        end
      end
      object dbgSocios: TDBGridCitel
        Left = 0
        Top = 136
        Width = 1130
        Height = 542
        Align = alClient
        DataSource = dtsSocios
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnEnter = dbgSociosEnter
        OnKeyDown = dbgSociosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'SOC_NOMSOC'
            Title.Caption = 'Nome'
            Width = 321
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_NUMCPF'
            Title.Caption = 'CGC/CPF'
            Width = 133
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_NUMR_G'
            Title.Caption = 'RG'
            Width = 104
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_ORGEMI'
            Title.Caption = 'Org.Emissor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_NOMCID'
            Title.Caption = 'Cidade'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_ESTADO'
            Title.Caption = 'UF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_PROFIS'
            Title.Caption = 'Profiss'#227'o'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_ESTCIV'
            Title.Caption = 'Est.Civil'
            Visible = True
          end>
      end
    end
    object TabSheet1: TTabSheet
      Caption = '&6 - Metas'
      ImageIndex = 4
      inline fraCadMetasEmpresa: TfraCadMetasEmpresaFrame
        Left = 0
        Top = 0
        Width = 1130
        Height = 678
        Align = alClient
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 1130
        ExplicitHeight = 678
        inherited pnlFundoFrame: TPanel
          Width = 1130
          Height = 678
          ExplicitWidth = 1130
          ExplicitHeight = 678
          inherited pnlGradeMeta: TPanel
            Width = 1128
            Height = 596
            ExplicitWidth = 1128
            ExplicitHeight = 596
            inherited cxGridMetas: TcxGrid
              Width = 1126
              Height = 594
              ExplicitWidth = 1126
              ExplicitHeight = 594
            end
          end
          inherited pnlHeaderMeta: TPanel
            Width = 1128
            ExplicitWidth = 1128
            inherited pnlLegMet: TPanel
              Width = 1126
              ExplicitWidth = 1126
            end
            inherited pnlEmpresa: TPanel
              inherited lblEmpresa: TLabel
                Height = 14
                ExplicitHeight = 14
              end
              inherited edtCodEmp: TEditFocus
                Height = 22
                ExplicitHeight = 22
              end
              inherited edtNomEmp: TEditFocus
                Height = 22
                ExplicitHeight = 22
              end
            end
            inherited pnlFiltros: TPanel
              inherited lblAno: TLabel
                Height = 14
                ExplicitHeight = 14
              end
              inherited edtAnoMet: TEditFocus
                Height = 22
                ExplicitHeight = 22
              end
            end
          end
        end
        inherited frxHelp: TfrxReport
          Datasets = <>
          Variables = <>
          Style = <>
        end
      end
    end
    object tbsImpPre: TTabSheet
      Caption = '&7 - Forma'#231#227'o de Pre'#231'os na inclus'#227'o de produtos'
      ImageIndex = 5
      object pnlDadosCusto: TPanel
        Left = 11
        Top = 9
        Width = 355
        Height = 176
        BevelOuter = bvNone
        TabOrder = 0
        object Label53: TLabel
          Left = 75
          Top = 7
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'ICMS Entrada (-):'
        end
        object Label54: TLabel
          Left = 252
          Top = 7
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label135: TLabel
          Left = 51
          Top = 29
          Width = 106
          Height = 14
          Alignment = taRightJustify
          Caption = 'Impostos Federais (-):'
        end
        object Label136: TLabel
          Left = 252
          Top = 29
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label55: TLabel
          Left = 83
          Top = 51
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'ICMS Sa'#237'da (+):'
        end
        object Label56: TLabel
          Left = 252
          Top = 51
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label57: TLabel
          Left = 49
          Top = 73
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Impostos Federais (+):'
        end
        object Label58: TLabel
          Left = 252
          Top = 73
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label66: TLabel
          Left = 21
          Top = 95
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais (+):'
        end
        object lblDesOpePer: TLabel
          Left = 252
          Top = 95
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label59: TLabel
          Left = 40
          Top = 117
          Width = 117
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tabela de Pre'#231'o Padr'#227'o:'
        end
        object Label60: TLabel
          Left = 29
          Top = 142
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem de Pre'#231'o Padr'#227'o:'
        end
        object Label61: TLabel
          Left = 252
          Top = 141
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object dbeIcmEnt: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 3
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ICMENT'
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
        object dbeSubFed: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 25
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_SUBFED'
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
        object dbeIcmSai: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 47
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_ICMSAI'
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
        object dbeImpFed: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 69
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_IMPFED'
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
        object dbeDesOpe: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 91
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_DESOPE'
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
        object dbeTabPad: TDBComboBoxFocus
          Tag = 99
          Left = 159
          Top = 114
          Width = 92
          Height = 22
          Style = csDropDownList
          DataField = 'EMP_TABPAD'
          DataSource = dtsTabela
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeMarPad: TDBEditFocus
          Tag = 99
          Left = 159
          Top = 137
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_MARPAD'
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
      end
    end
    object tbsForPre: TTabSheet
      Caption = '&8 - Fornecedores para Forma'#231#227'o de Pre'#231'os em todas as empresas'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlForPre: TPanel
        Left = 0
        Top = 645
        Width = 1130
        Height = 33
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnExcFor: TBitBtnLocked
          Left = 476
          Top = 8
          Width = 152
          Height = 22
          Caption = '[ DEL ] Exclui fornecedor'
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
          TabOrder = 0
          OnClick = btnExcForClick
        end
      end
      object cxgForPre: TcxGrid
        Left = 0
        Top = 0
        Width = 1130
        Height = 645
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgForPreView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgForPreViewEditKeyDown
          OnEditKeyPress = cxgForPreViewEditKeyPress
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para adicionar um novo fornecedor'
          NewItemRow.Visible = True
          OptionsData.Deleting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxgForPreCODFOR: TcxGridDBColumn
            Caption = 'C'#243'digo do Fornecedor'
            DataBinding.FieldName = 'EFR_CODFOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ValidateOnEnter = True
            SortIndex = 0
            SortOrder = soAscending
            Width = 114
          end
          object cxgForPreNOMFOR: TcxGridDBColumn
            Caption = 'Nome do Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            Width = 493
          end
        end
        object cxgForPreLevel1: TcxGridLevel
          GridView = cxgForPreView
        end
      end
    end
    object tbsInsSub: TTabSheet
      Caption = '&9 - Inscri'#231#227'o Estadual do Substituto Tribut'#225'rio'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgInsSub: TcxGrid
        Left = 0
        Top = 0
        Width = 1130
        Height = 678
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgInsSubView: TcxGridDBBandedTableView
          OnKeyDown = cxgInsSubViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 
                '>>> Clique aqui para informar a Inscri'#231#227'o Estadual para todos os' +
                ' estados <<<'
              Styles.Header = cxsHeader
              Width = 842
              OnHeaderClick = cxgInsSubViewBands0HeaderClick
            end>
          object cxgInsSubViewESTADO: TcxGridDBBandedColumn
            Caption = 'Estado de Destino'
            DataBinding.FieldName = 'EMP_ESTADO'
            RepositoryItem = cxrEstados
            Options.Editing = False
            Options.Filtering = False
            Options.FilteringFilteredItemsList = False
            Options.FilteringMRUItemsList = False
            Options.FilteringPopup = False
            Options.FilteringPopupMultiSelect = False
            Options.Moving = False
            Options.Sorting = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 369
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgInsSubViewINSSUB: TcxGridDBBandedColumn
            Caption = 'Inscri'#231#227'o Estadual'
            DataBinding.FieldName = 'EMP_INSSUB'
            HeaderGlyphAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringAddValueItems = False
            Options.FilteringFilteredItemsList = False
            Options.FilteringMRUItemsList = False
            Options.FilteringPopup = False
            Options.FilteringPopupMultiSelect = False
            Options.Moving = False
            Options.Sorting = False
            Width = 265
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgInsSubViewCADSIM: TcxGridDBBandedColumn
            Caption = 'Cad. Simplificado RICMS'
            DataBinding.FieldName = 'EMP_CADSIM'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderGlyphAlignmentHorz = taCenter
            Width = 208
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
        end
        object cxgInsSubLevel: TcxGridLevel
          GridView = cxgInsSubView
        end
      end
    end
    object tbsPerERF: TTabSheet
      Caption = '10 - Permiss'#227'o de Tipos de Movimento de Venda'
      Enabled = False
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgPerERF: TcxGrid
        Left = 0
        Top = 0
        Width = 1130
        Height = 608
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgPerERFView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'Permiss'#227'o de Tipos de Movimento de Venda'
              Width = 934
            end>
          object EMPDES: TcxGridDBBandedColumn
            Caption = 'C'#243'd.Emp.Dest.'
            DataBinding.FieldName = 'VEN_EMPDES'
            Options.Editing = False
            Options.Focusing = False
            Width = 78
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object NOMDES: TcxGridDBBandedColumn
            Caption = 'Empresa Destino'
            DataBinding.FieldName = 'VEN_EMPDES'
            RepositoryItem = cxrEmpDes
            Options.Editing = False
            Options.Focusing = False
            Width = 220
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object PERRET: TcxGridDBBandedColumn
            Caption = 'Permitir Retira'
            DataBinding.FieldName = 'VEN_PERRET'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 112
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object PERENT: TcxGridDBBandedColumn
            Caption = 'Permitir Entrega Imediata'
            DataBinding.FieldName = 'VEN_PERENT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 129
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object PERFUT: TcxGridDBBandedColumn
            Caption = 'Permitir Entrega Futura'
            DataBinding.FieldName = 'VEN_PERFUT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 116
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object PERTRE: TcxGridDBBandedColumn
            Caption = 'Permitir Transfer'#234'ncia de Estoque'
            DataBinding.FieldName = 'VEN_PERTRE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 178
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object PERMLJ: TcxGridDBBandedColumn
            Caption = 'Permitir Multi-Loja'
            DataBinding.FieldName = 'VEN_PERMLJ'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 101
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxgPerERFView
        end
      end
      object pnlLegeda: TPanel
        Left = 0
        Top = 608
        Width = 1130
        Height = 70
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lblLegen1: TLabel
          Left = 7
          Top = 6
          Width = 978
          Height = 28
          Caption = 
            '* Quando as op'#231#245'es '#39'PERMITIR RETIRA'#39' - '#39'PERMITIR ENTREGA IMEDIAT' +
            'A'#39' - '#39'PERMITIR ENTREGA FUTURA'#39' estiverem desmarcadas, a Empresa ' +
            'n'#227'o ser'#225' exibida na consulta do campo '#39'Empresa'#39' na digita'#231#227'o da ' +
            'venda. Ser'#225' poss'#237'vel digitar diretamente o c'#243'digo da Empresa e p' +
            'osteriormente liberado por senha.'
          WordWrap = True
        end
        object lblLegen2: TLabel
          Left = 7
          Top = 48
          Width = 1116
          Height = 14
          Caption = 
            '* Quando a op'#231#227'o '#39'PERMITIR TRANSFER'#202'NCIA ESTOQUE'#39' estiver desmar' +
            'cada, a Empresa n'#227'o ser'#225' exibida na listagem de Empresas para at' +
            'ender a Transfer'#234'ncia de Estoque, ao digitar um Or'#231'amento/Pedido' +
            ' para a pr'#243'pria Empresa.'
        end
      end
    end
    object tbsContabilidade: TTabSheet
      Caption = '11 - Contabilidade'
      ImageIndex = 10
      object gbFormaTributacao: TcxGroupBox
        Left = 0
        Top = 81
        Align = alClient
        Caption = 'Forma de Tributa'#231#227'o (Somente Empresas MATRIZ)'
        TabOrder = 0
        Height = 597
        Width = 1130
        object GridFormaTributacao: TcxGridCitel
          Left = 2
          Top = 90
          Width = 1126
          Height = 505
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          ExplicitHeight = 503
          object GridFormaTributacaoTableView: TcxGridDBTableViewCitel
            OnKeyDown = GridFormaTributacaoTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsFormTrib
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = ' '
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridFormaTributacaoTableViewTRI_CODEMP: TcxGridDBColumn
              Caption = 'TRIB_CODEMP'
              DataBinding.FieldName = 'TRI_CODEMP'
              Visible = False
              VisibleForCustomization = False
              Width = 65
            end
            object GridFormaTributacaoTableViewTRI_ANOEXE: TcxGridDBColumn
              Caption = 'Exerc'#237'cio'
              DataBinding.FieldName = 'TRI_ANOEXE'
              Width = 81
            end
            object GridFormaTributacaoTableViewTRI_FORMTR: TcxGridDBColumn
              Caption = 'Forma de Tributa'#231#227'o'
              DataBinding.FieldName = 'TRI_FORMTR'
              PropertiesClassName = 'TcxRadioGroupProperties'
              Properties.Columns = 2
              Properties.Items = <
                item
                  Caption = '1-Lucro Presumido'
                  Value = '1'
                end
                item
                  Caption = '2-Lucro Real (Trimestral)'
                  Value = '2'
                end
                item
                  Caption = '3-Lucro Real (Estimativa Mensal)'
                  Value = '3'
                end
                item
                  Caption = '4-Simples Nacional'
                  Value = '4'
                end>
              Width = 257
            end
            object GridFormaTributacaoTableViewTRI_INIATV: TcxGridDBColumn
              Caption = 'In'#237'cio das Atividades'
              DataBinding.FieldName = 'TRI_INIATV'
              PropertiesClassName = 'TcxDateEditProperties'
              Width = 138
            end
            object GridFormaTributacaoTableViewTRI_ENCERR: TcxGridDBColumn
              Caption = 'Encerramento Cont'#225'bil'
              DataBinding.FieldName = 'TRI_ENCERR'
              PropertiesClassName = 'TcxRadioGroupProperties'
              Properties.Columns = 2
              Properties.Items = <
                item
                  Caption = 'Anual'
                  Value = 'A'
                end
                item
                  Caption = 'Mensal'
                  Value = 'M'
                end
                item
                  Caption = 'Trimestral'
                  Value = 'T'
                end>
              Width = 275
            end
            object GridFormaTributacaoTableViewTRI_VALBAS: TcxGridDBColumn
              Caption = 'Valor Base/M'#234's Para Adicional - IRPJ'
              DataBinding.FieldName = 'TRI_VALBAS'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 194
            end
            object GridFormaTributacaoTableViewTRI_VLIRPJ: TcxGridDBColumn
              Caption = 'IRPJ'
              DataBinding.FieldName = 'TRI_VLIRPJ'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.0000'
              Width = 77
            end
            object GridFormaTributacaoTableViewTRI_ADIRPJ: TcxGridDBColumn
              Caption = 'Adicional - IRPJ'
              DataBinding.FieldName = 'TRI_ADIRPJ'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.0000'
              Width = 91
            end
            object GridFormaTributacaoTableViewTRI_VLCSLL: TcxGridDBColumn
              Caption = 'CSLL'
              DataBinding.FieldName = 'TRI_VLCSLL'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.0000'
              Width = 103
            end
          end
          object GridFormaTributacaoLevel: TcxGridLevel
            GridView = GridFormaTributacaoTableView
          end
        end
        object gbFormaTributacaoCampos: TPanel
          Left = 2
          Top = 19
          Width = 1126
          Height = 71
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label35: TLabel
            Left = 692
            Top = 3
            Width = 101
            Height = 14
            Caption = 'In'#237'cio das Atividades:'
          end
          object cxLabel1: TcxLabel
            Left = 3
            Top = 1
            Caption = 'Exerc'#237'cio:'
            Transparent = True
          end
          object edtTRI_ANOEXE: TEditFocus
            Left = 54
            Top = 0
            Width = 51
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 4
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 4
            TipoTexto = ttInteiro
          end
          object cxLabel2: TcxLabel
            Left = 108
            Top = 0
            Caption = 'Forma de Tributa'#231#227'o:'
            Transparent = True
          end
          object cxLabel3: TcxLabel
            Left = 420
            Top = 1
            Caption = 'Encerramento Cont'#225'bil:'
            Transparent = True
          end
          object cxLabel4: TcxLabel
            Left = 5
            Top = 40
            Caption = 'Valor Base/M'#234's Para Adicional - IRPJ:'
            Transparent = True
          end
          object edtTRI_VALBAS: TCurrencyEditFocus
            Left = 191
            Top = 39
            Properties.DisplayFormat = ' ,0.00;- ,0.00'
            StyleFocused.Color = clInfoBk
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            Width = 121
          end
          object cxGroupBox1: TcxGroupBox
            Left = 318
            Top = 24
            Caption = 'Al'#237'quotas Para Apura'#231#227'o'
            TabOrder = 5
            Height = 41
            Width = 447
            object cxLabel5: TcxLabel
              Left = 8
              Top = 17
              Caption = 'IRPJ:'
              Transparent = True
            end
            object edtTRI_VLIRPJ: TCurrencyEditFocus
              Left = 36
              Top = 15
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = ' ,0.0000;- ,0.0000'
              StyleFocused.Color = clInfoBk
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              Width = 93
            end
            object cxLabel6: TcxLabel
              Left = 134
              Top = 17
              Caption = 'Adicional - IRPJ:'
              Transparent = True
            end
            object edtTRI_ADIRPJ: TCurrencyEditFocus
              Left = 217
              Top = 15
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = ' ,0.0000;- ,0.0000'
              StyleFocused.Color = clInfoBk
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              Width = 93
            end
            object cxLabel7: TcxLabel
              Left = 315
              Top = 17
              Caption = 'CSLL:'
              Transparent = True
            end
            object edtTRI_VLCSLL: TCurrencyEditFocus
              Left = 349
              Top = 16
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = ' ,0.0000;- ,0.0000'
              StyleFocused.Color = clInfoBk
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              Width = 93
            end
          end
          object btnConfirmaFormaTrib: TBitBtnLocked
            Left = 767
            Top = 39
            Width = 84
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
            TabOrder = 10
            OnClick = btnConfirmaFormaTribClick
          end
          object edtTRI_FORMTR: TcxComboBox
            Left = 214
            Top = 0
            Properties.DropDownListStyle = lsEditFixedList
            Properties.Items.Strings = (
              '1-Lucro Presumido'
              '2-Lucro Real (Trimestral)'
              '3-Lucro Real (Estimativa Mensal)'
              '4-Simples Nacional')
            Properties.OnChange = edtTRI_FORMTRPropertiesChange
            TabOrder = 1
            Text = '1-Lucro Presumido'
            Width = 203
          end
          object edtTRI_ENCERR: TcxComboBox
            Left = 535
            Top = 0
            Enabled = False
            Properties.DropDownListStyle = lsEditFixedList
            Properties.Items.Strings = (
              'Anual'
              'Mensal'
              'Trimestral')
            TabOrder = 2
            Text = 'Trimestral'
            Width = 153
          end
          object btnCancelarFormaTrib: TBitBtnLocked
            Left = 851
            Top = 39
            Width = 84
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
            TabOrder = 11
            OnClick = btnCancelarFormaTribClick
          end
          object edtTRI_INIATV: TcxDateEdit
            Left = 796
            Top = 0
            TabOrder = 3
            Width = 136
          end
        end
      end
      object gbCamposContabilidade: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Alignment = alCenterCenter
        TabOrder = 1
        Height = 81
        Width = 1130
        object Label101: TLabel
          Left = 5
          Top = 11
          Width = 160
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Plano de Contas Cont'#225'bil:'
        end
        object Label106: TLabel
          Left = 56
          Top = 35
          Width = 109
          Height = 14
          Alignment = taRightJustify
          Caption = 'Natureza Juridica ECF:'
        end
        object lblIniCon: TLabel
          Left = 7
          Top = 59
          Width = 171
          Height = 14
          Alignment = taRightJustify
          Caption = 'In'#237'cio da Contabilidade pelo Autcom:'
        end
        object dbeTplAco: TDBEditFocus
          Tag = 99
          Left = 171
          Top = 7
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_TPLACO'
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
          OnKeyPress = dbeTplAcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object dbeNatJur: TDBEditFocus
          Tag = 99
          Left = 171
          Top = 32
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_NTJURI'
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
          TabOrder = 1
          OnKeyPress = dbeNatJurKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object edtDescricaoDoTipoDePlanoDeContaContabil: TEditFocus
          Left = 241
          Top = 7
          Width = 321
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
        object edtDescricaoNaturezaJuridica: TEditFocus
          Left = 241
          Top = 32
          Width = 321
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
        object dbeIniCon: TDBEditFocus
          Tag = 99
          Left = 184
          Top = 56
          Width = 106
          Height = 22
          CharCase = ecUpperCase
          DataField = 'EMP_INICON'
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
      end
    end
    object tbsContabilista: TTabSheet
      Caption = '12 - Contabilista'
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label117: TLabel
        Left = 50
        Top = 20
        Width = 107
        Height = 13
        AutoSize = False
        Caption = 'Nome do Contabilista:'
      end
      object Label118: TLabel
        Left = 50
        Top = 42
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CPF:'
      end
      object Label119: TLabel
        Left = 50
        Top = 67
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CRC:'
      end
      object Label120: TLabel
        Left = 50
        Top = 89
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CNPJ:'
      end
      object Label121: TLabel
        Left = 50
        Top = 135
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Complemento:'
      end
      object Label122: TLabel
        Left = 50
        Top = 111
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Endere'#231'o:'
      end
      object Label123: TLabel
        Left = 50
        Top = 181
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fone:'
      end
      object Label124: TLabel
        Left = 45
        Top = 203
        Width = 107
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'E-mail:'
      end
      object Label126: TLabel
        Left = 555
        Top = 157
        Width = 29
        Height = 13
        AutoSize = False
        Caption = 'CEP: '
      end
      object Label127: TLabel
        Left = 586
        Top = 110
        Width = 20
        Height = 13
        AutoSize = False
        Caption = 'N'#186':'
      end
      object Label128: TLabel
        Left = 382
        Top = 180
        Width = 55
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fax:'
      end
      object Label129: TLabel
        Left = 51
        Top = 157
        Width = 104
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Bairro:'
      end
      object Label113: TLabel
        Left = 72
        Top = 224
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd IBGE cidade:'
      end
      object Label114: TLabel
        Left = 405
        Top = 224
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
      end
      object dbeNomeContab: TDBEditFocus
        Left = 158
        Top = 14
        Width = 500
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_NOMCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCpfContab: TDBEditFocus
        Left = 158
        Top = 37
        Width = 215
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_CPFCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCrcContab: TDBEditFocus
        Left = 158
        Top = 60
        Width = 215
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_CRCCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCnpjContab: TDBEditFocus
        Left = 158
        Top = 83
        Width = 215
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_CGCCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEndContab: TDBEditFocus
        Left = 158
        Top = 106
        Width = 420
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_ENDCTB'
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
      object dbeComplContab: TDBEditFocus
        Left = 158
        Top = 129
        Width = 420
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_COMCTB'
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
      object dbeFoneContab: TDBEditFocus
        Left = 158
        Top = 175
        Width = 214
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_FONCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEmailContab: TDBEditFocus
        Left = 158
        Top = 198
        Width = 501
        Height = 22
        CharCase = ecLowerCase
        DataField = 'EMP_EMACTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumEndContab: TDBEditFocus
        Left = 608
        Top = 106
        Width = 51
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_NUMCTB'
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
      object dbeCepContab: TDBEditFocus
        Left = 587
        Top = 152
        Width = 72
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_CEPCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFaxContab: TDBEditFocus
        Left = 444
        Top = 175
        Width = 215
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_FAXCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeBairroContab: TDBEditFocus
        Left = 158
        Top = 152
        Width = 377
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_BAICTB'
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
      object dbeIbgeCidCtb: TDBEditFocus
        Tag = 99
        Left = 158
        Top = 221
        Width = 79
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EMP_IBGCTB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 12
        OnKeyPress = dbeIbgeCidCtbKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
        OnChamaCadastro = dbeCidadeChamaCadastro
      end
      object edtCidContab: TEditFocus
        Left = 239
        Top = 221
        Width = 160
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtEstContab: TEditFocus
        Left = 444
        Top = 221
        Width = 46
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 685
    Top = 327
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 828
    Top = 353
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 440
  end
  object cldCores: TColorDialog
    Left = 820
    Top = 408
  end
  object qryConEmp: TUniQuery
    Connection = frmModulo.Database
    Left = 356
    Top = 580
  end
  object dtsConEmp: TDataSource
    DataSet = cdsConEmp
    Left = 816
    Top = 300
  end
  object qryCadEmp: TUniQuery
    Connection = frmModulo.Database
    Left = 460
    Top = 463
  end
  object cxRepositorio: TcxEditRepository
    Left = 596
    Top = 500
    PixelsPerInch = 96
    object cxrTipOpe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Venda'
          Value = '1'
        end
        item
          Caption = 'Transfer'#234'ncia'
          Value = '2'
        end
        item
          Caption = 'Dep'#243'sito Fechado'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object cxrEmpDes: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'EMP_CODEMP'
      Properties.ListColumns = <
        item
          FieldName = 'EMP_NOMEMP'
        end>
      Properties.ListSource = dtsCadEmp
    end
    object cxrSimNao: TcxEditRepositoryCheckBoxItem
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
    object cxrCadCta: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CTA_CODCTA'
      Properties.ListColumns = <
        item
          FieldName = 'CTA_DESCTA'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsCadCta
    end
    object cxrUltPis: TcxEditRepositoryCheckBoxItem
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
    object cxrUltICM: TcxEditRepositoryCheckBoxItem
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
    object cxrFat_TE: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.0000;(,0.0000)'
      Properties.EditFormat = '#,##0.0000'
      Properties.UseThousandSeparator = True
      Properties.OnValidate = cxrFat_TEPropertiesValidate
    end
    object cxrEstados: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <>
    end
    object cxlTeprev: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 200
      Properties.KeyFieldNames = 'TEP_CODIGO'
      Properties.ListColumns = <
        item
          Caption = 'Pr.Transf.n'#227'o Promoc.'
          FieldName = 'TEP_DESCRI'
        end>
      Properties.ListSource = dtsTeprev
    end
    object cxlTeppro: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 200
      Properties.KeyFieldNames = 'TEP_CODIGO'
      Properties.ListColumns = <
        item
          Caption = 'Pr.Transf. Promoc.'
          FieldName = 'TEP_DESCRI'
        end>
      Properties.ListSource = dtsTepPro
    end
    object cxlTepdef: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 200
      Properties.KeyFieldNames = 'TEP_CODIGO'
      Properties.ListColumns = <
        item
          Caption = 'Pr.Transf. Dep. Fechado'
          FieldName = 'TEP_DESCRI'
        end>
      Properties.ListSource = dtsTeprev
    end
  end
  object dtsCadEmp: TDataSource
    DataSet = qryCadEmp
    Left = 460
    Top = 495
  end
  object cdsConEmp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConEmp'
    BeforePost = cdsConEmpBeforePost
    Left = 524
    Top = 540
  end
  object dspConEmp: TUniDataSetProvider
    DataSet = qryConEmp
    Options = []
    Left = 468
    Top = 548
  end
  object cxStyleRepositorio: TcxStyleRepository
    Left = 692
    Top = 549
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxsHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsSocios: TDataSource
    DataSet = cdsSocios
    Left = 388
    Top = 407
  end
  object cdsSocios: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 492
    Top = 415
    object cdsSociosSOC_NOMSOC: TStringField
      FieldName = 'SOC_NOMSOC'
      Size = 60
    end
    object cdsSociosSOC_NUMR_G: TStringField
      FieldName = 'SOC_NUMR_G'
      Size = 15
    end
    object cdsSociosSOC_NUMCPF: TStringField
      DisplayWidth = 18
      FieldName = 'SOC_NUMCPF'
      Size = 18
    end
    object cdsSociosSOC_CIDSOC: TStringField
      FieldName = 'SOC_CIDSOC'
      Size = 5
    end
    object cdsSociosSOC_CGCCPF: TIntegerField
      FieldName = 'SOC_CGCCPF'
    end
    object cdsSociosSOC_ORGEMI: TStringField
      FieldName = 'SOC_ORGEMI'
      Size = 10
    end
    object cdsSociosSOC_PROFIS: TStringField
      FieldName = 'SOC_PROFIS'
      Size = 60
    end
    object cdsSociosSOC_ESTCIV: TStringField
      FieldName = 'SOC_ESTCIV'
      Size = 1
    end
    object cdsSociosSOC_NOMCID: TStringField
      FieldName = 'SOC_NOMCID'
      Size = 60
    end
    object cdsSociosSOC_ESTADO: TStringField
      FieldName = 'SOC_ESTADO'
      Size = 2
    end
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    OnDataChange = dtsTabelaDataChange
    Left = 708
    Top = 287
  end
  object dtsCadCta: TDataSource
    Left = 563
    Top = 296
  end
  object dsRegTri: TDataSource
    Left = 696
    Top = 473
  end
  object qryTeprev: TUniQuery
    Connection = frmModulo.Database
    Left = 220
    Top = 399
  end
  object dtsTeprev: TDataSource
    DataSet = qryTeprev
    Left = 292
    Top = 399
  end
  object qryTepPro: TUniQuery
    Connection = frmModulo.Database
    Left = 196
    Top = 455
  end
  object dtsTepPro: TDataSource
    DataSet = qryTepPro
    Left = 292
    Top = 439
  end
  object FileOpenCertificadoPFX: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Certificado PFX'
        FileMask = '*.pfx'
      end>
    Options = []
    Left = 684
    Top = 412
  end
  object dtsEmpCat: TDataSource
    DataSet = cdsEmpCat
    Left = 604
    Top = 231
  end
  object cdsEmpCat: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsEmpCatBeforePost
    Left = 663
    Top = 231
    object cdsEmpCatAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEmpCatCAT_CODEMP: TStringField
      FieldName = 'CAT_CODEMP'
      Size = 3
    end
    object cdsEmpCatCAT_NUMANO: TIntegerField
      FieldName = 'CAT_NUMANO'
    end
    object cdsEmpCatCAT_NUMMES: TIntegerField
      FieldName = 'CAT_NUMMES'
    end
    object cdsEmpCatCAT_TOTVAL: TFloatField
      FieldName = 'CAT_TOTVAL'
    end
    object cdsEmpCatIDF_STATUS: TStringField
      FieldName = 'IDF_STATUS'
    end
    object cdsEmpCatMESANO: TStringField
      FieldName = 'MESANO'
      Size = 7
    end
    object cdsEmpCatCAT_TOTVA2: TFloatField
      FieldName = 'CAT_TOTVA2'
    end
  end
  object cdsFormTrib: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IndicePk'
        Fields = 'TRI_ANOEXE'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'IndicePk'
    Params = <>
    StoreDefs = True
    Left = 412
    Top = 320
    object cdsFormTribTRI_CODEMP: TStringField
      FieldName = 'TRI_CODEMP'
      Size = 3
    end
    object cdsFormTribTRI_ANOEXE: TIntegerField
      FieldName = 'TRI_ANOEXE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsFormTribTRI_FORMTR: TStringField
      FieldName = 'TRI_FORMTR'
      Size = 1
    end
    object cdsFormTribTRI_ENCERR: TStringField
      FieldName = 'TRI_ENCERR'
      Size = 1
    end
    object cdsFormTribTRI_VALBAS: TFloatField
      FieldName = 'TRI_VALBAS'
    end
    object cdsFormTribTRI_VLIRPJ: TFloatField
      FieldName = 'TRI_VLIRPJ'
    end
    object cdsFormTribTRI_ADIRPJ: TFloatField
      FieldName = 'TRI_ADIRPJ'
    end
    object cdsFormTribTRI_VLCSLL: TFloatField
      FieldName = 'TRI_VLCSLL'
    end
    object cdsFormTribTRI_INIATV: TDateField
      FieldName = 'TRI_INIATV'
    end
  end
  object dsFormTrib: TDataSource
    AutoEdit = False
    DataSet = cdsFormTrib
    Left = 412
    Top = 368
  end
  object dlgArquivoExcel: TOpenDialog
    Filter = 'Excel|*.xls|Excel|*.xlsx|CSV|*.csv'
    Left = 596
    Top = 165
  end
end
