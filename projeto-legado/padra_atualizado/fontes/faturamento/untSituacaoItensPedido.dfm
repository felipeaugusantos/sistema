inherited frmSituacaoItensPedido: TfrmSituacaoItensPedido
  Width = 1000
  Height = 402
  Caption = 'Situa'#231#227'o dos itens no pedido'
  Position = poMainFormCenter
  ExplicitWidth = 1000
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 329
    Width = 994
    ExplicitTop = 329
    ExplicitWidth = 1102
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 1098
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 1022
    end
  end
  inherited pnlStatus: TPanel
    Top = 357
    Width = 994
    ExplicitTop = 357
    ExplicitWidth = 1102
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 931
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 931
    end
  end
  object DBGridCitel1: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 994
    Height = 329
    Align = alClient
    DataSource = dtsItens
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
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 354
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODUNI'
        Title.Caption = 'UN'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        Title.Caption = 'Quantidade'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status'
        Width = 414
        Visible = True
      end>
  end
  object dtsItens: TDataSource
    Left = 712
    Top = 32
  end
end
