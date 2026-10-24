inherited frmDesfazerExpedicaoDesteDocumento: TfrmDesfazerExpedicaoDesteDocumento
  Width = 800
  Height = 462
  BorderIcons = [biSystemMenu]
  Caption = 'Desfazer expedi'#231#227'o deste documento'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 389
    Width = 794
    ExplicitTop = 389
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 714
      ExplicitLeft = 714
    end
  end
  inherited pnlStatus: TPanel
    Top = 417
    Width = 794
    ExplicitTop = 417
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 544
      Width = 250
      ExplicitLeft = 544
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 544
      ExplicitWidth = 544
    end
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 359
    Width = 794
    Height = 30
    Align = alBottom
    TabOrder = 3
    object btnLimpaExpedicao: TBitBtnLocked
      Left = 10
      Top = 4
      Width = 147
      Height = 22
      Caption = '[F3] Limpa Expedi'#231#227'o'
      TabOrder = 0
      OnClick = btnLimpaExpedicaoClick
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 0
    Width = 794
    Height = 359
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODITE'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Width = 407
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SIGUNI'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDDOC'
        Title.Alignment = taRightJustify
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDEXP'
        Title.Alignment = taRightJustify
        Width = 100
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 452
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 240
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 164
    Top = 184
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 164
    Top = 136
    object cdsItensINCGER: TStringField
      FieldName = 'INCGER'
    end
    object cdsItensINCDET: TStringField
      FieldName = 'INCDET'
    end
    object cdsItensCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensSIGUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensQTDDOC: TFloatField
      DisplayLabel = 'Qtd. Doc.'
      FieldName = 'QTDDOC'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensQTDEXP: TFloatField
      DisplayLabel = 'Qtd. Exp.'
      FieldName = 'QTDEXP'
      DisplayFormat = '#,##0.00'
    end
  end
end
