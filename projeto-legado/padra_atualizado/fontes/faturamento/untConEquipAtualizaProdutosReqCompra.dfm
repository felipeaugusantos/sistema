inherited frmConEquipAtualizaProdutosReqCompra: TfrmConEquipAtualizaProdutosReqCompra
  Width = 1004
  Height = 550
  Caption = 'Atualizar Produtos da Ordem de Servi'#231'o para Requisi'#231#227'o de Compra'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1004
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 478
    Width = 998
    ExplicitTop = 478
    ExplicitWidth = 998
    inherited FlwBotoes: TFlowPanel
      Width = 994
      ExplicitWidth = 994
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 998
    ExplicitTop = 505
    ExplicitWidth = 998
    inherited pnlNomeForm: TPanel
      Left = 827
      ExplicitLeft = 827
    end
    inherited pnlInfo: TPanel
      Width = 827
      ExplicitWidth = 827
    end
  end
  inherited pgcDados: TPageControl
    Left = 608
    Top = 128
    Width = 81
    Height = 41
    Align = alNone
    ExplicitLeft = 608
    ExplicitTop = 128
    ExplicitWidth = 81
    ExplicitHeight = 41
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 73
      ExplicitHeight = 9
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 998
    Height = 478
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 998
      Height = 49
      Align = alTop
      TabOrder = 0
      object lblCodReq: TLabel
        Left = 8
        Top = 25
        Width = 111
        Height = 14
        Caption = 'Requisi'#231#227'o de Compra:'
      end
      object edtCodReq: TEditFocus
        Tag = 99
        Left = 125
        Top = 21
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 0
        OnKeyPress = edtCodReqKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDadosOS: TPanel
      Left = 0
      Top = 49
      Width = 998
      Height = 117
      Align = alTop
      Enabled = False
      TabOrder = 1
      DesignSize = (
        998
        117)
      object lnlNumOSe: TLabel
        Left = 30
        Top = 12
        Width = 90
        Height = 14
        Caption = 'N'#186' Ordem Servi'#231'o:'
      end
      object lnlPedido: TLabel
        Left = 241
        Top = 14
        Width = 50
        Height = 14
        Caption = 'N'#186' Pedido:'
      end
      object lblCliente: TLabel
        Left = 85
        Top = 37
        Width = 35
        Height = 14
        Caption = 'Cliente:'
      end
      object lblEquip: TLabel
        Left = 56
        Top = 62
        Width = 64
        Height = 14
        Caption = 'Equipamento:'
      end
      object lblVend: TLabel
        Left = 70
        Top = 87
        Width = 50
        Height = 14
        Caption = 'Vendedor:'
      end
      object lblTecnico: TLabel
        Left = 357
        Top = 87
        Width = 41
        Height = 14
        Caption = 'T'#233'cnico:'
      end
      object edtNumOse: TEditFocus
        Tag = 99
        Left = 122
        Top = 9
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttInteiro
      end
      object edtEmpOSe: TEditFocus
        Tag = 99
        Left = 189
        Top = 9
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 293
        Top = 9
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEmpDoc: TEditFocus
        Tag = 99
        Left = 412
        Top = 9
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 380
        Top = 9
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 122
        Top = 84
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 154
        Top = 84
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
      object edtCodTec: TEditFocus
        Tag = 99
        Left = 400
        Top = 84
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomTec: TEditFocus
        Left = 432
        Top = 84
        Width = 201
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 122
        Top = 34
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 189
        Top = 34
        Width = 444
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEqu: TEditFocus
        Tag = 99
        Left = 122
        Top = 59
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesEqu: TEditFocus
        Left = 173
        Top = 59
        Width = 460
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 453
      Width = 998
      Height = 25
      Align = alBottom
      TabOrder = 3
      object lblInfo: TLabel
        Left = 10
        Top = 5
        Width = 421
        Height = 14
        Caption = 
          '*Exibindo apenas os produtos "Item Especial", os demais produtos' +
          ' n'#227'o ser'#227'o alterados.'
      end
    end
    object cxGrid: TcxGridCitel
      Left = 0
      Top = 166
      Width = 998
      Height = 287
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridTBV: TcxGridDBTableViewCitel
        OnKeyPress = cxGridTBVKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = cxGridTBVEditKeyPress
        DataController.DataSource = dtsGrid
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridTBVCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 56
        end
        object cxGridTBVDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 280
        end
        object cxGridTBVQTDITE: TcxGridDBColumn
          Caption = 'Qtde'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
          Width = 48
        end
        object cxGridTBVVLRUNI: TcxGridDBColumn
          Caption = 'Vlr. Unit'#225'rio'
          DataBinding.FieldName = 'VLRUNI'
          Options.Editing = False
          Width = 66
        end
        object cxGridTBVCODNOV: TcxGridDBColumn
          Caption = 'Novo Item'
          DataBinding.FieldName = 'CODNOV'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEditValueChanged = cxGridTBVCODNOVPropertiesEditValueChanged
          Width = 56
        end
        object cxGridTBVDESNOV: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Novo Item'
          DataBinding.FieldName = 'DESNOV'
          Options.Editing = False
          Width = 280
        end
        object cxGridTBVDESMAR: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'DESMAR'
          Options.Editing = False
          Width = 120
        end
        object cxGridTBVREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Width = 80
        end
        object cxGridTBVCODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'CODFAB'
          Options.Editing = False
          Width = 66
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridTBV
      end
    end
  end
  object pnlButtons: TPanel [4]
    Left = 0
    Top = 478
    Width = 998
    Height = 27
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object FlwPnlButtons: TFlowPanel
      Left = 2
      Top = 2
      Width = 876
      Height = 23
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 118
        Height = 22
        Caption = '[F10] Confirmar'
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
    object btnFechar: TBitBtnLocked
      Left = 878
      Top = 2
      Width = 118
      Height = 23
      Margins.Left = 14
      Margins.Top = 1
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 720
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 16
  end
  object dtsGrid: TDataSource
    Left = 776
    Top = 16
  end
end
