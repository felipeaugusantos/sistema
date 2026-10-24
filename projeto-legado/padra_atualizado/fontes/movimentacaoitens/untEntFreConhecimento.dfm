inherited frmEntFreConhecimento: TfrmEntFreConhecimento
  Left = 299
  Top = 248
  Width = 1006
  Height = 745
  BorderStyle = bsSizeable
  Caption = 'Conhecimento de Frete'
  Position = poMainFormCenter
  ExplicitWidth = 1006
  ExplicitHeight = 745
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 666
    Width = 990
    Height = 24
    BevelInner = bvNone
    BevelOuter = bvRaised
    ExplicitTop = 666
    ExplicitWidth = 990
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 911
      Height = 22
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 911
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Gravar'
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
      object btnAltVal: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 100
        Height = 22
        Caption = '&Alt. Duplicatas'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnAltValClick
      end
      object btnBarBol: TBitBtnLocked
        Left = 175
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F9] C'#243'd. Barras Boleto'
        TabOrder = 2
        OnClick = btnBarBolClick
      end
      object btnAbreXmlCte: TBitBtnLocked
        Left = 295
        Top = 0
        Width = 85
        Height = 22
        Caption = 'A&brir XML'
        Glyph.Data = {
          D6020000424DD60200000000000036000000280000000E0000000C0000000100
          200000000000A002000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF0000000000000000008080
          8000808080008080800080808000808080008080800080808000808080000000
          0000FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000808080008080
          800080808000808080008080800080808000808080008080800000000000FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF000000000080808000808080008080
          8000808080008080800080808000808080008080800000000000FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          000000000000000000000000000000000000FF00FF0000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00}
        TabOrder = 3
        OnClick = btnAbreXmlCteClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 380
        Top = 0
        Width = 126
        Height = 22
        Caption = '&Excluir Documento'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        Visible = False
        OnClick = btnExcluirClick
      end
      object btnCfgPis: TBitBtnLocked
        Left = 506
        Top = 0
        Width = 88
        Height = 22
        Caption = '[F6] Config. PIS'
        TabOrder = 5
        Visible = False
        OnClick = btnCfgPisClick
      end
      object btnCfgCof: TBitBtnLocked
        Left = 594
        Top = 0
        Width = 104
        Height = 22
        Caption = '[F7] Config. COFINS'
        TabOrder = 6
        Visible = False
        OnClick = btnCfgCofClick
      end
      object btnOutDes: TBitBtnLocked
        Left = 698
        Top = 0
        Width = 122
        Height = 22
        Caption = '[F8] Outras Despesas'
        TabOrder = 7
        OnClick = btnOutDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 912
      Top = 1
      Align = alRight
      ExplicitLeft = 912
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 690
    Width = 990
    ExplicitTop = 690
    ExplicitWidth = 990
    inherited pnlNomeForm: TPanel
      Left = 819
      ExplicitLeft = 819
    end
    inherited pnlInfo: TPanel
      Width = 819
      ExplicitWidth = 819
    end
  end
  object pgcFrete: TPageControl [2]
    Left = 0
    Top = 0
    Width = 990
    Height = 654
    ActivePage = tbsNotas
    Align = alClient
    TabOrder = 2
    OnChange = pgcFreteChange
    object tbsNotas: TTabSheet
      Caption = '1- Documentos'
      ImageIndex = 1
      OnEnter = tbsNotasEnter
      object pnlNotas: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Label11: TLabel
          Left = 14
          Top = 18
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nro. Documento:'
        end
        object Label28: TLabel
          Left = 306
          Top = 18
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'S'#233'rie:'
        end
        object Label29: TLabel
          Left = 198
          Top = 18
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Esp'#233'cie:'
        end
        object Label30: TLabel
          Left = 35
          Top = 41
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object lblPerRep: TLabel
          Left = 409
          Top = 18
          Width = 109
          Height = 14
          Alignment = taRightJustify
          Caption = '% Representatividade:'
        end
        object edtSerEnt: TEditFocus
          Tag = 99
          Left = 337
          Top = 14
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEspEnt: TEditFocus
          Tag = 99
          Left = 240
          Top = 14
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 97
          Top = 37
          Width = 72
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 4
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomFor: TEditFocus
          Left = 170
          Top = 37
          Width = 327
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtNotEnt: TEditFocus
          Tag = 99
          Left = 97
          Top = 14
          Width = 99
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          TabOrder = 0
          OnExit = edtNotEntExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object btnIncluir: TBitBtnLocked
          Left = 507
          Top = 37
          Width = 77
          Height = 22
          Caption = '&Incluir'
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
          TabOrder = 6
          OnClick = btnIncluirClick
        end
        object edtPerRep: TEditFocus
          Tag = 99
          Left = 521
          Top = 14
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object cxgNotas: TcxGrid
        Left = 0
        Top = 73
        Width = 982
        Height = 552
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgNotasView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#0.00'
              Kind = skSum
              Column = cxgNotasPERREP
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = cxgNotasVLRCON
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxgNotasViewDtaEnt: TcxGridDBColumn
            Caption = 'Data de Entrada'
            DataBinding.FieldName = 'DTAENT'
            Options.Editing = False
            Width = 90
          end
          object cxgNotasViewColumn1: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'NUMDOC'
            Options.Editing = False
            Width = 105
          end
          object cxgNotasViewColumn2: TcxGridDBColumn
            Caption = 'Esp'#233'cie'
            DataBinding.FieldName = 'ESPDOC'
            Options.Editing = False
            Width = 52
          end
          object cxgNotasViewColumn3: TcxGridDBColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'SERIE_'
            Options.Editing = False
            Width = 45
          end
          object cxgNotasViewColumn4: TcxGridDBColumn
            Caption = 'C'#243'd.Fornecedor'
            DataBinding.FieldName = 'CODFOR'
            Options.Editing = False
            Width = 89
          end
          object cxgNotasViewColumn5: TcxGridDBColumn
            Caption = 'Nome do Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            Width = 230
          end
          object cxgNotasVLRCON: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'VLRCON'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxgNotasPERREP: TcxGridDBColumn
            Caption = '% de Representatividade'
            DataBinding.FieldName = 'PERREP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 131
          end
        end
        object cxgNotasLevel1: TcxGridLevel
          GridView = cxgNotasView
        end
      end
    end
    object tbsFrete: TTabSheet
      Caption = '2- Dados do Frete'
      OnEnter = tbsFreteEnter
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 625
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlTopo: TPanel
          Left = 0
          Top = 0
          Width = 982
          Height = 277
          Align = alTop
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object Label1: TLabel
            Left = 19
            Top = 9
            Width = 71
            Height = 14
            Caption = 'Nr Documento:'
          end
          object Label2: TLabel
            Left = 335
            Top = 9
            Width = 28
            Height = 14
            Caption = 'S'#233'rie:'
          end
          object Label3: TLabel
            Left = 203
            Top = 9
            Width = 41
            Height = 14
            Caption = 'Esp'#233'cie:'
          end
          object lblCliFor: TLabel
            Left = 12
            Top = 55
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Transportadora:'
          end
          object Label4: TLabel
            Left = 31
            Top = 32
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dta Entrada:'
          end
          object Label5: TLabel
            Left = 166
            Top = 32
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dta Documento:'
          end
          object Label6: TLabel
            Left = 319
            Top = 32
            Width = 43
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cnd.Pag:'
          end
          object Label33: TLabel
            Left = 0
            Top = 232
            Width = 89
            Height = 14
            Alignment = taRightJustify
            Caption = 'Chave de Acesso:'
          end
          object lblTipFre: TLabel
            Left = 390
            Top = 235
            Width = 76
            Height = 14
            Caption = 'Rateio do Frete:'
          end
          object edtNumDoc: TEditFocus
            Tag = 99
            Left = 95
            Top = 5
            Width = 102
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 12
            TabOrder = 0
            OnExit = edtNumDocExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object edtSerie: TEditFocus
            Tag = 99
            Left = 365
            Top = 5
            Width = 52
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 3
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEspDoc: TEditFocus
            Tag = 99
            Left = 246
            Top = 5
            Width = 39
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 2
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
          object edtCodTra: TEditFocus
            Tag = 99
            Left = 95
            Top = 51
            Width = 69
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 8
            TabOrder = 8
            OnKeyPress = edtCodTraKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtDesTra: TEditFocus
            Left = 166
            Top = 51
            Width = 480
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 10
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskDtaEnt: TMaskEditFocus
            Tag = 99
            Left = 95
            Top = 28
            Width = 69
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999'
            MaxLength = 10
            TabOrder = 3
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskDtaDoc: TMaskEditFocus
            Tag = 99
            Left = 246
            Top = 28
            Width = 69
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999'
            MaxLength = 10
            TabOrder = 4
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskConPag: TMaskEditFocus
            Tag = 99
            Left = 365
            Top = 28
            Width = 278
            Height = 22
            AutoSize = False
            EditMask = 
              '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
              '99.999.999.999.999.999.999.999.999;0;_'
            MaxLength = 98
            TabOrder = 5
            Text = ''
            OnExit = mskConPagExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtChaveAcesso: TEditFocus
            Tag = 99
            Left = 95
            Top = 226
            Width = 293
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 44
            TabOrder = 11
            OnExit = edtChaveAcessoExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 44
            TipoTexto = ttAlfanumerico
          end
          object pnlPortador: TPanel
            Left = 1
            Top = 249
            Width = 980
            Height = 27
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 13
            Visible = False
            object Label31: TLabel
              Left = 44
              Top = 5
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Portador:'
            end
            object Label32: TLabel
              Left = 14
              Top = 147
              Width = 89
              Height = 14
              Alignment = taRightJustify
              Caption = 'Chave de Acesso:'
            end
            object Label8: TLabel
              Left = 437
              Top = 8
              Width = 28
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor:'
            end
            object Label34: TLabel
              Left = 568
              Top = 8
              Width = 37
              Height = 14
              Caption = 'Modelo:'
            end
            object edtCodPor: TEditFocus
              Tag = 99
              Left = 94
              Top = 0
              Width = 55
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtCodPorKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtNomPor: TEditFocus
              Left = 150
              Top = 0
              Width = 236
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
            object edtValDoc: TEditFocus
              Tag = 99
              Left = 467
              Top = 0
              Width = 89
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              TabOrder = 2
              OnExit = edtValDocExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 8
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object cbxCODMOD: TComboBoxFocus
              Tag = 99
              Left = 608
              Top = 0
              Width = 37
              Height = 22
              Style = csDropDownList
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object cbbTipFre: TComboBoxFocus
            Tag = 99
            Left = 468
            Top = 226
            Width = 178
            Height = 22
            Style = csDropDownList
            TabOrder = 12
            OnChange = cbbTipFreChange
            Items.Strings = (
              'Proporcional ao Valor do Item'
              'Proporcional ao Peso do Item'
              'Proporcional a Quantidade de Item'
              'Informar os Percetuais por Item')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object chkImprCp: TCheckBox
            Left = 780
            Top = 28
            Width = 75
            Height = 17
            Caption = 'Imprime CP'
            TabOrder = 7
          end
          object chkGravarFinanceiro: TCheckBox
            Left = 658
            Top = 28
            Width = 121
            Height = 17
            Caption = 'Gravar Financeiro'
            TabOrder = 6
            OnClick = chkGravarFinanceiroClick
          end
          inline fraCtaPagar: TfraCtaPagar
            Left = 0
            Top = 74
            Width = 886
            Height = 152
            TabOrder = 9
            ExplicitTop = 74
            ExplicitWidth = 886
            ExplicitHeight = 152
            inherited pnlFundo: TPanel
              Width = 886
              Height = 152
              ExplicitWidth = 886
              ExplicitHeight = 152
              inherited pnlDetalhe: TPanel
                Width = 889
                Height = 152
                ExplicitWidth = 889
                ExplicitHeight = 152
                inherited lblVeiobo: TLabel
                  Left = 707
                  Top = 3
                  Width = 63
                  Height = 14
                  ExplicitLeft = 707
                  ExplicitTop = 3
                  ExplicitWidth = 63
                  ExplicitHeight = 14
                end
                inherited Label13: TLabel
                  Left = 12
                  Top = 72
                  Width = 81
                  Height = 14
                  ExplicitLeft = 12
                  ExplicitTop = 72
                  ExplicitWidth = 81
                  ExplicitHeight = 14
                end
                inherited Label17: TLabel
                  Left = 47
                  Top = 115
                  Height = 14
                  ExplicitLeft = 47
                  ExplicitTop = 115
                  ExplicitHeight = 14
                end
                inherited Label4: TLabel
                  Left = 719
                  Top = 74
                  Width = 51
                  Height = 14
                  ExplicitLeft = 719
                  ExplicitTop = 74
                  ExplicitWidth = 51
                  ExplicitHeight = 14
                end
                inherited ColVeiobo: TColorLabel
                  Left = 797
                  Top = 3
                  Width = 55
                  Height = 14
                  ExplicitLeft = 797
                  ExplicitTop = 3
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited ColorLabel1: TColorLabel
                  Left = 799
                  Top = 72
                  Width = 55
                  Height = 14
                  ExplicitLeft = 799
                  ExplicitTop = 72
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited Label20: TLabel
                  Left = 724
                  Top = 51
                  Height = 14
                  ExplicitLeft = 724
                  ExplicitTop = 51
                  ExplicitHeight = 14
                end
                inherited ColorLabel3: TColorLabel
                  Left = 799
                  Top = 49
                  Width = 55
                  Height = 14
                  ExplicitLeft = 799
                  ExplicitTop = 49
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited lblTipoDoc: TLabel
                  Left = 46
                  Top = 3
                  Width = 48
                  Height = 14
                  ExplicitLeft = 46
                  ExplicitTop = 3
                  ExplicitWidth = 48
                  ExplicitHeight = 14
                end
                inherited Label31: TLabel
                  Left = 189
                  Top = 27
                  Height = 14
                  ExplicitLeft = 189
                  ExplicitTop = 27
                  ExplicitHeight = 14
                end
                inherited ColorLabel5: TColorLabel
                  Left = 268
                  Top = 26
                  Width = 55
                  Height = 14
                  ExplicitLeft = 268
                  ExplicitTop = 26
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited lbl1: TLabel
                  Left = 724
                  Top = 29
                  Width = 46
                  Height = 14
                  ExplicitLeft = 724
                  ExplicitTop = 29
                  ExplicitWidth = 46
                  ExplicitHeight = 14
                end
                inherited ColorLabel8: TColorLabel
                  Left = 799
                  Top = 25
                  Width = 55
                  Height = 14
                  ExplicitLeft = 799
                  ExplicitTop = 25
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited lblGuia: TLabel
                  Left = 141
                  Top = 5
                  Height = 14
                  ExplicitLeft = 141
                  ExplicitTop = 5
                  ExplicitHeight = 14
                end
                inherited Label36: TLabel
                  Left = 343
                  Top = 26
                  Width = 31
                  Height = 14
                  ExplicitLeft = 343
                  ExplicitTop = 26
                  ExplicitWidth = 31
                  ExplicitHeight = 14
                end
                inherited spbDicaTributo: TSpeedButton
                  Left = 647
                  Top = 0
                  ExplicitLeft = 647
                  ExplicitTop = 0
                end
                inherited lblEventos: TLabel
                  Left = 57
                  Top = 50
                  Width = 36
                  Height = 14
                  Caption = 'Evento:'
                  ExplicitLeft = 57
                  ExplicitTop = 50
                  ExplicitWidth = 36
                  ExplicitHeight = 14
                end
                inherited Label34: TLabel
                  Left = 28
                  Top = 26
                  Width = 65
                  Height = 14
                  ExplicitLeft = 28
                  ExplicitTop = 26
                  ExplicitWidth = 65
                  ExplicitHeight = 14
                end
                inherited Label33: TLabel
                  Left = 684
                  Top = 117
                  Width = 85
                  Height = 14
                  ExplicitLeft = 684
                  ExplicitTop = 117
                  ExplicitWidth = 85
                  ExplicitHeight = 14
                end
                inherited ColorLabel7: TColorLabel
                  Left = 798
                  Top = 117
                  Width = 55
                  Height = 14
                  ExplicitLeft = 798
                  ExplicitTop = 117
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited Label32: TLabel
                  Left = 650
                  Top = 94
                  Width = 119
                  Height = 14
                  ExplicitLeft = 650
                  ExplicitTop = 94
                  ExplicitWidth = 119
                  ExplicitHeight = 14
                end
                inherited ColorLabel6: TColorLabel
                  Left = 798
                  Top = 94
                  Width = 55
                  Height = 14
                  ExplicitLeft = 798
                  ExplicitTop = 94
                  ExplicitWidth = 55
                  ExplicitHeight = 14
                end
                inherited edtNomCta: TEditFocus
                  Left = 151
                  Top = 69
                  Width = 495
                  Height = 22
                  ExplicitLeft = 151
                  ExplicitTop = 69
                  ExplicitWidth = 495
                  ExplicitHeight = 22
                end
                inherited cbxBcoFor: TComboBoxFocus
                  Left = 377
                  Top = 23
                  Width = 268
                  ExplicitLeft = 377
                  ExplicitTop = 23
                  ExplicitWidth = 268
                end
                inherited LcbGuiaTributo: TDBLookupComboBox
                  Left = 166
                  Top = 0
                  Height = 22
                  ExplicitLeft = 166
                  ExplicitTop = 0
                  ExplicitHeight = 22
                end
                inherited LcbTipoTributo: TDBLookupComboBox
                  Left = 267
                  Top = 0
                  Width = 379
                  Height = 22
                  ExplicitLeft = 267
                  ExplicitTop = 0
                  ExplicitWidth = 379
                  ExplicitHeight = 22
                end
                inherited edtDeposi: TEditFocus
                  Left = 240
                  Top = 23
                  Height = 22
                  ExplicitLeft = 240
                  ExplicitTop = 23
                  ExplicitHeight = 22
                end
                inherited MemHisto: TMemo
                  Left = 95
                  Top = 92
                  Width = 551
                  OnKeyPress = fraCtaPagarMemHistoKeyPress
                  ExplicitLeft = 95
                  ExplicitTop = 92
                  ExplicitWidth = 551
                end
                inherited edtTipDoc: TEditFocus
                  Left = 95
                  Top = 0
                  Height = 22
                  ExplicitLeft = 95
                  ExplicitTop = 0
                  ExplicitHeight = 22
                end
                inherited edtVeiobo: TEditFocus
                  Left = 769
                  Top = 0
                  Height = 22
                  OnClick = fraCtaPagaredtVeioboClick
                  ExplicitLeft = 769
                  ExplicitTop = 0
                  ExplicitHeight = 22
                end
                inherited edtVeioNF: TEditFocus
                  Left = 769
                  Top = 23
                  Height = 22
                  ExplicitLeft = 769
                  ExplicitTop = 23
                  ExplicitHeight = 22
                end
                inherited edtUsaChq: TEditFocus
                  Left = 769
                  Top = 46
                  Height = 22
                  ExplicitLeft = 769
                  ExplicitTop = 46
                  ExplicitHeight = 22
                end
                inherited edtPrevis: TEditFocus
                  Left = 769
                  Top = 69
                  Height = 22
                  ExplicitLeft = 769
                  ExplicitTop = 69
                  ExplicitHeight = 22
                end
                inherited edtDesEve: TEditFocus
                  Left = 151
                  Top = 46
                  Width = 495
                  Height = 22
                  ExplicitLeft = 151
                  ExplicitTop = 46
                  ExplicitWidth = 495
                  ExplicitHeight = 22
                end
                inherited edtCodEve: TEditFocus
                  Left = 95
                  Top = 46
                  Height = 22
                  OnKeyPress = fraCtaPagaredtCodEveKeyPress
                  ExplicitLeft = 95
                  ExplicitTop = 46
                  ExplicitHeight = 22
                end
                inherited edtCodCta: TMaskEditFocus
                  Left = 95
                  Top = 69
                  Height = 22
                  OnKeyPress = fraCtaPagaredtCodCtaKeyPress
                  ExplicitLeft = 95
                  ExplicitTop = 69
                  ExplicitHeight = 22
                end
                inherited edtCompet: TMaskEditFocus
                  Left = 95
                  Top = 23
                  Width = 72
                  Height = 22
                  ExplicitLeft = 95
                  ExplicitTop = 23
                  ExplicitWidth = 72
                  ExplicitHeight = 22
                end
                inherited edtPagAnt: TEditFocus
                  Left = 769
                  Top = 92
                  Height = 22
                  ExplicitLeft = 769
                  ExplicitTop = 92
                  ExplicitHeight = 22
                end
                inherited edtUsoCon: TEditFocus
                  Left = 769
                  Top = 115
                  Height = 22
                  ExplicitLeft = 769
                  ExplicitTop = 115
                  ExplicitHeight = 22
                end
              end
            end
          end
        end
        object pnlClassificacoes: TPanel
          Left = 0
          Top = 277
          Width = 982
          Height = 348
          Align = alClient
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object bvlSeparador1: TBevel
            Left = 191
            Top = 20
            Width = 4
            Height = 317
            Style = bsRaised
          end
          object bvlSeparador2: TBevel
            Left = 288
            Top = 21
            Width = 4
            Height = 317
            Style = bsRaised
          end
          object bvlSeparador3: TBevel
            Left = 385
            Top = 21
            Width = 4
            Height = 317
            Style = bsRaised
          end
          object bvlSeparador4: TBevel
            Left = 482
            Top = 21
            Width = 4
            Height = 317
            Style = bsRaised
          end
          object bvlSeparador5: TBevel
            Left = 577
            Top = 20
            Width = 4
            Height = 317
            Style = bsRaised
          end
          object Label9: TLabel
            Left = 5
            Top = 24
            Width = 102
            Height = 14
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o. Fiscal:'
          end
          object Label10: TLabel
            Left = 37
            Top = 47
            Width = 69
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Cont'#225'bil:'
          end
          object Label16: TLabel
            Left = 51
            Top = 70
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Base ICMS:'
          end
          object Label17: TLabel
            Left = 34
            Top = 93
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Al'#237'quota. ICMS:'
          end
          object Label18: TLabel
            Left = 51
            Top = 116
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor ICMS:'
          end
          object Label20: TLabel
            Left = 68
            Top = 139
            Width = 38
            Height = 14
            Alignment = taRightJustify
            Caption = 'Isentas:'
          end
          object Label21: TLabel
            Left = 17
            Top = 162
            Width = 89
            Height = 14
            Alignment = taRightJustify
            Caption = 'Base ICMS Subst.:'
          end
          object Label23: TLabel
            Left = 38
            Top = 251
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desp. Acess.:'
          end
          object Label24: TLabel
            Left = 65
            Top = 274
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Base IPI:'
          end
          object Label25: TLabel
            Left = 65
            Top = 297
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor IPI:'
          end
          object Label12: TLabel
            Left = 117
            Top = 6
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = '1a Class.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label13: TLabel
            Left = 218
            Top = 6
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = '2a Class.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 405
            Top = 6
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = '4a Class.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 306
            Top = 6
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = '3a Class.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label26: TLabel
            Left = 636
            Top = 28
            Width = 26
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label27: TLabel
            Left = 507
            Top = 6
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = '5a Class.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label19: TLabel
            Left = 70
            Top = 320
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Outras:'
          end
          object Label22: TLabel
            Left = 30
            Top = 185
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor de Retido:'
          end
          object lblBasAnt: TLabel
            Left = 9
            Top = 208
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Base ICMS Antecip.:'
          end
          object lblValAnt: TLabel
            Left = 9
            Top = 228
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor ICMS Antecip.:'
          end
          object edtClaFi1: TEditFocus
            Tag = 99
            Left = 110
            Top = 20
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 4
            TabOrder = 0
            OnExit = edtClaFi1Exit
            OnKeyPress = edtClaFi1KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtClaFi2: TEditFocus
            Tag = 99
            Left = 207
            Top = 20
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 4
            TabOrder = 14
            OnKeyPress = edtClaFi1KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtClaFi3: TEditFocus
            Tag = 99
            Left = 304
            Top = 20
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 4
            TabOrder = 28
            OnKeyPress = edtClaFi1KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtClaFi4: TEditFocus
            Tag = 99
            Left = 401
            Top = 20
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 4
            TabOrder = 42
            OnKeyPress = edtClaFi1KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtClaFi5: TEditFocus
            Tag = 99
            Left = 498
            Top = 20
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 4
            TabOrder = 56
            OnKeyPress = edtClaFi1KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtValCo1: TEditFocus
            Tag = 99
            Left = 110
            Top = 43
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
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
          object edtValCo2: TEditFocus
            Tag = 99
            Left = 207
            Top = 43
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 15
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValCo3: TEditFocus
            Tag = 99
            Left = 304
            Top = 43
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 29
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValCo4: TEditFocus
            Tag = 99
            Left = 401
            Top = 43
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 43
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValCo5: TEditFocus
            Tag = 99
            Left = 498
            Top = 43
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 57
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValCoT: TEditFocus
            Left = 592
            Top = 43
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 70
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIc1: TEditFocus
            Tag = 99
            Left = 110
            Top = 66
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIc2: TEditFocus
            Tag = 99
            Left = 207
            Top = 66
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 16
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIc3: TEditFocus
            Tag = 99
            Left = 304
            Top = 66
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 30
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIc4: TEditFocus
            Tag = 99
            Left = 401
            Top = 66
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 44
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIc5: TEditFocus
            Tag = 99
            Left = 498
            Top = 66
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 58
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIcT: TEditFocus
            Left = 592
            Top = 66
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 71
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIc1: TEditFocus
            Tag = 99
            Left = 110
            Top = 89
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIc2: TEditFocus
            Tag = 99
            Left = 207
            Top = 89
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 17
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIc3: TEditFocus
            Tag = 99
            Left = 304
            Top = 89
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 31
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIc4: TEditFocus
            Tag = 99
            Left = 401
            Top = 89
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 45
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIc5: TEditFocus
            Tag = 99
            Left = 498
            Top = 89
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 59
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAlqIcT: TEditFocus
            Left = 592
            Top = 89
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 72
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIc1: TEditFocus
            Tag = 99
            Left = 110
            Top = 112
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 4
            OnEnter = edtValIc1Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIc2: TEditFocus
            Tag = 99
            Left = 207
            Top = 112
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 18
            OnEnter = edtValIc2Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIc3: TEditFocus
            Tag = 99
            Left = 304
            Top = 112
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 32
            OnEnter = edtValIc3Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIc4: TEditFocus
            Tag = 99
            Left = 401
            Top = 112
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 46
            OnEnter = edtValIc4Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIc5: TEditFocus
            Tag = 99
            Left = 498
            Top = 112
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 60
            OnEnter = edtValIc5Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIcT: TEditFocus
            Left = 592
            Top = 112
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 73
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIs1: TEditFocus
            Tag = 99
            Left = 110
            Top = 135
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIs2: TEditFocus
            Tag = 99
            Left = 207
            Top = 135
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 19
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIs3: TEditFocus
            Tag = 99
            Left = 304
            Top = 135
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 33
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIs4: TEditFocus
            Tag = 99
            Left = 401
            Top = 135
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 47
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIs5: TEditFocus
            Tag = 99
            Left = 498
            Top = 135
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 61
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIsT: TEditFocus
            Left = 592
            Top = 135
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 74
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSu1: TEditFocus
            Tag = 99
            Left = 110
            Top = 158
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSu2: TEditFocus
            Tag = 99
            Left = 207
            Top = 158
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 20
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSu3: TEditFocus
            Tag = 99
            Left = 304
            Top = 158
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 34
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSu4: TEditFocus
            Tag = 99
            Left = 401
            Top = 158
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 48
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSu5: TEditFocus
            Tag = 99
            Left = 498
            Top = 158
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 62
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasSuT: TEditFocus
            Left = 592
            Top = 158
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 75
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValRe1: TEditFocus
            Tag = 99
            Left = 110
            Top = 181
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValRe2: TEditFocus
            Tag = 99
            Left = 207
            Top = 181
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 21
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValRe3: TEditFocus
            Tag = 99
            Left = 304
            Top = 181
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 35
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValRe4: TEditFocus
            Tag = 99
            Left = 401
            Top = 181
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 49
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValRe5: TEditFocus
            Tag = 99
            Left = 498
            Top = 181
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 63
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValReT: TEditFocus
            Left = 592
            Top = 181
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 76
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAc1: TEditFocus
            Tag = 99
            Left = 110
            Top = 250
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 10
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAc2: TEditFocus
            Tag = 99
            Left = 207
            Top = 250
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 24
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAc3: TEditFocus
            Tag = 99
            Left = 304
            Top = 250
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 38
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAc4: TEditFocus
            Tag = 99
            Left = 401
            Top = 250
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 52
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAc5: TEditFocus
            Tag = 99
            Left = 498
            Top = 250
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 66
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtDesAcT: TEditFocus
            Left = 592
            Top = 250
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 79
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIp1: TEditFocus
            Tag = 99
            Left = 110
            Top = 273
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIp2: TEditFocus
            Tag = 99
            Left = 207
            Top = 273
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 25
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIp3: TEditFocus
            Tag = 99
            Left = 304
            Top = 273
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 39
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIp4: TEditFocus
            Tag = 99
            Left = 401
            Top = 273
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 53
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIp5: TEditFocus
            Tag = 99
            Left = 498
            Top = 273
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 67
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasIpT: TEditFocus
            Left = 592
            Top = 273
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 80
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIp1: TEditFocus
            Tag = 99
            Left = 110
            Top = 296
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIp2: TEditFocus
            Tag = 99
            Left = 207
            Top = 296
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 26
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIp3: TEditFocus
            Tag = 99
            Left = 304
            Top = 296
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 40
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIp4: TEditFocus
            Tag = 99
            Left = 401
            Top = 296
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 54
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIp5: TEditFocus
            Tag = 99
            Left = 498
            Top = 296
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 68
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValIpT: TEditFocus
            Left = 592
            Top = 296
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 81
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOu1: TEditFocus
            Tag = 99
            Left = 110
            Top = 319
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOu2: TEditFocus
            Tag = 99
            Left = 207
            Top = 319
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 27
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOu3: TEditFocus
            Tag = 99
            Left = 304
            Top = 319
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 41
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOu4: TEditFocus
            Tag = 99
            Left = 401
            Top = 319
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 55
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOu5: TEditFocus
            Tag = 99
            Left = 498
            Top = 319
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            TabOrder = 69
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValOuT: TEditFocus
            Left = 592
            Top = 319
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            TabOrder = 82
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIc1: TEditFocus
            Tag = 99
            Left = 110
            Top = 227
            Width = 70
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
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAn1: TEditFocus
            Tag = 99
            Left = 110
            Top = 204
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAn2: TEditFocus
            Tag = 99
            Left = 207
            Top = 204
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 22
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIc2: TEditFocus
            Tag = 99
            Left = 207
            Top = 227
            Width = 70
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
            TabOrder = 23
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIc3: TEditFocus
            Tag = 99
            Left = 304
            Top = 227
            Width = 70
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
            TabOrder = 37
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAn3: TEditFocus
            Tag = 99
            Left = 304
            Top = 204
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 36
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAn4: TEditFocus
            Tag = 99
            Left = 401
            Top = 204
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 50
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIc4: TEditFocus
            Tag = 99
            Left = 401
            Top = 227
            Width = 70
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
            TabOrder = 51
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIc5: TEditFocus
            Tag = 99
            Left = 498
            Top = 227
            Width = 70
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
            TabOrder = 65
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAn5: TEditFocus
            Tag = 99
            Left = 498
            Top = 204
            Width = 70
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 64
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtBasAnT: TEditFocus
            Tag = 99
            Left = 592
            Top = 204
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 77
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAntIcT: TEditFocus
            Tag = 99
            Left = 592
            Top = 227
            Width = 70
            Height = 22
            TabStop = False
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
            TabOrder = 78
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
    end
    object tbsPessoas: TTabSheet
      Caption = '3 - Pessoas do CTE'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlContainerPessoas: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 625
        Align = alClient
        TabOrder = 0
      end
    end
    object tbsItens: TTabSheet
      Caption = '4 - Informe os itens que ter'#227'o ICMS Antecipado relativo ao Frete'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgItens: TcxGrid
        Left = 0
        Top = 0
        Width = 982
        Height = 625
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsZebra
          object cxgItensCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ENT_CODITE'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 54
          end
          object cxgItensDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Item'
            DataBinding.FieldName = 'ENT_DESITE'
            Options.Editing = False
            Width = 237
          end
          object cxgItensREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'ENT_REFERE'
            Options.Editing = False
            Width = 83
          end
          object cxgItensUNIDAD: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'ENT_SIGUNI'
            Options.Editing = False
            Width = 45
          end
          object cxgItensCODCST: TcxGridDBColumn
            Caption = 'Sit.Tribut'#225'ria'
            DataBinding.FieldName = 'ENT_CODFIS'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 80
          end
          object cxgItensANTPRO: TcxGridDBColumn
            Caption = 'ICMS Antecipado'
            DataBinding.FieldName = 'ENT_ANTPRO'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 95
          end
          object cxgItensANTFRE: TcxGridDBColumn
            Caption = 'ICMS Antecipado sobre o Frete'
            DataBinding.FieldName = 'ENT_ANTFRE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 168
          end
          object cxgItensNUMDOC: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'ENT_NUMDOC'
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxgItensView
        end
      end
    end
    object tbsRateioFrete: TTabSheet
      Caption = '5 - Rateio do Frete'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgProdutos: TcxGrid
        Left = 0
        Top = 0
        Width = 982
        Height = 584
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvProdutos: TcxGridDBBandedTableView
          OnKeyPress = cxvProdutosKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxvProdutosEditKeyDown
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              OnGetText = cxvProdutosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText
              FieldName = 'PERFRE'
              Column = cxvProdutosPERFRE
            end>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsView.NoDataToDisplayInfoText = '<Nemhum produto encontrado>'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsZebra
          Bands = <
            item
              FixedKind = fkLeft
            end
            item
            end
            item
              FixedKind = fkRight
            end>
          object cxvProdutosColumn1: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 81
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvProdutosColumn2: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 222
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvProdutosColumn4: TcxGridDBBandedColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'DESMAR'
            Options.Editing = False
            Width = 111
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvProdutosColumn5: TcxGridDBBandedColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'SIGUNI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 45
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvProdutosColumn6: TcxGridDBBandedColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 81
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvProdutosColumn7: TcxGridDBBandedColumn
            Caption = 'Mult. Compra'
            DataBinding.FieldName = 'MLTCOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 81
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvProdutosColumn8: TcxGridDBBandedColumn
            Caption = 'Vr. Unit'#225'rio'
            DataBinding.FieldName = 'VALUNI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 82
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxvProdutosColumn9: TcxGridDBBandedColumn
            Caption = 'Vr. Total'
            DataBinding.FieldName = 'VALTOT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 82
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxvProdutosNUMDOC: TcxGridDBBandedColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'NUMDOC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 101
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvProdutosPERFRE: TcxGridDBBandedColumn
            Caption = 'Percentual'
            DataBinding.FieldName = 'PERFRE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Styles.Footer = cxsTotal
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvProdutosVALFRE: TcxGridDBBandedColumn
            Caption = 'Valor do Frete'
            DataBinding.FieldName = 'VALFRE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
        end
        object cxgProdutosLevel1: TcxGridLevel
          GridView = cxvProdutos
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 584
        Width = 982
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        ParentBackground = False
        ParentColor = True
        ShowCaption = False
        TabOrder = 1
        object Label35: TLabel
          Left = 8
          Top = 16
          Width = 225
          Height = 14
          Caption = 'Percentual do frete sobre o total da(s) nota(s):'
        end
        object Label36: TLabel
          Left = 308
          Top = 16
          Width = 10
          Height = 14
          Caption = '%'
        end
        object Label7: TLabel
          Left = 511
          Top = 16
          Width = 168
          Height = 14
          Caption = 'Vlr. Total Conhecimentos Digitados:'
        end
        object Label37: TLabel
          Left = 756
          Top = 16
          Width = 13
          Height = 14
          Caption = 'R$'
        end
        object edtPerFreNota: TEditFocus
          Left = 236
          Top = 11
          Width = 69
          Height = 22
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValorFreNota: TEditFocus
          Left = 684
          Top = 11
          Width = 69
          Height = 22
          Alignment = taRightJustify
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
      end
    end
  end
  object prbProgresso: TProgressBar [3]
    Left = 0
    Top = 654
    Width = 990
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 800
    Top = 616
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 792
    Top = 336
  end
  object cxsRepositorio: TcxStyleRepository
    Left = 872
    Top = 144
    PixelsPerInch = 96
    object cxsZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsTotal: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlue
    end
  end
end
