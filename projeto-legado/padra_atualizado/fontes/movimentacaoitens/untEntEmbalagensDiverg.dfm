inherited frmEntEmbalagensDiverg: TfrmEntEmbalagensDiverg
  Width = 800
  Height = 489
  BorderStyle = bsSizeable
  Caption = 'Digeverg'#234'ncias de Embalagens  na baixa do pedido'
  ExplicitWidth = 800
  ExplicitHeight = 489
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 407
    Width = 784
    TabOrder = 1
    ExplicitTop = 407
    ExplicitWidth = 784
    inherited btnSair: TBitBtnLocked
      Left = 704
      TabOrder = 1
      ExplicitLeft = 704
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object mmoAjuda: TMemo [2]
    Left = 0
    Top = 344
    Width = 784
    Height = 63
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
      
        'As quantidades a serem baixadas dos itens listados n'#227'o s'#227'o m'#250'lti' +
        'plos das embalagens infomadas no Pedido de Compra.'
      
        'Esses itens ter'#227'o suas quantidades convertidas em unidades de ve' +
        'nda no respectivo pedido para evitar inconsist'#234'ncias nas baixas.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    StyleElements = []
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 784
    Height = 344
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 243
      end
      object cxgItensEMBORI: TcxGridDBColumn
        Caption = 'Embalagem  Pedido'
        DataBinding.FieldName = 'EMBORI'
        HeaderAlignmentHorz = taRightJustify
        Width = 111
      end
      object cxgItensEMBENT: TcxGridDBColumn
        Caption = 'Emb. Entrada Merc.'
        DataBinding.FieldName = 'EMBENT'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 113
      end
      object cxgItensQTDENT: TcxGridDBColumn
        Caption = 'Quant. Entrada Merc.'
        DataBinding.FieldName = 'QTDENT'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 111
      end
      object cxgItensQTDBAI: TcxGridDBColumn
        Caption = 'Quantidade a ser Baixada'
        DataBinding.FieldName = 'QTDBAI'
        HeaderAlignmentHorz = taRightJustify
        Width = 135
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 435
    Width = 784
    TabOrder = 2
    ExplicitTop = 435
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
end
