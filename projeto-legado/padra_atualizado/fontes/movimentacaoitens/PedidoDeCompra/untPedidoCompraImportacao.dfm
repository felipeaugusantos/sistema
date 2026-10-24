inherited frmPedidoCompraImportacao: TfrmPedidoCompraImportacao
  Width = 1375
  Height = 636
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Pedido de Importa'#231#227'o'
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1375
  ExplicitHeight = 636
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 553
    Width = 1359
    ExplicitTop = 553
    ExplicitWidth = 1359
    inherited FlwBotoes: TFlowPanel
      Width = 1355
      ExplicitWidth = 1355
    end
    inherited btnSair: TBitBtnLocked
      Left = 1276
      ExplicitLeft = 1276
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
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
      TabOrder = 1
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1359
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lbl4: TLabel
      Left = 68
      Top = 13
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Taxa Siscomex:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 7
      Top = 36
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marinha Mercante (AFRMM):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtValTax: TEditFocus
      Tag = 99
      Left = 147
      Top = 9
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtMarMer: TEditFocus
      Tag = 99
      Left = 147
      Top = 32
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnl2: TPanel [3]
    Left = 0
    Top = 317
    Width = 1359
    Height = 236
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object grb1: TGroupBox
      Left = 21
      Top = 6
      Width = 324
      Height = 227
      Caption = 'Resumo final:'
      TabOrder = 0
      object lbl1: TLabel
        Left = 90
        Top = 21
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor das Mercadorias:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 48
        Top = 44
        Width = 154
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do Imposto de Importa'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 146
        Top = 67
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do IPI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 141
        Top = 90
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do PIS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl6: TLabel
        Left = 125
        Top = 113
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do Cofins:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 126
        Top = 136
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Taxa Siscomex:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 71
        Top = 182
        Width = 131
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do ICMS Incorporado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl10: TLabel
        Left = 67
        Top = 205
        Width = 135
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor total da Nota Fiscal:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl11: TLabel
        Left = 65
        Top = 159
        Width = 137
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marinha Mercante (AFRMM):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtTotIte: TEditFocus
        Tag = 99
        Left = 205
        Top = 17
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotImp: TEditFocus
        Tag = 99
        Left = 205
        Top = 40
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotIPI: TEditFocus
        Tag = 99
        Left = 205
        Top = 63
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
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
      object edtTotPis: TEditFocus
        Tag = 99
        Left = 205
        Top = 86
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotCof: TEditFocus
        Tag = 99
        Left = 205
        Top = 109
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotTax: TEditFocus
        Tag = 99
        Left = 205
        Top = 132
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
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
      object edtTotIcm: TEditFocus
        Tag = 99
        Left = 205
        Top = 178
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotGer: TEditFocus
        Tag = 99
        Left = 205
        Top = 201
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
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
      object edtTotMar: TEditFocus
        Tag = 99
        Left = 205
        Top = 155
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object grbReforma: TGroupBox
      Left = 355
      Top = 6
      Width = 260
      Height = 96
      Caption = 'Reforma Tribut'#225'ria:'
      TabOrder = 1
      object lblTotCbs: TLabel
        Left = 64
        Top = 21
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da CBS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTotIbs: TLabel
        Left = 67
        Top = 44
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do IBS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTotIs: TLabel
        Left = 76
        Top = 67
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do IS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtTotCbs: TEditFocus
        Tag = 99
        Left = 142
        Top = 17
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotIbs: TEditFocus
        Tag = 99
        Left = 142
        Top = 40
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotIs: TEditFocus
        Tag = 99
        Left = 142
        Top = 63
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
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
    end
  end
  object cxgItens: TcxGrid [4]
    Left = 0
    Top = 65
    Width = 1359
    Height = 252
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxbItens: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Bands = <
        item
          Width = 241
        end
        item
          Width = 1200
        end>
      object cxcItensDBBandedTableView1Column1: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column2: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 260
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxcItensColumn1: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ITE_SIGUNI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcItensColumn2: TcxGridDBBandedColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxcItensUNILIQ: TcxGridDBBandedColumn
        Caption = 'Valor Unit'#225'rio'
        DataBinding.FieldName = 'ITE_UNILIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxcItensColumn4: TcxGridDBBandedColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'ITE_TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxcItensColumn5: TcxGridDBBandedColumn
        Caption = ' % II'
        DataBinding.FieldName = 'ITE_ALQIMP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxcItensColumn6: TcxGridDBBandedColumn
        Caption = 'VR.II'
        DataBinding.FieldName = 'ITE_VALIMP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxcItensColumn7: TcxGridDBBandedColumn
        Caption = '% IPI'
        DataBinding.FieldName = 'ITE_PERIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxcItensColumn8: TcxGridDBBandedColumn
        Caption = 'VR.IPI'
        DataBinding.FieldName = 'ITE_TOTIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxbItensALQCBS: TcxGridDBBandedColumn
        Caption = '% CBS'
        DataBinding.FieldName = 'ITE_ALQCBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxbItensVALCBS: TcxGridDBBandedColumn
        Caption = 'VR.CBS'
        DataBinding.FieldName = 'ITE_VALCBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxbItensALQIBS: TcxGridDBBandedColumn
        Caption = '% IBS'
        DataBinding.FieldName = 'ITE_ALQIBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxbItensVALIBS: TcxGridDBBandedColumn
        Caption = 'VR.IBS'
        DataBinding.FieldName = 'ITE_VALIBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxbItensALQ_IS: TcxGridDBBandedColumn
        Caption = '% IS'
        DataBinding.FieldName = 'ITE_ALQ_IS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxbItensVAL_IS: TcxGridDBBandedColumn
        Caption = 'VR.IS'
        DataBinding.FieldName = 'ITE_VAL_IS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxcItensColumn9: TcxGridDBBandedColumn
        Caption = '% PIS'
        DataBinding.FieldName = 'ITE_ALQPIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxcItensColumn10: TcxGridDBBandedColumn
        Caption = 'VR. PIS'
        DataBinding.FieldName = 'ITE_VALPIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxcItensColumn11: TcxGridDBBandedColumn
        Caption = '% COFINS'
        DataBinding.FieldName = 'ITE_ALQCOF'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxcItensColumn12: TcxGridDBBandedColumn
        Caption = 'VR. CONFINS'
        DataBinding.FieldName = 'ITE_VALCOF'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxcItensColumn13: TcxGridDBBandedColumn
        Caption = 'VR.SISCOMEX'
        DataBinding.FieldName = 'ITE_VALSIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxcItensColumn14: TcxGridDBBandedColumn
        Caption = ' VR.AFRMM'
        DataBinding.FieldName = 'ITE_VALMAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxcItensColumn15: TcxGridDBBandedColumn
        Caption = ' % ICMS'
        DataBinding.FieldName = 'ITE_ALQICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnEditValueChanged = cxcItensColumn15PropertiesEditValueChanged
        Properties.OnValidate = cxcItensColumn15PropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxbItenPerBas: TcxGridDBBandedColumn
        Caption = '% Bas. ICMS'
        DataBinding.FieldName = 'ITE_PERBAS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        Properties.MaxValue = 100.000000000000000000
        Properties.OnEditValueChanged = cxbItenPerBasPropertiesEditValueChanged
        Properties.OnValidate = cxbItenPerBasPropertiesValidate
        Position.BandIndex = 1
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxcItensColumn16: TcxGridDBBandedColumn
        Caption = 'BC ICMS'
        DataBinding.FieldName = 'ITE_BASICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxcItensColumn17: TcxGridDBBandedColumn
        Caption = 'VR. ICMS'
        DataBinding.FieldName = 'ITE_VALICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
    end
    object cxlGrid1Level1: TcxGridLevel
      GridView = cxbItens
    end
  end
  inherited pnlStatus: TPanel
    Top = 581
    Width = 1359
    ExplicitTop = 581
    ExplicitWidth = 1359
    inherited pnlNomeForm: TPanel
      Left = 1188
      ExplicitLeft = 1188
    end
    inherited pnlInfo: TPanel
      Width = 1188
      ExplicitWidth = 1188
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 824
    Top = 352
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object dtsItens: TDataSource
    Left = 968
    Top = 352
  end
end
