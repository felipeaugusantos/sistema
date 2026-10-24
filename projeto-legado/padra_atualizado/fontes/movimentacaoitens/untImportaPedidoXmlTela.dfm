inherited frmImportaPedidoXmlTela: TfrmImportaPedidoXmlTela
  Width = 857
  Height = 502
  Caption = 'Importa'#231#227'o de Pedidos de Compra'
  ExplicitTop = -96
  ExplicitWidth = 857
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 431
    Width = 851
    TabOrder = 1
    ExplicitTop = 431
    ExplicitWidth = 851
    inherited FlwBotoes: TFlowPanel
      Width = 847
      ExplicitWidth = 847
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Caption = '[F10] Confirma'
        ExplicitWidth = 113
      end
      object btnExcluir: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 126
        Height = 22
        Caption = '&Remover Pedido'
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
    inherited btnSair: TBitBtnLocked
      Left = 768
      ExplicitLeft = 768
    end
  end
  inherited pnlStatus: TPanel
    Top = 457
    Width = 851
    TabOrder = 2
    ExplicitTop = 457
    ExplicitWidth = 851
    inherited pnlNomeForm: TPanel
      Left = 680
      ExplicitLeft = 680
    end
    inherited pnlInfo: TPanel
      Width = 680
      ExplicitWidth = 680
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 851
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 27
      Width = 90
      Height = 14
      Caption = 'Pedido de Compra:'
    end
    object Label228: TLabel
      Left = 219
      Top = 27
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNumPed: TEditFocus
      Left = 111
      Top = 24
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 268
      Top = 24
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 306
      Top = 24
      Width = 430
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgPedidos: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 851
    Height = 366
    Align = alClient
    TabOrder = 3
    object cxvPedidos: TcxGridDBTableView
      OnKeyDown = cxvPedidosKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum pedido informado>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyle1
      object cxvPedidosColumn1: TcxGridDBColumn
        Caption = 'Data do Pedido'
        DataBinding.FieldName = 'DTAPED'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 75
      end
      object cxvPedidosColumn2: TcxGridDBColumn
        Caption = 'Data de Entrega'
        DataBinding.FieldName = 'DTAENT'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 75
      end
      object cxvPedidosColumn7: TcxGridDBColumn
        Caption = 'C'#243'digo do Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object cxvPedidosColumn3: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        HeaderAlignmentHorz = taCenter
        Width = 382
      end
      object cxvPedidosColumn4: TcxGridDBColumn
        Caption = 'N'#250'mero do Pedido'
        DataBinding.FieldName = 'NUMPED'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 106
      end
      object cxvPedidosColumn5: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxvPedidosColumn6: TcxGridDBColumn
        Caption = 'Empresa Destino'
        DataBinding.FieldName = 'EMPDES'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
    end
    object cxgPedidosLevel1: TcxGridLevel
      GridView = cxvPedidos
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 232
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 112
    Top = 256
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
