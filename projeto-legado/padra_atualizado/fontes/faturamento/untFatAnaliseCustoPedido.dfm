inherited frmFatAnaliseCustoPedido: TfrmFatAnaliseCustoPedido
  Width = 1226
  Height = 875
  Caption = 'An'#225'lise de Custo no Pedido'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1226
  ExplicitHeight = 875
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 805
    Width = 1220
    Height = 25
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 805
    ExplicitWidth = 1220
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 1216
      Height = 21
      ExplicitWidth = 1216
      ExplicitHeight = 21
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 103
        Height = 20
        Caption = '&Confirmar'
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
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1113
      Top = 2
      Width = 103
      Height = 20
      ExplicitLeft = 1113
      ExplicitTop = 2
      ExplicitWidth = 103
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 830
    Width = 1220
    TabOrder = 3
    ExplicitTop = 830
    ExplicitWidth = 1220
    inherited pnlNomeForm: TPanel
      Left = 1049
      ExplicitLeft = 1049
    end
    inherited pnlInfo: TPanel
      Width = 1049
      ExplicitWidth = 1049
    end
  end
  inherited pgcDados: TPageControl
    Width = 1220
    Height = 805
    TabOrder = 2
    ExplicitWidth = 1220
    ExplicitHeight = 805
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1212
      ExplicitHeight = 773
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1220
    Height = 805
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 1218
      Height = 32
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblPedido: TLabel
        Left = 45
        Top = 7
        Width = 35
        Height = 14
        Caption = 'Pedido:'
      end
      object lblNumPedido: TLabel
        Left = 86
        Top = 7
        Width = 84
        Height = 14
        Caption = 'XXXXXXXXXXXX'
      end
      object lblEmpresa: TLabel
        Left = 216
        Top = 7
        Width = 45
        Height = 14
        Caption = 'Empresa:'
      end
      object lblDescEmpresa: TLabel
        Left = 266
        Top = 7
        Width = 445
        Height = 14
        Caption = 'XXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
      end
    end
    object pnlDadosPedido: TPanel
      Left = 1
      Top = 33
      Width = 1218
      Height = 194
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCliente: TLabel
        Left = 3
        Top = 8
        Width = 35
        Height = 14
        Caption = 'Cliente:'
      end
      object lblVendedor: TLabel
        Left = 3
        Top = 31
        Width = 50
        Height = 14
        Caption = 'Vendedor:'
      end
      object lblConPag: TLabel
        Left = 3
        Top = 54
        Width = 64
        Height = 14
        Caption = 'Cond. Pagto.:'
      end
      object lblFormPag: TLabel
        Left = 3
        Top = 100
        Width = 66
        Height = 14
        Caption = 'Forma Pagto.:'
      end
      object lblCartao: TLabel
        Left = 3
        Top = 123
        Width = 35
        Height = 14
        Caption = 'Cart'#227'o:'
      end
      object lblTransp: TLabel
        Left = 3
        Top = 146
        Width = 78
        Height = 14
        Caption = 'Transportadora:'
      end
      object lblFrete: TLabel
        Left = 609
        Top = 146
        Width = 72
        Height = 14
        Caption = 'Vr.Frete Sa'#237'da:'
      end
      object lblValorFrete: TLabel
        Left = 683
        Top = 146
        Width = 60
        Height = 14
        Caption = 'lblValorFrete'
      end
      object edtCliente: TEditFocus
        Left = 85
        Top = 5
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVendedor: TEditFocus
        Left = 85
        Top = 28
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCodCnd: TEditFocus
        Left = 85
        Top = 51
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtConPag: TEditFocus
        Left = 85
        Top = 74
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtForPag: TEditFocus
        Left = 85
        Top = 97
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesCar: TEditFocus
        Left = 127
        Top = 120
        Width = 471
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtTransp: TEditFocus
        Left = 85
        Top = 143
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCar: TEditFocus
        Left = 85
        Top = 120
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 7
        OnExit = edtCodCarExit
        OnKeyPress = edtCodCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object pnlProfissional: TPanel
        Left = 1
        Top = 165
        Width = 1216
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 8
        object lblProfi: TLabel
          Left = 2
          Top = 4
          Width = 59
          Height = 14
          Caption = 'Profissional:'
        end
        object lblComissao: TLabel
          Left = 630
          Top = 4
          Width = 50
          Height = 14
          Caption = 'Comiss'#227'o:'
        end
        object lblPercComissao: TLabel
          Left = 731
          Top = 4
          Width = 10
          Height = 14
          Caption = '%'
        end
        object edtProfi: TEditFocus
          Left = 84
          Top = 1
          Width = 513
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValorComissao: TEditFocus
          Left = 682
          Top = 1
          Width = 46
          Height = 22
          Alignment = taRightJustify
          TabOrder = 1
          OnExit = edtValorComissaoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
    object cxgProdutos: TcxGrid
      Left = 1
      Top = 337
      Width = 1218
      Height = 438
      Align = alClient
      TabOrder = 3
      object cxgProdutosDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgProdutosDBTableViewCustomDrawCell
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxgProdutosQTDITE
          end
          item
            Kind = skSum
            Column = cxgProdutosVLRUNI
          end
          item
            Kind = skSum
            Column = cxgProdutosDESESP
          end
          item
            Kind = skSum
            Column = cxgProdutosVLRTOT
          end
          item
            Kind = skSum
            Column = cxgProdutosFREENT
          end
          item
            Kind = skSum
            Column = cxgProdutosCMV
          end
          item
            Kind = skSum
            Column = cxgProdutosCOMPRO
          end
          item
            Kind = skSum
            Column = cxgProdutosTAXCAR
          end
          item
            Kind = skSum
            Column = cxgProdutosCUSTOT
          end
          item
            Kind = skSum
            Column = cxgProdutosRESULT
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxgProdutosCODIGO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 48
        end
        object cxgProdutosDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 517
        end
        object cxgProdutosUNIDAD: TcxGridDBColumn
          Caption = 'UN'
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
        end
        object cxgProdutosMARCA: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'MARCA'
          Options.Editing = False
          Width = 240
        end
        object cxgProdutosAMBCOM: TcxGridDBColumn
          Caption = 'Ambiente/Complemento'
          DataBinding.FieldName = 'COMPLE'
          Options.Editing = False
          Width = 228
        end
        object cxgProdutosQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
        end
        object cxgProdutosVLRUNI: TcxGridDBColumn
          Caption = 'Vr. Unit'#225'rio'
          DataBinding.FieldName = 'UNITAR'
          Options.Editing = False
        end
        object cxgProdutosDESESP: TcxGridDBColumn
          Caption = 'Desc. Esp.'
          DataBinding.FieldName = 'DESESP'
          Options.Editing = False
        end
        object cxgProdutosVLRTOT: TcxGridDBColumn
          Caption = 'Vr. Total'
          DataBinding.FieldName = 'VLRTOT'
          Options.Editing = False
        end
        object cxgProdutosFREENT: TcxGridDBColumn
          Caption = 'Vr. Frete Ent.'
          DataBinding.FieldName = 'FREENT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValidate = cxgProdutosFREENTPropertiesValidate
          Width = 69
        end
        object cxgProdutosCMV: TcxGridDBColumn
          DataBinding.FieldName = 'CMV'
          Options.Editing = False
        end
        object cxgProdutosCOMPRO: TcxGridDBColumn
          Caption = 'Vr. Com. Profis.'
          DataBinding.FieldName = 'COMPRO'
          Options.Editing = False
          Width = 81
        end
        object cxgProdutosTAXCAR: TcxGridDBColumn
          Caption = 'Vr. Tx. Cart'#227'o'
          DataBinding.FieldName = 'TAXCAR'
          Options.Editing = False
          Width = 73
        end
        object cxgProdutosCUSTOT: TcxGridDBColumn
          Caption = 'Vr. Cust. Total'
          DataBinding.FieldName = 'CUSTOT'
          Options.Editing = False
          Width = 85
        end
        object cxgProdutosRESULT: TcxGridDBColumn
          Caption = 'Resultado'
          DataBinding.FieldName = 'RESULT'
          Options.Editing = False
        end
        object cxgProdutosMARGEM: TcxGridDBColumn
          Caption = 'Margem'
          DataBinding.FieldName = 'MARGEM'
          Options.Editing = False
        end
      end
      object cxgProdutosLevel: TcxGridLevel
        GridView = cxgProdutosDBTableView
      end
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 775
      Width = 1218
      Height = 29
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
      DesignSize = (
        1218
        29)
      object shpLegCamEdit: TShape
        Left = 8
        Top = 4
        Width = 20
        Height = 20
        Brush.Color = clYellow
      end
      object lblLegCamEdit: TLabel
        Left = 34
        Top = 7
        Width = 99
        Height = 13
        Caption = 'Campos Editaveis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotMargem: TLabel
        Left = 1017
        Top = 5
        Width = 70
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Margem Geral:'
      end
      object edtTotMargem: TEditFocus
        Left = 1091
        Top = 2
        Width = 121
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlProfissionalVarios: TPanel
      Left = 1
      Top = 227
      Width = 1218
      Height = 110
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object pnlGridProfisionalVarios: TPanel
        Left = 1
        Top = 1
        Width = 597
        Height = 108
        Align = alLeft
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object cxgProfissionais: TcxGrid
          Left = 1
          Top = 1
          Width = 595
          Height = 106
          Align = alClient
          TabOrder = 0
          object cxgProfissionaisDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgProfissionaisDBTableViewCustomDrawCell
            DataController.DataSource = dtaProfissionais
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxgProfissionaisCODPRO: TcxGridDBColumn
              DataBinding.FieldName = 'CODPRO'
              Options.Editing = False
              Options.AutoWidthSizable = False
              Width = 80
            end
            object cxgProfissionaisNOMPRO: TcxGridDBColumn
              DataBinding.FieldName = 'NOMPRO'
              Options.Editing = False
              Options.AutoWidthSizable = False
              Width = 405
            end
            object cxgProfissionaisCOMPRO: TcxGridDBColumn
              DataBinding.FieldName = 'COMPRO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValidate = cxgProfissionaisCOMPROPropertiesValidate
              Options.AutoWidthSizable = False
              Width = 85
            end
          end
          object cxgProfissionaisLevel: TcxGridLevel
            GridView = cxgProfissionaisDBTableView
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1024
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 992
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 960
    Top = 48
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 944
    Top = 536
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 4
    end
    object cdsProdutosMARCA: TStringField
      FieldName = 'MARCA'
      Size = 30
    end
    object cdsProdutosCOMPLE: TStringField
      FieldName = 'COMPLE'
      Size = 60
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsProdutosUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsProdutosDESESP: TFloatField
      FieldName = 'DESESP'
    end
    object cdsProdutosVLRTOT: TFloatField
      FieldName = 'VLRTOT'
    end
    object cdsProdutosFREENT: TFloatField
      FieldName = 'FREENT'
    end
    object cdsProdutosCMV: TFloatField
      FieldName = 'CMV'
    end
    object cdsProdutosCOMPRO: TFloatField
      FieldName = 'COMPRO'
    end
    object cdsProdutosTAXCAR: TFloatField
      FieldName = 'TAXCAR'
    end
    object cdsProdutosCUSTOT: TFloatField
      FieldName = 'CUSTOT'
    end
    object cdsProdutosRESULT: TFloatField
      FieldName = 'RESULT'
    end
    object cdsProdutosMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosEMPITE: TStringField
      FieldName = 'EMPITE'
      Size = 3
    end
    object cdsProdutosCODFIS: TStringField
      FieldName = 'CODFIS'
      Size = 5
    end
    object cdsProdutosVALCOM: TFloatField
      FieldName = 'VALCOM'
    end
    object cdsProdutosIMPDIR: TStringField
      FieldName = 'IMPDIR'
      Size = 1
    end
    object cdsProdutosICMSAI: TFloatField
      FieldName = 'ICMSAI'
    end
    object cdsProdutosIMPFED: TFloatField
      FieldName = 'IMPFED'
    end
    object cdsProdutosDESOPE: TFloatField
      FieldName = 'DESOPE'
    end
    object cdsProdutosALDIFA: TFloatField
      FieldName = 'ALDIFA'
    end
    object cdsProdutosVALRET: TFloatField
      FieldName = 'VALRET'
    end
    object cdsProdutosBASICM: TFloatField
      FieldName = 'BASICM'
    end
    object cdsProdutosPERFCP: TFloatField
      FieldName = 'PERFCP'
    end
    object cdsProdutosOUTVAL: TFloatField
      FieldName = 'OUTVAL'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 1016
    Top = 536
  end
  object cdsProfissionais: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 769
    Top = 267
    object cdsProfissionaisCODPRO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPRO'
      Size = 8
    end
    object cdsProfissionaisNOMPRO: TStringField
      DisplayLabel = 'Profissional'
      FieldName = 'NOMPRO'
      Size = 40
    end
    object cdsProfissionaisCOMPRO: TFloatField
      DisplayLabel = 'Comiss'#227'o %'
      FieldName = 'COMPRO'
      DisplayFormat = '##0.00'
      EditFormat = '##0.00'
    end
    object cdsProfissionaisTOTCOMPRO: TAggregateField
      FieldName = 'TOTCOMPRO'
      Active = True
      DisplayName = ''
      DisplayFormat = '##0.00'
      Expression = 'SUM(COMPRO)'
    end
  end
  object dtaProfissionais: TDataSource
    DataSet = cdsProfissionais
    Left = 857
    Top = 267
  end
end
