inherited frmFatAltLoteItem: TfrmFatAltLoteItem
  Width = 831
  Height = 565
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o de %s dos Itens do Pedido de Venda'
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 831
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 492
    Width = 825
    ExplicitTop = 492
    ExplicitWidth = 717
    inherited FlwBotoes: TFlowPanel
      Width = 821
      ExplicitTop = 2
      ExplicitWidth = 713
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 111
        Height = 22
        Caption = '[F10] Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 744
      Top = 2
      ExplicitLeft = 636
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 520
    Width = 825
    ExplicitTop = 520
    ExplicitWidth = 717
    inherited pnlNomeForm: TPanel
      Left = 654
      ExplicitLeft = 546
    end
    inherited pnlInfo: TPanel
      Width = 654
      ExplicitWidth = 546
    end
  end
  object pnlBusca: TPanel [3]
    Left = 0
    Top = 0
    Width = 825
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 717
    object lbl1: TLabel
      Left = 13
      Top = 9
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object lbl2: TLabel
      Left = 141
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 13
      Top = 24
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 101
      Top = 24
      Width = 28
      Height = 22
      TabStop = False
      Alignment = taCenter
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      Text = 'PD'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 141
      Top = 24
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 199
      Top = 24
      Width = 505
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 57
    Width = 825
    Height = 146
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 4
    ExplicitWidth = 717
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lbl8: TLabel
      Left = 11
      Top = 49
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagto:'
    end
    object lbl5: TLabel
      Left = 617
      Top = 7
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object lbl6: TLabel
      Left = 619
      Top = 92
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object lbl7: TLabel
      Left = 11
      Top = 92
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Form. Pagto:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 11
      Top = 21
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 76
      Top = 21
      Width = 539
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCndAtu: TEditFocus
      Tag = 99
      Left = 11
      Top = 64
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object mskCndPagAtu: TMaskEditFocus
      Tag = 99
      Left = 77
      Top = 64
      Width = 538
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 4
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesCndAtu: TEditFocus
      Left = 617
      Top = 64
      Width = 196
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaEnt: TEditFocus
      Tag = 99
      Left = 617
      Top = 21
      Width = 196
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValDocAtu: TEditFocus
      Tag = 2
      Left = 617
      Top = 107
      Width = 196
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 12
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtForPagAtu: TEditFocus
      Tag = 99
      Left = 11
      Top = 107
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesFpgAtu: TEditFocus
      Left = 77
      Top = 107
      Width = 538
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlGrid: TPanel [5]
    Left = 0
    Top = 203
    Width = 825
    Height = 289
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    TabStop = True
    ExplicitWidth = 717
    object cxGrid: TcxGrid
      Left = 2
      Top = 26
      Width = 821
      Height = 261
      Align = alClient
      TabOrder = 1
      OnEnter = cxGridEnter
      OnExit = cxGridExit
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 713
      object cxGridItens: TcxGridDBTableView
        OnKeyDown = cxGridItensKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGridItensCodIte: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridItensDescri: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 288
        end
        object cxGridItensUnidad: TcxGridDBColumn
          Caption = 'Und.'
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
          Options.Focusing = False
          Width = 39
        end
        object cxGridItensQtdIte: TcxGridDBColumn
          Caption = 'Qtde'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 39
        end
        object cxGridItensEmpIte: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'EMPITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 34
        end
        object cxGridItensUnitar: TcxGridDBColumn
          Caption = 'Vr.Unit.'
          DataBinding.FieldName = 'UNITAR'
          Visible = False
          Options.Editing = False
          Options.Focusing = False
          Width = 61
        end
        object cxGridItensTotIte: TcxGridDBColumn
          Caption = 'Vr.Total'
          DataBinding.FieldName = 'TOTITE'
          Visible = False
          Options.Editing = False
          Options.Focusing = False
          Width = 78
        end
        object cxGridItensLote: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'NUMLOT'
          Options.Editing = False
          Options.Focusing = False
          Width = 129
        end
        object cxGridItensNewLot: TcxGridDBColumn
          Caption = 'Novo Lote'
          DataBinding.FieldName = 'NEWLOT'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.CharCase = ecUpperCase
          Properties.OnButtonClick = cxGridItensNovoLotePropertiesButtonClick
          Properties.OnValidate = cxGridItensNewLotPropertiesValidate
          Width = 134
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridItens
      end
    end
    object pnlTitulo: TPanel
      Left = 2
      Top = 2
      Width = 821
      Height = 24
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Itens do Pedido'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 713
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 308
    Top = 319
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 364
    Top = 319
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 319
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 479
    Top = 355
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 101
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 2
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosUNITAR: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTOTITE: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosNUMLOT: TStringField
      FieldName = 'NUMLOT'
      Size = 30
    end
    object cdsProdutosNEWLOT: TStringField
      FieldName = 'NEWLOT'
      Size = 30
    end
    object cdsProdutosEMPITE: TStringField
      FieldName = 'EMPFAT'
      Size = 3
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 509
    Top = 355
  end
end
