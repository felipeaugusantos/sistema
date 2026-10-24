inherited frmRelFatVendasPorLinha: TfrmRelFatVendasPorLinha
  Width = 890
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Vendas por Linha'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 890
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 378
    Width = 884
    ExplicitTop = 378
    ExplicitWidth = 884
    inherited btnSair: TBitBtnLocked
      Left = 801
      ExplicitLeft = 801
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 884
    Height = 33
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblVendedor: TLabel
      Left = 8
      Top = 9
      Width = 57
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 33
    Width = 884
    Height = 317
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',#0.00'
          Kind = skSum
          Column = cxDadosViewTOTGER
        end
        item
          Format = ',#0.00'
          Kind = skSum
          Column = cxDadosViewTOTVEN
        end
        item
          Format = ',#0.00'
          Kind = skSum
          Column = cxDadosViewQTDVEN
        end
        item
          Format = ',#0.00'
          Kind = skSum
          Column = cxDadosViewTOTITE
        end
        item
          Format = ',#0.00'
          Kind = skSum
          Column = cxDadosViewQTDITE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Nenhum registro encontrado'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxDadosViewCODLIN: TcxGridDBColumn
        Caption = 'Linha'
        DataBinding.FieldName = 'CODLIN'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 65
      end
      object cxDadosViewDESLIN: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESLIN'
        Styles.Header = cxStyleHeader
        Width = 300
      end
      object cxDadosViewQTDITE: TcxGridDBColumn
        Caption = 'Qtd. Vendida'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 100
      end
      object cxDadosViewTOTITE: TcxGridDBColumn
        Caption = 'Vlr. Vendido'
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 100
      end
      object cxDadosViewQTDVEN: TcxGridDBColumn
        Caption = 'Qtd. Vendendo'
        DataBinding.FieldName = 'QTDVEN'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 100
      end
      object cxDadosViewTOTVEN: TcxGridDBColumn
        Caption = 'Vlr. Vendendo'
        DataBinding.FieldName = 'TOTVEN'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 100
      end
      object cxDadosViewTOTGER: TcxGridDBColumn
        Caption = 'Tot. Geral'
        DataBinding.FieldName = 'TOTGER'
        HeaderAlignmentHorz = taCenter
        Styles.Footer = cxStyleFooter
        Styles.Header = cxStyleHeader
        Width = 100
      end
    end
    object cxDadosNivel: TcxGridLevel
      Caption = 'Vendas por Linha'
      GridView = cxDadosView
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 350
    Width = 884
    Height = 28
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    object lblTitMetas: TLabel
      Left = 671
      Top = 6
      Width = 109
      Height = 16
      Caption = 'Meta do Per'#237'odo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMetas: TLabel
      Left = 779
      Top = 7
      Width = 86
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 406
    Width = 884
    TabOrder = 3
    ExplicitTop = 406
    ExplicitWidth = 884
    inherited pnlNomeForm: TPanel
      Left = 713
      ExplicitLeft = 713
    end
    inherited pnlInfo: TPanel
      Width = 713
      ExplicitWidth = 713
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 112
  end
  object dtsDados: TDataSource
    Left = 264
    Top = 112
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 360
    Top = 112
    PixelsPerInch = 96
    object cxStyleFooter: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyleHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
