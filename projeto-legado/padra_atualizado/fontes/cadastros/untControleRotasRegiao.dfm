inherited frmControleRotasRegiao: TfrmControleRotasRegiao
  Width = 800
  Height = 550
  Caption = 'Controle de Rotas por regi'#227'o'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 451
    Width = 794
    Height = 54
    TabOrder = 1
    TabStop = True
    ExplicitTop = 451
    ExplicitWidth = 794
    ExplicitHeight = 54
    inherited FlwBotoes: TFlowPanel
      Top = 30
      Width = 713
      Height = 22
      TabStop = True
      ExplicitTop = 30
      ExplicitWidth = 713
      ExplicitHeight = 22
      object btnInsRota: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 181
        Height = 22
        Caption = '[ Insert ] Inserir uma nova Rota'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnInsRotaClick
      end
      object btnMudaOrdem: TBitBtnLocked
        Left = 181
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F3 ] Muda Ordem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnMudaOrdemClick
      end
      object btnPesquisar: TBitBtnLocked
        Left = 297
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F5 ] &Pesquisar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnPesquisarClick
      end
      object btnGeraAuto: TBitBtnLocked
        Left = 413
        Top = 0
        Width = 158
        Height = 22
        Caption = '[ F10 ] Gera'#231#227'o Autom'#225'tica'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btnGeraAutoClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 571
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F9 ] Imprimir as Rotas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnRelatorioClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      Top = 30
      Align = alRight
      ExplicitLeft = 715
      ExplicitTop = 30
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 790
      Height = 28
      Align = alTop
      ShowCaption = False
      TabOrder = 2
      object Shape1: TShape
        Left = 21
        Top = 5
        Width = 27
        Height = 16
        Brush.Color = clGreen
        Pen.Color = clWhite
      end
      object Label8: TLabel
        Left = 52
        Top = 7
        Width = 58
        Height = 14
        Caption = 'Em Aberto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape2: TShape
        Left = 128
        Top = 5
        Width = 27
        Height = 16
        Brush.Color = clRed
        Pen.Color = clWhite
      end
      object Label3: TLabel
        Left = 161
        Top = 7
        Width = 48
        Height = 14
        Caption = 'Baixadas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 483
        Top = 6
        Width = 112
        Height = 14
        Caption = '[ F6 ] - Alterar Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 619
        Top = 6
        Width = 145
        Height = 14
        Caption = '[ F4 ] - Alterar Data Entrega'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 451
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    TabStop = True
    object pnlFiltro: TPanel
      Left = 1
      Top = 1
      Width = 792
      Height = 59
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      TabStop = True
      object grbFiltros: TGroupBox
        Left = 1
        Top = 1
        Width = 790
        Height = 57
        Align = alClient
        Caption = 'Filtros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
        object Label6: TLabel
          Left = 10
          Top = 25
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Per'#237'odo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 138
          Top = 25
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 245
          Top = 25
          Width = 38
          Height = 14
          Alignment = taRightJustify
          Caption = 'Status:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 414
          Top = 25
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 64
          Top = 17
          Width = 70
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 151
          Top = 17
          Width = 72
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object cbStatus: TComboBoxFocus
          Left = 289
          Top = 17
          Width = 110
          Height = 22
          Style = csOwnerDrawFixed
          ItemIndex = 0
          TabOrder = 2
          Text = 'TODOS'
          Items.Strings = (
            'TODOS'
            'ABERTO'
            'BAIXADO')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 464
          Top = 18
          Width = 44
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 3
          OnKeyPress = edtCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesReg: TEditFocus
          Left = 509
          Top = 18
          Width = 228
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
      end
    end
    object pnlRotas: TPanel
      Left = 1
      Top = 105
      Width = 792
      Height = 345
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object dbgRotas: TDBGridCitel
        Left = 1
        Top = 1
        Width = 790
        Height = 343
        TabStop = False
        Align = alClient
        DataSource = dtsConsulta
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgRotasDrawColumnCell
        OnKeyDown = dbgRotasKeyDown
        OnTitleClick = dbgRotasTitleClick
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'ENT_CODIGO'
            Title.Caption = 'Seq. Rota'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ENT_DTAENT'
            Title.Caption = 'Data Entrega'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENT_CODREG'
            Title.Caption = 'C'#243'd. Regi'#227'o'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'REG_DESREG'
            Title.Caption = 'Regi'#227'o'
            Width = 187
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENT_STATUS'
            Title.Caption = 'Status'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VEICULO'
            Title.Caption = 'Ve'#237'culo'
            Width = 260
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VEI_CAPCAR'
            Title.Caption = 'Capacidade'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'FGO_PESBRU'
            Title.Alignment = taRightJustify
            Title.Caption = 'Peso Pedidos'
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DISPON'
            Title.Caption = 'Disponibilidade'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ROT_VLRMIN'
            Title.Caption = 'Vlr.M'#237'n.Carga'
            Width = 70
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'FGO_VLRCON'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Pedidos'
            Width = 74
            Visible = True
          end>
      end
    end
    object pnlPesquisa: TPanel
      Left = 1
      Top = 60
      Width = 792
      Height = 45
      Align = alTop
      TabOrder = 2
      Visible = False
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 790
        Height = 43
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblPesquisa: TLabel
          Left = 8
          Top = 13
          Width = 70
          Height = 14
          Caption = '&Pesquisar por '
        end
        object lblNomeCampo: TLabel
          Left = 80
          Top = 13
          Width = 73
          Height = 14
          Caption = 'DET_MMMMMM'
        end
        object edtData: TMaskEditFocus
          Left = 160
          Top = 9
          Width = 73
          Height = 22
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtNumero: TEditFocus
          Left = 232
          Top = 9
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 1
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtString: TEditFocus
          Left = 304
          Top = 9
          Width = 329
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValor: TEditFocus
          Tag = 99
          Left = 632
          Top = 9
          Width = 77
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
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,####0.0000'
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 794
    TabOrder = 2
    ExplicitTop = 505
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 32
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 640
    Top = 144
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 608
    Top = 144
  end
  object dspConsulta: TUniDataSetProvider
    Options = []
    Left = 576
    Top = 144
  end
end
