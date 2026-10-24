inherited frmRelFatVendasItensF9: TfrmRelFatVendasItensF9
  Left = 168
  Top = 151
  Width = 1109
  Height = 452
  BorderIcons = [biSystemMenu]
  Caption = 'Itens Vendidos'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 900
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 894
    Height = 26
    ExplicitTop = 381
    ExplicitWidth = 894
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 806
      Height = 22
      ExplicitWidth = 890
      object btnDocCom: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 240
        Height = 22
        Caption = '[ F5 ] Visualizar Documento Completo'
        TabOrder = 0
        Visible = False
        OnClick = btnDocComClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 808
      Top = 2
      Width = 84
      Align = alRight
      ExplicitLeft = 808
      ExplicitTop = 2
      ExplicitWidth = 84
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 33
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblProduto: TLabel
      Left = 8
      Top = 9
      Width = 47
      Height = 14
      Caption = 'Produto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 407
    Width = 894
    ExplicitTop = 407
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object dbgItens: TcxGrid [4]
    Left = 0
    Top = 33
    Width = 894
    Height = 348
    Align = alClient
    TabOrder = 4
    TabStop = False
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 346
    object dbgItensDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsRelVenCli
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = QTDITE
        end
        item
          Kind = skSum
          Column = TOTITE
        end
        item
          Kind = skSum
          Column = TOTIPI
        end
        item
          Kind = skSum
          Column = TOTGER
        end
        item
          Kind = skSum
          Column = TOTCUS
        end
        item
        end
        item
          Column = MARGEM
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.Summary.OnAfterSummary = dbgItensDBTableView1DataControllerSummaryAfterSummary
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object DTAENT: TcxGridDBColumn
        Caption = 'Dt.Emiss'#227'o'
        DataBinding.FieldName = 'DTAENT'
      end
      object NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
      end
      object DOCORI: TcxGridDBColumn
        Caption = 'Doc.Origem'
        DataBinding.FieldName = 'DOCORI'
      end
      object NUMFAT: TcxGridDBColumn
        Caption = 'Doc.Conf.'
        DataBinding.FieldName = 'NUMFAT'
      end
      object CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
      end
      object NOMCLI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'NOMCLI'
      end
      object CODVEN: TcxGridDBColumn
        Caption = 'Cod Ven'
        DataBinding.FieldName = 'CODVEN'
      end
      object NOMVEN: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'VENDED'
        Width = 161
      end
      object QTDITE: TcxGridDBColumn
        Caption = 'Qtd.Item'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
      end
      object UNITAR: TcxGridDBColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'UNITAR'
        HeaderAlignmentHorz = taRightJustify
      end
      object TOTITE: TcxGridDBColumn
        Caption = 'Vr.Total'
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taRightJustify
      end
      object TOTIPI: TcxGridDBColumn
        Caption = 'Vr. IPI'
        DataBinding.FieldName = 'TOTIPI'
        HeaderAlignmentHorz = taRightJustify
      end
      object TOTGER: TcxGridDBColumn
        Caption = 'Tot.+ IPI'
        DataBinding.FieldName = 'TOTGER'
        HeaderAlignmentHorz = taRightJustify
      end
      object TOTCUS: TcxGridDBColumn
        Caption = 'Vr.Custo'
        DataBinding.FieldName = 'TOTCUS'
        HeaderAlignmentHorz = taRightJustify
      end
      object MARGEM: TcxGridDBColumn
        Caption = 'Margem'
        DataBinding.FieldName = 'MARGEM'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object dbgItensLevel1: TcxGridLevel
      GridView = dbgItensDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 200
  end
  object dtsRelVenCli: TDataSource
    Left = 288
    Top = 200
  end
end
