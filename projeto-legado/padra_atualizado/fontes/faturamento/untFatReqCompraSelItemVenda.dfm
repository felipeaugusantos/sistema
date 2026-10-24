inherited frmFatReqCompraSelItemEspecialVenda: TfrmFatReqCompraSelItemEspecialVenda
  Width = 694
  Caption = 'Selecionar Item Especial do Pedido'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 694
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 688
    ExplicitWidth = 688
    inherited FlwBotoes: TFlowPanel
      Left = 102
      Width = 584
      ExplicitLeft = 102
      ExplicitWidth = 584
    end
    inherited btnSair: TBitBtnLocked
      Left = 605
      ExplicitLeft = 605
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 100
      Height = 24
      Align = alLeft
      Caption = '[F10] Confirmar'
      TabOrder = 2
      OnClick = BitBtnLocked1Click
    end
  end
  inherited pnlStatus: TPanel
    Width = 688
    ExplicitWidth = 688
    inherited pnlNomeForm: TPanel
      Left = 517
      ExplicitLeft = 517
    end
    inherited pnlInfo: TPanel
      Width = 517
      ExplicitWidth = 517
    end
  end
  object dbgItem: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 688
    Height = 189
    Align = alClient
    DataSource = dtsDados
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItemDrawColumnCell
    OnDblClick = dbgItemDblClick
    OnKeyDown = dbgItemKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FDO_CODITE'
        Title.Caption = 'Item'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 565
        Visible = True
      end>
  end
  object dtsDados: TDataSource
    Left = 168
    Top = 88
  end
end
