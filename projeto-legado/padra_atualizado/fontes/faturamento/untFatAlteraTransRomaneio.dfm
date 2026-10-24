inherited frmFatAlteraTransRomaneio: TfrmFatAlteraTransRomaneio
  Left = 148
  Top = 137
  Width = 565
  Height = 350
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Global de Transportadora nos Pedidos de Venda'
  Position = poScreenCenter
  ExplicitWidth = 565
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 276
    Width = 559
    Height = 29
    TabOrder = 3
    ExplicitTop = 276
    ExplicitWidth = 559
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Top = 3
      Width = 555
      Height = 24
      ExplicitLeft = 2
      ExplicitTop = 3
      ExplicitWidth = 555
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 88
        Top = 0
        Width = 102
        Height = 22
        Caption = '[ F2 ] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 190
        Top = 0
        Width = 124
        Height = 22
        Caption = '[ F3 ] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 466
      Top = 2
      Width = 90
      ExplicitLeft = 466
      ExplicitTop = 2
      ExplicitWidth = 90
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 559
    Height = 56
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblRomaneio: TLabel
      Left = 8
      Top = 7
      Width = 47
      Height = 14
      Caption = 'Romaneio'
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 141
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      TabOrder = 0
      OnEnter = edtNumRomEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
  end
  object dbgDocumentos: TDBGridCitel [3]
    Left = 0
    Top = 56
    Width = 559
    Height = 220
    Align = alClient
    DataSource = dtsDocumentos
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDocumentosDrawColumnCell
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DOCUME'
        Title.Caption = 'Documento'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 279
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODVEN'
        Title.Caption = 'Vend.'
        Width = 32
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 78
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 305
    Width = 559
    TabOrder = 2
    ExplicitTop = 305
    ExplicitWidth = 559
    inherited pnlNomeForm: TPanel
      Left = 388
      ExplicitLeft = 388
    end
    inherited pnlInfo: TPanel
      Width = 388
      ExplicitWidth = 388
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 255
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 200
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 351
    Top = 152
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentos'
    AfterOpen = cdsDocumentosAfterOpen
    Left = 287
    Top = 152
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 255
    Top = 152
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 319
    Top = 152
  end
end
