inherited frmPontosImpressao: TfrmPontosImpressao
  Left = 10
  Top = 10
  Width = 299
  Height = 315
  Anchors = []
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Selecione o Ponto de Impress'#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 299
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 270
    Width = 293
    ExplicitTop = 270
    ExplicitWidth = 293
    inherited FlwBotoes: TFlowPanel
      Width = 289
      ExplicitWidth = 289
    end
  end
  inherited pnlStatus: TPanel
    Top = 270
    Width = 293
    ExplicitTop = 270
    ExplicitWidth = 293
    inherited pnlNomeForm: TPanel
      Left = 146
      Width = 147
      ExplicitLeft = 146
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 146
      ExplicitWidth = 146
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
    Width = 293
    Height = 270
    Align = alClient
    DataSource = dtsPonImp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'PON_NOMPON'
        Title.Caption = 'Ponto de Impress'#227'o'
        Width = 250
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 96
  end
  object dtsPonImp: TDataSource
    Left = 104
    Top = 192
  end
end
