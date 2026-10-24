inherited frmConsultoriaFiscalSaneamento: TfrmConsultoriaFiscalSaneamento
  Width = 1024
  Height = 700
  Caption = 'Consultoria fiscal saneamento - IMendes'
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 629
    Width = 1018
    Height = 26
    ExplicitTop = 629
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 862
      Height = 22
      ExplicitWidth = 862
      ExplicitHeight = 22
      object btnExpandir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 89
        Height = 22
        Align = alLeft
        Caption = '&Expandir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000002000000080000000C0000000D0000000D00000008000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000007674337BF8E5E4DFF8E5D4CFF8E5C4BFF644036BF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000009A67667FFE5D6CDFFE5D5CCFFE4D5CBFFA47463FF000000000000
          00000000000000000000000000000000000000000000000000004E362CFF4E35
          2CFF4C332BFFAB7C6CFFF3EBE7FFF3EBE6FFF3EBE6FFA87A69FF000000000000
          000000000000000000000000000000000000000000000000000050372EFF0000
          000000000004825F54C1AF8171FFAD8070FFAD806EFF7F5E51C2000000000000
          000000000000000000000000000000000000000000000000000052382FFF0000
          0000000000030000000B0000001100000013000000130000000C000000000000
          0000000000000000000000000000000000000000000000000000543A31FF0000
          00000000000779584CBFA67C6BFFA67B6AFFA67A69FF76574BBF000000000000
          0000000000000000000000000000000000000000000000000000563B32FF0000
          000000000009BB9486FFE5D6CDFFE5D5CCFFE4D5CBFFBA9283FF000000000000
          0000000000000000000000000000000000000000000000000000583D34FF573D
          33FF543B31FFBF998BFFF3EBE7FFF3EBE6FFF3EBE6FFBD9788FF000000000000
          00000000000000000000000000000000000000000000000000005A3F35FF0000
          00000000000490756AC1C29D8FFFC19C8EFFC19C8DFF8E7367C2000000000000
          00000000000000000000000000000000000000000000000000005B4037FF0000
          0000000000010000000300000005000000060000000600000004000000000000
          000000000000000000000000000000000002000000080000000C593F35FF0000
          000D000000080000000200000000000000000000000000000000000000000000
          00003B2822C200000000000000000000000779584CBFA67C6BFFA67B6AFFA67A
          69FF76574BBF0000000800000000000000000000000000000000000000003E2B
          24C251372FFF3D2923C20000000000000009BB9486FFE5D6CDFFE5D5CCFFE4D5
          CBFFBA9283FF0000000A00000000000000000000000000000000412D26C2553B
          31FF533A31FF523930FF3E2B25C200000008BF998BFFF3EBE7FFF3EBE6FFF3EB
          E6FFBD9788FF0000000900000000000000000000000000000000000000000000
          00000000000000000000000000000000000490756AC1C29D8FFFC19C8EFFC19C
          8DFF8E7367C20000000500000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnExpandirClick
      end
      object btnRecolher: TBitBtnLocked
        Left = 89
        Top = 0
        Width = 89
        Height = 22
        Align = alLeft
        Caption = '&Recolher'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000030000
          0009000000090000000300000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000080908
          57C5080756C902020A270000000E000000110000001300000015000000140000
          00110000000C0000000500000001000000000000000000000000000000081312
          76D14551CCFF15136CDF5E4E51AC72483BCD7A4839DE915644FF774436DE693C
          30CE3A2019870704032B00000010000000040000000000000000000000050909
          12342D2C93F24B56D2FF36338EFFCDC5C9FFDECFCAFFEFE6E3FFDDCAC4FFD3BC
          B5FFB48B7FFF895140F540231B9200000018000000050000000101020414593C
          33A0C8B7BCFF4443ADFF4E5AD4FF393895FF9D9194FF604236FF755B4EFFBEAE
          A7FFEBE2DEFFE5D8D3FFB79085FF4E2A21A90101021A000000032F23246BB58D
          80FFF7F4F3FFE1DFE7FF4546ACFF505DD5FF3C3A98FFC6BAB9FFB29A87FF7F62
          51FFC0B0A9FFECE3DFFFECE2DFFFA37467FF28191A750000000A5E4F60E1BCB1
          ACFFF6F3F3FFF6F3F2FFA7999DFF4848ADFF5361D6FF353595FFA29799FFBBA7
          94FF806658FFEEE5E2FFECE2DFFFB1A29CFF503F50E40000000D182C4D885C63
          72FFB2B0B0FFF1EEEDFF795B4CFFD8D2CFFF4647ADFF5564D8FF393A9CFFCEC7
          C4FF7A5D4DFFEBE3E1FFABA6A3FF505566FF142A55AA0000000A05080F21395F
          9DFA697F9AFF626160FF55443CFFB6AC99FFDCDAD4FF4648AEFF5867DAFF4447
          A8FF968E93FF666363FF4E6586FF2F5191FF050B173C00000004000000031221
          3B685A7FB7FFA6C5E3FF7990ABFF444D59FF494D53FF84838AFF474CB3FF5B6B
          DCFF434AAFFFA6B9D7FF4467A3FD0B172E630000000600000000000000000000
          00030F1B3159315593ED6F91C1FF9BB9DCFFB0CDE9FFCDE8FBFFC0D1E8FF515A
          C1FF5C6EDCFF424BB4FE2F375080000000070000000100000000000000000000
          0000000000020204071112223E6F1C3765B0213F76D0274C91FC284479D25F70
          96D13C45B0EC5F71DFFF2B3196D303040C180000000100000000000000000000
          0000000000000000000000000002000000030000000400000005000000050000
          000505060F19333AA0D18C99E7FF272D90C80000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000104050E152E3594C12C3191BF0000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000010000000000000000}
        TabOrder = 1
        OnClick = btnRecolherClick
      end
      object btnCarregarConsulta: TBitBtnLocked
        Left = 178
        Top = 0
        Width = 253
        Height = 22
        Align = alRight
        Caption = 'Visualizar/Carregar Consultas Realizadas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000090000
          000E000000100000001000000010000000100000001000000011000000110000
          001100000011000000100000000B00000003000000000000000017417CCA2159
          A8FF225BAAFF225AAAFF2159A9FF2158A9FF2057A8FF2057A7FF2055A7FF1F55
          A7FF1F54A6FF1E53A6FF1E52A4FF1A458DE303080F2900000002225DA8FF2F6B
          B0FF579AD3FF71BEECFF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
          E1FF389BE0FF369AE0FF3498DFFF2875C1FF0F284E8B000000082868B1FF4884
          BFFF4489C7FF9CD8F5FF63B9EBFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
          E5FF47A6E4FF44A4E4FF41A2E3FF3991D7FF1B4787D50000000D2C6FB7FF6CA7
          D2FF3C87C6FFA0D4EFFF94D5F4FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
          EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2967B4FF040B142F2F75BCFF8FC7
          E6FF4FA0D5FF7FBCE2FFC3EEFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
          EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF408ACAFF112C4E81327CBFFFAFE3
          F5FF75C8EDFF55A3D7FFD2F5FDFFD4F6FEFFD2F4FEFFCDF3FDFFC8F1FDFFC2EE
          FCFFBCEBFBFFB5E7FAFFADE3F9FFA5DFF8FF82C0E6FF1E5189CB3582C4FFC7F5
          FEFF97E5FCFF62BBE7FF4AA0D6FF4A9DD5FF91C3E3FF8DBCDCFF8FBDE0FF5FA3
          D6FF4394CFFF4292CEFF2D73BAFF2D72B9FF2C71B8FF2765A7EA3688C8FFCDF7
          FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFFBBE6F3FFA68E78FFA6BABDFFB2E1
          F3FFB9E6F7FFB3E0F0FF8EADD1FF000000180000000B00000007398ECBFFD0F8
          FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFD3EDF3FFAD744CFF9A6841FFBEB8
          ADFFD1E1E3FF975D32FF8A6E59FF0C07032E00000007000000013B92CEFFD3F9
          FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF9CC3E0FFAD886CFFDBB891FFB07F
          53FF9B643AFF9F663DFFDBB67EFF8E5D33EF311D0F67000000063D97D1FFE2FC
          FEFFE2FCFEFFE1FCFEFFD3F3FAFF428FC1EC0B111523382A1E58C49870FFEAD2
          B1FFFCF0D0FFFEF2D3FFFEE9BBFFF7E6C5FFA36C43FF000000082E739DBF3E9A
          D3FF3E99D3FF3E99D3FF3E97D2FF143245590000000200000003382C204E9877
          58CABF946DFAC3966DFFEAD3B4FFB7906CEE3D2E215B00000003000000020000
          0003000000030000000400000003000000020000000000000000000000010000
          000200000005CAA27AFF846A50AC110D0A1B0000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000001000000000000000000000000}
        TabOrder = 2
        OnClick = btnCarregarConsultaClick
      end
      object btnExportacoes: TBitBtnLocked
        Left = 431
        Top = 0
        Width = 130
        Height = 22
        Align = alLeft
        Caption = '&Exporta'#231#245'es'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000002000000090000000C0000000C0000000C0000
          000D0000000D0000000D0000000C000000070000000200000000000000000000
          0000000000000000000000000008975B36FF975B36FF975B36FF975B36FF1563
          40FF156340FF156340FF156340FF0B32208E0000000600000000000000000000
          0000000000000000000000000008A96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
          52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF0000001200000006000000000000
          0002000000080000000C00000014A96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
          52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF184994FF0C254B8C000000000000
          000745312ABF60453BFFAFA29DFFA96F46FFFFF4C9FFFFF4C9FFEAD3A9FF1D78
          52FFA0FFECFFA0FFECFF80DEC6FF1D7852FF5FB7E5FF215CA7FF000000000000
          000A6F5347FF947869FFB4A6A2FFCEA988FFB88158FFB88158FFB88158FF7390
          66FF2CA074FF2CA074FF2CA074FF2CA074FF5FB7E5FF215CA7FF000000000000
          000A73574AFF987D6EFF938077FFFDFDFDFFF5F1EFFF6A7DDAFFA4BFFFFFA4BF
          FFFF89A4F7FF215CA7FFA8EFFFFFA8EFFFFF84D3F2FF215CA7FF000000000000
          0009785C4EFF9D8273FF765C50FFFFFFFFFFF9F6F3FFB0B8E4FF6A7EDAFF6A7E
          DAFF6A7EDAFF5384D1FF3B8BC7FF3B8BC7FF3B8BC7FF3B8BC7FF000000000000
          00087C6050FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFEFEFEFFFDFDFDFFFCFC
          FCFFB5A9A3FFB8AAA5FFAC9E9AFF0000000E0000000400000003000000000000
          00077F6354FFA78E7DFF977A6AFF967969FF957967FF84695CFF785D53FF775C
          51FF775C51FF775A50FF62463CFF000000090000000000000000000000000000
          0007836757FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF5941
          39FF584037FF795C52FF654A3FFF000000090000000000000000000000000000
          0006866A59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFE7D4C6FFE6D3C5FFE6D3
          C5FF5B433AFF7A5F54FF694E42FF000000080000000000000000000000000000
          0005886D5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFE8D7CAFFE7D5C8FFE6D4
          C6FF5E463EFF7C6156FF6C5145FF000000070000000000000000000000000000
          00048B705EFFB7A091FF70564DFFF6EFEAFFF5EDE8FFF4ECE6FFF4EBE4FFF3EA
          E3FF634A41FF7E6358FF715549FF000000060000000000000000000000000000
          0002675446BF8C715FFF755A50FF8D766CFF897369FF856D65FF81695FFF7C64
          5BFF674D45FF775B4DFF543F36C0000000030000000000000000000000000000
          0001000000020000000300000003000000030000000400000004000000040000
          0004000000040000000400000003000000010000000000000000}
        TabOrder = 3
        OnClick = btnExportacoesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
    end
    object btnLog: TBitBtnLocked
      Left = 864
      Top = 2
      Width = 75
      Height = 22
      Align = alRight
      Caption = 'L&og'
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
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1018
    ExplicitTop = 655
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 193
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object pnlCntFiltros: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 190
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 2
      ParentColor = True
      TabOrder = 0
      object Panel4: TPanel
        Left = 5
        Top = 2
        Width = 439
        Height = 188
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object grpProdutos: TGroupBox
          Left = 0
          Top = 0
          Width = 439
          Height = 145
          Align = alTop
          Caption = 'Produto'
          TabOrder = 0
          object Label8: TLabel
            Left = 18
            Top = 89
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor:'
          end
          object Label2: TLabel
            Left = 52
            Top = 66
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'NCM:'
          end
          object Label1: TLabel
            Left = 25
            Top = 42
            Width = 52
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o:'
          end
          object Label9: TLabel
            Left = 38
            Top = 19
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo: '
          end
          object Label11: TLabel
            Left = 9
            Top = 112
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Linha / Grupo:'
          end
          object edtCodFor: TEditFocus
            Tag = 99
            Left = 79
            Top = 85
            Width = 69
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 4
            OnExit = edtCodForExit
            OnKeyPress = edtCodForKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtNomFor: TEditFocus
            Left = 148
            Top = 85
            Width = 280
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
          object edtCodNCM: TEditFocus
            Tag = 99
            Left = 79
            Top = 62
            Width = 349
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 3
            OnExit = edtCodNCMExit
            OnKeyPress = edtCodNCMKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtDesIte: TEditFocus
            Tag = 99
            Left = 79
            Top = 39
            Width = 349
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCodIte: TEditFocus
            Tag = 99
            Left = 79
            Top = 16
            Width = 69
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
            TabOrder = 0
            OnExit = edtCodIteExit
            OnKeyPress = edtCodIteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIte2: TEditFocus
            Left = 148
            Top = 16
            Width = 280
            Height = 22
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskLinGru: TMaskEditFocus
            Tag = 99
            Left = 79
            Top = 108
            Width = 69
            Height = 22
            CharCase = ecUpperCase
            EditMask = '999.999;0;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 7
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
          object edtDesGru: TEditFocus
            Left = 148
            Top = 108
            Width = 280
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
        object grpEmpresa: TGroupBox
          Left = 0
          Top = 145
          Width = 439
          Height = 41
          Align = alTop
          Caption = 'Empresa'
          TabOrder = 1
          object Label6: TLabel
            Left = 71
            Top = 19
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa:'
          end
          object edtNomEmp: TEditFocus
            Left = 188
            Top = 13
            Width = 240
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
          object edtCodEmp: TEditFocus
            Tag = 99
            Left = 124
            Top = 13
            Width = 63
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
            MaxLength = 3
            ParentFont = False
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
        end
      end
      object Panel1: TPanel
        Left = 445
        Top = 1
        Width = 436
        Height = 187
        BevelOuter = bvNone
        TabOrder = 1
        object grpApresentacao: TGroupBox
          Left = 0
          Top = 153
          Width = 436
          Height = 34
          Align = alBottom
          TabOrder = 3
          object btnLimparFiltros: TBitBtnLocked
            Left = 263
            Top = 6
            Width = 81
            Height = 22
            Caption = '&Limpar'
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
            OnClick = btnLimparFiltrosClick
          end
          object btnConfirma: TBitBtnLocked
            Left = 347
            Top = 6
            Width = 81
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
            TabOrder = 0
            OnClick = btnConfirmaClick
          end
        end
        object grpICMS: TGroupBox
          Left = 0
          Top = 0
          Width = 436
          Height = 43
          Align = alTop
          Caption = 'ICMS'
          TabOrder = 0
          object Label10: TLabel
            Left = 59
            Top = 19
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o:'
          end
          object edtDesAbfICM: TEditFocus
            Left = 188
            Top = 16
            Width = 240
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
          object edtCodAbfIcm: TEditFocus
            Tag = 99
            Left = 124
            Top = 16
            Width = 63
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 7
            ParentCtl3D = False
            TabOrder = 0
            OnExit = edtCodAbfIcmExit
            OnKeyPress = edtCodAbfIcmKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
        end
        object grpPISCOF: TGroupBox
          Left = 0
          Top = 43
          Width = 436
          Height = 64
          Align = alTop
          Caption = 'PIS/COFINS'
          TabOrder = 1
          object Label45: TLabel
            Left = 4
            Top = 20
            Width = 114
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de COFINS:'
          end
          object Label74: TLabel
            Left = 26
            Top = 40
            Width = 92
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de PIS:'
          end
          object edtDesAbfCof: TEditFocus
            Left = 188
            Top = 14
            Width = 240
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
          object edtDesAbfPis: TEditFocus
            Left = 188
            Top = 37
            Width = 240
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
          object edtAbfCof: TEditFocus
            Tag = 99
            Left = 124
            Top = 14
            Width = 63
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 2
            OnExit = edtAbfCofExit
            OnKeyPress = edtAbfCofKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtAbfPis: TEditFocus
            Tag = 99
            Left = 124
            Top = 37
            Width = 63
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 3
            OnExit = edtAbfPisExit
            OnKeyPress = edtAbfPisKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
        end
        object grpIPI: TGroupBox
          Left = 0
          Top = 107
          Width = 436
          Height = 39
          Align = alTop
          Caption = 'IPI'
          TabOrder = 2
          object Label5: TLabel
            Left = 31
            Top = 16
            Width = 87
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de IPI:'
          end
          object edtAbfIpi: TEditFocus
            Tag = 99
            Left = 124
            Top = 13
            Width = 63
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnExit = edtAbfIpiExit
            OnKeyPress = edtAbfIpiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesAbfIpi: TEditFocus
            Left = 188
            Top = 13
            Width = 240
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
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 193
    Width = 1018
    Height = 436
    Align = alClient
    TabOrder = 3
    object pnlRodape: TPanel
      Left = 1
      Top = 404
      Width = 1016
      Height = 31
      Align = alBottom
      TabOrder = 0
      object Shape1: TShape
        Left = 139
        Top = 3
        Width = 14
        Height = 14
        Brush.Color = clBlue
      end
      object Label12: TLabel
        Left = 155
        Top = 3
        Width = 116
        Height = 14
        Caption = 'Valor atual do Cadastro '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        StyleElements = []
      end
      object Shape2: TShape
        Left = 9
        Top = 3
        Width = 14
        Height = 14
        Brush.Color = 25600
      end
      object Label13: TLabel
        Left = 28
        Top = 3
        Width = 96
        Height = 14
        Caption = 'Retorno da Imendes'
        Font.Charset = ANSI_CHARSET
        Font.Color = 25600
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        StyleElements = []
      end
      object Shape3: TShape
        Left = 277
        Top = 3
        Width = 14
        Height = 14
        Brush.Color = clRed
      end
      object Label14: TLabel
        Left = 297
        Top = 3
        Width = 63
        Height = 14
        Caption = 'Diverg'#234'ncias'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        StyleElements = []
      end
      object Label3: TLabel
        Left = 496
        Top = 8
        Width = 69
        Height = 14
        Caption = 'Localizar Item:'
      end
      object btnGerarAbreviacao: TBitBtnLocked
        Left = 863
        Top = 1
        Width = 152
        Height = 29
        Align = alRight
        Caption = 'Gerar Abrevia'#231#227'o Fiscal'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000002000000090000000C0000000C0000000C0000
          000D0000000D0000000D0000000C000000070000000200000000000000000000
          0000000000000000000000000008975B36FF975B36FF975B36FF975B36FF1563
          40FF156340FF156340FF156340FF0B32208E0000000600000000000000000000
          0000000000000000000000000008A96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
          52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF0000001200000006000000000000
          0002000000080000000C00000014A96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
          52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF184994FF0C254B8C000000000000
          000745312ABF60453BFFAFA29DFFA96F46FFFFF4C9FFFFF4C9FFEAD3A9FF1D78
          52FFA0FFECFFA0FFECFF80DEC6FF1D7852FF5FB7E5FF215CA7FF000000000000
          000A6F5347FF947869FFB4A6A2FFCEA988FFB88158FFB88158FFB88158FF7390
          66FF2CA074FF2CA074FF2CA074FF2CA074FF5FB7E5FF215CA7FF000000000000
          000A73574AFF987D6EFF938077FFFDFDFDFFF5F1EFFF6A7DDAFFA4BFFFFFA4BF
          FFFF89A4F7FF215CA7FFA8EFFFFFA8EFFFFF84D3F2FF215CA7FF000000000000
          0009785C4EFF9D8273FF765C50FFFFFFFFFFF9F6F3FFB0B8E4FF6A7EDAFF6A7E
          DAFF6A7EDAFF5384D1FF3B8BC7FF3B8BC7FF3B8BC7FF3B8BC7FF000000000000
          00087C6050FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFEFEFEFFFDFDFDFFFCFC
          FCFFB5A9A3FFB8AAA5FFAC9E9AFF0000000E0000000400000003000000000000
          00077F6354FFA78E7DFF977A6AFF967969FF957967FF84695CFF785D53FF775C
          51FF775C51FF775A50FF62463CFF000000090000000000000000000000000000
          0007836757FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF5941
          39FF584037FF795C52FF654A3FFF000000090000000000000000000000000000
          0006866A59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFE7D4C6FFE6D3C5FFE6D3
          C5FF5B433AFF7A5F54FF694E42FF000000080000000000000000000000000000
          0005886D5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFE8D7CAFFE7D5C8FFE6D4
          C6FF5E463EFF7C6156FF6C5145FF000000070000000000000000000000000000
          00048B705EFFB7A091FF70564DFFF6EFEAFFF5EDE8FFF4ECE6FFF4EBE4FFF3EA
          E3FF634A41FF7E6358FF715549FF000000060000000000000000000000000000
          0002675446BF8C715FFF755A50FF8D766CFF897369FF856D65FF81695FFF7C64
          5BFF674D45FF775B4DFF543F36C0000000030000000000000000000000000000
          0001000000020000000300000003000000030000000400000004000000040000
          0004000000040000000400000003000000010000000000000000}
        TabOrder = 0
        OnClick = btnGerarAbreviacaoClick
      end
      object edtLocItem: TEditFocus
        Left = 571
        Top = 4
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 1
        OnKeyPress = edtLocItemKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlOpcoesRetorno: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 176
      Align = alTop
      BevelOuter = bvNone
      Padding.Bottom = 2
      ParentColor = True
      TabOrder = 1
      Visible = False
      DesignSize = (
        1016
        176)
      object spbExpandCollapse: TSpeedButton
        Left = 905
        Top = 156
        Width = 109
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'Recolher Filtros'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000025190F3C573A248E8056
          35D099673FF9805635D0573A248E25190F3C0000000000000000000000000000
          0000000000000000000000000000000000003927195C926A47DCBE9265FFCFA1
          6FFFDAAC77FFCFA16FFFBE9265FF926A47DC3927195C00000000000000000000
          0000000000000000000000000000261A113C946E4DDCCBA276FFDEB17CFFDDAF
          79FFDDAF79FFDDAF79FFDEB17CFFCBA276FF946E4DDC261A113C000000000000
          00000000000000000000000000005A412B8EC5A07CFFE1B786FFDFB27EFFDFB2
          7EFFDFB27EFFDFB27EFFDFB27EFFE1B786FFC5A07CFF5A412B8E000000000000
          0000000000000000000000000000866244D0DABB97FFD09E69FFC48B54FFC48B
          54FFC48B54FFC48B54FFC48B54FFD09E69FFDABB97FF866244D0000000000000
          00000C1E173C1E47378E2B6851D0A37C58FFECD2B2FFC9935EFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC9935EFFECD2B2FFA27956F900000000142F
          255C2F785DDC339D76FF31AD80FF928A65FFE2CBB2FFDCB284FFD2A26FFFD2A2
          6FFFD2A26FFFD2A26FFFD2A26FFFDCB284FFE2CBB2FF89684CD00D20193C307D
          61DC33A87DFF2FB987FF30946FFF748060FFD0B8A1FFF2DDC2FFECCDA6FFE9C6
          9AFFE9C496FFE9C69AFFECCDA6FFF2DDC2FFD0B8A1FF5F4A368E214F3E8E37A4
          7CFF30BA88FF30BA88FF337C60FFFFFFFFFFA59477FFDECCB8FFF5E4CFFFF1DB
          BEFFF0D7B8FFF1DBBEFFF5E4CFFFDECCB8FF9E8369DC2820183C337960D03EB9
          91FF379976FF357F63FF357F63FFFFFFFFFF608364FFA69679FFD3BFABFFE9DC
          CDFFF8EFE4FFE9DCCDFFD3BFABFF9F856BDC3E31255C00000000409678F951D0
          ADFF388266FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF798667FF9B96
          74FFAA8967FF8C7054D0604C398E2820183C0000000000000000388368D062D0
          B4FF48A788FF3B866AFF3B866AFFFFFFFFFF3B866AFF3B866AFF48A788FF62D0
          B4FF388368D00000000000000000000000000000000000000000285C4A8E63C4
          A8FF7BE4CBFF6FDFC1FF408D71FFFFFFFFFF408D71FF6FDFC1FF7BE4CBFF63C4
          A8FF285C4A8E00000000000000000000000000000000000000001128203C489A
          7FDC76D3BAFF8EEAD5FF62B69DFF449276FF62B69DFF8EEAD5FF76D3BAFF489A
          7FDC1128203C0000000000000000000000000000000000000000000000001B3E
          325C4A9C81DC70CBB1FF87DEC8FF96EBD7FF87DEC8FF70CBB1FF4A9C81DC1B3E
          325C000000000000000000000000000000000000000000000000000000000000
          00001228213C2A604D8E3D8C71D049A888F93D8C71D02A604D8E1228213C0000
          0000000000000000000000000000000000000000000000000000}
        OnClick = spbExpandCollapseClick
        ExplicitLeft = 895
      end
      object Label15: TLabel
        Left = 603
        Top = 153
        Width = 32
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'P'#225'gina'
      end
      object lblTotal: TLabel
        Left = 704
        Top = 153
        Width = 3
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = '/'
      end
      object btnPerfis: TSpeedButton
        Left = 905
        Top = 135
        Width = 109
        Height = 21
        Anchors = [akRight, akBottom]
        Caption = 'Recolher Perfis '
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000025190F3C573A248E8056
          35D099673FF9805635D0573A248E25190F3C0000000000000000000000000000
          0000000000000000000000000000000000003927195C926A47DCBE9265FFCFA1
          6FFFDAAC77FFCFA16FFFBE9265FF926A47DC3927195C00000000000000000000
          0000000000000000000000000000261A113C946E4DDCCBA276FFDEB17CFFDDAF
          79FFDDAF79FFDDAF79FFDEB17CFFCBA276FF946E4DDC261A113C000000000000
          00000000000000000000000000005A412B8EC5A07CFFE1B786FFDFB27EFFDFB2
          7EFFDFB27EFFDFB27EFFDFB27EFFE1B786FFC5A07CFF5A412B8E000000000000
          0000000000000000000000000000866244D0DABB97FFD09E69FFC48B54FFC48B
          54FFC48B54FFC48B54FFC48B54FFD09E69FFDABB97FF866244D0000000000000
          00000C1E173C1E47378E2B6851D0A37C58FFECD2B2FFC9935EFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC9935EFFECD2B2FFA27956F900000000142F
          255C2F785DDC339D76FF31AD80FF928A65FFE2CBB2FFDCB284FFD2A26FFFD2A2
          6FFFD2A26FFFD2A26FFFD2A26FFFDCB284FFE2CBB2FF89684CD00D20193C307D
          61DC33A87DFF2FB987FF30946FFF748060FFD0B8A1FFF2DDC2FFECCDA6FFE9C6
          9AFFE9C496FFE9C69AFFECCDA6FFF2DDC2FFD0B8A1FF5F4A368E214F3E8E37A4
          7CFF30BA88FF30BA88FF337C60FFFFFFFFFFA59477FFDECCB8FFF5E4CFFFF1DB
          BEFFF0D7B8FFF1DBBEFFF5E4CFFFDECCB8FF9E8369DC2820183C337960D03EB9
          91FF379976FF357F63FF357F63FFFFFFFFFF608364FFA69679FFD3BFABFFE9DC
          CDFFF8EFE4FFE9DCCDFFD3BFABFF9F856BDC3E31255C00000000409678F951D0
          ADFF388266FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF798667FF9B96
          74FFAA8967FF8C7054D0604C398E2820183C0000000000000000388368D062D0
          B4FF48A788FF3B866AFF3B866AFFFFFFFFFF3B866AFF3B866AFF48A788FF62D0
          B4FF388368D00000000000000000000000000000000000000000285C4A8E63C4
          A8FF7BE4CBFF6FDFC1FF408D71FFFFFFFFFF408D71FF6FDFC1FF7BE4CBFF63C4
          A8FF285C4A8E00000000000000000000000000000000000000001128203C489A
          7FDC76D3BAFF8EEAD5FF62B69DFF449276FF62B69DFF8EEAD5FF76D3BAFF489A
          7FDC1128203C0000000000000000000000000000000000000000000000001B3E
          325C4A9C81DC70CBB1FF87DEC8FF96EBD7FF87DEC8FF70CBB1FF4A9C81DC1B3E
          325C000000000000000000000000000000000000000000000000000000000000
          00001228213C2A604D8E3D8C71D049A888F93D8C71D02A604D8E1228213C0000
          0000000000000000000000000000000000000000000000000000}
        OnClick = btnPerfisClick
        ExplicitLeft = 895
      end
      object SpeedButton2: TSpeedButton
        Left = 760
        Top = 156
        Width = 144
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'Desmarca todos Perfis'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
        OnClick = SpeedButton2Click
        ExplicitLeft = 750
      end
      object SpeedButton1: TSpeedButton
        Left = 760
        Top = 135
        Width = 144
        Height = 21
        Anchors = [akRight, akBottom]
        Caption = 'Marca Todos Perfis      '
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
        OnClick = SpeedButton1Click
        ExplicitLeft = 750
      end
      object grpFiltrosDiv: TGroupBox
        Left = 5
        Top = 125
        Width = 508
        Height = 48
        Anchors = [akLeft, akBottom]
        Caption = 'Filtrar Diverg'#234'ncias : '
        TabOrder = 0
        DesignSize = (
          508
          48)
        object chkDivICMS: TCheckBox
          Left = 5
          Top = 15
          Width = 49
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'ICMS'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = chkDivICMSClick
        end
        object chkInfGerais: TCheckBox
          Left = 74
          Top = 15
          Width = 75
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'Inf. Gerais'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = chkDivICMSClick
        end
        object chkSemIme: TCheckBox
          Left = 164
          Top = 15
          Width = 175
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'Item n'#227'o encontrado na Imendes'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = chkDivICMSClick
        end
        object chkRetparcial: TCheckBox
          Left = 357
          Top = 15
          Width = 137
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'Retorno Parcial Imendes'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = chkDivICMSClick
        end
        object chkCodbarInv: TCheckBox
          Left = 5
          Top = 30
          Width = 153
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'C'#243'digo de Barras Inv'#225'lido'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = chkDivICMSClick
        end
        object chkSemCst: TCheckBox
          Left = 164
          Top = 30
          Width = 138
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'Sem CST de Origem'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = chkDivICMSClick
        end
      end
      object clsFilterPerfil: TcxCheckListBox
        Left = 0
        Top = 0
        Width = 1016
        Height = 124
        Align = alTop
        Columns = 2
        IntegralHeight = True
        Items = <>
        ParentFont = False
        Style.BorderColor = clInactiveBorder
        Style.BorderStyle = cbsNone
        Style.Color = 16770261
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -11
        Style.Font.Name = 'Consolas'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        OnClick = clsFilterPerfilClick
        OnEditValueChanged = clsFilterPerfilEditValueChanged
      end
      object cxpPagina: TcxSpinEdit
        Left = 635
        Top = 150
        Anchors = [akLeft, akBottom]
        Properties.OnChange = cxSpinEdit1PropertiesChange
        TabOrder = 2
        Width = 63
      end
    end
    object pnlGridResultado: TPanel
      Left = 1
      Top = 177
      Width = 1016
      Height = 227
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 736
    Top = 112
  end
  object popOpSele: TPopupMenu
    Left = 660
    Top = 44
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
    end
  end
  object Timer1: TTimer
    Left = 696
    Top = 224
  end
  object dtsInfGerais: TDataSource
    Left = 688
    Top = 320
  end
  object dtsDados: TDataSource
    Left = 728
    Top = 320
  end
  object popMaisInfo: TPopupMenu
    Left = 592
    Top = 416
    object ItensComRetonoParcial1: TMenuItem
      Caption = 'Itens Com Retono Parcial'
      OnClick = ItensComRetonoParcial1Click
    end
    object SemCST1: TMenuItem
      Caption = 'Itens Sem CST de Origem'
      OnClick = SemCST1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object CdigoBarrasinvalidos1: TMenuItem
      Caption = 'Itens com C'#243'digo de Barras Inv'#225'lidos - Com Saldo de Estoque'#9' '
      OnClick = CdigoBarrasinvalidos1Click
    end
    object ItenscomCdigodeBarrasInvlidosTodososProdutos1: TMenuItem
      Caption = 'Itens com C'#243'digo de Barras Inv'#225'lidos - Todos os Produtos'
      OnClick = ItenscomCdigodeBarrasInvlidosTodososProdutos1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ItensnoencontradosnaImendes1: TMenuItem
      Caption = 
        'Itens com C'#243'd. Barras V'#225'lido N'#227'o Encontrados na Imendes - Com Sa' +
        'ldo de Estoque'
      OnClick = ItensnoencontradosnaImendes1Click
    end
    object ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1: TMenuItem
      Caption = 
        'Itens com C'#243'd. Barras V'#225'lido N'#227'o Encontrados na Imendes - Todos ' +
        'os Produtos'
      OnClick = ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1Click
    end
  end
end
