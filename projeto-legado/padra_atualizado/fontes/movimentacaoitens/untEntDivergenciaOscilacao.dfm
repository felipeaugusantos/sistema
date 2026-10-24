inherited frmEntDivergenciaOscilacao: TfrmEntDivergenciaOscilacao
  Width = 626
  Height = 309
  Caption = 'Itens Divergentes'
  OnDestroy = FormDestroy
  ExplicitWidth = 626
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 236
    Width = 620
    ExplicitTop = 236
    ExplicitWidth = 620
    inherited btnSair: TBitBtnLocked
      Left = 537
      ExplicitLeft = 537
    end
    inherited btnConfirma: TBitBtnLocked
      ModalResult = 0
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 620
    Height = 236
    Align = alClient
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
        FieldName = 'DESITE'
        Title.Caption = 'Item'
        Width = 434
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRPED'
        Title.Caption = 'Valor Pedido'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRDIG'
        Title.Caption = 'Valor digitado'
        Width = 70
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 264
    Width = 620
    ExplicitTop = 264
    ExplicitWidth = 620
    inherited pnlNomeForm: TPanel
      Left = 449
      ExplicitLeft = 449
    end
    inherited pnlInfo: TPanel
      Width = 449
      ExplicitWidth = 449
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
end
