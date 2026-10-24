object frmErroRede: TfrmErroRede
  Left = 312
  Top = 277
  BorderStyle = bsNone
  Caption = 'frmErroRede'
  ClientHeight = 617
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 617
    Align = alClient
    BevelInner = bvRaised
    BorderStyle = bsSingle
    TabOrder = 0
    object Splitter1: TSplitter
      AlignWithMargins = True
      Left = 7
      Top = 302
      Width = 611
      Height = 3
      Cursor = crVSplit
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Beveled = True
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 235
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 313
      Width = 615
      Height = 13
      Align = alTop
      Caption = 'Detalhes t'#233'cnicos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 103
    end
    object btnCopy: TSpeedButton
      Left = 597
      Top = 308
      Width = 23
      Height = 22
      Flat = True
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
      OnClick = btnCopyClick
    end
    object memStack: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 329
      Width = 615
      Height = 245
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
    object Panel3: TPanel
      Left = 2
      Top = 577
      Width = 621
      Height = 34
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 521
        Top = 3
        Width = 97
        Height = 28
        Align = alRight
        Caption = '&Fechar'
        TabOrder = 0
        OnClick = btnFecharClick
      end
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 615
      Height = 289
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Panel2: TPanel
        Left = 50
        Top = 6
        Width = 551
        Height = 193
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 541
          Height = 16
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Conex'#227'o com o servidor foi interrompida.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 266
        end
        object lblTentativas: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 31
          Width = 541
          Height = 26
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 
            'O AUTCOM perdeu o contato com o servidor de rede durante a execu' +
            #231#227'o e n'#227'o conseguiu continuar. Isso pode acontecer por queda mom' +
            'ent'#226'nea da rede, instabilidade no cabo ou no switch, ou sobrecar' +
            'ga no servidor.'
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 538
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 90
          Width = 541
          Height = 26
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 
            'N'#227'o '#233' poss'#237'vel continuar a sess'#227'o atual - reabrir o AUTCOM ap'#243's ' +
            'verificar a rede resolver'#225' o problema na maioria dos casos.'
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 510
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 149
          Width = 541
          Height = 39
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 
            'Opera'#231#245'es j'#225' confirmadas anteriormente foram gravadas normalment' +
            'e. Apenas atividades que estavam em andamento no momento da qued' +
            'a podem n'#227'o ter sido salvas. Ao reabrir, verifique o '#250'ltimo lan'#231 +
            'amento realizado.'
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 520
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 67
          Width = 541
          Height = 13
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'O programa precisa ser fechado.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 183
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 126
          Width = 541
          Height = 13
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Seus dados:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 67
        end
      end
      object memErro: TMemo
        Left = 55
        Top = 205
        Width = 370
        Height = 81
        BevelOuter = bvNone
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '1. Anote o que estava fazendo antes do erro.'
          '2. Clique em Fechar para encerrar o programa.'
          '3. Verifique o cabo de rede ou fale com o suporte.'
          '4. Reabra o AUTCOM e confira o '#250'ltimo lan'#231'amento.'
          '5. Se o erro se repetir no mesmo dia, avise o TI.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object cxImage1: TcxImage
        Left = 8
        Top = 11
        AutoSize = True
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000020
          000000200806000000737A7AF40000001974455874536F667477617265004164
          6F626520496D616765526561647971C9653C0000001B744558745469746C6500
          5761726E696E673B4E6F74696669636174696F6E3BB6E779860000049E494441
          54785EED94794CD37718C6B7653AC45DC9FE59B66CF18F89324427E31045C298
          3B5C9685C503C7C47901634303988906141430A3188E5105B103741C010B4839
          46E528542BB08A481139047518CA515A282D679167DFF797C589A2CE49354B6C
          F2499E3CEFFBE57979DFB4CF0178AA3CFBFC7F91C539BD517BCC793F6377E961
          07D3279DFF82FCA8F3F1F63307D1F6FB3E30CD27EF49853F5FC27358511BEF3C
          61D05D8541D70AD2E451CDE8E9D1DE8B4D6BE29C9A6ECAE230AE9673749C8DC1
          1F7CA766BECF92B946FFEFCF45AD8CB822DC09C38002633D950437C415A10F58
          2DCAA85B1087D9DB55473B1A467A6A31D625C178AF8C60BA02C34A19586DA238
          D4DED12843446EB5303DCB7368BC2189C1586F3546FB5B202911119C1E65435C
          2FE3E15CE4CA56BEF7E297677CF592F0E5118A746F18FA9B31DA2D43B22001CB
          9C3610A4396F4C5909459A37586FEC8C6EA120C8D64E7A68B961B8A71EC31D45
          185156209E1F035BC7F51C094762396FF88608FA0E0958EF447EA0CD47333244
          88ABD99CB290658D6D67781853D561A82D13237F1623EFD409583BAC25489347
          35364401AE1685A1FC807D1B7FFBA2571E7BF5C58136E11793B6C1A0BB097D4B
          06230D43EDB9904BF360B5FC6B82347954E37A86D9301793B7431C64F3783F50
          423F2BEB9240DBF1A1CE3AB6DE22E81A5338F44D69E86C966289DD570469F2FE
          A9B7A4437F5D0CF6F656B6BFD5C7FFE914BBBE986752F4D3878AE6BC83185337
          41DB701C5A45E26D46BBE5B05AF625417A4A8D7A752D9968CEDD8FE2DDD6D762
          DDCD5F7DE4D5E7F92E0DAF3EB2915BFDE0E51468EB8E4C61E466253EFD7C0D41
          9ABCA9D41F83BE35073547DD21F2B38A7FA4536478595A17FA2E1D1F6815B375
          0AA1A90AC7C085280CD4C6DE467FF53442020308D277D6A897DE3042A1A91380
          FDADC92CEFC5ABFED5297C57BD6B72FAC7258A4B277762A4B31AAA727FA84A7D
          197EE89304402DDD078D2C14DA4B020CB517328AA0AD17904735EAE17AB93765
          FED09C0F47FD096F887C3EB811ED6AF6DA43579FE9B92854CA7361E1552C280C
          BDE21FEE415D1984868A9370FBD6036E6E1EA4C99BB69706E997C7401AE98253
          5E96890F3C45CA26F3A5D99E96E3AADA340CD6A7A0A7D0635A066AE3E1E3E589
          F7AD5613A4C9BB6FBFAAD41F7D3571C8F1B49C4CDD6CF1D9B4A7D8E5FCCEECCC
          2D1675F2444F76D30274177D8F2ED177D3A23E1F81D0BD3B306F813DC7C13D3B
          C8A3DAF4E46F814AB21717051E38B57551C76197F75EBF67F5A91B1786941F58
          CDC20BD157190C65AEDB7DE9CADF064D431612780104A7BB0AB63DF88D6833D4
          E70EA12CD819E9EEE682BB4FF16286BB797B47F92F186C4845DFD970287336A0
          53B8EEFE64BBA2B76C0F419ABC87D29DEF816BA2BDA02C9639EBCE016627BB9A
          955445AD43BFFC283435B150571D865AF63387A63A8AF307EA92A055FC86C1C6
          2CE89A73A16BCAC1E01521B49733A0AD3F89FE0BF1E0DECA78505504A3B73400
          3D625F74177841797A1394D96E90867D82A4F566C52CF3A53B0798B573C55B8E
          BFAE9DDF94FECD8249068CC4A460CDFC86EDB66FDADCBD01BAC75CC6DB8C850C
          0B23B1F0EF0CD3E9BE8E64CC66CC312226943125FCD907C053E52F6A6A3577F3
          F307D50000000049454E44AE426082}
        Style.BorderStyle = ebsNone
        Style.Edges = [bLeft, bTop, bRight, bBottom]
        TabOrder = 2
        Transparent = True
      end
    end
  end
end
