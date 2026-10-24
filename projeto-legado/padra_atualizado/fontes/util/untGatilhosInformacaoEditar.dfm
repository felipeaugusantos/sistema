inherited frmGatilhosInformacaoEditar: TfrmGatilhosInformacaoEditar
  Left = 299
  Top = 188
  Width = 758
  Height = 641
  BorderStyle = bsDialog
  Caption = 'Gatilho de Informa'#231#227'o - Edi'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 758
  ExplicitHeight = 641
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 570
    Width = 752
    Height = 26
    ExplicitTop = 526
    ExplicitWidth = 752
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 594
      Height = 22
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 594
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 673
      Top = 2
      Align = alRight
      ExplicitLeft = 673
      ExplicitTop = 2
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
      Caption = '&Confirmar'
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
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 596
    Width = 752
    ExplicitTop = 552
    ExplicitWidth = 752
    inherited pnlNomeForm: TPanel
      Left = 581
      ExplicitLeft = 581
    end
    inherited pnlInfo: TPanel
      Width = 581
      ExplicitWidth = 581
    end
  end
  object pnlEditarGatilho: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 746
    Height = 564
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 520
    object lbl6: TLabel
      Left = 44
      Top = 21
      Width = 87
      Height = 14
      Hint = 'Saldo Dispon'#237'vel'
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Gatilho:'
      ParentShowHint = False
      ShowHint = True
    end
    object Label5: TLabel
      Left = 208
      Top = 21
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object Label8: TLabel
      Left = 406
      Top = 21
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtCodigo: TEditFocus
      Tag = 99
      Left = 133
      Top = 15
      Width = 55
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object cmbStatus: TComboBoxFocus
      Tag = 99
      Left = 245
      Top = 15
      Width = 136
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 0
      TabOrder = 1
      Text = 'Ativo'
      Items.Strings = (
        'Ativo'
        'Inativo')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object GroupBox1: TGroupBox
      Left = 20
      Top = 56
      Width = 709
      Height = 201
      Caption = 'Periodicidade do envio:'
      TabOrder = 3
      object Label6: TLabel
        Left = 37
        Top = 29
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quando enviar:'
      end
      object Label7: TLabel
        Left = 30
        Top = 55
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dias da Semana:'
      end
      object Label4: TLabel
        Left = 40
        Top = 168
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hora marcada:'
      end
      object Label2: TLabel
        Left = 49
        Top = 79
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dias da m'#234's:'
      end
      object cmbQuandoEnviar: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 23
        Width = 248
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        TabOrder = 0
        Text = 'TODA SEMANA'
        OnChange = cmbQuandoEnviarChange
        Items.Strings = (
          'TODA SEMANA'
          'DIAS FIXOS')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object chkDiasSemana: TCheckListBox
        Tag = 99
        Left = 113
        Top = 49
        Width = 557
        Height = 20
        Columns = 7
        ItemHeight = 14
        Items.Strings = (
          'Domingo'
          'Segunda'
          'Ter'#231'a'
          'Quarta'
          'Quinta'
          'Sexta'
          'S'#225'bado')
        TabOrder = 1
      end
      object edtHoraEnvio: TMaskEditFocus
        Tag = 99
        Left = 113
        Top = 162
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        EditMask = '99:99;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object chkEnviarFeriados: TCheckBox
        Tag = 99
        AlignWithMargins = True
        Left = 225
        Top = 168
        Width = 127
        Height = 14
        Margins.Left = 66
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = ' Enviar em Feriados'
        TabOrder = 4
      end
      object chkDiasMes: TCheckListBox
        Tag = 99
        Left = 113
        Top = 73
        Width = 557
        Height = 86
        Columns = 7
        ItemHeight = 14
        Items.Strings = (
          '01'
          '02'
          '03'
          '04'
          '05'
          '06'
          '07'
          '08'
          '09'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16'
          '17'
          '18'
          '19'
          '20'
          '21'
          '22'
          '23'
          '24'
          '25'
          '26'
          '27'
          '28'
          '29'
          '30'
          '31')
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 268
      Width = 709
      Height = 106
      Caption = 'Operador de destino:'
      TabOrder = 4
      object Label3: TLabel
        Left = 62
        Top = 28
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador:'
      end
      object lblWhatsApp: TLabel
        Left = 194
        Top = 53
        Width = 81
        Height = 14
        Cursor = crHandPoint
        Caption = '(16) 99999-9999'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        StyleElements = [seClient, seBorder]
        OnClick = lblWhatsAppClick
      end
      object lblEmail: TLabel
        Left = 194
        Top = 75
        Width = 130
        Height = 14
        Cursor = crHandPoint
        Caption = 'citel@citelsoftware.com.br'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        StyleElements = [seClient, seBorder]
        OnClick = lblEmailClick
      end
      object edtNomOpe: TEditFocus
        Left = 170
        Top = 22
        Width = 500
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 113
        Top = 22
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        OnKeyPress = edtCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object chkWhatsApp: TCheckBox
        Tag = 99
        AlignWithMargins = True
        Left = 113
        Top = 53
        Width = 75
        Height = 14
        Margins.Left = 66
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = ' WhatsApp'
        TabOrder = 1
      end
      object chkEmail: TCheckBox
        Tag = 99
        AlignWithMargins = True
        Left = 113
        Top = 75
        Width = 48
        Height = 14
        Margins.Left = 66
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = ' Email'
        TabOrder = 2
      end
    end
    object GroupBox3: TGroupBox
      Left = 20
      Top = 380
      Width = 709
      Height = 175
      Caption = 'Dados do Relat'#243'rio:'
      TabOrder = 5
      object Label1: TLabel
        Left = 66
        Top = 26
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Relat'#243'rio:'
      end
      object lblMotEntFut: TLabel
        Left = 72
        Top = 53
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
      end
      object lblLocalizar: TLabel
        Left = 83
        Top = 81
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'T'#237'tulo:'
      end
      object Label9: TLabel
        Left = 77
        Top = 105
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Status:'
      end
      object Label10: TLabel
        Left = 406
        Top = 105
        Width = 23
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo:'
      end
      object btnConfigurarFiltros: TcxButton
        Left = 112
        Top = 137
        Width = 180
        Height = 24
        Caption = 'Configurar Filtros do Relat'#243'rio'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000049331E65B6804CFC402D1B5900000000000000000000
          0000000000000000000000000000000000000000000000000000000000003425
          1648795633A8291D1139896139BEB8824DFF875F38BB2D20133E7E5935AF3525
          1649000000000000000000000000000000000000000000000000000000007E59
          35AEB8824DFFB7814DFEB8824DFFB8824DFFB8824DFFB7814DFEB8824DFF7955
          32A7000000000000000000000000000000000000000000000000000000002D20
          133FB7814CFDB7814DFE7251309E3F2C1A577251309EB7814DFEB7814CFD2A1E
          123A000000000000000000000000000000000000000000000000412E1B5A865F
          38BAB8824DFF6E4D2E980000000000000000000000006E4D2E98B8824DFF8A61
          3ABF49331E650000000000000000000000000000000001010001B47F4BF9B882
          4DFFB8824DFF402D1B59000000000000000000000000402D1B59B8824DFFB882
          4DFFB47F4BF90000000000000000000000000000000000000000432F1C5D8860
          39BCB8824DFF6E4D2E980000000000000000000000006E4D2E98B8824DFF855E
          38B8402D1B590000000000000000000000000000000000000000000000002A1E
          123AB7814CFDB7814DFE7251309E3F2C1A577251309EB7814DFEB7814DFE2E21
          1340000000000000000000000000000000000000000000000000000000007754
          32A5B8824DFFB7814CFDB8824DFFB8824DFFB8824DFFB7814CFDB8824DFF805B
          36B2000000003827184D00000000000000000000000000000000000000003425
          16487F5A35B02D20133E875F38BBB8824DFF886039BC291D1139765432A45C41
          27805C412780B8824EFF5C4127803827184D0000000000000000000000000000
          00000000000000000000412E1B5AB47F4BFA47321E6300000000000000005C41
          2780B8824EFF855E38B8B8824EFF5C4127800000000000000000000000000000
          00000000000000000000000000000000000000000000000000003827184DB882
          4EFF855E38B800000000855E38B8B8824EFF3827184D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000005C41
          2780B8824EFF855E38B8B8824EFF5C4127800000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000003827
          184D5C412780B8824EFF5C4127803827184D0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003827184D000000000000000000000000}
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        TabOrder = 6
        OnClick = btnConfigurarFiltrosClick
      end
      object btnEmailTeste: TcxButton
        Left = 302
        Top = 137
        Width = 180
        Height = 24
        Caption = 'Enviar email de teste'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000E744558745469746C65004D61696C3B4E6577A171F84B0000021F49
          444154785EA5934D48545D18809FF736A8D834431A9846660B89B285156411FD
          4C5614DA2290B00F5C652099D6A255C1884AB592C08A68119441D8CE0F246931
          9416811406C5D4486205E9989160E2CFBDF774DF602E17C5451B1F7839CFD93C
          BC8B7344555909162B441EF47C02155045F1F14DA818AECBB8AA2280AAC68136
          55E2A8B6291032C6A3BEA64C00591E5FEE432DDB5B3DA552D003AAB4E18791BB
          8FDF271062A8A202A83F8AB2A1204CD1C413483E6267633B3363A3840B8B797B
          3B4E2602589D5DEFD4768CFE8B0F77CEE8AF44932EBC69D6C9FF6B75A0B924D1
          7F711321401CC7F0F4C5307B7714138DE4E2795EB035960863CF3AF8997C49E9
          FE7AA6478688E645706CFBB0423C13B05D97A2C228F7BB07A9AADCCAB6D2F538
          C603605548C8D97D0E275A4D7FE721A4A09C3FE9D700A28ABF816B1B7273B3A9
          3CB885DE448A642A4D4D7539283CEC7E45EACB144D67634CC52E305552C7CCAD
          F21B59210151FC0D1CC3F4ACC3F8F82CD547CAF83CFA83CBED3DA4C726A93ABE
          8BFF4E55F0F5FB6FF2F79C6764F01B0DDDD3D77A6AD7002C06EC39C3B17D9B41
          8448389B757961003616E591BF76358A32F47182E4F02480000492D3D8D237DF
          71E528B6F1100565115D22D95916975AFBB877FD64445567820D701D8308842C
          2B788504E0F909B504015CD7232008780B0BF3CF1BAEF6C6347840A2088A7FCF
          1801AE3D370098A501D375F3F409DF117F203897B90206B0F161C5DFF92F5E25
          157110505FC30000000049454E44AE426082}
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        TabOrder = 7
        OnClick = btnEmailTesteClick
      end
      object btnWhatsAppTeste: TcxButton
        Left = 490
        Top = 137
        Width = 180
        Height = 24
        Caption = 'Enviar whatsapp de teste'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
          530000000467414D410000B18F0BFC6105000000206348524D00007A26000080
          840000FA00000080E8000075300000EA6000003A98000017709CBA513C000002
          85504C5445EDEDEDFEFEFEFDFDFDFFFFFFEFEFEFFBFBFBEEEEEEF0F0F0F1F1F1
          ECECECE0E0E0F7F8F7FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
          FFF9FAF9FBFBFBFFFFFFFCFEFCFAFEFAFFFFFFFBFBFBF9F9F9FFFEFFFFFFFFFA
          FAFAE7E7E7FFFDFFFFFEFFF1F1F1FBFAFAFDFEFDFBFDFBFBFBFBFFFDFFFFFDFF
          FFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFDFFFFFDFFFBF9FBFCFAFBF3F3
          F3FEFDFDF3F3F3FAFAFAFEFEFEF8F7F8BCBCBCFEFDFEF3FBF4F7FBF8F9F8F9E8
          E9E8FDFDFDF6FBF7FEFDFDFFFDFFF1F9F2FEFCFDF7F6F6E6E7E6F8F8F8F8F8F8
          F6F5F6F0F0F0EEEEEEF6F5F6FCF9FCFEFBFEFEFBFEFCFAFCF7F6F7DAF5DDB0EA
          B598E39FADE9B3D7F4D9EDFAEE9AE3A261D36C55D06154D0605FD36B94E19CE9
          F9EAEEFAEF83DC8C50CD5D55CF6152CE5F7CDA86E9F9EB9DE3A54CCB5A89DD93
          C4EEC967D3734DCB5B4ECB5C93E09CE1F6E35BCE6954CC62DAF4DDFFFFFF9FE3
          A748C8574AC95949C95857CD64D9F4DCB9EABF45C65554CB62DEF5E1A6E4AD46
          C65646C75644C654AFE7B6A2E2AA3FC35042C453A7E4AFFBFEFB7CD6873EC34F
          42C45241C45240C3513FC34F97DFA0A5E2AD3BC14D3CC14E53C862D5F2D9D8F3
          DB5ECC6C39C04B49C55A59CA683FC2503DC14F3BC14C99DFA2C1EBC73DC04F39
          BF4C37BE4A62CC71DFF4E2E2F6E48BDA96B1E6B8EAF8ECA4E2AC43C255B6E8BD
          5AC96933BC4735BD4859C869BFEAC5F5FCF6D6F1DA42C15550C561E4F6E798DD
          A22FB94331BA4538BD4C64CB7397DCA29FDFA95AC86A33BB47A5E1AD80D48D27
          B53C2BB7412AB7402CB7412AB73F28B63D2FB8448BD897F6FBF782D48F89D795
          9FDEA95CC76D33B9482AB54029B53F32B84757C568AFE4B7FDFEFDCEEED3B4E5
          BCB3E5BBCCEDD1EFF9F0D58BAB870000005274524E5300000000000000000000
          000445A5E3FBFCE5AB4C06148DEDF0971A13AAB61A038998063FEAF14E9BADD8
          E6F1FCEFFBD2E190A036EA3F2AE2830263FAFE9E0FA9FCE7E5FEE27A0EC6AE6B
          323182C4E2E3C788B6487A6D00000001624B474403110C4CF200000009704859
          73000014C3000014C30115704D420000000774494D4507E60A11142219762A9F
          280000011B4944415418D3011001EFFE000001020B0C0D0E0F10111213140203
          0400020215161752535454555618191A020300051B1C5758595A5B5B5A5C5D5E
          1D1E05001F205F60616263636363636164652122002324666768696A6B6C6C6C
          6C676D252600276E6F707172737475757575767778280029797A7B7C727D7A7E
          7F7F7F7F80812A002B82838485868788898A8B89898C8D2C002D8E8F90919293
          9495969798999A9B2E002F9C9D9E9FA0A1A2A3A4A5A6A79EA8300031A5A9AAAB
          AAACADAE7272AFB0B1B23200332AB3B4B5B5B4B6B7B8B9BABBBC3435003637BD
          BEBFC0C1C1C2C2C3C4C5C63839003A3BC7C8C9CACBCCCDCECFD03C3D3E06003F
          D140414243D2D3D4D5D64445460708004748494A4B4C4D4E4F50514B0309040A
          D48F69A2B3084A4B0000002574455874646174653A6372656174650032303232
          2D31302D31375432303A33333A34332B30303A30301BEDAACA00000025744558
          74646174653A6D6F6469667900323032322D31302D31375432303A33333A3433
          2B30303A30306AB012760000001974455874536F667477617265007777772E69
          6E6B73636170652E6F72679BEE3C1A0000000049454E44AE426082}
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        TabOrder = 8
        OnClick = btnWhatsAppTesteClick
      end
      object edtCodRel: TEditFocus
        Tag = 99
        Left = 113
        Top = 22
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        OnKeyPress = edtCodRelKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtNomRel: TEditFocus
        Left = 169
        Top = 22
        Width = 501
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object cmbPeriodo: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 47
        Width = 239
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        Items.Strings = (
          'Falta Produto'
          'Aguardando Cliente'
          'Previs'#227'o de Entrega')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtDescricao: TEditFocus
        Tag = 99
        Left = 113
        Top = 73
        Width = 239
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbRelatorioStatus: TComboBoxFocus
        Tag = 99
        Left = 113
        Top = 99
        Width = 239
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbRelatorioTipo: TComboBoxFocus
        Tag = 99
        Left = 431
        Top = 99
        Width = 239
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 453
      Top = 15
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 493
      Top = 15
      Width = 197
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 8
  end
end
