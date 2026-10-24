inherited frmConsultaRelatMenu: TfrmConsultaRelatMenu
  Width = 996
  Height = 557
  BorderStyle = bsSizeable
  Caption = 'Relat'#243'rios customizados incluidos no menu de relat'#243'rios'
  ExplicitWidth = 996
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 475
    Width = 980
    ExplicitTop = 475
    ExplicitWidth = 980
    inherited btnSair: TBitBtnLocked
      Left = 897
      Caption = 'Sair'
      ExplicitLeft = 897
    end
    object btnExcluir: TBitBtnLocked
      Left = 373
      Top = 2
      Width = 218
      Height = 22
      Caption = '&Remove relat'#243'rios marcados do menu'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnExcluirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 503
    Width = 980
    ExplicitTop = 503
    ExplicitWidth = 980
    inherited pnlNomeForm: TPanel
      Left = 809
      ExplicitLeft = 809
    end
    inherited pnlInfo: TPanel
      Width = 809
      ExplicitWidth = 809
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 980
    Height = 475
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum relat'#243'rio incluido>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvItensColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODREL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 73
      end
      object cxvItensColumn2: TcxGridDBColumn
        Caption = 'Nome do Relat'#243'rio'
        DataBinding.FieldName = 'NOMREL'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
        Width = 412
      end
      object cxvItensColumn3: TcxGridDBColumn
        Caption = 'Nome do Menu'
        DataBinding.FieldName = 'CAPMEN'
        Options.Editing = False
        Width = 389
      end
      object cxvItensColumn4: TcxGridDBColumn
        Caption = 'Remover do Menu'
        DataBinding.FieldName = 'RETIRA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 104
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 560
    Top = 256
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
