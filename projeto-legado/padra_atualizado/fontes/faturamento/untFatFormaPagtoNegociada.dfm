inherited frmFatFormaPagtoNegociada: TfrmFatFormaPagtoNegociada
  Left = 277
  Top = 251
  Width = 596
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Formas de Pagamento Negociadas'
  Position = poMainFormCenter
  ExplicitWidth = 596
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 590
    Height = 28
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 527
    ExplicitWidth = 590
    ExplicitHeight = 28
    object Label6: TLabel [0]
      Left = 96
      Top = 8
      Width = 32
      Height = 14
      Caption = 'Label6'
    end
    inherited FlwBotoes: TFlowPanel
      Left = 281
      Width = 208
      TabOrder = 3
      ExplicitLeft = 281
      ExplicitWidth = 208
    end
    inherited btnSair: TBitBtnLocked
      Left = 489
      Top = 2
      Width = 99
      Height = 24
      Align = alRight
      Font.Height = -12
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 489
      ExplicitTop = 2
      ExplicitWidth = 99
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 127
      Height = 24
      Align = alLeft
      Caption = '[F10] Confirma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnUnificarCartoes: TBitBtnLocked
      Left = 129
      Top = 2
      Width = 152
      Height = 24
      Align = alLeft
      Caption = '[F3] Unificar Cart'#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000002000000080000
        000C0000000D0000000E0000000E0000000D0000000900000002000000000000
        000000000000000000000000000000000000000000000000000779564ABFA877
        66FFA77664FFA77564FFA67564FFA57363FF765246BF00000008000000000000
        000000000002000000080000000C0000000D0000000D00000016CAB4ACFFEBE6
        E1FFE4D9D1FFE5DAD1FFE8DDD3FFEEE3D8FFA87766FF0000000B000000000000
        0000000000071A4278BF2258A5FF2258A5FF2157A4FF2157A4FF2156A3FF2156
        A3FF2156A2FF2055A3FF5376ACFFEBE2DAFFAC7B6BFF00000009000000000000
        0000000000092660AAFF61B8ECFF57B3EBFF57B2EAFF56B2EAFF55B1E9FF53B1
        E9FF53B0EAFF52AFE9FF2258A4FFEAE4DDFFB08171FF00000008000000000000
        0000000000092864ADFF6AC0EFFF5DB8EDFF5BB6ECFF5BB6ECFF5AB6ECFF58B4
        EBFF57B3EBFF5AB5EAFF235BA7FFEDE8E3FFB48777FF00000006000000000000
        0000000000082B69AFFF75C6F0FF63BCEEFF61BBEEFF60BAEEFF5FBAEDFF5EB9
        EDFF5DB8ECFF61BAEDFF265FA9FFF3F1EFFFB98D7EFF00000005000000020000
        0008000000132D6DB3FF7FCCF3FF68C0EFFF67BFEFFF66BFEFFF64BEEFFF64BD
        EEFF63BCEEFF6CC0EFFF2764ACFFD7C3BBFF8C6D61BF00000002000000077956
        4ABFBF9F93FF3174B6FF8AD3F5FF6EC4F1FF6DC4F1FF6BC3F1FF6BC2F1FF6AC1
        F0FF68C1F0FF76C7F1FF2968AEFF0000000A000000010000000000000009AD7C
        6CFFF4EEE9FF3377B9FF92D7F6FF72C8F3FF72C7F2FF71C6F2FF6FC6F2FF6FC5
        F2FF6EC4F2FF81CEF3FF2C6CB2FF00000007000000000000000000000008B182
        72FFF6F1EDFF357DBEFF9BDCF7FF76CBF4FF75CAF3FF75CAF4FF74CAF3FF73C9
        F3FF72C8F3FF8BD3F6FF2E71B5FF00000006000000000000000000000006B588
        78FFF8F5F1FF3881C0FFA2DFF9FFA0DEF9FF9FDDF7FF9CDDF7FF9ADCF8FF98DA
        F7FF95D9F7FF93D8F7FF3175B7FF00000004000000000000000000000005BA8F
        7FFFFAF8F5FF6BA0CDFF3A85C3FF3984C2FF3983C1FF3883C1FF3882C1FF3881
        C0FF3881C0FF3880C0FF285F8DBF00000003000000000000000000000003BE94
        84FFFDFBFAFFFCFAF9FFFBF9F7FFFBF9F7FFFBF9F7FFCEB1A6FF000000070000
        0003000000030000000300000002000000010000000000000000000000019171
        66BFC29989FFC19888FFC09787FFBF9686FFBF9485FF8C6D61BF000000020000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000010000000200000002000000020000000200000001000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      TabOrder = 1
      OnClick = btnUnificarCartoesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 590
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 419
      ExplicitLeft = 419
    end
    inherited pnlInfo: TPanel
      Width = 419
      ExplicitWidth = 419
    end
  end
  inherited pgcDados: TPageControl
    Width = 590
    Height = 527
    TabOrder = 2
    ExplicitWidth = 590
    ExplicitHeight = 527
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 582
      ExplicitHeight = 495
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 590
    Height = 527
    Align = alClient
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblInfGrid: TLabel
      Left = 1
      Top = 450
      Width = 588
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'Pressione [ESC] para selecionar uma nova forma de pagamento ou P' +
        'ressione [DELETE] para excluir uma j'#225' inserida.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 557
    end
    object cxgFormasNegociadas: TcxGrid
      Left = 1
      Top = 242
      Width = 588
      Height = 208
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgFormasNegociadasView: TcxGridDBBandedTableView
        OnKeyDown = cxgFormasNegociadasViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsFormasNegociadas
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgFormasNegociadasViewVALFPG
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgFormasNegociadasViewVALFPG
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgFormasNegociadasViewVALFPG
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem registros para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'FORMAS DE PAGAMENTO NEGOCIADAS PARA RECEBIMENTO'
          end>
        object cxgFormasNegociadasViewCODFPG: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODFPG'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 45
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgFormasNegociadasViewDESFPG: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESFPG'
          Options.Editing = False
          Options.Filtering = False
          Width = 183
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgFormasNegociadasViewVALFPG: TcxGridDBBandedColumn
          Caption = 'Valor Negociado'
          DataBinding.FieldName = 'VALFPG'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 105
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgFormasNegociadasViewVALANT: TcxGridDBBandedColumn
          Caption = 'Recebido Bxa. Ctr.'
          DataBinding.FieldName = 'VALANT'
          Width = 105
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgFormasNegociadasViewVALREC: TcxGridDBBandedColumn
          Caption = 'Valor Recebido'
          DataBinding.FieldName = 'VALREC'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 105
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgFormasNegociadasViewFPGREC: TcxGridDBBandedColumn
          Caption = 'Rec.?'
          DataBinding.FieldName = 'FPGREC'
          RepositoryItem = cxrImgFpgRec
          Options.Editing = False
          Width = 40
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object cxgFormasNegociadasLevel: TcxGridLevel
        GridView = cxgFormasNegociadasView
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 494
      Width = 588
      Height = 32
      Align = alBottom
      BevelOuter = bvLowered
      BorderWidth = 4
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object lblValVen: TLabel
        Left = 40
        Top = 5
        Width = 72
        Height = 22
        Align = alRight
        Alignment = taRightJustify
        Caption = ' Valor Total: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 16
      end
      object Label13: TLabel
        Left = 392
        Top = 5
        Width = 97
        Height = 22
        Align = alRight
        Alignment = taRightJustify
        Caption = ' Valor Restante: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 16
      end
      object lblValDig: TLabel
        Left = 206
        Top = 5
        Width = 92
        Height = 22
        Align = alRight
        Alignment = taRightJustify
        Caption = ' Valor Digitado: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 16
      end
      object edtValVen: TCurrencyEditFocus
        Left = 112
        Top = 5
        Margins.Left = 8
        Margins.Top = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clGreen
        Style.Font.Height = -13
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Height = 22
        Width = 94
      end
      object edtValDig: TCurrencyEditFocus
        Left = 298
        Top = 5
        Margins.Left = 8
        Margins.Top = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -13
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Height = 22
        Width = 94
      end
      object edtValRes: TCurrencyEditFocus
        Left = 489
        Top = 5
        Margins.Left = 8
        Margins.Top = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -13
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Height = 22
        Width = 94
      end
    end
    object pnlDadosCondicao: TPanel
      Left = 1
      Top = 1
      Width = 588
      Height = 74
      Align = alTop
      ParentColor = True
      TabOrder = 0
      object Label5: TLabel
        Left = 11
        Top = 3
        Width = 208
        Height = 16
        Caption = 'Condi'#231#227'o de Pagamento do Pedido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTotalCreditos: TLabel
        Left = 428
        Top = 3
        Width = 114
        Height = 16
        Caption = 'Cr'#233'ditos do Cliente:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCndPed: TEditFocus
        Tag = 99
        Left = 11
        Top = 20
        Width = 42
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnKeyPress = edtCodCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesCndPed: TEditFocus
        Left = 56
        Top = 20
        Width = 366
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
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
      object edtConPagPed: TEditFocus
        Tag = 99
        Left = 11
        Top = 45
        Width = 542
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnKeyPress = edtCodCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtTotalCreditos: TCurrencyEditFocus
        Tag = 99
        Left = 428
        Top = 20
        Margins.Left = 7
        Margins.Top = 2
        TabStop = False
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Height = 22
        Width = 125
      end
    end
    object pnlFormasPagamento: TPanel
      Left = 1
      Top = 75
      Width = 588
      Height = 167
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label2: TLabel
        Left = 11
        Top = 4
        Width = 129
        Height = 16
        Caption = 'Forma de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 414
        Top = 4
        Width = 33
        Height = 16
        Caption = 'Valor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 476
        Top = 51
        Width = 73
        Height = 16
        Caption = 'N'#176' Parcelas:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 11
        Top = 51
        Width = 42
        Height = 16
        Caption = 'Cart'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblConPag: TLabel
        Left = 11
        Top = 97
        Width = 460
        Height = 16
        Caption = 
          'Condi'#231#227'o de Pagamento (Ex: 2 cheques para 30 e 60 dias, utilizar' +
          ' 02.030.060):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblQtdParcelMax: TLabel
        Left = 88
        Top = 51
        Width = 366
        Height = 16
        Caption = 'Qtd. M'#225'xima de Parcelas (Cart'#227'o) da Condi'#231#227'o de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblDtaChq: TLabel
        Left = 257
        Top = 96
        Width = 72
        Height = 16
        Caption = 'Vencimento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object cbxModalidades: TComboBoxFocus
        Tag = 99
        Left = 11
        Top = 23
        Width = 397
        Height = 24
        BevelInner = bvLowered
        BevelKind = bkFlat
        Style = csOwnerDrawFixed
        Color = 16316664
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemHeight = 18
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnChange = cbxModalidadesChange
        OnEnter = cbxModalidadesEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtValor: TCurrencyEditFocus
        Tag = 99
        Left = 414
        Top = 23
        Margins.Left = 7
        Margins.Top = 2
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.DisplayFormat = '#,##0.00'
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Height = 24
        Width = 139
      end
      object mskConPag: TMaskEditFocus
        Tag = 99
        Left = 11
        Top = 116
        Width = 525
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Enabled = False
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodCar: TEditFocus
        Tag = 99
        Left = 11
        Top = 68
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnKeyPress = edtCodCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCar: TEditFocus
        Left = 88
        Top = 68
        Width = 382
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
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
      object btnInserirFormaPagto: TBitBtnLocked
        Left = 10
        Top = 139
        Width = 202
        Height = 26
        Caption = 'Incluir Forma de Pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000C30E0000C30E00000001000000000000006B00000073
          0000007B000000940000009C0000086B0800087B08000884080008A5080008AD
          080008B5080010731000107B10001084100010A5100010AD100010B510001873
          1800187B180018841800188C1800189C180018A5180018AD180018B51800217B
          2100218C210021942100219C210021AD210021B5210029942900299C29003194
          3100319C3100399C390039A5390039AD3900429C420042A5420042AD42004AA5
          4A004AAD4A0052A5520052AD52005AAD5A0063AD630063B563006BB56B0073BD
          73007BB57B007BBD7B0084B5840084C684008CBD8C008CC68C009CCE9C00A5D6
          A500B5DEB500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3B3C340B11111112120C0C06060201323C3C0D1A1F2121
          1F201C16160E0803003C3C141F23232324393C1D17100904023C3C1B23272927
          273C3C3C1E180F08063C3C1F26292B2927283C3C3C180F0E073C3C22292B2B29
          2927253C3C3C17160D3C3C262B3C3C3C3C3C3C3C3C3C3C1C133C3C272D3C3C3C
          3C3C3C3C3C3C3C1C193C3C2B2E2E2D2B2926233C3C3C201F193C3C2B30302D2B
          29263C3C3C1F1F1F193C3C2D33312E2D2B3C3C3C22222121193C3C303733302F
          2E3A3C2929272321193C3C3138373331302F2E2D2C292721113C3C3A312F2D2B
          2B2929272623211A363C3B3C3C3C3C3C3C3C3C3C3C3C3C3C3C3B}
        ParentFont = False
        TabOrder = 8
        OnClick = btnInserirFormaPagtoClick
      end
      object edtQtdPar: TEditFocus
        Tag = 99
        Left = 476
        Top = 68
        Width = 77
        Height = 22
        Alignment = taCenter
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttInteiro
      end
      object btnSelCre: TBitBtnLocked
        Left = 555
        Top = 22
        Width = 25
        Height = 25
        Hint = 'Selecionar duplicatas de cr'#233'dito'
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
          A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
          ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
          A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
          A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
          B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
          A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
          A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
          C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
          A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
          A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
          BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
          A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
          A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
          D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
          9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
          AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
          DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
          9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
          A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
          B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
          FFFFFFFFFFFFFF000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Visible = False
        OnClick = btnSelCreClick
      end
      object dtaDtaChq: TcxDateEdit
        Tag = 99
        Left = 257
        Top = 114
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 7
        Visible = False
        Width = 90
      end
    end
    object pnlTroco: TPanel
      Left = 1
      Top = 464
      Width = 588
      Height = 30
      Align = alBottom
      BevelOuter = bvLowered
      BorderWidth = 5
      Caption = 'VALOR DO TROCO: 0,00'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 88
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 56
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 304
  end
  object dtsFormasNegociadas: TDataSource
    Left = 152
    Top = 304
  end
  object cxRepositorio: TcxEditRepository
    Left = 568
    Top = 296
    PixelsPerInch = 96
    object cxrImgFpgRec: TcxEditRepositoryImageComboBoxItem
      Properties.Images = cxImageList
      Properties.Items = <
        item
          ImageIndex = 0
          Value = 'S'
        end
        item
          ImageIndex = 1
          Value = 'N'
        end>
    end
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 19399192
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000008080000080
          8000008080000080800000808000800000008000000000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800080000000008000000080000080000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080008000000000800000008000000080000000800000800000000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000800000000080000000800000008000000080000000800000008000008000
          0000008080000080800000808000008080000080800000808000008080008000
          000000800000008000000080000000FF00000080000000800000008000000080
          0000800000000080800000808000008080000080800000808000008080000080
          0000008000000080000000FF00000080800000FF000000800000008000000080
          00008000000000808000008080000080800000808000008080000080800000FF
          00000080000000FF000000808000008080000080800000FF0000008000000080
          0000008000008000000000808000008080000080800000808000008080000080
          800000FF0000008080000080800000808000008080000080800000FF00000080
          0000008000000080000080000000008080000080800000808000008080000080
          80000080800000808000008080000080800000808000008080000080800000FF
          0000008000000080000000800000800000000080800000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000FF00000080000000800000008000008000000000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          80000080800000FF000000800000008000000080000080000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000FF0000008000000080000000800000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000808000008080000080800000FF00000080000000800000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          80000080800000808000008080000080800000FF000000800000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000008080000080800000FF0000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000008080000080800000808000}
        MaskColor = clOlive
      end>
  end
end
