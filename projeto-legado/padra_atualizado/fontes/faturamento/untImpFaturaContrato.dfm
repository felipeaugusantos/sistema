inherited frmImpFaturaContrato: TfrmImpFaturaContrato
  Width = 612
  Height = 315
  Caption = 'Imprimir Faturas do Contrato'
  Position = poMainFormCenter
  ExplicitWidth = 612
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 242
    Width = 606
    ExplicitTop = 242
    ExplicitWidth = 606
    inherited FlwBotoes: TFlowPanel
      Width = 602
      ExplicitWidth = 602
      object btnSelectodas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 115
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F2] &Selecionar Todas'
        TabOrder = 0
        OnClick = btnSelectodasClick
      end
      object btnDesmarcartodas: TBitBtnLocked
        Left = 115
        Top = 0
        Width = 115
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F3] &Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcartodasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 85
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 1
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 523
      ExplicitLeft = 523
    end
  end
  inherited pnlStatus: TPanel
    Top = 270
    Width = 606
    ExplicitTop = 270
    ExplicitWidth = 606
    inherited pnlNomeForm: TPanel
      Left = 435
      ExplicitLeft = 435
    end
    inherited pnlInfo: TPanel
      Width = 435
      ExplicitWidth = 435
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 606
    Height = 242
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object dbgFaturasContrato: TDBGridCitel
      Left = 1
      Top = 1
      Width = 604
      Height = 240
      Align = alClient
      DataSource = dtsSelecaoFaturas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgFaturasContratoDrawColumnCell
      OnDblClick = dbgFaturasContratoDblClick
      OnKeyDown = dbgFaturasContratoKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Caption = 'Documento'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Caption = 'Esp'#233'cie'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Caption = 'Empresa'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_PARCEL'
          Title.Caption = 'Parcela'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTAVEN'
          Title.Caption = 'Dta. Venc.'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_VALDUP'
          Title.Caption = 'Valor da Parcela'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTAREC'
          Title.Caption = 'Dta. Pagto.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_VALREC'
          Title.Caption = 'Valor Pago'
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 184
  end
  object cdsSelecaoFaturas: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CTR_PARCEL'
    Params = <>
    Left = 440
    Top = 168
    object cdsSelecaoFaturasCTR_NUMDUP: TStringField
      FieldName = 'CTR_NUMDUP'
      Size = 12
    end
    object cdsSelecaoFaturasCTR_ESPDOC: TStringField
      FieldName = 'CTR_ESPDOC'
      Size = 3
    end
    object cdsSelecaoFaturasCTR_CODEMP: TStringField
      FieldName = 'CTR_CODEMP'
      Size = 3
    end
    object cdsSelecaoFaturasCTR_PARCEL: TStringField
      FieldName = 'CTR_PARCEL'
      Size = 3
    end
    object cdsSelecaoFaturasCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object cdsSelecaoFaturasCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
      currency = True
    end
    object cdsSelecaoFaturasCTR_DTAREC: TDateField
      FieldName = 'CTR_DTAREC'
    end
    object cdsSelecaoFaturasCTR_VALREC: TFloatField
      FieldName = 'CTR_VALREC'
      currency = True
    end
    object cdsSelecaoFaturasIMPRIM: TBooleanField
      FieldName = 'IMPRIM'
    end
  end
  object dtsSelecaoFaturas: TDataSource
    DataSet = cdsSelecaoFaturas
    Left = 488
    Top = 104
  end
end
