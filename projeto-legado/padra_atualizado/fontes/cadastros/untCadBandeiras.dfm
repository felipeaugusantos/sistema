inherited frmCadBandeiras: TfrmCadBandeiras
  Left = 312
  Top = 337
  Width = 600
  Height = 480
  Caption = 'Cadastro de Bandeiras'
  OnDestroy = FormDestroy
  ExplicitWidth = 600
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 410
    Width = 594
    Height = 25
    ExplicitTop = 410
    ExplicitWidth = 594
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 536
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 536
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 70
        ExplicitWidth = 70
      end
      inherited btnGravar: TBitBtnLocked
        Left = 70
        Width = 70
        ExplicitLeft = 70
        ExplicitWidth = 70
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 140
        Width = 70
        ExplicitLeft = 140
        ExplicitWidth = 70
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 210
        Width = 70
        ExplicitLeft = 210
        ExplicitWidth = 70
      end
      inherited btnCancela: TBitBtnLocked
        Left = 280
        Width = 76
        ExplicitLeft = 280
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 356
        Width = 74
        ExplicitLeft = 356
        ExplicitWidth = 74
      end
      object btnPlaNco: TBitBtnLocked
        Left = 430
        Top = 0
        Width = 85
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 6
        Visible = False
        OnClick = btnPlaNcoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 538
      Width = 54
      Height = 21
      Align = alRight
      ExplicitLeft = 538
      ExplicitWidth = 54
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 435
    Width = 594
    ExplicitTop = 435
    ExplicitWidth = 594
    inherited pnlNomeForm: TPanel
      Left = 434
      Width = 160
      ExplicitLeft = 434
      ExplicitWidth = 160
    end
    inherited pnlInfo: TPanel
      Width = 434
      ExplicitWidth = 434
    end
  end
  inherited pgcDados: TPageControl
    Width = 594
    Height = 410
    ExplicitWidth = 594
    ExplicitHeight = 410
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 586
      ExplicitHeight = 378
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 594
    Height = 410
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 115
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 99
      Top = 36
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblDesPlaCon: TLabel
      Left = 81
      Top = 60
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano Cont'#225'bil:'
      Visible = False
    end
    object dbeCodBan: TDBEditFocus
      Tag = 99
      Left = 154
      Top = 8
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAN_CODBAN'
      DataSource = dtsCadBan
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomBan: TDBEditFocus
      Tag = 99
      Left = 154
      Top = 32
      Width = 427
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAN_NOMBAN'
      DataSource = dtsCadBan
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesPlaNco: TEditFocus
      Left = 293
      Top = 57
      Width = 288
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      Visible = False
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbePlaNco: TDBEditFocus
      Tag = 99
      Left = 154
      Top = 57
      Width = 135
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnKeyPress = dbePlaNcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gbCnfTef: TGroupBox
      Left = 12
      Top = 85
      Width = 569
      Height = 316
      Caption = 'Configura'#231#227'o TEF'
      TabOrder = 4
      Visible = False
      object pnlBotoesTef: TPanel
        Left = 2
        Top = 16
        Width = 565
        Height = 33
        Align = alTop
        TabOrder = 0
        object btnIncluirDadosEmpresa: TBitBtnLocked
          Left = 1
          Top = 1
          Width = 76
          Height = 31
          Align = alLeft
          Caption = 'I&ncluir'
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
          TabOrder = 0
          OnClick = btnIncluirDadosEmpresaClick
        end
        object btnAlterarDadosEmpresa: TBitBtnLocked
          Left = 77
          Top = 1
          Width = 76
          Height = 31
          Align = alLeft
          Caption = 'A&lterar'
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
          OnClick = btnAlterarDadosEmpresaClick
        end
        object btnExcluirDadosEmpresa: TBitBtnLocked
          Left = 153
          Top = 1
          Width = 76
          Height = 31
          Align = alLeft
          Caption = 'E&xcluir'
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
          TabOrder = 2
          OnClick = btnExcluirDadosEmpresaClick
        end
      end
      object GridTef: TcxGridCitel
        Left = 2
        Top = 49
        Width = 565
        Height = 265
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridTefView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCnfTef
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridTefViewAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
            VisibleForCustomization = False
          end
          object GridTefViewBAN_SEQBAN: TcxGridDBColumn
            DataBinding.FieldName = 'BAN_SEQBAN'
            Visible = False
            VisibleForCustomization = False
          end
          object GridTefViewBAN_TFTBAN: TcxGridDBColumn
            Caption = 'C'#243'd. Bandeira Fiserv-ClisiTef'
            DataBinding.FieldName = 'BAN_TFTBAN'
            Width = 167
          end
          object GridTefViewBAN_TFBAN2: TcxGridDBColumn
            Caption = 'C'#243'd. Bandeira Conex'#227'oTech-Scope'
            DataBinding.FieldName = 'BAN_TFBAN2'
            Width = 182
          end
          object GridTefViewBAN_TIPCAR: TcxGridDBColumn
            Caption = 'Tipo de Cart'#227'o'
            DataBinding.FieldName = 'BAN_TIPCAR'
            PropertiesClassName = 'TcxRadioGroupProperties'
            Properties.Columns = 2
            Properties.Items = <
              item
                Caption = 'Cr'#233'dito'
                Value = 'C'
              end
              item
                Caption = 'D'#233'bito'
                Value = 'D'
              end>
            Width = 177
          end
        end
        object GridTefLevel1: TcxGridLevel
          GridView = GridTefView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 6
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 6
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 8
  end
  object dtsCadBan: TDataSource
    Left = 296
    Top = 6
  end
  object dtsCnfTef: TDataSource
    AutoEdit = False
    Left = 462
    Top = 101
  end
end
