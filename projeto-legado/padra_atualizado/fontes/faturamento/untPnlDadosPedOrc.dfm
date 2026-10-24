object frmPnlDadosPedOrc: TfrmPnlDadosPedOrc
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 2
  Caption = 'frmPnlDadosPedOrc'
  ClientHeight = 90
  ClientWidth = 1067
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    1067
    90)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TFlowPanel
    Left = 0
    Top = 0
    Width = 832
    Height = 90
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 132
    object btnGerarPDF: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 90
      Height = 23
      Caption = '[F8] - Gerar PDF'
      TabOrder = 0
      OnClick = btnGerarPDFClick
    end
    object btnEnviarEmail: TBitBtnLocked
      Left = 90
      Top = 0
      Width = 99
      Height = 23
      Caption = '[F9] - Enviar E-mail'
      TabOrder = 2
      OnClick = btnEnviarEmailClick
    end
    object btnBaixaPedido: TBitBtnLocked
      Left = 189
      Top = 0
      Width = 252
      Height = 23
      Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
      TabOrder = 3
      OnClick = btnBaixaPedidoClick
    end
    object btnItensPend: TBitBtnLocked
      Left = 441
      Top = 0
      Width = 155
      Height = 23
      Caption = '[F11] Mostrar itens pendentes'
      TabOrder = 4
      OnClick = btnItensPendClick
    end
    object btnImpSep: TBitBtnLocked
      Left = 596
      Top = 0
      Width = 142
      Height = 23
      Caption = '[F7] - Imprimir Separa'#231#227'o'
      TabOrder = 5
      Visible = False
      OnClick = btnImpSepClick
    end
    object btnGerCab: TBitBtnLocked
      Left = 0
      Top = 23
      Width = 156
      Height = 23
      Caption = '[F6] - Gerar Cabe'#231'alho Word'
      TabOrder = 8
      OnClick = btnGerCabClick
    end
    object btnLibNegada: TBitBtnLocked
      Left = 156
      Top = 23
      Width = 195
      Height = 23
      Caption = '[F5] Exibir Motivo da Libera'#231#227'o Negada'
      TabOrder = 7
      OnClick = btnLibNegadaClick
    end
    object btnEfetivarOrcamento: TBitBtnLocked
      Left = 351
      Top = 23
      Width = 180
      Height = 23
      Caption = '[F4] Efetivar Or'#231'amento em Pedido'
      TabOrder = 6
      OnClick = btnEfetivarOrcamentoClick
    end
    object btnLegendaStatus: TBitBtnLocked
      Left = 531
      Top = 23
      Width = 155
      Height = 23
      Caption = '[Alt+F1] - Legenda Status'
      TabOrder = 9
      Visible = False
      OnClick = btnLegendaStatusClick
    end
    object btnGerarXLS: TBitBtnLocked
      Left = 686
      Top = 23
      Width = 91
      Height = 23
      Caption = '[F12] - Gerar XLS'
      TabOrder = 1
      OnClick = btnGerarXLSClick
    end
    object btnLimpSep: TBitBtnLocked
      Left = 0
      Top = 46
      Width = 142
      Height = 23
      Caption = '[Alt+F2] - Limpar Separa'#231#227'o'
      TabOrder = 10
      Visible = False
      OnClick = btnLimpSepClick
    end
    object btnCobrancaYapay: TBitBtnLocked
      Left = 142
      Top = 46
      Width = 210
      Height = 23
      Caption = '[Alt + F12] - Abrir Cobran'#231'a Online Yapay'
      TabOrder = 11
      OnClick = btnCobrancaYapayClick
    end
    object btnSituacaoItens: TBitBtnLocked
      Left = 352
      Top = 46
      Width = 198
      Height = 23
      Caption = '[Alt+F11] - Mostra situa'#231#227'o dos itens'
      TabOrder = 12
      OnClick = btnSituacaoItensClick
    end
    object btnEnviarWpp: TBitBtnLocked
      Left = 550
      Top = 46
      Width = 155
      Height = 23
      Caption = '[Alt+F9] - Enviar Whatsapp'
      TabOrder = 13
      OnClick = btnEnviarWppClick
    end
    object lblTotRegistros: TLabel
      Left = 705
      Top = 46
      Width = 106
      Height = 13
      Align = alCustom
      Caption = 'Total de Registros:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btnProfis: TBitBtnLocked
      Left = 0
      Top = 69
      Width = 136
      Height = 23
      Caption = '[ Alt+F6 ] - Profissionais'
      TabOrder = 14
      Visible = False
      OnClick = btnProfisClick
    end
    object btnPedidosVinculados: TBitBtnLocked
      Left = 136
      Top = 69
      Width = 161
      Height = 23
      Caption = '[ Alt+F5 ] - Pedidos Vinculados'
      TabOrder = 15
      Visible = False
      OnClick = btnPedidosVinculadosClick
    end
  end
  object grpLegenda: TGroupBox
    Left = 832
    Top = 0
    Width = 235
    Height = 90
    Align = alRight
    TabOrder = 1
    ExplicitHeight = 132
    DesignSize = (
      235
      90)
    object Shape1: TShape
      Left = 14
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = clBlack
    end
    object Label1: TLabel
      Left = 33
      Top = 4
      Width = 85
      Height = 13
      Caption = 'Pedidos de Venda'
    end
    object Shape2: TShape
      Left = 14
      Top = 71
      Width = 13
      Height = 13
      Anchors = [akLeft, akBottom]
      Brush.Color = clBlue
      ExplicitTop = 46
    end
    object Label2: TLabel
      Left = 33
      Top = 71
      Width = 140
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Pedidos de Ordem de Servi'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 46
    end
    object Shape3: TShape
      Left = 14
      Top = 36
      Width = 13
      Height = 13
      Anchors = [akLeft]
      Brush.Color = clPurple
      ExplicitTop = 25
    end
    object Label3: TLabel
      Left = 33
      Top = 36
      Width = 195
      Height = 13
      Anchors = [akLeft]
      Caption = 'Pedidos de Venda Baixados Parcialmente'
      ExplicitTop = 25
    end
  end
  object chkExibirTodosPed: TCheckBox
    Left = 8
    Top = 71
    Width = 140
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Exibir todos os pedidos'
    TabOrder = 2
    OnClick = chkExibirTodosPedClick
    ExplicitTop = 115
  end
end
