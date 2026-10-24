inherited frmCadFin: TfrmCadFin
  Width = 596
  Height = 530
  Caption = 'Cadastro de Financeiras'
  ExplicitWidth = 596
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 460
    Width = 590
    Height = 25
    ExplicitTop = 460
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 510
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        ExplicitLeft = 83
        ExplicitWidth = 83
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        ExplicitLeft = 166
        ExplicitWidth = 83
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        ExplicitLeft = 249
        ExplicitWidth = 83
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 84
        ExplicitLeft = 332
        ExplicitWidth = 84
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 416
        Width = 83
        ExplicitLeft = 416
        ExplicitWidth = 83
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 512
      Width = 76
      Height = 21
      Align = alRight
      ExplicitLeft = 507
      ExplicitWidth = 76
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 590
    Height = 460
    ExplicitHeight = 460
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 428
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 590
    Height = 460
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 585
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 590
      Height = 126
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 585
      object Label8: TLabel
        Left = 55
        Top = 13
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 169
        Top = 13
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 57
        Top = 36
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label2: TLabel
        Left = 12
        Top = 59
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Taxa de retorno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 18
        Top = 82
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Taxa de boleto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 187
        Top = 59
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Taxa de cadastro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 312
        Top = 82
        Width = 157
        Height = 14
        Alignment = taRightJustify
        Caption = 'Recebimento da taxa de retorno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 548
        Top = 82
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = '(dias)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 360
        Top = 59
        Width = 109
        Height = 14
        Caption = 'Retorno da Financeira:'
      end
      object Label11: TLabel
        Left = 167
        Top = 59
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object dbeCodFin: TDBEditFocus
        Tag = 99
        Left = 94
        Top = 9
        Width = 70
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_CODIGO'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 222
        Top = 9
        Width = 354
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_DESCRI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodCli: TDBEditFocus
        Tag = 99
        Left = 94
        Top = 32
        Width = 70
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_CODCLI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbeTaxRet: TDBEditFocus
        Tag = 99
        Left = 94
        Top = 55
        Width = 70
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_TAXRET'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTaxBol: TDBEditFocus
        Tag = 99
        Left = 94
        Top = 78
        Width = 70
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_TAXBOL'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTaxCad: TDBEditFocus
        Tag = 99
        Left = 277
        Top = 55
        Width = 70
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_TAXCAD'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDiaRec: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 78
        Width = 72
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIN_DIAREC'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 164
        Top = 32
        Width = 412
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
      object DBCheckBox1: TDBCheckBox
        Left = 94
        Top = 104
        Width = 370
        Height = 17
        Caption = 'Informar taxas e encargos em Despesas Acess'#243'rias no Faturamento'
        DataField = 'FIN_DESACE'
        DataSource = dtsTabela
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object cmbTipRet: TComboBoxFocus
        Tag = 99
        Left = 472
        Top = 55
        Width = 72
        Height = 22
        Style = csDropDownList
        TabOrder = 5
        OnChange = cmbTipRetChange
        Items.Strings = (
          'Direto'
          'Parcelado')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlIndices: TPanel
      Left = 0
      Top = 126
      Width = 590
      Height = 334
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlIndices'
      Enabled = False
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 585
      object cxgIndFin: TcxGrid
        Left = 0
        Top = 89
        Width = 590
        Height = 245
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 585
        object cxgIndFinTab: TcxGridDBTableView
          OnKeyDown = cxgIndFinTabKeyDown
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          DataController.DataSource = dtsIndFin
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsWhite
          Styles.ContentOdd = cxsGreen
          object cxgIndFinTabQtdPar: TcxGridDBColumn
            Caption = 'Quantidade de Parcelas'
            DataBinding.FieldName = 'IND_QTDPAR'
            HeaderAlignmentHorz = taRightJustify
            Width = 127
          end
          object cxgIndFinTabIndFin: TcxGridDBColumn
            Caption = #205'ndice de Financiamento'
            DataBinding.FieldName = 'IND_INDFIN'
            PropertiesClassName = 'TcxTextEditProperties'
            HeaderAlignmentHorz = taRightJustify
            Width = 126
          end
          object cxgIndFinTabCodCar: TcxGridDBColumn
            Caption = 'Cart'#227'o'
            DataBinding.FieldName = 'IND_NOMCAR'
            Width = 304
          end
        end
        object cxgIndFinLevel1: TcxGridLevel
          GridView = cxgIndFinTab
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 590
        Height = 89
        Align = alTop
        Color = 16770261
        TabOrder = 0
        ExplicitWidth = 585
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 588
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Caption = #205'NDICES DE FINANCIAMENTO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 583
        end
        object Panel3: TPanel
          Left = 1
          Top = 24
          Width = 588
          Height = 64
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          ExplicitWidth = 583
          object Label9: TLabel
            Left = 8
            Top = 13
            Width = 118
            Height = 14
            Caption = 'Quantidade de parcelas:'
          end
          object Label10: TLabel
            Left = 211
            Top = 13
            Width = 116
            Height = 14
            Caption = #205'ndice de financiamento:'
          end
          object lblCodCar: TLabel
            Left = 92
            Top = 40
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cart'#227'o:'
          end
          object edtQtdPar: TEditFocus
            Tag = 99
            Left = 129
            Top = 9
            Width = 61
            Height = 22
            Alignment = taRightJustify
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtIndFin: TEditFocus
            Tag = 99
            Left = 330
            Top = 9
            Width = 119
            Height = 22
            Alignment = taRightJustify
            TabOrder = 1
            OnKeyPress = edtIndFinKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#0.00000000'
          end
          object edtDesCar: TEditFocus
            Left = 191
            Top = 32
            Width = 382
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object edtCodCar: TEditFocus
            Tag = 99
            Left = 129
            Top = 32
            Width = 61
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtCodCarKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 485
    Width = 590
    ExplicitTop = 485
    inherited pnlNomeForm: TPanel
      Left = 243
    end
    inherited pnlInfo: TPanel
      Width = 243
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 136
  end
  object dtsTabela: TDataSource
    Left = 448
    Top = 136
  end
  object dtsIndFin: TDataSource
    DataSet = cdsIndFin
    Left = 456
    Top = 256
  end
  object cdsIndFin: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpIndFin'
    Left = 456
    Top = 288
    object cdsIndFinAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsIndFinIND_CODFIN: TStringField
      FieldName = 'IND_CODFIN'
      Size = 5
    end
    object cdsIndFinIND_INDFIN: TFloatField
      FieldName = 'IND_INDFIN'
    end
    object cdsIndFinIND_CODCAR: TStringField
      FieldName = 'IND_CODCAR'
      Size = 5
    end
    object cdsIndFinIND_QTDPAR: TIntegerField
      FieldName = 'IND_QTDPAR'
    end
    object cdsIndFinIND_NOMCAR: TStringField
      FieldName = 'IND_NOMCAR'
      Size = 50
    end
  end
  object dspIndFin: TUniDataSetProvider
    Options = []
    Left = 456
    Top = 328
  end
  object cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    object cxsWhite: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object cxsGreen: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
