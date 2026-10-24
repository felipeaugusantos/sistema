inherited frmPedidosNaoFaturadosDoMesmoCliente: TfrmPedidosNaoFaturadosDoMesmoCliente
  Width = 800
  Height = 360
  Caption = 'Pedidos n'#227'o faturados do mesmo cliente do pedido selecionado'
  ExplicitWidth = 800
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 289
    Width = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 714
    end
  end
  inherited pnlStatus: TPanel
    Top = 315
    Width = 794
    inherited pnlNomeForm: TPanel
      Left = 494
      Width = 300
      ExplicitLeft = 585
      ExplicitWidth = 300
    end
    inherited pnlInfo: TPanel
      Width = 494
    end
  end
  object pnlRodape: TPanel [2]
    Left = 0
    Top = 248
    Width = 794
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 216
    ExplicitTop = 216
    ExplicitWidth = 185
    object lblCarregarPedidosColor: TColorLabel
      Left = 685
      Top = 14
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblCarregarPedidos: TLabel
      Left = 290
      Top = 14
      Width = 368
      Height = 14
      Caption = 
        'Deseja carregar os pedidos do mesmo cliente que est'#227'o aqui na Ex' +
        'pedi'#231#227'o?'
    end
    object edtCarregarPedidos: TEditFocus
      Tag = 99
      Left = 664
      Top = 10
      Width = 15
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 0
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
  end
  object dbgPedidos: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 248
    Align = alClient
    DataSource = dtsPedidos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'DTAEMI'
        Title.Caption = 'Dt. Emiss'#227'o'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PEDIDO'
        Title.Caption = 'Pedido'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODVEN'
        Title.Caption = 'Vendedor'
        Width = 190
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRPED'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Pedido'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status do Pedido'
        Width = 215
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 256
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 40
  end
  object dtsPedidos: TDataSource
    Left = 288
    Top = 40
  end
end
