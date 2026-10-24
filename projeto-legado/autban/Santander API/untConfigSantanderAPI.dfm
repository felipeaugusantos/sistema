inherited frmConfigSantanderAPI: TfrmConfigSantanderAPI
  Width = 679
  Height = 663
  BorderIcons = [biSystemMenu]
  Caption = 'frmConfigSantanderAPI'
  Position = poScreenCenter
  ExplicitWidth = 679
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 590
    Width = 673
    ExplicitTop = 590
    ExplicitWidth = 673
    inherited FlwBotoes: TFlowPanel
      Width = 669
      ExplicitWidth = 669
      object btnEditar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Alterar'
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
        TabOrder = 0
        OnClick = btnEditarClick
      end
      object btnGravar: TBitBtnLocked
        Left = 88
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
        TabOrder = 1
        OnClick = btnGravarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 176
        Top = 0
        Width = 88
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'C&ancelar'
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
        OnClick = BtnOcorrenciaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 593
      ExplicitLeft = 593
    end
  end
  inherited pnlStatus: TPanel
    Top = 618
    Width = 673
    ExplicitTop = 618
    ExplicitWidth = 673
    inherited pnlNomeForm: TPanel
      Left = 502
      ExplicitLeft = 502
    end
    inherited pnlInfo: TPanel
      Width = 502
      ExplicitWidth = 502
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 673
    Height = 590
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
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 2
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 669
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Banco Santander - 033 [ Online ]'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
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
      Width = 669
      Height = 564
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
        Top = 24
        Width = 661
        Height = 536
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
        OnChange = cxPaginasChange
        ClientRectBottom = 536
        ClientRectRight = 661
        ClientRectTop = 20
        object tbsGeral: TcxTabSheet
          Caption = 'Dados Gerais'
          ImageIndex = 0
          object pnlAtivo1: TPanel
            Left = 0
            Top = 0
            Width = 661
            Height = 516
            Align = alClient
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object lblCodCart: TLabel
              Left = 3
              Top = 9
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'C'#243'digo da Carteira:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblIdentBanco: TLabel
              Left = 320
              Top = 9
              Width = 171
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Identifica'#231#227'o no Banco (Contrato):'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblCodAgenc: TLabel
              Left = 3
              Top = 29
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'C'#243'digo da Ag'#234'ncia:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblContCorr: TLabel
              Left = 3
              Top = 49
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Conv'#234'nio Cedente:'
              Color = 16770261
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblDiasProt: TLabel
              Left = 4
              Top = 208
              Width = 167
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Quantidade de Dias para Protesto:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblInstrucao1: TLabel
              Left = 3
              Top = 69
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Instru'#231#227'o 1:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblInstrucao2: TLabel
              Left = 33
              Top = 89
              Width = 138
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Instru'#231#227'o 2:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblPortadorBaixa: TLabel
              Left = 81
              Top = 310
              Width = 90
              Height = 13
              Caption = 'Portador de Baixa:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblObservacao1: TLabel
              Left = 3
              Top = 109
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 1:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblObservacao2: TLabel
              Left = 3
              Top = 129
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 2:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblObservacao3: TLabel
              Left = 3
              Top = 149
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 3:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblObservacao4: TLabel
              Left = 3
              Top = 169
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 4:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblObservacao5: TLabel
              Left = 3
              Top = 189
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Observa'#231#227'o 5:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblDiasCred: TLabel
              Left = 324
              Top = 209
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Quantidade de Dias para Cr'#233'dito:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object Label14: TLabel
              Left = 328
              Top = 185
              Width = 159
              Height = 14
              Caption = 'Quantidade de Dias para Cr'#233'dito:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblProAce: TLabel
              Left = 406
              Top = 269
              Width = 159
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Imprime Protocolo de Aceite:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              Transparent = True
            end
            object lblSAcAva: TLabel
              Left = 46
              Top = 270
              Width = 125
              Height = 13
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Caption = 'Mostrar Sacador Avalista?'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblDupAgrSN: TColorLabel
              Left = 196
              Top = 290
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              CorDestaque = clRed
            end
            object lblSAcAvaSN: TColorLabel
              Left = 196
              Top = 270
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              CorDestaque = clRed
            end
            object lblDupAgr: TLabel
              Left = 25
              Top = 290
              Width = 146
              Height = 13
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Caption = 'Enviar N'#250'm. Dupl. Agrupadas?'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblTipDia: TLabel
              Left = 3
              Top = 371
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Tipo de dias para protesto:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblPerMul: TLabel
              Left = 3
              Top = 229
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Percentual de Multa:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblInfAdi: TLabel
              Left = 323
              Top = 229
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Informa'#231#227'o Adicional:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              Transparent = True
            end
            object lblContaCobr: TLabel
              Left = 323
              Top = 49
              Width = 168
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Num. Conta Corrente Cobran'#231'a:'
              Color = clBtnFace
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            object lblProAceSN: TColorLabel
              Left = 593
              Top = 270
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              CorDestaque = clRed
            end
            object lblWorkspace: TLabel
              Left = 36
              Top = 391
              Width = 133
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Workspace API Santander:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
            end
            object lblEmpresaConvenio: TLabel
              Left = -12
              Top = 350
              Width = 182
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Empresa detentora do conv'#234'nio:'
              Color = 16770261
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
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
            end
            object lblCreditDate: TLabel
              Left = 348
              Top = 290
              Width = 217
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Considerar liquida'#231#227'o pela data de cr'#233'dito:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              Transparent = True
            end
            object lblCreditDateSN: TColorLabel
              Left = 593
              Top = 290
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              CorDestaque = clRed
            end
            object edtIdentBanc: TEditFocus
              Left = 493
              Top = 6
              Width = 154
              Height = 19
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
              MaxLength = 20
              ParentFont = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtDiasProt: TEditFocus
              Tag = 99
              Left = 173
              Top = 206
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
              MaxLength = 2
              ParentFont = False
              TabOrder = 12
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
              Left = 173
              Top = 46
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
              MaxLength = 8
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 8
              TipoTexto = ttNumerico
            end
            object edtCodAgencia: TEditFocus
              Tag = 99
              Left = 173
              Top = 26
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
              MaxLength = 4
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 4
              TipoTexto = ttNumerico
            end
            object edtDesPor: TEditFocus
              Left = 235
              Top = 307
              Width = 412
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
              Color = 16768952
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
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
              Top = 307
              Width = 61
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
              TabOrder = 21
              OnKeyPress = edtCodPorKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtObservacao1: TEditFocus
              Tag = 99
              Left = 173
              Top = 106
              Width = 474
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
              MaxLength = 60
              ParentFont = False
              TabOrder = 7
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
              Top = 126
              Width = 474
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
              MaxLength = 60
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
            object edtObservacao3: TEditFocus
              Tag = 99
              Left = 173
              Top = 146
              Width = 474
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
              MaxLength = 60
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
            object edtObservacao4: TEditFocus
              Tag = 99
              Left = 173
              Top = 166
              Width = 474
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
              MaxLength = 60
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
            object edtObservacao5: TEditFocus
              Tag = 99
              Left = 173
              Top = 186
              Width = 474
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
              MaxLength = 60
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
            object edtContaCobr: TEditFocus
              Tag = 99
              Left = 493
              Top = 46
              Width = 154
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
            object edtDiasCred: TEditFocus
              Left = 493
              Top = 206
              Width = 154
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
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
            object edtSacAva: TEditFocus
              Tag = 99
              Left = 173
              Top = 267
              Width = 19
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
              MaxLength = 1
              ParentFont = False
              TabOrder = 17
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            object edtDupAgr: TEditFocus
              Tag = 99
              Left = 173
              Top = 287
              Width = 19
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
            object cmbTipDia: TComboBoxFocus
              Left = 173
              Top = 368
              Width = 100
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemHeight = 13
              ParentFont = False
              TabOrder = 26
              Items.Strings = (
                #218'teis'
                'Corridos')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtPerMul: TEditFocus
              Tag = 99
              Left = 173
              Top = 226
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
              MaxLength = 5
              ParentFont = False
              TabOrder = 14
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 5
              TipoTexto = ttNumerico
              EditFormat = ',0.00'
            end
            object edtInfAdi: TEditFocus
              Left = 493
              Top = 226
              Width = 154
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              MaxLength = 10
              ParentFont = False
              TabOrder = 15
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttAlfanumerico
            end
            object cmbCodCar: TComboBoxFocus
              Tag = 99
              Left = 173
              Top = 6
              Width = 140
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ItemHeight = 13
              ParentFont = False
              TabOrder = 0
              Items.Strings = (
                '1 - ELETR'#212'NICA COM REGISTRO'
                '3 - CAUCIONADA ELETR'#212'NICA'
                '4 - COBRAN'#199'A SEM REGISTRO'
                '5 - R'#193'PIDA COM REGISTRO'
                '6 - CAUCIONADA R'#193'PIDA'
                '7 - DESCONTADA ELETR'#212'NICA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cmbInstrucao1: TComboBoxFocus
              Tag = 99
              Left = 173
              Top = 66
              Width = 474
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ItemHeight = 13
              ParentFont = False
              TabOrder = 5
              Items.Strings = (
                '00 - N'#227'o h'#225' instru'#231#245'es'
                '06 - Protestar'
                '07 - N'#227'o protestar')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cmbInstrucao2: TComboBoxFocus
              Tag = 99
              Left = 173
              Top = 86
              Width = 474
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ItemHeight = 13
              ParentFont = False
              TabOrder = 6
              Items.Strings = (
                '00 - N'#227'o h'#225' instru'#231#245'es'
                '02 - Baixar ap'#243's 15 dias do vencimento'
                '03 - Baixar ap'#243's 30 dias do vencimento'
                '04 - N'#227'o baixar')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtProAce: TEditFocus
              Tag = 99
              Left = 571
              Top = 267
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
              TabOrder = 18
              Text = 'N'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            inline fraPlanoDeContasBai: TfraPlanoDeContasMskEdit
              Left = 105
              Top = 327
              Width = 573
              Height = 21
              TabOrder = 23
              ExplicitLeft = 105
              ExplicitTop = 327
              ExplicitWidth = 573
              ExplicitHeight = 21
              inherited lblPlaContas: TLabel
                Left = 4
                Width = 62
                Caption = 'Conta Baixa:'
                ExplicitLeft = 4
                ExplicitWidth = 62
              end
              inherited edtDesCta: TEditFocus
                Left = 130
                Width = 412
                ExplicitLeft = 130
                ExplicitWidth = 412
              end
              inherited MskCodCta: TMaskEdit
                Left = 68
                Width = 61
                OnKeyPress = fraPlanoDeContasBaiMskCodCtaKeyPress
                ExplicitLeft = 68
                ExplicitWidth = 61
              end
            end
            inline fraGerarPixBoleto: TfraGerarPixBoleto
              Left = 37
              Top = 245
              Width = 641
              Height = 21
              Color = 16770261
              ParentBackground = False
              ParentColor = False
              TabOrder = 16
              ExplicitLeft = 37
              ExplicitTop = 245
              ExplicitWidth = 641
              ExplicitHeight = 21
              inherited pnlChavePix: TPanel
                Width = 641
                Height = 21
                ExplicitWidth = 641
                ExplicitHeight = 21
                inherited lblGerarPix: TLabel
                  Left = 5
                  Top = 4
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Quality = fqClearType
                  ExplicitLeft = 5
                  ExplicitTop = 4
                end
                inherited lblGerarPixSN: TColorLabel
                  Left = 161
                  Top = 4
                  Font.Charset = ANSI_CHARSET
                  Font.Pitch = fpVariable
                  Font.Quality = fqClearType
                  ExplicitLeft = 161
                  ExplicitTop = 4
                end
                inherited lblChavePix: TLabel
                  Left = 233
                  Top = 4
                  Font.Charset = ANSI_CHARSET
                  Font.Pitch = fpVariable
                  Font.Quality = fqClearType
                  ExplicitLeft = 233
                  ExplicitTop = 4
                end
                inherited edtGerarPix: TEditFocus
                  Top = 1
                  Width = 19
                  Height = 20
                  OnChange = fraGerarPixBoletoedtGerarPixChange
                  ExplicitTop = 1
                  ExplicitWidth = 19
                  ExplicitHeight = 20
                end
                inherited cmbChavePix: TcxLookupComboBox
                  Tag = 99
                  Left = 343
                  Properties.ListColumns = <
                    item
                      FieldName = 'CHAVE'
                    end>
                  Properties.ListOptions.SyncMode = True
                  ExplicitLeft = 343
                  ExplicitWidth = 267
                  Width = 267
                end
              end
            end
            object grpDadosAutorizacao: TGroupBox
              Left = 4
              Top = 416
              Width = 644
              Height = 92
              Caption = 'Dados de Autoriza'#231#227'o'
              TabOrder = 29
              object pnlAuthV2: TPanel
                Left = 7
                Top = 15
                Width = 626
                Height = 40
                BevelOuter = bvNone
                Caption = 'pnlDadosAutorizacao'
                ShowCaption = False
                TabOrder = 0
                object lblClientSecret: TLabel
                  Left = 6
                  Top = 24
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
                  Left = 66
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
                  Left = 138
                  Top = 21
                  Width = 484
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
                  ParentFont = False
                  PasswordChar = '*'
                  TabOrder = 1
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
                  Left = 138
                  Top = 1
                  Width = 484
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
              end
              object pnlCertificado: TPanel
                Left = 23
                Top = 123
                Width = 618
                Height = 67
                BevelOuter = bvNone
                ShowCaption = False
                TabOrder = 1
                object lblValidadeCertificado: TLabel
                  Left = 132
                  Top = 44
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
                  Visible = False
                end
                object lblVallidadeCertificadoDesc: TLabel
                  Left = -40
                  Top = 43
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
                  Visible = False
                end
                object lblArquivoPFX: TLabel
                  Left = -10
                  Top = 24
                  Width = 140
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Certificado PFX:'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  Visible = False
                end
                object lblSenhaCertificado: TLabel
                  Left = -10
                  Top = 4
                  Width = 140
                  Height = 14
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Senha Certificado:'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  Visible = False
                end
                object edtArquivoPFX: TEditFocus
                  Tag = 99
                  AlignWithMargins = True
                  Left = 132
                  Top = 21
                  Width = 460
                  Height = 21
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  TabStop = False
                  Alignment = taLeftJustify
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 0
                  Visible = False
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object btnArquivoPFX: TcxButton
                  Left = 593
                  Top = 21
                  Width = 23
                  Height = 21
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
                  TabOrder = 1
                  TabStop = False
                  Visible = False
                  OnClick = btnArquivoPFXClick
                end
                object edtSenhaCertificado: TEditFocus
                  Tag = 99
                  Left = 132
                  Top = 1
                  Width = 159
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
                  MaxLength = 32
                  ParentFont = False
                  PasswordChar = '*'
                  TabOrder = 2
                  Visible = False
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
              end
            end
            object edtWorkspace: TEditFocus
              Left = 173
              Top = 388
              Width = 357
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              TabOrder = 27
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 36
              TipoTexto = ttAlfanumerico
            end
            object btnGerarWorkSpace: TBitBtnLocked
              Left = 533
              Top = 386
              Width = 114
              Height = 24
              Caption = 'Gerar Workspace'
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000001000000020000
                00063D29238F714C43FF311F1A8F000000070000000200000001000000090000
                000E0000000F0000000F0000001000000010000000110D090731201613602519
                156F725045F4C2B0A7FF5F3F36F42317136D1D1310580B0706257F6056C1B185
                78FFB08576FFAF8476FFAF8375FFAF8375FFC9AEA5FF8E7166FF987F76FF8467
                5DFFBFAEA4FFE2D9D2FFC6B7B1FF7D5F56FF896D63FF472F28B9BF998BFFF8F3
                EDFFF7F2ECFFF5F0EBFFF5F0EBFFF5F0EAFFF8F3F0FFC2B1ABFFA48A80FFECE7
                E3FFBDA69CFF9E7E70FFC3AFA6FFEAE2DEFF997C72FF38282479C09B8DFFF9F4
                F0FFF6EDE7FFF4EDE7FFF4EDE5FFF4EDE5FFF6F0EAFFF5F0EDFF8D6D5FFFEAE4
                E0FF8B6B5FFFCDC0BAFF8B6B60FFE7DFD9FF765549FC00000008C19D8FFFFAF5
                F2FFF8EFEBFFF6EFE9FFF6F0E9FFF6EFE9FFF8F4EFFFC7B5ADFFAC9388FFEFEA
                E6FFB19E98FF755349FFAC978FFFE9E1DCFFA1887EFF3A2A257AC29E90FFFAF8
                F5FFF8F2EFFFF8F2EFFFF8F2EFFFF6F2EDFFF9F4F2FFB89F94FFB7A095FFA88A
                7FFFD9CDC7FFF6F3F1FFD4C5BEFFA4877AFFB1998EFF675045B6C3A092FFFBF8
                F7FFF8F4F0FFFAF4F0FFFAF4F0FFFAF2F0FFFCF8F5FFF0EAE6FFDFD4CCFFDCD0
                CAFFA48476FFE2D8D2FF9D7B6FFFC4ABA2FF3025215A120E0C21C4A092FFFCFA
                F8FFFBF6F4FFFAF8F4FFFAF8F4FFFAF8F2FFFBF7F3FFFBF6F4FFFBF7F4FFFBF8
                F6FFCDBAB1FFA28273FFCAB7AFFFD8C2BBFF0000000C00000000C4A193FFFFFF
                FEFFFFFFFEFFFFFEFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
                FEFFFFFFFFFFFFFFFFFFFFFFFFFFCCAEA4FF0000000C00000000C68E5CFFECD4
                B4FFDEB182FFDDB180FFE5C29AFFDCAF7FFFDCAE7DFFDBAD7DFFDBAD7CFFDBAD
                7BFFDBAC7AFFDBAC7AFFE7C5A0FFC38956FF0000000B00000000C89260FFEED7
                BBFFE0B888FFE7C8A1FFB37B51FFE7C69FFFDEB584FFDEB483FFDDB382FFDDB0
                81FFDDB180FFDCAF7EFFE9C9A5FFC48B59FF0000000A00000000CA9664FFF0DC
                C1FFEACEABFFB57B53FFB47B53FFB57B52FFECD0ADFFE3C096FFE3BE92FFE2BD
                90FFE1BB8DFFDFB789FFEACFACFFC78F5EFF0000000900000000CC9A68FFF4E4
                CDFFAC6F47FFAB6F47FFAB6E47FFAB6E46FFAA6E46FFE6C69DFFE6C69CFFE6C5
                9BFFE5C39AFFE5C398FFEFD8BBFFC99461FF0000000900000000CF9D6DFFF5E7
                D2FFF5E7D2FFF5E7D1FFF5E7D1FFF5E6D0FFF5E6CFFFF4E6CFFFF4E4CEFFF4E4
                CDFFF4E4CDFFF4E3CBFFF3E2CAFFCB9766FF00000008000000009E7D56C1D6A7
                74FFD5A773FFD5A673FFD5A672FFD4A572FFD4A571FFD3A471FFD3A370FFD2A3
                6FFFD2A26FFFD2A16EFFD1A16EFF9A7751C20000000500000000}
              TabOrder = 28
              TabStop = False
              OnClick = btnGerarWorkSpaceClick
            end
            object edtEmpresaConvenio: TEditFocus
              Tag = 99
              Left = 173
              Top = 347
              Width = 61
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 24
              OnEnter = edtEmpresaConvenioMouseEnter
              OnExit = edtEmpresaConvenioMouseLeave
              OnKeyPress = edtEmpresaConvenioKeyPress
              OnMouseEnter = edtEmpresaConvenioMouseEnter
              OnMouseLeave = edtEmpresaConvenioMouseLeave
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
            object edtDescricaoEmpresaConvenio: TEditFocus
              Left = 235
              Top = 347
              Width = 412
              Height = 19
              TabStop = False
              Alignment = taLeftJustify
              AutoSize = False
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
            object edtCreditDate: TEditFocus
              Tag = 99
              Left = 571
              Top = 287
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
              ParentShowHint = False
              ShowHint = False
              TabOrder = 20
              Text = 'S'
              OnEnter = edtCreditDateMouseEnter
              OnExit = edtCreditDateMouseLeave
              OnMouseEnter = edtCreditDateMouseEnter
              OnMouseLeave = edtCreditDateMouseLeave
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
          end
          object btnValidarDadosAutorizacao: TBitBtnLocked
            Left = 472
            Top = 477
            Width = 161
            Height = 24
            Caption = 'Validar Dados Autoriza'#231#227'o'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000020000
              000A0000000F0000001000000010000000100000001000000011000000110000
              0011000000110000001100000011000000100000000A0000000200000009845E
              4FC1B6836EFFB7826DFFB5816DFFB5806CFFB5806CFFB4806CFFB47E6BFFB47E
              6AFFB37D69FFB37D68FFB27D69FFB27C68FF80584AC20000000A0000000EBC8B
              76FFF8F2EDFFF6EFEBFFF6EEEAFFF6EFEAFFF6EFEAFFF6EEE9FFF6EEE9FFF5EE
              E9FFF6EDE8FFF5EEE8FFF5EDE8FFF6EFEBFFBB8774FF0000000E0000000EBE8D
              79FFF8F3EFFFF5EEE9FFF6EEE9FFF5EEEBFFF4F0ECFFEBE8E5FFEEE9E8FFF5EF
              EAFFF5ECE7FFF4ECE6FFF4EBE6FFF6F0ECFFBD8A76FF0000000F0000000DC08F
              7CFFFAF3F1FFF7EFEAFFF6F0EBFFF2EEECFFCEBDB2FFA36442FFB08C7AFFEBE8
              E5FFF5EEE9FFF5EDE7FFF5ECE7FFF7F1EDFFBD8B78FF0000000E0000000CC291
              7EFFFAF5F3FFF8F1EDFFF5F1EFFFD3C2B8FFB57E59FFE2BD8BFFAB724DFFC7B5
              ABFFF1EDEBFFF5EEE9FFF5EEE9FFF8F3EDFFBF8E7BFF0000000D0000000CC395
              81FFFBF8F4FFF6F3F1FFD9C8BFFFB9845EFFE4C18FFFE6C393FFDCB687FFA36D
              4FFFDDD6D2FFF6F0EDFFF6EFEAFFF9F3EFFFC0907DFF0000000D0000000BC597
              85FFFAF7F5FFE1D1C7FFBE8D6AFFEACCA5FFF1DEBFFFF5E4CAFFEBCCA1FFCEA2
              76FFAB7F6AFFE8E6E3FFF6F2EEFFF9F3F1FFC29380FF0000000C0000000AC69A
              88FFFBF9F7FFDBC5B8FFC99F81FFE4CCB4FFCAA082FFB98463FFEAD5BBFFEBCE
              A4FFC4936BFFB89786FFEEEAE8FFF8F3F0FFC39683FF0000000B0000000AC89D
              8BFFFCFAF8FFFAF7F6FFD9C3B4FFC1957BFFD4BDAFFFDED3CDFFBC8E71FFEBD7
              BEFFEED3ADFFBB8661FFC4AEA2FFF0ECE9FFC49885FF0000000A00000009CAA0
              8EFFFBFAF8FFFCF9F6FFFAF7F6FFF8F5F3FFF9F6F4FFF8F6F4FFE8DFDAFFBC8E
              71FFE5CDB5FFF1DEBDFFBA8562FFE9E6E3FFC59A88FF0000000A00000008CCA3
              91FFFCFBFAFFFCF8F5FFFCF8F5FFFBF7F4FFFBF7F4FFFAF6F5FFFAF7F6FFEBE5
              E1FFC0967BFFC5987AFFD1C3BAFFF1EFECFFC99E8CFF0000000900000007CDA5
              93FFFDFBFAFFFCF9F7FFFCF9F7FFFCF8F6FFFBF9F5FFFBF8F5FFFBF8F5FFFAF8
              F6FFF4F2F1FFEEECEBFFF4F2F0FFFAF7F6FFCBA18FFF0000000800000006CEA7
              96FFFDFBFAFFFEFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFB
              F9FFFCFBFBFFFAF9F8FFFBFAF8FFFCFAF8FFCCA391FF00000007000000049A7E
              71C1CFA998FFCFA898FFCFA997FFCFA997FFCFA897FFCEA796FFCFA796FFCFA8
              96FFCFA796FFCEA696FFCEA794FFCEA694FF987B6FC100000005000000010000
              0004000000050000000600000006000000060000000600000006000000060000
              0006000000060000000600000006000000060000000400000001}
            TabOrder = 1
            TabStop = False
            OnClick = btnValidarDadosAutorizacaoClick
          end
        end
        object tbsComplemento: TcxTabSheet
          Caption = 'Complemento'
          ImageIndex = 2
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlComplemento: TPanel
            Left = 0
            Top = 0
            Width = 661
            Height = 281
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblUsaSac: TLabel
              Left = -5
              Top = 13
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
            object lblUsaSacSN: TColorLabel
              Left = 158
              Top = 13
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblPerImpBol: TLabel
              Left = 391
              Top = 13
              Width = 167
              Height = 17
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Permitir impress'#227'o de boletos?'
              Color = 16770261
              Font.Charset = DEFAULT_CHARSET
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
              WordWrap = True
            end
            object clbPerImpBol: TColorLabel
              Left = 587
              Top = 12
              Width = 54
              Height = 13
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object grpBeneficiario: TGroupBox
              Left = 13
              Top = 38
              Width = 616
              Height = 122
              Caption = 'Dados do Benefici'#225'rio'
              TabOrder = 2
              object lblDesCrr: TLabel
                Left = 72
                Top = 17
                Width = 66
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
              object lblEndBen: TLabel
                Left = 72
                Top = 37
                Width = 66
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
              object lblCompBen: TLabel
                Left = 64
                Top = 57
                Width = 74
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
              object lblBaiBen: TLabel
                Left = 232
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
              object lblCidBen: TLabel
                Left = 88
                Top = 77
                Width = 48
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
              object lblEstBen: TLabel
                Left = 356
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
              object lblCepBen: TLabel
                Left = 431
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
              object lblCNPJBen: TLabel
                Left = 88
                Top = 97
                Width = 50
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
                Left = 140
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
                Left = 140
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
                Left = 140
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
                Left = 401
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
                Left = 140
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
                Left = 401
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
                Left = 467
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
                Left = 140
                Top = 94
                Width = 200
                Height = 21
                EditMask = '>aa\.aaa\.aaa/aaaa-99'
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
              Left = 134
              Top = 10
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
            object edtPerImpBol: TEditFocus
              Tag = 99
              Left = 564
              Top = 10
              Width = 19
              Height = 19
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              MaxLength = 1
              ParentFont = False
              TabOrder = 1
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
        end
        object tbsEncBan: TcxTabSheet
          AllowCloseButton = False
          Caption = 'Encargos Banc'#225'rios'
          ImageIndex = 2
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlAtivo2: TPanel
            Left = 0
            Top = 0
            Width = 661
            Height = 516
            Align = alClient
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object grpTarAux: TcxGroupBox
              AlignWithMargins = True
              Left = 0
              Top = 129
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Align = alTop
              Caption = 'Dados para lan'#231'amento de tarifas banc'#225'rias - Auxiliares '
              Ctl3D = True
              ParentCtl3D = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Style.BorderColor = clNavy
              Style.BorderStyle = ebs3D
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clRed
              Style.Font.Height = -11
              Style.Font.Name = 'Tahoma'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = [fsBold]
              Style.Font.Quality = fqClearType
              Style.LookAndFeel.Kind = lfFlat
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              Style.IsFontAssigned = True
              StyleDisabled.LookAndFeel.Kind = lfFlat
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 1
              Height = 313
              Width = 661
              object grdTarifas: TcxGrid
                Left = 5
                Top = 13
                Width = 634
                Height = 264
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                TabOrder = 0
                TabStop = False
                LookAndFeel.NativeStyle = False
                LookAndFeel.ScrollbarMode = sbmClassic
                LookAndFeel.SkinName = ''
                object grdTarifasDBTableView1: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsCustomize.ColumnGrouping = False
                  OptionsCustomize.ColumnHidingOnGrouping = False
                  OptionsCustomize.ColumnHorzSizing = False
                  OptionsCustomize.ColumnMoving = False
                  OptionsCustomize.ColumnSorting = False
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsSelection.CellSelect = False
                  OptionsSelection.InvertSelect = False
                  OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' dados para mostrar>'
                  OptionsView.GroupByBox = False
                  object grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn
                    Caption = 'Ocorr'#234'ncia'
                    DataBinding.FieldName = 'CNF_CODOCO'
                    PropertiesClassName = 'TcxTextEditProperties'
                    Properties.Alignment.Horz = taCenter
                    HeaderAlignmentHorz = taCenter
                    Width = 97
                  end
                  object grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn
                    Caption = 'Descri'#231#227'o'
                    DataBinding.FieldName = 'CNF_DESOCO'
                    Width = 228
                  end
                  object grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn
                    Caption = 'Gera Contas a Pagar'
                    DataBinding.FieldName = 'CNF_GERPAG'
                    PropertiesClassName = 'TcxCheckBoxProperties'
                    Properties.Alignment = taCenter
                    HeaderAlignmentHorz = taCenter
                    Width = 144
                  end
                  object grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn
                    Caption = 'Custa de Cart'#243'rio'
                    DataBinding.FieldName = 'CNF_CUSCAR'
                    PropertiesClassName = 'TcxCheckBoxProperties'
                    Properties.Alignment = taCenter
                    HeaderAlignmentHorz = taCenter
                    Width = 150
                  end
                  object grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn
                    Caption = 'Fornecedor'
                    DataBinding.FieldName = 'CNF_FORNEC'
                    Width = 265
                  end
                  object grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn
                    Caption = 'Plano de Contas'
                    DataBinding.FieldName = 'CNF_PLNCON'
                    Width = 302
                  end
                  object grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn
                    Caption = 'Portador'
                    DataBinding.FieldName = 'CNF_PORTAD'
                    Width = 339
                  end
                end
                object grdTarifasLevel1: TcxGridLevel
                  GridView = grdTarifasDBTableView1
                end
              end
              object btnAddOco: TBitBtnLocked
                Left = 5
                Top = 283
                Width = 82
                Height = 27
                Caption = 'Adicionar'
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
                TabOrder = 1
              end
              object btnRemOco: TBitBtnLocked
                Left = 173
                Top = 283
                Width = 82
                Height = 27
                Caption = 'Remover'
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
                TabOrder = 3
              end
              object btnEdtOco: TBitBtnLocked
                Left = 89
                Top = 283
                Width = 82
                Height = 27
                Caption = 'Editar'
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
                  00000000000000000000000000000000001F421C11FF30140DEC190A06B30304
                  075F0000001B0000000500000000000000000000000000000000000000000000
                  00000000000000000000000000000000001E663C2BE7B9C7D2FF7889A2FF2441
                  82FF051033AF0000002100000005000000000000000000000000000000000000
                  0002000000090000000E0000000F0000002041261BAE879AB2FFC8E3F5FF1F66
                  B6FF2B6BA8FF051236AD0000001F000000040000000000000000000000000000
                  00088C6657C0C38C7AFFC38C79FFCBA395FFA89894FF488BC3FFDEFEFDFF51B4
                  E3FF1F68B7FF3173AEFF061538AA0000001C0000000400000000000000000000
                  000CC5917EFFFDFBFAFFFCF8F6FFFAF7F5FFECEAE9FF7CA3BFFF479FD2FFDEFE
                  FDFF59BFE9FF216BB9FF367BB3FF07173AA70000001A00000004000000000000
                  000CC79481FFFEFBFAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7EA4BFFF4BA5
                  D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF081A3DA300000018000000000000
                  000BC99786FFFEFCFBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7
                  C2FF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F9E000000000000
                  000ACB9C8BFFFEFDFCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9
                  E7FF85ABC7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
                  0009CFA08DFFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4
                  EFFFEFECE9FF89AECAFF54B1DCFFDEFEFDFF4FA6D4FF102C4E93000000000000
                  0009D0A393FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
                  EFFFFAF6F1FFF3EFEDFF83A0B8FF357FBCFF173A598F0000000C000000000000
                  0008D3A897FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
                  F1FFFBF5F0FFFAF6F3FFE2CCC4FF000000160000000600000001000000000000
                  0007D3AB9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
                  F3FFFCF6F2FFFBF6F1FFD1A494FF0000000C0000000000000000000000000000
                  0006D8AE9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
                  F5FFFBF7F4FFFCF7F3FFD3A897FF0000000B0000000000000000000000000000
                  0006D8B0A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
                  F6FFFBF7F6FFFCF7F5FFD4AC9BFF0000000A0000000000000000000000000000
                  0005D9B3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
                  FEFFFEFEFEFFFEFEFEFFD7AE9EFF000000090000000000000000000000000000
                  0003A3867AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3
                  A2FFD9B2A2FFD8B2A2FFA08377C2000000060000000000000000}
                ParentFont = False
                TabOrder = 2
              end
            end
            object grpTarLiq: TcxGroupBox
              AlignWithMargins = True
              Left = 0
              Top = 5
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Align = alTop
              Caption = 'Dados para lan'#231'amento da tarifa banc'#225'ria - Liquida'#231#227'o '
              Ctl3D = True
              ParentCtl3D = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Style.BorderColor = clNavy
              Style.BorderStyle = ebs3D
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clRed
              Style.Font.Height = -11
              Style.Font.Name = 'Tahoma'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = [fsBold]
              Style.Font.Quality = fqClearType
              Style.LookAndFeel.Kind = lfFlat
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              Style.IsFontAssigned = True
              StyleDisabled.LookAndFeel.Kind = lfFlat
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 0
              Height = 116
              Width = 661
              object Label51: TLabel
                Left = 67
                Top = 42
                Width = 46
                Height = 13
                Alignment = taRightJustify
                Caption = 'Portador:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object Label53: TLabel
                Left = 18
                Top = 22
                Width = 95
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Valor da Tarifa:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object Label54: TLabel
                Left = 54
                Top = 82
                Width = 59
                Height = 13
                Alignment = taRightJustify
                Caption = 'Fornecedor:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
              end
              object edtDesPorTar: TEditFocus
                Left = 177
                Top = 39
                Width = 395
                Height = 19
                TabStop = False
                Alignment = taLeftJustify
                AutoSize = False
                Color = 16768952
                Enabled = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
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
              object edtPorTar: TEditFocus
                Tag = 99
                Left = 115
                Top = 39
                Width = 61
                Height = 19
                Alignment = taLeftJustify
                AutoSize = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                MaxLength = 5
                ParentFont = False
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtValorTarifa: TEditFocus
                Tag = 99
                Left = 115
                Top = 19
                Width = 61
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
                MaxLength = 5
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesForTar: TEditFocus
                Left = 177
                Top = 79
                Width = 395
                Height = 19
                TabStop = False
                Alignment = taLeftJustify
                AutoSize = False
                Color = 16768952
                Enabled = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
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
              object edtForTar: TEditFocus
                Tag = 99
                Left = 115
                Top = 79
                Width = 61
                Height = 19
                Alignment = taLeftJustify
                AutoSize = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                MaxLength = 8
                ParentFont = False
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 8
                TipoTexto = ttNumerico
              end
              inline fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit
                Left = 4
                Top = 59
                Width = 577
                Height = 19
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                TabOrder = 2
                ExplicitLeft = 4
                ExplicitTop = 59
                ExplicitWidth = 577
                ExplicitHeight = 19
                inherited lblPlaContas: TLabel
                  Left = 1
                  Width = 108
                  Caption = 'Plano de Conta Tarifa:'
                  ExplicitLeft = 1
                  ExplicitWidth = 108
                end
                inherited edtDesCta: TEditFocus
                  Left = 173
                  Width = 395
                  ExplicitLeft = 173
                  ExplicitWidth = 395
                end
                inherited MskCodCta: TMaskEdit
                  Left = 111
                  Width = 61
                  ExplicitLeft = 111
                  ExplicitWidth = 61
                end
              end
            end
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 800
    Top = 688
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpRightTop
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
    Left = 616
  end
end
