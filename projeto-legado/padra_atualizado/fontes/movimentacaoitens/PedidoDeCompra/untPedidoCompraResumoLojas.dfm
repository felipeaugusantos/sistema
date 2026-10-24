inherited frmPedidoCompraResumoLojas: TfrmPedidoCompraResumoLojas
  Width = 1007
  Height = 444
  BorderStyle = bsSizeable
  Caption = 'Resumo por Loja'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1007
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 14
  object lblValorMinFornecedor: TLabel [0]
    Left = 0
    Top = 347
    Width = 991
    Height = 14
    Align = alBottom
    Caption = 'Valor m'#237'nimo exigido pelo fornecedor:'
    ExplicitWidth = 180
  end
  inherited pnlBotoes: TPanel
    Top = 361
    Width = 991
    ExplicitTop = 361
    ExplicitWidth = 991
    inherited FlwBotoes: TFlowPanel
      Width = 987
      ExplicitWidth = 987
    end
    inherited btnSair: TBitBtnLocked
      Left = 911
      TabOrder = 3
      ExplicitLeft = 911
    end
    object btnItens: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 121
      Height = 22
      Caption = '[ F2 ] Itens'
      TabOrder = 1
      OnClick = btnItensClick
    end
    object btnAcumular: TBitBtnLocked
      Left = 360
      Top = 3
      Width = 265
      Height = 22
      Caption = '[ F5 ] Acumular na empresa selecionada'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000000000000000000000000000000000000000000C0000
        0007000000030000000A00000010000000050000000000000000000000000000
        0000000000030000000C000000100000000F00000008000000021115A0FF0304
        1F470000000B090C467B0C0F94FF000000100000000000000000000000000000
        00000000000A00632FFF00612EFF005929FF002611860000000912168AD40709
        4A8C0000001E0F1373BA090C66BA0000000D0000000000000000000000000000
        00000000000B00622EFF00190C5A001B0D5A005929FF000B052F12186696212A
        BDFF1F28BCFF161BACFF06083F79000000070000000000000000000000000000
        000000000009006934FF001B0D57001D0F5600602DFF0006031C0A0D3451171E
        AEFF05061A43161CAAFF02031633000000020000000000000000000000000000
        000000000007007B3FFF00783EFF007138FF00361B930000000800000009242D
        C1FF1A2083B5131997E10000000A000000000000000000000000000000000000
        000000000006007B3FFF0020105000211250007037FF00070418000000041D26
        89B0242EC1FF0E11619100000005000000000000000000000000000000000000
        000000000004008444FF0022124D001B0F3D00793EFF00100828000000021419
        546B212BC3FF070A314B00000002000000000000000000000000000000000000
        000000000002009653FF009351FF008A49FF0045238C000000030000000E0000
        00140000001700000013000000070000000200000000000000020000000B0000
        0014000000170000001800000019000000190000001300000005A86D49EEB576
        4FFFB5754FFFB5754DFF3220155C0000000600000000000000065837258CB26F
        49FFB16E48FFB06E47FFAF6D46FFB06C46FFAF6B45FF00000011855A3FC0DDB9
        94FFE7C696FFC39469FF623B23B0040302190000000600000004000000135635
        219BCC9F78FFE7C493FFE4BD86FFE1B780FFB3734DFF000000144531236ACD9D
        79FFEFD6B1FFE6C495FFB9865DFF623C23AE2D1B115A0604021E2E1D125C6942
        2AB1C29069FFE6C495FFE8C597FFE3BD88FFB97B55FF000000120202010D9F76
        56D2E1C1A2FFF2DDB9FFEACBA0FFC79D73FFB27C54FFA46740FFB6815AFFCEA2
        7AFFE5C59BFFEFD5AEFFE6C6A2FFEBCDA1FFC0845EFF0000000F000000021D16
        102EB98D6AEAE0C09FFFF5E5C8FFF4E0BBFFF3DEB6FFF2DCB2FFF2DCB4FFF3DD
        B6FFF3DFBEFFDCB894FFBD8B65F5DBB691FFC58F67FF0000000D000000000000
        0002110D0A1D8F6D53B4D7AE89FFEBD4B7FFF5E5CAFFF9ECD2FFF3E2C6FFEAD0
        B0FFD3A984FF8B694EB6110D0925644C388BC9986FFF0000000A000000000000
        000000000001000000043E3125517C61499CA68163CDCEA079F9A68162CD7C60
        499D3E302453000000060000000200000006664F3A8400000004}
      TabOrder = 2
      OnClick = btnAcumularClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 389
    Width = 991
    ExplicitTop = 389
    ExplicitWidth = 991
    inherited pnlNomeForm: TPanel
      Left = 820
      ExplicitLeft = 820
    end
    inherited pnlInfo: TPanel
      Width = 820
      ExplicitWidth = 820
    end
  end
  object cxPedidos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 991
    Height = 347
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvPedidos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTDES'
          Column = cxvPedidosTOTDES
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTFRE'
          Column = cxvPedidosTOTFRE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTGER'
          Column = cxvPedidosTOTGER
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTIPI'
          Column = cxvPedidosTOTIPI
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTCBS'
          Column = cxvPedidosTOTCBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTIBS'
          Column = cxvPedidosTOTIBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOT_IS'
          Column = cxvPedidosTOT_IS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTITE'
          Column = cxvPedidosTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTSUB'
          Column = cxvPedidosTOTSUB
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTLKG'
          Column = cxVPedidosTOTLKG
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TOTPES'
          Column = cxvPedidosTOTPES
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxPedCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 57
      end
      object cxvPedidosNOMEMP: TcxGridDBColumn
        Caption = 'Nome da Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Options.Editing = False
        Width = 247
      end
      object cxvPedidosTOTITE: TcxGridDBColumn
        Caption = 'Total dos Itens'
        DataBinding.FieldName = 'TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxvPedidosTOTIPI: TcxGridDBColumn
        Caption = 'Total de IPI'
        DataBinding.FieldName = 'TOTIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxvPedidosTOTCBS: TcxGridDBColumn
        Caption = 'Total CBS'
        DataBinding.FieldName = 'TOTCBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxvPedidosTOTIBS: TcxGridDBColumn
        Caption = 'Total IBS'
        DataBinding.FieldName = 'TOTIBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxvPedidosTOT_IS: TcxGridDBColumn
        Caption = 'Total IS'
        DataBinding.FieldName = 'TOT_IS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxvPedidosTOTSUB: TcxGridDBColumn
        Caption = 'Total Subst.'
        DataBinding.FieldName = 'TOTSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxVPedidosTOTLKG: TcxGridDBColumn
        Caption = 'Lt/Kg'
        DataBinding.FieldName = 'TOTLKG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Options.Editing = False
        Width = 90
      end
      object cxvPedidosTOTFRE: TcxGridDBColumn
        Caption = 'Frete'
        DataBinding.FieldName = 'TOTFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxvPedidosTOTDES: TcxGridDBColumn
        Caption = 'Desp. Acess.'
        DataBinding.FieldName = 'TOTDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxvPedidosTOTGER: TcxGridDBColumn
        Caption = 'Total Pedido'
        DataBinding.FieldName = 'TOTGER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxPedidosACUMUL: TcxGridDBColumn
        Caption = 'Acumular na Empresa'
        DataBinding.FieldName = 'ACUMUL'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ClearKey = 46
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Sorted = True
        Properties.OnCloseUp = cxPedidosACUMULPropertiesCloseUp
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxvPedidosTOTPES: TcxGridDBColumn
        Caption = 'Peso Bruto Total'
        DataBinding.FieldName = 'TOTPES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Width = 120
      end
    end
    object cxPedidosLevel1: TcxGridLevel
      GridView = cxvPedidos
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 184
  end
end
