inherited frmCadDirVerdeVermelho: TfrmCadDirVerdeVermelho
  Width = 653
  Height = 147
  Caption = 'Cadastro de Direitos de Acesso do Sistema Verde/Vermelho'
  OnDestroy = FormDestroy
  ExplicitWidth = 653
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 77
    Width = 647
    Height = 25
    ExplicitTop = 77
    ExplicitWidth = 647
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 575
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 575
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 71
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 142
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 213
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 284
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 359
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 359
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      object btnDirAce: TBitBtnLocked
        Left = 434
        Top = 0
        Width = 125
        Height = 21
        Caption = '&Direitos de Acesso'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000030000
          0009000000090000000300000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000080908
          57C5080756C902020A270000000E000000110000001300000015000000140000
          00110000000C0000000500000001000000000000000000000000000000081312
          76D14551CCFF15136CDF5E4E51AC72483BCD7A4839DE915644FF774436DE693C
          30CE3A2019870704032B00000010000000040000000000000000000000050909
          12342D2C93F24B56D2FF36338EFFCDC5C9FFDECFCAFFEFE6E3FFDDCAC4FFD3BC
          B5FFB48B7FFF895140F540231B9200000018000000050000000101020414593C
          33A0C8B7BCFF4443ADFF4E5AD4FF393895FF9D9194FF604236FF755B4EFFBEAE
          A7FFEBE2DEFFE5D8D3FFB79085FF4E2A21A90101021A000000032F23246BB58D
          80FFF7F4F3FFE1DFE7FF4546ACFF505DD5FF3C3A98FFC6BAB9FFB29A87FF7F62
          51FFC0B0A9FFECE3DFFFECE2DFFFA37467FF28191A750000000A5E4F60E1BCB1
          ACFFF6F3F3FFF6F3F2FFA7999DFF4848ADFF5361D6FF353595FFA29799FFBBA7
          94FF806658FFEEE5E2FFECE2DFFFB1A29CFF503F50E40000000D182C4D885C63
          72FFB2B0B0FFF1EEEDFF795B4CFFD8D2CFFF4647ADFF5564D8FF393A9CFFCEC7
          C4FF7A5D4DFFEBE3E1FFABA6A3FF505566FF142A55AA0000000A05080F21395F
          9DFA697F9AFF626160FF55443CFFB6AC99FFDCDAD4FF4648AEFF5867DAFF4447
          A8FF968E93FF666363FF4E6586FF2F5191FF050B173C00000004000000031221
          3B685A7FB7FFA6C5E3FF7990ABFF444D59FF494D53FF84838AFF474CB3FF5B6B
          DCFF434AAFFFA6B9D7FF4467A3FD0B172E630000000600000000000000000000
          00030F1B3159315593ED6F91C1FF9BB9DCFFB0CDE9FFCDE8FBFFC0D1E8FF515A
          C1FF5C6EDCFF424BB4FE2F375080000000070000000100000000000000000000
          0000000000020204071112223E6F1C3765B0213F76D0274C91FC284479D25F70
          96D13C45B0EC5F71DFFF2B3196D303040C180000000100000000000000000000
          0000000000000000000000000002000000030000000400000005000000050000
          000505060F19333AA0D18C99E7FF272D90C80000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000104050E152E3594C12C3191BF0000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000010000000000000000}
        Spacing = 2
        TabOrder = 6
        OnClick = btnDirAceClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 577
      Width = 68
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 573
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 647
    Height = 77
    ExplicitWidth = 647
    ExplicitHeight = 77
    inherited tbsGeral: TTabSheet
      Enabled = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 639
      ExplicitHeight = 45
    end
  end
  inherited pnlStatus: TPanel
    Top = 102
    Width = 647
    ExplicitTop = 102
    ExplicitWidth = 647
    inherited pnlNomeForm: TPanel
      Left = 416
      Width = 231
      ExplicitLeft = 416
      ExplicitWidth = 231
    end
    inherited pnlInfo: TPanel
      Width = 416
      ExplicitWidth = 416
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 647
    Height = 77
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Label2: TLabel
      Left = 11
      Top = 39
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDesDir: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 35
      Width = 450
      Height = 22
      DataField = 'DIR_NOMDIR'
      DataSource = dtsCadDir
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIR_CODDIR'
      DataSource = dtsCadDir
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 8
  end
  object dtsCadDir: TDataSource
    Left = 200
    Top = 8
  end
end
