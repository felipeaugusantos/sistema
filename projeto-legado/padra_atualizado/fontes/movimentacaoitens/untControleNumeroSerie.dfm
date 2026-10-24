inherited frmControleNumeroSerie: TfrmControleNumeroSerie
  Width = 1111
  Height = 403
  Caption = 'Itens com Controle por N'#250'mero de S'#233'rie'
  ExplicitWidth = 1111
  ExplicitHeight = 403
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 332
    Width = 1105
    ExplicitTop = 332
    ExplicitWidth = 1105
    inherited FlwBotoes: TFlowPanel
      Width = 1101
      ExplicitWidth = 1101
      inherited btnConfirma: TBitBtnLocked
        Width = 129
        ModalResult = 0
        ExplicitWidth = 129
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1025
      ExplicitLeft = 1025
    end
  end
  inherited pnlStatus: TPanel
    Top = 358
    Width = 1105
    ExplicitTop = 358
    ExplicitWidth = 1105
    inherited pnlNomeForm: TPanel
      Left = 934
      ExplicitLeft = 934
    end
    inherited pnlInfo: TPanel
      Width = 934
      ExplicitWidth = 934
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1105
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      'Os Itens abaixo possuem controle por n'#250'mero de s'#233'rie. Ser'#225' neces' +
      's'#225'rio inform'#225'-los.'
    TabOrder = 2
  end
  object dbgConsulta: TDBGridCitel [3]
    Left = 0
    Top = 41
    Width = 1105
    Height = 291
    Align = alClient
    DataSource = dtsNumeroSerie
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnCellClick = dbgConsultaCellClick
    OnDrawColumnCell = dbgConsultaDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODBAR'
        ReadOnly = True
        Title.Caption = 'Cod. Barras'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 223
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Caption = 'Marca'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 205
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFAB'
        ReadOnly = True
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 142
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMSER'
        ReadOnly = True
        Title.Caption = 'N'#250'mero de S'#233'rie'
        Width = 103
        Visible = True
      end>
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 96
  end
  object dtsNumeroSerie: TDataSource
    DataSet = cdsNumeroSerie
    Left = 232
    Top = 168
  end
  object cdsNumeroSerie: TUniClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    AfterScroll = cdsNumeroSerieAfterScroll
    Left = 144
    Top = 168
    object cdsNumeroSerieCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 5
    end
    object cdsNumeroSerieDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 80
    end
    object cdsNumeroSerieQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsNumeroSerieNUMSER: TStringField
      FieldName = 'NUMSER'
      Size = 3000
    end
    object cdsNumeroSerieEMPITE: TStringField
      FieldName = 'EMPITE'
      Size = 3
    end
    object cdsNumeroSerieAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsNumeroSerieCODBAR: TStringField
      FieldName = 'CODBAR'
    end
    object cdsNumeroSerieDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 60
    end
    object cdsNumeroSerieREFERE: TStringField
      FieldName = 'REFERE'
      Size = 60
    end
    object cdsNumeroSerieCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 60
    end
    object cdsNumeroSerieVALIDO: TBooleanField
      FieldName = 'VALIDO'
    end
  end
  object cdsSeries: TUniClientDataSet
    Aggregates = <>
    MasterSource = dtsNumeroSerie
    PacketRecords = 0
    Params = <>
    Left = 304
    Top = 248
    object cdsSeriesLINHA: TIntegerField
      FieldName = 'LINHA'
    end
    object cdsSeriesSER_CODITE: TStringField
      FieldName = 'SER_CODITE'
    end
    object cdsSeriesSER_NUMSER: TStringField
      FieldName = 'SER_NUMSER'
      Size = 60
    end
  end
end
