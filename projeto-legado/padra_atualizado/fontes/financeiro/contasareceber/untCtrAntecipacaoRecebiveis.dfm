inherited frmCtrAntecipacaoRecebiveis: TfrmCtrAntecipacaoRecebiveis
  Left = 960
  Top = 309
  Width = 768
  Height = 666
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Contas a Receber - Acerto de Conta - Antecipa'#231#227'o de Receb'#237'veis'
  Position = poMainFormCenter
  ExplicitWidth = 768
  ExplicitHeight = 666
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 593
    Width = 762
    ExplicitTop = 593
    ExplicitWidth = 762
    DesignSize = (
      762
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 758
      Align = alBottom
      TabOrder = 2
      ExplicitWidth = 758
    end
    inherited btnSair: TBitBtnLocked
      Left = 672
      Width = 86
      ExplicitLeft = 672
      ExplicitWidth = 86
    end
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 164
      Height = 22
      Caption = '[ F10 ] &Gravar Cr'#233'dito'
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
    object btnCalculo: TBitBtnLocked
      AlignWithMargins = True
      Left = 583
      Top = 3
      Width = 89
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&C'#225'lculos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnCalculoClick
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 29
    Width = 762
    Height = 36
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 517
      Top = 9
      Width = 57
      Height = 14
      Caption = 'Total Geral :'
    end
    object lblPreVis: TLabel
      Left = 49
      Top = 11
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Pagamento :'
    end
    object edtValorCorrigido: TEditFocus
      Tag = 99
      Left = 577
      Top = 6
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskDtaPagto: TMaskEditFocus
      Tag = 99
      Left = 139
      Top = 6
      Width = 80
      Height = 22
      TabStop = False
      Color = 16768952
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 621
    Width = 762
    ExplicitTop = 621
    ExplicitWidth = 762
    inherited pnlNomeForm: TPanel
      Left = 591
      ExplicitLeft = 591
    end
    inherited pnlInfo: TPanel
      Width = 591
      ExplicitWidth = 591
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 762
    Height = 29
    Align = alTop
    Caption = 'ANTECIPA'#199#195'O DE RECEB'#205'VEIS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
  end
  object pnlGrid: TPanel [5]
    Left = 0
    Top = 232
    Width = 762
    Height = 361
    Align = alClient
    ParentColor = True
    TabOrder = 5
    object pnlTotais: TPanel
      Left = 1
      Top = 294
      Width = 760
      Height = 66
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 0
      DesignSize = (
        760
        66)
      object lblvaldig: TLabel
        Left = 529
        Top = 12
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Digitado :'
      end
      object Label3: TLabel
        Left = 334
        Top = 39
        Width = 266
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor dos receb'#237'veis trazidos at'#233' a data do pagamento:'
      end
      object Label4: TLabel
        Left = 43
        Top = 12
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total desconto :'
      end
      object Label5: TLabel
        Left = 25
        Top = 39
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Data Base C'#225'lculo :'
      end
      object edtValCalc: TEditFocus
        Tag = 99
        Left = 604
        Top = 35
        Width = 130
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValDig: TEditFocus
        Tag = 99
        Left = 604
        Top = 8
        Width = 130
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValTotDesconto: TEditFocus
        Tag = 99
        Left = 129
        Top = 8
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object mskDtaBase: TMaskEditFocus
        Tag = 99
        Left = 129
        Top = 35
        Width = 89
        Height = 22
        TabStop = False
        Color = 16768952
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ReadOnly = True
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object cxGridParcelas: TcxGrid
      Left = 1
      Top = 1
      Width = 760
      Height = 293
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvGridParcelas: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.HideSelection = True
        OptionsView.GroupByBox = False
        Styles.ContentEven = cxStyleZebra
        object cxvGridANT_ESPORI: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'ANT_ESPORI'
          Width = 120
        end
        object cxvGridANT_VLRORI: TcxGridDBColumn
          Caption = 'Vlr. Original'
          DataBinding.FieldName = 'ANT_VLRORI'
          Width = 90
        end
        object cxvGridANT_PRCDSC: TcxGridDBColumn
          Caption = '% Desc.'
          DataBinding.FieldName = 'ANT_PRCDSC'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 60
        end
        object cxvGridANT_VLRDSC: TcxGridDBColumn
          Caption = 'Vlr.Desc.'
          DataBinding.FieldName = 'ANT_VLRDSC'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxvGridANT_VLRCAL: TcxGridDBColumn
          Caption = 'Vlr. Calculado'
          DataBinding.FieldName = 'ANT_VLRCAL'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 90
        end
        object cxvGridANT_NROCHQ: TcxGridDBColumn
          Caption = 'N'#186' Cheque'
          DataBinding.FieldName = 'ANT_NROCHQ'
          Options.Editing = False
          Width = 100
        end
        object cxvGridANT_NOMCAR: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'ANT_NOMCAR'
          Options.Editing = False
          Width = 120
        end
        object cxvGridANT_DTAVEN: TcxGridDBColumn
          Caption = 'Dt. Vencimento'
          DataBinding.FieldName = 'ANT_DTAVEN'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 80
        end
      end
      object cxGridParcelasLevel1: TcxGridLevel
        GridView = cxvGridParcelas
      end
    end
  end
  object pnlFundo: TPanel [6]
    Left = 0
    Top = 65
    Width = 762
    Height = 167
    Align = alTop
    AutoSize = True
    Color = 16770261
    TabOrder = 6
    object lblPorBaiDin: TLabel
      Left = 27
      Top = 6
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblDinheiro: TLabel
      Left = 531
      Top = 8
      Width = 42
      Height = 14
      Caption = 'Dinheiro:'
    end
    object lblPorBaiChV: TLabel
      Left = 27
      Top = 28
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblChequeVista: TLabel
      Left = 500
      Top = 32
      Width = 77
      Height = 14
      Caption = 'Cheque a Vista:'
    end
    object lblPorBaiOrd: TLabel
      Left = 27
      Top = 54
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblChequePre: TLabel
      Left = 511
      Top = 55
      Width = 66
      Height = 14
      Caption = 'Cheque - Pr'#233':'
    end
    object lblPorBaiRep: TLabel
      Left = 27
      Top = 78
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblCartao: TLabel
      Left = 542
      Top = 77
      Width = 35
      Height = 14
      Caption = 'Cart'#227'o:'
    end
    object Label2: TLabel
      Left = 26
      Top = 124
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lbl1: TLabel
      Left = 19
      Top = 148
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtPorBaiDin: TEditFocus
      Tag = 99
      Left = 73
      Top = 1
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtPorBaiDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorBaiDin: TEditFocus
      Left = 139
      Top = 1
      Width = 323
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
    object edtDinheiro: TEditFocus
      Tag = 99
      Left = 579
      Top = 4
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPorBaiChV: TEditFocus
      Tag = 99
      Left = 73
      Top = 25
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtPorBaiChVKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorChV: TEditFocus
      Left = 139
      Top = 25
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtChqVista: TEditFocus
      Tag = 99
      Left = 579
      Top = 27
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPorBaiChP: TEditFocus
      Tag = 99
      Left = 73
      Top = 49
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 6
      OnKeyPress = edtPorBaiChPKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorChP: TEditFocus
      Left = 139
      Top = 49
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChqPre: TEditFocus
      Tag = 99
      Left = 579
      Top = 50
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPorCart: TEditFocus
      Tag = 99
      Left = 73
      Top = 73
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 9
      OnKeyPress = edtPorCartKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorCart: TEditFocus
      Left = 139
      Top = 73
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCartao: TEditFocus
      Tag = 99
      Left = 579
      Top = 73
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPorAntec: TEditFocus
      Tag = 99
      Left = 73
      Top = 120
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 12
      OnKeyPress = edtPorAntecKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorAntec: TEditFocus
      Left = 139
      Top = 120
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 73
      Top = 144
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 13
      TabOrder = 14
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
    object edtNomVen: TEditFocus
      Left = 139
      Top = 144
      Width = 323
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 648
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 224
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 176
    Top = 464
    PixelsPerInch = 96
    object cxStyleZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
