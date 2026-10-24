inherited frmTefCitelDadosCartao: TfrmTefCitelDadosCartao
  Width = 813
  Height = 553
  BorderIcons = [biSystemMenu]
  Caption = 'Cart'#245'es Pendentes'
  Position = poScreenCenter
  ExplicitWidth = 813
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 480
    Width = 807
    ExplicitTop = 480
    ExplicitWidth = 807
    inherited FlwBotoes: TFlowPanel
      Width = 803
      TabOrder = 1
      ExplicitWidth = 803
    end
    inherited btnSair: TBitBtnLocked
      Left = 724
      TabOrder = 0
      ExplicitLeft = 724
    end
  end
  inherited pnlStatus: TPanel
    Top = 508
    Width = 807
    ExplicitTop = 508
    ExplicitWidth = 807
    inherited pnlNomeForm: TPanel
      Left = 636
      ExplicitLeft = 636
    end
    inherited pnlInfo: TPanel
      Width = 636
      ExplicitWidth = 636
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 46
    Width = 807
    Height = 434
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 3
    object cxGridCitel1: TcxGridCitel
      Left = 0
      Top = 0
      Width = 807
      Height = 434
      Align = alClient
      TabOrder = 0
      TabStop = False
      object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitel1DBTableViewCitel1TFT_DTATRA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'TFT_DTATRA'
          Visible = False
          Width = 66
        end
        object cxGridCitel1DBTableViewCitel1TFT_HRATRA: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'TFT_HRATRA'
          Visible = False
        end
        object cxGridCitel1DBTableViewCitel1TFT_NUMDOC: TcxGridDBColumn
          Caption = 'N'#186' Documento'
          DataBinding.FieldName = 'TFT_NUMDOC'
          Visible = False
          Width = 82
        end
        object cxGridCitel1DBTableViewCitel1TFT_NUMNSU: TcxGridDBColumn
          Caption = 'N'#186' Nsu'
          DataBinding.FieldName = 'TFT_NUMNSU'
          Visible = False
          Width = 108
        end
        object cxGridCitel1DBTableViewCitel1TFT_VALTRA: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'TFT_VALTRA'
          Visible = False
        end
        object cxGridCitel1DBTableViewCitel1TFT_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'TFT_STATUS'
          Visible = False
          Width = 78
        end
        object cxGridCitel1DBTableViewCitel1SERVIDOR: TcxGridDBColumn
          Caption = 'Servidor'
          DataBinding.FieldName = 'SERVIDOR'
          Visible = False
          Width = 100
        end
        object cxGridCitel1DBTableViewCitel1USUARIO: TcxGridDBColumn
          Caption = 'Usu'#225'rio'
          DataBinding.FieldName = 'USUARIO'
          Visible = False
          Width = 105
        end
        object cxGridCitel1DBTableViewCitel1MAQUINA: TcxGridDBColumn
          Caption = 'M'#225'quina'
          DataBinding.FieldName = 'MAQUINA'
          Visible = False
          Width = 106
        end
        object cxGridCitel1DBTableViewCitelNUMCUPOM: TcxGridDBColumn
          Caption = 'N'#186' Documento'
          DataBinding.FieldName = 'NUMCUPOM'
          Visible = False
          Width = 87
        end
        object cxGridCitel1DBTableViewCitelVALOR: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALOR'
          Width = 94
        end
        object cxGridCitel1DBTableViewCitelDATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          Width = 85
        end
        object cxGridCitel1DBTableViewCitelHORA: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'HORA'
          Width = 88
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitel1DBTableViewCitel1
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 807
    Height = 46
    Align = alTop
    TabOrder = 4
    object Label1: TLabel
      Left = 114
      Top = 1
      Width = 565
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Transa'#231#245'es pendentes dever'#227'o ser regularizadas no Relat'#243'rio do T' +
        'EF em:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object btnLinkCliSitef: TBitBtnLocked
      Left = 114
      Top = 20
      Width = 565
      Height = 22
      Caption = 'https://sitefexpress.softwareexpress.com.br/sitefweb'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      TabOrder = 0
      OnClick = btnLinkCliSitefClick
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 88
  end
  object dtsDados: TDataSource
    Left = 452
    Top = 312
  end
  object CdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 312
    object CdsDadosCUPOM: TStringField
      FieldName = 'CUPOM'
      Size = 10
    end
    object CdsDadosIDCUPOM: TStringField
      FieldName = 'IDCUPOM'
      Size = 10
    end
    object CdsDadosDATA: TDateField
      FieldName = 'DATA'
    end
    object CdsDadosHORA: TTimeField
      FieldName = 'HORA'
    end
    object CdsDadosVALOR: TStringField
      FieldName = 'VALOR'
    end
  end
end
