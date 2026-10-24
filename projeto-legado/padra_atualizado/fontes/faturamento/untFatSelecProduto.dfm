inherited frmFatSelecProduto: TfrmFatSelecProduto
  Left = 317
  Top = 374
  Width = 790
  Height = 350
  Caption = 'Selecione o Produto'
  Position = poMainFormCenter
  ExplicitWidth = 790
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 258
    Width = 784
    ExplicitTop = 184
    ExplicitWidth = 544
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 540
    end
  end
  inherited pnlStatus: TPanel
    Top = 305
    Width = 784
    ExplicitTop = 231
    ExplicitWidth = 544
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 373
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 373
    end
  end
  inherited pgcDados: TPageControl
    Left = 8
    Top = 368
    Width = 81
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 8
    ExplicitTop = 368
    ExplicitWidth = 81
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 73
      ExplicitHeight = 1
    end
  end
  object pnlVariosEncontrados: TPanel [3]
    Left = 0
    Top = 258
    Width = 784
    Height = 47
    Align = alBottom
    ParentColor = True
    TabOrder = 3
    ExplicitTop = 184
    ExplicitWidth = 544
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 782
      Height = 45
      Align = alClient
      Caption = 
        'Para o c'#243'digo informado, foi encontrado v'#225'rios itens que se enqu' +
        'adram no valor digidado, sendo estes pelo inicio do c'#243'digo de fa' +
        'brica igual, c'#243'digo de barras atrelado a mais de um produto, ou,' +
        ' pelo c'#243'digo de similares do item encontrado. Por favor selecion' +
        'e o item desejado.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 541
      ExplicitHeight = 42
    end
  end
  object cxgItens: TcxGridCitel [4]
    Left = 0
    Top = 0
    Width = 784
    Height = 258
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 544
    ExplicitHeight = 184
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.GroupFooterMultiSummaries = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 55
      end
      object cxvItensCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. Fabrica'
        DataBinding.FieldName = 'CODFAB'
        Width = 150
      end
      object cxvItensDESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Width = 200
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 350
      end
    end
    object cxlItens: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
end
