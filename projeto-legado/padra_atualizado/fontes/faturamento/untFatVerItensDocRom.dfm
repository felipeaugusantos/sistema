inherited frmFatVerItensDocRom: TfrmFatVerItensDocRom
  Left = 208
  Top = 234
  Width = 800
  Height = 400
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'Itens do Documento'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter: TSplitter [0]
    Left = 633
    Top = 0
    Height = 317
    Align = alRight
    ExplicitLeft = 0
    ExplicitTop = 314
    ExplicitHeight = 734
  end
  inherited pnlBotoes: TPanel
    Top = 317
    Width = 784
    ExplicitTop = 317
    ExplicitWidth = 734
    inherited FlwBotoes: TFlowPanel
      Width = 703
      ExplicitWidth = 653
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 655
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 784
    ExplicitTop = 345
    ExplicitWidth = 734
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 563
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 563
    end
  end
  object grbItens: TGroupBox [3]
    Left = 0
    Top = 0
    Width = 633
    Height = 317
    Align = alClient
    Caption = 'Itens'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    ExplicitWidth = 734
    ExplicitHeight = 165
    object dbgItens: TDBGridCitel
      Left = 2
      Top = 16
      Width = 629
      Height = 299
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgItensKeyDown
      CorZebra = clMoneyGreen
      Zebra = True
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DET_CODITE'
          Title.Caption = 'Item'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 301
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_NUMLOT'
          Title.Caption = 'Lote'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TURENT'
          Title.Caption = 'Turno'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DET_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtd. Romaneio'
          Width = 76
          Visible = True
        end>
    end
  end
  object grbVolumes: TGroupBox [4]
    Left = 636
    Top = 0
    Width = 148
    Height = 317
    Align = alRight
    Caption = 'Volumes'
    TabOrder = 3
    object dbgVolumes: TDBGridCitel
      Left = 2
      Top = 16
      Width = 144
      Height = 299
      Align = alClient
      BiDiMode = bdLeftToRight
      DataSource = dtsVolumes
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgVolumesDrawColumnCell
      OnKeyDown = dbgItensKeyDown
      OnTitleClick = dbgVolumesTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMVOL'
          Title.Alignment = taRightJustify
          Width = 53
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'BIPADO'
          Title.Alignment = taCenter
          Width = 52
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 392
    Top = 152
  end
  object dtsVolumes: TDataSource
    DataSet = cdsVolumes
    Left = 520
    Top = 152
  end
  object cdsVolumes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 152
    object cdsVolumesNUMVOL: TIntegerField
      DisplayLabel = 'Num.Vol.'
      FieldName = 'NUMVOL'
    end
    object cdsVolumesBIPADO: TStringField
      DisplayLabel = 'Bipado?'
      FieldName = 'BIPADO'
      Size = 3
    end
  end
end
