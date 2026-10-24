inherited frmSolicitacaoColorantesLojas: TfrmSolicitacaoColorantesLojas
  Left = 235
  Top = 332
  Width = 693
  Height = 544
  BorderStyle = bsDialog
  Caption = 'Informe as Lojas que fornecer'#227'o os itens Base/Colorantes'
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 693
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 473
    Width = 687
    Height = 26
    ExplicitTop = 473
    ExplicitWidth = 687
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 87
      Width = 521
      Height = 22
      TabOrder = 2
      ExplicitLeft = 87
      ExplicitWidth = 521
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 608
      Top = 2
      Align = alRight
      ModalResult = 2
      ExplicitLeft = 608
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 85
      Height = 22
      Align = alLeft
      Caption = '[F10] Confirma'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object dbgItensLoja: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 687
    Height = 273
    Align = alClient
    DataSource = dtsItens
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgItensLojaKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Item'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 282
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Loja Abast.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALLOC'
        ReadOnly = True
        Title.Caption = 'Saldo est. local'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALOUT'
        ReadOnly = True
        Title.Caption = 'Est. outras lojas'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 499
    Width = 687
    ExplicitTop = 499
    ExplicitWidth = 687
    inherited pnlNomeForm: TPanel
      Left = 516
      ExplicitLeft = 516
    end
    inherited pnlInfo: TPanel
      Width = 516
      ExplicitWidth = 516
    end
  end
  object dbgEstoque: TDBGridCitel [4]
    Left = 0
    Top = 273
    Width = 687
    Height = 200
    Align = alBottom
    DataSource = dtsEstoque
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
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
        FieldName = 'EMP_NOMEMP'
        Title.Caption = 'Empresa'
        Width = 266
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDOS'
        Title.Caption = 'Saldo'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALRES'
        Title.Caption = 'Saldo reserv. '
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDIS'
        Title.Caption = 'Saldo dispon.'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ENTFUT'
        Title.Caption = 'Ent. futuras'
        Width = 90
        Visible = True
      end>
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 248
    Top = 80
  end
  object dtsUsado: TDataSource
    Left = 256
    Top = 128
  end
  object dtsEstoque: TDataSource
    Left = 344
    Top = 256
  end
end
