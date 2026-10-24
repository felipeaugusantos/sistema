inherited frmCadRelatorios: TfrmCadRelatorios
  Width = 1031
  Height = 889
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Cadastro de Relat'#243'rios'
  WindowState = wsMaximized
  ExplicitWidth = 1031
  ExplicitHeight = 889
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 808
    Width = 1015
    Height = 26
    ExplicitTop = 808
    ExplicitWidth = 1015
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 934
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 934
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        TabOrder = 5
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        TabOrder = 6
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        TabOrder = 7
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        TabOrder = 8
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        TabOrder = 9
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        Height = 22
        TabOrder = 4
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      object btnExecutar: TBitBtnLocked
        Left = 434
        Top = 0
        Width = 76
        Height = 22
        Caption = 'E&xecutar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000001000000010000000110000
          0011000000100000000B00000003000000000000000000000000000000000000
          00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
          5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
          000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
          000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
          000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
          000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
          E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
          0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
          E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
          0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
          EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
          0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
          EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
          0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
          0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
          0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
          FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
          0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
          84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
          000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
          EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
          0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
          00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
          93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
        ParentFont = False
        TabOrder = 0
        OnClick = btnExecutarClick
      end
      object btnSalvaBackup: TBitBtnLocked
        Left = 510
        Top = 0
        Width = 115
        Height = 22
        Caption = 'Duplicar relat'#243'rio'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001100000011000000110000
          001100000011000000100000000B000000030000000000000000000000094633
          2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FFA764
          36FF583D36FF5B3E37FF3B2821C20000000A00000000000000000000000D6F53
          47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFFD4A5
          6AFF5D413AFF684B41FF543931FF0000000E00000000000000000000000C7357
          4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FFF6EE
          E8FF62473FFF715348FF573B33FF0000000F00000000000000000000000B785C
          4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFFF6EF
          EAFF684E44FF72554BFF593E35FF0000000E00000000000000000000000A7C60
          50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFF1F1
          F1FF89756EFF8A7269FF5F443BFF0000000C0000000000000000000000097F63
          54FFA78E7DFF977A6AFF967969FF957967FF84695CFF705548FF8F7B73FF0B67
          37FF295D3CFF81746BFF806C63FF0000000C0000000000000000000000088367
          57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF776761FF0A67
          37FF2AAF7FFF106137FF5B6352FF00000016000000030000000000000007866A
          59FFAF9788FF674E44FFF3EAE4FFE8D9CEFFE9DFD7FFE5DBD5FFD8CFC9FF0B6A
          3BFF4EDCB2FF27C48DFF0C7746FF022E179C000201190000000500000006886D
          5CFFB39C8CFF6B5248FFF4ECE6FFEBE3DCFF47916BFF046B38FF046B38FF056B
          38FF3AD7A5FF37D6A2FF32D3A0FF199966FF044A26D5000D063A000000058B70
          5EFFB7A091FF70564DFFF6EFEAFFEBE4DFFF167E4EFF84EDD1FF52E1B6FF4DDF
          B3FF48DDAFFF44DBACFF3FD9A9FF3AD7A6FF32BE8EFF0F6A3FF6000000048E72
          60FFBBA595FF755A50FFF7F1ECFFF1EEEBFF188252FFB8F7E7FFB4F5E6FFAFF4
          E4FF85EDD2FF52E1B7FF4DDFB3FF5DE2BBFF66D0AEFF16794CF6000000026A56
          49BF8F7361FF795E54FF765D52FFAFA19CFF3B8963FF0D814DFF0D804DFF0D80
          4CFF95F1DAFF65E7C2FF83ECCFFF57B28FFF065932D2010E0832000000010000
          000200000003000000030000000300000005000000090000000C000000140D7B
          4BF2AEF6E5FF94E5CEFF339167FD033A1F910001010F00000003000000000000
          0000000000000000000000000000000000000000000000000000000000070F7F
          4EF287CBB3FF106D42E6011C0F4C000000060000000100000000000000000000
          0000000000000000000000000000000000000000000000000000000000051081
          52F1034B2AAE0007041700000003000000010000000000000000}
        TabOrder = 1
        OnClick = btnSalvaBackupClick
      end
      object btnIncMen: TBitBtnLocked
        Left = 625
        Top = 0
        Width = 112
        Height = 22
        Caption = 'I&ncluir no menu'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
          25D0522C17931209053000000009000000010000000000000000000000000000
          00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
          6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
          0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
          82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
          2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
          59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
          47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
          45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
          6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
          44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
          83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
          47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
          8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
          F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
          A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
          D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
          ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
          3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
          9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
          3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
          6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
          3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
          3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
          5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
          0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
          CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
          00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
          B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
          000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
          60CD6C543F8B16110D2200000003000000010000000000000000}
        ParentFont = False
        TabOrder = 2
        OnClick = btnIncMenClick
      end
      object btnTesteExe: TBitBtnLocked
        Left = 737
        Top = 0
        Width = 28
        Height = 22
        Caption = 'Executar (Teste)'
        TabOrder = 3
        Visible = False
        OnClick = btnTesteExeClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 936
      Align = alRight
      ExplicitLeft = 936
    end
  end
  inherited pnlStatus: TPanel
    Top = 834
    Width = 1015
    ParentColor = True
    ExplicitTop = 834
    ExplicitWidth = 1015
    inherited pnlNomeForm: TPanel
      Left = 668
      ParentColor = True
      ExplicitLeft = 668
    end
    inherited pnlInfo: TPanel
      Width = 668
      ParentColor = True
      ExplicitWidth = 668
    end
  end
  inherited pgcDados: TPageControl
    Width = 1015
    Height = 808
    OnChange = pgcDadosChange
    ExplicitWidth = 1015
    ExplicitHeight = 808
    inherited tbsGeral: TTabSheet
      Caption = 'Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1007
      ExplicitHeight = 776
      object pnlGeral: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 773
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 557
          Height = 634
          Align = alLeft
          BevelKind = bkTile
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label1: TLabel
            Left = 17
            Top = 15
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo:'
          end
          object Label2: TLabel
            Left = 23
            Top = 38
            Width = 30
            Height = 14
            Caption = 'Nome:'
          end
          object Label20: TLabel
            Left = 1
            Top = 62
            Width = 52
            Height = 14
            Caption = 'Descri'#231#227'o:'
          end
          object Label27: TLabel
            Left = 12
            Top = 86
            Width = 41
            Height = 14
            Caption = 'Arquivo:'
          end
          object Label32: TLabel
            Left = 3
            Top = 112
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valida'#231#227'o:'
          end
          object dbeCodigo: TDBEditFocus
            Tag = 99
            Left = 56
            Top = 11
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_CODREL'
            DataSource = dtsCadRel
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeDescri: TDBEditFocus
            Tag = 99
            Left = 56
            Top = 35
            Width = 480
            Height = 22
            DataField = 'REL_DESCRI'
            DataSource = dtsCadRel
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object grbCSV: TGroupBox
            Left = 6
            Top = 447
            Width = 270
            Height = 120
            Caption = 'Dados para gera'#231#227'o em arquivo CSV'
            TabOrder = 11
            object DBCheckBox1: TDBCheckBox
              Left = 17
              Top = 18
              Width = 205
              Height = 17
              Caption = 'Incluir t'#237'tulo e filtros do relat'#243'rio'
              DataField = 'REL_CSVTIT'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox2: TDBCheckBox
              Left = 17
              Top = 34
              Width = 230
              Height = 17
              Caption = 'Incluir nome das colunas'
              DataField = 'REL_CSVCOL'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox3: TDBCheckBox
              Left = 17
              Top = 50
              Width = 232
              Height = 17
              Caption = 'Colocar campos texto entre aspas duplas '
              DataField = 'REL_CSVASP'
              DataSource = dtsCadRel
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeCSVCAQ: TDBCheckBox
              Left = 17
              Top = 66
              Width = 232
              Height = 17
              Caption = 'Exibir childs ap'#243's cada quebra'
              DataField = 'REL_CSVCAQ'
              DataSource = dtsCadRel
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeCSVCAR: TDBCheckBox
              Left = 17
              Top = 82
              Width = 232
              Height = 17
              Caption = 'Exibir childs no fim do relat'#243'rio'
              DataField = 'REL_CSVCAR'
              DataSource = dtsCadRel
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeCSVDAS: TDBCheckBox
              Left = 17
              Top = 98
              Width = 232
              Height = 17
              Caption = 'Deletar aspas duplas dentro dos campos'
              DataField = 'REL_CSVDAS'
              DataSource = dtsCadRel
              TabOrder = 5
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object dbeDesCmp: TDBMemoFocus
            Left = 56
            Top = 60
            Width = 480
            Height = 20
            Align = alCustom
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            DataField = 'REL_DESCMP'
            DataSource = dtsCadRel
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object grbZebra: TGroupBox
            Left = 282
            Top = 447
            Width = 265
            Height = 95
            Caption = 'Zoom inicial e Cor da zebra'
            TabOrder = 12
            object Label25: TLabel
              Left = 13
              Top = 26
              Width = 56
              Height = 14
              Caption = 'Zoom inicial'
            end
            object Label26: TLabel
              Left = 13
              Top = 52
              Width = 63
              Height = 14
              Caption = 'Cor da zebra'
            end
            object edtZooIni: TSpinEdit
              Left = 80
              Top = 23
              Width = 48
              Height = 23
              Enabled = False
              MaxValue = 200
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnExit = edtZooIniExit
            end
            object dbeReiZeb: TDBCheckBox
              Left = 13
              Top = 74
              Width = 205
              Height = 17
              Caption = 'Reiniciar zebra ap'#243's quebra'
              DataField = 'REL_REIZEB'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeCorZeb: TcxDBColorComboBox
              Left = 80
              Top = 48
              DataBinding.DataField = 'REL_CORZEB'
              DataBinding.DataSource = dtsCadRel
              Properties.AllowSelectColor = True
              Properties.ClearKey = 46
              Properties.ColorDialogShowFull = True
              Properties.ColorDialogType = cxcdtAdvanced
              Properties.CustomColors = <>
              TabOrder = 2
              Width = 169
            end
          end
          object dbeArquiv: TDBEditFocus
            Tag = 99
            Left = 56
            Top = 83
            Width = 480
            Height = 22
            DataField = 'REL_ARQUIV'
            DataSource = dtsCadRel
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object grbFiltroComp: TGroupBox
            Left = 8
            Top = 343
            Width = 541
            Height = 100
            Caption = 'Filtros e Complementos de Cabe'#231'alho'
            TabOrder = 10
            object Label12: TLabel
              Left = 9
              Top = 25
              Width = 32
              Height = 14
              Caption = 'Filtros:'
            end
            object Label38: TLabel
              Left = 20
              Top = 74
              Width = 179
              Height = 14
              Caption = 'Condi'#231#227'o para visibilidade dos filtros:'
            end
            object cbxFilPri: TComboBoxFocus
              Left = 44
              Top = 20
              Width = 320
              Height = 22
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbxFilPriChange
              Items.Strings = (
                'Exibir os filtros apenas na primeira p'#225'gina do relat'#243'rio'
                'Exibir os filtros em todas as p'#225'ginas'
                'Nunca exibir os filtros')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbeQBRCOM: TDBCheckBox
              Left = 371
              Top = 13
              Width = 164
              Height = 17
              Caption = 'Quebrar Complem. Cabe'#231'alho'
              DataField = 'REL_QBRCOM'
              DataSource = dtsCadRel
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox8: TDBCheckBox
              Left = 41
              Top = 48
              Width = 324
              Height = 17
              Caption = 'Quando exibir os filtros, mostrar somente os filtros informados'
              DataField = 'REL_FILINF'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeQBRFIL: TDBCheckBox
              Left = 371
              Top = 29
              Width = 145
              Height = 17
              Caption = 'Quebrar Filtro do Relat'#243'rio'
              DataField = 'REL_QBRFIL'
              DataSource = dtsCadRel
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeCOMPVZ: TDBCheckBox
              Left = 371
              Top = 45
              Width = 145
              Height = 17
              Hint = 
                'Caso desative essa op'#231#227'o, certifique-se de que todas as vari'#225'vei' +
                's de complemento de cabe'#231'alho estejam montadas com um SELECT'
              Caption = 'Imp. comp. cab. vazio'
              DataField = 'REL_COMPVZ'
              DataSource = dtsCadRel
              TabOrder = 5
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeFilCnd: TDBEditFocus
              Tag = 99
              Left = 203
              Top = 69
              Width = 162
              Height = 22
              DataField = 'REL_FILCND'
              DataSource = dtsCadRel
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeSTRHED: TDBCheckBox
              Left = 371
              Top = 61
              Width = 158
              Height = 17
              Caption = 'Stretched T'#237'tulo das Colunas'
              DataField = 'REL_STRHED'
              DataSource = dtsCadRel
              TabOrder = 6
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeFilLat: TDBCheckBox
              Left = 371
              Top = 77
              Width = 158
              Height = 17
              Caption = 'Alinhar Imp. Filtros Laterais'
              DataField = 'REL_FILLAT'
              DataSource = dtsCadRel
              TabOrder = 7
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object dbeCodVal: TDBEditFocus
            Tag = 99
            Left = 56
            Top = 109
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_CODVAL'
            DataSource = dtsCadRel
            TabOrder = 4
            OnKeyPress = dbeCodValKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtDesCodVal: TEditFocus
            Left = 120
            Top = 109
            Width = 227
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
          object chkConInd: TDBCheckBox
            Left = 358
            Top = 112
            Width = 176
            Height = 17
            Caption = 'Executar em uma nova conex'#227'o'
            DataField = 'REL_CONIND'
            DataSource = dtsCadRel
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkConIndClick
          end
          object dbeCamAut: TDBCheckBox
            Left = 56
            Top = 135
            Width = 294
            Height = 17
            Caption = 'Carregar os campos automaticamente ao mudar o SQL'
            DataField = 'REL_CAMAUT'
            DataSource = dtsCadRel
            TabOrder = 7
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeCamAutClick
          end
          object grbModelo: TGroupBox
            Left = 6
            Top = 154
            Width = 541
            Height = 183
            Caption = 'Dados para gera'#231#227'o do relat'#243'rio'
            TabOrder = 9
            object Label3: TLabel
              Left = 10
              Top = 26
              Width = 37
              Height = 14
              Caption = 'Modelo:'
            end
            object lblNumCol: TLabel
              Left = 407
              Top = 142
              Width = 67
              Height = 14
              Caption = 'Qtde. colunas'
            end
            object dbeCodMod: TDBEditFocus
              Tag = 99
              Left = 50
              Top = 23
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'REL_CODMOD'
              DataSource = dtsCadRel
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              OnExit = dbeCodModExit
              OnKeyPress = dbeCodModKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
            end
            object edtModDes: TEditFocus
              Left = 114
              Top = 23
              Width = 386
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
            object DBCheckBox4: TDBCheckBox
              Left = 17
              Top = 68
              Width = 271
              Height = 17
              Caption = 'Omitir mensagem de registros impressos no rodap'#233
              DataField = 'REL_OMIREG'
              DataSource = dtsCadRel
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeOMITOT: TDBCheckBox
              Left = 17
              Top = 86
              Width = 112
              Height = 17
              Caption = 'Omitir total geral'
              DataField = 'REL_OMITOT'
              DataSource = dtsCadRel
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox6: TDBCheckBox
              Left = 17
              Top = 105
              Width = 217
              Height = 17
              Caption = 'Pedir p'#225'gina inicial para gerar o relat'#243'rio'
              DataField = 'REL_PAGINI'
              DataSource = dtsCadRel
              TabOrder = 7
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox7: TDBCheckBox
              Left = 135
              Top = 86
              Width = 235
              Height = 17
              Caption = 'Omitir totais parciais e childs (das quebras)'
              DataField = 'REL_OMIPAR'
              DataSource = dtsCadRel
              TabOrder = 5
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeExDtHr: TDBCheckBox
              Left = 237
              Top = 105
              Width = 102
              Height = 17
              Caption = 'Exibir Data/Hora'
              DataField = 'REL_EXDTHR'
              DataSource = dtsCadRel
              TabOrder = 8
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeEXLIBR: TDBCheckBox
              Left = 17
              Top = 123
              Width = 205
              Height = 17
              Caption = 'Excluir linhas com campos em branco'
              DataField = 'REL_EXLIBR'
              DataSource = dtsCadRel
              TabOrder = 10
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeNLTITB: TDBCheckBox
              Left = 378
              Top = 123
              Width = 151
              Height = 17
              Caption = 'N'#227'o listar t'#237'tulos em branco'
              DataField = 'REL_NLTITB'
              DataSource = dtsCadRel
              TabOrder = 12
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeGRUVER: TDBCheckBox
              Left = 17
              Top = 141
              Width = 218
              Height = 17
              Caption = 'Separar verticalmente grupos de campos'
              DataField = 'REL_GRUVER'
              DataSource = dtsCadRel
              TabOrder = 13
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkApePri: TCheckBox
              Left = 237
              Top = 159
              Width = 255
              Height = 17
              Caption = 'Imprimir Apenas o Relat'#243'rio Principal (em edi'#231#227'o)'
              TabOrder = 17
            end
            object DBCheckBox21: TDBCheckBox
              Left = 378
              Top = 105
              Width = 156
              Height = 17
              Caption = 'Op'#231#227'o de Impress'#227'o no grid'
              DataField = 'REL_IMPGRI'
              DataSource = dtsCadRel
              TabOrder = 9
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox23: TDBCheckBox
              Left = 237
              Top = 123
              Width = 135
              Height = 17
              Caption = 'Exibir n'#250'mero da p'#225'gina'
              DataField = 'REL_EXIPAG'
              DataSource = dtsCadRel
              TabOrder = 11
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object rdgPGRCPE: TRadioGroup
              Left = 379
              Top = 46
              Width = 137
              Height = 57
              Caption = 'Pagina'#231#227'o RCPE'
              Enabled = False
              ItemIndex = 2
              Items.Strings = (
                '2-499 .. 0-499 ..'
                '2-499 .. 502-999 ..'
                'Pagina'#231#227'o Normal')
              TabOrder = 6
              OnClick = rdgPGRCPEClick
            end
            object dbeSEMDAD: TDBCheckBox
              Left = 17
              Top = 159
              Width = 191
              Height = 17
              Caption = 'Imprimir relat'#243'rio sem dados?'
              DataField = 'REL_SEMDAD'
              DataSource = dtsCadRel
              TabOrder = 16
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object edtNumCol: TSpinEdit
              Left = 481
              Top = 137
              Width = 48
              Height = 23
              Enabled = False
              MaxValue = 5
              MinValue = 1
              TabOrder = 15
              Value = 1
              OnExit = edtNumColExit
            end
            object dbeCASQUE: TDBCheckBox
              Left = 237
              Top = 141
              Width = 159
              Height = 17
              Caption = 'Efeito Cascata nas Quebras'
              DataField = 'REL_CASQUE'
              DataSource = dtsCadRel
              TabOrder = 14
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object cbxTitPos: TComboBoxFocus
              Left = 16
              Top = 47
              Width = 357
              Height = 22
              Style = csDropDownList
              TabOrder = 1
              OnChange = cbxTitPosChange
              Items.Strings = (
                'N'#227'o exibir t'#237'tulo do relat'#243'rio quando for complementar'
                
                  'Exibir o t'#237'tulo ap'#243's o filtro quando for um relat'#243'rio complement' +
                  'ar'
                
                  'Exibir o t'#237'tulo antes do filtro quando for um relat'#243'rio compleme' +
                  'ntar')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object grpConfgsGrid: TGroupBox
            Left = 8
            Top = 568
            Width = 268
            Height = 58
            Caption = 'Configura'#231#245'es grid'
            TabOrder = 13
            object DBCheckBox25: TDBCheckBox
              Left = 15
              Top = 19
              Width = 205
              Height = 17
              Caption = 'Pedir confirma'#231#227'o de sa'#237'da ao fechar'
              DataField = 'REL_CONSAI'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeExcGri: TDBCheckBox
              Left = 15
              Top = 36
              Width = 205
              Height = 17
              Caption = 'Mostrar bot'#227'o gerar Excel'
              DataField = 'REL_EXCGRI'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object grpExportArqPdf: TGroupBox
            Left = 282
            Top = 548
            Width = 267
            Height = 78
            Caption = 'Configura'#231#245'es para Arquivo PDF:'
            TabOrder = 14
            object DBCheckBox30: TDBCheckBox
              Left = 13
              Top = 24
              Width = 199
              Height = 15
              Caption = 'Enviar gatilho imediato - Whatsapp'
              DataField = 'REL_PDFWPP'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox31: TDBCheckBox
              Left = 13
              Top = 45
              Width = 199
              Height = 15
              Caption = 'Enviar gatilho imediato - Email'
              DataField = 'REL_PDFEMA'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object dbeExpAut: TDBCheckBox
            Left = 358
            Top = 135
            Width = 191
            Height = 17
            Caption = 'Exporta Par'#226'metros Automatizados'
            DataField = 'REL_EXPAUT'
            DataSource = dtsCadRel
            TabOrder = 8
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkConIndClick
          end
        end
        object Panel12: TPanel
          Left = 557
          Top = 0
          Width = 450
          Height = 634
          Align = alClient
          BevelKind = bkTile
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object pnlJato: TPanel
            Left = 0
            Top = 329
            Width = 446
            Height = 153
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            Visible = False
            object grbJato: TGroupBox
              Left = 8
              Top = 0
              Width = 412
              Height = 149
              Caption = 'Configura'#231#245'es para Impressora Jato de Tinta:'
              Enabled = False
              TabOrder = 0
              object Label4: TLabel
                Left = 15
                Top = 33
                Width = 29
                Height = 14
                Caption = 'Folha:'
              end
              object lblPapHei: TLabel
                Left = 241
                Top = 71
                Width = 57
                Height = 14
                Alignment = taRightJustify
                Caption = 'Altura (cm):'
              end
              object Label24: TLabel
                Left = 15
                Top = 98
                Width = 144
                Height = 14
                Alignment = taRightJustify
                Caption = 'Fator de amplia'#231#227'o de p'#225'gina:'
              end
              object Label83: TLabel
                Left = 14
                Top = 124
                Width = 196
                Height = 14
                Alignment = taCenter
                Caption = 'Altura m'#225'xima para p'#225'gina sem fim (cm):'
              end
              object dbeTipFol: TDBComboBoxFocus
                Left = 47
                Top = 29
                Width = 94
                Height = 22
                Style = csDropDownList
                DataField = 'REL_TIPFOL'
                DataSource = dtsCadRel
                TabOrder = 0
                OnClick = dbeTipFolClick
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
              end
              object rdgOrient: TRadioGroup
                Left = 180
                Top = 16
                Width = 157
                Height = 46
                Caption = 'Orienta'#231#227'o'
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'Retrato'
                  'Paisagem')
                TabOrder = 1
                OnClick = rdgOrientClick
              end
              object chkInfHei: TDBCheckBox
                Left = 16
                Top = 71
                Width = 207
                Height = 17
                Caption = 'Informar a altura da p'#225'gina do relat'#243'rio'
                DataField = 'REL_INFHEI'
                DataSource = dtsCadRel
                TabOrder = 2
                ValueChecked = 'S'
                ValueUnchecked = 'N'
                OnClick = chkInfHeiClick
              end
              object dbePapHei: TDBEditFocus
                Tag = 99
                Left = 301
                Top = 67
                Width = 63
                Height = 22
                CharCase = ecUpperCase
                DataField = 'REL_PAPHEI'
                DataSource = dtsCadRel
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeFatSca: TDBEditFocus
                Tag = 99
                Left = 162
                Top = 93
                Width = 63
                Height = 22
                CharCase = ecUpperCase
                DataField = 'REL_FATSCA'
                DataSource = dtsCadRel
                TabOrder = 4
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeSplit: TDBCheckBox
                Left = 239
                Top = 96
                Width = 148
                Height = 17
                Caption = 'Realizar divis'#227'o da p'#225'gina'
                DataField = 'REL_SPLIT_'
                DataSource = dtsCadRel
                TabOrder = 5
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object DBEditFocus22: TDBEditFocus
                Tag = 99
                Left = 214
                Top = 119
                Width = 63
                Height = 22
                CharCase = ecUpperCase
                DataField = 'REL_ALTMAX'
                DataSource = dtsCadRel
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
          object pnlMatricial: TPanel
            Left = 0
            Top = 482
            Width = 446
            Height = 112
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 3
            Visible = False
            object grbMatricial: TGroupBox
              Left = 8
              Top = 2
              Width = 412
              Height = 104
              Caption = 'Configura'#231#245'es para Impressora Matricial:'
              TabOrder = 0
              object Label5: TLabel
                Left = 13
                Top = 25
                Width = 115
                Height = 14
                Caption = 'Quantidade de Colunas:'
              end
              object lblMarEsq: TLabel
                Left = 37
                Top = 50
                Width = 87
                Height = 14
                Caption = 'Margem esquerda'
              end
              object lblMarDir: TLabel
                Left = 54
                Top = 76
                Width = 70
                Height = 14
                Caption = 'Margem direita'
              end
              object dbeQtdCol: TDBComboBoxFocus
                Left = 130
                Top = 21
                Width = 77
                Height = 22
                Style = csDropDownList
                DataField = 'REL_QTDCOL'
                DataSource = dtsCadRel
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
              end
              object dbeAltMod: TDBCheckBox
                Left = 219
                Top = 18
                Width = 174
                Height = 15
                Caption = 'Customizar a altura pelo Modelo'
                DataField = 'REL_ALTMOD'
                DataSource = dtsCadRel
                TabOrder = 3
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object dbeSELIHE: TDBCheckBox
                Left = 219
                Top = 35
                Width = 174
                Height = 15
                Caption = 'Exibir segunda linha do header'
                DataField = 'REL_SELIHE'
                DataSource = dtsCadRel
                TabOrder = 4
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object dbeIMPMEI: TDBCheckBox
                Left = 219
                Top = 51
                Width = 174
                Height = 17
                Caption = 'Impress'#227'o meia p'#225'gina'
                DataField = 'REL_IMPMEI'
                DataSource = dtsCadRel
                TabOrder = 5
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object DBCheckBox9: TDBCheckBox
                Left = 219
                Top = 67
                Width = 174
                Height = 34
                Caption = 'Enviar Comando de coluna em todas as p'#225'ginas'
                DataField = 'REL_COMMAT'
                DataSource = dtsCadRel
                TabOrder = 6
                ValueChecked = 'S'
                ValueUnchecked = 'N'
                WordWrap = True
              end
              object edtMarEsq: TSpinEdit
                Left = 130
                Top = 47
                Width = 48
                Height = 23
                Enabled = False
                MaxValue = 5
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnExit = edtMarEsqExit
              end
              object edtMarDir: TSpinEdit
                Left = 130
                Top = 73
                Width = 48
                Height = 23
                Enabled = False
                MaxValue = 5
                MinValue = 0
                TabOrder = 2
                Value = 0
                OnExit = edtMarDirExit
              end
            end
          end
          object Panel18: TPanel
            Left = 0
            Top = 0
            Width = 446
            Height = 239
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object Label15: TLabel
              Left = 3
              Top = 3
              Width = 169
              Height = 14
              Caption = 'Poss'#237'veis destinos para o relat'#243'rio:'
            end
            object cklDestin: TCheckListBox
              Left = 2
              Top = 18
              Width = 434
              Height = 215
              OnClickCheck = cklDestinClickCheck
              Columns = 2
              Enabled = False
              ItemHeight = 14
              TabOrder = 0
            end
          end
          object pnlTXT: TPanel
            Left = 0
            Top = 651
            Width = 446
            Height = 91
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 4
            Visible = False
            object GroupBox5: TGroupBox
              Left = 8
              Top = 1
              Width = 412
              Height = 84
              Caption = 'Configura'#231#245'es para Arquivo TXT:'
              TabOrder = 0
              object Label30: TLabel
                Left = 10
                Top = 25
                Width = 153
                Height = 14
                Caption = 'Quantidade m'#225'xima de colunas:'
              end
              object debQTDCOLTXT: TDBEditFocus
                Left = 166
                Top = 20
                Width = 51
                Height = 22
                DataField = 'REL_QTDCOL'
                DataSource = dtsCadRel
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object DBCheckBox10: TDBCheckBox
                Left = 10
                Top = 48
                Width = 199
                Height = 15
                Caption = 'Incluir assinatura digital PAF-NFC-e'
                DataField = 'REL_ASSDIG'
                DataSource = dtsCadRel
                TabOrder = 1
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object dbePreLim: TDBCheckBox
                Left = 234
                Top = 25
                Width = 162
                Height = 15
                Caption = 'Preencher campo at'#233' limite'
                DataField = 'REL_PRELIM'
                DataSource = dtsCadRel
                TabOrder = 2
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object bdeGraDir: TDBCheckBox
                Left = 234
                Top = 48
                Width = 199
                Height = 15
                Caption = 'Gravar linha a linha'
                DataField = 'REL_GRADIR'
                DataSource = dtsCadRel
                TabOrder = 3
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object DBCheckBox24: TDBCheckBox
                Left = 10
                Top = 64
                Width = 199
                Height = 15
                Caption = 'Gerar XML PAF-NFC-e'
                DataField = 'REL_XMLPAF'
                DataSource = dtsCadRel
                TabOrder = 4
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
              object DBCheckBox27: TDBCheckBox
                Left = 234
                Top = 64
                Width = 171
                Height = 15
                Caption = 'Gerar TXT de Backup'
                DataField = 'REL_TXTBKP'
                DataSource = dtsCadRel
                TabOrder = 5
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
            end
          end
          object Panel30: TPanel
            Left = 0
            Top = 239
            Width = 446
            Height = 90
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel30'
            ShowCaption = False
            TabOrder = 1
            object Label89: TLabel
              Left = 8
              Top = 65
              Width = 84
              Height = 14
              Caption = 'Fila de Impress'#227'o'
            end
            object dbePasSai: TDBCheckBox
              Left = 8
              Top = 3
              Width = 225
              Height = 17
              Caption = 'Pedir pasta de sa'#237'da (CSV/PDF/TXT/XML/Arq.Sa'#237'da)'
              DataField = 'REL_PASSAI'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnClick = dbePasSaiClick
            end
            object dbeGatInf: TDBCheckBox
              Tag = 99
              Left = 262
              Top = -3
              Width = 156
              Height = 28
              Caption = 'Pode ser utilizado nos Gatilhos de Informa'#231#227'o?'
              DataField = 'REL_GATINF'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              WordWrap = True
              OnClick = dbeGatInfClick
            end
            object DBCheckBox22: TDBCheckBox
              Left = 8
              Top = 21
              Width = 191
              Height = 17
              Caption = 'Pedir path da imagem de cabe'#231'alho'
              DataField = 'REL_PEDIMA'
              DataSource = dtsCadRel
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox29: TDBCheckBox
              Left = 8
              Top = 39
              Width = 191
              Height = 17
              Caption = 'Gerar Log de Execu'#231#227'o'
              DataField = 'REL_GERLOG'
              DataSource = dtsCadRel
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeFr3per: TDBCheckBox
              Left = 262
              Top = 38
              Width = 162
              Height = 17
              Caption = 'FR3 Personalizado'
              DataField = 'REL_FR3PER'
              DataSource = dtsCadRel
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnClick = dbeFr3perClick
            end
            object dbeFilImp: TDBEditFocus
              Tag = 99
              Left = 98
              Top = 60
              Width = 162
              Height = 22
              DataField = 'REL_FILIMP'
              DataSource = dtsCadRel
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlXML: TPanel
            Left = 0
            Top = 594
            Width = 446
            Height = 57
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 5
            Visible = False
            object GroupBox23: TGroupBox
              Left = 8
              Top = 1
              Width = 412
              Height = 48
              Caption = 'Configura'#231#245'es para Arquivo XML:'
              TabOrder = 0
              object DBCheckBox28: TDBCheckBox
                Left = 10
                Top = 24
                Width = 199
                Height = 15
                Caption = 'Gravar linha a linha'
                DataField = 'REL_GRADIR'
                DataSource = dtsCadRel
                TabOrder = 0
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
            end
          end
          object pnlArqSai: TPanel
            Left = 0
            Top = 651
            Width = 446
            Height = 57
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            Visible = False
            object grbArqSai: TGroupBox
              Left = 8
              Top = 1
              Width = 412
              Height = 48
              Caption = 'Configura'#231#245'es para Arquivo Sa'#237'da:'
              TabOrder = 0
              object lblEncArq: TLabel
                Left = 10
                Top = 22
                Width = 62
                Height = 14
                Caption = 'Codifica'#231#227'o:'
              end
              object dbeEncArq: TDBComboBoxFocus
                Left = 78
                Top = 18
                Width = 105
                Height = 22
                Style = csDropDownList
                DataField = 'REL_ENCARQ'
                DataSource = dtsCadRel
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
              end
              object chkSanArq: TDBCheckBox
                Left = 200
                Top = 20
                Width = 200
                Height = 17
                Caption = 'Sanitizar nome do arquivo'
                DataField = 'REL_SANARQ'
                DataSource = dtsCadRel
                TabOrder = 1
                ValueChecked = 'S'
                ValueUnchecked = 'N'
              end
            end
          end
        end
        object pnlRodapeGeral: TPanel
          Left = 0
          Top = 634
          Width = 1007
          Height = 139
          Align = alBottom
          BevelKind = bkTile
          BevelOuter = bvNone
          TabOrder = 2
          object pnlMsgDados: TPanel
            Left = 0
            Top = 0
            Width = 1003
            Height = 85
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object Panel14: TPanel
              Left = 0
              Top = 0
              Width = 1003
              Height = 16
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Mensagem de rodap'#233' de dados'
              ParentColor = True
              TabOrder = 0
            end
            object dbeMsgDad: TDBMemoFocus
              Left = 0
              Top = 16
              Width = 1003
              Height = 69
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              DataField = 'REL_MSGDAD'
              DataSource = dtsCadRel
              ScrollBars = ssBoth
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
          end
          object pnlMsgRod: TPanel
            Left = 0
            Top = 85
            Width = 1003
            Height = 102
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 1003
              Height = 16
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Mensagem de rodap'#233' de p'#225'gina'
              TabOrder = 0
            end
            object dbeMsgRod: TDBMemoFocus
              Left = 0
              Top = 16
              Width = 1003
              Height = 86
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              DataField = 'REL_MSGROD'
              DataSource = dtsCadRel
              ScrollBars = ssBoth
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
          end
        end
      end
    end
    object tbsSQL: TTabSheet
      Caption = 'SQL Principal'
      ImageIndex = 1
      object bceDefSQL: TBCEditor
        Left = 0
        Top = 22
        Width = 1007
        Height = 696
        Cursor = crIBeam
        ActiveLine.Indicator.Visible = False
        Align = alClient
        BorderStyle = bsNone
        Caret.Options = []
        CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
        CodeFolding.Hint.Font.Color = clWindowText
        CodeFolding.Hint.Font.Height = -11
        CodeFolding.Hint.Font.Name = 'Courier New'
        CodeFolding.Hint.Font.Style = []
        CodeFolding.Hint.Indicator.Glyph.Visible = False
        CompletionProposal.CloseChars = '()[]. '
        CompletionProposal.Columns = <
          item
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            Items = <>
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Courier New'
            Title.Font.Style = []
          end>
        CompletionProposal.SecondaryShortCut = 0
        CompletionProposal.ShortCut = 16416
        CompletionProposal.Trigger.Chars = '.'
        CompletionProposal.Trigger.Enabled = False
        Directories.Colors = 'Colors'
        Directories.Highlighters = 'Highlighters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        LeftMargin.Font.Charset = DEFAULT_CHARSET
        LeftMargin.Font.Color = 13408665
        LeftMargin.Font.Height = -11
        LeftMargin.Font.Name = 'Courier New'
        LeftMargin.Font.Style = []
        Lines.Strings = (
          '')
        LineSpacing = 0
        MatchingPair.Enabled = True
        Minimap.Font.Charset = DEFAULT_CHARSET
        Minimap.Font.Color = clWindowText
        Minimap.Font.Height = -1
        Minimap.Font.Name = 'Courier New'
        Minimap.Font.Style = []
        OnExit = bceDefSQLExit
        OnKeyDown = bceDefSQLKeyDown
        ReadOnly = True
        SpecialChars.Style = scsDot
        SyncEdit.ShortCut = 24650
        TabOrder = 0
        TokenInfo.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Font.Color = clWindowText
        TokenInfo.Font.Height = -11
        TokenInfo.Font.Name = 'Courier New'
        TokenInfo.Font.Style = []
        TokenInfo.Title.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Title.Font.Color = clWindowText
        TokenInfo.Title.Font.Height = -11
        TokenInfo.Title.Font.Name = 'Courier New'
        TokenInfo.Title.Font.Style = []
        UndoOptions = [uoGroupUndo]
        WordWrap.Indicator.Bitmap.Data = {
          02020000424D020200000000000042000000280000000F0000000E0000000100
          100003000000C001000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          10001F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C0000}
        WordWrap.Indicator.MaskColor = clFuchsia
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Informe a instru'#231#227'o SQL para o relat'#243'rio:'
        TabOrder = 1
      end
      object Panel6: TPanel
        Left = 0
        Top = 718
        Width = 1007
        Height = 58
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object Label13: TLabel
          Left = 6
          Top = 34
          Width = 145
          Height = 14
          Caption = '< Alt + / > Busca Templates'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 162
          Top = 34
          Width = 261
          Height = 14
          Caption = '< F6 > Carrega Template posicionado no cursor '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblMaxCol: TLabel
          Left = 568
          Top = 36
          Width = 199
          Height = 14
          Caption = 'M'#225'ximo de colunas vari'#225'veis no relat'#243'rio:'
        end
        object btnAjuda: TBitBtnLocked
          Left = 171
          Top = 8
          Width = 193
          Height = 22
          Caption = 'Ajuda Vari'#225'veis Dispon'#237'veis'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
          TabOrder = 1
          OnClick = btnAjudaClick
        end
        object btnCadTem: TBitBtnLocked
          Left = 6
          Top = 8
          Width = 150
          Height = 22
          Caption = '[ F5 ] Cadastro de Templates'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnCadTemClick
        end
        object cbxHorizo: TComboBoxFocus
          Left = 568
          Top = 6
          Width = 425
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = 'Consulta padr'#227'o'
          OnChange = cbxHorizoChange
          Items.Strings = (
            'Consulta padr'#227'o'
            'Transformar cada coluna em um registro (Inverter a consulta)'
            
              'Inverter a consulta (Primeira coluna do Select como nome das col' +
              'unas do relat'#243'rio)')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeMaxCol: TcxDBSpinEdit
          Left = 771
          Top = 32
          DataBinding.DataField = 'REL_MAXCOL'
          DataBinding.DataSource = dtsCadRel
          TabOrder = 4
          Width = 73
        end
        object btnCamAut: TBitBtnLocked
          Left = 400
          Top = 6
          Width = 145
          Height = 22
          Caption = 'Atualizar campos e filtros'
          TabOrder = 2
          OnClick = btnCamAutClick
        end
      end
    end
    object tbsGruCam: TTabSheet
      Caption = 'Grupos de Campos'
      ImageIndex = 6
      object pnlGruCam: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        ParentColor = True
        TabOrder = 0
        object Label10: TLabel
          Left = 5
          Top = 26
          Width = 110
          Height = 14
          Alignment = taRightJustify
          Caption = 'Novo grupo de Campo:'
        end
        object btnExcGruCam: TBitBtnLocked
          Left = 747
          Top = 22
          Width = 154
          Height = 22
          Caption = 'Exclui &Grupo de Campo'
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
          TabOrder = 1
          OnClick = btnExcluiGruposClick
        end
        object edtGruCam: TEditFocus
          Tag = 99
          Left = 119
          Top = 22
          Width = 465
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object cxgGruposCam: TcxGrid
        Left = 0
        Top = 65
        Width = 1007
        Height = 711
        Align = alClient
        TabOrder = 1
        object cxvGruposCam: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para adicionar um novo grupo'
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum grupo cadastrado>'
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle1
          object cxvGruposNOMGRU: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Grupo'
            DataBinding.FieldName = 'GRU_NOMGRU'
            Width = 635
          end
          object cxvGruposTIPBAN: TcxGridDBColumn
            Caption = 'Tipo de Grupo (apenas para destino "Grid" )'
            DataBinding.FieldName = 'GRU_TIPBAN'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.CaseSensitiveSearch = True
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'CODTIP'
            Properties.ListColumns = <
              item
                FieldName = 'DESTIP'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsTipBan
            HeaderAlignmentHorz = taCenter
            Width = 236
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxvGruposCam
        end
      end
    end
    object tbsCampos: TTabSheet
      Caption = 'Campos Listados'
      ImageIndex = 3
      object pnlRodape: TPanel
        Left = 0
        Top = 576
        Width = 1007
        Height = 200
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object pnlGridLargura: TPanel
          Left = 1
          Top = 199
          Width = 1005
          Height = 0
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          Visible = False
          object cxgLargura: TcxGrid
            Left = 6
            Top = 6
            Width = 813
            Height = 83
            Enabled = False
            TabOrder = 0
            object cxvLinhas: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = ' '
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Bands = <
                item
                  Caption = 'Linha 1'
                  Position.BandIndex = 1
                  Position.ColIndex = 0
                end
                item
                  Caption = 'Largura das Linhas'
                end
                item
                  Caption = 'Linha 2'
                  Position.BandIndex = 1
                  Position.ColIndex = 1
                end
                item
                  Caption = 'Linha 3'
                  Position.BandIndex = 1
                  Position.ColIndex = 2
                end
                item
                  Caption = 'Linha 4'
                  Position.BandIndex = 1
                  Position.ColIndex = 3
                end
                item
                  Caption = 'Linha 5'
                  Position.BandIndex = 1
                  Position.ColIndex = 4
                end>
              object cxvLinhasColumn1: TcxGridDBBandedColumn
                Caption = 'M'#225'xima'
                DataBinding.FieldName = 'LARMA1'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLinhasColumn2: TcxGridDBBandedColumn
                Caption = 'Consumida'
                DataBinding.FieldName = 'LARCO1'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvLinhasColumn3: TcxGridDBBandedColumn
                Caption = 'M'#225'xima'
                DataBinding.FieldName = 'LARMA2'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 2
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLinhasColumn4: TcxGridDBBandedColumn
                Caption = 'Consumida'
                DataBinding.FieldName = 'LARCO2'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 2
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvLinhasColumn5: TcxGridDBBandedColumn
                Caption = 'M'#225'xima'
                DataBinding.FieldName = 'LARMA3'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 3
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLinhasColumn6: TcxGridDBBandedColumn
                Caption = 'Consumida'
                DataBinding.FieldName = 'LARCO3'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 3
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvLinhasColumn7: TcxGridDBBandedColumn
                Caption = 'M'#225'xima'
                DataBinding.FieldName = 'LARMA4'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 4
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLinhasColumn8: TcxGridDBBandedColumn
                Caption = 'Consumida'
                DataBinding.FieldName = 'LARCO4'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 4
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvLinhasColumn9: TcxGridDBBandedColumn
                Caption = 'M'#225'xima'
                DataBinding.FieldName = 'LARMA5'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 5
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvLinhasColumn10: TcxGridDBBandedColumn
                Caption = 'Consumida'
                DataBinding.FieldName = 'LARCO5'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 5
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
            end
            object cxgLarguraLevel1: TcxGridLevel
              GridView = cxvLinhas
            end
          end
        end
        object pnlInterGrafica: TPanel
          Left = 1
          Top = 1
          Width = 1005
          Height = 184
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object pnlTitGraf: TPanel
            Left = 0
            Top = 0
            Width = 1005
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Ajuste a largura dos campos da linha de detalhe'
            ParentColor = True
            TabOrder = 0
            object btnAltCam: TBitBtnLocked
              Left = 7
              Top = 8
              Width = 125
              Height = 22
              Caption = 'Alterar Campo'
              Enabled = False
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
              TabOrder = 0
              OnClick = btnAltCamClick
            end
            object btnAjudaCampos: TBitBtnLocked
              Left = 138
              Top = 8
              Width = 193
              Height = 22
              Caption = 'Ajuda Comandos Dispon'#237'veis'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
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
              TabOrder = 1
              OnClick = btnAjudaCamposClick
            end
            object btnRepFon: TBitBtnLocked
              Left = 337
              Top = 8
              Width = 26
              Height = 22
              Hint = 
                'Clique aqui para replicar a fonte personalizada desse campos par' +
                'a os demais'
              Cancel = True
              Enabled = False
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000C40E0000C40E00001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
                DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
                5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
                DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
                DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = btnRepFonClick
            end
            object btnDelFon: TBitBtnLocked
              Left = 369
              Top = 8
              Width = 26
              Height = 22
              Hint = 'Clique aqui para apagar a fonte personalizada de todos os campos'
              Cancel = True
              Enabled = False
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                08000000000000010000C40E0000C40E00000001000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                A6000020400000206000002080000020A0000020C0000020E000004000000040
                20000040400000406000004080000040A0000040C0000040E000006000000060
                20000060400000606000006080000060A0000060C0000060E000008000000080
                20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                20004000400040006000400080004000A0004000C0004000E000402000004020
                20004020400040206000402080004020A0004020C0004020E000404000004040
                20004040400040406000404080004040A0004040C0004040E000406000004060
                20004060400040606000406080004060A0004060C0004060E000408000004080
                20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                20008000400080006000800080008000A0008000C0008000E000802000008020
                20008020400080206000802080008020A0008020C0008020E000804000008040
                20008040400080406000804080008040A0008040C0008040E000806000008060
                20008060400080606000806080008060A0008060C0008060E000808000008080
                20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
                FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
                66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
                56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
                5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
                5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
                F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
                FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
                FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = btnDelFonClick
            end
          end
          object scrLinhas: TScrollBox
            Left = 0
            Top = 41
            Width = 1005
            Height = 143
            HorzScrollBar.Position = 2121
            VertScrollBar.Visible = False
            Align = alTop
            BevelInner = bvNone
            BevelOuter = bvNone
            BevelKind = bkFlat
            BorderStyle = bsNone
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            object imgFundo: TImage
              Left = -2122
              Top = -2
              Width = 7000
              Height = 125
            end
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Campos que ser'#227'o listados no relat'#243'rio:'
        ParentColor = True
        TabOrder = 4
      end
      object cxgCampos: TcxGrid
        Left = 0
        Top = 22
        Width = 1007
        Height = 473
        Align = alClient
        TabOrder = 0
        object cxvCampos: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FilterBox.CustomizeDialog = False
          FilterBox.Visible = fvNever
          OnEditKeyDown = cxvCamposEditKeyDown
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'LARGUR'
              Column = cxgCamposLARGUR
            end>
          DataController.Summary.SummaryGroups = <>
          Filtering.MRUItemsList = False
          Filtering.ColumnAddValueItems = False
          Filtering.ColumnMRUItemsList = False
          FilterRow.Visible = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.ShowLockedStateImageOptions.Sorting = lsimNever
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Sem campos definidos na instru'#231#227'o SQL>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle4
          object cxgCamposNOMCAM: TcxGridDBColumn
            Caption = 'Campo'
            DataBinding.FieldName = 'CAM_NOMCAM'
            Options.Editing = False
            Width = 84
          end
          object cxgCamposDESCAM: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'CAM_DESCAM'
            Width = 137
          end
          object cxvCamposFUNCAO: TcxGridDBColumn
            Caption = 'Fun'#231#227'o'
            DataBinding.FieldName = 'CAM_FUNCAO'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.OnChange = cxvCamposFUNCAOPropertiesChange
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 120
          end
          object cxvCamposMASCAR: TcxGridDBColumn
            Caption = 'M'#225'scara'
            DataBinding.FieldName = 'CAM_MASCAR'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediateDropDownWhenKeyPressed = False
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object cxvCamposLISTAR: TcxGridDBColumn
            Caption = 'Listar na Linha'
            DataBinding.FieldName = 'CAM_LISTAR'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5')
            Properties.OnCloseUp = cxvCamposLISTARPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 82
          end
          object cxvCamposTOTALI: TcxGridDBColumn
            Caption = 'Totalizar'
            DataBinding.FieldName = 'CAM_TOTALI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.OnCloseUp = cxvCamposTOTALIPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object cxvCamposQUEBRA: TcxGridDBColumn
            Caption = 'Quebrar'
            DataBinding.FieldName = 'CAM_QUEBRA'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxvCamposQUEBRAPropertiesChange
            OnCustomDrawCell = cxvCamposQUEBRACustomDrawCell
            HeaderAlignmentHorz = taCenter
            Width = 51
          end
          object cxvCamposLISQUE: TcxGridDBColumn
            Caption = 'Listar na Quebra'
            DataBinding.FieldName = 'CAM_LISQUE'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              '')
            Properties.OnCloseUp = cxvCamposLISQUEPropertiesCloseUp
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 82
          end
          object cxvCamposLINQUE: TcxGridDBColumn
            Caption = 'Linha da Quebra'
            DataBinding.FieldName = 'CAM_LINQUE'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsEditFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5')
            Properties.OnCloseUp = cxvCamposLINQUEPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            Width = 89
          end
          object cxvCamposCNDVIS: TcxGridDBColumn
            Caption = 'Condi'#231#227'o'
            DataBinding.FieldName = 'CAM_CNDVIS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            OnCustomDrawCell = cxvCamposCNDVISCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 66
          end
          object cxgCamposLARGUR: TcxGridDBColumn
            Caption = 'Largura (cm)'
            DataBinding.FieldName = 'CAM_LARGUR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxgCamposLARGURPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 77
          end
          object cxvCamposLARGURAREAL: TcxGridDBColumn
            Caption = 'LARGURA'
            DataBinding.FieldName = 'LARGUR'
            Visible = False
          end
          object cxvCamposPOSORD: TcxGridDBColumn
            DataBinding.FieldName = 'CAM_POSORD'
            Visible = False
          end
          object cxvCamposColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'CAM_POSICA'
            Visible = False
          end
          object cxvCamposGRUCAM: TcxGridDBColumn
            Caption = 'Grupo'
            DataBinding.FieldName = 'CAM_CODGRU'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.ClearKey = 46
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'GRU_CODGRU'
            Properties.ListColumns = <
              item
                FieldName = 'GRU_NOMGRU'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsGruPar
            HeaderAlignmentHorz = taCenter
            Width = 60
          end
          object cxvCamposSUBGRU: TcxGridDBColumn
            Caption = 'Subgrupo'
            DataBinding.FieldName = 'CAM_SUBGRU'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.ClearKey = 46
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'GRU_CODGRU'
            Properties.ListColumns = <
              item
                FieldName = 'GRU_NOMGRU'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsGruPar
            HeaderAlignmentHorz = taCenter
            Width = 60
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxvCampos
        end
      end
      object pnlDetalheTotais: TPanel
        Left = 0
        Top = 536
        Width = 1007
        Height = 40
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object Label6: TLabel
          Left = 5
          Top = 13
          Width = 162
          Height = 14
          Alignment = taRightJustify
          Caption = 'Apresenta'#231#227'o do t'#237'tulo dos totais:'
        end
        object Label8: TLabel
          Left = 427
          Top = 13
          Width = 98
          Height = 14
          Caption = 'Texto para "TOTAL":'
        end
        object cbxTipTot: TComboBoxFocus
          Left = 171
          Top = 10
          Width = 240
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 0
          OnClick = cbxTipTotClick
          Items.Strings = (
            'TOTAL + T'#237'tulo da quebra + Valor da Quebra'
            'TOTAL + T'#237'tulo da quebra'
            'TOTAL'
            'VAZIO')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeTexTot: TDBEditFocus
          Tag = 99
          Left = 528
          Top = 10
          Width = 449
          Height = 22
          DataField = 'REL_TEXTOT'
          DataSource = dtsCadRel
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 495
        Width = 1007
        Height = 41
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Shape1: TShape
          Left = 14
          Top = 15
          Width = 15
          Height = 15
          Brush.Color = clYellow
        end
        object Label7: TLabel
          Left = 35
          Top = 16
          Width = 266
          Height = 14
          Caption = 'Campos que est'#227'o no ORDER BY permitindo "Quebras"'
        end
        object lblTitQue: TLabel
          Left = 433
          Top = 16
          Width = 92
          Height = 14
          Caption = 'T'#237'tulo das quebras:'
        end
        object cbxTitQue: TComboBoxFocus
          Left = 528
          Top = 11
          Width = 457
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbxTitQueChange
          Items.Strings = (
            'Incluir os t'#237'tulos das quebras automaticamente'
            'N'#227'o listar os t'#237'tulos das quebras'
            'Incluir o cabe'#231'alho da linha de detalhe ap'#243's a quebra'
            
              'Incluir o cabe'#231'alho da linha de detalhe ap'#243's a quebra e n'#227'o list' +
              'ar os t'#237'tulos das quebras'
            'Incluir t'#237'tulos das colunas ap'#243's a '#250'ltima quebra')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object tbsGrupoFiltros: TTabSheet
      Caption = 'Grupo de Filtros'
      ImageIndex = 3
      object cxgGruposPar: TcxGrid
        Left = 0
        Top = 65
        Width = 1007
        Height = 535
        Align = alClient
        TabOrder = 1
        object cxvGruposPar: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FilterBox.CustomizeDialog = False
          FilterBox.Visible = fvNever
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para adicionar um novo grupo'
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum grupo cadastrado>'
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle3
          object cxvGruposParColumn1: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Grupo'
            DataBinding.FieldName = 'GRU_NOMGRU'
            Width = 635
          end
        end
        object cxgGruposParLevel1: TcxGridLevel
          GridView = cxvGruposPar
        end
      end
      object pnlGruposPar: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        ParentColor = True
        TabOrder = 0
        object Label9: TLabel
          Left = 8
          Top = 26
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Novo grupo de filtro:'
        end
        object btnExcluiGrupos: TBitBtnLocked
          Left = 648
          Top = 22
          Width = 154
          Height = 22
          Caption = 'Exclui &Grupo de Filtro'
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
          TabOrder = 1
          OnClick = btnExcluiGruposClick
        end
        object edtNovGru: TEditFocus
          Tag = 99
          Left = 110
          Top = 22
          Width = 465
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnInsereLoteGrupo: TBitBtnLocked
          Left = 808
          Top = 22
          Width = 189
          Height = 22
          Caption = 'Inserir Grupos mais Utilizados'
          Enabled = False
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
          TabOrder = 2
          OnClick = btnInsereLoteGrupoClick
        end
      end
      object Panel20: TPanel
        Left = 0
        Top = 600
        Width = 1007
        Height = 176
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel20'
        ShowCaption = False
        TabOrder = 2
        object GroupBox1: TGroupBox
          Left = 2
          Top = 6
          Width = 996
          Height = 168
          Caption = 'Grupo de filtros para:'
          TabOrder = 0
          object Label31: TLabel
            Left = 21
            Top = 25
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Composi'#231#227'o do Pre'#231'o de Custo:'
          end
          object Label33: TLabel
            Left = 111
            Top = 49
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'P'#225'gina Inicial:'
          end
          object Label34: TLabel
            Left = 53
            Top = 72
            Width = 122
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela de Invent'#225'rio (I_*):'
          end
          object Label35: TLabel
            Left = 5
            Top = 95
            Width = 170
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela de Invent'#225'rio - Lotes - (L_*):'
          end
          object Label36: TLabel
            Left = 23
            Top = 118
            Width = 152
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela de Invent'#225'rio (SALINV*):'
          end
          object Label37: TLabel
            Left = 27
            Top = 141
            Width = 144
            Height = 14
            Alignment = taRightJustify
            Caption = 'Invent'#225'rio Financeiro (CTR_*):'
          end
          object Label39: TLabel
            Left = 496
            Top = 25
            Width = 190
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela de Estoque Externo (ESTEXT_*):'
          end
          object Label84: TLabel
            Left = 474
            Top = 49
            Width = 212
            Height = 14
            Alignment = taRightJustify
            Caption = 'Estoque Recebido de Terceiros (ESTENT_*):'
          end
          object Label85: TLabel
            Left = 469
            Top = 72
            Width = 217
            Height = 14
            Alignment = taRightJustify
            Caption = 'Estoque Enviado para Terceiros (ESTENV_*):'
          end
          object Label90: TLabel
            Left = 647
            Top = 95
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Destino:'
          end
          object DBEditFocus1: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 21
            Width = 272
            Height = 22
            DataField = 'REL_GRUFIX'
            DataSource = dtsCadRel
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus2: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 44
            Width = 272
            Height = 22
            DataField = 'REL_GRUPAG'
            DataSource = dtsCadRel
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus3: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 67
            Width = 272
            Height = 22
            DataField = 'REL_GRUINV'
            DataSource = dtsCadRel
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus4: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 90
            Width = 272
            Height = 22
            DataField = 'REL_GRULOT'
            DataSource = dtsCadRel
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus5: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 113
            Width = 272
            Height = 22
            DataField = 'REL_GRUSAL'
            DataSource = dtsCadRel
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus6: TDBEditFocus
            Tag = 99
            Left = 177
            Top = 136
            Width = 272
            Height = 22
            DataField = 'REL_GRUCTR'
            DataSource = dtsCadRel
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus7: TDBEditFocus
            Tag = 99
            Left = 688
            Top = 21
            Width = 284
            Height = 22
            DataField = 'REL_GRUEXT'
            DataSource = dtsCadRel
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnInventario: TBitBtnLocked
            Left = 449
            Top = 67
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 7
            OnClick = btnInventarioClick
          end
          object btnLote: TBitBtnLocked
            Left = 449
            Top = 90
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 8
            OnClick = btnLoteClick
          end
          object btnSalInv: TBitBtnLocked
            Left = 449
            Top = 113
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 9
            OnClick = btnSalInvClick
          end
          object btnCtr: TBitBtnLocked
            Left = 449
            Top = 136
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 10
            OnClick = btnCtrClick
          end
          object btnEstExt: TBitBtnLocked
            Left = 972
            Top = 21
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 11
            OnClick = btnEstExtClick
          end
          object DBEditFocus23: TDBEditFocus
            Tag = 99
            Left = 688
            Top = 44
            Width = 284
            Height = 22
            DataField = 'REL_GRUENT'
            DataSource = dtsCadRel
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus24: TDBEditFocus
            Tag = 99
            Left = 688
            Top = 67
            Width = 284
            Height = 22
            DataField = 'REL_GRUENV'
            DataSource = dtsCadRel
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnEstEnt: TBitBtnLocked
            Left = 972
            Top = 44
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 14
            OnClick = btnEstEntClick
          end
          object btnEstEnv: TBitBtnLocked
            Left = 972
            Top = 67
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 15
            OnClick = btnEstEnvClick
          end
          object btnPreCus: TBitBtnLocked
            Left = 449
            Top = 21
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 16
            OnClick = btnPreCusClick
          end
          object btnPaginaInicial: TBitBtnLocked
            Left = 449
            Top = 44
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 17
            OnClick = btnPaginaInicialClick
          end
          object DBEditFocus25: TDBEditFocus
            Tag = 99
            Left = 688
            Top = 90
            Width = 284
            Height = 22
            DataField = 'REL_GRUDES'
            DataSource = dtsCadRel
            TabOrder = 18
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnDestino: TBitBtnLocked
            Left = 972
            Top = 90
            Width = 17
            Height = 22
            Caption = '...'
            TabOrder = 19
            OnClick = btnDestinoClick
          end
        end
      end
    end
    object tbsSQLFil: TTabSheet
      Caption = 'SQL para Tela de Filtros'
      ImageIndex = 8
      object Panel16: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 
          'Instru'#231#245'es que ser'#227'o executadas durante a entrada de dados (sepa' +
          'rar os grupos com "{ }")'
        ParentColor = True
        TabOrder = 1
      end
      object bceSQLFil: TBCEditor
        Left = 0
        Top = 41
        Width = 1007
        Height = 735
        Cursor = crIBeam
        ActiveLine.Indicator.Visible = False
        Align = alClient
        Caret.Options = []
        CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
        CodeFolding.Hint.Font.Color = clWindowText
        CodeFolding.Hint.Font.Height = -11
        CodeFolding.Hint.Font.Name = 'Courier New'
        CodeFolding.Hint.Font.Style = []
        CodeFolding.Hint.Indicator.Glyph.Visible = False
        CompletionProposal.CloseChars = '()[]. '
        CompletionProposal.Columns = <
          item
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            Items = <>
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Courier New'
            Title.Font.Style = []
          end>
        CompletionProposal.SecondaryShortCut = 0
        CompletionProposal.ShortCut = 16416
        CompletionProposal.Trigger.Chars = '.'
        CompletionProposal.Trigger.Enabled = False
        Directories.Colors = 'Colors'
        Directories.Highlighters = 'Highlighters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        LeftMargin.Font.Charset = DEFAULT_CHARSET
        LeftMargin.Font.Color = 13408665
        LeftMargin.Font.Height = -11
        LeftMargin.Font.Name = 'Courier New'
        LeftMargin.Font.Style = []
        Lines.Strings = (
          '')
        LineSpacing = 0
        MatchingPair.Enabled = True
        Minimap.Font.Charset = DEFAULT_CHARSET
        Minimap.Font.Color = clWindowText
        Minimap.Font.Height = -1
        Minimap.Font.Name = 'Courier New'
        Minimap.Font.Style = []
        OnExit = bceSQLFilExit
        OnKeyDown = bceSQLFilKeyDown
        ReadOnly = True
        SpecialChars.Style = scsDot
        SyncEdit.ShortCut = 24650
        TabOrder = 0
        TokenInfo.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Font.Color = clWindowText
        TokenInfo.Font.Height = -11
        TokenInfo.Font.Name = 'Courier New'
        TokenInfo.Font.Style = []
        TokenInfo.Title.Font.Charset = DEFAULT_CHARSET
        TokenInfo.Title.Font.Color = clWindowText
        TokenInfo.Title.Font.Height = -11
        TokenInfo.Title.Font.Name = 'Courier New'
        TokenInfo.Title.Font.Style = []
        UndoOptions = [uoGroupUndo]
        WordWrap.Indicator.Bitmap.Data = {
          02020000424D020200000000000042000000280000000F0000000E0000000100
          100003000000C001000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000
          1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
          10001F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C0000}
        WordWrap.Indicator.MaskColor = clFuchsia
      end
    end
    object tbsCompFiltroCab: TTabSheet
      Caption = 'Complementos da Tela de Filtro / Cabe'#231'alho'
      ImageIndex = 9
      OnResize = tbsCompFiltroCabResize
      object Splitter2: TSplitter
        Left = 0
        Top = 393
        Width = 1007
        Height = 3
        Cursor = crVSplit
        Align = alTop
        Color = clYellow
        ParentColor = False
        ExplicitWidth = 274
      end
      object pnlComplementos: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 393
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object pnlCompCabecalho: TPanel
          Left = 505
          Top = 0
          Width = 502
          Height = 393
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Panel17: TPanel
            Left = 0
            Top = 0
            Width = 502
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              502
              41)
            object Label17: TLabel
              Left = 4
              Top = 2
              Width = 494
              Height = 14
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'Informe as vari'#225'veis, presentes no SQL Principal (Aba 2),'
              ExplicitWidth = 487
            end
            object Label19: TLabel
              Left = 4
              Top = 19
              Width = 523
              Height = 14
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'que ser'#227'o listadas no cabe'#231'alho (uma por linha) '
              ExplicitWidth = 516
            end
          end
          object dbeComCab: TDBMemoFocus
            Left = 4
            Top = 41
            Width = 494
            Height = 352
            Align = alCustom
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataField = 'REL_COMCAB'
            DataSource = dtsCadRel
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
        object pnlCompTelaFiltro: TPanel
          Left = 0
          Top = 0
          Width = 505
          Height = 393
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Panel26: TPanel
            Left = 0
            Top = 0
            Width = 505
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              505
              41)
            object Label16: TLabel
              Left = 4
              Top = 2
              Width = 497
              Height = 14
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 
                'Informe as vari'#225'veis, presentes no SQL "Complementos de Filtro (' +
                'Aba 7)",'
            end
            object Label18: TLabel
              Left = 4
              Top = 19
              Width = 497
              Height = 14
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'que ser'#227'o listadas na tela de filtros (uma por linha) '
            end
          end
          object dbeCOMFIL: TDBMemoFocus
            Left = 4
            Top = 41
            Width = 497
            Height = 352
            Align = alCustom
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataField = 'REL_COMFIL'
            DataSource = dtsCadRel
            TabOrder = 1
            OnExit = dbeCOMFILExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
      end
      object pnlDirRel: TPanel
        Left = 0
        Top = 396
        Width = 1007
        Height = 380
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Panel15: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          Caption = 
            'Os direitos de acesso verde/vermelho listados abaixo ser'#227'o expor' +
            'tados no GeraScript.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
        object Panel27: TPanel
          Left = 0
          Top = 35
          Width = 1007
          Height = 46
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label29: TLabel
            Left = 12
            Top = 9
            Width = 50
            Height = 14
            Caption = 'Dir.Aceso:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodDir: TEditFocus
            Left = 68
            Top = 6
            Width = 64
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
            TabOrder = 0
            OnExit = edtCodDirExit
            OnKeyPress = edtCodDirKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
          object edtNomDir: TEditFocus
            Left = 132
            Top = 6
            Width = 412
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
          object btnIncDir: TBitBtnLocked
            Left = 556
            Top = 6
            Width = 157
            Height = 22
            Caption = '&Incluir Direito de Acesso'
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
            OnClick = btnIncDirClick
          end
        end
        object cxgDirRel: TcxGrid
          Left = 0
          Top = 81
          Width = 1007
          Height = 258
          Align = alClient
          TabOrder = 2
          object cxvDirRel: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = cxvDirRelEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NewItemRow.InfoText = 'Clique aqui para adicionar um novo relat'#243'rio'
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum relat'#243'rio adicionado>'
            OptionsView.GroupByBox = False
            object cxGridDBCODDIR: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'DIR_CODDIR'
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 77
            end
            object cxGridDBNOMDIR: TcxGridDBColumn
              Caption = 'Nome do Direito de Acesso'
              DataBinding.FieldName = 'DIR_NOMDIR'
              Options.Editing = False
              Width = 476
            end
          end
          object cxGridLevel4: TcxGridLevel
            GridView = cxvDirRel
          end
        end
        object Panel28: TPanel
          Left = 0
          Top = 339
          Width = 1007
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object btnDelDir: TBitBtnLocked
            Left = 10
            Top = 9
            Width = 199
            Height = 22
            Caption = '[ DEL ] Exclui Direito de Acesso'
            Enabled = False
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
            OnClick = btnDelDirClick
          end
        end
      end
    end
    object tbsParametros: TTabSheet
      Caption = 'Filtros'
      ImageIndex = 2
      object cxgParams: TcxGrid
        Left = 0
        Top = 22
        Width = 1007
        Height = 689
        Align = alClient
        TabOrder = 0
        object cxvParams: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.Visible = True
          OptionsBehavior.ShowLockedStateImageOptions.Sorting = lsimNever
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Sem par'#226'metros definidos na instru'#231#227'o SQL>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.ContentEven = cxStyle2
          object cxvParamsNOMPAR: TcxGridDBColumn
            Caption = 'Par'#226'metro'
            DataBinding.FieldName = 'PAR_NOMPAR'
            Options.Editing = False
            Width = 95
          end
          object cxvParamsDESPAR: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'PAR_DESPAR'
            Width = 280
          end
          object cxvParamsTIPFAC: TcxGridDBColumn
            Caption = 'Tipo de Interface'
            DataBinding.FieldName = 'PAR_TIPFAC'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.OnCloseUp = cxvParamsTIPFACPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            Width = 93
          end
          object cxvParamsTIPPAR: TcxGridDBColumn
            Caption = 'Tipo'
            DataBinding.FieldName = 'PAR_TIPPAR'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 136
          end
          object cxvParamsPESQUI: TcxGridDBColumn
            Caption = 'Tipo de Pesquisa'
            DataBinding.FieldName = 'PAR_PESQUI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.CaseInsensitive = False
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            HeaderAlignmentHorz = taCenter
            Width = 222
          end
          object cxvParamsCNDVIS: TcxGridDBColumn
            Caption = 'Condi'#231#227'o'
            DataBinding.FieldName = 'PAR_CNDVIS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            OnCustomDrawCell = cxvParamsCNDVISCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 66
          end
          object cxvParamsCODGRU: TcxGridDBColumn
            Caption = 'Grupo'
            DataBinding.FieldName = 'PAR_CODGRU'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'GRU_CODGRU'
            Properties.ListColumns = <
              item
                FieldName = 'GRU_NOMGRU'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsGruPar
            HeaderAlignmentHorz = taCenter
            Width = 93
          end
          object cxvParamsORDENA: TcxGridDBColumn
            Caption = 'Ordem'
            DataBinding.FieldName = 'PAR_ORDENA'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxvParamsGATPER: TcxGridDBColumn
            Caption = 'Gatilho de Per'#237'odo'
            DataBinding.FieldName = 'PAR_GATPER'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 61
          end
          object cxvParamsPARFIN: TcxGridDBColumn
            Caption = 'Par'#226'metro Final'
            DataBinding.FieldName = 'PAR_PARFIN'
            HeaderAlignmentHorz = taCenter
            Width = 154
          end
        end
        object cxgParamsLevel1: TcxGridLevel
          GridView = cxvParams
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Filtros para o relat'#243'rio:'
        ParentColor = True
        TabOrder = 1
      end
      object pnlRodapeFiltros: TPanel
        Left = 0
        Top = 711
        Width = 1007
        Height = 65
        Align = alBottom
        TabOrder = 2
        object btnAltFil: TBitBtnLocked
          Left = 13
          Top = 9
          Width = 125
          Height = 22
          Caption = 'Alterar &Filtro'
          Enabled = False
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
          TabOrder = 0
          OnClick = btnAltFilClick
        end
        object GroupBox3: TGroupBox
          Left = 843
          Top = 6
          Width = 134
          Height = 51
          Caption = 'Altera a ordem do filtro'
          TabOrder = 2
          object btnOrdBai: TBitBtnLocked
            Left = 68
            Top = 18
            Width = 28
            Height = 24
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000003827174D000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000003827174DB8824DFF3827174D0000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
              174D000000000000000000000000000000000000000000000000000000000000
              000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFF3827174D0000000000000000000000000000000000000000000000000000
              0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
              00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
              174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
              4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
              0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFF000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFF000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFF000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFF000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 1
            OnClick = btnOrdBaiClick
          end
          object btnOrdCim: TBitBtnLocked
            Left = 39
            Top = 18
            Width = 28
            Height = 24
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF0000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF0000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF0000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF0000000000000000000000000000000000000000000000003827
              174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
              00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
              0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
              000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
              00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
              0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
              4DFF3827174D0000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000003827174DB8824DFF3827
              174D000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000003827174D0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 0
            OnClick = btnOrdCimClick
          end
        end
        object btnRepExp: TBitBtnLocked
          Left = 144
          Top = 9
          Width = 26
          Height = 22
          Hint = 
            'Clique aqui para replicar a condi'#231#227'o de impress'#227'o do filtro para' +
            ' os demais filtros'
          Cancel = True
          Enabled = False
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000090000
            000E0000000F0000000F0000000F0000000F0000000F0000000F000000100000
            0010000000100000001000000010000000100000000F0000000A7B574BC1AC79
            68FFAC7968FFAB7968FFAB7968FFAB7968FFAA7968FFAA7969FFAA7969FFA979
            69FFA97969FFA97969FFA97A69FFA97A6AFFA87A6AFF78584CC1B27967FFF9F3
            EFFFF9F3EEFFFAF3EEFFFAF3EEFFFAF3EDFFF9F3EEFFF9F3EEFFF9F2EEFFF9F2
            EDFFF9F2EDFFF9F2EDFFF9F2EEFFF9F3EDFFF9F2EDFFB07764FFB37B69FFFAF3
            EFFF78675FFF443026FF7A6961FFA0938CFFF5EEEAFFF9F3EFFF9F928DFF5E4D
            46FFC5BCB6FF44322AFF44322AFFD3CAC4FFF9F2EEFFB17966FFB47C6AFFFAF5
            F0FF75645CFF75635CFFEDE6E1FF503C33FF817169FFFAF3EFFFF9F3F0FFFAF3
            EFFF6C5C55FF38251DFFDFD8D2FFF9F3EFFFF9F3EFFFB27A67FFB57E6CFFFAF5
            F1FFFAF5F1FFFAF4F1FFFAF5F0FF82726BFF473228FFCBC2BCFFFAF4F0FFFAF4
            F0FF877972FF47352CFFFAF4F0FFFAF4EFFFFAF4EFFFB37B69FFB7806EFFFAF6
            F2FFFAF6F2FFFAF6F1FFFAF5F1FFAC9F98FF49332AFF92837CFFFAF5F0FFFAF5
            F0FF55423CFF54433CFFE1DAD4FFFAF5F1FFFAF4F0FFB57D6AFFB88270FFFBF6
            F3FFFBF7F3FFFBF6F2FFFBF6F2FFD4CBC7FF4B362BFF68554CFFEEE8E3FF6354
            4BFF3D2A21FFAFA49EFF897B74FF63514BFFFAF5F1FFB67F6DFFB98472FFFBF7
            F3FFFCF7F3FFFBF7F4FFFBF7F3FFF5F0ECFF533E34FF4D362DFFE6DFDCFFFBF6
            F2FFFBF6F2FFFBF6F2FFFBF6F2FFFBF6F2FFFAF5F2FFB7806EFFBB8674FFFCF8
            F5FFFCF8F5FFFCF8F4FFFBF7F4FF503A30FF513930FF4F3930FF4F392FFF4F37
            2EFFFBF7F4FFFBF7F3FFFBF6F3FFFBF6F3FFFBF7F3FFB88270FFBC8976FFFCF8
            F6FFFCF9F5FFFBF8F5FFFCF8F5FFFCF8F5FFD6CEC9FF513B31FF79675EFFFBF8
            F5FFFCF7F4FFFBF7F5FFFBF8F4FFFBF7F4FFFBF7F4FFBA8473FFBE8B78FFFCF9
            F7FFFCF9F6FFFCF9F6FFFCF8F6FFFCF9F6FFFCF8F6FF91827AFF553F35FFEAE4
            E0FF827168FF827169FFFCF8F5FFFCF8F5FFFCF8F4FFBB8774FFBF8C7AFFFDFA
            F8FFFCFAF7FFFCFAF7FFFDFAF7FFFCF9F7FFFDFAF6FFFBF7F4FFAA9E97FF8271
            69FF543F34FF7F6E66FFFCF9F6FFFCF9F6FFFCF8F6FFBD8977FFC08F7DFFFDFA
            F8FFFDFAF8FFFCFBF8FFFCFAF7FFFDFAF7FFFCFAF8FFFCFAF8FFFDF9F7FFFCFA
            F8FFFDF9F7FFFCF9F7FFFCF9F6FFFCF9F6FFFCF9F7FFBE8B78FF98766AC0CD9F
            8EFFCC9F8EFFCC9F8EFFCC9F8DFFCC9E8DFFCB9E8DFFCB9D8CFFCB9D8CFFCA9C
            8BFFCA9C8BFFCA9B8AFFC99A89FFC89A88FFC89988FF947264C1000000030000
            0004000000050000000500000005000000050000000500000005000000050000
            0005000000050000000500000005000000050000000500000003}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnRepExpClick
        end
      end
    end
    object tbsComplementos: TTabSheet
      Caption = 'Relat'#243'rios Complementares'
      ImageIndex = 4
      object Splitter1: TSplitter
        Left = 0
        Top = 361
        Width = 1007
        Height = 3
        Cursor = crVSplit
        Align = alTop
        Color = clYellow
        ParentColor = False
        ExplicitLeft = -3
        ExplicitTop = 314
        ExplicitWidth = 1000
      end
      object Panel7: TPanel
        Left = 0
        Top = 40
        Width = 1007
        Height = 321
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          Caption = 
            'Os relat'#243'rios adicionados abaixo ser'#227'o listados ao final desse r' +
            'elat'#243'rio. '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
        object Panel9: TPanel
          Left = 0
          Top = 20
          Width = 1007
          Height = 46
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object lbl8: TLabel
            Left = 47
            Top = 9
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Relat'#243'rio:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodCom: TEditFocus
            Left = 94
            Top = 6
            Width = 64
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
            TabOrder = 0
            OnExit = edtCodComExit
            OnKeyPress = edtCodComKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
          object edtDesCom: TEditFocus
            Left = 159
            Top = 6
            Width = 412
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
          object btnIncCom: TBitBtnLocked
            Left = 576
            Top = 6
            Width = 133
            Height = 22
            Caption = '&Incluir Relat'#243'rio'
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
            OnClick = btnIncComClick
          end
        end
        object cxgRelat: TcxGrid
          Left = 0
          Top = 66
          Width = 1007
          Height = 190
          Align = alClient
          TabOrder = 2
          object cxvRelat: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = cxvRelatEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NewItemRow.InfoText = 'Clique aqui para adicionar um novo relat'#243'rio'
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum relat'#243'rio adicionado>'
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            object cxvRelatCODREL: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'REL_CODREL'
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 77
            end
            object cxvRelatDESCRI: TcxGridDBColumn
              Caption = 'Nome do Relat'#243'rio'
              DataBinding.FieldName = 'REL_DESCRI'
              Options.Editing = False
              Width = 462
            end
            object cxvRelatDESCMP: TcxGridDBColumn
              Caption = 'Descri'#231#227'o Complementar'
              DataBinding.FieldName = 'REL_DESCMP'
              Width = 242
            end
            object cxvRelatORDENA: TcxGridDBColumn
              AlternateCaption = 'REL_ORDENA'
              Caption = 'Ordem'
              DataBinding.FieldName = 'REL_ORDENA'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 83
            end
            object cxvRelatNOVPAG: TcxGridDBColumn
              Caption = 'Iniciar em nova p'#225'gina/arquivo'
              DataBinding.FieldName = 'REL_NOVPAG'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 125
            end
          end
          object cxgRelatLevel1: TcxGridLevel
            GridView = cxvRelat
          end
        end
        object pnlRodapeComplementares: TPanel
          Left = 0
          Top = 256
          Width = 1007
          Height = 65
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object btnDelCom: TBitBtnLocked
            Left = 10
            Top = 9
            Width = 162
            Height = 22
            Caption = '[ DEL ] Exclui Complemento'
            Enabled = False
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
            OnClick = btnDelComClick
          end
          object GroupBox16: TGroupBox
            Left = 423
            Top = 6
            Width = 154
            Height = 51
            Caption = 'Altera a ordem do relat'#243'rio'
            TabOrder = 1
            object BitBtnLocked1: TBitBtnLocked
              Left = 76
              Top = 18
              Width = 28
              Height = 24
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174D000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFF3827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 1
              OnClick = BitBtnLocked1Click
            end
            object BitBtnLocked2: TBitBtnLocked
              Left = 47
              Top = 18
              Width = 28
              Height = 24
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174DB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000003827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 0
              OnClick = BitBtnLocked2Click
            end
          end
        end
      end
      object Panel22: TPanel
        Left = 0
        Top = 364
        Width = 1007
        Height = 412
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object Panel23: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          Caption = 
            'Os subrelat'#243'rios (childs) adicionados abaixo ser'#227'o listados conf' +
            'orme a quebra definida.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
        object Panel24: TPanel
          Left = 0
          Top = 35
          Width = 1007
          Height = 46
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label28: TLabel
            Left = 32
            Top = 9
            Width = 45
            Height = 14
            Caption = 'Relat'#243'rio:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodChi: TEditFocus
            Left = 80
            Top = 6
            Width = 64
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
            TabOrder = 0
            OnExit = edtCodChiExit
            OnKeyPress = edtCodChiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
          object edtDesChi: TEditFocus
            Left = 145
            Top = 6
            Width = 412
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
          object btnIncChi: TBitBtnLocked
            Left = 562
            Top = 6
            Width = 133
            Height = 22
            Caption = '&Incluir Relat'#243'rio'
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
            OnClick = btnIncChiClick
          end
        end
        object cxgChirel: TcxGrid
          Left = 0
          Top = 81
          Width = 1007
          Height = 290
          Align = alClient
          TabOrder = 2
          object cxvChirel: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = cxvChirelEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NewItemRow.InfoText = 'Clique aqui para adicionar um novo relat'#243'rio'
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum relat'#243'rio adicionado>'
            OptionsView.GroupByBox = False
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'REL_CODREL'
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 77
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = 'Nome do Relat'#243'rio'
              DataBinding.FieldName = 'REL_DESCRI'
              Options.Editing = False
              Width = 485
            end
            object cxGridDBColumn3: TcxGridDBColumn
              Caption = 'Desc. Complementar'
              DataBinding.FieldName = 'REL_DESCMP'
              Visible = False
              Options.Editing = False
              Width = 242
            end
            object cxGridDBColumn4: TcxGridDBColumn
              AlternateCaption = 'REL_ORDENA'
              Caption = 'Ordem'
              DataBinding.FieldName = 'REL_ORDENA'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 57
            end
            object cxvChirelNomCam: TcxGridDBColumn
              Caption = 'Quebra'
              DataBinding.FieldName = 'REL_NOMCAM'
              PropertiesClassName = 'TcxComboBoxProperties'
              Width = 95
            end
            object cxvChirelCamLig: TcxGridDBColumn
              Caption = 'Campos de Liga'#231#227'o'
              DataBinding.FieldName = 'REL_CAMLIG'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.CharCase = ecUpperCase
              Width = 257
            end
          end
          object cxgChirelLevel1: TcxGridLevel
            GridView = cxvChirel
          end
        end
        object Panel25: TPanel
          Left = 0
          Top = 371
          Width = 1007
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object btnDelChi: TBitBtnLocked
            Left = 10
            Top = 9
            Width = 162
            Height = 22
            Caption = '[ DEL ] Exclui Child'
            Enabled = False
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
            OnClick = btnDelChiClick
          end
        end
      end
      object pnlRelPai: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 40
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlRelPai'
        ShowCaption = False
        TabOrder = 0
        object Label11: TLabel
          Left = 30
          Top = 12
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Relat'#243'rio Pai:'
        end
        object dbeCodPai: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 9
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REL_CODPAI'
          DataSource = dtsCadRel
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnKeyPress = dbeCodPaiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesCodPai: TEditFocus
          Left = 160
          Top = 9
          Width = 549
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
    object tbsHistorico: TTabSheet
      Caption = 'Hist'#243'rico de altera'#231#245'es'
      ImageIndex = 9
      object Panel19: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          1007
          776)
        object Label21: TLabel
          Left = 10
          Top = 11
          Width = 103
          Height = 14
          Caption = 'T'#237'tulo do hist'#243'rico:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Left = 375
          Top = 11
          Width = 57
          Height = 14
          Caption = 'Descri'#231#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label23: TLabel
          Left = 10
          Top = 56
          Width = 52
          Height = 14
          Caption = 'Hist'#243'rico:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTitHis: TEditFocus
          Tag = 99
          Left = 10
          Top = 28
          Width = 359
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesHis: TMemoFocus
          Left = 375
          Top = 28
          Width = 625
          Height = 444
          Anchors = [akLeft, akTop, akRight, akBottom]
          CharCase = ecUpperCase
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object cxgHisto: TcxGrid
          Left = 10
          Top = 73
          Width = 359
          Height = 399
          Align = alCustom
          Anchors = [akLeft, akTop, akBottom]
          Enabled = False
          TabOrder = 2
          object cxvHisto: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxvHistoCellClick
            OnEditKeyDown = cxvHistoEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NewItemRow.InfoText = 'Clique aqui para adicionar um novo relat'#243'rio'
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum hist'#243'rico adicionado>'
            OptionsView.GroupByBox = False
            object cxvHistoColumn3: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'HIS_DTACAD'
              Width = 79
            end
            object cxvHistoColumn4: TcxGridDBColumn
              Caption = 'Hora'
              DataBinding.FieldName = 'HIS_HORCAD'
            end
            object cxvHistoColumn1: TcxGridDBColumn
              Caption = 'T'#237'tulo'
              DataBinding.FieldName = 'HIS_TITULO'
              Width = 190
            end
          end
          object cxGridLevel3: TcxGridLevel
            GridView = cxvHisto
          end
        end
        object btnIncHis: TBitBtnLocked
          Left = 653
          Top = 478
          Width = 67
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Incluir'
          Enabled = False
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
          OnClick = btnIncHisClick
        end
        object btnAltHis: TBitBtnLocked
          Left = 790
          Top = 478
          Width = 66
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Alterar'
          Enabled = False
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
          TabOrder = 5
          OnClick = btnAltHisClick
        end
        object btnDelHis: TBitBtnLocked
          Left = 858
          Top = 478
          Width = 66
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Excluir'
          Enabled = False
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
          TabOrder = 6
          OnClick = btnDelHisClick
        end
        object btnCanHis: TBitBtnLocked
          Left = 926
          Top = 478
          Width = 74
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          Enabled = False
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
          OnClick = btnCanHisClick
        end
        object btnGraHis: TBitBtnLocked
          Left = 722
          Top = 478
          Width = 66
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Gravar'
          Enabled = False
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
          TabOrder = 4
          OnClick = btnGraHisClick
        end
      end
    end
    object tbsGrafico: TTabSheet
      Caption = 'Configura'#231#245'es do Gr'#225'fico'
      ImageIndex = 10
      object Panel29: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel29'
        ShowCaption = False
        TabOrder = 0
        object GroupBox2: TGroupBox
          Left = 8
          Top = 13
          Width = 553
          Height = 108
          Caption = 'T'#237'tulo do Relat'#243'rio'
          TabOrder = 0
          object Label44: TLabel
            Left = 163
            Top = 59
            Width = 62
            Height = 14
            Caption = 'Alinhamento:'
          end
          object Label45: TLabel
            Left = 15
            Top = 59
            Width = 41
            Height = 14
            Caption = 'Posi'#231#227'o:'
          end
          object Label40: TLabel
            Left = 15
            Top = 18
            Width = 30
            Height = 14
            Caption = 'Fonte:'
          end
          object dbeFntCam: TDBEditFocus
            Left = 15
            Top = 32
            Width = 474
            Height = 22
            TabStop = False
            DataField = 'REL_FONTIT'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnSetaFonte: TBitBtnLocked
            Tag = 99
            Left = 490
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnSetaFonteClick
          end
          object btnLimpaFonte: TBitBtnLocked
            Tag = 99
            Left = 516
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnLimpaFonteClick
          end
          object cmbPosTit: TComboBoxFocus
            Tag = 99
            Left = 15
            Top = 73
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 3
            Items.Strings = (
              'Default'
              'N'#227'o Mostrar'
              'Esquerda'
              'Topo'
              'Direita'
              'Base')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbAliTit: TComboBoxFocus
            Tag = 99
            Left = 163
            Top = 73
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 4
            Items.Strings = (
              'Centro'
              'Default'
              'Final'
              'In'#237'cio')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 127
          Width = 553
          Height = 123
          Caption = 'Legenda'
          TabOrder = 1
          object Label48: TLabel
            Left = 15
            Top = 18
            Width = 30
            Height = 14
            Caption = 'Fonte:'
          end
          object Label49: TLabel
            Left = 311
            Top = 59
            Width = 68
            Height = 14
            Caption = 'Cor do Fundo:'
          end
          object Label47: TLabel
            Left = 15
            Top = 59
            Width = 41
            Height = 14
            Caption = 'Posi'#231#227'o:'
          end
          object Label46: TLabel
            Left = 163
            Top = 59
            Width = 62
            Height = 14
            Caption = 'Alinhamento:'
          end
          object DBEditFocus15: TDBEditFocus
            Left = 15
            Top = 32
            Width = 474
            Height = 22
            TabStop = False
            DataField = 'REL_FONLEG'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnSetFonteLegenda: TBitBtnLocked
            Left = 490
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnSetFonteLegendaClick
          end
          object btnSetaCorLegendaFundo: TcxDBColorComboBox
            Tag = 99
            Left = 311
            Top = 73
            DataBinding.DataField = 'REL_FUNLEG'
            DataBinding.DataSource = dtsCadRel
            Properties.AllowSelectColor = True
            Properties.ClearKey = 46
            Properties.ColorDialogShowFull = True
            Properties.ColorDialogType = cxcdtAdvanced
            Properties.CustomColors = <>
            TabOrder = 2
            Width = 169
          end
          object btnLimpaFonteLegenda: TBitBtnLocked
            Left = 516
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteLegendaClick
          end
          object cmbPosLeg: TComboBoxFocus
            Tag = 99
            Left = 15
            Top = 73
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 4
            Items.Strings = (
              'Default'
              'N'#227'o Mostrar'
              'Esquerda'
              'Topo'
              'Direita'
              'Base')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbAliLeg: TComboBoxFocus
            Tag = 99
            Left = 163
            Top = 73
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 5
            Items.Strings = (
              'Centro'
              'Default'
              'Final'
              'In'#237'cio')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object DBCheckBox13: TDBCheckBox
            Left = 15
            Top = 101
            Width = 169
            Height = 17
            Caption = 'Com borda'
            DataField = 'REL_BORLEG'
            DataSource = dtsCadRel
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object GroupBox6: TGroupBox
          Left = 8
          Top = 258
          Width = 553
          Height = 108
          Caption = 'Eixo Vertical'
          TabOrder = 2
          object Label42: TLabel
            Left = 11
            Top = 18
            Width = 25
            Height = 14
            Caption = 'T'#237'tulo'
          end
          object Label50: TLabel
            Left = 11
            Top = 59
            Width = 27
            Height = 14
            Caption = 'Fonte'
          end
          object DBEditFocus9: TDBEditFocus
            Tag = 99
            Left = 11
            Top = 33
            Width = 474
            Height = 22
            DataField = 'REL_VALTIT'
            DataSource = dtsCadRel
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeCodModExit
            OnKeyPress = dbeCodModKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus16: TDBEditFocus
            Left = 11
            Top = 73
            Width = 474
            Height = 22
            TabStop = False
            DataField = 'REL_VALFON'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnFonteEixoY: TBitBtnLocked
            Left = 486
            Top = 73
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnFonteEixoYClick
          end
          object btnLimpaFonteEixoY: TBitBtnLocked
            Left = 512
            Top = 73
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteEixoYClick
          end
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 380
          Width = 553
          Height = 108
          Caption = 'Eixo Horizontal'
          TabOrder = 3
          object Label51: TLabel
            Left = 11
            Top = 18
            Width = 25
            Height = 14
            Caption = 'T'#237'tulo'
          end
          object Label52: TLabel
            Left = 11
            Top = 59
            Width = 27
            Height = 14
            Caption = 'Fonte'
          end
          object DBEditFocus17: TDBEditFocus
            Tag = 99
            Left = 11
            Top = 33
            Width = 474
            Height = 22
            DataField = 'REL_CATTIT'
            DataSource = dtsCadRel
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeCodModExit
            OnKeyPress = dbeCodModKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus18: TDBEditFocus
            Left = 11
            Top = 73
            Width = 474
            Height = 22
            TabStop = False
            DataField = 'REL_CATFON'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnFonteEixoX: TBitBtnLocked
            Left = 486
            Top = 73
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnFonteEixoXClick
          end
          object btnLimpaFonteEixoX: TBitBtnLocked
            Left = 512
            Top = 73
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteEixoXClick
          end
        end
        object GroupBox8: TGroupBox
          Left = 567
          Top = 13
          Width = 426
          Height = 133
          Caption = 'Caracter'#237'sticas Gerais do Gr'#225'fico'
          TabOrder = 4
          object Label43: TLabel
            Left = 7
            Top = 45
            Width = 41
            Height = 14
            Caption = 'Moldura:'
          end
          object Label59: TLabel
            Left = 213
            Top = 45
            Width = 76
            Height = 14
            Caption = 'Cor da Moldura:'
          end
          object Label60: TLabel
            Left = 107
            Top = 45
            Width = 97
            Height = 14
            Caption = 'Largura da Moldura:'
          end
          object Label68: TLabel
            Left = 158
            Top = 85
            Width = 156
            Height = 14
            Caption = 'Tempo de refresh em segundos:'
          end
          object Label69: TLabel
            Left = 9
            Top = 85
            Width = 109
            Height = 14
            Caption = 'Categorias por p'#225'gina:'
          end
          object dbeVarCor: TDBCheckBox
            Left = 8
            Top = 23
            Width = 154
            Height = 17
            Caption = 'V'#225'rias cores por categoria'
            DataField = 'REL_VARCOR'
            DataSource = dtsCadRel
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox11: TDBCheckBox
            Left = 168
            Top = 23
            Width = 114
            Height = 17
            Caption = 'Linhas Horizontais'
            DataField = 'REL_LINHOR'
            DataSource = dtsCadRel
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox12: TDBCheckBox
            Left = 288
            Top = 23
            Width = 100
            Height = 17
            Caption = 'Linhas Verticais'
            DataField = 'REL_LINVER'
            DataSource = dtsCadRel
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object cmbMolGra: TComboBoxFocus
            Tag = 99
            Left = 7
            Top = 59
            Width = 94
            Height = 22
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 3
            Text = 'Arredondada'
            Items.Strings = (
              'Arredondada'
              'Reta')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object bntCorMoldura: TcxDBColorComboBox
            Left = 213
            Top = 59
            DataBinding.DataField = 'REL_CORMOL'
            DataBinding.DataSource = dtsCadRel
            Properties.AllowSelectColor = True
            Properties.ClearKey = 46
            Properties.ColorDialogShowFull = True
            Properties.ColorDialogType = cxcdtAdvanced
            Properties.CustomColors = <>
            TabOrder = 5
            Width = 169
          end
          object DBEditFocus12: TDBEditFocus
            Tag = 99
            Left = 107
            Top = 59
            Width = 100
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_WIDMOL'
            DataSource = dtsCadRel
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTemRef: TDBEditFocus
            Tag = 99
            Left = 158
            Top = 99
            Width = 157
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_TEMREF'
            DataSource = dtsCadRel
            TabOrder = 7
            OnKeyPress = DBEditFocus14KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus20: TDBEditFocus
            Tag = 99
            Left = 7
            Top = 99
            Width = 145
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_CATPAG'
            DataSource = dtsCadRel
            TabOrder = 6
            OnKeyPress = DBEditFocus14KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox9: TGroupBox
          Left = 567
          Top = 380
          Width = 426
          Height = 123
          Caption = 'Gr'#225'fico de Colunas / Barras / Torta'
          TabOrder = 5
          object Label41: TLabel
            Left = 6
            Top = 27
            Width = 148
            Height = 14
            Caption = 'Posi'#231#227'o dos captions de valor:'
          end
          object Label61: TLabel
            Left = 7
            Top = 69
            Width = 137
            Height = 14
            Caption = 'Fonte dos captions de valor:'
          end
          object cmbValCap: TComboBoxFocus
            Tag = 99
            Left = 6
            Top = 42
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'N'#227'o Mostrar'
              'Base'
              'Centro'
              'Topo, dentro'
              'Topo, Fora')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeFonCap: TDBEditFocus
            Left = 7
            Top = 83
            Width = 341
            Height = 22
            TabStop = False
            DataField = 'REL_FONCAP'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnSetaFonteCaptions: TBitBtnLocked
            Left = 349
            Top = 83
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnSetaFonteCaptionsClick
          end
          object btnLimpaFonteCaptions: TBitBtnLocked
            Left = 375
            Top = 83
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteCaptionsClick
          end
        end
        object GroupBox11: TGroupBox
          Left = 567
          Top = 511
          Width = 426
          Height = 108
          Caption = 'Gr'#225'fico de Linha / '#193'rea'
          TabOrder = 6
          object Label54: TLabel
            Left = 6
            Top = 19
            Width = 154
            Height = 14
            Caption = 'Posi'#231#227'o dos caption de valores:'
          end
          object Label53: TLabel
            Left = 166
            Top = 19
            Width = 68
            Height = 14
            Caption = 'Estilo da linha:'
          end
          object Label55: TLabel
            Left = 317
            Top = 19
            Width = 95
            Height = 14
            Caption = 'Espessura da linha:'
          end
          object Label56: TLabel
            Left = 166
            Top = 61
            Width = 76
            Height = 14
            Caption = 'Estilo da Marca:'
          end
          object Label57: TLabel
            Left = 317
            Top = 61
            Width = 103
            Height = 14
            Caption = 'Espessura da Marca:'
          end
          object cmbLinCap: TComboBoxFocus
            Tag = 99
            Left = 6
            Top = 33
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'N'#227'o Mostrar'
              'Esquerda'
              'Acima'
              'Direita'
              'Abaixo'
              'Centro'
              'Acima, direita'
              'Abaixo, direita'
              'Acima, esquerda'
              'Abaixo, esquerda')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbLinSty: TComboBoxFocus
            Tag = 99
            Left = 166
            Top = 33
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 1
            Items.Strings = (
              'S'#243'lido'
              'Sem Linha'
              'Tra'#231'o'
              'Ponto'
              'Tra'#231'o ponto'
              'Tra'#231'o ponto ponto')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object DBEditFocus8: TDBEditFocus
            Tag = 99
            Left = 317
            Top = 33
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_LINWID'
            DataSource = dtsCadRel
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object cmbMarSty: TComboBoxFocus
            Tag = 99
            Left = 166
            Top = 75
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 3
            Items.Strings = (
              'Sem marca'
              'C'#237'rculo'
              'Diamante'
              'Quadrado'
              'Tri'#226'ngulo')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object DBEditFocus10: TDBEditFocus
            Tag = 99
            Left = 317
            Top = 75
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_MARWID'
            DataSource = dtsCadRel
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox10: TGroupBox
          Left = 567
          Top = 628
          Width = 426
          Height = 47
          Caption = 'Gr'#225'fico de '#193'rea'
          TabOrder = 7
          object Label58: TLabel
            Left = 8
            Top = 20
            Width = 86
            Height = 14
            Caption = '% Transpar'#234'ncia:'
          end
          object DBEditFocus11: TDBEditFocus
            Tag = 99
            Left = 100
            Top = 15
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_TRAARE'
            DataSource = dtsCadRel
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox12: TGroupBox
          Left = 8
          Top = 494
          Width = 553
          Height = 197
          Caption = 'Gr'#225'fico de Torta'
          TabOrder = 8
          object Label62: TLabel
            Left = 11
            Top = 27
            Width = 148
            Height = 14
            Caption = 'Posi'#231#227'o dos captions de valor:'
          end
          object Label63: TLabel
            Left = 12
            Top = 109
            Width = 116
            Height = 14
            Caption = 'Fonte do T'#237'tulo da S'#233'rie:'
          end
          object Label64: TLabel
            Left = 12
            Top = 150
            Width = 154
            Height = 14
            Caption = 'Cor do Fundo do T'#237'tulo da S'#233'rie:'
          end
          object Label65: TLabel
            Left = 241
            Top = 86
            Width = 144
            Height = 14
            Caption = 'N'#250'mero de colunas de s'#233'ries:'
          end
          object cmbPieCap: TComboBoxFocus
            Tag = 99
            Left = 11
            Top = 42
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Fora'
              'Centro'
              'Dentro'
              'N'#227'o Mostrar'
              'Fora com l'#237'der')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeSITCAP: TDBEditFocus
            Left = 12
            Top = 123
            Width = 341
            Height = 22
            TabStop = False
            DataField = 'REL_SITCAP'
            DataSource = dtsCadRel
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnFonteTitutoSerieTorta: TBitBtnLocked
            Left = 354
            Top = 123
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnFonteTitutoSerieTortaClick
          end
          object btnLimpaFonteTitutoSerieTorta: TBitBtnLocked
            Left = 380
            Top = 123
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteTitutoSerieTortaClick
          end
          object btnSetaCorFundoTituloSerie: TcxDBColorComboBox
            Left = 12
            Top = 164
            DataBinding.DataField = 'REL_FUNSIT'
            DataBinding.DataSource = dtsCadRel
            Properties.AllowSelectColor = True
            Properties.ClearKey = 46
            Properties.ColorDialogShowFull = True
            Properties.ColorDialogType = cxcdtAdvanced
            Properties.CustomColors = <>
            TabOrder = 4
            Width = 169
          end
          object DBCheckBox14: TDBCheckBox
            Left = 12
            Top = 83
            Width = 135
            Height = 17
            Caption = 'Mostrar t'#237'tulo da s'#233'rie'
            DataField = 'REL_SERCAP'
            DataSource = dtsCadRel
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox15: TDBCheckBox
            Left = 153
            Top = 85
            Width = 82
            Height = 17
            Caption = 'Com borda'
            DataField = 'REL_SERSIT'
            DataSource = dtsCadRel
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBEditFocus13: TDBEditFocus
            Tag = 99
            Left = 389
            Top = 81
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_SERCOL'
            DataSource = dtsCadRel
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object GroupBox13: TGroupBox
            Left = 172
            Top = 21
            Width = 234
            Height = 49
            Caption = 'Mostrar no caption'
            TabOrder = 8
            object DBCheckBox16: TDBCheckBox
              Left = 10
              Top = 24
              Width = 53
              Height = 17
              Caption = 'Valor'
              DataField = 'REL_ITEVAL'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox17: TDBCheckBox
              Left = 69
              Top = 24
              Width = 84
              Height = 17
              Caption = 'Percentual'
              DataField = 'REL_ITEPER'
              DataSource = dtsCadRel
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox18: TDBCheckBox
              Left = 150
              Top = 24
              Width = 67
              Height = 17
              Caption = 'Legenda'
              DataField = 'REL_ITECAT'
              DataSource = dtsCadRel
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
        end
        object btnLayGra: TBitBtnLocked
          Left = 815
          Top = 396
          Width = 153
          Height = 25
          Caption = 'Layout dos Gr'#225'ficos'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000000000000000000000000000000000007E5446B7B074
            62FFAF7461FFAF7460FFAE735FFFAE725FFFAD715EFFAD715EFFAD715EFFAC70
            5CFFAC705CFFAC6F5BFFAC6F5BFFAB6F5BFFAB6E5AFF7B4F41B7B67E6CFFFBF6
            F3FFFAF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFAF4F1FFFAF4F1FFFAF4F1FFF9F4
            F0FFF9F4F0FFF9F3F0FFF8F3EFFFF9F3EFFFF8F2EEFFB37968FFB77F6FFFFBF7
            F4FFF7EFE9FFF6EEE9FFF6EEE9FFF6EEE9FFF6EEE9FFF7EEE8FFF7EEE8FFF6EE
            E8FFF6EEE8FFF6EEE8FFF6EDE7FFF5EDE7FFF9F4F0FFB47B6AFFB88171FFFBF8
            F5FF1C4C9CFF1B4C9BFF978D92FF975231FFB69182FFF7EFE9FFF7EFE9FF1B4B
            9AFF1A4B9AFF978D91FF975330FFB69081FFFAF4F2FFB47C6BFFB98472FFFCF9
            F7FF1F509EFF7DCAFFFF595F7DFFF2C48EFF7A381EFFF8F0EBFFF8F0EBFF1D4D
            9CFF7CC8FFFF585E7DFFF3C792FF7B391FFFFAF6F3FFB67F6DFFBB8674FFFDFA
            F8FF2253A1FF7ECAFFFF5A627FFFF2C58EFF7C3B20FFF7F0ECFFF7F0ECFF1F4F
            9FFF7DC9FFFF5A627FFFF3C895FF803D23FFFAF7F5FFB7806FFFBC8877FFFDFB
            F9FF2557A4FF7FCAFFFF5D6581FFF3C690FF803D23FFF8F2EDFFF8F2EDFF2152
            A0FF7DCAFFFF5D6481FFF4CA97FF824226FFFBF8F6FFB98271FFBF8C7AFFFEFC
            FBFF295BA7FF7FCBFFFF616884FFF4C792FF834126FFF9F4F0FFF9F4F0FF2455
            A3FF7FCAFFFF5F6784FFF4CB9AFF88462AFFFCFAF9FFBB8675FFBF8C7AFFFEFC
            FBFF2C60AAFFFFFFFFFF636C87FFF3C894FF844428FFF9F4F0FFF9F4F0FF2658
            A5FF7FCBFFFF616A86FFFFFFFFFF8B4A2DFFFCFAF9FFBB8675FFC08D7DFFFEFD
            FCFF96ADD0FF3062ADFF656F89FFF4C996FF88482BFFF9F4F1FFF9F4F1FF295B
            A7FF7FCBFFFF466397FFBC875DFFAE774FFFFDFBFAFFBC8877FFC28F7EFFFEFD
            FDFFFBF6F3FFFAF6F3FFBB8655FFF4CB98FF8B4B2DFFFAF5F2FFFAF5F2FF2C5E
            AAFFFFFFFFFF2B5DA9FFF9F4F1FFFAF4F0FFFDFCFAFFBE8A79FFC39281FFFEFE
            FDFFFBF7F4FFFAF7F4FFBC8756FFFFFFFFFF8D4E2FFFFAF6F3FFFAF6F3FF95AD
            D0FF2F61ACFF2E61ACFFFAF5F2FFF9F6F2FFFDFCFCFFBF8D7BFFC49483FFFFFE
            FEFFFBF8F5FFFCF8F5FFDDC1A7FFBC885DFFAE784FFFFBF7F4FFFBF7F4FFFBF6
            F4FFFAF7F3FFFAF6F3FFFAF6F3FFFAF6F3FFFEFDFCFFC08F7EFFC59584FFFFFE
            FEFFFCF8F7FFFBF8F6FFFCF8F6FFFBF8F5FFFBF8F6FFFBF8F5FFFBF8F5FFFCF8
            F5FFFBF8F5FFFBF7F4FFFBF7F4FFFBF7F4FFFEFDFDFFC2907FFFC69786FFFFFF
            FEFFFFFFFEFFFFFEFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
            FEFFFEFEFEFFFEFEFEFFFFFEFEFFFFFEFDFFFEFEFDFFC39281FF997A6EBDCFA4
            94FFCFA393FFCEA393FFCEA393FFCEA292FFCEA292FFCDA292FFCDA292FFCDA1
            91FFCDA090FFCCA090FFCC9F8FFFCB9E8EFFCB9E8EFF967469BD}
          TabOrder = 9
          Visible = False
          OnClick = btnLayGraClick
        end
        object GroupBox14: TGroupBox
          Left = 567
          Top = 152
          Width = 425
          Height = 214
          Caption = 'Layout da Tela para relat'#243'rios complementares'
          TabOrder = 10
          object Label66: TLabel
            Left = 9
            Top = 20
            Width = 143
            Height = 14
            Caption = 'N'#250'mero de colunas do layout:'
          end
          object Label67: TLabel
            Left = 158
            Top = 20
            Width = 137
            Height = 14
            Caption = 'N'#250'mero de Linhas do layout:'
          end
          object DBEditFocus14: TDBEditFocus
            Tag = 99
            Left = 7
            Top = 34
            Width = 145
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_COLGRA'
            DataSource = dtsCadRel
            TabOrder = 0
            OnKeyPress = DBEditFocus14KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeLINGRA: TDBEditFocus
            Tag = 99
            Left = 158
            Top = 34
            Width = 145
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REL_LINGRA'
            DataSource = dtsCadRel
            TabOrder = 1
            OnExit = dbeLINGRAExit
            OnKeyPress = dbeLINGRAKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtNumGra: TEdit
            Left = 309
            Top = 34
            Width = 71
            Height = 22
            TabOrder = 2
            Text = 'edtNumGra'
            Visible = False
          end
          object dbeInfCol: TDBCheckBox
            Left = 8
            Top = 64
            Width = 201
            Height = 17
            Caption = 'Informar n'#250'mero de colunas por linha'
            DataField = 'REL_INFCOL'
            DataSource = dtsCadRel
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeInfColClick
          end
          object cxgColunasPorLinha: TcxGrid
            Left = 8
            Top = 85
            Width = 201
            Height = 123
            TabOrder = 4
            object cxvColunasPorLinha: TcxGridDBTableView
              Tag = 99
              Navigator.Buttons.CustomButtons = <>
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = ',0;-,0'
                  Kind = skSum
                  Column = cxvColunasPorLinhaQTDCOL
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              object cxvColunasPorLinhaNROLIN: TcxGridDBColumn
                Caption = 'Linha'
                DataBinding.FieldName = 'NROLIN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.Alignment.Horz = taCenter
                Properties.DecimalPlaces = 0
                Properties.DisplayFormat = ',0;-,0'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Options.Sorting = False
                SortIndex = 0
                SortOrder = soAscending
              end
              object cxvColunasPorLinhaQTDCOL: TcxGridDBColumn
                Caption = 'N'#250'mero de Colunas'
                DataBinding.FieldName = 'QTDCOL'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.Alignment.Horz = taCenter
                Properties.DecimalPlaces = 0
                Properties.DisplayFormat = ',0;-,0'
                HeaderAlignmentHorz = taCenter
                Width = 110
              end
            end
            object cxgColunasPorLinhaLevel1: TcxGridLevel
              GridView = cxvColunasPorLinha
            end
          end
          object DBCheckBox19: TDBCheckBox
            Left = 215
            Top = 64
            Width = 201
            Height = 17
            Caption = 'Ajustar a altura das linhas no layout'
            DataField = 'REL_INFALT'
            DataSource = dtsCadRel
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeInfColClick
          end
        end
      end
    end
    object tbsRodape: TTabSheet
      Caption = 'Rodap'#233' do Grid'
      ImageIndex = 11
      object pnlConfRodapeCabec: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlConfRodapeCabec'
        ShowCaption = False
        TabOrder = 0
        object pnlConfRodape: TPanel
          Left = 0
          Top = 41
          Width = 1007
          Height = 64
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlConfRodape'
          ShowCaption = False
          TabOrder = 0
          object bdeLAYROD: TDBRadioGroup
            Left = 19
            Top = 3
            Width = 195
            Height = 49
            Caption = 'Posi'#231#227'o do T'#237'tulo em rela'#231#227'o ao dado'
            Columns = 2
            DataField = 'REL_LAYROD'
            DataSource = dtsCadRel
            Items.Strings = (
              'acima'
              'na frente')
            TabOrder = 0
            Values.Strings = (
              '1'
              '2')
          end
          object dbeALIROD: TDBRadioGroup
            Left = 220
            Top = 3
            Width = 159
            Height = 49
            Caption = 'Alinhamento entre os campos'
            Columns = 2
            DataField = 'REL_ALIROD'
            DataSource = dtsCadRel
            Items.Strings = (
              'simples'
              'detalhado')
            TabOrder = 1
            Values.Strings = (
              '1'
              '2')
            OnChange = dbeALIRODChange
          end
        end
        object pnlTituloRodapeGrid: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Configura'#231#245'es do Rodap'#233
          TabOrder = 1
        end
        object pnlDadosRodapeGrid: TPanel
          Left = 0
          Top = 105
          Width = 1007
          Height = 88
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel7'
          ShowCaption = False
          TabOrder = 2
          object pnlDadosComumRodapeGrid: TPanel
            Left = 0
            Top = 0
            Width = 1007
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            Caption = 'pnlDadosComumRodapeGrid'
            ShowCaption = False
            TabOrder = 0
            object Label70: TLabel
              Left = 18
              Top = 6
              Width = 36
              Height = 14
              Caption = 'Campo:'
            end
            object btnIncRodape: TBitBtnLocked
              Left = 675
              Top = 2
              Width = 133
              Height = 22
              Caption = '&Inclui /Altera Campo'
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
              OnClick = btnIncRodapeClick
            end
            object cxlCampos: TcxLookupComboBox
              Left = 56
              Top = 3
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'CAM_NOMCAM'
              Properties.ListColumns = <
                item
                  Width = 50
                  FieldName = 'CAM_NOMCAM'
                end
                item
                  FieldName = 'CAM_DESCAM'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              TabOrder = 1
              Width = 613
            end
          end
          object pnlRodapeDetalhado: TPanel
            Left = 0
            Top = 30
            Width = 1007
            Height = 58
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'pnlRodapeDetalhado'
            ShowCaption = False
            TabOrder = 1
            object Label71: TLabel
              Left = 564
              Top = 7
              Width = 101
              Height = 14
              Caption = 'Campo de refer'#234'ncia'
            end
            object cxlCampoReferenciaRodape: TcxLookupComboBox
              Left = 564
              Top = 21
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'CAM_NOMCAM'
              Properties.ListColumns = <
                item
                  Width = 50
                  FieldName = 'CAM_NOMCAM'
                end
                item
                  FieldName = 'CAM_DESCAM'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              TabOrder = 0
              Width = 242
            end
            object rdgPOSREL: TRadioGroup
              Left = 18
              Top = 1
              Width = 540
              Height = 45
              Caption = 'Posi'#231#227'o em rela'#231#227'o ao campo de refer'#234'ncia'
              Columns = 3
              ItemIndex = 0
              Items.Strings = (
                'Abaixo, alinhado pelo conte'#250'do'
                'Abaixo, alinhado pelo t'#237'tulo'
                'Direita')
              TabOrder = 1
            end
          end
        end
        object Panel33: TPanel
          Left = 0
          Top = 717
          Width = 1007
          Height = 59
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object btnExcluiRodape: TBitBtnLocked
            Left = 7
            Top = 20
            Width = 154
            Height = 22
            Caption = 'Exclui campo do rodap'#233
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
            OnClick = btnExcluiRodapeClick
          end
          object GroupBox15: TGroupBox
            Left = 195
            Top = 6
            Width = 134
            Height = 51
            Caption = 'Altera a ordem do campo'
            TabOrder = 1
            object btnIncRod: TBitBtnLocked
              Left = 68
              Top = 18
              Width = 28
              Height = 24
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174D000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFF3827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 1
              OnClick = btnIncRodClick
            end
            object btnDecRod: TBitBtnLocked
              Left = 39
              Top = 18
              Width = 28
              Height = 24
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174DB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000003827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 0
              OnClick = btnDecRodClick
            end
          end
        end
        object cxgRodapeGrid: TcxGrid
          Tag = 99
          Left = 0
          Top = 193
          Width = 1007
          Height = 524
          Align = alClient
          TabOrder = 4
          object cxvRodapeGrid: TcxGridDBTableView
            Tag = 99
            Navigator.Buttons.CustomButtons = <>
            OnCellDblClick = cxvRodapeGridCellDblClick
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnSorting = False
            OptionsSelection.HideFocusRectOnExit = False
            OptionsView.NoDataToDisplayInfoText = '<Nemhum campo informado>'
            OptionsView.GroupByBox = False
            Styles.ContentEven = cxStyle4
            object cxvRodapeGridColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo do campo'
              DataBinding.FieldName = 'CAM_NOMCAM'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 100
            end
            object cxvRodapeGridDESCAM: TcxGridDBColumn
              Caption = 'Descri'#231#227'o do campo'
              DataBinding.FieldName = 'CAM_DESCAM'
              HeaderAlignmentHorz = taCenter
              Width = 327
            end
            object cxvRodapeGridLARGUR: TcxGridDBColumn
              Caption = 'Largura (cm)'
              DataBinding.FieldName = 'CAM_LARGUR'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Properties.OnValidate = cxvRodapeGridLARGURPropertiesValidate
              HeaderAlignmentHorz = taCenter
              Width = 74
            end
            object cxvRodapeGridColumn2: TcxGridDBColumn
              Caption = 'Altura (cm)'
              DataBinding.FieldName = 'CAM_ALTURA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              Width = 70
            end
            object cxvRodapeGridNOVROD: TcxGridDBColumn
              Caption = 'Iniciar nova linha'
              DataBinding.FieldName = 'CAM_NOVROD'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 89
            end
            object cxvRodapeGridColumn5: TcxGridDBColumn
              DataBinding.FieldName = 'CAM_ORDROD'
              Visible = False
              SortIndex = 0
              SortOrder = soAscending
            end
            object cxvRodapeGridPOSREL: TcxGridDBColumn
              Caption = 'Posi'#231#227'o'
              DataBinding.FieldName = 'POSREL'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 178
            end
            object cxvRodapeGridREFROD: TcxGridDBColumn
              Caption = 'Refer'#234'ncia'
              DataBinding.FieldName = 'CAM_REFROD'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 119
            end
          end
          object cxgRodapeGridLevel1: TcxGridLevel
            GridView = cxvRodapeGrid
          end
        end
      end
    end
    object tbsDashboard: TTabSheet
      Caption = 'Configura'#231#245'es Dashboard'
      ImageIndex = 12
      object pnlDashboard: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlDashboard'
        ShowCaption = False
        TabOrder = 0
        object Panel41: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 401
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel41'
          ShowCaption = False
          TabOrder = 0
          object GroupBox17: TGroupBox
            Left = 19
            Top = 8
            Width = 350
            Height = 385
            Caption = 'Layout da Tela para relat'#243'rios complementares'
            TabOrder = 0
            object Label73: TLabel
              Left = 13
              Top = 22
              Width = 137
              Height = 14
              Caption = 'N'#250'mero de Linhas do layout:'
            end
            object dbeLinGraDash: TDBEditFocus
              Tag = 99
              Left = 13
              Top = 36
              Width = 145
              Height = 22
              CharCase = ecUpperCase
              DataField = 'REL_LINGRA'
              DataSource = dtsCadRel
              TabOrder = 0
              OnExit = dbeLinGraDashExit
              OnKeyPress = dbeLINGRAKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object cxGrid1: TcxGrid
              Left = 13
              Top = 64
              Width = 321
              Height = 305
              TabOrder = 1
              object cxvColunasPorLinhaDashboard: TcxGridDBTableView
                Tag = 99
                Navigator.Buttons.CustomButtons = <>
                DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Format = ',0;-,0'
                    Kind = skSum
                    Column = cxGridDBColumn6
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsCustomize.ColumnHorzSizing = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Inserting = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.Footer = True
                OptionsView.GroupByBox = False
                object cxGridDBColumn5: TcxGridDBColumn
                  Caption = 'Linha'
                  DataBinding.FieldName = 'NROLIN'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.Alignment.Horz = taCenter
                  Properties.DecimalPlaces = 0
                  Properties.DisplayFormat = ',0;-,0'
                  HeaderAlignmentHorz = taCenter
                  Options.Editing = False
                  Options.Sorting = False
                  SortIndex = 0
                  SortOrder = soAscending
                end
                object cxGridDBColumn6: TcxGridDBColumn
                  Caption = 'N'#250'mero de Colunas'
                  DataBinding.FieldName = 'QTDCOL'
                  PropertiesClassName = 'TcxComboBoxProperties'
                  Properties.DropDownListStyle = lsFixedList
                  Properties.ImmediatePost = True
                  Properties.Items.Strings = (
                    '1'
                    '2'
                    '3'
                    '4'
                    '5')
                  HeaderAlignmentHorz = taCenter
                  Width = 110
                end
                object cxvColunasPorLinhaDashboardPROPOR: TcxGridDBColumn
                  Caption = 'Propor'#231#227'o'
                  DataBinding.FieldName = 'DEFPRO'
                  PropertiesClassName = 'TcxLookupComboBoxProperties'
                  Properties.ClearKey = 46
                  Properties.DropDownListStyle = lsFixedList
                  Properties.ImmediatePost = True
                  Properties.KeyFieldNames = 'PRO_DEFPRO'
                  Properties.ListColumns = <
                    item
                      FieldName = 'PRO_DEFPRO'
                    end>
                  Properties.ListOptions.AnsiSort = True
                  Properties.ListOptions.ShowHeader = False
                  Properties.OnValidate = cxvColunasPorLinhaDashboardPROPORPropertiesValidate
                  HeaderAlignmentHorz = taCenter
                  Width = 130
                end
              end
              object cxGridLevel5: TcxGridLevel
                GridView = cxvColunasPorLinhaDashboard
              end
            end
          end
          object grpDashWeb: TGroupBox
            Left = 375
            Top = 175
            Width = 473
            Height = 114
            Caption = 'Configura'#231#245'es para Dashboard WEB'
            TabOrder = 1
            object Label86: TLabel
              Left = 21
              Top = 50
              Width = 98
              Height = 14
              Caption = 'Tempo para Refresh'
            end
            object DBCheckBox32: TDBCheckBox
              Left = 21
              Top = 27
              Width = 316
              Height = 17
              Caption = 'Pode utilizar no Dashboard WEB'
              DataField = 'REL_DASWEB'
              DataSource = dtsCadRel
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeTempoRefreshWEB: TDBEditFocus
              Tag = 99
              Left = 21
              Top = 64
              Width = 145
              Height = 22
              CharCase = ecUpperCase
              DataField = 'REL_DASTEM'
              DataSource = dtsCadRel
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object GroupBox18: TGroupBox
            Left = 375
            Top = 8
            Width = 473
            Height = 153
            Caption = 'Para gr'#225'ficos tipo Card'
            TabOrder = 2
            object Label72: TLabel
              Left = 21
              Top = 30
              Width = 75
              Height = 14
              Caption = 'Chave do '#237'cone'
            end
            object Label93: TLabel
              Left = 21
              Top = 98
              Width = 32
              Height = 14
              Caption = 'StyleId'
            end
            object dbeICOGRA: TDBEditFocus
              Tag = 99
              Left = 21
              Top = 44
              Width = 436
              Height = 22
              DataField = 'REL_ICOGRA'
              DataSource = dtsCadRel
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object btnIcoGra: TBitBtnLocked
              Left = 21
              Top = 67
              Width = 100
              Height = 25
              Caption = 'Selecionar'
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
              TabOrder = 1
              OnClick = btnIcoGraClick
            end
            object dbeSTYLID: TDBEditFocus
              Tag = 99
              Left = 21
              Top = 112
              Width = 436
              Height = 22
              DataField = 'REL_STYLID'
              DataSource = dtsCadRel
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
        object Panel43: TPanel
          Left = 0
          Top = 401
          Width = 1007
          Height = 375
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel43'
          ShowCaption = False
          TabOrder = 1
          object Panel44: TPanel
            Left = 0
            Top = 0
            Width = 1007
            Height = 33
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Stylesheet'
            TabOrder = 0
          end
          object DBMemoFocus2: TDBMemoFocus
            Left = 0
            Top = 33
            Width = 1007
            Height = 342
            Align = alClient
            DataField = 'REL_STYSHE'
            DataSource = dtsCadRel
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
      end
    end
    object tbsRotinas: TTabSheet
      Caption = 'Bot'#245'es do Relat'#243'rio'
      ImageIndex = 13
      object pnlRotinas: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlRotinas'
        ShowCaption = False
        TabOrder = 0
        object pnlBotoesGrid: TPanel
          Left = 0
          Top = 320
          Width = 1007
          Height = 350
          Align = alTop
          BevelOuter = bvLowered
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 1
          object cxgBotGrid: TcxGrid
            Left = 1
            Top = 133
            Width = 1005
            Height = 166
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvBotGrid: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnSorting = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.HideFocusRectOnExit = False
              OptionsView.NoDataToDisplayInfoText = '<Nenhum bot'#227'o cadastrado>'
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Styles.ContentOdd = cxStyle5
              Bands = <
                item
                  Caption = 'Bot'#245'es do Grid'
                end>
              object cxvBotGridCAMROT: TcxGridDBBandedColumn
                Caption = 'Campos da Rotina'
                DataBinding.FieldName = 'CAMROT'
                Width = 1000
                Position.BandIndex = -1
                Position.ColIndex = -1
                Position.RowIndex = -1
              end
              object cxvBotGridDESROT: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o da Rotina / T'#237'tulo do Relat'#243'rio'
                DataBinding.FieldName = 'DESROT'
                Options.Editing = False
                Options.Filtering = False
                Width = 260
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvBotGridColumn1: TcxGridDBBandedColumn
                Caption = 'T'#237'tulo do Bot'#227'o'
                DataBinding.FieldName = 'ROT_TITBOT'
                Options.Filtering = False
                Width = 220
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxvBotGridColumnTeclaAtalho: TcxGridDBBandedColumn
                Caption = 'Atalho de Teclado'
                DataBinding.FieldName = 'ROT_TECATA'
                Options.Filtering = False
                Width = 130
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxvBotGridColumn4: TcxGridDBBandedColumn
                Caption = 'Executa Direto'
                DataBinding.FieldName = 'ROT_EXEDIR'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 55
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object cxvBotGridColumn5: TcxGridDBBandedColumn
                Caption = 'Copia Filtros do Pai'
                DataBinding.FieldName = 'ROT_COPPAI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 66
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object cxvBotGridColumn2: TcxGridDBBandedColumn
                Caption = 'Relat'#243'rio'
                DataBinding.FieldName = 'CODREL'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvBotGridMAPPAR: TcxGridDBBandedColumn
                Caption = 'Mapeia Par'#226'metros'
                PropertiesClassName = 'TcxButtonEditProperties'
                Properties.Buttons = <
                  item
                    Default = True
                    Glyph.SourceDPI = 96
                    Glyph.Data = {
                      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                      6100000013744558745469746C65005265706C6163653B456469743B69AAF970
                      000002F149444154785E75915D6C937514C67FFFFFDB8FE55D69D7956EEB04D9
                      66A62E534CBCD1B8044214A251D165892C92DDA937A80496A1018D5E2C1A45B8
                      003F50512442442E9CCA0226651780103BB20FD8071B3A098432F75537BBEE6D
                      DF36EFB14B7AC1C57692274F724E9E5F4ECEE1FD1383BC9717A00057DB57BF37
                      BE7DE4F2E13D47FB7ADE393690D9FD5D6FCFAEC3B16FDE3CD0D5047800BDE83B
                      0E5D6A075CECF9FE0A806E6EFB6275DBD7DD9D1FFD744DCE0C4E49773C2557A7
                      3372E956527EEE9F94F61F07E48D83174E6FD8D25AFBDADEDFF66E3F1413C054
                      80DEBAFBC84391AAFAB3F5F79785EB6AC324B342D611727969402B459186E1D1
                      09864627161EAC2D33874727F9724783DF15A9595BBC225C736CED03E5E1F255
                      4146EEA418B83AC6CD1B534C4FFD4765652955D51554DF574EE5EA107EBF698A
                      D78DD51B07D0FA89A6B75A827EDFC381B09FBFC6E7E98AF6712E1AEBF8F34ACF
                      D6A1E88135D7FA622DE7BB62BFF65E1E63FC5F8B9468C667D3585606C07029A3
                      F8A57B569510CF3707FBC718EE1FFA65ECE2B7DB66E383338033F577F799C79A
                      F7AD0F044C1C1473E91CB6ED904EDB005A6D6EEB4C28A582083840E2F650CBC5
                      1F769D7C6EE729BB73FFF39E275F3DFA81C70CB68A0882B0E8885A74A29F3596
                      02F8819540391002BC80062878F15DF30A205250087003E83F1A1ED976A1BE5A
                      4ED4449E2D841091BB05A09B3E471A0F22CF7C8CAC7F974F004303DAC965373A
                      8681CEC926C060E9D2730998BCC1E6F93BAC931CAD8FBE42AD06DCD905FB054B
                      38AD1CE745C0BD1C206B41661E236B13CA58303FC1AC3E5E57F5F4CC5C929393
                      89FD02F76E2FF1D5017A098002304BE9C04B8795E0D3EBA7F28022918D019FC9
                      CBC11567B54099529B96D942A7123031427332CE16D1BC5EF9382B752669AD8B
                      8D4FEF7B6AE4E69A3971A25E910D806729809D816C1AC35EC095CB80F61072D9
                      76B6FE9F5CAE15984939CEB922A17D99438A52E08B703C0F213DCB87B7CF731D
                      C007780B21132801DC4BBCD1007C8579002802F4FFAFBC55FD76C606D2000000
                      0049454E44AE426082}
                    Kind = bkEllipsis
                  end>
                Properties.ViewStyle = vsButtonsOnly
                Properties.OnButtonClick = cxvBotGridMAPPARPropertiesButtonClick
                HeaderAlignmentHorz = taCenter
                Width = 67
                Position.BandIndex = 0
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object cxvBotGridColumn3: TcxGridDBBandedColumn
                Caption = 'ORDEM'
                DataBinding.FieldName = 'ROT_ORDBOT'
                Visible = False
                Options.Editing = False
                SortIndex = 0
                SortOrder = soAscending
                Position.BandIndex = 0
                Position.ColIndex = 8
                Position.RowIndex = 0
              end
              object cxvBotGridCampoRotina: TcxGridDBBandedColumn
                Caption = 'Campos da Rotina'
                PropertiesClassName = 'TcxButtonEditProperties'
                Properties.Buttons = <
                  item
                    Default = True
                    Kind = bkEllipsis
                  end>
                Properties.ViewStyle = vsButtonsOnly
                Properties.OnButtonClick = cxvBotGridCampoRotinaPropertiesButtonClick
                HeaderAlignmentHorz = taCenter
                Position.BandIndex = 0
                Position.ColIndex = 9
                Position.RowIndex = 0
              end
              object cxvBotGridFecSai: TcxGridDBBandedColumn
                Caption = 'Fechar Grid Ap'#243's Executar'
                DataBinding.FieldName = 'ROT_FECTEL'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                Properties.OnValidate = cxvBotGridFecSaiPropertiesValidate
                HeaderAlignmentHorz = taCenter
                Width = 66
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
            end
            object cxgBotGridLevel1: TcxGridLevel
              GridView = cxvBotGrid
            end
          end
          object pnlInlcuiRotina: TPanel
            Left = 1
            Top = 103
            Width = 1005
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel4'
            ShowCaption = False
            TabOrder = 2
            object lblRotinaGrid: TLabel
              Left = 59
              Top = 6
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'Rotina:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object btnIncRotGrid: TBitBtnLocked
              Left = 577
              Top = 2
              Width = 133
              Height = 22
              Caption = '&Incluir Bot'#227'o'
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
              OnClick = btnIncRotGridClick
            end
            object cxlRotinaGrid: TcxLookupComboBox
              Left = 94
              Top = 2
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'NOMROT'
              Properties.ListColumns = <
                item
                  FieldName = 'DESROT'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              TabOrder = 1
              Width = 477
            end
          end
          object pnlExcluiRotina: TPanel
            Left = 1
            Top = 299
            Width = 1005
            Height = 50
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'pnlExcluiRotina'
            ShowCaption = False
            TabOrder = 4
            object btnExcluiBotaoGrid: TBitBtnLocked
              Left = 7
              Top = 9
              Width = 162
              Height = 22
              Caption = '[ DEL ] Exclui Bot'#227'o'
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
              OnClick = btnExcluiBotaoGridClick
            end
            object GroupBox20: TGroupBox
              Left = 431
              Top = 1
              Width = 135
              Height = 45
              Caption = 'Altera a ordem do bot'#227'o'
              TabOrder = 1
              object btnIncBotGrid: TBitBtnLocked
                Left = 69
                Top = 18
                Width = 28
                Height = 24
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000000000003827174D000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000003827174DB8824DFF3827174D0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
                  174D000000000000000000000000000000000000000000000000000000000000
                  000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF3827174D0000000000000000000000000000000000000000000000000000
                  0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                  00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
                  174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 1
                OnClick = btnIncBotGridClick
              end
              object btnDecBotGrid: TBitBtnLocked
                Left = 40
                Top = 18
                Width = 28
                Height = 24
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000003827
                  174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
                  00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                  0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
                  000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
                  00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                  0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
                  4DFF3827174D0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000000000003827174DB8824DFF3827
                  174D000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000003827174D0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 0
                OnClick = btnDecBotGridClick
              end
            end
          end
          object Panel31: TPanel
            Left = 1
            Top = 1
            Width = 1005
            Height = 20
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Bot'#245'es do relat'#243'rio quando gerado em grid '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
          end
          object Panel32: TPanel
            Left = 1
            Top = 49
            Width = 1005
            Height = 54
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object lblCodRelGrid: TLabel
              Left = 47
              Top = 12
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Relat'#243'rio:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtCodRelGrid: TEditFocus
              Tag = 99
              Left = 94
              Top = 6
              Width = 64
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
              TabOrder = 0
              OnKeyPress = edtCodRelGridKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 6
              TipoTexto = ttNumerico
            end
            object edtCodRelGridDes: TEditFocus
              Left = 159
              Top = 6
              Width = 412
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
            object chkCopValGrid: TCheckBox
              Left = 94
              Top = 34
              Width = 235
              Height = 17
              Caption = 'Copiar os valores dos filtros do relat'#243'rio pai'
              TabOrder = 2
            end
            object chkExeDirGrid: TCheckBox
              Left = 336
              Top = 34
              Width = 195
              Height = 17
              Caption = 'Executar sem abrir a tela dos filtros'
              TabOrder = 3
            end
            object chkFecSaiGrid: TCheckBox
              Left = 542
              Top = 34
              Width = 259
              Height = 17
              Caption = 'Fechar grid ap'#243's executar a rotina com sucesso'
              TabOrder = 4
            end
          end
          object Panel34: TPanel
            Left = 1
            Top = 21
            Width = 1005
            Height = 28
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel34'
            ShowCaption = False
            TabOrder = 0
            object Label79: TLabel
              Left = 18
              Top = 9
              Width = 74
              Height = 14
              Caption = 'T'#237'tulo do Bot'#227'o:'
            end
            object Label82: TLabel
              Left = 477
              Top = 9
              Width = 90
              Height = 14
              Caption = 'T'#237'tulo de chamada:'
            end
            object Label87: TLabel
              Left = 692
              Top = 9
              Width = 89
              Height = 14
              Caption = 'Atalho de Teclado:'
            end
            object edtTitBotGrid: TEditFocus
              Left = 94
              Top = 3
              Width = 350
              Height = 22
              Alignment = taLeftJustify
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object cmbTipChaGrid: TComboBoxFocus
              Left = 570
              Top = 3
              Width = 90
              Height = 22
              Style = csDropDownList
              TabOrder = 1
              OnChange = cmbTipChaGridChange
              Items.Strings = (
                'Relat'#243'rio'
                'Rotina')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtAtaRelGrid: TEdit
              Left = 785
              Top = 3
              Width = 181
              Height = 22
              ReadOnly = True
              TabOrder = 2
              OnKeyDown = edtAtaRelGridKeyDown
            end
          end
        end
        object pnlBotoesTelaFiltros: TPanel
          Left = 0
          Top = 0
          Width = 1007
          Height = 320
          Align = alTop
          BevelOuter = bvLowered
          Caption = 'pnlBotoesTelaFiltros'
          ShowCaption = False
          TabOrder = 0
          object cxgBotFil: TcxGrid
            Left = 1
            Top = 133
            Width = 1005
            Height = 136
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 3
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvBotFil: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnSorting = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.HideFocusRectOnExit = False
              OptionsView.NoDataToDisplayInfoText = '<Nenhum bot'#227'o cadastrado>'
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Styles.ContentOdd = cxStyle5
              Bands = <
                item
                  Caption = 'Bot'#245'es da tela de filtros'
                end>
              object cxGridDBBandedColumn1: TcxGridDBBandedColumn
                Caption = 'Campos da Rotina'
                DataBinding.FieldName = 'CAMROT'
                Width = 1000
                Position.BandIndex = -1
                Position.ColIndex = -1
                Position.RowIndex = -1
              end
              object cxvBotFilDESROT: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o da Rotina / T'#237'tulo do Relat'#243'rio'
                DataBinding.FieldName = 'DESROT'
                Options.Editing = False
                Options.Filtering = False
                Width = 260
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxvBotFilTeclaAtalho: TcxGridDBBandedColumn
                Caption = 'Tecla de Atalho'
                DataBinding.FieldName = 'ROT_TECATA'
                Options.Editing = False
                Options.Filtering = False
                Width = 150
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxvCodFilTITBOT: TcxGridDBBandedColumn
                Caption = 'T'#237'tulo do Bot'#227'o'
                DataBinding.FieldName = 'ROT_TITBOT'
                Options.Filtering = False
                Width = 220
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxvCodFiEXEDIR: TcxGridDBBandedColumn
                Caption = 'Executa Direto'
                DataBinding.FieldName = 'ROT_EXEDIR'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 55
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object cxvCodFilCOPPAI: TcxGridDBBandedColumn
                Caption = 'Copia Filtros do Pai'
                DataBinding.FieldName = 'ROT_COPPAI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 66
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object cxvBotFilCODREL: TcxGridDBBandedColumn
                Caption = 'Relat'#243'rio'
                DataBinding.FieldName = 'CODREL'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvBotFilMAPPAR: TcxGridDBBandedColumn
                Caption = 'Mapeia Par'#226'metros'
                PropertiesClassName = 'TcxButtonEditProperties'
                Properties.Buttons = <
                  item
                    Default = True
                    Glyph.SourceDPI = 96
                    Glyph.Data = {
                      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                      6100000013744558745469746C65005265706C6163653B456469743B69AAF970
                      000002F149444154785E75915D6C937514C67FFFFFDB8FE55D69D7956EEB04D9
                      66A62E534CBCD1B8044214A251D165892C92DDA937A80496A1018D5E2C1A45B8
                      003F50512442442E9CCA0226651780103BB20FD8071B3A098432F75537BBEE6D
                      DF36EFB14B7AC1C57692274F724E9E5F4ECEE1FD1383BC9717A00057DB57BF37
                      BE7DE4F2E13D47FB7ADE393690D9FD5D6FCFAEC3B16FDE3CD0D5047800BDE83B
                      0E5D6A075CECF9FE0A806E6EFB6275DBD7DD9D1FFD744DCE0C4E49773C2557A7
                      3372E956527EEE9F94F61F07E48D83174E6FD8D25AFBDADEDFF66E3F1413C054
                      80DEBAFBC84391AAFAB3F5F79785EB6AC324B342D611727969402B459186E1D1
                      09864627161EAC2D33874727F9724783DF15A9595BBC225C736CED03E5E1F255
                      4146EEA418B83AC6CD1B534C4FFD4765652955D51554DF574EE5EA107EBF698A
                      D78DD51B07D0FA89A6B75A827EDFC381B09FBFC6E7E98AF6712E1AEBF8F34ACF
                      D6A1E88135D7FA622DE7BB62BFF65E1E63FC5F8B9468C667D3585606C07029A3
                      F8A57B569510CF3707FBC718EE1FFA65ECE2B7DB66E383338033F577F799C79A
                      F7AD0F044C1C1473E91CB6ED904EDB005A6D6EEB4C28A582083840E2F650CBC5
                      1F769D7C6EE729BB73FFF39E275F3DFA81C70CB68A0882B0E8885A74A29F3596
                      02F8819540391002BC80062878F15DF30A205250087003E83F1A1ED976A1BE5A
                      4ED4449E2D841091BB05A09B3E471A0F22CF7C8CAC7F974F004303DAC965373A
                      8681CEC926C060E9D2730998BCC1E6F93BAC931CAD8FBE42AD06DCD905FB054B
                      38AD1CE745C0BD1C206B41661E236B13CA58303FC1AC3E5E57F5F4CC5C929393
                      89FD02F76E2FF1D5017A098002304BE9C04B8795E0D3EBA7F28022918D019FC9
                      CBC11567B54099529B96D942A7123031427332CE16D1BC5EF9382B752669AD8B
                      8D4FEF7B6AE4E69A3971A25E910D806729809D816C1AC35EC095CB80F61072D9
                      76B6FE9F5CAE15984939CEB922A17D99438A52E08B703C0F213DCB87B7CF731D
                      C007780B21132801DC4BBCD1007C8579002802F4FFAFBC55FD76C606D2000000
                      0049454E44AE426082}
                    Kind = bkEllipsis
                  end>
                Properties.ViewStyle = vsButtonsOnly
                Properties.OnButtonClick = cxvBotFilMAPPARPropertiesButtonClick
                HeaderAlignmentHorz = taCenter
                Width = 67
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object cxvBotFilORDBOT: TcxGridDBBandedColumn
                Caption = 'ORDEM'
                DataBinding.FieldName = 'ROT_ORDBOT'
                Visible = False
                Options.Editing = False
                SortIndex = 0
                SortOrder = soAscending
                Position.BandIndex = 0
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
            end
            object cxGridLevel6: TcxGridLevel
              GridView = cxvBotFil
            end
          end
          object Panel35: TPanel
            Left = 1
            Top = 103
            Width = 1005
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel4'
            ShowCaption = False
            TabOrder = 2
            object lblRotinaFil: TLabel
              Left = 59
              Top = 6
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'Rotina:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object btnIncRotFil: TBitBtnLocked
              Left = 576
              Top = 2
              Width = 133
              Height = 22
              Caption = '&Incluir Bot'#227'o'
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
              OnClick = btnIncRotFilClick
            end
            object cxlRotinaFil: TcxLookupComboBox
              Left = 94
              Top = 2
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'NOMROT'
              Properties.ListColumns = <
                item
                  FieldName = 'DESROT'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              TabOrder = 1
              Width = 477
            end
          end
          object Panel36: TPanel
            Left = 1
            Top = 269
            Width = 1005
            Height = 50
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'pnlExcluiRotina'
            ShowCaption = False
            TabOrder = 4
            object btnExcluiBotaoFil: TBitBtnLocked
              Left = 7
              Top = 9
              Width = 162
              Height = 22
              Caption = '[ DEL ] Exclui Bot'#227'o'
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
              OnClick = btnExcluiBotaoFilClick
            end
            object GroupBox21: TGroupBox
              Left = 431
              Top = 1
              Width = 135
              Height = 45
              Caption = 'Altera a ordem do bot'#227'o'
              TabOrder = 1
              object btnIncBotFiltro: TBitBtnLocked
                Left = 69
                Top = 17
                Width = 28
                Height = 24
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000000000003827174D000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000003827174DB8824DFF3827174D0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
                  174D000000000000000000000000000000000000000000000000000000000000
                  000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF3827174D0000000000000000000000000000000000000000000000000000
                  0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                  00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
                  174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFF000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 1
                OnClick = btnIncBotFiltroClick
              end
              object btnDecBotFiltro: TBitBtnLocked
                Left = 40
                Top = 17
                Width = 28
                Height = 24
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF0000000000000000000000000000000000000000000000003827
                  174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
                  00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                  0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
                  000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
                  00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
                  4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                  0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
                  4DFF3827174D0000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000000000003827174DB8824DFF3827
                  174D000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000003827174D0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 0
                OnClick = btnDecBotFiltroClick
              end
            end
          end
          object Panel37: TPanel
            Left = 1
            Top = 1
            Width = 1005
            Height = 20
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Bot'#245'es da tela de filtros'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
          end
          object Panel38: TPanel
            Left = 1
            Top = 49
            Width = 1005
            Height = 54
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object lblCodRelFil: TLabel
              Left = 47
              Top = 12
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Relat'#243'rio:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtCodRelFil: TEditFocus
              Tag = 99
              Left = 94
              Top = 6
              Width = 64
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
              TabOrder = 0
              OnKeyPress = edtCodRelFilKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 6
              TipoTexto = ttNumerico
            end
            object edtCodRelFilDes: TEditFocus
              Left = 159
              Top = 6
              Width = 412
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
            object chkCopValFil: TCheckBox
              Left = 95
              Top = 34
              Width = 235
              Height = 17
              Caption = 'Copiar os valores dos filtros do relat'#243'rio pai'
              TabOrder = 2
            end
            object chkExeDirFil: TCheckBox
              Left = 334
              Top = 34
              Width = 207
              Height = 17
              Caption = 'Executar sem abrir a tela dos filtros'
              TabOrder = 3
            end
          end
          object Panel39: TPanel
            Left = 1
            Top = 21
            Width = 1005
            Height = 28
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel34'
            ShowCaption = False
            TabOrder = 0
            object Label81: TLabel
              Left = 18
              Top = 9
              Width = 74
              Height = 14
              Caption = 'T'#237'tulo do Bot'#227'o:'
            end
            object Label75: TLabel
              Left = 477
              Top = 9
              Width = 90
              Height = 14
              Caption = 'T'#237'tulo de chamada:'
            end
            object Label88: TLabel
              Left = 692
              Top = 9
              Width = 89
              Height = 14
              Caption = 'Atalho de Teclado:'
            end
            object edtTitBotFil: TEditFocus
              Left = 94
              Top = 3
              Width = 350
              Height = 22
              Alignment = taLeftJustify
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object cmbTipChaFil: TComboBoxFocus
              Left = 570
              Top = 3
              Width = 90
              Height = 22
              Style = csDropDownList
              TabOrder = 1
              OnChange = cmbTipChaFilChange
              Items.Strings = (
                'Relat'#243'rio'
                'Rotina')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtAtaRelFil: TEdit
              Left = 785
              Top = 3
              Width = 181
              Height = 22
              ReadOnly = True
              TabOrder = 2
              OnKeyDown = edtAtaRelFilKeyDown
            end
          end
        end
      end
    end
    object tbsScriptBeforePost: TTabSheet
      Caption = 'Beforepost do Grid'
      ImageIndex = 14
      object pnlValidacao: TPanel
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        BevelOuter = bvLowered
        Caption = 'pnlValidacao'
        ParentColor = True
        TabOrder = 0
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 1005
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Script do beforepost do grid'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          object btnAjudaBeforePost: TBitBtnLocked
            Left = 111
            Top = 3
            Width = 100
            Height = 22
            Caption = 'Ajuda Script'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
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
            TabOrder = 0
            OnClick = btnAjudaBeforePostClick
          end
          object btnCompila: TBitBtnLocked
            Left = 8
            Top = 3
            Width = 99
            Height = 22
            Caption = 'Compila'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000010000000200000001000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000040000000A00000009000000040000000100000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000003070615205743B9081510410000000F0000000700000003000000010000
              0000000000000000000000000000000000000000000000000000000000000000
              000003080616328466FF2F7E64FC1D4C3CA6050D0A300000000E000000060000
              0002000000010000000000000000000000000000000000000000000000000000
              00000308061635896AFF56C8A2FF46A57DFF318064F51942348F020605220000
              000C000000050000000200000000000000000000000000000000000000000000
              000003080616388E6FFF63CEACFF49C69EFF51C29BFF4BA680FF317E63EA1536
              2A77010202190000000B00000005000000010000000000000000000000000000
              0000030907163A9373FF70D4B4FF4EC9A2FF4EC9A2FF4EC9A2FF55BF97FF4DA7
              82FF2F7960DC1029215F00000010000000050000000100000000000000000000
              0000040907163D9978FF7CD8BCFF53CCA7FF53CCA7FF53CCA7FF53CCA7FF5CCF
              ACFF64C09DFF52A886FF2D715AC40916112B0000000100000000000000000000
              000004090716409E7EFF89DDC4FF58CFABFF59CFACFF6ED5B6FF85DCC1FF8ADD
              C4FF8ADDC4FF7AC7A9FF5BAD90FF16362C5B0000000000000000000000000000
              0000040A081642A483FF94E1CAFF66D4B4FF87DEC4FF8EE0C8FF8EE0C8FF86D2
              B7FF66B89AFF337E66C810292141000000000000000000000000000000000000
              0000040A081645A987FFA6E7D4FF8FE1C9FF91E2CBFF94DCC4FF74C2A5FF3B91
              75DD183B2F5A0001010200000000000000000000000000000000000000000000
              0000040A081648AE8CFFC0EFE2FFA2E6D1FF7CC9ADFF42A082ED204E40750204
              0307000000000000000000000000000000000000000000000000000000000000
              0000040A09144DB392FF8AD0B7FF48AC8CF72862508D050B0911000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000040B09114CB594FE317761A70915121F0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000020504070F231D3200000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 1
            OnClick = btnCompilaClick
          end
        end
        object stmSCRBEF: TfsSyntaxMemo
          AlignWithMargins = True
          Left = 4
          Top = 29
          Width = 999
          Height = 743
          Cursor = crIBeam
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          TabStop = True
          BlockColor = clHighlight
          BlockFontColor = clHighlightText
          CommentAttr.Charset = DEFAULT_CHARSET
          CommentAttr.Color = clNavy
          CommentAttr.Height = -13
          CommentAttr.Name = 'Courier New'
          CommentAttr.Style = [fsItalic]
          KeywordAttr.Charset = DEFAULT_CHARSET
          KeywordAttr.Color = clWindowText
          KeywordAttr.Height = -13
          KeywordAttr.Name = 'Courier New'
          KeywordAttr.Style = [fsBold]
          StringAttr.Charset = DEFAULT_CHARSET
          StringAttr.Color = clNavy
          StringAttr.Height = -13
          StringAttr.Name = 'Courier New'
          StringAttr.Style = []
          TextAttr.Charset = DEFAULT_CHARSET
          TextAttr.Color = clWindowText
          TextAttr.Height = -13
          TextAttr.Name = 'Courier New'
          TextAttr.Style = []
          Lines.Strings = (
            '')
          ReadOnly = True
          SyntaxType = stPascal
          ShowFooter = True
          ShowGutter = True
          ExplicitLeft = 2
          ExplicitTop = 283
          ExplicitWidth = 638
          ExplicitHeight = 228
        end
      end
    end
    object tbsXML: TTabSheet
      Caption = 'Dados do XML'
      ImageIndex = 15
      object Label76: TLabel
        Left = 14
        Top = 164
        Width = 163
        Height = 14
        Caption = 'Tag que agrupa o xml do relat'#243'rio:'
      end
      object Label77: TLabel
        Left = 14
        Top = 220
        Width = 123
        Height = 14
        Caption = 'Texto do Rodap'#233' do XML:'
      end
      object DBEditFocus19: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 179
        Width = 163
        Height = 22
        DataField = 'REL_TAGREL'
        DataSource = dtsCadRel
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object Panel10: TPanel
        Left = 14
        Top = 8
        Width = 827
        Height = 137
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Panel21: TPanel
          Left = 0
          Top = 0
          Width = 827
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Texto do cabe'#231'alho do XML'
          ParentColor = True
          TabOrder = 0
        end
        object DBMemoFocus1: TDBMemoFocus
          Left = 0
          Top = 16
          Width = 827
          Height = 121
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DataField = 'REL_TAGCAB'
          DataSource = dtsCadRel
          ScrollBars = ssBoth
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object DBEditFocus21: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 235
        Width = 163
        Height = 22
        DataField = 'REL_TAGROD'
        DataSource = dtsCadRel
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object tbsExcel: TTabSheet
      Caption = 'Dados do Excel'
      ImageIndex = 16
      object Label74: TLabel
        Left = 13
        Top = 18
        Width = 57
        Height = 14
        Caption = 'Totaliza'#231#227'o:'
      end
      object cbxTotIni: TComboBoxFocus
        Left = 13
        Top = 32
        Width = 245
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 2
        TabOrder = 0
        Text = 'No final da quebra listando o valor da quebra'
        OnChange = cbxTotIniChange
        Items.Strings = (
          'No in'#237'cio da quebra'
          'No final da quebra'
          'No final da quebra listando o valor da quebra')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object DBCheckBox26: TDBCheckBox
        Left = 13
        Top = 59
        Width = 199
        Height = 15
        Caption = 'Gravar linha a linha'
        DataField = 'REL_GRADIR'
        DataSource = dtsCadRel
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object GroupBox19: TGroupBox
        Left = 13
        Top = 80
        Width = 740
        Height = 73
        Caption = 'T'#237'tulo das Colunas'
        TabOrder = 2
        object Label78: TLabel
          Left = 19
          Top = 21
          Width = 145
          Height = 14
          Caption = 'Fonte dos T'#237'tulos das Colunas'
        end
        object Label80: TLabel
          Left = 555
          Top = 21
          Width = 68
          Height = 14
          Caption = 'Cor do Fundo:'
        end
        object dbeFonTco: TDBEditFocus
          Left = 19
          Top = 36
          Width = 474
          Height = 22
          TabStop = False
          DataField = 'REL_FONTCO'
          DataSource = dtsCadRel
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnFonTco: TBitBtnLocked
          Left = 495
          Top = 36
          Width = 26
          Height = 22
          Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
          Cancel = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
            DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
            5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
            DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
            DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnFonTcoClick
        end
        object btnLimparFonTco: TBitBtnLocked
          Left = 523
          Top = 36
          Width = 26
          Height = 22
          Hint = 'Clique aqui para limpar a fonte'
          Cancel = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000C40E0000C40E00000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A6000020400000206000002080000020A0000020C0000020E000004000000040
            20000040400000406000004080000040A0000040C0000040E000006000000060
            20000060400000606000006080000060A0000060C0000060E000008000000080
            20000080400000806000008080000080A0000080C0000080E00000A0000000A0
            200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
            200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
            200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
            20004000400040006000400080004000A0004000C0004000E000402000004020
            20004020400040206000402080004020A0004020C0004020E000404000004040
            20004040400040406000404080004040A0004040C0004040E000406000004060
            20004060400040606000406080004060A0004060C0004060E000408000004080
            20004080400040806000408080004080A0004080C0004080E00040A0000040A0
            200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
            200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
            200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
            20008000400080006000800080008000A0008000C0008000E000802000008020
            20008020400080206000802080008020A0008020C0008020E000804000008040
            20008040400080406000804080008040A0008040C0008040E000806000008060
            20008060400080606000806080008060A0008060C0008060E000808000008080
            20008080400080806000808080008080A0008080C0008080E00080A0000080A0
            200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
            200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
            200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
            2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
            2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
            2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
            2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
            2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
            2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
            2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
            66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
            56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
            5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
            5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
            F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
            FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
            FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnLimparFonTcoClick
        end
        object dbeFunTco: TcxDBColorComboBox
          Tag = 99
          Left = 555
          Top = 36
          DataBinding.DataField = 'REL_FUNTCO'
          DataBinding.DataSource = dtsCadRel
          Properties.AllowSelectColor = True
          Properties.ClearKey = 46
          Properties.ColorDialogShowFull = True
          Properties.ColorDialogType = cxcdtAdvanced
          Properties.CustomColors = <>
          TabOrder = 3
          Width = 169
        end
      end
    end
    object tbsWhatsApp: TTabSheet
      Caption = 'WhatsApp'
      ImageIndex = 17
      object grbGatilho: TGroupBox
        Left = 0
        Top = 0
        Width = 1007
        Height = 776
        Align = alClient
        Caption = 'Informa'#231#245'es do gatilho'
        TabOrder = 0
        object dbeCAMIDT: TDBMemoFocus
          Left = 2
          Top = 122
          Width = 1003
          Height = 652
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DataField = 'REL_CAMIDT'
          DataSource = dtsCadRel
          ScrollBars = ssBoth
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object Panel40: TPanel
          Left = 2
          Top = 16
          Width = 1003
          Height = 65
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel40'
          ParentColor = True
          ShowCaption = False
          TabOrder = 0
          object Label91: TLabel
            Left = 21
            Top = 15
            Width = 123
            Height = 14
            Caption = 'ID Fila Disparo Whatsapp:'
          end
          object Label92: TLabel
            Left = 21
            Top = 39
            Width = 124
            Height = 14
            Caption = 'ID do Template Whatsapp:'
          end
          object dbeWIDDIS: TDBEditFocus
            Tag = 99
            Left = 147
            Top = 12
            Width = 92
            Height = 22
            DataField = 'REL_WIDDIS'
            DataSource = dtsCadRel
            TabOrder = 0
            OnKeyPress = dbeWIDDISKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeWIDTEM: TDBEditFocus
            Tag = 99
            Left = 147
            Top = 35
            Width = 92
            Height = 22
            DataField = 'REL_WIDTEM'
            DataSource = dtsCadRel
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDescCadFil: TEditFocus
            Left = 241
            Top = 12
            Width = 434
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
        end
        object Panel42: TPanel
          Left = 2
          Top = 81
          Width = 1003
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Informe os campos do Template encapsulados por << >>'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 2
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 712
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 920
    Top = 728
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 912
    Top = 712
  end
  object dtsCadRel: TDataSource
    Left = 728
    Top = 720
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 488
    Top = 672
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16770736
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = 14674687
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14548923
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = 14737632
    end
  end
  object dtsGruPar: TDataSource
    Left = 668
    Top = 708
  end
  object dtsTipBan: TDataSource
    Left = 508
    Top = 716
  end
  object tmrRolagem: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrRolagemTimer
    Left = 804
    Top = 716
  end
  object frxAjudaBeforePost: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45141.605599097220000000
    ReportOptions.LastChange = 45141.605599097220000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 924
    Top = 421
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
      object Rich1: TfrxRichView
        Align = baClient
        Width = 718.110700000000000000
        Height = 1046.929810000000000000
        GapX = 2.000000000000000000
        GapY = 1.000000000000000000
        RichEdit = {
          7B5C727466315C616E73695C616E7369637067313235325C64656666305C6E6F
          7569636F6D7061745C6465666C616E67313034367B5C666F6E7474626C7B5C66
          305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A7B5C636F
          6C6F7274626C203B5C726564305C677265656E305C626C75653235353B7D0D0A
          7B5C2A5C67656E657261746F722052696368656432302031302E302E32303334
          387D5C766965776B696E64345C756331200D0A5C706172645C71635C625C6630
          5C6673323020436F6D706C656D656E746F7320616469636F6E61646F7320616F
          2070617363616C73637269707420706172612061206265666F7265706F737420
          646F20677269645C7061720D0A0D0A5C706172645C7061720D0A31202D204F62
          6A65746F735C7061720D0A5C623020202020205C7061720D0A202020312E3120
          2D205C6366315C62206364734461646F735C6366305C623020202854556E6943
          6C69656E7444617461536574293A20636C69656E7420636F6E74656E646F206F
          73206461646F7320646F2072656C61745C27663372696F2E5C7061720D0A2020
          20202020312E312E31202D204D5C276539746F646F7320646F20636473446164
          6F733A205C7061720D0A2020202020202020312E312E312E31202D2046756E63
          74696F6E205C6366315C62204669656C6442794E616D655C6366305C62302028
          73747243616D706F3A20537472696E67293A20544669656C643B5C7061720D0A
          5C7061720D0A5C622032202D2050726F6365647572657320652046756E637469
          6F6E735C7061720D0A5C7061720D0A5C623020202020322E3031202D2066756E
          6374696F6E206643757272656E7454696D653A20537472696E673B5C7061720D
          0A202020322E3032202D2066756E6374696F6E206643757272656E7444617465
          3A20537472696E673B5C7061720D0A202020322E3033202D2066756E6374696F
          6E206643757272656E744461746554696D653A20537472696E673B5C7061720D
          0A202020322E3034202D2066756E6374696F6E20664E6F773A20544461746554
          696D653B5C7061720D0A202020322E3035202D2066756E6374696F6E20664973
          4E756D62657228436F6E7374207374724E756D6265723A20537472696E67293A
          20426F6F6C65616E3B5C7061720D0A202020322E3036202D2066756E6374696F
          6E2066456D70747953747228737472537472696E67203A20537472696E673B20
          626C6E546972614361726163457370656369616C3A20426F6F6C65616E203D20
          46616C7365293A20426F6F6C65616E3B5C7061720D0A202020322E3037202D20
          66756E6374696F6E20665061644C28737472546578746F3A20537472696E673B
          20696E7454616D616E686F3A20496E74656765723B2073747243617261637465
          723A20537472696E67203D202727202727293A20537472696E673B5C7061720D
          0A202020322E3038202D2066756E6374696F6E20665061645228737472546578
          746F3A20537472696E673B20696E7454616D616E686F3A20496E74656765723B
          2073747243617261637465723A20537472696E67203D202727202727293A2053
          7472696E673B5C7061720D0A202020322E3039202D2066756E6374696F6E2066
          5061644328737472546578746F3A20537472696E673B20696E7454616D616E68
          6F3A20496E74656765723B2073747243617261637465723A20537472696E6720
          3D202727202727293A20537472696E673B5C7061720D0A202020322E3132202D
          2066756E6374696F6E206643616D706F546162656C612873747243616D706F3A
          20537472696E673B20737472546162656C613A20537472696E673B206172724B
          6579732C2061727256616C7565733A2041727261793B20626C6E53656D707265
          4C657242616E636F3A20426F6F6C65616E203D2054727565293A205661726961
          6E743B5C7061720D0A202020322E3133202D2066756E6374696F6E2066436667
          5369732873747243616D4366673A20537472696E673B20737472436F64456D70
          3A20537472696E67203D202727293A2056617269616E743B5C7061720D0A5C70
          61720D0A5C622033202D20566172695C276531766569735C7061720D0A5C7061
          720D0A5C623020202020332E31202D207374724C6F67696E5573756172696F4C
          6F6761646F3A20537472696E673B5C7061720D0A2020202020202020435C2766
          336469676F20646F207573755C27653172696F206C6F6761646F2E5C7061720D
          0A205C7061720D0A202020332E32202D2056535F737472436F64456D703A2053
          7472696E673B5C7061720D0A2020202020202020456D707265736120636F7272
          656E74652E5C7061720D0A5C7061720D0A202020332E33202D2056535F446174
          653A2054446174653B5C7061720D0A20202020202020204461746120636F7272
          656E74652E5C7061720D0A5C7061720D0A202020332E3420202D205C6366315C
          62207374724D656E736167656D41706F734D6172636172546F646F735C636630
          5C6230203A20537472696E673B5C7061720D0A20202020202020205175616E64
          6F20666F7220707265656E63686964612C20756D61206D656E736167656D2073
          65725C276531206D6F73747261646120616F207573755C27653172696F206170
          5C27663373206D617263617220636C69636172206E6F20626F745C2765336F20
          224D617263617220746F646F73222E5C7061720D0A5C62202020205C7061720D
          0A2A205C62305C6920417320696E666F726D615C2765375C276635657320656D
          20617A756C20735C2765336F206173206D6169732072656C6576616E74657320
          70617261206F20636F6E746578746F20646F2076616C6964615C2765375C2765
          336F20646120636F6C756E615C6930202E5C7061720D0A5C667331365C706172
          0D0A7D0D0A00}
      end
    end
  end
end
