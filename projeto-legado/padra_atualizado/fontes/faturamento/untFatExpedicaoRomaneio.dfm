inherited frmFatExpedicaoRomaneio: TfrmFatExpedicaoRomaneio
  Left = 208
  Top = 228
  Width = 846
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = 'Expedi'#231#227'o - Itens'
  Position = poScreenCenter
  ExplicitWidth = 846
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 399
    Width = 840
    Height = 56
    ExplicitTop = 399
    ExplicitWidth = 840
    ExplicitHeight = 56
    inherited FlwBotoes: TFlowPanel
      Width = 836
      Height = 52
      ExplicitWidth = 836
      ExplicitHeight = 52
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F10] Confirmar Expedi'#231#227'o'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnFatura: TBitBtnLocked
        Left = 165
        Top = 0
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F11] Realizar Faturamento'
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
        OnClick = btnFaturaClick
      end
      object btnDigVol: TBitBtnLocked
        Left = 330
        Top = 0
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F12] Digitar Volumes'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FEFEFEFEFEFE
          FEFEFEFEFEFEFFFFFFFFFFFFFFFFFEF0E8E3E2D8D3FAF4F1FFFFFFFFFFFFFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFDEFE3DC7F94A532
          7AA42984B5487999C2C0C1FBF4F0FFFFFFFFFFFFFEFEFEFEFEFEFEFEFEFFFFFF
          FFFFFDEFE3DC7E94A52673A0459FC954ABD06CB8DD54ADD32882B2497A9AC3C0
          C1FBF4F0FFFFFFFEFEFEFFFFFFFFFEFC8099A925729F419BC655A9D151A3CB4C
          9EC664B1D74DA0C753A6CD52AAD22681B2467898D0D4D7FFFFFFFFFFFFFFFEF9
          1971A452A7CF4E9FC74C9DC64D9EC6499AC364B1D74A9CC44C9DC64C9DC64FA1
          CA4BA1CB749CB6FFFFFFFFFFFFFFFEF93682AF479BC5499AC3499AC3499AC445
          97C164AED64798C2499AC4499AC34698C25CA8D0799EB7FFFFFFFFFFFFFFFDF8
          4389B14092C24695C14697C44795C14090BD63AED7418FBB4797C44695C34192
          BF68ACD1779EB7FFFFFFFFFFFFFFFCF85390B73B90BF4592BF3C87B02B6F9A38
          7EA764B4DE2D6A903177A2428EB83E8FBF74B1D4759DB6FFFFFFFFFFFFFFFFFB
          689DBF2F7DAB2B719C2E7AAB4B9AC71B537A5EA3C636759B3D8FBF2A71A02871
          9C85B7D5759FB9FFFFFFFFFFFFF2E3D931739F2A77A84391C14195C25FB1D647
          84A52A739D8AC8E24099C54496C33685B74582AB6E91A7FFFCF7FFFFFF26719F
          2E85BA3C90C0479EC888C6E066A0C02C6C9C1F5C914F88B082BBD46EB8D83E95
          C33187BA3A89BB97B3C6FFFFFFA2BECFBEDDED7AB5D26799BB1C609528689C2F
          6FA13070A22B6B9E1E60973E79A476AAC8A6D3E982ACC5FFFFFFFFFFFFE8DDD8
          0B649895B5CE568DB72770A62E75A83278AA3378AB3077AA2972A7377AAC7BA4
          C55D95BA6790A8FFFFFDFFFFFE4588AE6EBBDD308DBF5BA0C77FAFCE659EC33F
          87B7307DB14D8EBB79AACB6FA8CB4092BF3B98C767B3D4B0C0CCFFFFFFBCD0DD
          86B0CA5597BB73B4D4328CBD4593C3488AB47CABCA61A0C72480B656A4CD64A6
          C9689EBD9BB9CEF2F6F8FEFEFEFFFFFFFFFFFFFFFFFFA9C2D4A9C5D670A1BFE6
          EBEFFFFFFF8FB3C885B0C9AFC6D6E8ECF0FFFFFFFFFFFFFFFFFF}
        TabOrder = 2
        OnClick = btnDigVolClick
      end
      object btnReimpSep: TBitBtnLocked
        Left = 495
        Top = 0
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F5] Reimprimir Separa'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00020000000A0000000F00000011000000110000001200000012000000130000
          00130000001300000014000000130000000D0000000300000000000000008059
          4ABAB37C68FFB37B67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB177
          65FFB17763FFB07664FFB07664FF7E5548C50000000C0000000000000000B67F
          6BFFFDFBFAFFFBF7F4FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFF8F0EBFFF9F0EAFFB17866FF000000120000000000000000B681
          6FFFFDFBFBFFC4907BFFC38E7AFFC28E79FFC28E78FFC18C78FFF6ECE5FF137C
          D4FF116BCBFF0E5FC4FFF9F1ECFFB37A68FF000000130000000000000000B984
          72FFFEFCFBFFF1E6DEFFF1E5DDFFF0E4DDFFF0E4DDFFF1E4DCFFF7EEE7FF168E
          E0FF137FD8FF1171D0FFFAF2EEFFB57D6BFF000000120000000000000000BC87
          75FFFEFDFCFFC69580FFC5947FFFC5937EFFC4907DFFC5907CFFF8EEE9FF19A1
          EAFF1794E1FF1485DAFFFAF4EFFFB7816EFF000000110000000000000000BE8B
          7AFFFEFDFCFFF3E8E2FFF2E7E1FFF2E7E1FFF2E6DFFFF2E6DEFFF8F0EAFFF8F0
          E9FFF8EFE9FFF8EFE8FFFAF5F1FFBA8571FF000000100000000000000000C190
          7FFFFEFEFDFFC99A85FFC89984FFC89883FFC79782FFC79682FFC69381FFC694
          80FFC5937EFFC5917EFFFBF6F3FFBB8975FF0000000F0000000000000000C494
          82FFFEFEFDFFF4EBE5FFF4EAE5FFF4EAE4FFF4E9E4FFF3E8E3FFF3E8E3FFF2E8
          E1FFF2E7E1FFF2E6DFFFFCF7F4FFBE8B79FF0000000F0000000000000000C697
          87FFFEFEFEFFCD9F8BFFCC9F8AFFCB9C8AFFCA9D89FFCA9B86FFC99B87FFC899
          84FFC89884FFC89783FFFDF9F7FFC18E7DFF0000000E0000000000000000C99B
          8AFFFFFEFEFFF4ECE7FFF4EBE7FFF4EBE7FFF5EBE7FFF5EBE7FFF5E9E6FFF4EA
          E5FFF4EAE4FFF3EAE4FFFDFAF8FFC39382FF0000000D0000000000000000CBA0
          8DFFFFFEFEFFCFA48FFFCEA18FFFCEA18EFFCDA08DFFCDA18CFFCDA08BFFCC9E
          8AFFCB9E8AFFCB9D89FFFDFBF9FFC69786FF0000000C0000000000000000CDA1
          91FFFFFFFEFFF5EFEAFFF6EEEAFFF6EEEAFFF5EDEAFFF5EDE9FFF5ECE8FFF4EC
          E8FFF4ECE7FFF5ECE7FFFDFCFAFFC89B8AFF0000000B0000000000000000CFA4
          93FFFFFFFFFFD1A693FFD0A792FFD0A692FFD0A592FFCFA491FFCFA490FFCFA4
          8FFFCFA28FFFCEA28DFFFEFCFCFFCB9D8DFF0000000B0000000000000000D1A7
          96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFFEFEFDFFCDA191FF0000000900000000000000009C7D
          71BED2A898FFD2A898FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A6
          95FFD0A595FFCFA595FFCFA494FF98796EC20000000600000000}
        TabOrder = 3
        OnClick = btnReimpSepClick
      end
      object btnQuantidade: TBitBtnLocked
        Left = 660
        Top = 0
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F6] Quantidade'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          CCCCCC6060400000FF0000FF0000C000007C606050CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CCCCCC6060400000FF0000FF0000C000
          007C606050CCCCCCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC5A5A3A0000FF0000FF0000CC000086545444CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C69A9A9A2626068B8B6B5E5E461A
          1A0ADEDEDEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC7E7E7EC5C5C5FFFFFFF9F9F9282828DADADAC0C0C0CCBCBCC6BEBEC0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6828282BBBBBBFFFFFFFFFFFFFFFFFFB6
          B6B6404040D8C8C83CEBEB94CCCCCCBCBCC0C0C0C0C0C0C0C0C0C0C0C0CACACA
          4E4E4EFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2A2A2ADAD2D2A0C8C81CFFFFA0C8
          C8D8B8B8C0C0C0C0C0C0C0C0C0D4D4D45A5A5AFFFFFFDBDBDBFFFFFFFFFFFFFF
          FFFF5454549A8A8A4CEBEB86EDED00FFFF18F7F7E4B4B4C0C0C0CCCCCC303030
          FFFFFFFFFFFF787878FFFFFFFFFFFFFFFFFFCECECE484040A6D6D674F3F346FF
          FF00FFFF18F7F7D2CACAD4D4D48080807070704C4C4CF5F5F5FFFFFFFFFFFFFF
          FFFFC4C4C45444445AF1F164DBDB7CD3D300FFFF00FFFFDB0C0C4848484A4A4A
          949494787878CBCBCBFFFFFFC3C3C3383838D8D8D854444460EFEF22F1F100FF
          FF00FFFF00FFFFAC9C9CCCCCCCCCCCCCCECECE808080181818D0D0D078787824
          2424DCDCDC4E4646A6D6D680EFEF4CFFFF00FFFFA8C8C8CAC2C2C0C0C0C0C0C0
          C8C8C8808080282828D8D8D8808080282828E8E8E848383858EFEF32FFFF0EF5
          F5A2CACACCBCBCC0C0C0C0C0C0C0C0C0C8C8C88282822C2C2CD8D8D888888832
          3232404040DED6D69ACACA5EFDFDDCB4B4C6BEBEC0C0C0C0C0C0C0C0C0C0C0C0
          CACACA646464000000F0F0F0161616383838DADADACCBCBC36EDEDD6B6B6C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CACACAE0E0E03C3C3CDCDCDCCE
          CECEC0C0C0C0C0C0CCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        TabOrder = 4
        OnClick = btnQuantidadeClick
      end
      object btnExpAut: TBitBtnLocked
        Left = 0
        Top = 25
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F7] Expedi'#231#227'o "Autom'#225'tica"'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 5
        OnClick = btnExpAutClick
      end
      object btnRelInc: TBitBtnLocked
        Left = 165
        Top = 25
        Width = 165
        Height = 25
        Anchors = []
        Caption = '[F8] Rel. Inconsist'#234'ncias'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00020000000A0000000F00000011000000110000001200000012000000130000
          00130000001300000014000000130000000D0000000300000000000000008059
          4ABAB37C68FFB37B67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB177
          65FFB17763FFB07664FFB07664FF7E5548C50000000C0000000000000000B67F
          6BFFFDFBFAFFFBF7F4FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFF8F0EBFFF9F0EAFFB17866FF000000120000000000000000B681
          6FFFFDFBFBFFC38E79FFC28D79FFC28D78FFC18C77FFC18B76FFC08A76FFC08A
          75FFBF8A74FFC08874FFF9F1ECFFB37A68FF000000130000000000000000B984
          72FFFEFCFBFFF1E6DEFFF1E5DDFFF0E4DDFFF0E4DDFFF1E4DCFFF0E4DCFFF0E2
          DBFFF0E2DAFFF0E2DAFFFAF2EEFFB57D6BFF000000120000000000000000BC87
          75FFFEFDFCFFC5947FFFC5937EFFC4907DFFC38F7CFFC4907BFFC48F7BFFC38F
          7AFFC28E78FFC28D78FFFAF4EFFFB7816EFF000000110000000000000000BE8B
          7AFFFEFDFCFFF3E8E2FFF2E7E1FFF2E7E1FFF2E6DFFFF2E6DEFFF1E6DEFFF1E6
          DEFFF1E5DEFFF1E5DDFFFAF5F1FFBA8571FF000000100000000000000000C190
          7FFFFEFEFDFFC99884FFC89884FFC79782FFC79682FFC79681FFC69480FFC594
          7FFFC5917EFFC6927DFFFBF6F3FFBB8975FF0000000F0000000000000000C494
          82FFFEFEFDFFF4EBE5FFF4EAE5FFF4EAE4FFF4E9E4FFF3E8E3FFF3E8E3FFF2E8
          E1FFF2E7E1FFF2E6DFFFFCF7F4FFBE8B79FF0000000F0000000000000000C697
          87FFFEFEFEFFCC9F8AFFCC9F8AFFCB9E89FFCB9C87FFCA9C88FFC99A85FFC999
          85FFC99884FFC89883FFFDF9F7FFC18E7DFF0000000E0000000000000000C99B
          8AFFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFF5EBE7FFF5E9E6FFF4EA
          E5FFF4EAE4FFF3EAE4FFFDFAF8FFC39382FF0000000D0000000000000000CBA0
          8DFFFFFEFEFF137CD4FF116BCBFF0E5FC4FFFCF7F5FFCEA18DFFCDA08CFFCDA0
          8BFFCC9F8AFFCC9D88FFFDFBF9FFC69786FF0000000C0000000000000000CDA1
          91FFFFFFFEFF168EE0FF137FD8FF1171D0FFFCF8F7FFF5EDE9FFF5ECE8FFF4EC
          E8FFF4ECE7FFF5ECE7FFFDFCFAFFC89B8AFF0000000B0000000000000000CFA4
          93FFFFFFFFFF19A1EAFF1794E1FF1485DAFFFDFAF8FFD0A692FFD0A591FFD0A3
          90FFCFA48FFFCEA38FFFFEFCFCFFCB9D8DFF0000000B0000000000000000D1A7
          96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFFEFEFDFFCDA191FF0000000900000000000000009C7D
          71BED2A898FFD2A898FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A6
          95FFD0A595FFCFA595FFCFA494FF98796EC20000000600000000}
        TabOrder = 6
        OnClick = btnRelIncClick
      end
      object btnConsPD: TBitBtnLocked
        Left = 330
        Top = 25
        Width = 330
        Height = 25
        Anchors = []
        Caption = '[F9] Consultar Pedidos de Venda'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F0000000F0000000F0000000F00000010000000100000
          00100000001000000012000000200713339E0F276AFF0A193A98000000087F57
          48C0B17864FFB07763FFAF7662FFAE7561FFAE7560FFAD735FFFAC735FFFAC72
          5EFFAA715CFFA26B57FF4D445EFF417CB9FF70C7FFFF265198FF0000000CB780
          6EFFF4ECE7FFF4EBE6FFF3EBE5FFF2EAE4FFF1E9E3FFEEE6E2FFEBE4E0FFE8E0
          DCFFE1D8D4FF6E7B9BFF4C83BCFF83CFFFFF5694CEFF142B4D990000000CB882
          70FFF6EEEAFFEEE0D9FFEDE0D8FFECE0DAFFDBCDC6FFA27D68FF8E5D41FF8C5C
          40FF795C52FF577EA6FF92D4FAFF619CD0FF64667FFF0000001C0000000BB984
          72FFF7F0ECFFEFE2DBFFEEE3DCFFDACBC2FF926246FFC8A583FFF0D9B9FFF0DC
          BEFFC7A88BFF895D43FF6891B2FF829BB6FFAD7967FF000000100000000ABB86
          75FFF8F2EFFF5E67E3FF656DDCFFAA8670FFC8A482FFF8DBADFFF7D6A6FFF8DB
          ACFFFAE3BFFFC8A88CFF83685CFFE5DFDBFFB6806FFF0000000D00000009BD88
          77FFF9F4F1FF626DE6FF787FE1FF98684BFFF2DBB9FFFCECCEFFFCEFD5FFF9E0
          B8FFF8DEB4FFF3E1C7FF8F5D41FFECE8E5FFB98370FF0000000C00000008BF8A
          79FFFAF6F4FF6672E8FF7E85E4FF9D6D51FFF4DEBDFFFEF8E8FFFEF7E5FFFDF0
          D9FFF8DEB6FFF3E2C8FF926145FFF0EBE8FFBA8572FF0000000B00000007C08D
          7BFFFBF8F6FF6B79EAFF7681E6FFB7947EFFCEAE90FFFCECD1FFFEFAEBFFFDF0
          D7FFFAE5C4FFCBAC90FFAD8974FFF3EEECFFBC8775FF0000000A00000007C28E
          7DFFFCF9F8FF717EECFF6D78E7FFE7DCD4FFA67757FFCFAF93FFF2DFC5FFF2DF
          C6FFCDAE92FFA17357FFDFD2CBFFF8F2F0FFBD8977FF0000000A00000006C391
          80FFFCFBF9FF7684EDFF6070E8FFF6F1EDFFDBBA8CFFB48864FFAA7D62FF9A79
          58FF878762FFE8DDD6FFF3EBE6FFF9F5F2FFBF8B7AFF0000000900000005C492
          82FFFDFCFBFFF8F3EEFFF8F2EDFFF8F1EDFFDEB676FFDAB078FFF6F1EEFF59CB
          96FF43B97DFFF5EEEAFFF4ECE7FFFAF7F5FFC08D7CFF0000000800000004C695
          84FFFEFDFCFFFAF4F1FFF9F3F0FFF8F3F0FFDCB067FFD3A257FFF7F2EDFF16BA
          70FF11AD5FFFF6F0EBFFF6EEEAFFFCF8F6FFC28F7EFF0000000700000004C797
          86FFFEFDFDFFFAF7F3FFFAF6F3FFFAF5F1FFDEB269FFD7A65CFFF9F4F0FFF8F2
          EFFFF8F2EEFFF7F2EDFFF7F1ECFFFCFAF8FFC39181FF0000000600000003C898
          88FFFEFEFDFFFEFEFDFFFEFEFDFFFEFDFDFFFEFDFCFFFEFDFCFFFEFDFCFFFEFC
          FBFFFDFCFBFFFDFCFBFFFDFBFAFFFDFBFAFFC59383FF00000005000000029673
          67BFCA9C8BFFCA9C8BFFCA9B8BFFCA9B8AFFC99A8AFFC99A8AFFC99A89FFC898
          89FFC89888FFC89787FFC79786FFC69686FF926F62C000000003}
        TabOrder = 7
        OnClick = btnConsPDClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 662
      Top = 27
      Width = 165
      Height = 25
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 662
      ExplicitTop = 27
      ExplicitWidth = 165
      ExplicitHeight = 25
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 840
    Height = 399
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblLimparExpedido: TLabel
      Left = 1
      Top = 357
      Width = 838
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'Para limpar a quantidade expedida do produto selecione o mesmo n' +
        'o Grid e pressione a tecla [Shift+F5]'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 497
    end
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 1
      Width = 838
      Height = 356
      Align = alClient
      Ctl3D = False
      DataSource = dtsItens
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgItensDrawColumnCell
      OnEnter = dbgItensEnter
      OnExit = dbgItensExit
      OnKeyDown = dbgItensKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Produto'
          Width = 387
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMLOT'
          Title.Caption = 'Lote'
          Width = 120
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SALEST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Estoque'
          Visible = False
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quantidade'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          Title.Caption = 'Unidade'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDEXP'
          Title.Alignment = taRightJustify
          Title.Caption = 'Expedido'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENTSAI'
          Title.Caption = 'Ent. / Sai.'
          Visible = True
        end>
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 371
      Width = 838
      Height = 27
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        838
        27)
      object lblCodBar: TLabel
        Left = 2
        Top = 6
        Width = 152
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Barras (Embalagem):'
      end
      object Label2: TLabel
        Left = 287
        Top = 6
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object shpSemSal: TShape
        Left = 650
        Top = 7
        Width = 12
        Height = 12
        Anchors = [akTop, akRight]
        Brush.Color = clRed
        Pen.Color = clRed
        ExplicitLeft = 657
      end
      object lblSemSal: TLabel
        Left = 666
        Top = 6
        Width = 167
        Height = 14
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Produtos sem saldo de estoque      '
        ExplicitLeft = 673
      end
      object lblSepImp: TLabel
        Left = 535
        Top = 6
        Width = 96
        Height = 14
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Sep. N'#227'o Impressa      '
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 442
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 154
        Top = 2
        Width = 130
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 346
        Top = 2
        Width = 73
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 840
    ExplicitTop = 455
    ExplicitWidth = 840
    inherited pnlNomeForm: TPanel
      Left = 669
      ExplicitLeft = 669
    end
    inherited pnlInfo: TPanel
      Width = 669
      ExplicitWidth = 669
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 624
    Top = 304
  end
  object dtsItens: TDataSource
    Left = 624
    Top = 336
  end
  object cdsSelecao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 336
    object cdsSelecaoCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object cdsSelecaoCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsSelecaoDESITE: TStringField
      FieldName = 'DESITE'
      Size = 87
    end
    object cdsSelecaoNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsSelecaoQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsSelecaoUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsSelecaoTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object cdsSelecaoUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 50
    end
    object qrySelecaoNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 40
    end
    object cdsSelecaoNOMVEN: TStringField
      FieldName = 'NOMVEN'
      Size = 30
    end
    object qrySelecaoNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsSelecaoENDENT: TStringField
      FieldName = 'ENDENT'
      Size = 40
    end
    object cdsSelecaoCIDENT: TStringField
      FieldName = 'CIDENT'
      Size = 40
    end
    object cdsSelecaoSIGLA_: TStringField
      FieldName = 'SIGLA_'
      Size = 5
    end
    object cdsSelecaoIDEPRO: TStringField
      FieldName = 'IDEPRO'
      Size = 3
    end
    object cdsSelecaoDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsSelecaoDTAVAL: TDateField
      FieldName = 'DTAVAL'
    end
    object cdsSelecaoMENSAG: TStringField
      FieldName = 'MENSAG'
      Size = 70
    end
    object qrySelecaoTIPEMB: TStringField
      FieldName = 'TIPEMB'
      Size = 2
    end
    object qrySelecaoNRODOC: TStringField
      FieldName = 'NRODOC'
      Size = 15
    end
    object cdsSelecaoCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsSelecaoVOLQTE: TStringField
      FieldName = 'VOLQTE'
      Size = 50
    end
  end
  object frxEtiqItens: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39456.445405405100000000
    ReportOptions.LastChange = 40084.421803379600000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 656
    Top = 336
  end
  object frxRelInconsistencia: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42157.424744710660000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure Memo21OnAfterData(Sender: TfrxComponent);'
      '  Var        '
      
        '   fltDifere : Double;                                          ' +
        '       '
      'begin'
      
        '  fltDifere := <frxRelatorio."ACONFE"> - <frxRelatorio."CONFER">' +
        ';                            '
      '  '
      '  If fltDifere <= 0 Then'
      '    Memo21.Text := '#39#39
      '  Else'
      
        '    Memo21.Text := FormatFloat('#39'#,##0.00'#39',fltDifere);           ' +
        '                                                                ' +
        '     '
      'end;'
      ''
      'procedure Memo5OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."CONFER"> <= 0 Then'
      '    Memo5.Text := '#39#39
      '  Else'
      
        '    Memo5.Text := FormatFloat('#39'#,##0.00'#39',<frxRelatorio."CONFER">' +
        ');'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 592
    Top = 304
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 268.346630000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintChildIfInvisible = True
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Width = 113.385838980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PEDIDO"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 680.314967950000000000
          Width = 75.590538980000000000
          Height = 15.118110240000000000
          OnAfterData = 'Memo21OnAfterData'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ACONFE"> - <frxRelatorio."CONFER">]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 600.945270000000000000
          Width = 75.590538980000000000
          Height = 15.118110240000000000
          OnAfterData = 'Memo5OnAfterData'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CONFER"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 517.795292680000000000
          Width = 79.370068980000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ACONFE"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 117.165430000000000000
          Width = 260.787447950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 381.732530000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 404.409710000000000000
        Width = 755.906000000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 378.481880000000000000
          Width = 377.877180000000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNome: TfrxMemoView
          Width = 374.400000000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[NOMFOR]')
          VAlign = vaCenter
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 173.858380000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object rllFundoHeader: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Width = 113.385838980000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 680.314967950000000000
          Width = 75.590538980000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 600.945270000000000000
          Width = 75.590538980000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CONFERIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 517.795292680000000000
          Width = 79.370068980000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A CONFERIR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 117.165430000000000000
          Width = 260.787447950000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 381.732530000000000000
          Width = 132.283464570000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 94.488188980000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo11: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 94.488188980000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          HAlign = haRight
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baCenter
          Left = 0.793940000000000000
          Top = 29.881880000000000000
          Width = 754.318120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 0.793940000000000000
          Top = 45.881880000000000000
          Width = 754.318120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Time: TfrxMemoView
          Left = 699.091316610000000000
          Top = 45.881880000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Date: TfrxMemoView
          Left = 630.647620000000000000
          Top = 45.881880000000000000
          Width = 68.031503390000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPagina: TfrxMemoView
          Left = 651.015770000000000000
          Top = 29.881880000000000000
          Width = 104.768460000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 0.377952760000000000
        Top = 381.732530000000000000
        Width = 755.906000000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 215.433210000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."DESITE"'
        object Memo12: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            
              '   Produto: [frxRelatorio."DESITE"] - Unidade: [frxRelatorio."UN' +
              'IDAD"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 306.141930000000000000
        Width = 755.906000000000000000
        object Memo18: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 680.314967950000000000
          Width = 75.590538980000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ACONFE"> - <frxRelatorio."CONFER">,rlbDetalh' +
              'es)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 600.945270000000000000
          Width = 75.590538980000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CONFER">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 517.795292680000000000
          Width = 79.370068980000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ACONFE">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
      end
    end
  end
  object cdsIteInc: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 561
    Top = 304
    object cdsIteIncDESITE: TStringField
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsIteIncUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 4
    end
    object cdsIteIncACONFE: TFloatField
      FieldName = 'ACONFE'
    end
    object cdsIteIncCONFER: TFloatField
      FieldName = 'CONFER'
    end
    object cdsIteIncDIFERE: TFloatField
      FieldName = 'DIFERE'
    end
    object cdsIteIncPEDIDO: TStringField
      FieldName = 'PEDIDO'
      Size = 19
    end
    object cdsIteIncNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 100
    end
    object cdsIteIncNOMVEN: TStringField
      FieldName = 'NOMVEN'
      Size = 100
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 560
    Top = 336
  end
end
