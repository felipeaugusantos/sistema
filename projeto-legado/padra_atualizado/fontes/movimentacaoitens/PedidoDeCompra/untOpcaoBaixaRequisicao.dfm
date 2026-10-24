inherited frmOpcaoBaixaRequisicao: TfrmOpcaoBaixaRequisicao
  Width = 800
  Height = 584
  Caption = 'Escolha a op'#231#227'o sobre o destino da requisi'#231#227'o:'
  ExplicitWidth = 800
  ExplicitHeight = 584
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 513
    Width = 794
    TabOrder = 1
    ExplicitTop = 338
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 714
      ExplicitLeft = 714
    end
  end
  inherited pnlStatus: TPanel
    Top = 539
    Width = 794
    TabOrder = 2
    ExplicitTop = 364
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object mmoInstru: TMemo [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 160
    Align = alTop
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    ExplicitTop = 97
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 160
    Width = 794
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 312
    object rdgOpcaoPedido: TRadioGroup
      Tag = 99
      Left = 12
      Top = 8
      Width = 593
      Height = 73
      Caption = 'Op'#231#245'es sobre a requisi'#231#227'o'
      Items.Strings = (
        
          'Desvincular as requisi'#231#245'es do pedido de compra selecionado e bai' +
          'xar o pedido, mantendo as requisi'#231#245'es em aberto'
        
          'Desvincular as requisi'#231#245'es do pedido de compra selecionado e neg' +
          'ar a requisi'#231#227'o')
      TabOrder = 0
      OnClick = rdgOpcaoPedidoClick
    end
  end
  object pnlMotivo: TPanel [5]
    Left = 0
    Top = 257
    Width = 794
    Height = 256
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMotivo'
    Enabled = False
    ShowCaption = False
    TabOrder = 5
    ExplicitLeft = 240
    ExplicitTop = 352
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 73
      Align = alTop
      BorderWidth = 2
      TabOrder = 0
      ExplicitTop = 8
      object rdgMotNeg: TRadioGroup
        Left = 3
        Top = 3
        Width = 788
        Height = 67
        Align = alClient
        Caption = 'Motivo para negar a requisi'#231#227'o:'
        ItemIndex = 0
        Items.Strings = (
          'N'#227'o ir'#225' comprar a mercadoria por motivo de for'#231'a maior'
          'Produto j'#225' possui saldo em estoque')
        TabOrder = 0
        OnClick = rdgMotNegClick
      end
    end
    object mmoJUSTIF: TMemoFocus
      Left = 0
      Top = 97
      Width = 794
      Height = 159
      Align = alClient
      BorderStyle = bsNone
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 534
      ExplicitHeight = 168
    end
    object Panel4: TPanel
      Left = 0
      Top = 73
      Width = 794
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Digite o motivo da negativa da  requisi'#231#227'o'
      TabOrder = 2
      ExplicitLeft = -3
      ExplicitTop = 76
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 640
    Top = 72
  end
end
