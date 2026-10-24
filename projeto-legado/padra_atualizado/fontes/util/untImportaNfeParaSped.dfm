inherited frmImportaNfeParaSped: TfrmImportaNfeParaSped
  Width = 520
  Height = 206
  Caption = 'Importa NFE para gera'#231#227'o do SPED'
  Position = poMainFormCenter
  ExplicitWidth = 520
  ExplicitHeight = 206
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 8
    Width = 169
    Height = 14
    Caption = 'Path com XMLs de emiss'#227'o pr'#243'pria'
  end
  object lblDocumentos: TLabel [1]
    Left = 8
    Top = 95
    Width = 60
    Height = 14
    Caption = 'Documentos'
  end
  object lblEstimativa: TLabel [2]
    Left = 394
    Top = 95
    Width = 104
    Height = 14
    Alignment = taRightJustify
    Caption = 'Estimativa de t'#233'rmino:'
  end
  object rdgFilIte: TRadioGroup [3]
    Left = 8
    Top = 53
    Width = 182
    Height = 38
    Caption = 'Filtrar Item Por:'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'CODITE'
      'CODVEL')
    TabOrder = 1
  end
  inherited pnlBotoes: TPanel
    Top = 133
    Width = 514
    TabOrder = 5
    ExplicitTop = 133
    ExplicitWidth = 514
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 356
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 356
    end
    inherited btnSair: TBitBtnLocked
      Left = 435
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 435
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnImportar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Importar'
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
      OnClick = btnImportarClick
    end
  end
  object pgbDocumentos: TProgressBar [5]
    Left = 8
    Top = 109
    Width = 494
    Height = 17
    TabOrder = 4
  end
  inline fraArquivo: TfraDirectoryEditFocus [6]
    Left = 8
    Top = 25
    Width = 493
    Height = 24
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 25
    ExplicitWidth = 493
    ExplicitHeight = 24
    inherited edtDirectory: TEditFocus
      Width = 468
      Height = 22
      ExplicitWidth = 468
      ExplicitHeight = 22
    end
    inherited btnOpenDirectory: TcxButton
      Left = 470
      Height = 24
      ExplicitLeft = 470
      ExplicitHeight = 24
    end
  end
  object chkImpNotasInutilizadas: TCheckBox [7]
    Left = 354
    Top = 72
    Width = 147
    Height = 17
    Caption = 'Importar notas inutilizadas'
    TabOrder = 3
  end
  inherited pnlStatus: TPanel [8]
    Top = 161
    Width = 514
    TabOrder = 6
    ExplicitTop = 161
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 343
      ExplicitLeft = 343
    end
    inherited pnlInfo: TPanel
      Width = 343
      ExplicitWidth = 343
    end
  end
  object chkAbfIcm: TCheckBox [9]
    Left = 201
    Top = 68
    Width = 142
    Height = 17
    Caption = 'Carregar ABFICM'
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu [10]
    Left = 344
    Top = 2
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 2
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 2
  end
  object cdsParticipantes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 2
    object cdsParticipantesCODVEL: TStringField
      FieldName = 'CODVEL'
    end
    object cdsParticipantesCNPJ: TStringField
      FieldName = 'CNPJ'
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41703.416773564830000000
    ReportOptions.LastChange = 41703.603024085650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 2
    Datasets = <
      item
        DataSet = frxParticipantes
        DataSetName = 'frxParticipantes'
      end>
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
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo3: TfrxMemoView
          Left = 124.724490000000000000
          Top = 3.779530000000000000
          Width = 461.102660000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Clientes / Fornecedores / Consumidores')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Top = 45.354360000000000000
          Width = 740.787880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Os CPF/CNPJ abaixo n'#227'o encontram-se nos cadastros do Autcom. Por' +
              ' favor verifique e realize o cadastro se necess'#225'rio.')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 151.181200000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 26.456710000000000000
          Fill.BackColor = clScrollBar
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOTA FISCAL')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 166.299320000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFP/CNPJ')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        DataSet = frxParticipantes
        DataSetName = 'frxParticipantes'
        RowCount = 0
        object frxParticipantesDocumento: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'Documento'
          DataSet = frxParticipantes
          DataSetName = 'frxParticipantes'
          Memo.UTF8W = (
            '[frxParticipantes."Documento"]')
        end
        object frxParticipantesCGC: TfrxMemoView
          Left = 166.299320000000000000
          Top = 3.779530000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'CGC'
          DataSet = frxParticipantes
          DataSetName = 'frxParticipantes'
          Memo.UTF8W = (
            '[frxParticipantes."CGC"]')
        end
      end
    end
  end
  object frxParticipantes: TfrxDBDataset
    UserName = 'frxParticipantes'
    CloseDataSource = False
    DataSet = cdsClientesNaoCadastrados
    BCDToCurrency = False
    Left = 216
    Top = 2
  end
  object cdsClientesNaoCadastrados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 2
    object cdsClientesNaoCadastradosDocumento: TStringField
      FieldName = 'Documento'
    end
    object cdsClientesNaoCadastradosCGC: TStringField
      FieldName = 'CGC'
    end
  end
  object cdsCodVel: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'CODVEL'
    Params = <>
    StoreDefs = True
    Left = 232
    Top = 58
    object cdsCodVelCODVEL: TStringField
      FieldName = 'CODVEL'
      KeyFields = 'CODVEL'
    end
    object cdsCodVelCODABF: TStringField
      FieldName = 'CODABF'
      KeyFields = 'CODABF'
      Size = 3
    end
    object cdsCodVelCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsCodVelCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsCodVelFLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
  end
  object cdsAbfIcm: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsAbfIcmIndex1'
        Fields = 'ABF_CODABF;CODITE;CODEST;CODEMP'
      end>
    IndexName = 'cdsAbfIcmIndex1'
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 58
    object cdsAbfIcmABF_CODABF: TStringField
      FieldName = 'ABF_CODABF'
      Size = 3
    end
    object cdsAbfIcmCODEMP: TStringField
      FieldName = 'CODEMP'
      KeyFields = 'CODEMP'
      Size = 3
    end
    object cdsAbfIcmCODITE: TStringField
      FieldName = 'CODITE'
      KeyFields = 'CODITE'
      Size = 5
    end
    object cdsAbfIcmCODEST: TStringField
      FieldName = 'CODEST'
      Size = 2
    end
    object cdsAbfIcmABF_IVA_ST_ENT_PEF: TCurrencyField
      FieldName = 'ABF_IVA_ST_ENT_PEF'
    end
    object cdsAbfIcmABF_IVA_ST_ENT_PEJ: TCurrencyField
      FieldName = 'ABF_IVA_ST_ENT_PEJ'
    end
    object cdsAbfIcmABF_IVA_ST_ENT_PER: TCurrencyField
      FieldName = 'ABF_IVA_ST_ENT_PER'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_NCO: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_NCO'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_CCO: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_CCO'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_CNC: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_CNC'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_CTA: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_CTA'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_PRU: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_PRU'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_SNA: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_SNA'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_IND: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_IND'
    end
    object cdsAbfIcmABF_IVA_ST_SAI_TRS: TCurrencyField
      FieldName = 'ABF_IVA_ST_SAI_TRS'
    end
    object cdsAbfIcmABF_IVA_ST_ENT_PES: TCurrencyField
      FieldName = 'ABF_IVA_ST_ENT_PES'
    end
    object cdsAbfIcmCODABF: TStringField
      FieldName = 'CODABF'
      Size = 3
    end
    object cdsAbfIcmABF_BASICM_ENT_PEF: TCurrencyField
      FieldName = 'ABF_BASICM_ENT_PEF'
    end
    object cdsAbfIcmABF_BASICM_ENT_PEJ: TCurrencyField
      FieldName = 'ABF_BASICM_ENT_PEJ'
    end
    object cdsAbfIcmABF_BASICM_ENT_PER: TCurrencyField
      FieldName = 'ABF_BASICM_ENT_PER'
    end
    object cdsAbfIcmABF_BASICM_SAI_NCO: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_NCO'
    end
    object cdsAbfIcmABF_BASICM_SAI_CCO: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_CCO'
    end
    object cdsAbfIcmABF_BASICM_SAI_CNC: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_CNC'
    end
    object cdsAbfIcmABF_BASICM_SAI_CTA: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_CTA'
    end
    object cdsAbfIcmABF_BASICM_SAI_PRU: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_PRU'
    end
    object cdsAbfIcmABF_BASICM_SAI_SNA: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_SNA'
    end
    object cdsAbfIcmABF_BASICM_SAI_IND: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_IND'
    end
    object cdsAbfIcmABF_BASICM_SAI_TRS: TCurrencyField
      FieldName = 'ABF_BASICM_SAI_TRS'
    end
    object cdsAbfIcmABF_BASICM_ENT_PES: TCurrencyField
      FieldName = 'ABF_BASICM_ENT_PES'
    end
    object cdsAbfIcmABF_ALQICM_ENT_PEF: TCurrencyField
      FieldName = 'ABF_ALQICM_ENT_PEF'
    end
    object cdsAbfIcmABF_ALQICM_ENT_PEJ: TCurrencyField
      FieldName = 'ABF_ALQICM_ENT_PEJ'
    end
    object cdsAbfIcmABF_ALQICM_ENT_PER: TCurrencyField
      FieldName = 'ABF_ALQICM_ENT_PER'
    end
    object cdsAbfIcmABF_ALQICM_SAI_NCO: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_NCO'
    end
    object cdsAbfIcmABF_ALQICM_SAI_CCO: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_CCO'
    end
    object cdsAbfIcmABF_ALQICM_SAI_CNC: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_CNC'
    end
    object cdsAbfIcmABF_ALQICM_SAI_CTA: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_CTA'
    end
    object cdsAbfIcmABF_ALQICM_SAI_PRU: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_PRU'
    end
    object cdsAbfIcmABF_ALQICM_SAI_SNA: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_SNA'
    end
    object cdsAbfIcmABF_ALQICM_SAI_IND: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_IND'
    end
    object cdsAbfIcmABF_ALQICM_SAI_TRS: TCurrencyField
      FieldName = 'ABF_ALQICM_SAI_TRS'
    end
    object cdsAbfIcmABF_ALQICM_ENT_PES: TCurrencyField
      FieldName = 'ABF_ALQICM_ENT_PES'
    end
    object cdsAbfIcmABF_BASRET_ENT_PEF: TCurrencyField
      FieldName = 'ABF_BASRET_ENT_PEF'
    end
    object cdsAbfIcmABF_BASRET_ENT_PEJ: TCurrencyField
      FieldName = 'ABF_BASRET_ENT_PEJ'
    end
    object cdsAbfIcmABF_BASRET_ENT_PER: TCurrencyField
      FieldName = 'ABF_BASRET_ENT_PER'
    end
    object cdsAbfIcmABF_BASRET_SAI_NCO: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_NCO'
    end
    object cdsAbfIcmABF_BASRET_SAI_CCO: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_CCO'
    end
    object cdsAbfIcmABF_BASRET_SAI_CNC: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_CNC'
    end
    object cdsAbfIcmABF_BASRET_SAI_CTA: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_CTA'
    end
    object cdsAbfIcmABF_BASRET_SAI_PRU: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_PRU'
    end
    object cdsAbfIcmABF_BASRET_SAI_SNA: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_SNA'
    end
    object cdsAbfIcmABF_BASRET_SAI_IND: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_IND'
    end
    object cdsAbfIcmABF_BASRET_SAI_TRS: TCurrencyField
      FieldName = 'ABF_BASRET_SAI_TRS'
    end
    object cdsAbfIcmABF_BASRET_ENT_PES: TCurrencyField
      FieldName = 'ABF_BASRET_ENT_PES'
    end
    object cdsAbfIcmABF_ALQRET_ENT_PEF: TCurrencyField
      FieldName = 'ABF_ALQRET_ENT_PEF'
    end
    object cdsAbfIcmABF_ALQRET_ENT_PEJ: TCurrencyField
      FieldName = 'ABF_ALQRET_ENT_PEJ'
    end
    object cdsAbfIcmABF_ALQRET_ENT_PER: TCurrencyField
      FieldName = 'ABF_ALQRET_ENT_PER'
    end
    object cdsAbfIcmABF_ALQRET_SAI_NCO: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_NCO'
    end
    object cdsAbfIcmABF_ALQRET_SAI_CCO: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_CCO'
    end
    object cdsAbfIcmABF_ALQRET_SAI_CNC: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_CNC'
    end
    object cdsAbfIcmABF_ALQRET_SAI_CTA: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_CTA'
    end
    object cdsAbfIcmABF_ALQRET_SAI_PRU: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_PRU'
    end
    object cdsAbfIcmABF_ALQRET_SAI_SNA: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_SNA'
    end
    object cdsAbfIcmABF_ALQRET_SAI_IND: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_IND'
    end
    object cdsAbfIcmABF_ALQRET_SAI_TRS: TCurrencyField
      FieldName = 'ABF_ALQRET_SAI_TRS'
    end
    object cdsAbfIcmABF_ALQRET_ENT_PES: TCurrencyField
      FieldName = 'ABF_ALQRET_ENT_PES'
    end
    object cdsAbfIcmABF_RICMPR_SAI_CNC: TStringField
      FieldName = 'ABF_RICMPR_SAI_CNC'
      Size = 1
    end
    object cdsAbfIcmABF_RICMPR_ENT_PEF: TStringField
      FieldName = 'ABF_RICMPR_ENT_PEF'
      Size = 1
    end
    object cdsAbfIcmABF_RICMPR_ENT_PEJ: TStringField
      FieldName = 'ABF_RICMPR_ENT_PEJ'
      Size = 1
    end
    object cdsAbfIcmABF_RICMPR_ENT_PER: TStringField
      FieldName = 'ABF_RICMPR_ENT_PER'
      Size = 1
    end
    object cdsAbfIcmABF_RICMPR_ENT_PES: TStringField
      FieldName = 'ABF_RICMPR_ENT_PES'
      Size = 1
    end
    object cdsAbfIcmABF_RICMPR_SAI_SNA: TStringField
      FieldName = 'ABF_RICMPR_SAI_SNA'
      Size = 1
    end
    object cdsAbfIcmABF_CODSIT_ENT_PEF: TStringField
      FieldName = 'ABF_CODSIT_ENT_PEF'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_ENT_PEJ: TStringField
      FieldName = 'ABF_CODSIT_ENT_PEJ'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_ENT_PER: TStringField
      FieldName = 'ABF_CODSIT_ENT_PER'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_NCO: TStringField
      FieldName = 'ABF_CODSIT_SAI_NCO'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_CCO: TStringField
      FieldName = 'ABF_CODSIT_SAI_CCO'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_CNC: TStringField
      FieldName = 'ABF_CODSIT_SAI_CNC'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_CTA: TStringField
      FieldName = 'ABF_CODSIT_SAI_CTA'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_PRU: TStringField
      FieldName = 'ABF_CODSIT_SAI_PRU'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_SNA: TStringField
      FieldName = 'ABF_CODSIT_SAI_SNA'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_IND: TStringField
      FieldName = 'ABF_CODSIT_SAI_IND'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_SAI_TRS: TStringField
      FieldName = 'ABF_CODSIT_SAI_TRS'
      Size = 3
    end
    object cdsAbfIcmABF_CODSIT_ENT_PES: TStringField
      FieldName = 'ABF_CODSIT_ENT_PES'
      Size = 3
    end
  end
end
