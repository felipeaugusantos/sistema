inherited frmAltPrecoFornecedorItensTabPrd: TfrmAltPrecoFornecedorItensTabPrd
  Left = 169
  Top = 161
  Width = 808
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Itens a serem alterados'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 808
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 534
    Width = 792
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 506
    Width = 792
    ExplicitTop = 506
    ExplicitWidth = 792
    DesignSize = (
      792
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 788
      ExplicitWidth = 788
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 792
    ExplicitTop = 545
    ExplicitWidth = 792
    inherited pnlNomeForm: TPanel
      Left = 652
      Width = 140
      ExplicitLeft = 652
      ExplicitWidth = 140
    end
    inherited pnlInfo: TPanel
      Width = 652
      ExplicitWidth = 652
      object lblContadorLocal: TLabel
        Left = 2
        Top = 2
        Width = 648
        Height = 12
        Align = alClient
        ExplicitWidth = 3
        ExplicitHeight = 14
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 792
    Height = 506
    Visible = False
    ExplicitWidth = 792
    ExplicitHeight = 506
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 784
      ExplicitHeight = 474
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 0
    Width = 792
    Height = 506
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
  end
  object pnlBotoesEnt: TPanel [5]
    Left = 0
    Top = 506
    Width = 792
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnMarTod: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 114
      Height = 24
      Align = alLeft
      Caption = '[ F3 ] Marca Todos'
      TabOrder = 1
      OnClick = btnMarTodClick
    end
    object btnDesTod: TBitBtnLocked
      Left = 227
      Top = 2
      Width = 114
      Height = 24
      Align = alLeft
      Caption = '[ F4] Desmarca Todos'
      TabOrder = 2
      OnClick = btnMarTodClick
    end
    object btnVoltar: TBitBtnLocked
      Left = 679
      Top = 2
      Width = 111
      Height = 24
      Align = alRight
      Caption = '[ Esc ] Voltar'
      TabOrder = 3
      OnClick = btnVoltarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 160
  end
  object dtsItens: TDataSource
    Left = 144
    Top = 160
  end
end
