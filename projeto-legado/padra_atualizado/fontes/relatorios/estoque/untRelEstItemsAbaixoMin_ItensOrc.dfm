inherited frmRelEstItemsAbaixoMin_ItensOrc: TfrmRelEstItemsAbaixoMin_ItensOrc
  Width = 1243
  Height = 550
  Caption = 'Itens do Or'#231'amento'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1243
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 1237
    Height = 26
    Color = 16770261
    ExplicitTop = 439
    ExplicitWidth = 1237
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1233
      Height = 22
      ExplicitWidth = 1233
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 22
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F7 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 221
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F6 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
      object btnMarcarDesmarcarExclusao: TBitBtnLocked
        Left = 362
        Top = 0
        Width = 214
        Height = 22
        Caption = '[ F11 ] - Marcar todos p/ Exclus'#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000040000000E00000013000000130000
          0014000000140000001500000015000000160000001600000000000000000000
          00000000000000000000000000000000000D8C694DBCCD996EFFCC976CFFCB95
          6AFFC99468FFC99266FFC89163FFC79062FFC68E60FF00000000000000000000
          00000000000000000000000000000000000ECE9D73FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          00000000000000000000000000000000000DD09F76FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          00000000000000000000000000000000000BD1A179FFE1BD9FFFE1BD9EFFE0BC
          9DFFDFBB9BFFDFBB9AFFDFBA99FFDEB997FFDEB896FF00000000000000000000
          00000000000000000000000000000000000AD2A37BFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000003031527000000000000000000000009D4A47DFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000404
          1727131382E70000000000000000000000085556D8FF5150D5FF4C4BD0FF4646
          CDFF4140C9FF3C3CC6FF3736C2FF3231BEFF2E2DBBFF00000000050518271C21
          96EA191994FF15168FFF12128AFF000000075959DBFF6262E2FF5D5DE0FF5959
          DCFF5555D9FF5151D6FF4D4CD3FF4948D0FF4444CEFF00000000201F93E7364B
          D6FF3750E2FF2F46DCFF15168FFF000000065C5CDDFF6565E5FF6160E2FF5D5D
          DFFF5958DCFF5454D9FF5150D6FF4C4BD3FF4847D0FF00000000060619272327
          9EEA1F209FFF1C1C99FF191994FF00000005605FDFFF6868E7FF6464E4FF6060
          E2FF5D5CDFFF5857DCFF5454D9FF4F4FD6FF4C4BD3FF00000000000000000606
          1A271F2094E70000000000000000000000046363E2FF5F5FDFFF5B5ADBFF5656
          D8FF5150D4FF4C4BD1FF4646CDFF4140C9FF3C3CC6FF00000000000000000000
          000006061927000000000000000000000002D9AF8AFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000000000000000000000000000000000000D9B08CFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000000000000000000000000000000000000947860ADD9B08CFFDAAE8AFFD8AE
          88FFD7AC86FFD6AA84FFD5A882FFD5A780FFD4A57EFF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnMarcarDesmarcarExclusaoClick
      end
      object btnMostraEstoque: TBitBtnLocked
        Left = 576
        Top = 0
        Width = 141
        Height = 22
        Caption = 'Estoque das Lojas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0001000000060000000A0000000B0000000B0000000B0000000B0000000B0000
          000C0000000C0000000C0000000B000000070000000200000000000000000000
          000680574CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB279
          68FFB37968FFB27967FFB17967FF7F5749BF0000000700000000000000000000
          0008B57D6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFAF5
          F1FFFBF5F1FFFAF4F1FFFAF4F0FFB27B68FF0000000B00000000000000000000
          0008B67F6DFFFCF8F5FFEFEEEEFFEFEEEEFFEFEFEFFFEFEEEEFFEFEFEFFFEFEF
          EFFFEFEFEFFFEFEFEFFFFBF5F2FFB47D6AFF0000000B00000000000000000000
          0008B8826FFFFCF9F6FFEFEEEEFFC69B8BFFC59A8AFFC59A89FFC49888FFC498
          87FFBA8B7AFFEFEFEFFFFBF7F3FFB67F6DFF0000000A00000000000000000000
          0007BA8473FFFDF9F8FFF0F0EFFFF8EEE9FFF8EFE8FFF8EEE8FFF7EEE8FFF8EE
          E8FFF7EEE8FFF1F0F0FFFCF8F5FFB88170FF0000000A00000000000000000000
          0007BB8776FFFDFBF9FFF3F2F1FFC89F8EFFC89E8DFFC79D8CFFC79C8BFFC69B
          8BFFBC8E7DFFF2F1F1FFFCF9F7FFB98473FF0000000900000000000000000000
          0006BD8A78FFFDFBFAFFF4F4F4FFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFF9F0
          EBFFF8F0EAFFF4F3F2FFFDFAF8FFBB8675FF0000000800000000000000000000
          0006BF8D7BFFFEFCFBFFF7F6F6FFCAA494FFCAA393FFC9A291FFC8A191FFC8A0
          8FFFBF9381FFF5F4F3FFFDFBF9FFBD8978FF0000000800000000000000000000
          0005C1907EFFFEFDFCFFF9F9F8FFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2
          EEFFF9F1EEFFF7F6F4FFFDFBFAFFBF8D7BFF0000000700000000000000000000
          0005C39381FFFEFDFDFFFCFBFAFFCEAA9AFFCEA998FFCDA797FFCCA595FFCBA5
          94FFC19786FFF8F8F6FFFEFCFBFFC18F7EFF0000000700000000000000000000
          0004C59684FFFEFEFEFFFDFBFBFFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4
          F1FFFAF4F0FFFAF8F7FFFEFDFCFFC39381FF0000000600000000000000000000
          0004C69887FFFFFEFEFFFEFDFCFFCEAA9AFFCEA998FFCDA797FFCCA595FFCBA5
          94FFC19786FFFBFAF7FFFEFDFDFFC59684FF0000000600000000000000000000
          0003C99B8AFFFFFEFEFFFEFDFCFFFEFCFCFFFDFCFBFFFDFCFAFFFDFBFAFFFCFA
          F9FFFCFAF8FFFCF9F8FFFFFEFEFFC79887FF0000000500000000000000000000
          0003CA9E8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFC99B8AFF0000000400000000000000000000
          00029B7F74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA9
          99FFCFA899FFCEA899FFCFA898FF997B71C00000000300000000}
        TabOrder = 4
        OnClick = btnMostraEstoqueClick
      end
      object btnSimilares: TBitBtnLocked
        Left = 717
        Top = 0
        Width = 141
        Height = 22
        Caption = 'Similares'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000E0000000F0000000F00000010000000100000001000000010000000110000
          0011000000110000001100000011000000100000000B000000037B4F42C0AC6E
          5CFFAC6E5BFFAB6E5BFFAB6E5BFFAB6D5AFFAA6D5AFFAA6D5AFFAA6C59FFAB6C
          59FFAA6C59FFAA6C59FFAA6C59FFAA6C59FF7A4D3FC30000000AAD715FFFFCFB
          F9FFFAF7F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5F3FFFAF5F2FFFAF5F2FFF9F5
          F2FFF9F5F2FFF9F5F1FFF9F4F1FFF9F4F0FFAB6C5AFF0000000FAF7462FFFDFC
          FAFFF7F0EAFFF7EFEAFFF6F0EAFFF7F0EAFFF7F0EAFFF6F0EAFFFAF7F4FFFBF7
          F4FFFBF7F4FFF8F3EFFFF6EFEAFFFAF5F2FFAC6F5CFF00000010B17865FFFEFD
          FCFFF7F1EBFFF8F1EBFFF8F1ECFFF8F0EBFFF7F0EBFFF7F1EBFFB45F28FFB35E
          27FFB25D26FFD4A587FFF6F0EAFFFBF7F3FFAD725FFF0000000FB47B68FFFEFD
          FCFFF9F2EDFFF8F2EDFFF8F2EDFFF8F2ECFFF8F2EDFFF8F2ECFFB6632DFFFBF8
          F5FFE6CBBAFFB76631FFF7F1ECFFFBF8F5FFAF7562FF0000000EB77F6CFFFEFE
          FDFFF9F3EEFFF9F3EFFFF8F3EEFFF9F3EFFFF9F3EEFFF8F2EEFFB8662FFFB866
          2FFFB7642EFFD8AB8EFFF9F2EDFFFCF9F7FFB27866FF0000000DB98371FFFEFE
          FEFFFAF4F0FFFAF4F0FFFAF4F1FFFCF9F7FFFAF4F1FFF9F3F0FFBB6B33FFFCF9
          F7FFE8CFBDFFBC6D39FFF9F3F0FFFCFAF8FFB47C69FF0000000CBC8775FFFFFE
          FEFFFAF5F2FFFAF5F2FFEDDBD1FFA95926FFECDACFFFFAF4F1FFBC6C36FFBC6C
          36FFBB6C36FFDAAD8FFFFAF4F1FFFDFBFAFFB77F6DFF0000000BBE8B79FFFFFF
          FEFFFBF6F3FFFBF6F3FFCC9B7DFFC0845FFFCB997CFFFBF6F3FFFAF5F3FFFBF6
          F2FFFBF5F3FFFAF5F3FFFAF5F3FFFDFCFBFFBA8371FF0000000AC18E7CFFFFFF
          FFFFFBF7F4FFF7EEE8FFB26637FFEFDFD5FFB16335FFF6EDE8FFFBF7F4FFFBF7
          F4FFFBF6F3FFFBF6F4FFFBF6F3FFFEFCFBFFBD8775FF0000000AC39281FFFFFF
          FFFFFBF8F5FFDBB59EFFCE9D7DFFFCF8F5FFCC997AFFD9B39CFFFBF8F5FFFCF8
          F5FFFBF7F4FFFBF7F4FFFBF7F4FFFEFDFCFFBF8B79FF00000009C59584FFFFFF
          FFFFFBF6F5FFB97243FFEEDDD2FFFCF9F6FFEEDCD1FFB76E40FFFBF6F4FFFCF8
          F6FFFBF8F6FFFCF8F6FFFBF8F6FFFEFDFDFFC18E7DFF00000008C89887FFFFFF
          FFFFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFBF9
          F7FFFCF9F6FFFCF9F7FFFBF9F7FFFEFEFEFFC49281FF00000007C99A8AFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC59684FF000000069D7F74BFD3AB
          9CFFD2AB9CFFD2AA9BFFD2A99AFFD2A99AFFD1A798FFD0A798FFD0A697FFCFA6
          96FFCFA496FFCEA494FFCEA494FFCDA392FF98786CC000000004}
        TabOrder = 5
        OnClick = btnSimilaresClick
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 858
        Top = 0
        Width = 141
        Height = 22
        Caption = 'Configura colunas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
          4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
          ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
          6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
          9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
          71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
          64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
          75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
          B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
          78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
          BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
          7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
          BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
          7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
          C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
          84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
          C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
          87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
          D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
          8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
          97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
          8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
          AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
          91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
          F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
          95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
          6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
          93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
        TabOrder = 6
        OnClick = BitBtnLocked1Click
      end
      object BitBtnLocked2: TBitBtnLocked
        Left = 999
        Top = 0
        Width = 141
        Height = 22
        Caption = 'Ajustar Colunas'
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
        OnClick = BitBtnLocked2Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1156
      Top = 1
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
      ExplicitLeft = 1156
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 1237
    ExplicitTop = 505
    ExplicitWidth = 1237
    inherited pnlNomeForm: TPanel
      Left = 1066
      ExplicitLeft = 1066
    end
    inherited pnlInfo: TPanel
      Width = 1066
      ExplicitWidth = 1066
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 1237
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    Visible = False
    object lblEmpresa: TLabel
      Left = 8
      Top = 6
      Width = 62
      Height = 14
      Caption = 'lblEmpresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 465
    Width = 1237
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblTitTotPes: TLabel
      Left = 541
      Top = 3
      Width = 151
      Height = 14
      Alignment = taRightJustify
      Caption = 'Litro/Kilo Total Selecionado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTitTotNec: TLabel
      Left = 507
      Top = 23
      Width = 185
      Height = 14
      Alignment = taRightJustify
      Caption = 'Neces. Compra Total Selecionada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotNec: TLabel
      Left = 696
      Top = 23
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotPes: TLabel
      Left = 696
      Top = 3
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTitPesoBruto: TLabel
      Left = 916
      Top = 3
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotPesoBruto: TLabel
      Left = 984
      Top = 3
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlTail: TPanel [4]
    Left = 0
    Top = 376
    Width = 1237
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    Visible = False
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 1237
      Height = 22
      Align = alClient
      Alignment = taCenter
      Caption = 'Aguarde, gravando...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 146
      ExplicitHeight = 18
    end
    object prbProgesso: TcxProgressBar
      Left = 0
      Top = 22
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 23
      Width = 1237
    end
  end
  object cxGrid: TcxGrid [5]
    Left = 0
    Top = 27
    Width = 1237
    Height = 253
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridView: TcxGridDBTableView
      OnKeyDown = cxGridViewKeyDown
      OnKeyPress = cxGridViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridViewCustomDrawCell
      OnEditKeyPress = cxGridViewEditKeyPress
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftNull]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
      OptionsView.GroupByBox = False
      object cxColEXCLUIR: TcxGridDBColumn
        Caption = 'Excluir'
        DataBinding.FieldName = 'EXCLUIR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderGlyphAlignmentHorz = taCenter
        Options.Filtering = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
      end
      object cxColCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 50
      end
      object cxColDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 272
      end
      object cxColSIGUNI: TcxGridDBColumn
        Caption = 'Un.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Width = 22
      end
      object cxColNIVGIR: TcxGridDBColumn
        Caption = 'N'#237'vel de Giro'
        DataBinding.FieldName = 'NIVGIR'
        Width = 70
      end
      object cxColLOCFIS: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica CD'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Width = 100
      end
      object cxColLOCSUP: TcxGridDBColumn
        Caption = 'Super Estoque CD'
        DataBinding.FieldName = 'LOCSUP'
        Options.Editing = False
        Width = 100
      end
      object cxColFISEMP: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica Loja'
        DataBinding.FieldName = 'FISEMP'
        Options.Editing = False
        Width = 100
      end
      object cxColSUPEMP: TcxGridDBColumn
        Caption = 'Super Estoque Loja'
        DataBinding.FieldName = 'SUPEMP'
        Options.Editing = False
        Width = 100
      end
      object cxcolCODFAB: TcxGridDBColumn
        Caption = 'C'#243'digo F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 100
      end
      object cxColMEDIA_CD: TcxGridDBColumn
        Caption = 'M'#233'dia Mensal Vendas CD'
        DataBinding.FieldName = 'MEDIA_CD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 129
      end
      object cxGridSALFIS: TcxGridDBColumn
        Caption = 'Saldo F'#237'sico CD'
        DataBinding.FieldName = 'SALFIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 87
      end
      object cxColSALDCD: TcxGridDBColumn
        Caption = 'Saldo CD transf. (*)'
        DataBinding.FieldName = 'SALDCD'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 102
      end
      object cxColREALCD: TcxGridDBColumn
        Caption = 'Saldo Dispon. CD'
        DataBinding.FieldName = 'REALCD'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 98
      end
      object cxcolESTMINCD: TcxGridDBColumn
        Caption = 'Est. M'#237'nimo CD'
        DataBinding.FieldName = 'CD_ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 81
      end
      object cxColSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 74
      end
      object cxColSALMLG: TcxGridDBColumn
        Caption = 'Saldo GR/ML'
        DataBinding.FieldName = 'SALMLG'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 93
      end
      object cxColESTMIN: TcxGridDBColumn
        Caption = 'Est. M'#237'nimo'
        DataBinding.FieldName = 'ESTMIN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 75
      end
      object cxColESTMAX: TcxGridDBColumn
        Caption = 'Est. M'#225'ximo'
        DataBinding.FieldName = 'ESTMAX'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 75
      end
      object cxColGIRITE: TcxGridDBColumn
        Caption = 'Qtd Giro Est. Venda'
        DataBinding.FieldName = 'GIRITE'
        Visible = False
        Width = 103
      end
      object cxColPESUNT: TcxGridDBColumn
        Caption = 'Lt/Kg. Unit.'
        DataBinding.FieldName = 'PESUNT'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object cxColEMBALA: TcxGridDBColumn
        Caption = 'Embalag.'
        DataBinding.FieldName = 'EMBALA'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 58
      end
      object cxColMLTCOM: TcxGridDBColumn
        Caption = 'Multiplo Compra'
        DataBinding.FieldName = 'MLTCOM'
        HeaderAlignmentHorz = taCenter
        Width = 94
      end
      object cxColQTDPEN: TcxGridDBColumn
        Caption = 'Qtd PD Compra Pend.'
        DataBinding.FieldName = 'QTDPEN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 111
      end
      object cxcolQTDPEN_GAR: TcxGridDBColumn
        Caption = 'PD Compra Gar.'
        DataBinding.FieldName = 'QTDPEN_GAR'
        Options.Editing = False
        Width = 83
      end
      object cxColCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 60
      end
      object cxColNECORI: TcxGridDBColumn
        Caption = 'Nec.Compra'
        DataBinding.FieldName = 'NECORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 65
      end
      object cxColNECCOM: TcxGridDBColumn
        Caption = 'Nec.Compra'
        DataBinding.FieldName = 'NECCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.OnValidate = cxColNECCOMPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Width = 65
      end
      object cxColPONEXP: TcxGridDBColumn
        Caption = 'Ponto Exposi'#231#227'o'
        DataBinding.FieldName = 'ITE_PONEXP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 65
      end
      object cxColNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 100
      end
      object cxColDESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Options.Editing = False
        Width = 150
      end
      object cxColFORREF: TcxGridDBColumn
        Caption = 'Fornecedor / Refer'#234'ncia'
        DataBinding.FieldName = 'FORREF'
        Options.Editing = False
        Width = 400
      end
      object cxColQTDVEN: TcxGridDBColumn
        Caption = 'Qtde. Vendida'
        DataBinding.FieldName = 'QTDVEN'
        Options.Editing = False
        Width = 73
      end
      object cxColENTFUT: TcxGridDBColumn
        Caption = 'Ent. Fut. Pend.'
        DataBinding.FieldName = 'ENTFUT'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 87
      end
      object cxColTEPEND: TcxGridDBColumn
        Caption = 'Trans. Para Emp. Dest'
        DataBinding.FieldName = 'TEPEND'
        Options.Editing = False
        Width = 120
      end
      object cxColQSAI01: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI01'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI02: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI02'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI03: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI03'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI04: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI04'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI05: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI05'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI06: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI06'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI07: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI07'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI08: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI08'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI09: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI09'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI10: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI10'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI11: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI11'
        Visible = False
        Options.Editing = False
      end
      object cxColQSAI12: TcxGridDBColumn
        DataBinding.FieldName = 'QSAI12'
        Visible = False
        Options.Editing = False
      end
      object cxColCodGru: TcxGridDBColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'GRUDES'
        Visible = False
      end
      object cxColCodFor: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Visible = False
      end
      object cxColLinDes: TcxGridDBColumn
        Caption = 'Linha'
        DataBinding.FieldName = 'LINDES'
      end
      object cxColTEMLOT: TcxGridDBColumn
        DataBinding.FieldName = 'TEMLOT'
        Visible = False
      end
      object cxColMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Options.Editing = False
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridView
    end
  end
  object pnlAplicacao: TPanel [6]
    Left = 0
    Top = 280
    Width = 1237
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 1237
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 1237
      Height = 76
      Align = alBottom
      BorderStyle = bsNone
      DataField = 'APLICA'
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object Panel2: TPanel [7]
    Left = 0
    Top = 420
    Width = 1237
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 2
    ParentColor = True
    TabOrder = 7
    object Label1: TLabel
      Left = 0
      Top = 2
      Width = 894
      Height = 17
      Align = alLeft
      Caption = 
        '[ F5 ] - Exclui selecionados para exclus'#227'o [ F9 ] - Marca/Desmar' +
        'ca Item individualmente   ENTER - Altera a necessidade de compra' +
        '   [F8] Apagar sem saldo CD              '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 14
    end
    object lblQtdReg: TLabel
      Left = 894
      Top = 2
      Width = 46
      Height = 17
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Qtd.Reg:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 14
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 200
  end
  object qryConsulta: TUniQuery
    Left = 72
    Top = 96
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 80
    Top = 152
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspConsulta'
    AfterOpen = cdsConsultaAfterOpen
    BeforeEdit = cdsConsultaBeforeEdit
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    AfterCancel = cdsConsultaAfterCancel
    AfterScroll = cdsConsultaAfterScroll
    Left = 168
    Top = 96
    object cdsConsultaSUM_PESTOT: TAggregateField
      FieldName = 'SUM_PESTOT'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PESTOT)'
    end
    object cdsConsultaSUM_NECTOT: TAggregateField
      FieldName = 'SUM_NECTOT'
      Active = True
      DisplayName = ''
      Expression = 'SUM(NECTOT)'
    end
    object cdsConsultaSUM_PESTIT: TAggregateField
      FieldName = 'SUM_PESTIT'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PESTIT)'
    end
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 272
    Top = 104
  end
end
