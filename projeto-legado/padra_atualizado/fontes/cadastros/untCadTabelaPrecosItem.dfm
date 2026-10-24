inherited frmCadTabelaPrecosItem: TfrmCadTabelaPrecosItem
  Width = 1066
  Height = 768
  BorderStyle = bsSizeable
  Caption = 'Tabela de Pre'#231'o do Fornecedor'
  WindowState = wsMaximized
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1066
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 687
    Width = 1050
    TabOrder = 1
    ExplicitTop = 687
    ExplicitWidth = 1050
    inherited FlwBotoes: TFlowPanel
      Width = 969
      ExplicitWidth = 969
      inherited btnConfirma: TBitBtnLocked
        Width = 139
        ExplicitWidth = 139
      end
      object btnExcluiItem: TBitBtnLocked
        Left = 139
        Top = 0
        Width = 138
        Height = 22
        Caption = '&Exclui item'
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
        Visible = False
        OnClick = btnExcluiItemClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 971
      Top = 2
      Align = alRight
      ExplicitLeft = 971
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1050
    TabOrder = 2
    ExplicitTop = 713
    ExplicitWidth = 1050
    inherited pnlNomeForm: TPanel
      Left = 879
      ExplicitLeft = 879
    end
    inherited pnlInfo: TPanel
      Width = 879
      ExplicitWidth = 879
    end
  end
  object pgcItens: TPageControl [2]
    Left = 0
    Top = 20
    Width = 1050
    Height = 667
    ActivePage = tbsAltGlobal
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = pgcItensChange
    object tbsFiltros: TTabSheet
      Caption = '&Filtro para inclus'#227'o dos itens'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFiltros: TPanel
        Left = 0
        Top = 0
        Width = 1042
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Label2: TLabel
          Left = 47
          Top = 30
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object Label3: TLabel
          Left = 43
          Top = 52
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
        end
        object Label4: TLabel
          Left = 459
          Top = 52
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Label5: TLabel
          Left = 31
          Top = 8
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
        end
        object Label6: TLabel
          Left = 66
          Top = 74
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object Label9: TLabel
          Left = 40
          Top = 96
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object edtRefere: TEditFocus
          Tag = 99
          Left = 101
          Top = 48
          Width = 351
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 101
          Top = 26
          Width = 439
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 504
          Top = 48
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 101
          Top = 4
          Width = 48
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 0
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGru: TEditFocus
          Left = 150
          Top = 4
          Width = 390
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
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 101
          Top = 70
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 170
          Top = 70
          Width = 370
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 101
          Top = 92
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 5
          OnEnter = edtCodForEnter
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomFor: TEditFocus
          Left = 170
          Top = 92
          Width = 370
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
      object cxgItens: TcxGrid
        Left = 0
        Top = 129
        Width = 1042
        Height = 506
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsIteSel
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxgItensCodIte
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxgItensCodIte: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ITE_CODITE'
            SortIndex = 0
            SortOrder = soAscending
            Width = 76
          end
          object cxgItensViewColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Item'
            DataBinding.FieldName = 'ITE_DESITE'
            Width = 271
          end
          object cxgItensViewColumn3: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNI_SIGUNI'
            Width = 49
          end
          object cxgItensViewColumn4: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'ITE_REFERE'
            Width = 126
          end
          object cxgItensViewColumn5: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'ITE_CODFOR'
            Width = 78
          end
          object cxgItensViewColumn6: TcxGridDBColumn
            Caption = 'Nome do fornecedor'
            DataBinding.FieldName = 'FOR_NOMFOR'
            Width = 151
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxgItensView
        end
      end
    end
    object tbsDados: TTabSheet
      Caption = '&Informa'#231#245'es do Item'
      DoubleBuffered = False
      ImageIndex = 1
      ParentDoubleBuffered = False
      OnShow = tbsDadosShow
      object pnlDados1: TPanel
        Left = 0
        Top = 28
        Width = 1042
        Height = 190
        Align = alTop
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 1
        object Label8: TLabel
          Left = 50
          Top = 75
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo de F'#225'brica:'
        end
        object Label1: TLabel
          Left = 19
          Top = 98
          Width = 121
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o do Fabricante:'
        end
        object Label49: TLabel
          Left = 13
          Top = 122
          Width = 127
          Height = 14
          Alignment = taRightJustify
          Caption = 'NCM / Classifica'#231#227'o de IPI:'
        end
        object Label32: TLabel
          Left = 583
          Top = 29
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'Abrevia'#231#227'o Fiscal:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label118: TLabel
          Left = 359
          Top = 6
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'M'#250'ltiplo para Compra:'
        end
        object lblUniCom: TLabel
          Left = 576
          Top = 6
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade de Compra:'
        end
        object Label147: TLabel
          Left = 71
          Top = 145
          Width = 163
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dias para entrega do Fornecedor:'
        end
        object Label48: TLabel
          Left = 84
          Top = 6
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
        end
        object Label50: TLabel
          Left = 7
          Top = 29
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. de Barras Embalagem:'
        end
        object shpRefere: TShape
          Left = 341
          Top = 4
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object Label55: TLabel
          Left = 581
          Top = 52
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Abrevia'#231#227'o de PIS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpAbfPis: TShape
          Left = 740
          Top = 50
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object Label56: TLabel
          Left = 435
          Top = 52
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Peso:'
        end
        object shpPesoIt: TShape
          Left = 529
          Top = 50
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object shpCodAbf: TShape
          Left = 740
          Top = 27
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object Label52: TLabel
          Left = 586
          Top = 75
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Abrevia'#231#227'o de IPI:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label54: TLabel
          Left = 559
          Top = 98
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Abrevia'#231#227'o de COFINS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpAbfCof: TShape
          Left = 740
          Top = 96
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object shpClaIpi: TShape
          Left = 300
          Top = 119
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object shpMltCom: TShape
          Left = 529
          Top = 4
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object shpCodFab: TShape
          Left = 341
          Top = 73
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object Label51: TLabel
          Left = 355
          Top = 29
          Width = 107
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quant. na Embalagem:'
        end
        object lbl1: TLabel
          Left = 53
          Top = 52
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo de Barras:'
        end
        object lbl14: TLabel
          Left = 420
          Top = 75
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Divis'#237'vel:'
        end
        object shpNotEsp: TShape
          Left = 495
          Top = 73
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object ColorLabel15: TColorLabel
          Left = 505
          Top = 76
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object shpCobBar: TShape
          Left = 341
          Top = 49
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object shpUniCom: TShape
          Left = 740
          Top = 4
          Width = 7
          Height = 20
          Brush.Color = clGreen
        end
        object lbl50: TLabel
          Left = 319
          Top = 122
          Width = 143
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo EX IPI (Exce'#231#227'o NCM):'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 579
          Top = 145
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Produtos:'
        end
        object dbeCodFab: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 72
          Width = 196
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODFAB'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDesFab: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 95
          Width = 409
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESFAB'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeClaIpi: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 118
          Width = 155
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CLAIPI'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          OnKeyPress = dbeClaIpiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodAbr: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 26
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODABF'
          DataSource = dtsTabDet
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          OnKeyPress = dbeCodAbrKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodAbrChamaCadastro
        end
        object edtDesAbf: TEditFocus
          Left = 747
          Top = 26
          Width = 279
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 18
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeMultCompra: TDBEditFocus
          Tag = 99
          Left = 465
          Top = 3
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MLTCOM'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeUniCom: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 3
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_UNICOM'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 12
          OnKeyPress = dbeUniComKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesUniCom: TEditFocus
          Left = 747
          Top = 3
          Width = 279
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 19
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeDiaFor: TDBEditFocus
          Tag = 99
          Left = 236
          Top = 141
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DIAFOR'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeRefere: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 3
          Width = 196
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_REFERE'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBarEmb: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 26
          Width = 196
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_BAREMB'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAbfPis: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 49
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ABFPIS'
          DataSource = dtsTabDet
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          OnKeyPress = dbeAbfPisKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesPis: TEditFocus
          Left = 747
          Top = 49
          Width = 279
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 20
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbePesoIt: TDBEditFocus
          Tag = 99
          Left = 465
          Top = 49
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_PESOIT'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAbfIpi: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 72
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ABFIPI'
          DataSource = dtsTabDet
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          OnKeyPress = dbeAbfIpiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesIpi: TEditFocus
          Left = 747
          Top = 72
          Width = 279
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 21
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeAbfCof: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 95
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ABFCOF'
          DataSource = dtsTabDet
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          OnKeyPress = dbeAbfCofKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesCof: TEditFocus
          Left = 747
          Top = 95
          Width = 279
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 22
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeEmbala: TDBEditFocus
          Tag = 99
          Left = 465
          Top = 26
          Width = 107
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_EMBALA'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodBar: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 49
          Width = 196
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_CODBAR'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNotEsp: TDBEditFocus
          Tag = 99
          Left = 465
          Top = 72
          Width = 29
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_NOTESP'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object pnlSitPro: TPanel
          Left = 569
          Top = 118
          Width = 518
          Height = 25
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 17
          object lblSitPro: TLabel
            Left = 4
            Top = 3
            Width = 100
            Height = 14
            Alignment = taRightJustify
            Caption = 'Situa'#231#227'o do Produto:'
          end
          object shpSitPro: TShape
            Left = 171
            Top = 1
            Width = 7
            Height = 20
            Brush.Color = clGreen
          end
          object dbeSitPro: TDBEditFocus
            Tag = 99
            Left = 107
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TFO_SITPRO'
            DataSource = dtsItens
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeSitProKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttNumerico
          end
          object edtSitPro: TEditFocus
            Left = 179
            Top = 0
            Width = 278
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
        end
        object dbeExcIpi: TDBEditFocus
          Tag = 99
          Left = 465
          Top = 118
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_EXCIPI'
          DataSource = dtsTabDet
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          OnExit = dbeExcIpiExit
          OnKeyPress = dbeExcIpiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeGruPro: TDBEditFocus
          Tag = 99
          Left = 676
          Top = 141
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TFO_PRDGRU'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 23
          OnKeyPress = dbeGruProKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesGrp: TEditFocus
          Left = 748
          Top = 141
          Width = 278
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 24
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object pnlLegendaComuns: TPanel
          Left = 1
          Top = 164
          Width = 1040
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'pnlLegendaComuns'
          ShowCaption = False
          TabOrder = 25
          object Shape3: TShape
            Left = 7
            Top = 0
            Width = 12
            Height = 12
            Brush.Color = clGreen
          end
          object Label11: TLabel
            Left = 23
            Top = 0
            Width = 985
            Height = 15
            AutoSize = False
            Caption = 
              'Indica os Campos que s'#227'o coletivos. Os Campos Coletivos s'#227'o camp' +
              'os compartilhados para todas as tabelas de pre'#231'o cadastradas par' +
              'a o Item e Fornecedor Atual.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object shp1: TShape
            Left = 7
            Top = 13
            Width = 12
            Height = 12
            Brush.Color = clBlue
          end
          object lbl7: TLabel
            Left = 23
            Top = 13
            Width = 483
            Height = 14
            AutoSize = False
            Caption = 
              'Os campos com nome em azul possuem valores informados por empres' +
              'a.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
        end
      end
      object pnlDados2: TPanel
        Left = 0
        Top = 218
        Width = 1042
        Height = 417
        Align = alClient
        BevelOuter = bvLowered
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object pnlPrecos: TPanel
          Left = 1
          Top = 35
          Width = 1040
          Height = 381
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object pnlPrecom: TPanel
            Left = 1
            Top = 1
            Width = 506
            Height = 379
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'pnlPrecom'
            ShowCaption = False
            TabOrder = 0
            object Label13: TLabel
              Left = 34
              Top = 12
              Width = 82
              Height = 14
              Alignment = taRightJustify
              Caption = 'Pre'#231'o Compra:'
              Color = 16770261
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'charter'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
            object Label14: TLabel
              Left = 37
              Top = 34
              Width = 79
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto 01 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 213
              Top = 34
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label15: TLabel
              Left = 86
              Top = 56
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = '02 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label34: TLabel
              Left = 213
              Top = 56
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label16: TLabel
              Left = 86
              Top = 78
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = '03 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label35: TLabel
              Left = 213
              Top = 78
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label17: TLabel
              Left = 86
              Top = 100
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = '04 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 213
              Top = 100
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label18: TLabel
              Left = 86
              Top = 122
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = '05 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label37: TLabel
              Left = 213
              Top = 122
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label19: TLabel
              Left = 86
              Top = 144
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = '06 (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label38: TLabel
              Left = 213
              Top = 144
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label137: TLabel
              Left = 4
              Top = 166
              Width = 112
              Height = 14
              Alignment = taRightJustify
              Caption = 'Pre'#231'o Compra L'#237'qu.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label20: TLabel
              Left = 310
              Top = 12
              Width = 82
              Height = 14
              Alignment = taRightJustify
              Caption = 'ICMS Entrada (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label39: TLabel
              Left = 488
              Top = 12
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label135: TLabel
              Left = 286
              Top = 34
              Width = 106
              Height = 14
              Alignment = taRightJustify
              Caption = 'Impostos Federais (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label136: TLabel
              Left = 488
              Top = 34
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label21: TLabel
              Left = 322
              Top = 56
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'IPI Entrada (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label40: TLabel
              Left = 488
              Top = 56
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label22: TLabel
              Left = 344
              Top = 79
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Frete (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label41: TLabel
              Left = 488
              Top = 78
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object lblValFre: TLabel
              Left = 319
              Top = 100
              Width = 73
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor Frete (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 288
              Top = 122
              Width = 104
              Height = 14
              Alignment = taRightJustify
              Caption = 'Acr'#233'scimo Finan. (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label42: TLabel
              Left = 488
              Top = 122
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label24: TLabel
              Left = 302
              Top = 145
              Width = 90
              Height = 14
              Alignment = taRightJustify
              Caption = 'Sub. Tribut'#225'ria (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label43: TLabel
              Left = 488
              Top = 145
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object lblDesAdi: TLabel
              Left = 227
              Top = 167
              Width = 165
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descontos Adicionais (Boleto) (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label133: TLabel
              Left = 488
              Top = 167
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbePreCom: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 8
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_PRECOM'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf01: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 30
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF01'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf02: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 52
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF02'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf03: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 74
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF03'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf04: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 96
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF04'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf05: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 118
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF05'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesf06: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 140
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESF06'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeIcmEnt: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 8
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ICMENT'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeSubFed: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 30
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_SUBFED'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeIpiEnt: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 52
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_IPIENT'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeFreEnt: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 74
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_FREENT'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 11
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeValFre: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 96
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_VALFRE'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 12
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeSubsti: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 140
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_SUBSTI'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 14
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesAdb: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 162
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESADB'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 15
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeAcrFin: TDBEditFocus
              Tag = 99
              Left = 395
              Top = 118
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ACRFIN'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 13
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object chkPreDol: TDBCheckBox
              Left = 218
              Top = 11
              Width = 70
              Height = 17
              Caption = 'Em d'#243'lar'
              Ctl3D = True
              DataField = 'ITE_PREDOL'
              DataSource = dtsTabDet
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnClick = chkPreDolClick
            end
            object dbeComLiq: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 162
              Width = 92
              Height = 22
              TabStop = False
              CharCase = ecUpperCase
              DataField = 'ITE_COMLIQ'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 16
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlSuframa: TPanel
            Left = 507
            Top = 1
            Width = 233
            Height = 379
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object Label221: TLabel
              Left = 83
              Top = 11
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'TCIF (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label222: TLabel
              Left = 91
              Top = 35
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'TS (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label223: TLabel
              Left = 2
              Top = 55
              Width = 122
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto PIS/COFINS (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label224: TLabel
              Left = 33
              Top = 79
              Width = 91
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto ICMS (-):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label225: TLabel
              Left = 35
              Top = 99
              Width = 89
              Height = 14
              Alignment = taRightJustify
              Caption = 'Fator Regional (+):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label227: TLabel
              Left = 219
              Top = 11
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label228: TLabel
              Left = 219
              Top = 33
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label229: TLabel
              Left = 219
              Top = 55
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label230: TLabel
              Left = 219
              Top = 79
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label231: TLabel
              Left = 219
              Top = 101
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbeTCIFCu: TDBEditFocus
              Tag = 99
              Left = 126
              Top = 8
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TCIFCU'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeTSCust: TDBEditFocus
              Tag = 99
              Left = 126
              Top = 30
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TSCUST'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeDePiCo: TDBEditFocus
              Tag = 99
              Left = 126
              Top = 52
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DEPICO'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeDeICMS: TDBEditFocus
              Tag = 99
              Left = 126
              Top = 74
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DEICMS'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeFatReg: TDBEditFocus
              Tag = 99
              Left = 126
              Top = 96
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_FATREG'
              DataSource = dtsTabDet
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
          object pnlPrecoCusto: TPanel
            Left = 740
            Top = 1
            Width = 248
            Height = 379
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object Panel1: TPanel
              Left = 0
              Top = 0
              Width = 248
              Height = 138
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Panel1'
              ParentColor = True
              ShowCaption = False
              TabOrder = 0
              object Label26: TLabel
                Left = 52
                Top = 8
                Width = 88
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o de Custo:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object lblOutVal: TLabel
                Left = 47
                Top = 30
                Width = 93
                Height = 14
                Alignment = taRightJustify
                Caption = 'Outros Valores (+):'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label25: TLabel
                Left = 66
                Top = 52
                Width = 74
                Height = 14
                Alignment = taRightJustify
                Caption = 'ICMS Sa'#237'da (+):'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label28: TLabel
                Left = 32
                Top = 74
                Width = 108
                Height = 14
                Alignment = taRightJustify
                Caption = 'Impostos Federais (+):'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label66: TLabel
                Left = 4
                Top = 96
                Width = 136
                Height = 14
                Alignment = taRightJustify
                Caption = 'Despesas Operacionais (+):'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label138: TLabel
                Left = 26
                Top = 119
                Width = 114
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o de Custo Real:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label44: TLabel
                Left = 238
                Top = 56
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
              end
              object lblDesOpePer: TLabel
                Left = 238
                Top = 78
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
              end
              object Label29: TLabel
                Left = 238
                Top = 100
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
              end
              object dbeOutVal: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 28
                Width = 92
                Height = 22
                CharCase = ecUpperCase
                DataField = 'ITE_OUTVAL'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeIcmSai: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 50
                Width = 92
                Height = 22
                CharCase = ecUpperCase
                DataField = 'ITE_ICMSAI'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 1
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeImpFed: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 72
                Width = 92
                Height = 22
                CharCase = ecUpperCase
                DataField = 'ITE_IMPFED'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 2
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeDesOpe: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 94
                Width = 92
                Height = 22
                CharCase = ecUpperCase
                DataField = 'ITE_DESOPE'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 3
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeCusRea: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 116
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                DataField = 'ITE_CUSREA'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreCus: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 6
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                DataField = 'ITE_PRECUS'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ReadOnly = True
                TabOrder = 5
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPrecoVenda: TPanel
              Left = 0
              Top = 138
              Width = 248
              Height = 113
              Align = alTop
              BevelOuter = bvNone
              Caption = 'pnlPrecoVenda'
              ParentColor = True
              ShowCaption = False
              TabOrder = 1
              object Label12: TLabel
                Left = 91
                Top = 3
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object Label27: TLabel
                Left = 51
                Top = 47
                Width = 89
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o de Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object lblMarBr1: TLabel
                Left = 238
                Top = 3
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
              end
              object lbl3: TLabel
                Left = 43
                Top = 71
                Width = 95
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o de Revista:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object lbl5: TLabel
                Left = 25
                Top = 91
                Width = 115
                Height = 14
                Alignment = taRightJustify
                Caption = 'Desconto de Revista:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object lbl6: TLabel
                Left = 238
                Top = 91
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
              end
              object lblComTbl: TLabel
                Left = 90
                Top = 25
                Width = 50
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object dbeMarBru: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 0
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                Color = 16768952
                DataField = 'ITE_MARBRU'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVen: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 44
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                Color = 16768952
                DataField = 'ITE_PREVEN'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ReadOnly = True
                TabOrder = 1
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePREREV: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 66
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                Color = 16768952
                DataField = 'ITE_PREREV'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
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
                TipoTexto = ttAlfanumerico
              end
              object dbeDesRev: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 88
                Width = 92
                Height = 22
                TabStop = False
                CharCase = ecUpperCase
                Color = 16768952
                DataField = 'ITE_DESREV'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                ReadOnly = True
                TabOrder = 3
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeComTbl: TDBEditFocus
                Tag = 99
                Left = 144
                Top = 22
                Width = 92
                Height = 22
                CharCase = ecUpperCase
                DataField = 'ITE_COMTBL'
                DataSource = dtsTabDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentFont = False
                TabOrder = 4
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object Panel3: TPanel
              Left = 0
              Top = 251
              Width = 248
              Height = 61
              Align = alTop
              BevelOuter = bvNone
              Caption = 'pnlCncCus'
              ParentColor = True
              ShowCaption = False
              TabOrder = 2
            end
          end
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 1040
          Height = 34
          Align = alTop
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label10: TLabel
            Left = 20
            Top = 12
            Width = 213
            Height = 14
            Alignment = taRightJustify
            Caption = 'Divisor Convers'#227'o para Custo (Embalagem):'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object dbeCnvCus: TDBEditFocus
            Tag = 99
            Left = 236
            Top = 8
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CNVCUS'
            DataSource = dtsItens
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCnvCusExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object rdgAlterarTipo: TRadioGroup
            Left = 345
            Top = -1
            Width = 471
            Height = 32
            Caption = 'Alterar'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Margem de Lucro'
              'Pre'#231'o de Venda')
            TabOrder = 1
            OnClick = rdgAlterarTipoClick
          end
        end
      end
      object pnlItem: TPanel
        Left = 0
        Top = 0
        Width = 1042
        Height = 28
        Align = alTop
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        object Label7: TLabel
          Left = 70
          Top = 7
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo do Item:'
        end
        object dbeCodIte: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 3
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODITE'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodIteChamaCadastro
        end
        object dbeDesIte: TDBEditFocus
          Tag = 99
          Left = 210
          Top = 3
          Width = 550
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'ITE_DESITE'
          DataSource = dtsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsAltComuns: TTabSheet
      Caption = 'Altera'#231#227'o Global Dados Cadastrais'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 604
        Width = 1042
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnExcelComuns: TBitBtnLocked
          Left = 7
          Top = 6
          Width = 138
          Height = 22
          Caption = '[ F9 ] Exportar para Excel'
          TabOrder = 0
          OnClick = btnExcelComunsClick
        end
      end
      object cxgDadosComuns: TcxGrid
        Left = 0
        Top = 0
        Width = 1042
        Height = 604
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvDadosComuns: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para defnir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.ContentEven = cxsZebra
          Bands = <
            item
              Caption = 'Produto'
              FixedKind = fkLeft
            end
            item
              Caption = 'Dados Comuns para todas as empresas'
            end>
          object cxvDadosComunsCODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 60
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvDadosComunsDESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o do Produto'
            DataBinding.FieldName = 'ITE_DESITE'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.SortByDisplayText = isbtOn
            Width = 314
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvDadosComunsCODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'digo de F'#225'brica'
            DataBinding.FieldName = 'ITE_CODFAB'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Options.SortByDisplayText = isbtOn
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvDadosComunsREFERE: TcxGridDBBandedColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'TFO_REFERE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 126
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvDadosComunsSITPRO: TcxGridDBBandedColumn
            Caption = 'Situa'#231#227'o do Produto'
            DataBinding.FieldName = 'TFO_SITPRO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            RepositoryItem = btnPesquisaGrid
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvDadosComunsBAREMB: TcxGridDBBandedColumn
            Caption = 'C'#243'digo de Barras Embalagem'
            DataBinding.FieldName = 'TFO_BAREMB'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvDadosComunsEMBALA: TcxGridDBBandedColumn
            Caption = 'Quantidade Embalagem'
            DataBinding.FieldName = 'TFO_EMBALA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxvDadosComunsCODBAR: TcxGridDBBandedColumn
            Caption = 'C'#243'digo de Barras'
            DataBinding.FieldName = 'TFO_CODBAR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 154
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxvDadosComunsCLAIPI: TcxGridDBBandedColumn
            Caption = 'Classifica'#231#227'o de IPI'
            DataBinding.FieldName = 'ITE_CLAIPI'
            PropertiesClassName = 'TcxTextEditProperties'
            RepositoryItem = btnPesquisaGrid
            HeaderAlignmentHorz = taCenter
            Width = 98
            Position.BandIndex = 1
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxvDadosComunsPESOIT: TcxGridDBBandedColumn
            Caption = 'Peso do Item'
            DataBinding.FieldName = 'TFO_PESOIT'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxvDadosComunsDIAFOR: TcxGridDBBandedColumn
            Caption = 'Dias Entrega Fornecedor'
            DataBinding.FieldName = 'ITE_DIAFOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxvDadosComunsNOTESP: TcxGridDBBandedColumn
            Caption = 'Divis'#237'vel'
            DataBinding.FieldName = 'TFO_NOTESP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.CharCase = ecUpperCase
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxvDadosComunsUNICOM: TcxGridDBBandedColumn
            Caption = 'Unidade Compra'
            DataBinding.FieldName = 'ITE_UNICOM'
            RepositoryItem = btnPesquisaGrid
            HeaderAlignmentHorz = taCenter
            Width = 66
            Position.BandIndex = 1
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxvDadosComunsMLTCOM: TcxGridDBBandedColumn
            Caption = 'M'#250'ltiplo Compra'
            DataBinding.FieldName = 'ITE_MLTCOM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = btnPesquisaGridPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxvDadosComunsPRDGRU: TcxGridDBBandedColumn
            Caption = 'Grupo de Produtos'
            DataBinding.FieldName = 'TFO_PRDGRU'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            RepositoryItem = btnPesquisaGrid
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvDadosComunsPRINC: TcxGridDBBandedColumn
            Caption = 'Princ'
            DataBinding.FieldName = 'PRINC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 30
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxvDadosComuns
        end
      end
    end
    object tbsAltGlobal: TTabSheet
      Caption = 'Altera'#231#227'o Global Dados por Empresa'
      ImageIndex = 2
      OnShow = tbsAltGlobalShow
      object pnlTopo: TPanel
        Left = 0
        Top = 0
        Width = 1042
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbl4: TLabel
          Left = 13
          Top = 21
          Width = 45
          Height = 14
          Caption = 'Empresa:'
        end
        object cxlFiltroEmpresa: TcxLookupComboBox
          Left = 62
          Top = 18
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CODEMP'
          Properties.ListColumns = <
            item
              FieldName = 'NOMEMP'
            end>
          Properties.ListOptions.CaseInsensitive = True
          Properties.ListOptions.ShowHeader = False
          Properties.OnCloseUp = cxlFiltroEmpresaPropertiesCloseUp
          TabOrder = 0
          Width = 587
        end
      end
      object pnlHeranca: TPanel
        Left = 0
        Top = 581
        Width = 1042
        Height = 54
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lbl8: TLabel
          Left = 15
          Top = 39
          Width = 362
          Height = 14
          AutoSize = False
          Caption = 'Os campos com valores em azul s'#227'o informados por empresa.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object btnHeranca: TBitBtnLocked
          Left = 400
          Top = 11
          Width = 138
          Height = 22
          Caption = '[ F8 ] Heran'#231'a de Pre'#231'os'
          TabOrder = 3
          OnClick = btnHerancaClick
        end
        object btnMarcaTodos: TBitBtnLocked
          Left = 132
          Top = 11
          Width = 122
          Height = 22
          Caption = '[ F6 ] Marca Todos'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnMarcaTodosClick
        end
        object btnDesmarcaTodos: TBitBtnLocked
          Left = 257
          Top = 11
          Width = 141
          Height = 22
          Caption = '[ F7 ] Desmarca Todos'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 2
          OnClick = btnDesmarcaTodosClick
        end
        object btnMarDes: TBitBtnLocked
          Left = 8
          Top = 11
          Width = 122
          Height = 22
          Caption = '[ F5 ] Marca/Desmarca'
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarDesClick
        end
        object btnExcel: TBitBtnLocked
          Left = 541
          Top = 11
          Width = 138
          Height = 22
          Caption = '[ F9 ] Exportar para Excel'
          TabOrder = 4
          OnClick = btnExcelClick
        end
      end
      object cxgDadosPorEmpresa: TcxGrid
        Left = 0
        Top = 57
        Width = 1042
        Height = 507
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvDadosPorEmpresa: TcxGridDBBandedTableView
          OnKeyPress = cxvDadosPorEmpresaKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxvDadosPorEmpresaCustomDrawCell
          OnEditKeyPress = cxvDadosPorEmpresaEditKeyPress
          OnFocusedItemChanged = cxvDadosPorEmpresaFocusedItemChanged
          OnFocusedRecordChanged = cxvDadosPorEmpresaFocusedRecordChanged
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para defnir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.ContentEven = cxsZebra
          Bands = <
            item
              Caption = 'Produto'
              FixedKind = fkLeft
              Width = 660
            end
            item
              Caption = 'Custos'
            end
            item
              Caption = 'Pre'#231'o de Venda'
              FixedKind = fkRight
            end>
          object cxvDadosPorEmpresaCODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 59
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o do Produto'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'ITE_CODITE'
            Properties.ListColumns = <
              item
                FieldName = 'ITE_DESITE'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.SortByDisplayText = isbtOn
            Width = 314
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaCODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'digo de F'#225'brica'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'ITE_CODITE'
            Properties.ListColumns = <
              item
                FieldName = 'ITE_CODFAB'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.SortByDisplayText = isbtOn
            Width = 100
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaSIGUNI: TcxGridDBBandedColumn
            Caption = 'Sigla da Unidade'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'ITE_CODITE'
            Properties.ListColumns = <
              item
                FieldName = 'ITE_SIGUNI'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.SortByDisplayText = isbtOn
            Width = 46
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaPRECOM: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Compra'
            DataBinding.FieldName = 'ITE_PRECOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 80
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaICMENT: TcxGridDBBandedColumn
            Caption = 'ICMS Entrada (-)'
            DataBinding.FieldName = 'ITE_ICMENT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 49
            Position.BandIndex = 1
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaCONLIQ: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Compra L'#237'quido'
            DataBinding.FieldName = 'ITE_COMLIQ'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 80
            Position.BandIndex = 1
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF06: TcxGridDBBandedColumn
            Caption = 'Desconto 06 (-)'
            DataBinding.FieldName = 'ITE_DESF06'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF05: TcxGridDBBandedColumn
            Caption = 'Desconto 05 (-)'
            DataBinding.FieldName = 'ITE_DESF05'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF04: TcxGridDBBandedColumn
            Caption = 'Desconto 04 (-)'
            DataBinding.FieldName = 'ITE_DESF04'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF03: TcxGridDBBandedColumn
            Caption = 'Desconto 03 (-)'
            DataBinding.FieldName = 'ITE_DESF03'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF02: TcxGridDBBandedColumn
            Caption = 'Desconto 02 (-)'
            DataBinding.FieldName = 'ITE_DESF02'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESF01: TcxGridDBBandedColumn
            Caption = 'Desconto 01 (-)'
            DataBinding.FieldName = 'ITE_DESF01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaSUBFED: TcxGridDBBandedColumn
            Caption = 'Impostos Federais (-)'
            DataBinding.FieldName = 'ITE_SUBFED'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 53
            Position.BandIndex = 1
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaIPIENT: TcxGridDBBandedColumn
            Caption = 'IPI Entrada (+)'
            DataBinding.FieldName = 'ITE_IPIENT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 1
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaVALFRE: TcxGridDBBandedColumn
            Caption = 'Valor Frete (+)'
            DataBinding.FieldName = 'ITE_VALFRE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 13
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaFREENT: TcxGridDBBandedColumn
            Caption = '% Frete (+)'
            DataBinding.FieldName = 'ITE_FREENT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 48
            Position.BandIndex = 1
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaACRFIN: TcxGridDBBandedColumn
            Caption = 'Acr'#233'scimo Finan. (+)'
            DataBinding.FieldName = 'ITE_ACRFIN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 61
            Position.BandIndex = 1
            Position.ColIndex = 14
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaSUBSTI: TcxGridDBBandedColumn
            Caption = 'Sub. Tribut'#225'ria (+)'
            DataBinding.FieldName = 'ITE_SUBSTI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 55
            Position.BandIndex = 1
            Position.ColIndex = 15
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESADB: TcxGridDBBandedColumn
            Caption = 'Descontos Adicionais (Boleto) (+)'
            DataBinding.FieldName = 'ITE_DESADB'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 63
            Position.BandIndex = 1
            Position.ColIndex = 16
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaPRECUS: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Custo'
            DataBinding.FieldName = 'ITE_PRECUS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 17
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaOUTVAL: TcxGridDBBandedColumn
            Caption = 'Outros Valores (+)'
            DataBinding.FieldName = 'ITE_OUTVAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 18
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaICMSAI: TcxGridDBBandedColumn
            Caption = 'ICMS Sa'#237'da (+)'
            DataBinding.FieldName = 'ITE_ICMSAI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 52
            Position.BandIndex = 1
            Position.ColIndex = 19
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaIMPFED: TcxGridDBBandedColumn
            Caption = 'Impostos Federais (+)'
            DataBinding.FieldName = 'ITE_IMPFED'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 56
            Position.BandIndex = 1
            Position.ColIndex = 20
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESOPE: TcxGridDBBandedColumn
            Caption = 'Despesas Operacionais (+)'
            DataBinding.FieldName = 'ITE_DESOPE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 74
            Position.BandIndex = 1
            Position.ColIndex = 21
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaCUSREA: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Custo Real'
            DataBinding.FieldName = 'ITE_CUSREA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 22
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaMARBRU: TcxGridDBBandedColumn
            Caption = 'Margem'
            DataBinding.FieldName = 'ITE_MARBRU'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 46
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaCOMTBL: TcxGridDBBandedColumn
            Caption = 'Comiss'#227'o'
            DataBinding.FieldName = 'ITE_COMTBL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = cxvDadosGeraisPRECOMPropertiesValidate
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 54
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaPREVEN: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Venda'
            DataBinding.FieldName = 'ITE_PREVEN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaPREREV: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o de Revista'
            DataBinding.FieldName = 'ITE_PREREV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxsPorEmpresa
            Width = 65
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaDESREV: TcxGridDBBandedColumn
            Caption = 'Desconto de Revista'
            DataBinding.FieldName = 'ITE_DESREV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            HeaderAlignmentHorz = taCenter
            Styles.Content = cxsPorEmpresa
            Width = 58
            Position.BandIndex = 2
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaPRINC: TcxGridDBBandedColumn
            Caption = 'Princ'
            DataBinding.FieldName = 'ITE_CODITE'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.KeyFieldNames = 'ITE_CODITE'
            Properties.ListColumns = <
              item
                FieldName = 'PRINC'
              end>
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.SortByDisplayText = isbtOn
            Width = 30
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaABFICM: TcxGridDBBandedColumn
            Caption = 'Abrev. ICMS'
            DataBinding.FieldName = 'ITE_CODABF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnValidate = cxvDadosPorEmpresaABFICMPropertiesValidate
            OnGetDisplayText = cxvDadosPorEmpresaABFICMGetDisplayText
            MinWidth = 70
            Width = 105
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaColumn1: TcxGridDBBandedColumn
            Caption = 'Tabela de Pre'#231'o'
            DataBinding.FieldName = 'TABELA'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            OnCustomDrawCell = cxvDadosPorEmpresaColumn1CustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxvDadosPorEmpresaCUSATI: TcxGridDBBandedColumn
            Caption = 'Custo Ativo'
            DataBinding.FieldName = 'CUSATI'
            OnGetDisplayText = cxvDadosPorEmpresaCUSATIGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
        end
        object cxgDadosPorEmpresaLevel1: TcxGridLevel
          GridView = cxvDadosPorEmpresa
        end
      end
      object prbProgresso: TProgressBar
        Left = 0
        Top = 564
        Width = 1042
        Height = 17
        Align = alBottom
        Smooth = True
        TabOrder = 3
        Visible = False
      end
    end
    object tbsPreVen: TTabSheet
      Caption = 'Pre'#231'os de Venda relacionados'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label46: TLabel
        Left = 15
        Top = 25
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object rdgMarPre: TRadioGroup
        Left = 18
        Top = 59
        Width = 471
        Height = 46
        Caption = 'Alterar'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Margem de Lucro'
          'Pre'#231'o de Venda')
        TabOrder = 0
        OnClick = rdgMarPreClick
      end
      object cxgPreVen: TcxGrid
        Left = 18
        Top = 119
        Width = 618
        Height = 169
        TabOrder = 1
        object cxgPreVenView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
        end
        object cxvPreVen: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Bands = <
            item
            end
            item
              Caption = 'Margem de Lucro (%)'
              Width = 205
            end
            item
              Width = 98
            end
            item
              Caption = 'Pre'#231'o de Venda'
              Width = 253
            end>
          object cxvPreVenColumn1: TcxGridDBBandedColumn
            Caption = 'Tabela'
            DataBinding.FieldName = 'NROTAB'
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 60
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxcPreVenMARORI: TcxGridDBBandedColumn
            Caption = 'Atual'
            DataBinding.FieldName = 'MARORI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taCenter
            Width = 60
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxcPreVenMARBRU: TcxGridDBBandedColumn
            Caption = 'Nova'
            DataBinding.FieldName = 'MARBRU'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taCenter
            Width = 60
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvPreVenColumn5: TcxGridDBBandedColumn
            Caption = 'Comiss'#227'o (%)'
            DataBinding.FieldName = 'COMTBL'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 60
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvPreVenColumn4: TcxGridDBBandedColumn
            Caption = 'Atual'
            DataBinding.FieldName = 'PREORI'
            HeaderAlignmentHorz = taCenter
            Width = 60
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvPreVenColumn6: TcxGridDBBandedColumn
            Caption = 'Novo'
            DataBinding.FieldName = 'PREVEN'
            HeaderAlignmentHorz = taCenter
            Width = 60
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
        end
        object cxgPreVenLevel1: TcxGridLevel
          GridView = cxvPreVen
        end
      end
      object dbePreCus2: TDBEditFocus
        Tag = 99
        Left = 107
        Top = 22
        Width = 92
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'ITE_PRECUS'
        DataSource = dtsTabDet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlCaption: TPanel [3]
    Left = 0
    Top = 0
    Width = 1050
    Height = 20
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1144
    Top = 368
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 912
    Top = 168
  end
  object dtsItens: TDataSource
    Left = 760
    Top = 184
  end
  object dtsIteSel: TDataSource
    Left = 40
    Top = 328
  end
  object dtsTabDet: TDataSource
    Left = 931
    Top = 200
  end
  object cxstylesTabelasPreco: TcxStyleRepository
    Left = 600
    Top = 376
    PixelsPerInch = 96
    object cxsZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsEnfaseCusto: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsPorEmpresa: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlue
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 1168
    Top = 304
    PixelsPerInch = 96
    object btnPesquisaGrid: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00A467
            69FFA46769FFA46769FFA46769FFA46769FFA46769FFA46769FFA46769FFA467
            69FFA46769FFA46769FFA46769FFA46769FFFF00FF00FF00FF00FF00FF004853
            60FFFEE9C7FFF4DAB5FFF3D5AAFFF2D0A0FFEFCB96FFEFC68BFFEDC182FFEBC1
            7FFFEBC180FFEBC180FFF2C782FFA46769FFFF00FF00FF00FF004380B7FF1F6F
            C2FF656B86FFF3DABCFFF2D5B1FFF0D0A7FFEECB9EFFEDC793FFEDC28BFFE9BD
            81FFE9BD7FFFE9BD7FFFEFC481FFA46769FFFF00FF00FF00FF00FF00FF0032A3
            FFFF1672D7FF6B6A80FFF2DABCFFF2D5B2FFEFD0A9FFEECB9EFFEDC796FFEBC2
            8CFFE9BD82FFE9BD7FFFEFC481FFA46769FFFF00FF00FF00FF00FF00FF00A067
            5BFF34A1FFFF1572D4FF5E6782FFF3DABBFFF2D5B1FFF0D0A6FFEECB9EFFEDC7
            95FFEBC28AFFEABF81FFEFC480FFA46769FFFF00FF00FF00FF00FF00FF00A775
            6BFFFFFBF0FF33A6FFFF4078ADFF8E675EFFAC7F75FF97645EFFAC7D6FFFCAA0
            83FFEDC695FFEBC28AFFEFC583FFA46769FFFF00FF00FF00FF00FF00FF00A775
            6BFFFFFFFCFFFAF0E6FFAD8A88FFB78F84FFD8BAA5FFEED5B6FFD7B298FFB588
            77FFCBA083FFEBC793FFF2C98CFFA46769FFFF00FF00FF00FF00FF00FF00BC82
            68FFFFFFFFFFFEF7F2FFAF847FFFDAC0B4FFF7E3CFFFF6E0C5FFFFFFF4FFD7B1
            98FFAC7D6FFFEECC9EFFF3CE97FFA46769FFFF00FF00FF00FF00FF00FF00BC82
            68FFFFFFFFFFFFFEFCFF976560FFF6E9E0FFF7EADAFFF6E3CFFFFFFFEBFFEFD4
            B7FF97645EFFF0D0A6FFF6D3A0FFA46769FFFF00FF00FF00FF00FF00FF00D192
            6DFFFFFFFFFFFFFFFFFFB08884FFDECAC4FFFAEFE5FFF8EAD9FFFFFFD4FFD9B8
            A5FFAC7F74FFF4D8B1FFEBCFA4FFA46769FFFF00FF00FF00FF00FF00FF00D192
            6DFFFFFFFFFFFFFFFFFFD5BFBCFFBA9793FFDECAC4FFF6E9DEFFDAC0B4FFB78F
            84FFB28C7BFFDECEB4FFB6AA93FFA46769FFFF00FF00FF00FF00FF00FF00DA9D
            75FFFFFFFFFFFFFFFFFFFFFFFFFFD5BFBCFFB08884FF976560FFAF867FFFCAA7
            9DFFA56B5FFFA56B5FFFA56B5FFFA46769FFFF00FF00FF00FF00FF00FF00DA9D
            75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFFFEF7FFDAC1
            BAFFA56B5FFFE19E55FFE68F31FFB56D4DFFFF00FF00FF00FF00FF00FF00E7AB
            79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCC7
            C5FFA56B5FFFF8B55CFFBF7A5CFFFF00FF00FF00FF00FF00FF00FF00FF00E7AB
            79FFFBF4F0FFFBF4EFFFFAF3EFFFFAF3EFFFF8F2EFFFF7F2EFFFF7F2EFFFD8C2
            C0FFA56B5FFFC1836CFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7AB
            79FFD1926DFFD1926DFFD1926DFFD1926DFFD1926DFFD1926DFFD1926DFFD192
            6DFFA56B5FFFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 45
      Properties.OnButtonClick = btnPesquisaGridPropertiesButtonClick
      Properties.OnValidate = btnPesquisaGridPropertiesValidate
    end
  end
end
