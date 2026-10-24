inherited frmConfigCtaDDA: TfrmConfigCtaDDA
  Width = 678
  Height = 504
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o de Contas Correntes - DDA'
  Position = poMainFormCenter
  ExplicitWidth = 678
  ExplicitHeight = 504
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 433
    Width = 672
    Height = 26
    ExplicitTop = 433
    ExplicitWidth = 672
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 591
      Height = 22
      ExplicitWidth = 591
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Gravar'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 593
      Top = 2
      Align = alRight
      ExplicitLeft = 593
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 459
    Width = 672
    ExplicitTop = 459
    ExplicitWidth = 672
    inherited pnlNomeForm: TPanel
      Left = 501
      ExplicitLeft = 501
    end
    inherited pnlInfo: TPanel
      Width = 501
      ExplicitWidth = 501
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 672
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es DDA - '
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object tabContas: TTabControl [3]
    Left = 0
    Top = 22
    Width = 672
    Height = 411
    Align = alClient
    TabOrder = 3
    Tabs.Strings = (
      'Conta &1'
      'Conta &2'
      'Conta &3'
      'Conta &4'
      'Conta &5')
    TabIndex = 0
    OnChange = tabContasChange
    OnChanging = tabContasChanging
    object cxPaginas: TcxPageControl
      Left = 4
      Top = 25
      Width = 664
      Height = 382
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tbsDadosAutenticacao
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 9
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      ClientRectBottom = 382
      ClientRectRight = 664
      ClientRectTop = 21
      object tbsGeral: TcxTabSheet
        Caption = 'Dados Gerais'
        ImageIndex = 0
        object pnlAtivo: TPanel
          Left = 0
          Top = 0
          Width = 664
          Height = 361
          Align = alClient
          BevelOuter = bvNone
          Color = 16770261
          Enabled = False
          ParentBackground = False
          TabOrder = 0
          object Label6: TLabel
            Left = 331
            Top = 31
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'D'#237'gito Conta Corrente:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblCodAgenc: TLabel
            Left = 11
            Top = 8
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo da Ag'#234'ncia (Sem D'#237'gito):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblContCorr: TLabel
            Left = 11
            Top = 31
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'N'#250'm. Conta Corrente:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPathArquivosRet: TLabel
            Left = 11
            Top = 129
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Pasta para Arquivos de Retorno:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 11
            Top = 55
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Portador de Contas a Pagar:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtDigCtaCor: TEditFocus
            Left = 501
            Top = 28
            Width = 140
            Height = 22
            Alignment = taLeftJustify
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttNumerico
          end
          object edtContaCorr: TEditFocus
            Left = 181
            Top = 28
            Width = 140
            Height = 22
            Alignment = taLeftJustify
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 12
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object edtCodAgencia: TEditFocus
            Left = 181
            Top = 5
            Width = 140
            Height = 22
            Alignment = taLeftJustify
            AutoSize = False
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPor: TEditFocus
            Left = 245
            Top = 52
            Width = 396
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            AutoSize = False
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 7
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
            Left = 181
            Top = 52
            Width = 61
            Height = 22
            Alignment = taLeftJustify
            AutoSize = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 3
            OnKeyPress = edtCodPorKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          inline fraPathRetorno: TfraDirectoryEditFocus
            Left = 180
            Top = 123
            Width = 460
            Height = 24
            Color = 16770261
            ParentBackground = False
            ParentColor = False
            TabOrder = 6
            ExplicitLeft = 180
            ExplicitTop = 123
            ExplicitWidth = 460
            ExplicitHeight = 24
            inherited edtDirectory: TEditFocus
              Width = 435
              Height = 22
              ExplicitWidth = 435
              ExplicitHeight = 22
            end
            inherited btnOpenDirectory: TcxButton
              Left = 437
              Height = 24
              ExplicitLeft = 437
              ExplicitHeight = 24
            end
          end
          inline fraCentroCusto: TfraCentroCustoEditFocus
            Left = 4
            Top = 100
            Width = 645
            Height = 22
            TabOrder = 5
            ExplicitLeft = 4
            ExplicitTop = 100
            ExplicitWidth = 645
            inherited lblEventos: TLabel
              Left = 2
              Top = 3
              Width = 173
              Height = 14
              Caption = 'Centro de Custo de Contas a Pagar:'
              ExplicitLeft = 2
              ExplicitTop = 3
              ExplicitWidth = 173
              ExplicitHeight = 14
            end
            inherited edtCodEve: TEditFocus
              Left = 177
              Width = 61
              Height = 22
              ExplicitLeft = 177
              ExplicitWidth = 61
              ExplicitHeight = 22
            end
            inherited edtDesEve: TEditFocus
              Left = 241
              Width = 396
              Height = 22
              ExplicitLeft = 241
              ExplicitWidth = 396
              ExplicitHeight = 22
            end
          end
          inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
            Left = 8
            Top = 76
            Width = 638
            Height = 22
            TabOrder = 4
            ExplicitLeft = 8
            ExplicitTop = 76
            ExplicitWidth = 638
            ExplicitHeight = 22
            inherited lblPlaContas: TLabel
              Left = 0
              Width = 173
              Height = 14
              Caption = 'Plano de Contas de Contas a Pagar:'
              ExplicitLeft = 0
              ExplicitWidth = 173
              ExplicitHeight = 14
            end
            inherited edtDesCta: TEditFocus
              Left = 237
              Width = 396
              Height = 22
              ExplicitLeft = 237
              ExplicitWidth = 396
              ExplicitHeight = 22
            end
            inherited MskCodCta: TMaskEdit
              Left = 173
              Width = 61
              Height = 22
              ExplicitLeft = 173
              ExplicitWidth = 61
              ExplicitHeight = 22
            end
          end
          object pnlFiltraEmpresaLogada: TPanel
            Left = 4
            Top = 153
            Width = 636
            Height = 25
            BevelOuter = bvNone
            TabOrder = 8
            object lbInfExibirApenasDuplicatas: TLabel
              Left = 326
              Top = 6
              Width = 224
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'Exibir apenas duplicatas da empresa logada ?'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentBiDiMode = False
              ParentColor = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
            end
            object ColorLabel3: TColorLabel
              Left = 579
              Top = 6
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object edtEmpLog: TEditFocus
              Tag = 99
              Left = 556
              Top = 4
              Width = 17
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
              ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object tbsDadosAutenticacao: TcxTabSheet
        Caption = 'Dados Autentica'#231#227'o'
        ImageIndex = 1
        object pnlAtivo2: TPanel
          Left = 0
          Top = 0
          Width = 664
          Height = 361
          Align = alClient
          BevelOuter = bvNone
          Enabled = False
          TabOrder = 0
          inline fraDDAAPIAutenticacaoFrame: TfraDDAAPIAutenticacaoFrame
            Left = 0
            Top = 0
            Width = 664
            Height = 361
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 664
            ExplicitHeight = 361
            inherited pnlFundo: TPanel
              Width = 664
              Height = 361
              ExplicitWidth = 664
              ExplicitHeight = 361
              inherited lblAmbienteAPITexto: TLabel
                Width = 48
                Height = 14
                ExplicitWidth = 48
                ExplicitHeight = 14
              end
              inherited lblMensagem: TLabel
                Font.Pitch = fpVariable
              end
              inherited pnlChaveAppDev: TPanel
                Width = 664
                ExplicitWidth = 664
                inherited lblChaveAppDev: TLabel
                  Left = 25
                  Width = 73
                  Height = 14
                  ExplicitLeft = 25
                  ExplicitWidth = 73
                  ExplicitHeight = 14
                end
              end
              inherited pnlChavesClient: TPanel
                Width = 664
                ExplicitWidth = 664
                inherited lblClientID: TLabel
                  Left = 57
                  Width = 41
                  Height = 14
                  ExplicitLeft = 57
                  ExplicitWidth = 41
                  ExplicitHeight = 14
                end
                inherited lblClientSecret: TLabel
                  Left = 34
                  Width = 64
                  Height = 14
                  ExplicitLeft = 34
                  ExplicitWidth = 64
                  ExplicitHeight = 14
                end
              end
              inherited pnlCertificadoPFX: TPanel
                Width = 664
                ExplicitWidth = 664
                inherited edtArquivoPFX: TEditFocus
                  Height = 22
                  ExplicitHeight = 22
                end
              end
              inherited pnlSenhaCertificado: TPanel
                Width = 664
                ExplicitWidth = 664
                inherited lblSenhaCertificado: TLabel
                  Height = 14
                  ExplicitHeight = 14
                end
                inherited lblValidadeCertificado: TLabel
                  Height = 14
                  ExplicitHeight = 14
                end
                inherited edtValidadeCertificado: TEditFocus
                  Height = 22
                  ExplicitHeight = 22
                end
              end
              inherited pnlChaveBasic: TPanel
                Width = 664
                ExplicitWidth = 664
                inherited lblChaveBasic: TLabel
                  Left = 6
                  Width = 92
                  Height = 14
                  ExplicitLeft = 6
                  ExplicitWidth = 92
                  ExplicitHeight = 14
                end
                inherited btnGerarChaveBasic: TBitBtnLocked
                  Top = 103
                  OnClick = fraDDAAPIAutenticacaoFramebtnGerarChaveBasicClick
                  ExplicitTop = 103
                end
              end
            end
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 0
  end
end
