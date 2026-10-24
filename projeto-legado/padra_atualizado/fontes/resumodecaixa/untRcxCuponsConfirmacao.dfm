inherited frmRcxCuponsConfirmacao: TfrmRcxCuponsConfirmacao
  Width = 712
  Height = 356
  Caption = 'Cupons fiscais para confirma'#231#227'o'
  Position = poScreenCenter
  ExplicitWidth = 712
  ExplicitHeight = 356
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 287
    Width = 706
    ExplicitTop = 287
    ExplicitWidth = 706
    inherited btnSair: TBitBtnLocked
      Left = 623
      ExplicitLeft = 623
    end
  end
  object dbgDocumentos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 706
    Height = 287
    Align = alClient
    DataSource = dtsDocumentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FIS_NUMDOC'
        Title.Caption = 'Documento'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIS_DTAENT'
        Title.Caption = 'Data'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIS_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 233
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FIS_VLRTOT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIS_NOMVEN'
        Title.Caption = 'Vendedor'
        Width = 165
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 315
    Width = 706
    ExplicitTop = 315
    ExplicitWidth = 706
    inherited pnlNomeForm: TPanel
      Left = 535
      ExplicitLeft = 535
    end
    inherited pnlInfo: TPanel
      Width = 535
      ExplicitWidth = 535
    end
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    Left = 192
    Top = 120
  end
  object dtsDocumentos: TDataSource
    DataSet = qryDocumentos
    Left = 232
    Top = 120
  end
end
