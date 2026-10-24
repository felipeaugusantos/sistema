inherited frmConfirmarGeracaoPedidos: TfrmConfirmarGeracaoPedidos
  Width = 941
  Height = 433
  Caption = 'Confirmar Gera'#231#227'o de Pedidos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 941
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 935
    ExplicitTop = 360
    ExplicitWidth = 935
    inherited FlwBotoes: TFlowPanel
      Width = 931
      ExplicitWidth = 931
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 193
        Height = 22
        Caption = '[ F10 ] Confirmar Gera'#231#227'o Pedidos'
        ModalResult = 1
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnGerarExcel: TBitBtnLocked
        Left = 193
        Top = 0
        Width = 149
        Height = 22
        Caption = '[ F9 ] Gerar Excel'
        TabOrder = 1
        OnClick = btnGerarExcelClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 736
      Top = 2
      Width = 193
      Caption = '&Cancelar Gera'#231#227'o de Pedido'
      ExplicitLeft = 736
      ExplicitTop = 2
      ExplicitWidth = 193
    end
  end
  inherited pnlStatus: TPanel
    Top = 388
    Width = 935
    ExplicitTop = 388
    ExplicitWidth = 935
    inherited pnlNomeForm: TPanel
      Left = 764
      ExplicitLeft = 764
    end
    inherited pnlInfo: TPanel
      Width = 764
      ExplicitWidth = 764
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 32
    Width = 935
    Height = 315
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 2
    object cxgProdutos: TcxGrid
      Left = 0
      Top = 0
      Width = 935
      Height = 315
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvEstoque: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
          end
          item
            Format = '0.00'
            Kind = skSum
          end
          item
            Format = '0.00'
            Kind = skSum
          end
          item
            Format = '0.00'
            Kind = skSum
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxgProdutosSALDOS
          end
          item
            Format = '0.00'
            Kind = skSum
          end
          item
            Format = '0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxgProdutosCODIGO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Options.Moving = False
        end
        object cxgProdutosDESITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'DESITE'
          Options.Moving = False
          Width = 643
        end
        object cxgProdutosSALDOS: TcxGridDBColumn
          Caption = 'Saldos'
          DataBinding.FieldName = 'SALDOS'
          Options.Moving = False
        end
      end
      object cxgProdutosLevel1: TcxGridLevel
        GridView = cxvEstoque
      end
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 935
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 2
      Top = 7
      Width = 927
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Existe saldo dispon'#237'vel dos produtos abaixo em outras lojas. Cas' +
        'o deseje, verifique atrav'#233's do bot'#227'o "[F11] Estoque de Lojas" as' +
        ' possibilidades de transfer'#234'ncias.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
  end
  object prgProgresso: TProgressBar [4]
    Left = 0
    Top = 347
    Width = 935
    Height = 13
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object SaveDialog: TSaveDialog
    Left = 184
    Top = 216
  end
end
