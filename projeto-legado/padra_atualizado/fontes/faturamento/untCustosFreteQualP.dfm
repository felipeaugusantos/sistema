inherited frmCustosFreteQualP: TfrmCustosFreteQualP
  Width = 724
  Height = 373
  Caption = 'Custos de Frete QUALP'
  ExplicitWidth = 724
  ExplicitHeight = 373
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 300
    Width = 718
    ExplicitTop = 300
    ExplicitWidth = 718
    inherited FlwBotoes: TFlowPanel
      Width = 714
      ExplicitWidth = 714
    end
    inherited btnSair: TBitBtnLocked
      Left = 638
      ExplicitLeft = 638
    end
  end
  inherited pnlStatus: TPanel
    Top = 328
    Width = 718
    ExplicitTop = 328
    ExplicitWidth = 718
    inherited pnlNomeForm: TPanel
      Left = 547
      ExplicitLeft = 547
    end
    inherited pnlInfo: TPanel
      Width = 547
      ExplicitWidth = 547
    end
  end
  object dbgRotas: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 718
    Height = 265
    TabStop = False
    Align = alClient
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
  end
  object pnlTotalizador: TPanel [3]
    Left = 0
    Top = 265
    Width = 718
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 14
      Top = 6
      Width = 72
      Height = 14
      Caption = 'Total Ped'#225'gios:'
    end
    object Label2: TLabel
      Left = 178
      Top = 6
      Width = 92
      Height = 14
      Caption = 'Total Combust'#237'veis:'
    end
    object Label3: TLabel
      Left = 554
      Top = 6
      Width = 53
      Height = 14
      Caption = 'Total Frete:'
    end
    object lblPedagio: TLabel
      Left = 89
      Top = 6
      Width = 39
      Height = 24
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCombustivel: TLabel
      Left = 273
      Top = 6
      Width = 39
      Height = 24
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 610
      Top = 6
      Width = 39
      Height = 24
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAcrescFrete: TLabel
      Left = 364
      Top = 6
      Width = 97
      Height = 14
      Caption = 'Acr'#233'sc. Frete Ve'#237'c.:'
    end
    object lblValorAcresc: TLabel
      Left = 464
      Top = 6
      Width = 39
      Height = 24
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 256
    Top = 176
    object cdsConsultaCIDADE: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 40
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsConsultaVALOR_COMBUSTIVEL: TFloatField
      DisplayLabel = 'Custo Combust'#237'vel'
      DisplayWidth = 20
      FieldName = 'VALOR_COMBUSTIVEL'
      DisplayFormat = ',0.00'
    end
    object cdsConsultaVALOR_PEDAGIO: TFloatField
      DisplayLabel = 'Custo Ped'#225'gio'
      DisplayWidth = 20
      FieldName = 'VALOR_PEDAGIO'
      DisplayFormat = ',0.00'
    end
    object cdsConsultaTOTAL: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 20
      FieldName = 'TOTAL'
      DisplayFormat = ',0.00'
    end
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 336
    Top = 176
  end
end
