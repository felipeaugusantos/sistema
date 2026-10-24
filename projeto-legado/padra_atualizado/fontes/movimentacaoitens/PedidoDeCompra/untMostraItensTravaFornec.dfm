inherited frmMostraItensTravaFornec: TfrmMostraItensTravaFornec
  Height = 556
  BorderStyle = bsSizeable
  Caption = 'Itens que n'#227'o se encontram na Tabela de Pre'#231'o do Fornecedor'
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 473
    Width = 473
    ExplicitTop = 473
    ExplicitWidth = 473
    inherited FlwBotoes: TFlowPanel
      Width = 392
    end
    inherited btnSair: TBitBtnLocked
      Left = 394
      Top = 2
      Height = 24
      Align = alRight
      Caption = 'Sair'
      ExplicitLeft = 398
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 473
    Height = 379
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 61
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 399
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object mmoNaoEntraPedido: TMemo [3]
    Left = 0
    Top = 379
    Width = 473
    Height = 46
    TabStop = False
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '                          Os itens acima ser'#227'o excluidos do pedi' +
        'do de compra!')
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Visible = False
    StyleElements = [seBorder]
  end
  object mmoEntraPedido: TMemo [4]
    Left = 0
    Top = 425
    Width = 473
    Height = 48
    TabStop = False
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '                           Os itens acima permanecer'#227'o no pedido' +
        ' de compra!'
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Visible = False
    StyleElements = [seBorder]
  end
  inherited pnlStatus: TPanel
    Top = 501
    Width = 473
    ExplicitTop = 501
    ExplicitWidth = 473
    inherited pnlNomeForm: TPanel
      Left = 302
      ExplicitLeft = 302
    end
    inherited pnlInfo: TPanel
      Width = 302
      ExplicitWidth = 302
    end
  end
end
