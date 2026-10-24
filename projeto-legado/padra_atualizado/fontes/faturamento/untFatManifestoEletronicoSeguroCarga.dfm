inherited frmFatManifestoEletronicoSeguroCarga: TfrmFatManifestoEletronicoSeguroCarga
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Manifesto Eletr'#244'nico - Seguro da Carga'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Pitch = fpDefault
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Left = 95
      Width = 604
      TabOrder = 2
      ExplicitLeft = 95
      ExplicitWidth = 604
    end
    inherited btnSair: TBitBtnLocked
      Left = 699
      Top = 2
      Width = 93
      Height = 24
      Align = alRight
      ExplicitLeft = 699
      ExplicitTop = 2
      ExplicitWidth = 93
      ExplicitHeight = 24
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 93
      Height = 24
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
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object pnlSeguroCarga: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 527
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pgcSegCar: TPageControl
      Left = 0
      Top = 0
      Width = 794
      Height = 527
      ActivePage = tbsInformacoesDoPagamentoDoFrete
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      object tbsSeguroCarga: TTabSheet
        Caption = 'Seguro da Carga'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 8
          Top = 87
          Width = 101
          Height = 13
          Caption = 'Nome da Seguradora'
        end
        object Label2: TLabel
          Left = 272
          Top = 87
          Width = 154
          Height = 13
          Caption = 'N'#250'mero do CNPJ da Seguradora'
        end
        object Label3: TLabel
          Left = 536
          Top = 87
          Width = 89
          Height = 13
          Caption = 'N'#250'mero da Ap'#243'lice'
        end
        object Label4: TLabel
          Left = 486
          Top = 39
          Width = 120
          Height = 13
          Caption = 'Respons'#225'vel pelo seguro'
        end
        object Label9: TLabel
          Left = 406
          Top = 59
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = '1-CNPJ / 2-CPF:'
        end
        object edtNomeSeguradora: TEditFocus
          Tag = 99
          Left = 8
          Top = 104
          Width = 249
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 30
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object rdgRespSeg: TRadioGroup
          Left = 8
          Top = 17
          Width = 388
          Height = 60
          Caption = 'Respons'#225'vel pelo Seguro'
          ItemIndex = 0
          Items.Strings = (
            '1 - Emitente do MDF-e'
            
              '2 - Respons'#225'vel pela contrata'#231#227'o do servi'#231'o de transporte (contr' +
              'atante)')
          TabOrder = 0
        end
        object dbgSegCar: TDBGridCitel
          Left = 0
          Top = 151
          Width = 786
          Height = 345
          Align = alBottom
          DataSource = dtsSegCar
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 7
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyDown = dbgSegCarKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'MDF_SEQUEN'
              Title.Caption = 'Sequencial'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_RESSEG'
              Title.Caption = 'Respons'#225'vel pelo Seguro'
              Width = 132
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_RESCPF'
              Title.Caption = 'CPF/CNPJ do Respons'#225'vel pelo seguro'
              Width = 201
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_NOMSEG'
              Title.Caption = 'Nome da Seguradora'
              Width = 124
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_SEGCNP'
              Title.Caption = 'CNPJ Seguradora'
              Width = 114
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_NUMAPO'
              Title.Caption = 'N'#250'mero da Ap'#243'lice'
              Width = 101
              Visible = True
            end>
        end
        object edtNumApolice: TEditFocus
          Tag = 99
          Left = 536
          Top = 104
          Width = 188
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 20
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object btnAddSegCar: TBitBtnLocked
          Left = 740
          Top = 102
          Width = 35
          Height = 23
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            000000000002000000090000000E0000000F0000000F00000010000000100000
            0010000000100000000F0000000A000000020000000000000000000000000000
            0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
            4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
            000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
            9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
            00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
            7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
            000000000000000000010000000200000002000000030B20176D0A1B136F0000
            0004000000030000000200000002000000000000000000000000000000000000
            000000000000000000000000000000000003040C092E21664AF41C583FF6030A
            072F000000030000000000000000000000000000000000000000000000000000
            00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
            2BCD0001010D0000000100000000000000000000000000000000000000000000
            000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
            6AFF0E291D8B0000000600000001000000000000000000000000000000000000
            00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
            9DFF256F53FD07140E4700000003000000000000000000000000000000000000
            00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
            A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
            0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
            BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
            0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
            DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
            000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
            E6FF3B9878FF0000000900000004000000010000000000000000000000000000
            000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
            F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
            0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
            8EFF2E8166B90000000200000000000000000000000000000000000000000000
            0000000000000000000000000000000000010000000200000002000000020000
            0002000000020000000000000000000000000000000000000000}
          TabOrder = 6
          OnClick = btnAddSegCarClick
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 486
          Top = 56
          Width = 38
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 1
          Text = '2'
          OnChange = edtCgcCpfChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object mskRespCpfCnp: TMaskEditC_G_C_
          Tag = 99
          Left = 528
          Top = 56
          Width = 136
          Height = 21
          EditMask = '999.999.999-99;0;'
          MaxLength = 14
          TabOrder = 2
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskCnpSeguradora: TMaskEditC_G_C_
          Tag = 99
          Left = 272
          Top = 104
          Width = 249
          Height = 21
          EditMask = '99.999.999/9999-99;0;'
          MaxLength = 18
          TabOrder = 4
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
          strCgcCpf = '1'
        end
      end
      object tbsSeguroCargaAverbacao: TTabSheet
        Caption = 'Seguro da Carga - Averba'#231#227'o'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label5: TLabel
          Left = 8
          Top = 7
          Width = 107
          Height = 13
          Caption = 'N'#250'mero da Averba'#231#227'o'
        end
        object dbgAverb: TDBGridCitel
          Left = 0
          Top = 73
          Width = 786
          Height = 423
          Align = alBottom
          DataSource = dtsSegCarAver
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyDown = dbgAverbKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'MDF_SEQUEN'
              Title.Caption = 'Sequencial'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MDF_NUMAVE'
              Title.Caption = 'N'#250'mero da Averba'#231#227'o'
              Width = 236
              Visible = True
            end>
        end
        object edtNumAverb: TEditFocus
          Left = 8
          Top = 24
          Width = 304
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 40
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 40
          TipoTexto = ttAlfanumerico
        end
        object btnAddAverba: TBitBtnLocked
          Left = 318
          Top = 23
          Width = 35
          Height = 23
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            000000000002000000090000000E0000000F0000000F00000010000000100000
            0010000000100000000F0000000A000000020000000000000000000000000000
            0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
            4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
            000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
            9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
            00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
            7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
            000000000000000000010000000200000002000000030B20176D0A1B136F0000
            0004000000030000000200000002000000000000000000000000000000000000
            000000000000000000000000000000000003040C092E21664AF41C583FF6030A
            072F000000030000000000000000000000000000000000000000000000000000
            00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
            2BCD0001010D0000000100000000000000000000000000000000000000000000
            000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
            6AFF0E291D8B0000000600000001000000000000000000000000000000000000
            00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
            9DFF256F53FD07140E4700000003000000000000000000000000000000000000
            00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
            A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
            0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
            BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
            0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
            DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
            000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
            E6FF3B9878FF0000000900000004000000010000000000000000000000000000
            000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
            F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
            0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
            8EFF2E8166B90000000200000000000000000000000000000000000000000000
            0000000000000000000000000000000000010000000200000002000000020000
            0002000000020000000000000000000000000000000000000000}
          TabOrder = 1
          OnClick = btnAddAverbaClick
        end
      end
      object tbsProprietarioVeiculo: TTabSheet
        Caption = 'Propriet'#225'rio do Ve'#237'culo'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object bevelSeparador: TBevel
          Left = 295
          Top = 134
          Width = 438
          Height = 193
        end
        object lblCNPJ_CPFProprietario: TLabel
          Left = 350
          Top = 165
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = '1-CNPJ / 2-CPF:'
        end
        object lblRNTRC: TLabel
          Left = 390
          Top = 189
          Width = 38
          Height = 13
          Caption = 'RNTRC:'
        end
        object lblNomeRazaoSocialProprietario: TLabel
          Left = 319
          Top = 213
          Width = 109
          Height = 13
          Caption = 'Nome ou Raz'#227'o Social:'
        end
        object lblIEProprietario: TLabel
          Left = 337
          Top = 238
          Width = 91
          Height = 13
          Alignment = taRightJustify
          Caption = 'Inscri'#231#227'o Estadual:'
        end
        object lblUFProprietario: TLabel
          Left = 411
          Top = 261
          Width = 17
          Height = 13
          Caption = 'UF:'
        end
        object lblTipoProprietario: TLabel
          Left = 330
          Top = 281
          Width = 97
          Height = 26
          Caption = 'Tipo de Propriet'#225'rio ou possuidor:'
          WordWrap = True
        end
        object Label6: TLabel
          Left = 24
          Top = 212
          Width = 247
          Height = 26
          Alignment = taCenter
          Caption = 
            '* Informar apenas quando o ve'#237'culo n'#227'o pertencer ao emitente do ' +
            'MDF-e (Informar todos os campos).'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object edtCNPJ_CPFProprietario: TEditFocus
          Tag = 99
          Left = 433
          Top = 161
          Width = 38
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          Text = '2'
          OnChange = edtCNPJ_CPFProprietarioChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object mskCNPJ_CPFProprietario: TMaskEditC_G_C_
          Tag = 99
          Left = 474
          Top = 161
          Width = 136
          Height = 21
          EditMask = '999.999.999-99;0;'
          MaxLength = 14
          TabOrder = 1
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtRNTRC: TEditFocus
          Tag = 99
          Left = 433
          Top = 185
          Width = 60
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttInteiro
        end
        object edtNomeRazaoSocialProprietario: TEditFocus
          Left = 433
          Top = 210
          Width = 254
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 60
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 60
          TipoTexto = ttAlfanumerico
        end
        object edtUFProprietario: TEditFocus
          Tag = 99
          Left = 433
          Top = 258
          Width = 35
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 2
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object cbbTipoProprietario: TComboBoxFocus
          Tag = 99
          Left = 433
          Top = 282
          Width = 253
          Height = 22
          Style = csDropDownList
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ParentFont = False
          TabOrder = 6
          Items.Strings = (
            '0 '#8211' TAC AGREGADO'
            '1 '#8211' TAC INDEPENDENTE'
            '2 '#8211' OUTROS'
            '')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtIEProprietario: TEditFocus
          Tag = 99
          Left = 433
          Top = 234
          Width = 92
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 14
          TipoTexto = ttInteiro
        end
      end
      object tbsProdutoPredominante: TTabSheet
        Caption = 'Produto Predominante'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblTipoCarga: TLabel
          Left = 12
          Top = 16
          Width = 280
          Height = 13
          Caption = 'Tipo da Carga. Conforme Resolu'#231#227'o ANTT N'#186' 5.849/2019:'
        end
        object lblDescProdutoPredominante: TLabel
          Left = 12
          Top = 58
          Width = 175
          Height = 13
          Caption = 'Descri'#231#227'o do Produto Predominante:'
        end
        object lblCEAN_GTIN: TLabel
          Left = 12
          Top = 98
          Width = 321
          Height = 26
          Caption = 
            'CEAN/GTIN (GTIN - Global Trade Item Number) do produto, antigo c' +
            #243'digo EAN ou c'#243'digo de barras:'
          WordWrap = True
        end
        object lblNCM: TLabel
          Left = 12
          Top = 154
          Width = 26
          Height = 13
          Alignment = taRightJustify
          Caption = 'NCM:'
        end
        object lblCamposObrigatorios: TLabel
          Left = 12
          Top = 276
          Width = 107
          Height = 13
          Caption = '* Campos obrigat'#243'rios'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblTipoCargaObrigatorio: TLabel
          Left = 349
          Top = 39
          Width = 12
          Height = 13
          Caption = ' * '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDescProdutoPredominanteObrigatorio: TLabel
          Left = 349
          Top = 81
          Width = 12
          Height = 13
          Caption = ' * '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cbbTipoCarga: TComboBoxFocus
          Tag = 99
          Left = 12
          Top = 30
          Width = 329
          Height = 22
          Style = csDropDownList
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            '01 - GRANEL S'#211'LIDO'
            '02 - GRANEL L'#205'QUIDO'
            '03 - FRIGORIFICADA'
            '04 - CONTEINERIZADA'
            '05 - CARGA GERAL'
            '06 - NEOGRANEL'
            '07 - PERIGOSA (GRANEL S'#211'LIDO)'
            '08 - PERIGOSA (GRANEL L'#205'QUIDO)'
            '09 - PERIGOSA (CARGA FRIGORIFICADA)'
            '10 - PERIGOSA (CONTEINERIZADA)'
            '11 - PERIGOSA (CARGA GERAL)')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtDescProdutoPredominante: TEditFocus
          Left = 12
          Top = 73
          Width = 329
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 120
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 120
          TipoTexto = ttAlfanumerico
        end
        object edtCEAN_GTIN: TEditFocus
          Left = 12
          Top = 127
          Width = 329
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 14
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 14
          TipoTexto = ttAlfanumerico
        end
        object edtNCM: TEditFocus
          Tag = 99
          Left = 12
          Top = 170
          Width = 132
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 8
          TabOrder = 3
          OnKeyPress = edtNCMKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object gbLocalizacaoCarregamento: TGroupBox
          Left = 12
          Top = 197
          Width = 360
          Height = 66
          Caption = 'Localiza'#231#227'o Carregamento'
          TabOrder = 4
          object lblCEPCarregamento: TLabel
            Left = 12
            Top = 18
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = 'CEP:'
          end
          object lblLatitudeCarregamento: TLabel
            Left = 106
            Top = 18
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Latitude:'
          end
          object lblLongitudeCarregamento: TLabel
            Left = 230
            Top = 18
            Width = 51
            Height = 13
            Alignment = taRightJustify
            Caption = 'Longitude:'
          end
          object lblCEP_Carregamento_Ou: TLabel
            Left = 83
            Top = 36
            Width = 14
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ou'
          end
          object edtLatitudeCarregamento: TEditFocus
            Left = 106
            Top = 33
            Width = 120
            Height = 21
            Alignment = taLeftJustify
            MaxLength = 10
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object edtLongitudeCarregamento: TEditFocus
            Left = 230
            Top = 33
            Width = 120
            Height = 21
            Alignment = taLeftJustify
            MaxLength = 10
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object mskCEPCarregamento: TMaskEditFocus
            Tag = 99
            Left = 12
            Top = 33
            Width = 60
            Height = 21
            EditMask = '99999-999;0;_'
            MaxLength = 9
            TabOrder = 0
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
        end
        object gbLocalizacaoDescarregamento: TGroupBox
          Left = 375
          Top = 197
          Width = 360
          Height = 66
          Caption = 'Localiza'#231#227'o Descarregamento'
          TabOrder = 5
          object lblCEPDescarregamento: TLabel
            Left = 12
            Top = 18
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = 'CEP:'
          end
          object lblLatitudeDescarregamento: TLabel
            Left = 105
            Top = 18
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Latitude:'
          end
          object lblLongitudeDescarregamento: TLabel
            Left = 229
            Top = 18
            Width = 51
            Height = 13
            Alignment = taRightJustify
            Caption = 'Longitude:'
          end
          object lblCEP_Descarregamento_Ou: TLabel
            Left = 82
            Top = 36
            Width = 14
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ou'
          end
          object edtLatitudeDescarregamento: TEditFocus
            Left = 105
            Top = 33
            Width = 120
            Height = 21
            Alignment = taLeftJustify
            MaxLength = 10
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object edtLongitudeDescarregamento: TEditFocus
            Left = 229
            Top = 33
            Width = 120
            Height = 21
            Alignment = taLeftJustify
            MaxLength = 10
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttAlfanumerico
          end
          object mskCEPDescarregamento: TMaskEditFocus
            Tag = 99
            Left = 12
            Top = 33
            Width = 60
            Height = 21
            EditMask = '99999-999;0;_'
            MaxLength = 9
            TabOrder = 0
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
        end
      end
      object tbsInformacoesDoPagamentoDoFrete: TTabSheet
        Caption = 'Informa'#231#245'es do Pagamento do Frete'
        ImageIndex = 3
        object gbMDFPAG: TGroupBox
          Left = 0
          Top = 0
          Width = 786
          Height = 273
          Align = alTop
          Caption = 'Informa'#231#245'es do Pagamento'
          TabOrder = 0
          object lblValorContrato: TLabel
            Left = 386
            Top = 10
            Width = 112
            Height = 13
            Caption = 'Valor Total do Contrato'
          end
          object lblCamposObrigatoriosInfPag: TLabel
            Left = 15
            Top = 158
            Width = 107
            Height = 13
            Caption = '* Campos obrigat'#243'rios'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblValorTotalContratoObrigatorio: TLabel
            Left = 504
            Top = 14
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblFormaPagamentoObrigatorio: TLabel
            Left = 769
            Top = 29
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblNumeroBancoObrigatorio: TLabel
            Left = 769
            Top = 109
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblValorAdiantamento: TLabel
            Left = 516
            Top = 56
            Width = 113
            Height = 13
            Caption = 'Valor do Adiantamento:'
          end
          object gbResponsavelPagamento: TGroupBox
            Left = 15
            Top = 17
            Width = 363
            Height = 133
            Caption = 'Respons'#225'vel do Pagamento'
            TabOrder = 0
            object lblNomeResponsavelPagamento: TLabel
              Left = 60
              Top = 58
              Width = 31
              Height = 13
              Caption = 'Nome:'
            end
            object lblIDEstrangeiro: TLabel
              Left = 10
              Top = 108
              Width = 81
              Height = 13
              Caption = 'ID (Estrangeiro):'
            end
            object lblCNPJ_CPF: TLabel
              Left = 13
              Top = 83
              Width = 78
              Height = 13
              Alignment = taRightJustify
              Caption = '1-CNPJ / 2-CPF:'
            end
            object lblSeqMDFPAG: TLabel
              Left = 65
              Top = 34
              Width = 26
              Height = 13
              Caption = 'Seq.:'
            end
            object lblOu: TLabel
              Left = 285
              Top = 82
              Width = 21
              Height = 13
              Caption = ' OU '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtNomeResponsavel: TEditFocus
              Left = 96
              Top = 55
              Width = 254
              Height = 21
              Alignment = taLeftJustify
              MaxLength = 60
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 60
              TipoTexto = ttAlfanumerico
            end
            object edtIDEstrangeiro: TEditFocus
              Left = 96
              Top = 103
              Width = 254
              Height = 21
              Alignment = taLeftJustify
              MaxLength = 20
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 20
              TipoTexto = ttAlfanumerico
            end
            object edtCNPJ_CPF: TEditFocus
              Tag = 99
              Left = 96
              Top = 79
              Width = 38
              Height = 21
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 1
              TabOrder = 1
              Text = '2'
              OnChange = edtCNPJ_CPFChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object mskCNPJ_CPF: TMaskEditC_G_C_
              Tag = 99
              Left = 137
              Top = 79
              Width = 136
              Height = 21
              EditMask = '999.999.999-99;0;'
              MaxLength = 14
              TabOrder = 2
              Text = ''
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtSeqMDFPAG: TEditFocus
              Left = 96
              Top = 31
              Width = 38
              Height = 21
              TabStop = False
              Alignment = taLeftJustify
              Color = 16770261
              MaxLength = 60
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 60
              TipoTexto = ttAlfanumerico
            end
          end
          object btnAddInfPag: TBitBtnLocked
            Left = 337
            Top = 165
            Width = 35
            Height = 23
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              000000000002000000090000000E0000000F0000000F00000010000000100000
              0010000000100000000F0000000A000000020000000000000000000000000000
              0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
              4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
              000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
              9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
              00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
              7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
              000000000000000000010000000200000002000000030B20176D0A1B136F0000
              0004000000030000000200000002000000000000000000000000000000000000
              000000000000000000000000000000000003040C092E21664AF41C583FF6030A
              072F000000030000000000000000000000000000000000000000000000000000
              00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
              2BCD0001010D0000000100000000000000000000000000000000000000000000
              000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
              6AFF0E291D8B0000000600000001000000000000000000000000000000000000
              00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
              9DFF256F53FD07140E4700000003000000000000000000000000000000000000
              00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
              A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
              0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
              BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
              0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
              DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
              000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
              E6FF3B9878FF0000000900000004000000010000000000000000000000000000
              000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
              F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
              0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
              8EFF2E8166B90000000200000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000200000002000000020000
              0002000000020000000000000000000000000000000000000000}
            TabOrder = 5
            OnClick = btnAddInfPagClick
          end
          object gbInformacoesBancarias: TGroupBox
            Left = 384
            Top = 72
            Width = 383
            Height = 123
            Caption = 'Informa'#231#245'es Banc'#225'rias'
            TabOrder = 4
            object lblNumeroBanco: TLabel
              Left = 17
              Top = 19
              Width = 88
              Height = 13
              Caption = 'N'#250'mero do Banco:'
            end
            object lblNumeroAgencia: TLabel
              Left = 168
              Top = 19
              Width = 97
              Height = 13
              Caption = 'N'#250'mero da Ag'#234'ncia:'
            end
            object lblCNPJInstituicao: TLabel
              Left = 44
              Top = 38
              Width = 104
              Height = 26
              Alignment = taCenter
              Caption = 'CNPJ Institui'#231#227'o do pagamento eletr'#244'nico'
              WordWrap = True
            end
            object lblOu_: TLabel
              Left = 12
              Top = 45
              Width = 21
              Height = 13
              Caption = ' OU '
            end
            object edtPixEmail_Chave: TEditFocus
              Tag = 99
              Left = 7
              Top = 98
              Width = 368
              Height = 21
              Alignment = taLeftJustify
              MaxLength = 60
              TabOrder = 5
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 60
              TipoTexto = ttAlfanumerico
            end
            object edtNumeroBanco: TEditFocus
              Left = 109
              Top = 14
              Width = 44
              Height = 21
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 5
              TipoTexto = ttAlfanumerico
            end
            object edtNumeroAgencia: TEditFocus
              Left = 269
              Top = 14
              Width = 92
              Height = 21
              Alignment = taLeftJustify
              MaxLength = 10
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttAlfanumerico
            end
            object mskCNPJInstituicaoPag: TMaskEditC_G_C_
              Tag = 99
              Left = 164
              Top = 40
              Width = 116
              Height = 21
              EditMask = '99.999.999/9999-99;0;'
              MaxLength = 18
              TabOrder = 2
              Text = ''
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
              strCgcCpf = '1'
            end
            object rdgPIX: TRadioGroup
              Left = 7
              Top = 65
              Width = 330
              Height = 30
              Caption = 'OU PIX'
              Columns = 5
              Items.Strings = (
                'e-mail'
                'CPF'
                'CNPJ'
                'Celular'
                'Chave Al.')
              TabOrder = 3
              TabStop = True
              OnClick = rdgPIXClick
            end
            object mskPIX: TMaskEditC_G_C_
              Tag = 99
              Left = 7
              Top = 98
              Width = 119
              Height = 21
              EditMask = '>aa\.aaa\.aaa/aaaa-99;0;'
              MaxLength = 18
              TabOrder = 6
              Text = ''
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object btnLimpaPix: TBitBtnLocked
              Left = 345
              Top = 71
              Width = 31
              Height = 23
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000030000
                0010000000190000001C0000001D0000001E0000001F00000021000000220000
                00230000002400000026000000270000002600000019000000060000000D1112
                78C61718A5FF1717A3FF1717A2FF1717A1FF17169FFF16179EFF16169DFF1516
                9CFF15169BFF151599FF141498FF151598FF0E0F6CD100000018000000101819
                A8FF5252CCFF3231C1FF2F2EBFFF2C2CBDFF2A2BBBFF2828B9FF2625B7FF2424
                B6FF2222B5FF2020B3FF1F1EB1FF1C1CAFFF141497FF000000220000000D1819
                A9FF5C5DD6FF3B3BCCFF3837CAFF2728BAFF2929BDFF3030C4FF2D2DC2FF2323
                B7FF1C1DB0FF2626BCFF2323BAFF1F1FB1FF141498FF000000210000000A1919
                ABFF6261D8FF3D3DCEFF2223B5FF5F5CB6FF4949B6FF2526B8FF2323B6FF4240
                AAFF6161BCFF1617A8FF2625BCFF2020B2FF151599FF0000001E00000007191A
                ACFF6666DBFF2F2FC2FF5E5AB2FFE2D8D0FFF7F5F7FF6464C1FF6362BEFFF2EE
                F1FFF9F7F7FF6563BDFF1C1DB0FF2221B4FF15159AFF0000001B000000061A1A
                ADFF6C6CDDFF3737C9FF4543AFFFD5C8BFFFE4DBD4FFF6F2F3FFEFE8E9FFEFE8
                E9FFF2EEF0FF4140A9FF2223B7FF2424B6FF15169CFF00000018000000051A1B
                AEFF6F6FDEFF4444D4FF3232C5FF5A55B2FFE0D6D0FFF4EEEDFFF1ECECFFEEE8
                E9FF6060BEFF2324B7FF2D2DC2FF2525B7FF16169DFF00000015000000031A1A
                B0FF7474E1FF4F4FD8FF4242CAFF5E5AB8FFF5EFEFFFF5F0EFFFF3EEEDFFF5F2
                F3FF6363C0FF3535BDFF3939C7FF2828B9FF16169EFF00000013000000022324
                B3FF9A9BEAFF6666D7FF4847B6FFE3DBD5FFF8F4F3FFF4EEEFFFE0D6D0FFE4DB
                D4FFF7F5F7FF4A4AB8FF5757C9FF6061CCFF1F20A4FF0000001100000001393B
                BDFFACACEEFF6161D3FF615EB8FFDACEC2FFE3DAD5FF5E5AB8FF5A56B2FFD5C8
                BFFFE1D8CFFF615EB7FF5454C6FF7878D5FF3737AEFF00000010000000004141
                BFFFB7B7F1FF9A9AEBFF4E4FCAFF5F5CB8FF4947B6FF6869D3FF6768D1FF4643
                B0FF5B57B1FF4545BFFF8D8EE1FF8989DBFF3C3DB1FF0000000E000000004647
                C2FFC2C1F3FFA7A7EEFFA6A6EDFF7273D7FF8182DDFFA2A3EAFFA2A1E9FF7E7E
                D9FF6C6DD1FF9E9EE6FF9C9CE5FF9898E0FF4343B5FF0000000C000000004B4D
                C4FFCCCCF6FFCACAF5FFC9C9F4FFC6C7F4FFC5C5F3FFC3C3F2FFC1C1F1FFBFBF
                F0FFBDBDEFFFBBBBEEFFB9B9EDFFB4B4E9FF494AB8FF0000000A000000003233
                90BD5253C6FF5252C6FF5252C5FF5252C5FF5252C4FF5252C2FF5152C2FF5252
                C1FF5152C0FF5051BFFF5151BEFF5050BDFF313187C200000006000000000000
                0000000000000000000000000000000000000000000100000001000000020000
                0003000000030000000400000005000000060000000400000001}
              TabOrder = 4
              TabStop = False
              OnClick = btnLimpaPixClick
            end
          end
          object dbgInformacoesPagamento: TDBGridCitel
            Left = 2
            Top = 196
            Width = 782
            Height = 75
            Align = alBottom
            DataSource = dsMDFPAG
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            TabOrder = 6
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = dbgInformacoesPagamentoDblClick
            OnKeyDown = dbgInformacoesPagamentoKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'MDF_SEQPAG'
                Title.Alignment = taRightJustify
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_NOMRES'
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_ESTRAN'
                Title.Caption = 'ID (Estrangeiro)'
                Width = 141
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_VALTOT'
                Title.Alignment = taRightJustify
                Width = 150
                Visible = True
              end>
          end
          object rdgFormaPagamento: TRadioGroup
            Left = 525
            Top = 10
            Width = 242
            Height = 38
            Caption = 'Forma de Pagamento'
            Columns = 2
            Items.Strings = (
              'Pagamento '#224' vista'
              'Pagamento '#224' prazo')
            TabOrder = 2
            TabStop = True
            OnClick = rdgFormaPagamentoClick
          end
          object edtValorTotalContrato: TEditFocus
            Tag = 99
            Left = 386
            Top = 26
            Width = 133
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,####0.00'
          end
          object edtValorAdiantamento: TEditFocus
            Tag = 99
            Left = 634
            Top = 53
            Width = 133
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,####0.00'
          end
        end
        object gbComponentes: TGroupBox
          Left = 0
          Top = 273
          Width = 433
          Height = 223
          Align = alLeft
          Caption = 'Componente(s)'
          TabOrder = 1
          object lblTipoComponente: TLabel
            Left = 34
            Top = 44
            Width = 24
            Height = 13
            Caption = 'Tipo:'
          end
          object lblTipoComponenteObrigatorio: TLabel
            Left = 414
            Top = 45
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblValorComponente: TLabel
            Left = 30
            Top = 68
            Width = 28
            Height = 13
            Caption = 'Valor:'
          end
          object lblValorComponenteObrigatorio: TLabel
            Left = 214
            Top = 70
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblDescricaoComponente: TLabel
            Left = 8
            Top = 92
            Width = 50
            Height = 13
            Caption = 'Descri'#231#227'o:'
          end
          object lblSeqMDFCOM: TLabel
            Left = 32
            Top = 19
            Width = 26
            Height = 13
            Caption = 'Seq.:'
          end
          object cbbTipoComponente: TComboBoxFocus
            Tag = 99
            Left = 61
            Top = 40
            Width = 350
            Height = 22
            Style = csDropDownList
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 30
            ParentFont = False
            TabOrder = 1
            Items.Strings = (
              '01 - VALE PED'#193'GIO'
              '02 - IMPOSTOS, TAXAS E CONTRIBUI'#199#213'ES'
              '03 - DESPESAS (BANC'#193'RIAS, MEIOS DE PAGAMENTO, OUTRAS)'
              '99 - OUTROS')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtValorComponente: TEditFocus
            Tag = 99
            Left = 61
            Top = 64
            Width = 147
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,####0.00'
          end
          object edtDescricaoComponente: TEditFocus
            Left = 61
            Top = 88
            Width = 254
            Height = 21
            Alignment = taLeftJustify
            MaxLength = 60
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 60
            TipoTexto = ttAlfanumerico
          end
          object btnAddComponente: TBitBtnLocked
            Left = 359
            Top = 86
            Width = 35
            Height = 23
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              000000000002000000090000000E0000000F0000000F00000010000000100000
              0010000000100000000F0000000A000000020000000000000000000000000000
              0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
              4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
              000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
              9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
              00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
              7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
              000000000000000000010000000200000002000000030B20176D0A1B136F0000
              0004000000030000000200000002000000000000000000000000000000000000
              000000000000000000000000000000000003040C092E21664AF41C583FF6030A
              072F000000030000000000000000000000000000000000000000000000000000
              00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
              2BCD0001010D0000000100000000000000000000000000000000000000000000
              000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
              6AFF0E291D8B0000000600000001000000000000000000000000000000000000
              00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
              9DFF256F53FD07140E4700000003000000000000000000000000000000000000
              00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
              A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
              0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
              BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
              0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
              DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
              000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
              E6FF3B9878FF0000000900000004000000010000000000000000000000000000
              000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
              F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
              0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
              8EFF2E8166B90000000200000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000200000002000000020000
              0002000000020000000000000000000000000000000000000000}
            TabOrder = 4
            OnClick = btnAddComponenteClick
          end
          object dbgComponentes: TDBGridCitel
            Left = 2
            Top = 116
            Width = 429
            Height = 105
            Align = alBottom
            DataSource = dsMDFCOM
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = dbgComponentesDblClick
            OnKeyDown = dbgComponentesKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'MDF_SEQCOM'
                Title.Alignment = taRightJustify
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_DESCOM'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_VALCOM'
                Title.Alignment = taRightJustify
                Width = 150
                Visible = True
              end>
          end
          object edtSeqMDFCOM: TEditFocus
            Left = 61
            Top = 16
            Width = 38
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = 16770261
            MaxLength = 60
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 60
            TipoTexto = ttAlfanumerico
          end
        end
        object gbPrazos: TGroupBox
          Left = 433
          Top = 273
          Width = 353
          Height = 223
          Align = alClient
          Caption = 'Prazo(s)'
          TabOrder = 2
          object lblSeqMDFPRA: TLabel
            Left = 89
            Top = 19
            Width = 26
            Height = 13
            Caption = 'Seq.:'
          end
          object lblValorParcela: TLabel
            Left = 87
            Top = 91
            Width = 28
            Height = 13
            Caption = 'Valor:'
          end
          object lblValorParcelaObrigatorio: TLabel
            Left = 272
            Top = 92
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblDataVencimento: TLabel
            Left = 10
            Top = 66
            Width = 105
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vencimento (Parcela):'
          end
          object lblNumeroParcelas: TLabel
            Left = 21
            Top = 43
            Width = 94
            Height = 13
            Caption = 'N'#250'mero da Parcela:'
          end
          object Label7: TLabel
            Left = 188
            Top = 68
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 161
            Top = 45
            Width = 12
            Height = 13
            Caption = ' * '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object edtSeqMDFPRA: TEditFocus
            Left = 119
            Top = 16
            Width = 38
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
            Color = 16770261
            MaxLength = 60
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 60
            TipoTexto = ttAlfanumerico
          end
          object edtValorParcela: TEditFocus
            Tag = 99
            Left = 119
            Top = 87
            Width = 147
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,####0.00'
          end
          object mskDataVencimento: TMaskEditFocus
            Tag = 99
            Left = 119
            Top = 63
            Width = 63
            Height = 21
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 2
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object edtNumeroParcelas: TEditFocus
            Tag = 99
            Left = 119
            Top = 39
            Width = 38
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object btnAddPrazo: TBitBtnLocked
            Left = 299
            Top = 86
            Width = 35
            Height = 23
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              000000000002000000090000000E0000000F0000000F00000010000000100000
              0010000000100000000F0000000A000000020000000000000000000000000000
              0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
              4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
              000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
              9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
              00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
              7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
              000000000000000000010000000200000002000000030B20176D0A1B136F0000
              0004000000030000000200000002000000000000000000000000000000000000
              000000000000000000000000000000000003040C092E21664AF41C583FF6030A
              072F000000030000000000000000000000000000000000000000000000000000
              00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
              2BCD0001010D0000000100000000000000000000000000000000000000000000
              000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
              6AFF0E291D8B0000000600000001000000000000000000000000000000000000
              00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
              9DFF256F53FD07140E4700000003000000000000000000000000000000000000
              00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
              A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
              0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
              BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
              0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
              DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
              000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
              E6FF3B9878FF0000000900000004000000010000000000000000000000000000
              000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
              F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
              0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
              8EFF2E8166B90000000200000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000200000002000000020000
              0002000000020000000000000000000000000000000000000000}
            TabOrder = 4
            OnClick = btnAddPrazoClick
          end
          object dbgPrazos: TDBGridCitel
            Left = 2
            Top = 116
            Width = 349
            Height = 105
            Align = alBottom
            DataSource = dsMDFPRA
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = dbgPrazosDblClick
            OnKeyDown = dbgPrazosKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'MDF_SEQPRA'
                Title.Alignment = taRightJustify
                Width = 45
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_NUMPAR'
                Title.Alignment = taRightJustify
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'MDF_DTAVEN'
                Title.Alignment = taCenter
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MDF_VALPAR'
                Title.Alignment = taRightJustify
                Width = 100
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 960
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1096
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 888
    Top = 256
  end
  object dtsSegCar: TDataSource
    Left = 16
    Top = 41
  end
  object dtsSegCarAver: TDataSource
    Left = 16
    Top = 97
  end
  object cdsMDFPAG: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'MDF_SEQPAG'
    Params = <>
    AfterScroll = cdsMDFPAGAfterScroll
    Left = 28
    Top = 156
    object cdsMDFPAGMDF_NOMRES: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'MDF_NOMRES'
      Size = 60
    end
    object cdsMDFPAGMDF_CPFCNP: TStringField
      DisplayLabel = 'CNPJ/CPF'
      FieldName = 'MDF_CPFCNP'
      Size = 14
    end
    object cdsMDFPAGMDF_ESTRAN: TStringField
      DisplayLabel = 'Identificador (Se estrangeiro)'
      FieldName = 'MDF_ESTRAN'
    end
    object cdsMDFPAGMDF_VALTOT: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'MDF_VALTOT'
    end
    object cdsMDFPAGMDF_FORPAG: TIntegerField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'MDF_FORPAG'
    end
    object cdsMDFPAGMDF_NUMBAN: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'MDF_NUMBAN'
      Size = 5
    end
    object cdsMDFPAGMDF_NUMAGE: TStringField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'MDF_NUMAGE'
      Size = 10
    end
    object cdsMDFPAGMDF_CNPJPG: TStringField
      DisplayLabel = 'CNPJ da institui'#231#227'o de pagamento'
      FieldName = 'MDF_CNPJPG'
      Size = 14
    end
    object cdsMDFPAGMDF_SEQPAG: TIntegerField
      DisplayLabel = 'Seq.'
      FieldName = 'MDF_SEQPAG'
    end
    object cdsMDFPAGTIPO_CNPJ_CPF: TStringField
      FieldName = 'TIPO_CNPJ_CPF'
      Size = 1
    end
    object cdsMDFPAGMDF_TIPPIX: TIntegerField
      FieldName = 'MDF_TIPPIX'
    end
    object cdsMDFPAGMDF_CHAPIX: TStringField
      FieldName = 'MDF_CHAPIX'
      Size = 60
    end
    object cdsMDFPAGMDF_VALADI: TCurrencyField
      FieldName = 'MDF_VALADI'
    end
  end
  object cdsMDFCOM: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 184
    object cdsMDFCOMMDF_SEQPAG: TIntegerField
      DisplayLabel = 'Seq.'
      FieldName = 'MDF_SEQPAG'
    end
    object cdsMDFCOMMDF_SEQCOM: TIntegerField
      DisplayLabel = 'Seq.'
      FieldName = 'MDF_SEQCOM'
    end
    object cdsMDFCOMMDF_TIPCOM: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'MDF_TIPCOM'
      Size = 2
    end
    object cdsMDFCOMMDF_VALCOM: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'MDF_VALCOM'
    end
    object cdsMDFCOMMDF_DESCOM: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'MDF_DESCOM'
      Size = 60
    end
  end
  object cdsMDFPRA: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 244
    object cdsMDFPRAMDF_SEQPAG: TIntegerField
      DisplayLabel = 'Seq.'
      FieldName = 'MDF_SEQPAG'
    end
    object cdsMDFPRAMDF_SEQPRA: TIntegerField
      DisplayLabel = 'Seq.'
      FieldName = 'MDF_SEQPRA'
    end
    object cdsMDFPRAMDF_NUMPAR: TIntegerField
      DisplayLabel = 'Parcela'
      FieldName = 'MDF_NUMPAR'
    end
    object cdsMDFPRAMDF_DTAVEN: TStringField
      DisplayLabel = 'Vencimento'
      FieldName = 'MDF_DTAVEN'
      EditMask = '99/99/9999;0;_'
      Size = 8
    end
    object cdsMDFPRAMDF_VALPAR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'MDF_VALPAR'
    end
    object cdsMDFPRAccVENCIMENTO: TStringField
      FieldName = 'ccVENCIMENTO'
      Size = 10
    end
  end
  object dsMDFPAG: TDataSource
    DataSet = cdsMDFPAG
    Left = 119
    Top = 151
  end
  object dsMDFCOM: TDataSource
    DataSet = cdsMDFCOM
    Left = 463
    Top = 235
  end
  object dsMDFPRA: TDataSource
    DataSet = cdsMDFPRA
    Left = 651
    Top = 244
  end
end
