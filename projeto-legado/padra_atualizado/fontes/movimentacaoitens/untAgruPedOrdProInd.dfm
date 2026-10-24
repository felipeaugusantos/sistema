inherited frmAgruPedOrdProInd: TfrmAgruPedOrdProInd
  Width = 1024
  Height = 762
  Caption = 'Agrupamento de Pedidos para Ordem de Produ'#231#227'o'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 762
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 689
    Width = 1018
    ExplicitTop = 689
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 937
      ExplicitWidth = 937
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 129
        Height = 24
        Align = alLeft
        Caption = '&Confirmar'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000D0000000F0000000F0000000F0000000F0000000F0000000F0000000F0000
          000F0000000F00000010000000100000000F0000000A000000021D5A42C0287D
          5AFF277D5AFF277C5AFF277C59FF277B59FF277B58FF277A58FF267A58FF2678
          57FF267A56FF267856FF267755FF257756FF1B563DC1000000092B825FFF53C8
          A2FF51C7A0FF50C7A0FF4EC69FFF4DC59DFF4CC59DFF4AC49BFF49C39BFF47C3
          99FF45C298FF45C198FF43C096FF42C095FF277B59FF0000000D2C8664FF5DCC
          AAFF43C398FF42C299FF42C298FF43C298FF65CFADFF74D5B6FF4CC59DFF40C0
          95FF3EC095FF3EBF94FF3DBF94FF4BC49CFF297F5CFF0000000E2F8B68FF67D1
          B0FF48C69EFF48C59CFF47C59CFF5FCDABFF25825DFF00673BFF51BA96FF44C3
          9AFF43C399FF43C298FF42C298FF54C9A4FF2B8360FF0000000D31906DFF71D5
          B8FF4DC9A3FF4DC9A1FF60CFADFF3B9372FF87AF9DFFB1CFC1FF26875FFF53CA
          A5FF48C69EFF47C59DFF47C59DFF5DCEABFF2D8865FF0000000C339671FF7ADA
          BFFF52CCA7FF60D1AFFF4BA183FF699782FFF8F1EEFFF9F3EEFF357F5DFF5CBD
          9DFF4EC9A2FF4CC9A2FF4CC8A1FF67D2B2FF2F8C69FF0000000B359A76FF83DE
          C6FF59D0ADFF5AB094FF4F826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1C74
          4FFF69D5B4FF53CDA7FF52CCA6FF72D7B9FF32926EFF0000000B39A07CFF8CE2
          CBFF5FD4B3FF0D6742FFD2D2CBFF6A8F77FF136A43FF73967EFFF1E8E3FF72A2
          8BFF4CA384FF6AD9BAFF5AD2AFFF7BDBC0FF339773FF0000000A3AA681FF97E9
          D5FF69DEBFFF52BC9DFF0B6942FF389B79FF66DABAFF349773FF73967EFFF0EA
          E7FF4F886CFF60B89BFF67DABAFF87E2CAFF359C78FF000000093FAD88FF9FEC
          DAFF6DE1C3FF6DE1C3FF6DE0C2FF6CDFC1FF6BE0C1FF6BDFC0FF2C8966FF698E
          76FFE6E1DCFF176B47FF5FD1B2FF90E7D1FF3CA481FF0000000842B28DFFA5EE
          DDFF70E4C7FF70E4C6FF70E3C6FF6FE3C5FF6FE2C5FF6EE2C4FF6EE2C4FF3C9E
          7DFF1F6D4AFF2D8965FF6CE0C2FF97EAD6FF3DAA86FF0000000744B691FFAAEF
          E0FF73E6C9FF73E6C9FF72E5C9FF72E5C8FF71E5C8FF71E5C8FF71E4C7FF71E4
          C7FF64D3B5FF6DDFC2FF6FE3C6FF9EECDAFF41AF8BFF0000000746B994FFAEF1
          E2FF74E8CBFF74E7CBFF74E7CBFF74E7CAFF74E6CAFF73E6CAFF73E6CAFF73E6
          C9FF73E5C9FF72E5C9FF72E5C8FFA4EEDDFF42B38EFF0000000647BC97FFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFF44B792FF00000005348B70BF47BC
          97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BB97FF47BB
          97FF47BB96FF46BB96FF47BA95FF45BA94FF338A6EC000000003}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 129
        Top = 0
        Width = 129
        Height = 24
        Align = alLeft
        Caption = '&Marcar todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000000F00000010000000100000
          00100000001100000011000000100000000B0000000300000000000000000000
          0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
          BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
          000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
          E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
          000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
          C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
          000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
          E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
          000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
          77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
          000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
          4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
          00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
          9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
          00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
          B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
          00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
          C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
          0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
          6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
          0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
          D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
          00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
          A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
          00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
          AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
          00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
          64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
          00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
          1B44000000060000000600000006000000040000000100000000}
        TabOrder = 1
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 258
        Top = 0
        Width = 129
        Height = 24
        Align = alLeft
        Caption = '&Desmarcar todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000068057
          4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
          68FFB27967FFB17967FF7F5749BF00000007000000000000000000000008B57D
          6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFAF5F1FFFBF5
          F1FFFAF4F1FFFAF4F0FFB27B68FF0000000B000000000000000000000008B67F
          6DFFFCF8F5FFC79C8BFFC69B8BFFC59A8AFFC59A89FFC49888FFC49887FFC397
          87FFBA8B7AFFFBF5F2FFB47D6AFF0000000B000000000000000000000008B882
          6FFFFCF9F6FFF7EEE9FFF8EEE9FFF8EFE8FFF8EEE8FFF7EEE8FFF8EEE8FFF7ED
          E8FFF7EEE8FFFBF7F3FFB67F6DFF0000000A000000000000000000000007BA84
          73FFFDF9F8FFC8A090FFC89F8EFFC89E8DFFC79D8CFFC79C8BFFC69B8BFFC69A
          8AFFBC8E7DFFFCF8F5FFB88170FF0000000A000000000000000000000007BB87
          76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFF9F0EBFFF8EF
          EAFFF8F0EAFFFCF9F7FFB98473FF00000009000000000000000000000006BD8A
          78FFFDFBFAFFCBA695FFCAA494FFCAA393FFC9A291FFC8A191FFC8A08FFFC89F
          8EFFBF9381FFFDFAF8FFBB8675FF00000008000000000000000000000006BF8D
          7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
          EEFFF9F1EEFFFDFBF9FFBD8978FF00000008000000000000000000000005C190
          7EFFFEFDFCFFCFAA9BFFCEAA9AFFCEA998FFCDA797FFCBA494FFDCC5BBFFEAE0
          DCFFE2D1CBFFFAF9F8FFE1CDC6FF0000000F000000040000000100000005C393
          81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFAF6F4FFBCB7DBFF3B2E
          AEFF6D66B3FFEAE9ECFF665BA6FF160C7EEA0603244F0000000400000004C596
          84FFFEFEFEFFD9A87AFFD8A679FFD6A679FFD7A578FFEDE0D3FF4336B5FF6F85
          EAFF4150CBFF3A31A4FF3B48C9FF5C74E4FF180E82E70000000700000004C698
          87FFFFFEFEFFDEB487FFDFB387FFDEB386FFDEB386FFEDDCCBFF7970C3FF7780
          DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F0000000500000003C99B
          8AFFFFFEFEFFE0B688FFE0B688FFE0B588FFE0B588FFE4C3A1FFE8DED5FF4C45
          BAFF6A85EBFF7494F2FF6079E7FF262095E3010104130000000200000003CA9E
          8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFCFCFCFF807FD6FF6B7E
          E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA000000004000000029B7F
          74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFAA9CFFEFE5E1FF615FD6FFB1C3
          F6FF8D99EAFF5E5BD0FF8995E7FFA6B8F3FF3B35AEE300000004000000000000
          0001000000020000000300000003000000030000000300000004151537474B4B
          C5E63131829F020205112E2D809F4340BCE61212334600000002}
        TabOrder = 2
        OnClick = btnDesmarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 717
    Width = 1018
    ExplicitTop = 717
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
  object Notebook: TNotebook [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 689
    Align = alClient
    TabOrder = 2
    object TPage
      Left = 0
      Top = 0
      Caption = 'Principal'
      object Splitter1: TSplitter
        Left = 0
        Top = 521
        Width = 1018
        Height = 6
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 431
        ExplicitWidth = 800
      end
      object pnlFiltros: TPanel
        Left = 0
        Top = 0
        Width = 1018
        Height = 122
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 37
          Top = 9
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 177
          Top = 9
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 312
          Top = 9
          Width = 116
          Height = 14
          Caption = '(EMISS'#195'O DO PEDIDO)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 37
          Top = 32
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 176
          Top = 32
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 312
          Top = 33
          Width = 125
          Height = 14
          Caption = '(EMISS'#195'O DE ENTREGA)'
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
          Left = 94
          Top = 5
          Width = 70
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 229
          Top = 5
          Width = 70
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskIniEtr: TMaskEditFocus
          Tag = 99
          Left = 94
          Top = 28
          Width = 70
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskFinEtr: TMaskEditFocus
          Tag = 99
          Left = 229
          Top = 28
          Width = 70
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 3
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object pnlTipAte: TPanel
          Left = 0
          Top = 74
          Width = 1018
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          object lblTipAte: TLabel
            Left = 12
            Top = 5
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Atendim:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodTpa: TEditFocus
            Tag = 99
            Left = 94
            Top = 0
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
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            ParentFont = False
            TabOrder = 0
            OnExit = edtCodTpaExit
            OnKeyPress = edtCodTpaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesTpa: TEditFocus
            Left = 165
            Top = 0
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
        end
        object pnlEmpresa: TPanel
          Left = 0
          Top = 96
          Width = 1018
          Height = 26
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 6
          object lblEmpresa: TLabel
            Left = 46
            Top = 6
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
          object Label12: TLabel
            Left = 497
            Top = 6
            Width = 272
            Height = 14
            Caption = 'Pressione ENTER ou clique duplo para marcar um pedido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodEmp: TEditFocus
            Tag = 99
            Left = 94
            Top = 1
            Width = 35
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
          object edtDesEmp: TEditFocus
            Left = 130
            Top = 1
            Width = 315
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
          object btnFiltro: TBitBtnLocked
            Left = 448
            Top = 1
            Width = 44
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000001E1E
              1E7E00000000000000000707071D1A1A1A702B2B2BB7373737EA373737EA2B2B
              2BB71A1A1A700707071D00000000000000000000000000000000000000003C3C
              3CFF1E1E1E7E0D0D0D39292929B03C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
              3CFF3C3C3CFF292929B00D0D0D39000000000000000000000000000000003C3C
              3CFF3C3C3CFF333333D73C3C3CFF2D2D2DBF181818660707071F0707071F1818
              18662D2D2DBF3C3C3CFF292929B00707071D0000000000000000000000003C3C
              3CFF3C3C3CFF3C3C3CFF343434DF0C0C0C330000000000000000000000000000
              00000C0C0C332D2D2DBF3C3C3CFF1A1A1A700000000000000000000000003C3C
              3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000003C3C
              3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E00000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000001E1E
              1E7E3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF00000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00001E1E1E7E3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF00000000000000000000
              00001A1A1A703C3C3CFF2D2D2DBF0C0C0C330000000000000000000000000000
              00000C0C0C33343434DF3C3C3CFF3C3C3CFF3C3C3CFF00000000000000000000
              00000707071D292929B03C3C3CFF2D2D2DBF181818660707071F0707071F1818
              18662D2D2DBF3C3C3CFF333333D73C3C3CFF3C3C3CFF00000000000000000000
              0000000000000D0D0D39292929B03C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
              3CFF3C3C3CFF292929B00D0D0D391E1E1E7E3C3C3CFF00000000000000000000
              000000000000000000000707071D1A1A1A702B2B2BB7373737EA373737EA2B2B
              2BB71A1A1A700707071D00000000000000001E1E1E7E00000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 2
            OnClick = btnFiltroClick
          end
        end
        object pnlRedLoj: TPanel
          Left = 0
          Top = 51
          Width = 1018
          Height = 23
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 4
          object lblRedLoj: TLabel
            Left = 19
            Top = 3
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Rede de Lojas:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtRedLoj: TEditFocus
            Tag = 99
            Left = 94
            Top = 0
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
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            ParentFont = False
            TabOrder = 0
            OnExit = edtRedLojExit
            OnKeyPress = edtRedLojKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesRedLoj: TEditFocus
            Left = 165
            Top = 0
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
        end
      end
      object cxgFatDor: TcxGrid
        Left = 0
        Top = 527
        Width = 1018
        Height = 162
        Align = alBottom
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableView: TcxGridDBTableView
          OnMouseLeave = cxgOrdDetDBTableViewMouseLeave
          OnMouseMove = cxGridDBTableViewMouseMove
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGridDBTableViewCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
          OptionsView.GroupByBox = False
          object cxGridDBTableViewCODITE: TcxGridDBColumn
            Caption = 'C'#243'd. Produto'
            DataBinding.FieldName = 'FDO_CODITE'
            Width = 76
          end
          object cxGridDBTableViewDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'FDO_DESCRI'
            Width = 257
          end
          object cxGridDBTableViewCOMPLE: TcxGridDBColumn
            Caption = 'Complemento'
            DataBinding.FieldName = 'FDO_COMPLE'
            Width = 92
          end
          object cxGridDBTableViewUNIDAD: TcxGridDBColumn
            Caption = 'UN.'
            DataBinding.FieldName = 'FDO_UNIDAD'
            Width = 39
          end
          object cxGridDBTableViewENTRET: TcxGridDBColumn
            Caption = 'Tipo de Movimento'
            DataBinding.FieldName = 'ENTRET'
            Width = 141
          end
          object cxGridDBTableViewQTDITE: TcxGridDBColumn
            Caption = 'Qtde.'
            DataBinding.FieldName = 'FDO_QTDITE'
            Width = 64
          end
          object cxGridDBTableViewUNITAR: TcxGridDBColumn
            Caption = 'Unit'#225'rio'
            DataBinding.FieldName = 'FDO_UNITAR'
            Width = 67
          end
          object cxGridDBTableViewTOTITE: TcxGridDBColumn
            Caption = 'Total'
            DataBinding.FieldName = 'FDO_TOTITE'
            Width = 80
          end
          object cxGridDBTableViewSALDOS: TcxGridDBColumn
            Caption = 'Saldo Dispon'#237'vel'
            DataBinding.FieldName = 'ITE_SALDIS'
            Width = 110
          end
          object cxGridDBTableViewISALFIS: TcxGridDBColumn
            Caption = 'Saldo F'#237'sico'
            DataBinding.FieldName = 'ITE_SALFIS'
            Options.Editing = False
            Width = 110
          end
          object cxGridDBTableViewSALRES: TcxGridDBColumn
            Caption = 'Qtde. em Pedidos'
            DataBinding.FieldName = 'ITE_SALRES'
            Width = 100
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTableView
        end
      end
      object pnlObserv: TPanel
        Left = 0
        Top = 430
        Width = 1018
        Height = 91
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object dbtMsgPed: TDBText
          Left = 137
          Top = 6
          Width = 651
          Height = 25
          DataField = 'MSGPED'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object dbtMsgExp: TDBText
          Left = 155
          Top = 34
          Width = 632
          Height = 53
          DataField = 'MSGEXP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object lblMsgPed: TLabel
          Left = 9
          Top = 6
          Width = 123
          Height = 14
          Caption = 'Mensagem do pedido:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblMsgExp: TLabel
          Left = 9
          Top = 34
          Width = 140
          Height = 14
          Caption = 'Mensagem da expedi'#231#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pnlTotais: TPanel
        Left = 0
        Top = 416
        Width = 1018
        Height = 14
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object Label7: TLabel
          Left = 9
          Top = 1
          Width = 119
          Height = 14
          Caption = 'Total geral a produzir:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtPesoIt: TDBText
          Left = 134
          Top = 1
          Width = 73
          Height = 14
          Alignment = taRightJustify
          DataField = 'aggPESOIT'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 213
          Top = 1
          Width = 15
          Height = 14
          Caption = 'KG'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 281
          Top = 1
          Width = 125
          Height = 14
          Caption = 'Pedidos selecionados:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtQtdSel: TDBText
          Left = 408
          Top = 1
          Width = 33
          Height = 14
          Alignment = taRightJustify
          DataField = 'aggQTDMAR'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 489
          Top = 1
          Width = 158
          Height = 14
          Caption = 'Total selecionado a produzir:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbtPesoMa: TDBText
          Left = 650
          Top = 1
          Width = 73
          Height = 14
          Alignment = taRightJustify
          DataField = 'aggPESOMA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 729
          Top = 1
          Width = 15
          Height = 14
          Caption = 'KG'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object cxgFatGor: TcxGrid
        Left = 0
        Top = 122
        Width = 1018
        Height = 294
        Align = alClient
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgFatGorDBTableView: TcxGridDBTableView
          OnDblClick = cxgFatGorDBTableViewDblClick
          OnMouseLeave = cxgOrdDetDBTableViewMouseLeave
          OnMouseMove = cxgFatGorDBTableViewMouseMove
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgFatGorDBTableViewCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
          OptionsView.GroupByBox = False
          object cxgFatGorDBTableViewMARDES: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'MARDES'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = imgLista
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end>
            Width = 23
          end
          object cxgFatGorDBTableViewNUMDOC: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'FGO_NUMDOC'
            Width = 96
          end
          object cxgFatGorDBTableViewCODEMP: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'FGO_CODEMP'
            Width = 32
          end
          object cxgFatGorDBTableViewDTAENT: TcxGridDBColumn
            Caption = 'Data Pedido'
            DataBinding.FieldName = 'FGO_DTAENT'
            Width = 64
          end
          object cxgFatGorDBTableViewCODCLI: TcxGridDBColumn
            Caption = 'C'#243'd. Cliente'
            DataBinding.FieldName = 'FGO_CODCLI'
            Width = 65
          end
          object cxgFatGorDBTableViewNOMCLI: TcxGridDBColumn
            Caption = 'Nome Cliente'
            DataBinding.FieldName = 'CLI_NOMCLI'
            Width = 169
          end
          object cxgFatGorDBTableViewCODVEN: TcxGridDBColumn
            Caption = 'Vendedor'
            DataBinding.FieldName = 'FGO_CODVEN'
            Width = 53
          end
          object cxgFatGorDBTableViewDESCRI: TcxGridDBColumn
            Caption = 'Tipo Atendimento'
            DataBinding.FieldName = 'TPA_DESCRI'
            Width = 128
          end
          object cxgFatGorDBTableViewLIBERA: TcxGridDBColumn
            Caption = 'LIB.'
            DataBinding.FieldName = 'LIBERA'
            Width = 34
          end
          object cxgFatGorDBTableViewDTENTR: TcxGridDBColumn
            Caption = 'Data Entrega'
            DataBinding.FieldName = 'FGO_DTENTR'
            OnGetDataText = cxgFatGorDBTableViewDTENTRGetDataText
            Width = 82
          end
        end
        object cxgFatGorLevel1: TcxGridLevel
          GridView = cxgFatGorDBTableView
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Itens'
      object pnlItens: TPanel
        Left = 0
        Top = 0
        Width = 1018
        Height = 689
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 0
          Top = 289
          Width = 1018
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitLeft = 5
          ExplicitTop = 281
          ExplicitWidth = 794
        end
        object Splitter3: TSplitter
          Left = 829
          Top = 316
          Height = 373
          Align = alRight
          ExplicitLeft = 632
          ExplicitTop = 392
          ExplicitHeight = 100
        end
        object cxgOrdDet: TcxGrid
          Left = 0
          Top = 316
          Width = 829
          Height = 373
          Align = alClient
          TabOrder = 0
          OnExit = cxgOrdDetExit
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgOrdDetDBTableView: TcxGridDBTableView
            OnDblClick = cxgFatGorDBTableViewDblClick
            OnKeyPress = cxgOrdDetDBTableViewKeyPress
            OnMouseLeave = cxgOrdDetDBTableViewMouseLeave
            OnMouseMove = cxgFatGorDBTableViewMouseMove
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgFatGorDBTableViewCustomDrawCell
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
            OptionsView.GroupByBox = False
            object cxgOrdDetDBTableViewColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'ORD_CODITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 45
            end
            object cxgOrdDetDBTableViewDESITE: TcxGridDBColumn
              Caption = 'Produto'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 241
            end
            object cxgOrdDetCOMPLE: TcxGridDBColumn
              Caption = 'Complemento'
              DataBinding.FieldName = 'COMPLE'
              Options.Editing = False
              Options.Focusing = False
              Width = 92
            end
            object cxgOrdDetDBTableViewSIGUNI: TcxGridDBColumn
              Caption = 'UN'
              DataBinding.FieldName = 'SIGUNI'
              Options.Editing = False
              Options.Focusing = False
              Width = 24
            end
            object cxgOrdDetDBTableViewQTDPED: TcxGridDBColumn
              Caption = 'Qtd. Pedido'
              DataBinding.FieldName = 'QTDPED'
              Options.Editing = False
              Options.Focusing = False
              Width = 65
            end
            object cxgOrdDetDBTableViewQTDRST: TcxGridDBColumn
              Caption = 'Qtd. Pendente'
              DataBinding.FieldName = 'QTDRST'
              Width = 80
            end
            object cxgOrdDetDBTableViewESTOQUE_MAXIMO: TcxGridDBColumn
              Caption = 'Est.M'#225'x'
              DataBinding.FieldName = 'ESTOQUE_MAXIMO'
              Options.Editing = False
              Options.Focusing = False
              Width = 60
            end
            object cxgOrdDetDBTableViewESTOQUE_MINIMO: TcxGridDBColumn
              Caption = 'Est.M'#237'n'
              DataBinding.FieldName = 'ESTOQUE_MINIMO'
              Options.Editing = False
              Options.Focusing = False
              Width = 60
            end
            object cxgOrdDetDBTableViewESTOQUE_FISICO: TcxGridDBColumn
              Caption = 'Est.F'#237'sico'
              DataBinding.FieldName = 'ESTOQUE_FISICO'
              Options.Editing = False
              Options.Focusing = False
              Width = 60
            end
            object cxgOrdDetDBTableViewESTOQUE_DISPONIVEL: TcxGridDBColumn
              Caption = 'Est.Disp'
              DataBinding.FieldName = 'ESTOQUE_DISPONIVEL'
              Options.Editing = False
              Options.Focusing = False
              Width = 60
            end
            object cxgOrdDetDBTableViewSUGEST: TcxGridDBColumn
              Caption = 'Sugest'#227'o'
              DataBinding.FieldName = 'SUGEST'
              Options.Editing = False
              Options.Focusing = False
              Width = 60
            end
            object cxgOrdDetDBTableViewORD_QTDPRO: TcxGridDBColumn
              Caption = 'Qtd. Fabricar'
              DataBinding.FieldName = 'ORD_QTDPRO'
              PropertiesClassName = 'TcxMaskEditProperties'
              Properties.OnEditValueChanged = cxgOrdDetDBTableViewORD_QTDPROPropertiesEditValueChanged
              Width = 77
            end
            object cxgOrdDetDBTableViewESTUTI: TcxGridDBColumn
              Caption = 'Qtd. Estoque'
              DataBinding.FieldName = 'ESTUTI'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Action = SelLotes
                  Default = True
                  Kind = bkText
                end>
              Properties.ReadOnly = True
              Width = 75
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxgOrdDetDBTableView
          end
        end
        object cxgPedidos: TcxGrid
          Left = 832
          Top = 316
          Width = 186
          Height = 373
          Align = alRight
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgPedidosDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
            OptionsView.GroupByBox = False
            object cxgPedidosDBTableViewNUMDOC: TcxGridDBColumn
              Caption = 'Pedido'
              DataBinding.FieldName = 'NUMDOC'
              Width = 89
            end
            object cxgPedidosDBTableViewCODEMP: TcxGridDBColumn
              Caption = 'Emp.'
              DataBinding.FieldName = 'CODEMP'
              Width = 32
            end
            object cxgPedidosDBTableViewQTDITE: TcxGridDBColumn
              Caption = 'Qtde.'
              DataBinding.FieldName = 'QTDITE'
              Width = 43
            end
          end
          object cxGridLevel2: TcxGridLevel
            GridView = cxgPedidosDBTableView
          end
        end
        object cxgOrdPro: TcxGrid
          Left = 0
          Top = 0
          Width = 1018
          Height = 289
          Align = alTop
          TabOrder = 2
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgOrdProDBTableView: TcxGridDBTableView
            OnKeyUp = cxgOrdProDBTableViewKeyUp
            OnMouseLeave = cxgOrdDetDBTableViewMouseLeave
            OnMouseMove = cxgFatGorDBTableViewMouseMove
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgFatGorDBTableViewCustomDrawCell
            OnEditKeyDown = cxgOrdProDBTableViewEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
            OptionsView.GroupByBox = False
            object cxgOrdProDBTableViewMARCA: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'MARCA'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Properties.OnChange = cxgOrdProDBTableViewMARCAPropertiesChange
              HeaderAlignmentHorz = taCenter
              Width = 35
            end
            object cxgOrdProDBTableViewIMPRIM: TcxGridDBColumn
              Caption = 'I'
              DataBinding.FieldName = 'IMPRIM'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              Width = 35
            end
            object cxgOrdProDBTableViewColumn1: TcxGridDBColumn
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Action = ConfImpressao
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    424D360400000000000036000000280000001000000010000000010020000000
                    000000000000C40E0000C40E0000000000000000000000000000000000000000
                    000000000000000000000000000000000000000000000F0F0F40242424993535
                    35E0353535E0242424990F0F0F40000000000000000000000000000000000000
                    0000000000000000000000000000000000000F0F0F40303030CC3C3C3CFF0000
                    0000000000003C3C3CFF303030CC0F0F0F400000000000000000000000000000
                    00003C3C3CFF3C3C3CFF3C3C3CFF00000000242424993C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF3C3C3CFF242424990000000000000000000000000000
                    00003C3C3CFF3C3C3CFF3C3C3CFF00000000353535E03C3C3CFF3C3C3CFF0000
                    000000000000383838EF3C3C3CFF353535E0000000003C3C3CFF3C3C3CFF0000
                    00003C3C3CFF3C3C3CFF0000000000000000353535E03C3C3CFF3C3C3CFF3C3C
                    3CFF2D2D2DBF000000003C3C3CFF353535E0060606193C3C3CFF3C3C3CFF0000
                    00003C3C3CFF3C3C3CFF0000000000000000242424993C3C3CFF000000002D2D
                    2DBF2D2D2DBF000000003C3C3CFF24242499141414543C3C3CFF3C3C3CFF0000
                    0000000000000000000000000000000000000F0F0F40303030CC383838EF0000
                    000000000000383838EF303030CC0F0F0F40262626A33C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFE1E1E1E7F0F0F0F40242424993535
                    35E0353535E0242424990F0F0F401E1E1E7F3C3C3CFE3C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFE262626A3141414540606
                    06190606061914141454262626A3000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF0000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF0000
                    00003C3C3CFF3C3C3CFF00000000000000000000000000000000000000000000
                    00003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF0000
                    00003C3C3CFF3C3C3CFF00000000000000000000000000000000000000000000
                    00003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF00000000000000000000
                    00003C3C3CFF3C3C3CFF00000000000000000000000000000000000000000000
                    00003C3C3CFF3C3C3CFF00000000000000000000000000000000000000000000
                    00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF00000000000000000000000000000000000000000000
                    00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
                    3CFF3C3C3CFF3C3C3CFF000000000000000000000000}
                  Kind = bkGlyph
                end>
              Properties.ViewStyle = vsButtonsOnly
              Options.Filtering = False
              Options.ShowEditButtons = isebAlways
              Width = 25
              IsCaptionAssigned = True
            end
            object cxGridDBCODITE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 48
            end
            object cxGridDBDESITE: TcxGridDBColumn
              Caption = 'Produto'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 280
            end
            object cxgOrdProCOMPLE: TcxGridDBColumn
              Caption = 'Complemento'
              DataBinding.FieldName = 'COMPLE'
              Options.Editing = False
              Options.Focusing = False
              Width = 92
            end
            object cxGridDBDESCOR: TcxGridDBColumn
              Caption = 'Cor'
              DataBinding.FieldName = 'DESCOR'
              Options.Editing = False
              Options.Focusing = False
              Width = 147
            end
            object cxGridDBDTAPRE: TcxGridDBColumn
              Caption = 'Data Previs'#227'o'
              DataBinding.FieldName = 'DTAPRE'
              Width = 82
            end
            object cxGridDBVOLUME: TcxGridDBColumn
              Caption = 'Volume (LT)'
              DataBinding.FieldName = 'VOLUME'
              Options.Editing = False
              Options.Focusing = False
              Width = 76
            end
            object cxGridDBPESOIT: TcxGridDBColumn
              Caption = 'Peso (KG)'
              DataBinding.FieldName = 'PESOIT'
              Options.Editing = False
              Options.Focusing = False
              Width = 80
            end
          end
          object cxGridLevel3: TcxGridLevel
            GridView = cxgOrdProDBTableView
          end
        end
        object pnlImprimir: TPanel
          Left = 0
          Top = 292
          Width = 1018
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object btnImpTodos: TBitBtnLocked
            Tag = 1
            Left = 0
            Top = 0
            Width = 129
            Height = 24
            Align = alLeft
            Caption = '&Imprimir todos'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              000000000000000000030000000C000000120000001400000014000000150000
              0015000000140000000D00000003000000000000000000000000000000000000
              00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
              78FFBE8978FF876356C30000000B000000000000000000000000000000030000
              000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
              E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
              42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
              72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
              6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
              76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
              71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
              35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
              78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
              DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
              7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
              32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
              86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
              42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
              8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
              DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
              84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
              E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
              2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
              E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
              0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
              E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
              00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
              EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
              00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
              FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
              000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
              91FFCDA391FF98786BC100000004000000000000000000000000}
            TabOrder = 0
            OnClick = btnImpTodosClick
          end
          object btnNaoImp: TBitBtnLocked
            Left = 129
            Top = 0
            Width = 129
            Height = 24
            Align = alLeft
            Caption = '&N'#227'o imprimir todos'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000068057
              4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
              68FFB27967FFB17967FF7F5749BF00000007000000000000000000000008B57D
              6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFAF5F1FFFBF5
              F1FFFAF4F1FFFAF4F0FFB27B68FF0000000B000000000000000000000008B67F
              6DFFFCF8F5FFC79C8BFFC69B8BFFC59A8AFFC59A89FFC49888FFC49887FFC397
              87FFBA8B7AFFFBF5F2FFB47D6AFF0000000B000000000000000000000008B882
              6FFFFCF9F6FFF7EEE9FFF8EEE9FFF8EFE8FFF8EEE8FFF7EEE8FFF8EEE8FFF7ED
              E8FFF7EEE8FFFBF7F3FFB67F6DFF0000000A000000000000000000000007BA84
              73FFFDF9F8FFC8A090FFC89F8EFFC89E8DFFC79D8CFFC79C8BFFC69B8BFFC69A
              8AFFBC8E7DFFFCF8F5FFB88170FF0000000A000000000000000000000007BB87
              76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFF9F0EBFFF8EF
              EAFFF8F0EAFFFCF9F7FFB98473FF00000009000000000000000000000006BD8A
              78FFFDFBFAFFCBA695FFCAA494FFCAA393FFC9A291FFC8A191FFC8A08FFFC89F
              8EFFBF9381FFFDFAF8FFBB8675FF00000008000000000000000000000006BF8D
              7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
              EEFFF9F1EEFFFDFBF9FFBD8978FF00000008000000000000000000000005C190
              7EFFFEFDFCFFCFAA9BFFCEAA9AFFCEA998FFCDA797FFCBA494FFDCC5BBFFEAE0
              DCFFE2D1CBFFFAF9F8FFE1CDC6FF0000000F000000040000000100000005C393
              81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFAF6F4FFBCB7DBFF3B2E
              AEFF6D66B3FFEAE9ECFF665BA6FF160C7EEA0603244F0000000400000004C596
              84FFFEFEFEFFD9A87AFFD8A679FFD6A679FFD7A578FFEDE0D3FF4336B5FF6F85
              EAFF4150CBFF3A31A4FF3B48C9FF5C74E4FF180E82E70000000700000004C698
              87FFFFFEFEFFDEB487FFDFB387FFDEB386FFDEB386FFEDDCCBFF7970C3FF7780
              DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F0000000500000003C99B
              8AFFFFFEFEFFE0B688FFE0B688FFE0B588FFE0B588FFE4C3A1FFE8DED5FF4C45
              BAFF6A85EBFF7494F2FF6079E7FF262095E3010104130000000200000003CA9E
              8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFCFCFCFF807FD6FF6B7E
              E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA000000004000000029B7F
              74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFAA9CFFEFE5E1FF615FD6FFB1C3
              F6FF8D99EAFF5E5BD0FF8995E7FFA6B8F3FF3B35AEE300000004000000000000
              0001000000020000000300000003000000030000000300000004151537474B4B
              C5E63131829F020205112E2D809F4340BCE61212334600000002}
            TabOrder = 1
            OnClick = btnImpTodosClick
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 65520
  end
  object imgLista: TImageList
    Left = 136
    Top = 184
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00D6D6D600D6D6D600D6D6D600DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFF00000000EFF7FFFF00000000
      C7E3C1FF0000000083C1C0FF00000000C183C07F00000000E007803F00000000
      F00F801F00000000F81F800F00000000F81F040700000000F00F060300000000
      E0078F0000000000C183FFC00000000083C1FFE000000000C7E3FFF100000000
      EFF7FFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Left = 544
    Top = 144
    object ConfImpressao: TAction
      OnExecute = ConfImpressaoExecute
    end
    object SelLotes: TAction
      Caption = 'Escolher Lotes'
      OnExecute = SelLotesExecute
    end
  end
end
