inherited frmFatCancelamentosPDV: TfrmFatCancelamentosPDV
  Width = 647
  Height = 310
  Caption = 'Documentos pendentes para cancelamento'
  Position = poScreenCenter
  ExplicitWidth = 647
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 238
    Width = 641
    ExplicitTop = 238
    ExplicitWidth = 641
    object Label1: TLabel [0]
      Left = 144
      Top = 5
      Width = 258
      Height = 18
      Caption = '[ENTER] Para cancelar o documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 637
      Visible = False
      ExplicitTop = 2
      ExplicitWidth = 637
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 558
      ExplicitLeft = 558
    end
  end
  inherited pnlStatus: TPanel
    Top = 266
    Width = 641
    ExplicitTop = 266
    ExplicitWidth = 641
    inherited pnlNomeForm: TPanel
      Left = 470
      ExplicitLeft = 470
    end
    inherited pnlInfo: TPanel
      Width = 470
      ExplicitWidth = 470
    end
  end
  object dbgCancelamentos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 641
    Height = 238
    Align = alClient
    DataSource = dtsCancelamentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgCancelamentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CAN_NUMSER'
        Title.Caption = 'N'#250'mero S'#233'rie'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAN_NUMCOO'
        Title.Caption = 'COO'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIS_NUMDOC'
        Title.Caption = 'N'#250'mero IF'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 295
        Visible = True
      end>
  end
  object qryCancelamentos: TUniQuery
    Connection = frmModulo.Database
    Left = 176
    Top = 96
  end
  object dtsCancelamentos: TDataSource
    DataSet = qryCancelamentos
    Left = 232
    Top = 96
  end
end
