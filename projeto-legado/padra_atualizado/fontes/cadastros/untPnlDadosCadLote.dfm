object frmPnlDadosCadLote: TfrmPnlDadosCadLote
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmPnlDadosCadLote'
  ClientHeight = 54
  ClientWidth = 880
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblAvsVal: TLabel
    Left = 166
    Top = 20
    Width = 391
    Height = 13
    Caption = 
      '* Linha inteira em negrito refere-se a data de fabrica'#231#227'o mais a' +
      'ntiga.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object btnMostraEstoque: TBitBtnLocked
    Left = 8
    Top = 15
    Width = 150
    Height = 25
    Caption = '[ F6 ] Estoque das lojas'
    TabOrder = 0
    OnClick = btnMostraEstoqueClick
  end
  object grpLegenda: TGroupBox
    Left = 571
    Top = 0
    Width = 309
    Height = 54
    Align = alRight
    TabOrder = 1
    object ShapeChapa: TShape
      Left = 6
      Top = 30
      Width = 13
      Height = 13
      Brush.Color = clRed
    end
    object LabelChapa: TLabel
      Left = 25
      Top = 30
      Width = 278
      Height = 13
      Caption = 'Chapas j'#225' utilizadas em outros pedidos ou no pedido atual'
    end
    object ShapeMenorPrecoVenda: TShape
      Left = 6
      Top = 11
      Width = 13
      Height = 13
      Brush.Color = clGreen
    end
    object LabelMenorPrecoVenda: TLabel
      Left = 23
      Top = 11
      Width = 154
      Height = 13
      Caption = 'Lote com menor Pre'#231'o de Venda'
    end
  end
end
