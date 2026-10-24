inherited frmPreenchimentoAutomatizadoAbreviacaoICMS: TfrmPreenchimentoAutomatizadoAbreviacaoICMS
  Left = 215
  Top = 173
  Width = 906
  Height = 620
  BorderIcons = [biSystemMenu]
  Caption = 'Preenchimento automatizado de Abrevia'#231#227'o de ICMS'
  Position = poMainFormCenter
  ExplicitWidth = 906
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 551
    Width = 900
    Height = 24
    ExplicitTop = 551
    ExplicitWidth = 900
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 291
      Width = 530
      Height = 20
      TabOrder = 2
      ExplicitLeft = 291
      ExplicitWidth = 530
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 821
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 821
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnRealizarPreenchimento: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 149
      Height = 20
      Align = alLeft
      Caption = '&Realizar Preenchimento'
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
      OnClick = btnRealizarPreenchimentoClick
    end
    object btnImportarArquivo: TBitBtnLocked
      Left = 151
      Top = 2
      Width = 120
      Height = 20
      Hint = 
        'Atrav'#233's da importa'#231#227'o ser'#225' possivel incluir valores diferentes p' +
        'or perfil e por estado.'
      Align = alLeft
      Caption = 'Importar Arquivo'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000090000
        000E000000100000001000000010000000100000001000000011000000110000
        001100000011000000100000000B00000003000000000000000017417CCA2159
        A8FF225BAAFF225AAAFF2159A9FF2158A9FF2057A8FF2057A7FF2055A7FF1F55
        A7FF1F54A6FF1E53A6FF1E52A4FF1A458DE303080F2900000002225DA8FF2F6B
        B0FF579AD3FF71BEECFF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
        E1FF389BE0FF369AE0FF3498DFFF2875C1FF0F284E8B000000082868B1FF4884
        BFFF4489C7FF9CD8F5FF63B9EBFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
        E5FF47A6E4FF44A4E4FF41A2E3FF3991D7FF1B4787D50000000D2C6FB7FF6CA7
        D2FF3C87C6FFA0D4EFFF94D5F4FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
        EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2967B4FF040B142F2F75BCFF8FC7
        E6FF4FA0D5FF7FBCE2FFC3EEFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
        EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF408ACAFF112C4E81327CBFFFAFE3
        F5FF75C8EDFF55A3D7FFD2F5FDFFD4F6FEFFD2F4FEFFCDF3FDFFC8F1FDFFC2EE
        FCFFBCEBFBFFB5E7FAFFADE3F9FFA5DFF8FF82C0E6FF1E5189CB3582C4FFC7F5
        FEFF97E5FCFF62BBE7FF4AA0D6FF4A9DD5FF91C3E3FF8DBCDCFF8FBDE0FF5FA3
        D6FF4394CFFF4292CEFF2D73BAFF2D72B9FF2C71B8FF2765A7EA3688C8FFCDF7
        FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFFBBE6F3FFA68E78FFA6BABDFFB2E1
        F3FFB9E6F7FFB3E0F0FF8EADD1FF000000180000000B00000007398ECBFFD0F8
        FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFD3EDF3FFAD744CFF9A6841FFBEB8
        ADFFD1E1E3FF975D32FF8A6E59FF0C07032E00000007000000013B92CEFFD3F9
        FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF9CC3E0FFAD886CFFDBB891FFB07F
        53FF9B643AFF9F663DFFDBB67EFF8E5D33EF311D0F67000000063D97D1FFE2FC
        FEFFE2FCFEFFE1FCFEFFD3F3FAFF428FC1EC0B111523382A1E58C49870FFEAD2
        B1FFFCF0D0FFFEF2D3FFFEE9BBFFF7E6C5FFA36C43FF000000082E739DBF3E9A
        D3FF3E99D3FF3E99D3FF3E97D2FF143245590000000200000003382C204E9877
        58CABF946DFAC3966DFFEAD3B4FFB7906CEE3D2E215B00000003000000020000
        0003000000030000000400000003000000020000000000000000000000010000
        000200000005CAA27AFF846A50AC110D0A1B0000000200000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000100000001000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnImportarArquivoClick
    end
    object btnModeloArquivoImportar: TBitBtnLocked
      Left = 271
      Top = 2
      Width = 20
      Height = 20
      Hint = 'Layout do arquivo de importa'#231#227'o'
      Align = alLeft
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnModeloArquivoImportarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 575
    Width = 900
    ExplicitTop = 575
    ExplicitWidth = 900
    inherited pnlNomeForm: TPanel
      Left = 614
      Width = 286
      ExplicitLeft = 614
      ExplicitWidth = 286
    end
    inherited pnlInfo: TPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 900
    Height = 551
    Align = alClient
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object pnlDadosAbrev: TPanel
      Tag = 99
      Left = 1
      Top = 1
      Width = 898
      Height = 549
      Align = alClient
      ParentColor = True
      TabOrder = 0
      object gpbPerfis: TGroupBox
        Tag = 99
        AlignWithMargins = True
        Left = 7
        Top = 4
        Width = 884
        Height = 142
        Margins.Left = 6
        Margins.Right = 6
        Align = alTop
        Caption = 
          'Perfis a aplicar o preenchimento (Pressione duplo clique ou ente' +
          'r para editar)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object chkPerfis: TCheckListBox
          AlignWithMargins = True
          Left = 8
          Top = 22
          Width = 868
          Height = 112
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alClient
          Color = clWhite
          Columns = 2
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ItemHeight = 14
          Items.Strings = (
            'PEF - ENTRADAS PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)'
            'PEJ - ENTRADAS PESSOA JURIDICA (INDUSTRIA)'
            
              'PER - ENTRADAS PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZ' +
              'ACAO)'
            
              'PES - ENTRADAS PESSOA JUR'#205'DICA  (SIMPLES NACIONAL - DISTRIB. / R' +
              'EV. / COMERC.)'
            'PSI -  ENTRADAS PESSOA JUR'#205'DICA (SIMPLES NACIONAL - IND'#218'STRIA)'
            'NCO - SAIDAS NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)'
            'CCO - SAIDAS CONTRIBUINTE CONSUMIDOR'
            'CNC - SAIDAS CONTRIBUINTE NAO CONSUMIDOR'
            'SNA - SAIDAS SIMPLES NACIONAL'
            'CTA - SAIDAS CONSTRUTORA / NAO CONTRIBUINTE COM INSC.ESTADUAL'
            'PRU - SAIDAS PRODUTOR RURAL'
            'IND - SAIDAS INDUSTRIA'
            'TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS')
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnClick = chkPerfisClick
          OnKeyUp = chkPerfisKeyUp
        end
      end
      object pnlDados: TPanel
        AlignWithMargins = True
        Left = 7
        Top = 271
        Width = 884
        Height = 271
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          884
          271)
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 884
          Height = 271
          Align = alClient
          Brush.Style = bsClear
          Enabled = False
          Pen.Color = clGray
          ExplicitTop = 3
          ExplicitHeight = 268
        end
        object Label4: TLabel
          Left = 501
          Top = 212
          Width = 280
          Height = 28
          AutoSize = False
          Caption = 
            'Utilizar esta op'#231#227'o somente com autoriza'#231#227'o do contador respons'#225 +
            'vel pela empresa.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
        end
        object grp3: TGroupBox
          Tag = 99
          Left = 8
          Top = 12
          Width = 570
          Height = 101
          Caption = 'Situa'#231#227'o Tribut'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl1: TLabel
            Left = 17
            Top = 19
            Width = 90
            Height = 14
            Alignment = taRightJustify
            Caption = 'CST dentro Estado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 17
            Top = 58
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'CST Fora do Estado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodSitDentro: TEditFocus
            Tag = 99
            Left = 17
            Top = 33
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = edtCodSitDentroExit
            OnKeyPress = edtCodSitDentroKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesSitDentro: TEditFocus
            Left = 52
            Top = 33
            Width = 400
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
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
          object edtCodSitFora: TEditFocus
            Tag = 99
            Left = 17
            Top = 72
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            OnExit = edtCodSitDentroExit
            OnKeyPress = edtCodSitDentroKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesSitFora: TEditFocus
            Left = 52
            Top = 72
            Width = 400
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
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
        object grpMensagens: TGroupBox
          Tag = 99
          Left = 8
          Top = 191
          Width = 468
          Height = 66
          Caption = 'Mensagem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object edtMens01: TEditFocus
            Tag = 99
            Left = 17
            Top = 16
            Width = 435
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 75
            ParentCtl3D = False
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
          object edtMens02: TEditFocus
            Tag = 99
            Left = 17
            Top = 39
            Width = 435
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 75
            ParentCtl3D = False
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
        end
        object grpDifal: TGroupBox
          Tag = 99
          Left = 174
          Top = 119
          Width = 404
          Height = 66
          Caption = 'DIFAL'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label3: TLabel
            Left = 13
            Top = 20
            Width = 106
            Height = 14
            AutoSize = False
            Caption = '% Alq.Efetiva Origem'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblMatrizBasesDifal: TLabel
            Left = 124
            Top = 17
            Width = 102
            Height = 14
            Alignment = taRightJustify
            Caption = 'Matriz Bases do Difal'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtAlqEfO: TEditFocus
            Tag = 99
            Left = 13
            Top = 34
            Width = 102
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtCodMatBasDif: TEditFocus
            Tag = 99
            Left = 124
            Top = 34
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentCtl3D = False
            TabOrder = 1
            OnKeyPress = edtCodMatBasDifKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesMatBasDif: TEditFocus
            Left = 159
            Top = 34
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Ctl3D = True
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
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
        object grpST: TGroupBox
          Tag = 99
          Left = 8
          Top = 119
          Width = 157
          Height = 66
          Caption = 'Substitui'#231#227'o Tribut'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object lbl4: TLabel
            Left = 84
            Top = 20
            Width = 59
            Height = 14
            AutoSize = False
            Caption = 'IVA Original'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl6: TLabel
            Left = 17
            Top = 20
            Width = 70
            Height = 14
            AutoSize = False
            Caption = '% Base'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtIVAOri: TEditFocus
            Tag = 99
            Left = 84
            Top = 34
            Width = 60
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.0000'
          end
          object edtBasRet: TEditFocus
            Tag = 99
            Left = 17
            Top = 34
            Width = 60
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.000'
          end
        end
        object grpEntrada: TGroupBox
          Tag = 99
          Left = 584
          Top = 12
          Width = 292
          Height = 101
          Anchors = [akLeft, akTop, akRight]
          Caption = 'ICMS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lbl3: TLabel
            Left = 17
            Top = 15
            Width = 70
            Height = 14
            AutoSize = False
            Caption = '% Base'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 17
            Top = 55
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Matriz Al'#237'q. ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtBasIcm: TEditFocus
            Tag = 99
            Left = 17
            Top = 29
            Width = 78
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtMatIcm: TEditFocus
            Tag = 99
            Left = 17
            Top = 70
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            OnKeyPress = edtMatIcmKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesMatIcm: TEditFocus
            Left = 52
            Top = 70
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
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
        object GroupBox1: TGroupBox
          Tag = 99
          Left = 584
          Top = 119
          Width = 292
          Height = 58
          Anchors = [akLeft, akTop, akRight]
          Caption = 'FCP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label7: TLabel
            Left = 17
            Top = 13
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Matriz Al'#237'q. FCP'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtMatFcp: TEditFocus
            Tag = 99
            Left = 17
            Top = 28
            Width = 34
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnKeyPress = edtMatFcpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesMatFcp: TEditFocus
            Left = 52
            Top = 28
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
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
        object chkZerarParaCstStDentroEstado: TCheckBox
          Left = 485
          Top = 196
          Width = 391
          Height = 19
          Caption = 
            'Zerar Bases, Al'#237'quotas, MVA e Difal para CST de ST dentro do est' +
            'ado.'
          TabOrder = 6
          WordWrap = True
        end
        object grpCodBen: TGroupBox
          Tag = 99
          Left = 584
          Top = 178
          Width = 143
          Height = 41
          Caption = 'C'#243'digo Benef'#237'cio Fiscal'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object edtCodBen: TEditFocus
            Tag = 99
            Left = 7
            Top = 16
            Width = 129
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            ParentCtl3D = False
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
      end
      object gpbUfs: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 152
        Width = 884
        Height = 110
        Margins.Left = 6
        Margins.Right = 6
        Align = alTop
        Caption = 'UF a aplicar o preenchimento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object chkUfs: TCheckListBox
          AlignWithMargins = True
          Left = 8
          Top = 22
          Width = 868
          Height = 64
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 2
          Align = alClient
          Color = clWhite
          Columns = 7
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ItemHeight = 14
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'EX'
            'GO'
            'MA'
            'MS'
            'MT'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnClick = chkPerfisClick
          OnKeyUp = chkPerfisKeyUp
        end
        object pnlUfs: TPanel
          Left = 2
          Top = 88
          Width = 880
          Height = 20
          Margins.Top = 0
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnMarcarTodasUf: TBitBtnLocked
            Left = 8
            Top = 0
            Width = 100
            Height = 20
            Margins.Top = 0
            Caption = 'Marcar todos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnMarcarTodasUfClick
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 16
  end
  object frxHelp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Maximized = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45272.483450208330000000
    ReportOptions.LastChange = 45274.335520474540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 384
    Top = 16
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
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 419.527830000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 49.133890000000000000
          Width = 83.149660000000000000
          Height = 241.889920000000000000
          LineSpacing = 3.000000000000000000
          Memo.UTF8W = (
            'COLUNA A:'
            'COLUNA B:'
            'COLUNA C:'
            'COLUNA D:'
            'COLUNA E:'
            'COLUNA F:'
            'COLUNA G:'
            'COLUNA H:'
            'COLUNA I:'
            'COLUNA J:'
            'COLUNA K:'
            'COLUNA L:'
            'COLUNA M:'
            'COLUNA N:')
        end
        object Rich1: TfrxRichView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          GapX = 2.000000000000000000
          GapY = 1.000000000000000000
          RichEdit = {
            7B5C727466315C616E73695C616E7369637067313235325C64656666305C6E6F
            7569636F6D7061745C6465666C616E67313034367B5C666F6E7474626C7B5C66
            305C666E696C5C66636861727365743020417269616C3B7D7D0D0A7B5C2A5C67
            656E657261746F7220526963686564323020362E332E393630307D5C76696577
            6B696E64345C756331200D0A5C706172645C71635C667332342043414D504F53
            204120534552454D20494D504F525441444F533A5C7061720D0A7D0D0A00}
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 83.149660000000000000
          Top = 49.133890000000000000
          Width = 306.141930000000000000
          Height = 241.889920000000000000
          LineSpacing = 3.000000000000000000
          Memo.UTF8W = (
            'PERFIL'
            'UF'
            'CST'
            '% BASE ICMS'
            '% ALIQUOTA ICMS'
            '% BASE ST'
            '% ALIQ INTERNA ST'
            '% ALIQ REDUZIDA ST'
            'IVA ST'
            '% ALIQ EFETIVA ORIGEM '#8211' DIFAL'
            '% ALIQ INTERNA ESTADO DESTINO '#8211' DIFAL'
            '% BASE DESTINO '#8211' DIFAL'
            '% FCP'
            'C'#211'DIGO BENEF'#205'CIO FISCAL')
        end
      end
    end
  end
end
