inherited frmCadLocFisSelecao: TfrmCadLocFisSelecao
  Width = 767
  Height = 595
  Caption = 'Sele'#231#227'o de Localiza'#231#227'o F'#237'sica'
  OnDestroy = FormDestroy
  ExplicitWidth = 767
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 524
    Width = 761
    TabOrder = 1
    ExplicitTop = 524
    ExplicitWidth = 761
    inherited FlwBotoes: TFlowPanel
      Width = 680
      ExplicitWidth = 680
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Align = alLeft
        Enabled = False
        ModalResult = 0
        ExplicitWidth = 113
      end
      object btnMarcar: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 120
        Height = 22
        Align = alLeft
        Caption = '&Marcar Todos'
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
        Tag = 1
        Left = 233
        Top = 0
        Width = 120
        Height = 22
        Align = alLeft
        Caption = '&Desmarcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000011510
          4884271E8BFF130F458600000007110D4387221882FF110C4188000000000000
          0000000000000000000000000000000000000000000000000000000000023028
          99FF7286E3FF3E44B5FF20196EC5383EB1FF6576DEFF261C89FF000000000000
          0000000000000000000100000004000000060000000600000006000000071B18
          5184676CC8FF687CDFFF4C5ACBFF6073DDFF5C60C0FF16114884000000000000
          000000000000000000037E5D52BBAF8272FFAE8171FFAE8172FFC3A095FFD4BE
          B7FF4C4495FF4F60C9FF6C81E3FF4757C2FF0C0A53C300000007000000000000
          00000000000000000005B28677FFFFFFFFFFFBF8F6FFFBF8F6FFFDFCFAFF918F
          CBFF4956BFFF879CEBFF7F8CD6FF7F95E8FF3A44AEFF08073C86000000000000
          00000000000000000005B68B7BFFFFFFFFFFF7F3EFFFF8F3EFFFFCF9F7FF4E4F
          C7FFC5D7FAFF8790DEFF6B65BDFF858DDBFFC5D7FAFF433FB7FF000000000000
          00000000000000000004B99080FFFFFFFFFFF8F4F1FFF8F3F1FFFCFAF8FFA8A8
          E3FF5354CDFFA7A7E2FFD9C4BDFF272762834C4CC4FF25245F82B6703DFF120B
          06220000000200000004BC9586FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFCAACA0FF000000050000000200000001B87340FFBC7A
          49FF120B062200000002998075BFCEAC9DFFCDAB9CFFCCAA9BFFCBA99AFFCAA7
          98FFC9A697FFC8A596FF94786EC0000000030000000000000000BA7644FFCD90
          5CFFBD7A48FF0000000200000006000000090000000900000009000000090000
          0009000000090000000900000006000000020000000000000000BB7946FFBF7F
          4EFF130C072200000003846459BBB88C7BFFB78B7AFFB78B7BFFB78A7AFFB68A
          79FFB68979FFB68979FF836357BB000000040000000000000000BD7B49FF130C
          07220000000200000005BB9081FFFFFFFFFFFBF8F6FFFBF8F6FFFBF8F5FFFAF7
          F5FFFAF7F5FFFAF6F5FFB98D7CFF000000060000000000000000000000000000
          00000000000000000005BF9585FFFFFFFFFFF7F3EFFFF8F3EFFFF8F2EFFFF7F2
          EEFFF8F2EFFFFBF8F6FFBC9182FF000000050000000000000000000000000000
          00000000000000000004C29A8AFFFFFFFFFFF8F4F1FFF8F3F1FFF8F4F1FFF8F3
          F0FFF8F3F0FFFCFAF8FFBF9686FF000000050000000000000000000000000000
          00000000000000000004C59F90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC29B8BFF000000040000000000000000000000000000
          000000000000000000029A8176BFCFAD9EFFCEAD9EFFCEAC9DFFCDAC9DFFCDAB
          9BFFCCAA9BFFCBA99AFF977C72C0000000030000000000000000}
        TabOrder = 2
        OnClick = btnMarcarClick
      end
      object btnInverter: TBitBtnLocked
        Tag = 2
        Left = 353
        Top = 0
        Width = 120
        Height = 22
        Align = alLeft
        Caption = '&Inverter Sele'#231#227'o'
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
        TabOrder = 3
        OnClick = btnMarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 682
      Top = 2
      Align = alRight
      ExplicitLeft = 682
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 550
    Width = 761
    TabOrder = 2
    ExplicitTop = 550
    ExplicitWidth = 761
    inherited pnlNomeForm: TPanel
      Left = 590
      ExplicitLeft = 590
    end
    inherited pnlInfo: TPanel
      Width = 590
      ExplicitWidth = 590
    end
  end
  object pnlTop: TPanel [2]
    Left = 0
    Top = 0
    Width = 761
    Height = 151
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label9: TLabel
      Left = 61
      Top = 54
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rua:'
    end
    object Label10: TLabel
      Left = 50
      Top = 77
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233'dio:'
    end
    object Label11: TLabel
      Left = 50
      Top = 100
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Andar:'
    end
    object Label12: TLabel
      Left = 18
      Top = 124
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Apartamento:'
    end
    object Label13: TLabel
      Left = 3
      Top = 31
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. Separa'#231#227'o:'
    end
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 761
      Height = 20
      Align = alTop
      AutoSize = False
      Caption = '   Filtros'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 793
    end
    object topLine: TBevel
      Left = 0
      Top = 20
      Width = 761
      Height = 4
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 793
    end
    object Label2: TLabel
      Left = 137
      Top = 100
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label3: TLabel
      Left = 137
      Top = 124
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label4: TLabel
      Left = 137
      Top = 54
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label5: TLabel
      Left = 137
      Top = 77
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label6: TLabel
      Left = 331
      Top = 124
      Width = 400
      Height = 14
      Caption = 
        '* N'#227'o informando o intervalo completo, ser'#225' considerado apenas o' +
        ' que foi digitado.'
    end
    object Label7: TLabel
      Left = 399
      Top = 31
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. F'#237'sica:'
    end
    object edtRuaIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 51
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 74
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 97
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 120
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLse: TEditFocus
      Tag = 99
      Left = 84
      Top = 28
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodLseExit
      OnKeyPress = edtCodLseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesLse: TEditFocus
      Left = 131
      Top = 28
      Width = 262
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
    object edtRuaFin: TEditFocus
      Tag = 99
      Left = 158
      Top = 51
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioFin: TEditFocus
      Tag = 99
      Left = 158
      Top = 74
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarFin: TEditFocus
      Tag = 99
      Left = 158
      Top = 97
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoFin: TEditFocus
      Tag = 99
      Left = 158
      Top = 120
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnBuscar: TBitBtnLocked
      Left = 211
      Top = 120
      Width = 114
      Height = 25
      Caption = 'Buscar'
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
        7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
        88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
        C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
        87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
        F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
        A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
        FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
        A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
        F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
        92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
        D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
        6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
        A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
        84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
        4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
        F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
        020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
        A2FC62504B900404031000000002000000000000000000000000000000000000
        000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
        1F3E000000060000000100000000000000000000000000000000}
      TabOrder = 13
      OnClick = btnBuscarClick
    end
    object rdgAssociacaoClasse: TRadioGroup
      Tag = 99
      Left = 211
      Top = 72
      Width = 292
      Height = 40
      Caption = 'Apresentar Localiza'#231#245'es j'#225' associadas a uma Classe?'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 12
    end
    object edtCodLoc: TEditFocus
      Tag = 99
      Left = 460
      Top = 28
      Width = 93
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 2
      OnExit = edtCodLocExit
      OnKeyPress = edtCodLocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtDesLoc: TEditFocus
      Left = 559
      Top = 28
      Width = 194
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
  object cxgLocFis: TcxGridCitel [3]
    Left = 0
    Top = 151
    Width = 761
    Height = 373
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLocFisTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgLocFisTableViewMarca: TcxGridDBColumn
        Caption = '  '
        DataBinding.FieldName = 'MARCA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 25
      end
      object cxgLocFisTableViewCodigo: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'CODLOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 105
      end
      object cxgLocFisTableViewDescricao: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Options.Focusing = False
        Width = 164
      end
      object cxgLocFisTableViewAltura: TcxGridDBColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'ALTURA'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgLocFisTableViewLargura: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'LARGUR'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgLocFisTableViewProdundidade: TcxGridDBColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'PROFUN'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgLocFisTableViewCapacidade: TcxGridDBColumn
        Caption = 'Cap. M'#225'x.'
        DataBinding.FieldName = 'CAPACI'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgLocFisTableViewPeso: TcxGridDBColumn
        Caption = 'Peso M'#225'x.'
        DataBinding.FieldName = 'PESMAX'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgLocFisTableViewPickin: TcxGridDBColumn
        Caption = 'Picking'
        DataBinding.FieldName = 'PICKIN'
        OnGetDataText = cxgLocFisTableViewPickinGetDataText
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
    end
    object cxgLocFisLevel: TcxGridLevel
      GridView = cxgLocFisTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 340
    Top = 296
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 296
  end
end
