inherited frmRcxConsTransfValores: TfrmRcxConsTransfValores
  Width = 800
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = 'Resumo de Transfer'#234'ncia de Valores Pendentes'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 794
    ExplicitTop = 427
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitTop = 2
      ExplicitWidth = 790
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
  end
  object pnlTransferencias: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 427
    Align = alClient
    TabOrder = 2
    object dbgTransferencias: TcxGrid
      Left = 1
      Top = 1
      Width = 792
      Height = 403
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgTransferenciasDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_DINREC
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_CHQAVI
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_CHQPRE
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_CARREC
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_ORDREC
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_VALFIN
          end
          item
            Kind = skSum
            Column = dbgTransferenciasDBTableView1RCX_TOTGER
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' dados a serem exibidos>'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object dbgTransferenciasDBTableView1RCX_CODOPE: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'RCX_CODOPE'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 210
        end
        object dbgTransferenciasDBTableView1RCX_DINREC: TcxGridDBColumn
          Caption = 'Dinheiro'
          DataBinding.FieldName = 'RCX_DINREC'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_CHQAVI: TcxGridDBColumn
          Caption = 'Cheque Vista'
          DataBinding.FieldName = 'RCX_CHQAVI'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_CHQPRE: TcxGridDBColumn
          Caption = 'Cheque Pr'#233
          DataBinding.FieldName = 'RCX_CHQPRE'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_CARREC: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'RCX_CARREC'
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_ORDREC: TcxGridDBColumn
          Caption = 'Ordem Pagto'
          DataBinding.FieldName = 'RCX_ORDREC'
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_VALFIN: TcxGridDBColumn
          Caption = 'Financiam.'
          DataBinding.FieldName = 'RCX_VALFIN'
          Styles.Header = cxStyle1
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_TOTGER: TcxGridDBColumn
          Caption = 'Total'
          DataBinding.FieldName = 'RCX_TOTGER'
          Styles.Header = cxStyle1
          Width = 80
        end
      end
      object dbgTransferenciasLevel1: TcxGridLevel
        GridView = dbgTransferenciasDBTableView1
      end
    end
    object pnlMensagem: TPanel
      Left = 1
      Top = 404
      Width = 792
      Height = 22
      Align = alBottom
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label12: TLabel
        Left = 1
        Top = 1
        Width = 790
        Height = 20
        Align = alClient
        Alignment = taCenter
        Caption = 
          'O valor atual da transfer'#234'ncia em dinheiro est'#225' oculto, pois o s' +
          'istema est'#225' configurado para utilizar Transfer'#234'ncia Cega.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqAntialiased
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 503
        ExplicitHeight = 12
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 16
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 8
    Top = 72
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
