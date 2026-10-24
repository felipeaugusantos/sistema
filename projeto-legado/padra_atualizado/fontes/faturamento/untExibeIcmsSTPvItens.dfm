inherited frmExibeIcmsSTPvItens: TfrmExibeIcmsSTPvItens
  Width = 884
  Height = 534
  Caption = 'ICMS ST Parte Venda'
  Position = poScreenCenter
  ExplicitWidth = 884
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 462
    Width = 878
    ExplicitTop = 462
    ExplicitWidth = 878
    inherited btnSair: TBitBtnLocked
      Left = 795
      ExplicitLeft = 795
    end
  end
  inherited pnlStatus: TPanel
    Top = 490
    Width = 878
    ExplicitTop = 490
    ExplicitWidth = 878
    inherited pnlNomeForm: TPanel
      Left = 707
      ExplicitLeft = 707
    end
    inherited pnlInfo: TPanel
      Width = 707
      ExplicitWidth = 707
    end
  end
  object DBGridCitel1: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 878
    Height = 462
    Align = alClient
    DataSource = dtsDados
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_SEQUEN'
        Title.Caption = 'Sequen.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODEMP'
        Title.Caption = 'Empresa'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_TIPABF'
        Title.Caption = 'Tip Abrv.'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ESTDES'
        Title.Caption = 'UF Cliente'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODSIT'
        Title.Caption = 'Sit. Trib.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_VALIVA'
        Title.Caption = 'IVA'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ICMSAI'
        Title.Caption = 'Icm. Sai.'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CALCST'
        Title.Caption = 'Calc. ST?'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ICSTPV'
        Title.Caption = 'Icm. ST Pv.'
        Width = 78
        Visible = True
      end>
  end
  object dtsDados: TDataSource
    Left = 432
    Top = 256
  end
end
