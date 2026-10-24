inherited frmFilasImpressaoNFCe: TfrmFilasImpressaoNFCe
  Left = 357
  Top = 261
  Width = 342
  Height = 315
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Selecione a Fila de Impress'#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 342
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 270
    Width = 336
    ExplicitTop = 270
    ExplicitWidth = 293
    inherited FlwBotoes: TFlowPanel
      Width = 332
      ExplicitTop = 2
      ExplicitWidth = 289
    end
  end
  inherited pgcDados: TPageControl
    Height = 1
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object dbgPonImp: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 336
    Height = 270
    Align = alClient
    DataSource = dtsFilNfc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgPonImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FIL_DESCRI'
        Title.Caption = 'Fila de Impress'#227'o'
        Width = 300
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 270
    Width = 336
    ExplicitTop = 270
    ExplicitWidth = 293
    inherited pnlNomeForm: TPanel
      Left = 190
      Width = 146
      ExplicitLeft = 147
      ExplicitWidth = 146
    end
    inherited pnlInfo: TPanel
      Width = 190
      ExplicitWidth = 147
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 96
  end
  object dtsFilNfc: TDataSource
    Left = 104
    Top = 192
  end
end
