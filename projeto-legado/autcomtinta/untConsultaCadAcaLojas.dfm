inherited frmConsultaCadAcaLojas: TfrmConsultaCadAcaLojas
  Width = 514
  Height = 310
  ActiveControl = dbgSaldos
  Caption = 'Saldo das Lojas'
  Position = poMainFormCenter
  ExplicitWidth = 514
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 238
    Width = 508
    ExplicitTop = 238
    ExplicitWidth = 508
    inherited btnSair: TBitBtnLocked
      Left = 425
      ExplicitLeft = 425
    end
  end
  inherited pnlStatus: TPanel
    Top = 266
    Width = 508
    ExplicitTop = 266
    ExplicitWidth = 508
    inherited pnlNomeForm: TPanel
      Left = 337
      ExplicitLeft = 337
    end
    inherited pnlInfo: TPanel
      Width = 337
      ExplicitWidth = 337
    end
  end
  object dbgSaldos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 508
    Height = 238
    Align = alClient
    DataSource = dtsSaldos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgSaldosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ACA_EMPEST'
        Title.Caption = 'Empresa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOMEMP'
        Title.Caption = 'Nome Empresa'
        Width = 350
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ACA_SALDOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo'
        Visible = True
      end>
  end
  object dtsSaldos: TDataSource
    DataSet = qrySaldos
    Left = 160
    Top = 136
  end
  object qrySaldos: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      '  ACA_EMPEST,'
      '  EMP_NOMEMP,'
      '  ACA_SALDOS'
      'FROM'
      '  ACAGER'
      'JOIN CADEMP ON ACA_EMPEST = EMP_CODEMP'
      'WHERE'
      '  ACA_CODACA = :CODACA AND'
      '  ACA_CODEMP = :CODEMP ')
    Left = 128
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODACA'
      end
      item
        DataType = ftUnknown
        Name = 'CODEMP'
      end>
  end
end
