inherited frmRelCtrReimpressaoDocsList: TfrmRelCtrReimpressaoDocsList
  Left = 287
  Top = 223
  Width = 670
  Height = 400
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Reimpress'#227'o de Duplicatas'
  Position = poScreenCenter
  ExplicitWidth = 670
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 329
    Width = 664
    Height = 26
    TabOrder = 1
    ExplicitTop = 329
    ExplicitWidth = 664
    ExplicitHeight = 26
    object lblBusca: TLabel [0]
      Left = 7
      Top = 6
      Width = 55
      Height = 14
      Caption = 'F3 - Busca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 113
      Width = 472
      Height = 22
      ExplicitLeft = 113
      ExplicitWidth = 472
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 585
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 585
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 664
    TabOrder = 2
    ExplicitTop = 355
    ExplicitWidth = 664
    inherited pnlNomeForm: TPanel
      Left = 493
      ExplicitLeft = 493
    end
    inherited pnlInfo: TPanel
      Width = 493
      ExplicitWidth = 493
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 664
    Height = 329
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblSelecione: TLabel
      Left = 2
      Top = 2
      Width = 660
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Selecione o documento desejado'
      Color = 16757606
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 640
    end
    object cxgDocumentos: TcxGrid
      Left = 2
      Top = 22
      Width = 660
      Height = 305
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocumentosDados: TcxGridDBTableView
        OnKeyDown = cxgDocumentosDadosKeyDown
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
        FilterBox.CustomizeDialog = False
        OnCellDblClick = cxgDocumentosDadosCellDblClick
        OnCustomDrawCell = cxgDocumentosDadosCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgDuplicatasCTR_VALREC
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALREC
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALREC
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para filtrar as duplicatas'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' duplicatas para serem exibidas'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxgDuplicatasCTR_SEQCON: TcxGridDBColumn
          Caption = 'Seq. Bai.'
          DataBinding.FieldName = 'CTR_SEQCON'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 50
        end
        object cxgDuplicatasCTR_EMPBAI: TcxGridDBColumn
          Caption = 'Emp. Bai.'
          DataBinding.FieldName = 'CTR_EMPBAI'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 50
        end
        object cxgDuplicatasCTR_DTACAD: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CTR_DTACAD'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 65
        end
        object cxgDuplicatasCTR_NUMDUP: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'CTR_NUMDUP'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 85
        end
        object cxgDuplicatasCTR_PARCEL: TcxGridDBColumn
          Caption = 'Parc.'
          DataBinding.FieldName = 'CTR_PARCEL'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 40
        end
        object cxgDuplicatasCTR_ESPDOC: TcxGridDBColumn
          Caption = 'Esp.'
          DataBinding.FieldName = 'CTR_ESPDOC'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 34
        end
        object cxgDuplicatasCTR_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTR_CODEMP'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 36
        end
        object cxgDuplicatasCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 185
        end
        object cxgDuplicatasCTR_VALREC: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CTR_VALREC'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 79
        end
        object cxgDuplicatasCTR_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MARDES'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxgDocumentosNivel: TcxGridLevel
        GridView = cxgDocumentosDados
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 128
  end
  object cxstylrpstry1: TcxStyleRepository
    Left = 328
    Top = 128
    PixelsPerInch = 96
    object cxsSelecionado: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clAqua
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
  end
end
