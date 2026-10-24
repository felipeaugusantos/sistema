inherited frmItensInconsistentesEntrada: TfrmItensInconsistentesEntrada
  Width = 572
  Height = 401
  BorderStyle = bsSingle
  Caption = 'Produtos que n'#227'o foram carregados'
  ExplicitWidth = 572
  ExplicitHeight = 401
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 566
    inherited FlwBotoes: TFlowPanel
      Width = 562
    end
    inherited btnSair: TBitBtnLocked
      Left = 486
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 566
    inherited pnlNomeForm: TPanel
      Left = 395
    end
    inherited pnlInfo: TPanel
      Width = 395
    end
  end
  object MemoFocus1: TMemoFocus [3]
    Left = 0
    Top = 0
    Width = 566
    Height = 65
    Align = alTop
    Alignment = taCenter
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        'Os produtos abaixo constam na nota eletr'#244'nica, por'#233'm por inconsi' +
        'st'#234'ncias cadastrais n'#227'o foram '
      
        'carregadas para dar entrada na nota. Verifique os cadastros de U' +
        'nidade e Abrevia'#231#227'o Fiscal.')
    ParentFont = False
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    Texto = 
      '<<csq>>Os produtos abaixo constam na nota eletr'#244'nica, por'#233'm por ' +
      'inconsist'#234'ncias cadastrais n'#227'o foram <<csq>>carregadas para dar ' +
      'entrada na nota. Verifique os cadastros de Unidade e Abrevia'#231#227'o ' +
      'Fiscal.<<csq>>'
    ExplicitWidth = 670
  end
  object cxgItens: TcxGrid [4]
    Left = 0
    Top = 65
    Width = 566
    Height = 263
    Align = alClient
    TabOrder = 4
    ExplicitLeft = 168
    ExplicitTop = 112
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum produto encontrado>'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvItensColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DET_CODITE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 77
      end
      object cxvItensColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'ITE_DESITE'
        SortIndex = 0
        SortOrder = soAscending
        Width = 467
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 240
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 264
    Top = 136
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
