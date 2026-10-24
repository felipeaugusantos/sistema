inherited frmListaProfissionaisPD: TfrmListaProfissionaisPD
  Width = 486
  Height = 276
  BorderIcons = [biSystemMenu]
  Caption = 'frmListaProfissionaisPD'
  Position = poMainFormCenter
  ExplicitWidth = 486
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 204
    Width = 480
    Height = 27
    Visible = True
    ExplicitTop = 204
    ExplicitWidth = 480
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 476
      Height = 23
      ExplicitWidth = 476
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 399
      Top = 2
      ExplicitLeft = 399
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 231
    Width = 480
    ExplicitTop = 231
    ExplicitWidth = 480
    inherited pnlNomeForm: TPanel
      Left = 309
      ExplicitLeft = 309
    end
    inherited pnlInfo: TPanel
      Width = 309
      ExplicitWidth = 309
    end
  end
  inherited pgcDados: TPageControl
    Width = 480
    Height = 204
    ExplicitWidth = 480
    ExplicitHeight = 204
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 472
      ExplicitHeight = 172
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 480
    Height = 204
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgProf: TDBGridCitel
      Left = 1
      Top = 1
      Width = 478
      Height = 202
      Align = alClient
      DataSource = dtsProfi
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
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
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIS'
          Title.Caption = 'Profissional'
          Width = 345
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 344
  end
  object cdsProfi: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 128
    object cdsProfiCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 8
    end
    object cdsProfiPROFIS: TStringField
      FieldName = 'PROFIS'
      Size = 40
    end
  end
  object dtsProfi: TDataSource
    DataSet = cdsProfi
    Left = 600
    Top = 184
  end
end
