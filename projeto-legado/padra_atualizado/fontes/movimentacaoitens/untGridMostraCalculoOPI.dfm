inherited frmGridMostraCalculoOPI: TfrmGridMostraCalculoOPI
  Width = 1101
  Height = 461
  Caption = 'Custos de produtos Acabado'
  Position = poMainFormCenter
  ExplicitLeft = -60
  ExplicitWidth = 1101
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 388
    Width = 1095
    ExplicitTop = 388
    ExplicitWidth = 1066
    inherited FlwBotoes: TFlowPanel
      Left = 85
      Width = 1008
      ExplicitLeft = 85
      ExplicitWidth = 979
    end
    inherited btnSair: TBitBtnLocked
      Left = 1012
      ExplicitLeft = 983
    end
    object btnOk: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 83
      Height = 24
      Align = alLeft
      Caption = 'Confirmar'
      Default = True
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
      TabOrder = 2
      OnClick = btnOkClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 416
    Width = 1095
    ExplicitTop = 416
    ExplicitWidth = 1066
    inherited pnlNomeForm: TPanel
      Left = 924
      ExplicitLeft = 895
    end
    inherited pnlInfo: TPanel
      Width = 924
      ExplicitWidth = 895
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1095
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 1066
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
    end
    object Label2: TLabel
      Left = 310
      Top = 14
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo da F'#243'rmula:'
    end
    object DBNumOpi: TDBEditFocus
      Left = 171
      Top = 10
      Width = 121
      Height = 22
      DataField = 'NUMORD'
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBCustoFormula: TDBEditFocus
      Left = 403
      Top = 10
      Width = 121
      Height = 22
      DataField = 'CUSFOR'
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 41
    Width = 1095
    Height = 347
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 1066
    object cxgOrdCustoProdAca: TcxGrid
      Left = 0
      Top = 0
      Width = 1095
      Height = 347
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 1066
      object cxgOrdCustoProdAcaView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgOrdCustoProdAcaViewColumn1: TcxGridDBColumn
          Caption = 'Produto Acabado'
          DataBinding.FieldName = 'DESITE'
          Width = 350
        end
        object cxgOrdCustoProdAcaViewColumn2: TcxGridDBColumn
          Caption = 'Unididade'
          DataBinding.FieldName = 'UNDMED'
          Width = 80
        end
        object cxgOrdCustoProdAcaViewColumn4: TcxGridDBColumn
          Caption = 'Estoque Atual'
          DataBinding.FieldName = 'ESTATU'
          Width = 80
        end
        object cxgOrdCustoProdAcaViewColumn7: TcxGridDBColumn
          Caption = 'Estoque Final'
          DataBinding.FieldName = 'ESTFIN'
          Width = 80
        end
        object cxgOrdCustoProdAcaViewColumn5: TcxGridDBColumn
          Caption = 'Qtd. Programada'
          DataBinding.FieldName = 'QTDPRO'
          Width = 100
        end
        object cxgOrdCustoProdAcaViewColumn6: TcxGridDBColumn
          Caption = 'Qtd. Produzida'
          DataBinding.FieldName = 'QTDPZD'
          Width = 100
        end
        object cxgOrdCustoProdAcaViewColumn8: TcxGridDBColumn
          Caption = 'Custo Atual'
          DataBinding.FieldName = 'CUSATU'
          Width = 90
        end
        object cxgOrdCustoProdAcaViewColumn3: TcxGridDBColumn
          Caption = 'Custo Unit'#225'rio'
          DataBinding.FieldName = 'CUSUNI'
          Width = 100
        end
        object cxgOrdCustoProdAcaViewColumn9: TcxGridDBColumn
          Caption = 'Custo Final'
          DataBinding.FieldName = 'CUSFIN'
          Width = 110
        end
      end
      object cxgOrdCustoProdAcaLevel1: TcxGridLevel
        GridView = cxgOrdCustoProdAcaView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 856
    Top = 124
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 796
    Top = 92
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 792
    Top = 120
  end
end
