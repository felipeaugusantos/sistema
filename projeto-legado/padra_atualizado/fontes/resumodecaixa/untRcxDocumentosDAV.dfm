inherited frmRcxDocumentosDAV: TfrmRcxDocumentosDAV
  Width = 675
  Height = 414
  ActiveControl = dbgDocumentos
  Caption = 'Documentos para Emitir DAV'
  Position = poOwnerFormCenter
  ExplicitWidth = 675
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 342
    Width = 669
    ExplicitTop = 342
    ExplicitWidth = 669
    object Label1: TLabel [0]
      Left = 10
      Top = 5
      Width = 224
      Height = 19
      Caption = '[ENTER] Imprime Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 586
      ExplicitLeft = 586
    end
  end
  inherited pnlStatus: TPanel
    Top = 370
    Width = 669
    ExplicitTop = 370
    ExplicitWidth = 669
    inherited pnlNomeForm: TPanel
      Left = 498
      ExplicitLeft = 498
    end
    inherited pnlInfo: TPanel
      Width = 498
      ExplicitWidth = 498
    end
  end
  object dbgDocumentos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 669
    Height = 342
    Align = alClient
    DataSource = dtsDocumentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgDocumentosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'FGO_NUMDOC'
        Title.Caption = 'Documento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 422
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FGO_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Width = 96
        Visible = True
      end>
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    Left = 336
    Top = 160
  end
  object dtsDocumentos: TDataSource
    DataSet = qryDocumentos
    Left = 376
    Top = 160
  end
end
