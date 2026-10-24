inherited frmConsultaQualP: TfrmConsultaQualP
  Width = 661
  Height = 477
  Caption = 'Consulta de Valores de Frete na QUALP'
  Position = poScreenCenter
  ExplicitWidth = 661
  ExplicitHeight = 477
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 432
    Width = 655
    TabOrder = 3
    ExplicitTop = 432
    ExplicitWidth = 655
    inherited FlwBotoes: TFlowPanel
      Width = 651
      ExplicitWidth = 651
    end
  end
  inherited pnlStatus: TPanel
    Top = 432
    Width = 655
    TabOrder = 2
    ExplicitTop = 432
    ExplicitWidth = 655
    inherited pnlNomeForm: TPanel
      Left = 484
      ExplicitLeft = 484
    end
    inherited pnlInfo: TPanel
      Width = 484
      ExplicitWidth = 484
    end
  end
  inherited pgcDados: TPageControl
    Width = 655
    Height = 432
    TabOrder = 1
    ExplicitWidth = 655
    ExplicitHeight = 432
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 647
      ExplicitHeight = 400
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 655
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlInformacoesQualP: TPanel
      Left = 0
      Top = 0
      Width = 655
      Height = 89
      Align = alTop
      TabOrder = 0
      object lbl16: TLabel
        Left = 5
        Top = 3
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Placa Ve'#237'culo'
      end
      object lbl19: TLabel
        Left = 79
        Top = 3
        Width = 102
        Height = 14
        Caption = 'Descri'#231#227'o do Ve'#237'culo'
      end
      object Label1: TLabel
        Left = 147
        Top = 48
        Width = 74
        Height = 14
        Caption = 'Dura'#231#227'o trajeto'
      end
      object Label2: TLabel
        Left = 68
        Top = 48
        Width = 70
        Height = 14
        Caption = 'Dist'#226'ncia (Km)'
      end
      object Label3: TLabel
        Left = 311
        Top = 48
        Width = 89
        Height = 14
        Caption = 'Custo Combust'#237'vel'
      end
      object Label5: TLabel
        Left = 504
        Top = 18
        Width = 128
        Height = 22
        Caption = 'Total do Frete'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 5
        Top = 48
        Width = 52
        Height = 14
        Caption = 'Qtde Eixos'
      end
      object Label8: TLabel
        Left = 227
        Top = 48
        Width = 75
        Height = 14
        Caption = 'Custo Ped'#225'gios'
      end
      object Label9: TLabel
        Left = 409
        Top = 48
        Width = 91
        Height = 14
        Caption = 'Acr'#233'sc.Frete.Ve'#237'c.'
      end
      object mskPlaVei: TMaskEditFocus
        Tag = 99
        Left = 1
        Top = 20
        Width = 72
        Height = 22
        AutoSelect = False
        AutoSize = False
        CharCase = ecUpperCase
        EditMask = 'aaa-9a99;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = ''
        OnChange = mskPlaVeiChange
        OnExit = mskPlaVeiExit
        OnKeyPress = mskPlaVeiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesVei: TEditFocus
        Left = 79
        Top = 18
        Width = 422
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtTempoEstimadoDuracao: TEditFocus
        Left = 147
        Top = 63
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taCenter
        Color = 16768952
        Enabled = False
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
      object edtDistancia: TEditFocus
        Left = 68
        Top = 63
        Width = 76
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtCustoCombustivel: TEditFocus
        Left = 308
        Top = 63
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotalFrete: TEditFocus
        Left = 504
        Top = 55
        Width = 143
        Height = 30
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
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
      object edtQuantidadeEixos: TEditFocus
        Left = 5
        Top = 63
        Width = 60
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtCustoPedagio: TEditFocus
        Left = 227
        Top = 63
        Width = 78
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtAcrescimoVeiculo: TEditFocus
        Left = 406
        Top = 63
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    object grdQualP: TcxGridCitel
      Left = 0
      Top = 137
      Width = 655
      Height = 265
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdQualPDBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsQualP
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdQualPDBTableViewCitel1Column1: TcxGridDBColumn
          Caption = 'Tipo de Carga'
          DataBinding.FieldName = 'TIPO_CARGA'
          Options.Editing = False
          Width = 357
        end
        object grdQualPDBTableViewCitel1Column2: TcxGridDBColumn
          Caption = 'Tabela'
          DataBinding.FieldName = 'TABELA'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 70
        end
        object grdQualPDBTableViewCitel1Column3: TcxGridDBColumn
          Caption = 'Valor Frete'
          DataBinding.FieldName = 'VALOR'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 83
        end
      end
      object grdQualPLevel1: TcxGridLevel
        GridView = grdQualPDBTableViewCitel1
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 402
      Width = 655
      Height = 30
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      object BitBtnLocked2: TBitBtnLocked
        Left = 653
        Top = 2
        Width = 0
        Height = 26
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
        TabOrder = 0
        OnClick = btnSairClick
      end
      object btnOk: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 80
        Height = 26
        Align = alLeft
        Caption = 'Selecionar'
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
        TabOrder = 1
      end
    end
    object pnlLinkTabela: TPanel
      Left = 0
      Top = 89
      Width = 655
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label4: TLabel
        Left = 5
        Top = 6
        Width = 57
        Height = 14
        Caption = 'Link QUALP'
      end
      object Label7: TLabel
        Left = 351
        Top = 6
        Width = 74
        Height = 14
        Caption = 'Tabela de Frete'
      end
      object edtLinkQualP: TEditFocus
        Left = 5
        Top = 21
        Width = 343
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object cmbTabelaFrete: TComboBoxFocus
        Left = 351
        Top = 21
        Width = 258
        Height = 22
        Style = csDropDownList
        TabOrder = 1
        OnSelect = cmbTabelaFreteSelect
        Items.Strings = (
          'A'
          'B'
          'C'
          'D')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 168
  end
  object dtsQualP: TDataSource
    AutoEdit = False
    OnDataChange = dtsQualPDataChange
    Left = 23
    Top = 238
  end
end
