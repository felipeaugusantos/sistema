inherited frmRcxNFCePendentes: TfrmRcxNFCePendentes
  Width = 693
  Height = 429
  Caption = 'NFCes pendentes'
  Position = poScreenCenter
  ExplicitWidth = 693
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 347
    Width = 687
    Height = 37
    ExplicitTop = 347
    ExplicitWidth = 687
    ExplicitHeight = 37
    object lblReenviar: TLabel [0]
      Left = 11
      Top = 10
      Width = 147
      Height = 19
      Caption = 'F1 - Reenviar NFCe'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 683
      Height = 33
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 683
      ExplicitHeight = 33
    end
    inherited btnSair: TBitBtnLocked
      Left = 604
      Top = 8
      ExplicitLeft = 604
      ExplicitTop = 8
    end
    object btnAjustarConsumidor: TBitBtnLocked
      Left = 184
      Top = 5
      Width = 233
      Height = 27
      Hint = 
        'Confirma'#231#227'o de Cupom Simplificada - Esta rotina ir'#225' confirmar o ' +
        'Cupom em uma Nota Fiscal'
      Caption = '[F3] Ajustar Consumidor para esta Venda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      OnClick = btnAjustarConsumidorClick
    end
  end
  object dbgNFCes: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 687
    Height = 258
    Align = alClient
    DataSource = dtsNFCe
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgNFCesKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCON'
        Title.Caption = 'Cliente'
        Width = 433
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 95
        Visible = True
      end>
  end
  object dbeMensagem: TDBMemoFocus [3]
    Left = 0
    Top = 258
    Width = 687
    Height = 89
    Align = alBottom
    DataField = 'OBSERV'
    DataSource = dtsNFCe
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited pnlStatus: TPanel
    Top = 384
    Width = 687
    ExplicitTop = 384
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
  object dtsNFCe: TDataSource
    DataSet = qryNFCe
    Left = 296
    Top = 112
  end
  object qryNFCe: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    AfterScroll = qryNFCeAfterScroll
    Left = 336
    Top = 120
  end
end
