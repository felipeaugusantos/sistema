inherited frmConfigBancoInter: TfrmConfigBancoInter
  Width = 704
  Height = 540
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Configura'#231#245'es Banco Inter'
  Position = poMainFormCenter
  ExplicitWidth = 704
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 704
    ExplicitTop = 496
    ExplicitWidth = 704
    inherited FlwBotoes: TFlowPanel
      Width = 700
      ExplicitWidth = 700
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Gravar'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
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
        ParentFont = False
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnEditar: TBitBtnLocked
        Left = 88
        Top = 0
        Width = 88
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Alterar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000010421C11FF31140CE2190A069A0304
          07450000000E0000000200000000000000000000000000000000000000000000
          0002000000080000000C0000000D0000001B663C2BDEB9C7D2FF7889A2FF2441
          82FF051033980000001100000002000000000000000000000000000000000000
          0007295B8FBF357DC6FF337AC5FF528CC7FF696573FF879AB2FFC8E3F5FF1F66
          B6FF2B6BA8FF0512369700000010000000020000000000000000000000000000
          000A3C83CAFF8ACCF1FF66B9EBFF7AC0EAFF7AAAC9FF488BC3FFDEFEFDFF51B4
          E3FF1F68B7FF3173AEFF061538960000000F0000000200000000000000000000
          000A3F85CCFF93D1F2FF4690D2FF4F93D2FF6BA2D2FF5291C2FF479FD2FFDEFE
          FDFF59BFE9FF216BB9FF367BB3FF07173A940000000D00000002000000000000
          000A4389CEFF9CD5F3FF4A92D4FFFAF7F3FFF6F1EBFFEEE9E7FF8BB1CCFF4BA5
          D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF08193D920000000C000000000000
          0009468CD0FFA3D9F4FF4F97D5FFFBF8F6FFF6F0EBFFF6F1ECFFEFEBE8FF8DB3
          CEFF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F8F000000000000
          00094A8FD2FFABDDF5FF5399D6FFFCFAF8FFF6F1ECFFF6F0ECFFF7F1EEFFF0ED
          E8FF5695C7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
          00084D92D3FFB2E0F7FF569CD8FFFDFBFAFFF7F2EDFFF7F1ECFFF7F1EDFFF7F2
          EFFF72A6D6FF62A3D0FF54B1DCFFDEFEFDFF4FA6D4FF102C4E89000000000000
          00075094D6FFBAE4F7FF5B9FDAFFFDFCFBFFF8F2EEFFF8F2EEFFF7F2EDFFF0E8
          E3FF639DD4FF8DC3E6FF4D8EC4FF357FBCFF173A598700000006000000000000
          00075398D7FFBFE7F9FF5EA3DCFFFEFDFDFFF8F3F0FFF8F3F0FFEDE5E0FFE2D6
          D0FF458BCCFF7FBBE6FF5890CBFF0000000D0000000300000001000000000000
          0006559AD9FFC5E9F9FF62A6DEFFFEFEFEFFF9F4F1FFEAE1DCFFDCCDC7FFDCCD
          C7FF478BCCFF67ADDEFF377BC2FF000000090000000000000000000000000000
          0006589DDAFFCAEBFAFF66A9E0FFFFFFFEFFD0BEB7FFBBA298FFBBA199FFBBA1
          98FF4081C3FF66A9DBFF377BC2FF000000080000000000000000000000000000
          00055BA0DDFFCDEDFBFF69ACE1FFAC8E83FF946C5DFF926A5CFF91685AFF9A76
          69FF3D7DC0FF65A6D8FF397CC1FF000000070000000000000000000000000000
          00034678A5C05C9FDCFF599EDCFFB38D7EFFF1E9E2FFE2D2C6FFE1D0C3FF9971
          63FF4386CAFF498DD1FF33689AC1000000040000000000000000000000000000
          0001000000030000000400000005866A5FBEB58F80FFB58F80FFB48E7FFF8569
          5EBF000000060000000600000004000000010000000000000000}
        ParentFont = False
        TabOrder = 1
        OnClick = btnEditarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 176
        Top = 0
        Width = 88
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'C&ancelar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
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
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnClick = btnCancelarClick
      end
      object btnConfigurar: TBitBtnLocked
        Left = 264
        Top = 0
        Width = 88
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Configurar'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
          99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
          B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
          CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
          2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
          E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
          A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
          1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
          FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
          9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
          0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
          F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
          9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
          FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
          A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
          9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
          B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
          7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 3
        OnClick = btnConfigurarClick
      end
      object BtnManual: TBitBtnLocked
        Left = 352
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Manual'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF1E74E82E72D65181CD5B76B3245FC4FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4A94F078A3DCB2BAC7D2
          C4BCE6BDA2F4AE76B7A6A33973D0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          298FFF7AADEAFBDDB6FFE0B8FFE5BAFFDCB6ECB791E29B6AFDCEA2EEDED07AA2
          E0337BE1FF00FFFF00FFFF00FFFF00FF4282C8D6C7B2FFEFD3FEECD4FDE9D2F3
          D5BDE3A882ECB183FADFC4FFEFDEFFFBF0B9D2F3468EEEFF00FFFF00FF318FFF
          BD8E57FFE5B5FEF7EFFEF6EAFBEBDDEECBB3DE986CEFBE99FDECDAFFF6EEFFFB
          F8FFFFFFAEC6EA2578E7FF00FF2E84D488C474FFF8ECFFFBF7FFFBF6F9E7DBE7
          B89CE8AB80F6D8BFC5C1BBE3DFDBFEFEFDFFFFFEC6A7A94283DCFF00FF2B898E
          7CDC9FFFFFFFFFFEFCFEFCF9F3DBCBE2A782EAB38CFEEBDBF6F1EBC9CAC8D0D1
          CFF7F4F39893B53A91FBFF00FF1455D0CEDFF2FFFFFFFFFFFFFEFDFBEDD6CBE3
          AC87F5CEADE8E1DAFCF8F5FFFFFFEFEEEDB5D4F93A91FBFF00FF2C7EEA355DF3
          FFFFFFE1EFFFBADAFF98C7FF4BA0FF77ABEBDFE0E4DDD7CEC4C4C2E7E7E7FFFF
          FF71B2FF288CFFFF00FF2F8EFF53A1FF68AEFF73B3FFFF00FFFF00FFFF00FFFF
          00FF2D8DFFB1D6FFF1F1F0DFD9CED9E9FA3F97FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2D8DFFBFDDFF76B4
          FE2B8CFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF2D8DFFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 4
      end
      object BtnOcorrencia: TBitBtnLocked
        Left = 440
        Top = 0
        Width = 88
        Height = 22
        Caption = 'Oco&rr'#234'ncias'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
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
        ParentFont = False
        TabOrder = 5
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 621
      ExplicitLeft = 621
    end
  end
  inherited pnlStatus: TPanel
    Top = 524
    Width = 704
    ExplicitTop = 524
    ExplicitWidth = 704
    inherited pnlNomeForm: TPanel
      Left = 533
      ExplicitLeft = 533
    end
    inherited pnlInfo: TPanel
      Width = 533
      ExplicitWidth = 533
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 704
    Height = 496
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 700
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Banco Inter - 077'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object tabCarteira: TTabControl
      Left = 2
      Top = 24
      Width = 700
      Height = 470
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 0
      Tabs.Strings = (
        'Carteira &1'
        'Carteira &2'
        'Carteira &3'
        'Carteira &4'
        'Carteira &5')
      TabIndex = 0
      OnChange = tabCarteiraChange
      OnChanging = tabCarteiraChanging
      object cxPaginas: TcxPageControl
        Left = 4
        Top = 25
        Width = 692
        Height = 441
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        ParentFont = False
        TabOrder = 0
        Properties.ActivePage = tbsGeral
        Properties.CustomButtons.Buttons = <>
        Properties.HotTrack = True
        Properties.Style = 9
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        ClientRectBottom = 441
        ClientRectRight = 692
        ClientRectTop = 20
        object tbsGeral: TcxTabSheet
          Caption = 'Dados Gerais'
          ImageIndex = 0
          object pnlAtivo1: TPanel
            Left = 0
            Top = 0
            Width = 692
            Height = 421
            Align = alClient
            BevelOuter = bvNone
            Color = 16770261
            Enabled = False
            ParentBackground = False
            TabOrder = 0
            object lblCodAgenc: TLabel
              Left = 6
              Top = 10
              Width = 161
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'C'#243'digo da Ag'#234'ncia / Digito:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblCodCart: TLabel
              Left = 330
              Top = 30
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'C'#243'digo da Carteira:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblContCorr: TLabel
              Left = 382
              Top = 10
              Width = 116
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Conta Corrente / D'#237'gito:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblDiasProt: TLabel
              Left = 6
              Top = 191
              Width = 247
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Qtd. dias para Protesto/Devolu'#231#227'o/ Negativa'#231#227'o:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblIdentBanco: TLabel
              Left = 17
              Top = 31
              Width = 150
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'C'#243'digo do Benefici'#225'rio:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label1: TLabel
              Left = 17
              Top = 51
              Width = 153
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Portador de Baixa:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label2: TLabel
              Left = 40
              Top = 71
              Width = 130
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Conta Baixa:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label8: TLabel
              Left = 40
              Top = 91
              Width = 130
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 1:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label9: TLabel
              Left = 40
              Top = 111
              Width = 130
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 2:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label10: TLabel
              Left = 32
              Top = 131
              Width = 138
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 3:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label11: TLabel
              Left = 48
              Top = 151
              Width = 122
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 4:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label12: TLabel
              Left = 48
              Top = 171
              Width = 122
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 5:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label13: TLabel
              Left = 42
              Top = 252
              Width = 130
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Exp. CNPJ do Cedente:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object ColorLabel3: TColorLabel
              Left = 201
              Top = 253
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              CorDestaque = clRed
            end
            object Label14: TLabel
              Left = 391
              Top = 192
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Quantidade de Dias para Cr'#233'dito:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label17: TLabel
              Left = 391
              Top = 212
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Percentual de Multa:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lbl1: TLabel
              Left = 391
              Top = 232
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Tipo de dias para protesto:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lbl2: TLabel
              Left = 34
              Top = 233
              Width = 138
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Informa'#231#227'o Adicional:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentBiDiMode = False
              ParentColor = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
            end
            object Label6: TLabel
              Left = 19
              Top = 212
              Width = 153
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Quantidade de Dias para Mora:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label22: TLabel
              Left = 350
              Top = 0
              Width = 152
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object Label5: TLabel
              Left = 374
              Top = 253
              Width = 184
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Dias corridos para baixa autom'#225'tica:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentBiDiMode = False
              ParentColor = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
            end
            object lblVersaoAPi: TLabel
              Left = 121
              Top = 275
              Width = 51
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Vers'#227'o:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblVersaoObs: TLabel
              Left = 229
              Top = 274
              Width = 79
              Height = 13
              Caption = 'Vers'#227'o Obsoleta'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              Visible = False
            end
            object lblAmbiente: TLabel
              Left = 443
              Top = 273
              Width = 114
              Height = 13
              Alignment = taRightJustify
              Caption = 'Ambiente Configurado :'
            end
            object edtDiasProt: TEditFocus
              Tag = 99
              Left = 256
              Top = 188
              Width = 57
              Height = 21
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 13
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 2
              TipoTexto = ttNumerico
            end
            object edtContaCorr: TEditFocus
              Tag = 99
              Left = 501
              Top = 7
              Width = 142
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 15
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 15
              TipoTexto = ttNumerico
            end
            object edtCodAgencia: TEditFocus
              Tag = 99
              Left = 173
              Top = 7
              Width = 142
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 4
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 4
              TipoTexto = ttNumerico
            end
            object edtCodigoBeneficiario: TEditFocus
              Left = 173
              Top = 27
              Width = 168
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 9
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 9
              TipoTexto = ttNumerico
            end
            object edtCodCar: TEditFocus
              Left = 501
              Top = 27
              Width = 168
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 5
              Text = '112'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            object edtDesPor: TEditFocus
              Left = 237
              Top = 48
              Width = 432
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
              Color = 16768952
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
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
            object edtCodPor: TEditFocus
              Tag = 99
              Left = 173
              Top = 48
              Width = 63
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              ParentFont = False
              TabOrder = 6
              OnKeyPress = edtCodPorKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesCtaBai: TEditFocus
              Left = 237
              Top = 68
              Width = 432
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
              Color = 16768952
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 23
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtCtaBai: TEditFocus
              Tag = 99
              Left = 173
              Top = 68
              Width = 63
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 7
              ParentFont = False
              TabOrder = 7
              OnKeyPress = edtCtaBaiKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 7
              TipoTexto = ttNumerico
            end
            object edtObservacao1: TEditFocus
              Tag = 99
              Left = 173
              Top = 88
              Width = 496
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 78
              ParentFont = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtObservacao2: TEditFocus
              Tag = 99
              Left = 173
              Top = 108
              Width = 496
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 78
              ParentFont = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtObservacao3: TEditFocus
              Tag = 99
              Left = 173
              Top = 128
              Width = 496
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 78
              ParentFont = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtObservacao4: TEditFocus
              Tag = 99
              Left = 173
              Top = 148
              Width = 496
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 78
              ParentFont = False
              TabOrder = 11
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtObservacao5: TEditFocus
              Tag = 99
              Left = 173
              Top = 168
              Width = 496
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 78
              ParentFont = False
              TabOrder = 12
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpCgc: TEditFocus
              Tag = 99
              Left = 173
              Top = 250
              Width = 27
              Height = 20
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 19
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            object edtDiasCred: TEditFocus
              Left = 562
              Top = 188
              Width = 107
              Height = 21
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 14
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 2
              TipoTexto = ttNumerico
            end
            object edtPerMul: TEditFocus
              Tag = 99
              Left = 562
              Top = 210
              Width = 107
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              MaxLength = 5
              ParentFont = False
              TabOrder = 16
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object cmbTipDia: TComboBoxFocus
              Tag = 99
              Left = 562
              Top = 230
              Width = 107
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemHeight = 13
              ItemIndex = 0
              ParentFont = False
              TabOrder = 18
              Text = #218'teis'
              Items.Strings = (
                #218'teis'
                'Corridos')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtInfAdi: TEditFocus
              Left = 173
              Top = 230
              Width = 140
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              MaxLength = 10
              ParentFont = False
              TabOrder = 17
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttAlfanumerico
            end
            object edtDiasMora: TEditFocus
              Tag = 99
              Left = 173
              Top = 210
              Width = 140
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 15
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 2
              TipoTexto = ttNumerico
            end
            object edtDigCtaCor: TEditFocus
              Tag = 99
              Left = 644
              Top = 7
              Width = 25
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfanumerico
            end
            object edtDigitoAgencia: TEditFocus
              Tag = 99
              Left = 316
              Top = 7
              Width = 25
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              ParentFont = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfanumerico
            end
            object pnlAuthV1: TPanel
              Left = 0
              Top = 338
              Width = 692
              Height = 83
              Align = alBottom
              BevelOuter = bvNone
              Caption = 'pnlAuthV1'
              ShowCaption = False
              TabOrder = 24
              object lblArquivoCRT: TLabel
                Left = 32
                Top = 26
                Width = 140
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Arquivo do certificado CRT:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object lblArquivoKey: TLabel
                Left = 17
                Top = 46
                Width = 156
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Arquivo KEY (chave privada):'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object lblValidadeCertificado: TLabel
                Left = 174
                Top = 68
                Width = 56
                Height = 13
                Caption = 'VALIDADE'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                Font.Quality = fqClearType
                ParentFont = False
              end
              object Label3: TLabel
                Left = 2
                Top = 67
                Width = 170
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Validade do Certificado:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object Label4: TLabel
                Left = 33
                Top = 4
                Width = 139
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Senha para o certificado:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object edtArquivoCRT: TEditFocus
                Tag = 99
                AlignWithMargins = True
                Left = 173
                Top = 23
                Width = 473
                Height = 21
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                TabStop = False
                Alignment = taLeftJustify
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
              object btnArquivoCRT: TcxButton
                Left = 646
                Top = 22
                Width = 23
                Height = 23
                OptionsImage.Glyph.SourceDPI = 96
                OptionsImage.Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
                  526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
                  785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
                  B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
                  36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
                  461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
                  E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
                  FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
                  03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
                  24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
                  CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
                  54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
                  F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
                  B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
                  9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
                  B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
                  D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
                  9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
                  FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
                  A14B22EE620A0000000049454E44AE426082}
                TabOrder = 2
                TabStop = False
                OnClick = btnArquivoCRTClick
              end
              object edtArquivoKey: TEditFocus
                Tag = 99
                AlignWithMargins = True
                Left = 173
                Top = 45
                Width = 473
                Height = 21
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                TabStop = False
                Alignment = taLeftJustify
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
              object btnArquivoKey: TcxButton
                Left = 646
                Top = 44
                Width = 23
                Height = 22
                OptionsImage.Glyph.SourceDPI = 96
                OptionsImage.Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
                  526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
                  785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
                  B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
                  36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
                  461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
                  E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
                  FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
                  03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
                  24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
                  CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
                  54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
                  F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
                  B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
                  9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
                  B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
                  D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
                  9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
                  FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
                  A14B22EE620A0000000049454E44AE426082}
                TabOrder = 4
                TabStop = False
                OnClick = btnArquivoKeyClick
              end
              object edtSenhaCertificado: TEditFocus
                Tag = 99
                Left = 173
                Top = 1
                Width = 140
                Height = 21
                Alignment = taLeftJustify
                AutoSize = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
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
            end
            object pnlAuthV2: TPanel
              Left = 0
              Top = 292
              Width = 692
              Height = 46
              Align = alBottom
              BevelOuter = bvNone
              Caption = 'pnlAuthV2'
              ShowCaption = False
              TabOrder = 25
              object lblClientSecret: TLabel
                Left = 41
                Top = 28
                Width = 130
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Client Secret:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object lblClientID: TLabel
                Left = 102
                Top = 5
                Width = 70
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Client ID:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object edtClientSecret: TEditFocus
                Tag = 99
                Left = 173
                Top = 24
                Width = 496
                Height = 22
                Alignment = taLeftJustify
                AutoSize = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 1
                OnEnter = edtClientSecretEnter
                OnExit = edtClientSecretExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtClientID: TEditFocus
                Tag = 99
                Left = 173
                Top = 1
                Width = 496
                Height = 22
                Alignment = taLeftJustify
                AutoSize = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 0
                OnEnter = edtClientIDEnter
                OnExit = edtClientIDExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
            end
            object cmbVersaoAPi: TComboBox
              Left = 173
              Top = 271
              Width = 53
              Height = 21
              Style = csDropDownList
              TabOrder = 20
              OnChange = cmbVersaoAPiChange
              Items.Strings = (
                '1.0'
                '2.0'
                '3.0')
            end
            object cmbAmbiente: TcxComboBox
              Tag = 99
              Left = 561
              Top = 271
              Properties.DropDownListStyle = lsFixedList
              Properties.IncrementalSearch = False
              Properties.Items.Strings = (
                'Homologa'#231#227'o'
                'Produ'#231#227'o')
              Style.BorderColor = clAppWorkSpace
              Style.LookAndFeel.Kind = lfOffice11
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfOffice11
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfOffice11
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfOffice11
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 21
              Text = 'Homologa'#231#227'o'
              Width = 109
            end
            object edtDiasBaixaAutomatica: TEditFocus
              Tag = 99
              Left = 562
              Top = 250
              Width = 107
              Height = 21
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 26
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 2
              TipoTexto = ttNumerico
            end
          end
        end
        object cxTabDadosSacadorAvalista: TcxTabSheet
          Caption = 'Complemento'
          ImageIndex = 1
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlAtivo2: TPanel
            Left = 0
            Top = 0
            Width = 692
            Height = 421
            Align = alClient
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object pnlSacAva: TPanel
              Left = 0
              Top = 0
              Width = 692
              Height = 193
              Align = alTop
              BevelOuter = bvNone
              Caption = 'pnlSacAva'
              TabOrder = 0
              object Label7: TLabel
                Left = 8
                Top = 11
                Width = 139
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                BiDiMode = bdLeftToRight
                Caption = 'Enviar Sacador/Avalista?:'
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentBiDiMode = False
                ParentColor = False
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                Transparent = True
              end
              object ColorLabel7: TColorLabel
                Left = 177
                Top = 11
                Width = 54
                Height = 13
                Caption = '(S)im (N)'#227'o'
                CorDestaque = clRed
              end
              object grpBeneficiario: TGroupBox
                Left = 13
                Top = 37
                Width = 651
                Height = 122
                Caption = 'Dados do Sacador/Avalista'
                TabOrder = 1
                object lblDesCrr: TLabel
                  Left = 2
                  Top = 17
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Benefici'#225'rio:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label28: TLabel
                  Left = 2
                  Top = 37
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Endere'#231'o:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label29: TLabel
                  Left = 2
                  Top = 57
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Complemento:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label15: TLabel
                  Left = 264
                  Top = 57
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Bairro:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label16: TLabel
                  Left = 0
                  Top = 77
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Cidade:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label18: TLabel
                  Left = 388
                  Top = 77
                  Width = 43
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Estado:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label33: TLabel
                  Left = 463
                  Top = 77
                  Width = 28
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'CEP:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label34: TLabel
                  Left = 2
                  Top = 97
                  Width = 168
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'CNPJ:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object edtDesBen: TEditFocus
                  Tag = 99
                  Left = 172
                  Top = 14
                  Width = 461
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 60
                  ParentFont = False
                  TabOrder = 0
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtEndBen: TEditFocus
                  Tag = 99
                  Left = 172
                  Top = 34
                  Width = 461
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 1
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtCompBen: TEditFocus
                  Tag = 99
                  Left = 172
                  Top = 54
                  Width = 200
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 2
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtBaiBen: TEditFocus
                  Tag = 99
                  Left = 433
                  Top = 54
                  Width = 200
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 3
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtCidBen: TEditFocus
                  Tag = 99
                  Left = 172
                  Top = 74
                  Width = 200
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 4
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtEstBen: TEditFocus
                  Tag = 99
                  Left = 433
                  Top = 74
                  Width = 33
                  Height = 19
                  Alignment = taLeftJustify
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  MaxLength = 2
                  ParentFont = False
                  TabOrder = 5
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfabetico
                end
                object edtCepBen: TMaskEditFocus
                  Tag = 99
                  Left = 499
                  Top = 74
                  Width = 134
                  Height = 21
                  EditMask = '99999-999'
                  MaxLength = 9
                  TabOrder = 6
                  Text = '     -   '
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  ValidaData = False
                end
                object edtCgcBen: TMaskEditFocus
                  Tag = 99
                  Left = 172
                  Top = 94
                  Width = 200
                  Height = 21
                  EditMask = '99.999.999/9999-99'
                  MaxLength = 18
                  TabOrder = 7
                  Text = '  .   .   /    -  '
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  ValidaData = False
                end
              end
              object edtUsaSac: TEditFocus
                Tag = 99
                Left = 153
                Top = 8
                Width = 19
                Height = 19
                Alignment = taLeftJustify
                AutoSize = False
                CharCase = ecUpperCase
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                MaxLength = 1
                ParentFont = False
                TabOrder = 0
                Text = 'N'
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 1
                TipoTexto = ttAlfabetico
              end
            end
          end
        end
      end
      object WebBrowser: TWebBrowser
        Left = 727
        Top = 139
        Width = 27
        Height = 33
        TabStop = False
        TabOrder = 1
        ControlData = {
          4C000000CA020000690300000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620A000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 792
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 792
    Top = 368
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 784
    Top = 240
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpRightBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 625
    Top = 24
  end
end
