inherited frmRelacaoItensPedRefOR: TfrmRelacaoItensPedRefOR
  Width = 717
  Height = 414
  BorderIcons = [biSystemMenu]
  Caption = 'Itens com diferen'#231'a referente ao pedido '
  Position = poScreenCenter
  ExplicitWidth = 717
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 327
    Width = 711
    TabOrder = 4
    ExplicitTop = 324
    ExplicitWidth = 711
  end
  inherited pnlStatus: TPanel
    Top = 373
    Width = 711
    TabOrder = 3
    ExplicitTop = 370
    ExplicitWidth = 711
    inherited pnlNomeForm: TPanel
      Left = 540
      ExplicitLeft = 540
    end
    inherited pnlInfo: TPanel
      Width = 540
      ExplicitWidth = 540
    end
  end
  inherited pgcDados: TPageControl
    Top = -100
    Width = 17
    Height = 9
    Align = alNone
    TabOrder = 2
    ExplicitTop = -100
    ExplicitWidth = 17
    ExplicitHeight = 9
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 9
      ExplicitHeight = 429
    end
  end
  object dbgDados: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 711
    Height = 327
    Align = alClient
    DataSource = dsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDadosDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'd.Item'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o Item'
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMLOT'
        Title.Caption = 'N'#186' Lote'
        Width = 72
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDDIG'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtde. Digitada'
        Width = 78
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtde. Pedido'
        Width = 71
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SALDIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 94
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDDIF'
        Title.Alignment = taRightJustify
        Title.Caption = 'Diferen'#231'a'
        Width = 68
        Visible = True
      end>
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 327
    Width = 711
    Height = 46
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 324
    object shpDigAcm: TShape
      Left = 9
      Top = 9
      Width = 12
      Height = 12
      Brush.Color = clBlue
    end
    object Label1: TLabel
      Left = 26
      Top = 8
      Width = 251
      Height = 14
      Caption = 'Itens com quantidade digitadas acima do necess'#225'rio'
    end
    object Label2: TLabel
      Left = 26
      Top = 23
      Width = 255
      Height = 14
      Caption = 'Itens com quantidade digitadas abaixo do necess'#225'rio'
    end
    object shpDigAbx: TShape
      Left = 9
      Top = 24
      Width = 12
      Height = 12
      Brush.Color = clRed
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 720
    Top = 168
  end
  object dsDados: TDataSource
    Left = 592
    Top = 320
  end
end
