inherited frmFatSelContratos: TfrmFatSelContratos
  Width = 502
  ActiveControl = dbgContratos
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Contratos'
  ExplicitWidth = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 496
    ExplicitWidth = 496
    inherited FlwBotoes: TFlowPanel
      Width = 415
      ExplicitTop = 2
      ExplicitWidth = 492
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 417
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 413
    end
  end
  object dbgContratos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 496
    Height = 189
    Align = alClient
    DataSource = dtsContratos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgContratosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CON_CODCON'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CON_DESCON'
        Title.Caption = 'Nome'
        Width = 300
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CON_TOTCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 90
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Width = 496
    ExplicitWidth = 496
    inherited pnlNomeForm: TPanel
      Left = 325
      ExplicitLeft = 325
    end
    inherited pnlInfo: TPanel
      Width = 325
      ExplicitWidth = 325
    end
  end
  object dtsContratos: TDataSource
    Left = 88
    Top = 72
  end
end
