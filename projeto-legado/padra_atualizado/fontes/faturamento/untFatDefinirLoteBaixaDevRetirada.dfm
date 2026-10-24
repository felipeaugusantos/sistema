inherited frmFatDefinirLoteBaixaDevRetirada: TfrmFatDefinirLoteBaixaDevRetirada
  Width = 676
  Height = 310
  Caption = 'Definir Lote/Armaz'#233'm'
  ExplicitWidth = 676
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 239
    Width = 670
    ExplicitTop = 239
    ExplicitWidth = 670
    inherited FlwBotoes: TFlowPanel
      Width = 666
      ExplicitWidth = 666
    end
    inherited btnSair: TBitBtnLocked
      Left = 587
      ExplicitLeft = 587
    end
  end
  inherited pnlStatus: TPanel
    Top = 265
    Width = 670
    ExplicitTop = 265
    ExplicitWidth = 670
    inherited pnlNomeForm: TPanel
      Left = 499
      ExplicitLeft = 499
    end
    inherited pnlInfo: TPanel
      Width = 499
      ExplicitWidth = 499
    end
  end
  object dbgGrid: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 670
    Height = 239
    Align = alClient
    DataSource = dtsGrid
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgGridKeyPress
    CorZebra = cl3DLight
    Zebra = True
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_PEDRET'
        Title.Caption = 'Pedido'
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Item'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 270
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDITE'
        ReadOnly = True
        Title.Caption = 'Quantidade'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NUMLOT'
        Title.Caption = 'Armaz'#233'm'
        Width = 100
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 48
  end
  object dtsGrid: TDataSource
    Left = 416
    Top = 49
  end
end
