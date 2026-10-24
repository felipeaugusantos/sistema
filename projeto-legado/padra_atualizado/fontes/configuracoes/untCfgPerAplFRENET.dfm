inherited frmPerAplFRENET: TfrmPerAplFRENET
  Width = 415
  Height = 493
  Caption = 'Percentual para consulta FRENET por Estado'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 415
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 409
    ExplicitTop = 420
    ExplicitWidth = 409
    inherited FlwBotoes: TFlowPanel
      Width = 405
      ExplicitWidth = 405
    end
    inherited btnSair: TBitBtnLocked
      Left = 329
      ExplicitLeft = 329
    end
  end
  inherited pnlStatus: TPanel
    Top = 448
    Width = 409
    ExplicitTop = 448
    ExplicitWidth = 409
    inherited pnlNomeForm: TPanel
      Left = 238
      ExplicitLeft = 238
    end
    inherited pnlInfo: TPanel
      Width = 238
      ExplicitWidth = 238
    end
  end
  object dbgPerApl: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 409
    Height = 420
    Align = alClient
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgPerAplKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PER_ESTADO'
        ReadOnly = True
        Title.Caption = 'Estado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PER_DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 250
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PER_PERCEN'
        Title.Alignment = taCenter
        Title.Caption = 'Percentual'
        Width = 70
        Visible = True
      end>
  end
end
