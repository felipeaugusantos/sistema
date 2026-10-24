inherited frmCadCorrecaoOrdProducaoIndustrial: TfrmCadCorrecaoOrdProducaoIndustrial
  Width = 808
  Height = 455
  Caption = 'Corre'#231#245'es da Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 808
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 382
    Width = 802
    ExplicitTop = 382
    ExplicitWidth = 802
    inherited FlwBotoes: TFlowPanel
      Width = 798
      ExplicitWidth = 798
    end
    inherited btnSair: TBitBtnLocked
      Left = 722
      ExplicitLeft = 722
    end
  end
  inherited pnlStatus: TPanel
    Top = 410
    Width = 802
    ExplicitTop = 410
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 631
      ExplicitLeft = 631
    end
    inherited pnlInfo: TPanel
      Width = 631
      ExplicitWidth = 631
    end
  end
  object pnlGridCorrecao: TPanel [2]
    Left = 0
    Top = 77
    Width = 802
    Height = 277
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    object pnlCorrecao: TPanel
      Left = 0
      Top = 249
      Width = 802
      Height = 28
      Align = alBottom
      BevelInner = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      object btnIncluir: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 87
        Height = 24
        Align = alLeft
        Caption = '[ F5] Incluir'
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
        OnClick = btnIncluirClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 176
        Top = 2
        Width = 89
        Height = 24
        Align = alLeft
        Caption = '[ F7 ] Excluir'
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
        OnClick = btnExcluirClick
      end
      object btnAlterar: TBitBtnLocked
        Left = 89
        Top = 2
        Width = 87
        Height = 24
        Align = alLeft
        Caption = '[ F6 ] Alterar'
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
        OnClick = btnAlterarClick
      end
    end
    object cxgCorrecoes: TcxGrid
      Left = 0
      Top = 0
      Width = 802
      Height = 249
      Align = alClient
      TabOrder = 1
      object cxgCorrecoesViewMATBOPNao: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgCorrecoesViewMATBOPNaoColumn1: TcxGridDBColumn
          Caption = 'IT'
          DataBinding.FieldName = 'DMT_SEQUEN'
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soAscending
          Width = 46
        end
        object cxgCorrecoesViewMATBOPNaoColumn2: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'DMT_ITESUB'
          HeaderAlignmentHorz = taCenter
          Width = 59
        end
        object cxgCorrecoesViewMATBOPNaoColumn3: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'DMT_REFERE'
          Width = 242
        end
        object cxgCorrecoesQTDITE: TcxGridDBColumn
          Caption = 'Quantidade (KG)'
          DataBinding.FieldName = 'DMT_QTDITE'
          HeaderAlignmentHorz = taRightJustify
          Width = 92
        end
        object cxgCorrecoesViewMATBOPNaoColumn5: TcxGridDBColumn
          Caption = 'Observa'#231#245'es'
          DataBinding.FieldName = 'DMT_OBSERV'
          Width = 334
        end
        object cxgCorrecoesViewMATBOPNaoOPECON: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'DMT_OPECON'
          OnGetDisplayText = cxgCorrecoesViewMATBOPNaoOPECONGetDisplayText
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
        object cxgCorrecoesViewMATBOPNaoDTACON: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DMT_DTACON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
        object cxgCorrecoesViewMATBOPNaoHRACON: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'DMT_HRACON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
      end
      object cxgCorrecoesViewMATBOPSim: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxgCorrecoesViewMATBOPSimIT: TcxGridDBColumn
          Caption = 'IT'
          DataBinding.FieldName = 'DMT_SEQUEN'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Options.Focusing = False
          Width = 26
        end
        object cxgCorrecoesViewMATBOPSimDESCRICAO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DMT_REFERE'
          Options.Editing = False
          Options.Focusing = False
          Width = 353
        end
        object cxgCorrecoesViewMATBOPSimREFERENCIA: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERENCIA'
          Options.Editing = False
          Options.Focusing = False
          Width = 268
        end
        object cxgCorrecoesViewMATBOPSimQTDOP: TcxGridDBColumn
          Caption = 'Qtd. OP'
          DataBinding.FieldName = 'QTD_OP'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object cxgCorrecoesViewMATBOPSimQTDUTILIZADA: TcxGridDBColumn
          Caption = 'Qtd. Utilizada'
          DataBinding.FieldName = 'QTD_UTILIZADA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Width = 100
        end
        object cxgCorrecoesViewMATBOPSimCORRECAO: TcxGridDBColumn
          Caption = 'Corre'#231#227'o'
          DataBinding.FieldName = 'DMT_QTDITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Width = 100
        end
        object cxgCorrecoesViewMATBOPSimExcluir: TcxGridDBColumn
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.SourceHeight = 10
              Glyph.SourceWidth = 10
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000029744558745469746C650052656D6F76653B44656C6574653B426172
                733B526962626F6E3B5374616E646172643B635648300000026449444154785E
                A551494C5351146568194A2B583746627F458902118892AAB811369246043462
                8556D032A82D831664486D8C3FB40B8128E3C68998A289625720314469022591
                26566BC484681C22C6012B5A1556C7F73EBF507FDCF193F3DFBBE7DC7BDE7BF7
                86005811B820E80B2310F16B6880E4F7E10462AAF3F1B2014F889E961FBB307D
                AAE2EBC8FEDC137C72280FB1AB546BA0DAE4F11296C491940F36089F2CD5593F
                DFE8C682771453E71B31909D6D207C044D76166B8C339D1789E6C4A76B5D18D7
                15D9A869B04184A744E7FBED72C03FD08EF9B13BF09CADC1F50C55CDE08182DA
                B7ED562CB807E1BFDB06FF701F3C47753E52131D6C20B2EFCA343C31EAF1D3D1
                89B93E167F1EF5E37155255ED92C989F70E0C74D96E3C734F9B89498749A1E2A
                EC41644F4A6AF5B8F6107C7D2D98ED6D847FE80A7EDDBF8A6FBD4D98ED69C088
                3A0BD678A589E44A843D089844DB141B4D0FF3D5F8D251878FAC9EA08C5B87F6
                EC44B37C6D23C991F2530AF99F81E472BAAA7E42AFC307B612EFEA0E2FC1A52D
                446B5A4633C991090D968A5B93D24D4EAD06336DF5982E5363BA9C07D9BF674F
                62B4F020AC9B53976EF1CF145A36249B1EE4E5E28DA5022F8AB23045706B1383
                DB498974CFE1F599620CAB736061B63409A720ED5624CFBD341E81B760379EE5
                65A23F410183487ACE208EB1F42728E1CDCFE4F0BC641FBA9894395213176C10
                655EA3EC706CDF06778E0A76C57A5447C8E87B63298C91B166BB92817BEF0EDC
                4BDB8A0639D34DF8986083309A58278BEFB0C631BEAAC5E255940F6886A8D566
                A27DAF95ADEB22B15CD883808984208E209A8F859A9C6F6078F0145684BF98E8
                BFC080A205F60000000049454E44AE426082}
              Kind = bkGlyph
              Width = 20
            end>
          Properties.ViewStyle = vsButtonsOnly
          Options.ShowEditButtons = isebAlways
          Width = 25
          IsCaptionAssigned = True
        end
        object cxgCorrecoesViewMATBOPSimOPECON: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'DMT_OPECON'
          OnGetDisplayText = cxgCorrecoesViewMATBOPSimOPECONGetDisplayText
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
        object cxgCorrecoesViewMATBOPSimDTACON: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DMT_DTACON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
        object cxgCorrecoesViewMATBOPSimHRACON: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'DMT_HRACON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 65
        end
      end
      object cxgCorrecoesLevel1: TcxGridLevel
        GridView = cxgCorrecoesViewMATBOPSim
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 802
    Height = 77
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
    end
    object Label5: TLabel
      Left = 125
      Top = 37
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object mskDtaCad: TMaskEditFocus
      Tag = 99
      Left = 205
      Top = 11
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumOrd: TEditFocus
      Left = 168
      Top = 11
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtNumOrdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Left = 167
      Top = 35
      Width = 36
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CODITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 205
      Top = 35
      Width = 576
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 354
    Width = 802
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 126
      Height = 24
      Align = alLeft
      Caption = 'Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnConcluiCorrecao: TBitBtnLocked
      Left = 128
      Top = 2
      Width = 140
      Height = 24
      Align = alLeft
      Caption = 'Concluir Corre'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00030000000C0000000F0000000D000000060000000100000001000000040000
        000D0000001100000012000000110000000E0000000000000000000000000000
        00087E431BFF7C411AFF683213FF1C0C0457000000030000000107030119753A
        17FF723916FF723715FF6E3414FF4A1D09F20000000000000000000000000000
        00040D080427864E23F03D1F0CA00000000C0000000100000001000000072013
        0850945827FF915324FF693514EA050201260000000000000000000000000000
        000000000007502E149C572B11D50000000B000000000000000000000007502F
        1697965A28FF854A20FF2D140790000000080000000000000000000000000000
        0000000000031F130941753E18FF100803380000000D0000000D020100188953
        25E9985C2BFF713B17FD09040129000000030000000000000000000000000000
        0000000000000000000978471FDD894F22FF884D20FF864C20FF9A602CFF9A61
        2CFF935828FF49240DB90000000A000000000000000000000000000000000000
        000000000000000000044C31178675461ED8000000130000001159381B9F9D63
        2EFF864D20FF2010065B00000004000000000000000000000000000000000000
        00000000000000000002130C0629834B1FFF150C053702010110935F2DED9D63
        2FFF703E19E80101000E00000001000000000000000000000000000000000000
        00000000000000000000000000066D411DC5432811893322105FA26A32FF975D
        2BFF3D220E8A0000000500000000000000000000000000000000000000000000
        00000000000000000000000000033D27126C7C4F23D6714B24B7A46D33FF8C54
        25FC0E0803270000000200000000000000000000000000000000000000000000
        00000000000000000000000000020A0703179E6B32F7A56F35FCA26B33FF6239
        19BA000000060000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000004714D26B1A97338FF9D662EFF2D1C
        0B5A000000020000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000235251254AA7439FF8A5829E90201
        0009000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000200000004000000040000
        0001000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      TabOrder = 1
      OnClick = btnConcluiCorrecaoClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 540
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 696
    Top = 8
  end
  object dtsOrdPro: TDataSource
    Left = 672
    Top = 168
  end
end
