inherited frmFatTotalizadorEmpresa: TfrmFatTotalizadorEmpresa
  BorderIcons = [biSystemMenu]
  Caption = 'Totalizador por Empresa'
  DefaultMonitor = dmMainForm
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object DBGridCitel1: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 189
    Align = alClient
    DataSource = dsEmpresas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        Expanded = False
        FieldName = 'EMPDES'
        Title.Caption = 'Empresa de Destino'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRITE'
        Title.Caption = 'Total dos Itens'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRCON'
        Title.Caption = 'Total Geral'
        Width = 100
        Visible = True
      end>
  end
  object dsEmpresas: TDataSource
    Left = 248
    Top = 120
  end
end
