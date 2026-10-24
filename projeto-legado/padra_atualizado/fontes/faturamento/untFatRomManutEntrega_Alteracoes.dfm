inherited frmFatRomManutEntrega_Alteracoes: TfrmFatRomManutEntrega_Alteracoes
  Width = 725
  Height = 274
  BorderIcons = [biSystemMenu]
  Caption = 'Romaneio - Manuten'#231#227'o da Entrega (Altera'#231#245'es)'
  Position = poMainFormCenter
  ExplicitWidth = 725
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 201
    Width = 719
    ExplicitTop = 201
    ExplicitWidth = 719
    inherited FlwBotoes: TFlowPanel
      Width = 715
      ExplicitWidth = 715
    end
    inherited btnSair: TBitBtnLocked
      Left = 639
      ExplicitLeft = 639
    end
  end
  inherited pnlStatus: TPanel
    Top = 229
    Width = 719
    ExplicitTop = 229
    ExplicitWidth = 719
    inherited pnlNomeForm: TPanel
      Left = 469
      Width = 250
      ExplicitLeft = 469
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 469
      ExplicitWidth = 469
    end
  end
  object dbeAlteracoes: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 719
    Height = 201
    Align = alClient
    DataSource = dscAlteracoes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
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
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'OCO_DTAHOR'
        Title.Alignment = taCenter
        Title.Caption = 'Dt./Hr. Ocorr'#234'ncia'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        Title.Caption = 'Operador'
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OCO_DESOCO'
        Title.Caption = 'Ocorr'#234'ncia'
        Width = 357
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 124
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
    Top = 124
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 124
  end
  object qryAlteracoes: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 272
    Top = 124
  end
  object dscAlteracoes: TDataSource
    DataSet = qryAlteracoes
    Left = 304
    Top = 124
  end
end
