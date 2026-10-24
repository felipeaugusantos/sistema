inherited frmCtpAltGerAut: TfrmCtpAltGerAut
  Left = 244
  Top = 110
  Width = 1044
  Height = 610
  Caption = 'Confirmar altera'#231#227'o de pagamento recorrente'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1044
  ExplicitHeight = 610
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 537
    Width = 1038
    TabOrder = 2
    ExplicitTop = 537
    ExplicitWidth = 1038
    inherited FlwBotoes: TFlowPanel
      Width = 1034
      ExplicitWidth = 1034
    end
    inherited btnSair: TBitBtnLocked
      Left = 955
      TabOrder = 2
      ExplicitLeft = 955
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 122
      Height = 22
      Caption = '[F10] Confirma'
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 565
    Width = 1038
    TabOrder = 3
    ExplicitTop = 565
    ExplicitWidth = 1038
    inherited pnlNomeForm: TPanel
      Left = 867
      ExplicitLeft = 867
    end
    inherited pnlInfo: TPanel
      Width = 867
      ExplicitWidth = 867
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1038
    Height = 97
    Align = alTop
    TabOrder = 0
    object gpbVencimento: TGroupBox
      Left = 460
      Top = 10
      Width = 443
      Height = 51
      Caption = 'Vencimento'
      TabOrder = 1
      Visible = False
      object lblPeriodicidade: TLabel
        Left = 323
        Top = 25
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Periodicidade:'
      end
      object lbl4: TLabel
        Left = 151
        Top = 25
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Usar dia Fixo:'
      end
      object lbl5: TColorLabel
        Left = 248
        Top = 25
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label1: TLabel
        Left = 10
        Top = 25
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object edtPeriod: TEditFocus
        Tag = 99
        Left = 393
        Top = 21
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDiaFix: TEditFocus
        Tag = 99
        Left = 223
        Top = 21
        Width = 23
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 1
        Text = 'N'
        OnExit = edtDiaFixExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtDtaVen: TcxDateEdit
        Tag = 99
        Left = 41
        Top = 20
        Enabled = False
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        Width = 92
      end
    end
    object btnConfirmar: TBitBtnLocked
      Left = 460
      Top = 67
      Width = 109
      Height = 22
      Caption = '&Carregar Titulos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnConfirmarClick
    end
    object gbOpcao: TGroupBox
      Left = 6
      Top = 6
      Width = 448
      Height = 83
      Caption = 
        'Voc'#234' est'#225' prestes a alterar um lan'#231'amento recorrente. Quais lan'#231 +
        'amentos deseja alterar?'
      TabOrder = 0
      object ColorLabel1: TColorLabel
        Left = 88
        Top = 25
        Width = 173
        Height = 14
        Caption = '(1) Alterar apenas este lan'#231'amento.'
        CorDestaque = clRed
      end
      object ColorLabel2: TColorLabel
        Left = 88
        Top = 40
        Width = 262
        Height = 14
        Caption = '(2) Alterar este e os pr'#243'ximos lan'#231'amentos em aberto.'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel
        Left = 88
        Top = 56
        Width = 245
        Height = 14
        Caption = '(3) Alterar este e todos os lan'#231'amentos em aberto.'
        CorDestaque = clRed
      end
      object Label2: TLabel
        Left = 18
        Top = 39
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Op'#231#227'o:'
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 59
        Top = 35
        Width = 23
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        OnChange = edtOpcaoChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
  end
  object pnlAlteracoes: TPanel [3]
    Left = 0
    Top = 97
    Width = 1038
    Height = 440
    Align = alClient
    TabOrder = 1
    object gbAtual: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 1030
      Height = 213
      Align = alTop
      Caption = 'Registros atuais'
      TabOrder = 0
      object dbgDuplicatas: TcxGridCitel
        Left = 2
        Top = 16
        Width = 1026
        Height = 195
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgDuplicatasView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'CTP_NUMDUP'
            Width = 114
          end
          object dbgDuplicatasCTP_SERIE_: TcxGridDBColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'CTP_SERIE_'
            Width = 36
          end
          object dbgDuplicatasCTP_COMPET: TcxGridDBColumn
            Caption = 'Compet'#234'ncia'
            DataBinding.FieldName = 'CTP_COMPET'
            Width = 68
          end
          object dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn
            Caption = 'Vencimento'
            DataBinding.FieldName = 'CTP_DTAVEN'
            Width = 69
          end
          object dbgDuplicatasCTP_DTACAD: TcxGridDBColumn
            Caption = 'Cadastro'
            DataBinding.FieldName = 'CTP_DTACAD'
            Width = 69
          end
          object dbgDuplicatasCTP_VALDUP: TcxGridDBColumn
            Caption = 'Valor Dup.'
            DataBinding.FieldName = 'CTP_VALDUP'
            Width = 82
          end
          object dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn
            Caption = 'Desconto'
            DataBinding.FieldName = 'CTP_DESSUJ'
            Width = 57
          end
          object dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn
            Caption = 'Juros'
            DataBinding.FieldName = 'CTP_JURSUJ'
            Width = 55
          end
          object dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn
            Caption = 'Multa'
            DataBinding.FieldName = 'CTP_MULSUJ'
            Width = 55
          end
          object dbgDuplicatasTOTDUP: TcxGridDBColumn
            Caption = 'Valor Corrigido'
            DataBinding.FieldName = 'TOTDUP'
            Width = 77
          end
          object dbgDuplicatasCTP_NOMPOR: TcxGridDBColumn
            Caption = 'Portador'
            DataBinding.FieldName = 'CTP_NOMPOR'
            Width = 169
          end
          object dbgDuplicatasCTP_CODEVE: TcxGridDBColumn
            Caption = 'C'#243'd. Ctr.Custos'
            DataBinding.FieldName = 'CTP_CODEVE'
            Width = 85
          end
          object dbgDuplicatasEVE_DESEVE: TcxGridDBColumn
            Caption = 'Centro de Custos'
            DataBinding.FieldName = 'EVE_DESEVE'
            Width = 140
          end
          object dbgDuplicatasCTP_CODCTA: TcxGridDBColumn
            Caption = 'C'#243'd. Plano de Contas'
            DataBinding.FieldName = 'CTP_CODCTA'
            Width = 114
          end
          object dbgDuplicatasCTA_DESCTA: TcxGridDBColumn
            Caption = 'Plano de Contas'
            DataBinding.FieldName = 'CTA_DESCTA'
            Width = 200
          end
          object dbgDuplicatasCTP_PREVIS: TcxGridDBColumn
            Caption = 'Previs'#227'o?'
            DataBinding.FieldName = 'CTP_PREVIS'
            Width = 62
          end
          object dbgDuplicatasCTP_VEIONF: TcxGridDBColumn
            Caption = 'Veio NF?'
            DataBinding.FieldName = 'CTP_VEIONF'
            Width = 56
          end
          object dbgDuplicatasCTP_USOCON: TcxGridDBColumn
            Caption = 'Uso e Consumo?'
            DataBinding.FieldName = 'CTP_USOCON'
            Width = 92
          end
          object dbgDuplicatasCTP_PAGANT: TcxGridDBColumn
            Caption = 'Pag. Adiant.?'
            DataBinding.FieldName = 'CTP_PAGANT'
            Width = 78
          end
        end
        object dbgDuplicatasLevel1: TcxGridLevel
          GridView = dbgDuplicatasView
        end
      end
    end
    object gbNovo: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 223
      Width = 1030
      Height = 213
      Align = alClient
      Caption = 'Registros ap'#243's a altera'#231#227'o'
      TabOrder = 1
      object dbgDuplicatasNovo: TcxGridCitel
        Left = 2
        Top = 16
        Width = 1026
        Height = 195
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgDuplicatasNovoView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object dbgDuplicatasNovoCTP_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'CTP_NUMDUP'
            Width = 112
          end
          object dbgDuplicatasNovoCTP_SERIE: TcxGridDBColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'CTP_SERIE_'
            Width = 36
          end
          object dbgDuplicatasNovoCTP_COMPET: TcxGridDBColumn
            Caption = 'Compet'#234'ncia'
            DataBinding.FieldName = 'CTP_COMPET'
            Width = 68
          end
          object dbgDuplicatasNovoCTP_DTAVEN: TcxGridDBColumn
            Caption = 'Vencimento'
            DataBinding.FieldName = 'CTP_DTAVEN'
            Width = 69
          end
          object dbgDuplicatasNovoCTP_DTACAD: TcxGridDBColumn
            Caption = 'Cadastro'
            DataBinding.FieldName = 'CTP_DTACAD'
            Width = 69
          end
          object dbgDuplicatasNovoCTP_VALDUP: TcxGridDBColumn
            Caption = 'Valor Dup.'
            DataBinding.FieldName = 'CTP_VALDUP'
            Width = 82
          end
          object dbgDuplicatasNovoCTP_DESSUJ: TcxGridDBColumn
            Caption = 'Desconto'
            DataBinding.FieldName = 'CTP_DESSUJ'
            Width = 57
          end
          object dbgDuplicatasNovoCTP_JURSUJ: TcxGridDBColumn
            Caption = 'Juros'
            DataBinding.FieldName = 'CTP_JURSUJ'
            Width = 55
          end
          object dbgDuplicatasNovoCTP_MULSUJ: TcxGridDBColumn
            Caption = 'Multa'
            DataBinding.FieldName = 'CTP_MULSUJ'
            Width = 55
          end
          object dbgDuplicatasNovoTOTDUP: TcxGridDBColumn
            Caption = 'Valor Corrigido'
            DataBinding.FieldName = 'TOTDUP'
            Width = 77
          end
          object dbgDuplicatasNovoCTP_NOMPOR: TcxGridDBColumn
            Caption = 'Portador'
            DataBinding.FieldName = 'CTP_NOMPOR'
            Width = 169
          end
          object dbgDuplicatasNovoCTP_CODEVE: TcxGridDBColumn
            Caption = 'C'#243'd. Ctr.Custos'
            DataBinding.FieldName = 'CTP_CODEVE'
            Width = 85
          end
          object dbgDuplicatasNovoEVE_DESEVE: TcxGridDBColumn
            Caption = 'Centro de Custos'
            DataBinding.FieldName = 'EVE_DESEVE'
            Width = 140
          end
          object dbgDuplicatasNovoCTP_CODCTA: TcxGridDBColumn
            Caption = 'C'#243'd. Plano de Contas'
            DataBinding.FieldName = 'CTP_CODCTA'
            Width = 109
          end
          object dbgDuplicatasNovoCTA_DESCTA: TcxGridDBColumn
            Caption = 'Plano de Contas'
            DataBinding.FieldName = 'CTA_DESCTA'
            Width = 208
          end
          object dbgDuplicatasNovoCTP_PREVIS: TcxGridDBColumn
            Caption = 'Previs'#227'o?'
            DataBinding.FieldName = 'CTP_PREVIS'
            Width = 62
          end
          object dbgDuplicatasNovoCTP_VEIONF: TcxGridDBColumn
            Caption = 'Veio NF?'
            DataBinding.FieldName = 'CTP_VEIONF'
            Width = 56
          end
          object dbgDuplicatasNovoCTP_USOCON: TcxGridDBColumn
            Caption = 'Uso e Consumo?'
            DataBinding.FieldName = 'CTP_USOCON'
            Width = 92
          end
          object dbgDuplicatasNovoCTP_PAGANT: TcxGridDBColumn
            Caption = 'Pag. Adiant.?'
            DataBinding.FieldName = 'CTP_PAGANT'
            Width = 78
          end
        end
        object dbgDuplicatasNovoLevel1: TcxGridLevel
          GridView = dbgDuplicatasNovoView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 60
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 736
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 880
    Top = 32
  end
end
