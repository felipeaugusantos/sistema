inherited frmFatMostraDivergenciasPedOrc: TfrmFatMostraDivergenciasPedOrc
  Left = 175
  Top = 219
  Width = 791
  Height = 311
  BorderIcons = [biSystemMenu]
  Caption = 'Itens com Diverg'#234'ncia de Pre'#231'o'
  Position = poMainFormCenter
  ExplicitWidth = 791
  ExplicitHeight = 311
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 240
    Width = 785
    Height = 26
    ExplicitTop = 240
    ExplicitWidth = 785
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 704
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 781
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 706
      Top = 2
      Align = alRight
      ExplicitLeft = 702
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 785
    Height = 240
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 195
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNIDAD'
        Title.Caption = 'UN'
        Width = 20
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'QTD'
        Width = 57
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNIANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Un. Antigo'
        Width = 67
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Antigo'
        Width = 72
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNICOM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Un. Combin.'
        Width = 68
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTCOM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Combin.'
        Width = 76
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNIATU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Un. Atual'
        Width = 68
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTATU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Atual'
        Width = 67
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 266
    Width = 785
    ExplicitTop = 266
    ExplicitWidth = 785
    inherited pnlNomeForm: TPanel
      Left = 614
      ExplicitLeft = 614
    end
    inherited pnlInfo: TPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  object dtsItens: TDataSource
    Left = 384
    Top = 80
  end
end
