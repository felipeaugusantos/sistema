inherited frmImpEtiquetaAvulsa: TfrmImpEtiquetaAvulsa
  Left = 461
  Top = 350
  Width = 374
  Height = 424
  BorderIcons = [biSystemMenu]
  Caption = 'Etiqueta Avulsa'
  Position = poScreenCenter
  ExplicitWidth = 374
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 368
    ExplicitTop = 351
    ExplicitWidth = 368
    DesignSize = (
      368
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 364
      TabOrder = 3
      ExplicitTop = 2
      ExplicitWidth = 364
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 285
      TabOrder = 2
      ExplicitLeft = 285
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnImpExcel: TBitBtnLocked
      Left = 82
      Top = 3
      Width = 179
      Height = 22
      Caption = '&Importar arquivo do Excel'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        00090000000E0000000F00000010000000100000001100000011000000110000
        001200000012000000110000000C000000030000000000000000000000087B50
        43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
        59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
        5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
        ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
        62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
        2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
        66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
        F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
        69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
        F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
        6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
        F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
        71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
        F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
        77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
        F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
        7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
        32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
        7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
        EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
        82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
        F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
        85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
        F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
        89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
        FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
        67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
        87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
        0002000000030000000400000004000000050000000500000005000000060000
        0006000000060000000600000005000000010000000000000000}
      TabOrder = 1
      OnClick = btnImpExcelClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 368
    Height = 352
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 104
      Height = 14
      Caption = 'Texto para Impress'#227'o'
    end
    object Label2: TLabel
      Left = 8
      Top = 320
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object edtLinha01: TEditFocus
      Left = 8
      Top = 24
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
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
    object edtLinha02: TEditFocus
      Left = 8
      Top = 48
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
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
    object edtLinha03: TEditFocus
      Left = 8
      Top = 73
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha04: TEditFocus
      Left = 8
      Top = 97
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha05: TEditFocus
      Left = 8
      Top = 121
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha06: TEditFocus
      Left = 8
      Top = 145
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha07: TEditFocus
      Left = 8
      Top = 170
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha08: TEditFocus
      Left = 8
      Top = 194
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha09: TEditFocus
      Left = 8
      Top = 218
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha10: TEditFocus
      Left = 8
      Top = 242
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha11: TEditFocus
      Left = 8
      Top = 266
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLinha12: TEditFocus
      Left = 8
      Top = 290
      Width = 350
      Height = 25
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Left = 72
      Top = 315
      Width = 57
      Height = 25
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 12
      Text = '001'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 379
    Width = 368
    ExplicitTop = 379
    ExplicitWidth = 368
    inherited pnlNomeForm: TPanel
      Left = 197
      ExplicitLeft = 197
    end
    inherited pnlInfo: TPanel
      Width = 197
      ExplicitWidth = 197
    end
  end
  object frxEtiqueta: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.384341342600000000
    ReportOptions.LastChange = 39854.373454861100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 216
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Avulsa: TfrxReportPage
      PaperWidth = 79.000000000000000000
      PaperHeight = 50.000000000000000000
      PaperSize = 256
      ColumnWidth = 79.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 170.078762130000000000
        Top = 18.897650000000000000
        Width = 298.582870000000000000
        ColumnWidth = 133.417322834646000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 11.333333340000000000
          Top = 0.543289990000001700
          Width = 275.690391230000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA01'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA01"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 11.333333340000000000
          Top = 14.322819990000000000
          Width = 275.527661570000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA02'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA02"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 11.333333340000000000
          Top = 28.102349990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA03'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA03"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 11.333333340000000000
          Top = 41.881879990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA04'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA04"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 11.333333340000000000
          Top = 55.661409989999990000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA05'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA05"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 11.333333340000000000
          Top = 69.440939990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA06'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA06"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 11.333333340000000000
          Top = 83.220469990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA07'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA07"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 11.333333340000000000
          Top = 96.999999990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA08'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA08"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 11.333333340000000000
          Top = 110.779529990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA09'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA09"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 12.000000010000000000
          Top = 124.559059990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA10'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA10"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 11.333333340000000000
          Top = 138.338589990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA11'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA11"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 11.333333340000000000
          Top = 152.118119990000000000
          Width = 275.527559060000000000
          Height = 15.118110240000000000
          ShowHint = False
          DataField = 'LINHA12'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."LINHA12"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 88
    Top = 216
  end
end
