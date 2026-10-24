inherited frmFatRetiraDigSeparador: TfrmFatRetiraDigSeparador
  Left = 161
  Top = 210
  Width = 1024
  Height = 566
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Expedi'#231#227'o de Retira - Digita'#231#227'o do Separador'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitLeft = -235
  ExplicitWidth = 1024
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 441
    Width = 1018
    Height = 0
    BevelOuter = bvRaised
    Color = 16770261
    TabOrder = 1
    Visible = False
    ExplicitTop = 441
    ExplicitWidth = 1018
    ExplicitHeight = 0
    DesignSize = (
      1018
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 659
      Top = -25
      Width = 98
      ExplicitLeft = 659
      ExplicitTop = -25
      ExplicitWidth = 98
    end
  end
  inherited pnlStatus: TPanel
    Top = 521
    Width = 1018
    TabOrder = 2
    ExplicitTop = 521
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object dbgPedidos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 441
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgPedidosDrawColumnCell
    OnKeyDown = dbgPedidosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODVEN'
        Title.Alignment = taCenter
        Title.Caption = 'Vend.'
        Width = 35
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAENT'
        Title.Alignment = taCenter
        Title.Caption = 'Data Emiss'#227'o'
        Width = 72
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'HORENT'
        Title.Alignment = taCenter
        Title.Caption = 'Hora Emiss'#227'o'
        Width = 76
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Width = 125
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Esp.'
        Width = 24
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Cliente'
        Width = 209
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMSEP'
        Title.Caption = 'Separador'
        Width = 178
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ENTURG'
        Title.Alignment = taCenter
        Title.Caption = 'Urgente'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMSAN'
        Title.Caption = 'Separador Anterior (*)'
        Width = 178
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MENSAGEM'
        Title.Caption = 'Mensagem'
        Width = 348
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACAO'
        Title.Caption = 'Observa'#231#227'o'
        Width = 318
        Visible = True
      end>
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 465
    Width = 1018
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    object lbl1: TLabel
      Left = 0
      Top = 0
      Width = 1018
      Height = 56
      Align = alClient
      Alignment = taRightJustify
      Caption = 
        'Pressione [Enter] para informar ou limpar o separador  - [F3] Co' +
        'nfer'#234'ncia dos Produtos - [F5] para atualizar os documentos - [F6' +
        '] Imprimir Separa'#231#227'o     '
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 185
      ExplicitWidth = 833
      ExplicitHeight = 14
    end
    object lblSemSal: TLabel
      Left = 26
      Top = 11
      Width = 59
      Height = 14
      Caption = 'Separados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpSemSal: TShape
      Left = 10
      Top = 12
      Width = 12
      Height = 13
      Brush.Color = clBlue
    end
    object shpTotCon: TShape
      Left = 10
      Top = 32
      Width = 12
      Height = 13
      Brush.Color = clPurple
    end
    object lblTotCon: TLabel
      Left = 27
      Top = 31
      Width = 118
      Height = 14
      Caption = 'Totalmente conferido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlLegendEmpVen: TPanel [4]
    Left = 0
    Top = 441
    Width = 1018
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object shp2: TShape
      Left = 10
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clYellow
    end
    object lbl3: TLabel
      Left = 26
      Top = 6
      Width = 184
      Height = 14
      Caption = 'Vendedores de outras empresas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shp3: TShape
      Left = 225
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clLime
    end
    object lbl4: TLabel
      Left = 242
      Top = 6
      Width = 182
      Height = 14
      Caption = 'Vendedores da mesma empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSepAnt: TLabel
      Left = 439
      Top = 6
      Width = 467
      Height = 14
      Caption = 
        '(*) Separador anterior: Operador que foi definido antes de alter' +
        'ar e regravar o pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 88
  end
  object tmrTmpIan: TTimer
    Enabled = False
    OnTimer = tmrTmpIanTimer
    Left = 216
    Top = 184
  end
  object tmrTmpRte: TTimer
    Enabled = False
    OnTimer = tmrTmpRteTimer
    Left = 168
    Top = 184
  end
end
