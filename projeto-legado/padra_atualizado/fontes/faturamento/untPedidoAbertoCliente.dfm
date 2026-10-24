inherited frmPedidoAbertoCliente: TfrmPedidoAbertoCliente
  Width = 770
  Height = 505
  BorderIcons = [biSystemMenu]
  Caption = 'Pedidos em Aberto do Cliente'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 770
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 433
    Width = 764
    ExplicitTop = 433
    ExplicitWidth = 764
    inherited btnSair: TBitBtnLocked
      Left = 681
      ExplicitLeft = 681
    end
  end
  object dbePedidos: TcxGrid [2]
    Left = 0
    Top = 74
    Width = 764
    Height = 359
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDados: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.DataSource = dtsPedidos
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Position = spFooter
          Column = cxGridDadosVLRCON
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosVLRCON
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Position = spFooter
          Column = cxGridDadosTOTABE
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosTOTABE
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Position = spFooter
          Column = cxGridDadosVALADT
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosVALADT
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosVLRCON
          DisplayText = 'Total'
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosTOTABE
          DisplayText = 'Total'
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = cxGridDadosVALADT
          DisplayText = 'Total'
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      Styles.Selection = cxStyleSelecao
      object cxGridDadosDTAENT: TcxGridDBColumn
        Caption = 'Dt. Pedido'
        DataBinding.FieldName = 'DTAENT'
        SortIndex = 1
        SortOrder = soAscending
        Width = 65
      end
      object cxGridDadosPREVIS: TcxGridDBColumn
        Caption = 'Dt. Previs'#227'o'
        DataBinding.FieldName = 'PREVIS'
        Width = 65
      end
      object cxGridDadosNUMDOC: TcxGridDBColumn
        Caption = 'N'#186' Pedido'
        DataBinding.FieldName = 'NUMDOC'
        SortIndex = 2
        SortOrder = soAscending
        Width = 112
      end
      object cxGridDadosNUMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Visible = False
        GroupIndex = 0
        SortIndex = 0
        SortOrder = soAscending
        Width = 88
      end
      object cxGridDadosCODVEN: TcxGridDBColumn
        Caption = 'Vend.'
        DataBinding.FieldName = 'CODVEN'
        Width = 46
      end
      object cxGridDadosCONPAG: TcxGridDBColumn
        Caption = 'Cond. Pagamento'
        DataBinding.FieldName = 'CONPAG'
        OnGetDisplayText = cxGridDadosCONPAGGetDisplayText
        Width = 182
      end
      object cxGridDadosVLRCON: TcxGridDBColumn
        Caption = 'Tot. Pedido'
        DataBinding.FieldName = 'VLRCON'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxGridDadosTOTABE: TcxGridDBColumn
        Caption = 'Tot. Aberto'
        DataBinding.FieldName = 'TOTABE'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxGridDadosVALADT: TcxGridDBColumn
        Caption = 'Tot. Adiantado'
        DataBinding.FieldName = 'VALADT'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
    end
    object cxGridNivel: TcxGridLevel
      GridView = cxGridDados
    end
  end
  object pnlCliente: TPanel [3]
    Left = 0
    Top = 0
    Width = 764
    Height = 50
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object lbl1: TLabel
      Left = 6
      Top = 5
      Width = 38
      Height = 14
      Caption = 'Cliente: '
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 6
      Top = 18
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 72
      Top = 18
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlTit: TPanel [4]
    Left = 0
    Top = 50
    Width = 764
    Height = 24
    Align = alTop
    Caption = 'PEDIDOS N'#195'O FATURADOS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  inherited pnlStatus: TPanel
    Top = 461
    Width = 764
    ExplicitTop = 461
    ExplicitWidth = 764
    inherited pnlNomeForm: TPanel
      Left = 593
      ExplicitLeft = 593
    end
    inherited pnlInfo: TPanel
      Width = 593
      ExplicitWidth = 593
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 72
  end
  object dtsPedidos: TDataSource
    Left = 392
    Top = 72
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 296
    Top = 72
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clLime
    end
  end
end
