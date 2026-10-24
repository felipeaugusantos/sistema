inherited frmConsultaOcorrenciasCRMEmergenciais: TfrmConsultaOcorrenciasCRMEmergenciais
  Caption = 'Consulta Ocorr'#234'ncias Emerg'#234'nciais'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 430
    ExplicitTop = 430
  end
  inherited pgcDados: TPageControl
    Height = 430
    ExplicitHeight = 430
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 398
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 430
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgOcorrencias: TcxGrid
      Left = 1
      Top = 1
      Width = 767
      Height = 428
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgOcorrenciasDBTableView1: TcxGridDBTableView
        OnDblClick = dbgOcorrenciasDBTableView1DblClick
        OnKeyDown = dbgOcorrenciasDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsOcorrencias
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.PullFocusing = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhuma ocorr'#234'ncia dispon'#237'vel>'
        OptionsView.GroupByBox = False
        object dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 192
        end
        object dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn
          Caption = 'Protocolo'
          DataBinding.FieldName = 'OCO_PROTOC'
          Width = 149
        end
        object dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'GOC_CODGOC'
          Width = 45
        end
        object dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn
          Caption = 'Grupo Ocorr'#234'ncia'
          DataBinding.FieldName = 'GOC_DESGOC'
          Width = 150
        end
        object dbgOcorrenciasDBTableView1OCO_CODTOC: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'OCO_CODTOC'
          Width = 45
        end
        object dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn
          Caption = 'Tipo de Ocorr'#234'ncia'
          DataBinding.FieldName = 'TOC_DESTOC'
          Width = 169
        end
        object dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn
          Caption = 'Data Inclus'#227'o'
          DataBinding.FieldName = 'OCO_DTAINC'
          Width = 79
        end
        object dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn
          Caption = 'Hora Inclus'#227'o'
          DataBinding.FieldName = 'OCO_HORINC'
          Width = 83
        end
        object dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn
          Caption = 'Data Conclus'#227'o'
          DataBinding.FieldName = 'OCO_DTACON'
          Width = 91
        end
        object dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn
          Caption = 'Hora Conclus'#227'o'
          DataBinding.FieldName = 'OCO_HORCON'
          Width = 91
        end
        object dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn
          Caption = 'Operador Destino'
          DataBinding.FieldName = 'OPE_NOMOPE'
          Width = 165
        end
        object dbgOcorrenciasDBTableView1OCO_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'OCO_CODEMP'
          Width = 57
        end
      end
      object dbgOcorrenciasLevel1: TcxGridLevel
        GridView = dbgOcorrenciasDBTableView1
      end
    end
  end
  object pnlBotoesInferiores: TPanel [4]
    Left = 0
    Top = 430
    Width = 769
    Height = 31
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object btnSairBaixa: TBitBtnLocked
      Left = 644
      Top = 4
      Width = 116
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 0
      OnClick = btnSairBaixaClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 111
      Height = 21
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    inherited pnlInfo: TPanel
    end
  end
  object cdsOcorrencias: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOcorrencias'
    AfterScroll = cdsOcorrenciasAfterScroll
    Left = 391
    Top = 152
    object cdsOcorrenciasOCO_CODOCO: TStringField
      FieldName = 'OCO_CODOCO'
      Size = 8
    end
    object cdsOcorrenciasOCO_CODTOC: TStringField
      FieldName = 'OCO_CODTOC'
      Size = 5
    end
    object cdsOcorrenciasTOC_DESTOC: TStringField
      FieldName = 'TOC_DESTOC'
      Size = 40
    end
    object cdsOcorrenciasOCO_CODCLI: TStringField
      FieldName = 'OCO_CODCLI'
      Size = 8
    end
    object cdsOcorrenciasGOC_CODGOC: TStringField
      FieldName = 'GOC_CODGOC'
      Size = 5
    end
    object cdsOcorrenciasGOC_DESGOC: TStringField
      FieldName = 'GOC_DESGOC'
      Size = 40
    end
    object cdsOcorrenciasCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsOcorrenciasOCO_DTAINC: TDateField
      FieldName = 'OCO_DTAINC'
    end
    object cdsOcorrenciasOCO_HORINC: TTimeField
      FieldName = 'OCO_HORINC'
    end
    object cdsOcorrenciasOCO_DTACON: TDateField
      FieldName = 'OCO_DTACON'
    end
    object cdsOcorrenciasOCO_HORCON: TTimeField
      FieldName = 'OCO_HORCON'
    end
    object cdsOcorrenciasOCO_OPEOCO: TStringField
      FieldName = 'OCO_OPEOCO'
      Size = 3
    end
    object cdsOcorrenciasOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsOcorrenciasOCO_CODEMP: TStringField
      FieldName = 'OCO_CODEMP'
      Size = 3
    end
    object cdsOcorrenciasOCO_PROTOC: TStringField
      FieldName = 'OCO_PROTOC'
      Size = 22
    end
  end
  object dtsOcorrencias: TDataSource
    DataSet = cdsOcorrencias
    Left = 359
    Top = 152
  end
  object dspOcorrencias: TUniDataSetProvider
    DataSet = qryOcorrencias
    Options = []
    Left = 328
    Top = 152
  end
  object qryOcorrencias: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 296
    Top = 152
  end
end
