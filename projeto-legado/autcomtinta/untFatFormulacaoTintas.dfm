inherited frmFatFormulacaoTintas: TfrmFatFormulacaoTintas
  Width = 800
  Height = 500
  Caption = 'Formula'#231#227'o Tintas Gen'#233'ricos'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
    ExplicitWidth = 965
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 961
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
    ExplicitWidth = 965
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 794
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 794
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 455
    ExplicitWidth = 965
    ExplicitHeight = 455
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 957
      ExplicitHeight = 423
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 455
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 965
    object mmoBase: TMemo
      Left = 1
      Top = 1
      Width = 792
      Height = 63
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 963
    end
    object pnlBotoesFor: TPanel
      Left = 1
      Top = 426
      Width = 792
      Height = 28
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 963
      object lblTipoFormulacao: TLabel
        Left = 154
        Top = 8
        Width = 130
        Height = 15
        Caption = 'Formula'#231#227'o em Pulsos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnCancelarForm: TBitBtnLocked
        Left = 680
        Top = 1
        Width = 111
        Height = 26
        Align = alRight
        Caption = '[ Esc ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarFormClick
        ExplicitLeft = 848
        ExplicitTop = 3
        ExplicitHeight = 22
      end
      object btnImprimir: TBitBtnLocked
        Left = 1
        Top = 1
        Width = 149
        Height = 26
        Align = alLeft
        Caption = '[ F10 ] Imprimir Formula'#231#227'o'
        TabOrder = 0
        OnClick = btnImprimirClick
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitHeight = 22
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 512
        Top = 1
        Width = 168
        Height = 26
        Align = alRight
        Caption = 'Configurar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnConfigurarGridClick
        ExplicitLeft = 516
        ExplicitTop = -1
      end
    end
    object cxGridFormulacao1: TcxGrid
      Left = 1
      Top = 64
      Width = 792
      Height = 362
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 0
      object cxGridFormulacao: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGridForCODITE: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'TMP_CODITE'
          Options.Editing = False
          Width = 99
        end
        object cxGridForFORMUL: TcxGridDBColumn
          Caption = 'Base / Colorante'
          DataBinding.FieldName = 'TMP_FORMUL'
          Options.Editing = False
          Width = 171
        end
        object cxGridForDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'TMP_DESCRI'
          Options.Editing = False
          Width = 407
        end
        object cxGridForQTDBAS: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'TMP_QTDBAS'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 102
        end
      end
      object cxGridFormulacao1Level1: TcxGridLevel
        GridView = cxGridFormulacao
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 8
  end
end
