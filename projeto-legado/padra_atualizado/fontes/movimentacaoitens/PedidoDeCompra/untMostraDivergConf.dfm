inherited frmMostraDivergConf: TfrmMostraDivergConf
  Width = 590
  Height = 419
  BorderStyle = bsSizeable
  Caption = 'Diverg'#234'ncias da Confer'#234'ncia'
  ExplicitWidth = 590
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 337
    Width = 574
    ExplicitTop = 337
    ExplicitWidth = 574
    inherited btnSair: TBitBtnLocked
      Left = 491
      ExplicitLeft = 491
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 95
      Height = 22
      Caption = '[ F10 ] Confirma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
    end
  end
  object MemoFocus1: TMemoFocus [2]
    Left = 0
    Top = 302
    Width = 574
    Height = 35
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'Os itens acima est'#227'o com a quantidade conferida maior que a quan' +
        'tidade do pedido.'
      
        'Ao confirmar a grava'#231#227'o a quantidade conferida passar'#225' a ser a q' +
        'uantidade do item no pedido.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    StyleElements = [seFont, seBorder]
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    Texto = 
      'Os itens acima est'#227'o com a quantidade conferida maior que a quan' +
      'tidade do pedido.<<csq>>Ao confirmar a grava'#231#227'o a quantidade con' +
      'ferida passar'#225' a ser a quantidade do item no pedido.<<csq>>'
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 574
    Height = 302
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxvItensColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 60
      end
      object cxvItensColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 325
      end
      object cxvItensColumn3: TcxGridDBColumn
        Caption = 'Qtd. Conferida'
        DataBinding.FieldName = 'QTDCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxvItensColumn4: TcxGridDBColumn
        Caption = 'Qtd. Pedido'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited pnlStatus: TPanel
    Top = 365
    Width = 574
    ExplicitTop = 365
    ExplicitWidth = 574
    inherited pnlNomeForm: TPanel
      Left = 403
      ExplicitLeft = 403
    end
    inherited pnlInfo: TPanel
      Width = 403
      ExplicitWidth = 403
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 136
  end
end
