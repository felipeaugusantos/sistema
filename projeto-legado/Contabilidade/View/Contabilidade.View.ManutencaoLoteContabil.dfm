inherited frmManutencaoLoteContabil: TfrmManutencaoLoteContabil
  Width = 800
  Height = 665
  Caption = 'Manuten'#231#227'o de Lotes Cont'#225'beis'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 665
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 594
    Width = 794
    Height = 26
    ExplicitTop = 594
    ExplicitWidth = 794
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 5
      Height = 22
      Align = alLeft
      TabOrder = 5
      ExplicitWidth = 5
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      Top = 2
      Align = alRight
      TabOrder = 4
      ExplicitLeft = 715
      ExplicitTop = 2
    end
    object btnGravarLote: TBitBtnLocked
      Left = 196
      Top = 2
      Width = 104
      Height = 22
      Align = alLeft
      Caption = '&Gravar Lote'
      Enabled = False
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
      OnClick = btnGravarLoteClick
    end
    object btnPesquisa: TBitBtnLocked
      Left = 7
      Top = 2
      Width = 85
      Height = 22
      Align = alLeft
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnPesquisaClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 300
      Top = 2
      Width = 97
      Height = 22
      Align = alLeft
      Caption = '&Excluir Lote'
      Enabled = False
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
    object btnCancelarEfetivacao: TBitBtnLocked
      Left = 397
      Top = 2
      Width = 129
      Height = 22
      Align = alLeft
      Caption = '&Cancelar Efetiva'#231#227'o'
      Enabled = False
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
      TabOrder = 3
      OnClick = btnCancelarEfetivacaoClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 92
      Top = 2
      Width = 104
      Height = 22
      Align = alLeft
      Caption = 'C&ancelar'
      Enabled = False
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
      TabOrder = 6
      OnClick = btnCancelarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 620
    Width = 794
    ExplicitTop = 620
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
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 594
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlGrid: TPanel
      Left = 0
      Top = 293
      Width = 794
      Height = 227
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 794
        Height = 227
        Align = alClient
        TabOrder = 0
        object cxgDadosTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgDadosTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgDadosTableViewEditKeyDown
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosTableViewCON_DTALAN: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'CON_DTALAN'
            Width = 63
          end
          object cxgDadosTableViewCON_EMPLAN: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'CON_EMPLAN'
            Options.Editing = False
            Width = 38
          end
          object cxgDadosTableViewCON_CONDEB: TcxGridDBColumn
            Caption = 'Conta D'#233'bito'
            DataBinding.FieldName = 'CON_CONDEB'
            Width = 150
          end
          object cxgDadosTableViewDES_CONDEB: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Conta'
            DataBinding.FieldName = 'DES_CONDEB'
            Options.Editing = False
            Width = 170
          end
          object cxgDadosTableViewCON_CONCRE: TcxGridDBColumn
            Caption = 'Conta Cr'#233'dito'
            DataBinding.FieldName = 'CON_CONCRE'
            Width = 150
          end
          object cxgDadosTableViewDES_CONCRE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Conta'
            DataBinding.FieldName = 'DES_CONCRE'
            Options.Editing = False
            Width = 170
          end
          object cxgDadosTableViewCON_CCUSTO: TcxGridDBColumn
            Caption = 'C.Custo D'#233'bito'
            DataBinding.FieldName = 'CON_CCUSTO'
            Width = 80
          end
          object cxgDadosTableViewDES_CCUSTO: TcxGridDBColumn
            Caption = 'Descri'#231#227'o C.Custo D'#233'b.'
            DataBinding.FieldName = 'DES_CCUSTO'
            Options.Editing = False
            Width = 150
          end
          object cxgDadosTableViewCON_CCUSCR: TcxGridDBColumn
            Caption = 'C.Custo Cr'#233'dito'
            DataBinding.FieldName = 'CON_CCUSCR'
            Width = 80
          end
          object cxgDadosTableViewDES_CCUSCR: TcxGridDBColumn
            Caption = 'Descri'#231#227'o C.Custo Cr'#233'.'
            DataBinding.FieldName = 'DES_CCUSCR'
            Options.Editing = False
            Width = 150
          end
          object cxgDadosTableViewCON_VALLAN: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'CON_VALLAN'
            Options.Editing = False
            Width = 100
          end
          object cxgDadosTableViewCON_HISTOR: TcxGridDBColumn
            Caption = 'Hist'#243'rico'
            DataBinding.FieldName = 'CON_HISTOR'
            Options.Editing = False
            Width = 178
          end
        end
        object cxgDadosLevel1: TcxGridLevel
          GridView = cxgDadosTableView
        end
      end
    end
    object pnlTotais: TPanel
      Left = 0
      Top = 520
      Width = 794
      Height = 74
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object gpbTotais: TGroupBox
        Left = 0
        Top = 0
        Width = 794
        Height = 74
        Align = alClient
        TabOrder = 0
        object lblDebitos: TLabel
          Left = 12
          Top = 6
          Width = 379
          Height = 15
          AutoSize = False
          Caption = 'D'#233'bitos'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 16
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
        object lblCreditos: TLabel
          Left = 12
          Top = 22
          Width = 379
          Height = 15
          AutoSize = False
          Caption = 'Cr'#233'ditos'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = 16
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
        object lblDiferenca: TLabel
          Left = 12
          Top = 38
          Width = 379
          Height = 15
          AutoSize = False
          Caption = 'Diferen'#231'a'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 16
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
        object lblLancamentos: TLabel
          Left = 12
          Top = 54
          Width = 379
          Height = 15
          AutoSize = False
          Caption = 'Lan'#231'amentos'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 16
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
      end
    end
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 293
      Align = alTop
      TabOrder = 0
      object gpbDadosLote: TGroupBox
        Left = 5
        Top = 5
        Width = 148
        Height = 280
        Caption = 'Dados do Lote'
        TabOrder = 0
        object Label3: TLabel
          Left = 7
          Top = 21
          Width = 76
          Height = 14
          Caption = 'N'#250'mero do Lote'
        end
        object Label7: TLabel
          Left = 7
          Top = 140
          Width = 103
          Height = 14
          Caption = 'Valor Previsto em R$:'
        end
        object edtNumLot: TEditFocus
          Tag = 99
          Left = 7
          Top = 40
          Width = 133
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValPrev: TCurrencyEditFocus
          Tag = 99
          Left = 7
          Top = 159
          EditValue = 0.000000000000000000
          Properties.DisplayFormat = '0.00;-0.00'
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 133
        end
      end
      object gpbDadosLancto: TGroupBox
        Left = 159
        Top = 5
        Width = 624
        Height = 280
        Caption = 'Dados do Lan'#231'amento'
        TabOrder = 1
        object Label12: TLabel
          Left = 31
          Top = 56
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'C. D'#233'bito:'
        end
        object Label13: TLabel
          Left = 27
          Top = 81
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'C. Cr'#233'dito:'
        end
        object Label14: TLabel
          Left = 52
          Top = 27
          Width = 25
          Height = 14
          Caption = 'Data:'
        end
        object Label15: TLabel
          Left = 178
          Top = 27
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label16: TLabel
          Left = 32
          Top = 156
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hist'#243'rico:'
        end
        object Label17: TLabel
          Left = 49
          Top = 253
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor:'
        end
        object Label1: TLabel
          Left = 11
          Top = 108
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'C.Custo D'#233'b.:'
        end
        object Label2: TLabel
          Left = 13
          Top = 132
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'C.Custo Cr'#233'.:'
        end
        object mskContaCredito: TMaskEditFocus
          Left = 82
          Top = 77
          Width = 126
          Height = 22
          TabOrder = 5
          Text = ''
          OnExit = mskContaCreditoExit
          OnKeyPress = mskContaCreditoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskContaDebito: TMaskEditFocus
          Left = 82
          Top = 51
          Width = 126
          Height = 22
          TabOrder = 3
          Text = ''
          OnExit = mskContaDebitoExit
          OnKeyPress = mskContaDebitoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesContaDebito: TEditFocus
          Left = 211
          Top = 51
          Width = 393
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesContaCRedito: TEditFocus
          Left = 211
          Top = 77
          Width = 393
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEmpLan: TEditFocus
          Tag = 99
          Left = 227
          Top = 24
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 1
          OnKeyPress = edtEmpLanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 286
          Top = 24
          Width = 318
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtDesCCustoDebito: TEditFocus
          Left = 171
          Top = 103
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesCCustoCredito: TEditFocus
          Left = 171
          Top = 129
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtHistorico: TMemoFocus
          Left = 82
          Top = 156
          Width = 522
          Height = 89
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object edtValor: TCurrencyEditFocus
          Left = 82
          Top = 250
          EditValue = 0.000000000000000000
          Properties.DisplayFormat = '0.00;-0.00'
          StyleFocused.Color = clInfoBk
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 107
        end
        object btnAdicionar: TBitBtnLocked
          Left = 197
          Top = 249
          Width = 75
          Height = 25
          Caption = 'Lan'#231'ar'
          TabOrder = 13
          OnClick = btnAdicionarClick
        end
        object mskDtaLan: TcxDateEdit
          Tag = 99
          Left = 82
          Top = 22
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
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.Color = clInfoBk
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 0
          Width = 91
        end
        object edtCCustoDebito: TEditFocus
          Tag = 99
          Left = 82
          Top = 103
          Width = 83
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 7
          OnExit = edtCCustoDebitoExit
          OnKeyPress = edtCCustoDebitoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtCCustoCredito: TEditFocus
          Tag = 99
          Left = 82
          Top = 129
          Width = 83
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 9
          OnExit = edtCCustoCreditoExit
          OnKeyPress = edtCCustoCreditoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 816
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 872
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 844
    Top = 8
  end
  object dtsDados: TDataSource
    Left = 1020
    Top = 96
  end
end
