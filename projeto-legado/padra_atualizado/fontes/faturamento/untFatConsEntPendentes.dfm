inherited frmFatConsEntPendentes: TfrmFatConsEntPendentes
  Left = 471
  Top = 118
  Width = 591
  Height = 475
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de Entregas Pendentes'
  Position = poMainFormCenter
  ExplicitWidth = 591
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 318
    Width = 585
    TabOrder = 4
    ExplicitTop = 318
    ExplicitWidth = 585
    inherited FlwBotoes: TFlowPanel
      Width = 581
      ExplicitWidth = 581
    end
    inherited btnSair: TBitBtnLocked
      Left = 915
      ExplicitLeft = 915
    end
  end
  inherited pnlStatus: TPanel
    Top = 430
    Width = 585
    TabOrder = 3
    ExplicitTop = 430
    ExplicitWidth = 585
    inherited pnlNomeForm: TPanel
      Left = 414
      ExplicitLeft = 414
    end
    inherited pnlInfo: TPanel
      Width = 414
      ExplicitWidth = 414
    end
  end
  inherited pgcDados: TPageControl
    Top = 43
    Width = 585
    Height = 275
    TabOrder = 2
    TabStop = False
    Visible = False
    ExplicitTop = 43
    ExplicitWidth = 585
    ExplicitHeight = 275
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 243
    end
  end
  object dbgConsulta: TDBGridCitel [3]
    Left = 0
    Top = 43
    Width = 585
    Height = 275
    Align = alClient
    DataSource = dsGrid
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnCellClick = dbgConsultaCellClick
    OnDrawColumnCell = dbgConsultaDrawColumnCell
    OnKeyDown = dbgConsultaKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DTAENT'
        Title.Caption = 'Data'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORENT'
        Title.Caption = 'Hora'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Emp'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCLI'
        Title.Caption = 'Cliente'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODTRA'
        Title.Caption = 'Transp.'
        Width = 45
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODOPE'
        Title.Caption = 'Vendedor'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOTORISTA'
        Title.Caption = 'Motorista'
        Width = 120
        Visible = True
      end>
  end
  object pnlDescricoes: TPanel [4]
    Left = 0
    Top = 340
    Width = 585
    Height = 90
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object lblMarca: TLabel
      Left = 4
      Top = 71
      Width = 274
      Height = 14
      Caption = '[ENTER] Exibe os itens do documento selecionado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 426
      Top = 71
      Width = 148
      Height = 14
      Caption = 'F10 - Visualizar Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeCliente: TDBEdit
      Left = 1
      Top = 1
      Width = 583
      Height = 22
      TabStop = False
      Align = alTop
      Color = 16770261
      DataField = 'CLIENTE'
      DataSource = dsGrid
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
    end
    object dbeTransp: TDBEdit
      Left = 1
      Top = 23
      Width = 583
      Height = 22
      TabStop = False
      Align = alTop
      Color = 16770261
      DataField = 'TRANSP'
      DataSource = dsGrid
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
    end
    object dbeVendedor: TDBEdit
      Left = 1
      Top = 45
      Width = 583
      Height = 22
      TabStop = False
      Align = alTop
      Color = 16770261
      DataField = 'VENDEDOR'
      DataSource = dsGrid
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
    end
  end
  object pnlFiltros: TPanel [5]
    Left = 0
    Top = 0
    Width = 585
    Height = 43
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblEmpresa: TLabel
      Left = 15
      Top = 14
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 63
      Top = 10
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 109
      Top = 10
      Width = 460
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnl1: TPanel [6]
    Left = 0
    Top = 318
    Width = 585
    Height = 22
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object lblSemSal: TLabel
      Left = 496
      Top = 4
      Width = 78
      Height = 14
      Caption = 'Entrega Urgente'
    end
    object shpSemSal: TShape
      Left = 478
      Top = 5
      Width = 12
      Height = 12
      Brush.Color = clRed
      Pen.Color = clRed
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 88
  end
  object cdsGrid: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 152
  end
  object dsGrid: TDataSource
    DataSet = cdsGrid
    Left = 432
    Top = 152
  end
end
