inherited frmConsultaOcorrenciasCRM: TfrmConsultaOcorrenciasCRM
  Width = 1024
  Height = 768
  Caption = 'Consulta Ocorr'#234'ncias CRM'
  DoubleBuffered = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 664
    Width = 1018
    ExplicitTop = 664
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 664
    ExplicitWidth = 1018
    ExplicitHeight = 664
    inherited tbsGeral: TTabSheet
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 632
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 664
    Align = alClient
    Color = 16770261
    DoubleBuffered = True
    ParentBackground = False
    ParentDoubleBuffered = False
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 281
      Width = 1016
      Height = 110
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      object dbgOcorrencias: TcxGridCitel
        Left = 187
        Top = 38
        Width = 744
        Height = 102
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgOcorrenciasDBTableView1: TcxGridDBTableViewCitel
          OnDblClick = dbgOcorrenciasDBTableView1DblClick
          OnKeyUp = dbgOcorrenciasDBTableView1KeyUp
          OnMouseDown = dbgOcorrenciasDBTableView1MouseDown
          Navigator.Buttons.CustomButtons = <>
          OnCanFocusRecord = dbgOcorrenciasDBTableView1CanFocusRecord
          OnCellClick = dbgOcorrenciasDBTableView1CellClick
          OnSelectionChanged = dbgOcorrenciasDBTableView1SelectionChanged
          DataController.DataSource = dtsOcorrencias
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.PullFocusing = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhuma ocorr'#234'ncia dispon'#237'vel>'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CLI_NOMCLI'
            Width = 192
          end
          object dbgOcorrenciasDBTableView1CLI_FANSOB: TcxGridDBColumn
            Caption = 'Nome Fantasia/Sobrenome'
            DataBinding.FieldName = 'CLI_FANSOB'
            Width = 149
          end
          object dbgOcorrenciasDBTableView1CLI_CONTAT: TcxGridDBColumn
            Caption = 'Contato'
            DataBinding.FieldName = 'CLI_CONTAT'
            Width = 140
          end
          object dbgOcorrenciasDBTableView1CLI_FONE01: TcxGridDBColumn
            Caption = 'Telefone'
            DataBinding.FieldName = 'CLI_FONE01'
            Width = 80
          end
          object dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn
            Caption = 'Protocolo'
            DataBinding.FieldName = 'OCO_PROTOC'
            Width = 149
          end
          object dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'GOC_CODGOC'
            Width = 45
          end
          object dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn
            Caption = 'Grupo Ocorr'#234'ncia'
            DataBinding.FieldName = 'GOC_DESGOC'
            Width = 150
          end
          object OCO_CODTOC: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'OCO_CODTOC'
            Width = 45
          end
          object dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn
            Caption = 'Tipo de Ocorr'#234'ncia'
            DataBinding.FieldName = 'TOC_DESTOC'
            Width = 169
          end
          object dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn
            Caption = 'Data Inclus'#227'o'
            DataBinding.FieldName = 'OCO_DTAINC'
            Width = 79
          end
          object dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn
            Caption = 'Hora Inclus'#227'o'
            DataBinding.FieldName = 'OCO_HORINC'
            Width = 83
          end
          object OCO_DTAAGE: TcxGridDBColumn
            Caption = 'Data Agendamento'
            DataBinding.FieldName = 'OCO_DTAAGE'
            Width = 112
          end
          object dbgOcorrenciasDBTableView1OCO_HORAGE: TcxGridDBColumn
            Caption = 'Hora Agendamento'
            DataBinding.FieldName = 'OCO_HORAGE'
            Width = 115
          end
          object dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn
            Caption = 'Data Conclus'#227'o'
            DataBinding.FieldName = 'OCO_DTACON'
            Width = 91
          end
          object dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn
            Caption = 'Hora Conclus'#227'o'
            DataBinding.FieldName = 'OCO_HORCON'
            Width = 91
          end
          object dbgOcorrenciasDBTableView1NOPEOCO: TcxGridDBColumn
            Caption = 'Operador'
            DataBinding.FieldName = 'NOPEOCO'
            Width = 157
          end
          object dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn
            Caption = 'Operador Destino'
            DataBinding.FieldName = 'OPE_NOMOPE'
            Width = 165
          end
          object OCO_CODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'OCO_CODEMP'
            Width = 57
          end
          object dbgOcorrenciasDBTableView1GER_CODADE: TcxGridDBColumn
            Caption = 'AD'
            DataBinding.FieldName = 'GER_CODADE'
          end
          object dbgOcorrenciasDBTableView1DOCUMENTO: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'DOCUMENTO'
            Width = 120
          end
          object dbgOcorrenciasDBTableView1FGO_VALORC: TcxGridDBColumn
            Caption = 'Validade or'#231'.'
            DataBinding.FieldName = 'FGO_VALORC'
            Width = 80
          end
          object dbgOcorrenciasDBTableView1FGO_VLRCON: TcxGridDBColumn
            Caption = 'Vr.Documento'
            DataBinding.FieldName = 'FGO_VLRCON'
            Width = 90
          end
          object dbgOcorrenciasDBTableView1STATUSDEPS: TcxGridDBColumn
            Caption = 'Status DEPS'
            DataBinding.FieldName = 'STATUSDEPS'
            Visible = False
          end
          object dbgOcorrenciasDBTableView1CAT_DESCRI: TcxGridDBColumn
            Caption = 'Categoria'
            DataBinding.FieldName = 'CAT_DESCRI'
            Width = 200
          end
          object dbgOcorrenciasDBTableView1CAT_CORCAT: TcxGridDBColumn
            Caption = 'Cor Categoria'
            DataBinding.FieldName = 'CAT_CORCAT'
            PropertiesClassName = 'TdxColorEditProperties'
          end
          object dbgOcorrenciasDBTableView1NLEAD: TcxGridDBColumn
            Caption = 'N'#176' Lead'
            DataBinding.FieldName = 'NLEAD'
          end
          object OCO_CODOCO: TcxGridDBColumn
            DataBinding.FieldName = 'OCO_CODOCO'
            Visible = False
          end
          object OCO_CODCLI: TcxGridDBColumn
            DataBinding.FieldName = 'OCO_CODCLI'
            Visible = False
          end
          object OCO_CODOPE: TcxGridDBColumn
            DataBinding.FieldName = 'OCO_CODOPE'
            Visible = False
          end
          object OCO_CODCOC: TcxGridDBColumn
            DataBinding.FieldName = 'OCO_CODCOC'
            Visible = False
          end
          object dbgOcorrenciasDBTableView1FGO_PREVIS: TcxGridDBColumn
            Caption = 'Data Previs'#227'o OR/PD'
            DataBinding.FieldName = 'FGO_PREVIS'
          end
          object dbgOcorrenciasDBTableViewCOMPLEMENTO: TcxGridDBColumn
            Caption = 'Compl. Ocorr'#234'ncia'
            DataBinding.FieldName = 'COMPLEMENTO'
          end
          object dbgOcorrenciasDBTableView1OCO_ASSUNT: TcxGridDBColumn
            Caption = 'Assunto'
            DataBinding.FieldName = 'OCO_ASSUNT'
          end
          object dbgOcorrenciasDBTableView1FGO_CODVEN: TcxGridDBColumn
            Caption = 'C'#243'd. Vendedor'
            DataBinding.FieldName = 'FGO_CODVEN'
          end
          object dbgOcorrenciasDBTableView1OCO_CODSIT: TcxGridDBColumn
            Caption = 'C'#243'd. Situa'#231#227'o'
            DataBinding.FieldName = 'OCO_CODSIT'
          end
          object dbgOcorrenciasDBTableView1SIT_DESSIT: TcxGridDBColumn
            Caption = 'Situa'#231#227'o'
            DataBinding.FieldName = 'SIT_DESSIT'
          end
          object dbgOcorrenciasDBTableViewTEA_DESCRI: TcxGridDBColumn
            Caption = 'Temp. Atend.'
            DataBinding.FieldName = 'TEA_DESCRI'
          end
          object dbgOcorrenciasDBTableViewTEA_CORTEA: TcxGridDBColumn
            Caption = 'Cor Temp. Atend.'
            DataBinding.FieldName = 'TEA_CORTEA'
            PropertiesClassName = 'TdxColorEditProperties'
            Options.Editing = False
          end
        end
        object dbgOcorrenciasLevel1: TcxGridLevel
          GridView = dbgOcorrenciasDBTableView1
        end
        object dbgOcorrenciasLevel2: TcxGridLevel
        end
      end
    end
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 265
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 2
      DesignSize = (
        1016
        265)
      object lblCliente: TLabel
        Left = 74
        Top = 13
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 531
        Top = 80
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Ocorr'#234'ncia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 695
        Top = 80
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object Label9: TLabel
        Left = 564
        Top = 173
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Protocolo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 503
        Top = 13
        Width = 117
        Height = 14
        Caption = 'Grupo de Ocorr'#234'ncia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 513
        Top = 34
        Width = 107
        Height = 14
        Caption = 'Tipo de Ocorr'#234'ncia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 17
        Top = 105
        Width = 99
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador Origem:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 128
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador Destino:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 834
        Top = 80
        Width = 49
        Height = 14
        Caption = 'Situa'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 827
        Top = 105
        Width = 18
        Height = 14
        Alignment = taRightJustify
        Caption = 'AD:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 62
        Top = 34
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Atividade:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label25: TLabel
        Left = 8
        Top = 57
        Width = 108
        Height = 14
        Caption = 'Grupo de Atividade:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCidade: TLabel
        Left = 75
        Top = 81
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEstado: TLabel
        Left = 423
        Top = 81
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 513
        Top = 104
        Width = 107
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Agendamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 695
        Top = 104
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object Label13: TLabel
        Left = 8
        Top = 151
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Caption = 'Depart. Op. Destino:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpLiberadoOpeDest: TShape
        Left = 120
        Top = 123
        Width = 8
        Height = 22
      end
      object shpLiberadoOpeOrig: TShape
        Left = 120
        Top = 100
        Width = 8
        Height = 22
      end
      object Label14: TLabel
        Left = 515
        Top = 57
        Width = 105
        Height = 14
        Caption = 'Compl. Ocorr'#234'ncia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCatego: TLabel
        Left = 564
        Top = 151
        Width = 56
        Height = 14
        Caption = 'Categoria:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelQua: TLabel
        Left = 48
        Top = 173
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qualifica'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 509
        Top = 128
        Width = 107
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data inclus'#227'o Fluxo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 695
        Top = 127
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object lblEntrCD: TLabel
        Left = 811
        Top = 127
        Width = 90
        Height = 14
        Caption = 'Entrega pelo CD:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object clbEntrCD: TColorLabel
        Left = 935
        Top = 127
        Width = 60
        Height = 14
        Caption = '(S)im (N)'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        CorDestaque = clRed
      end
      object Label18: TLabel
        Left = 50
        Top = 195
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 218
        Top = 195
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Esp'#233'cie:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAssunto: TLabel
        Left = 795
        Top = 173
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Assunto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 64
        Top = 242
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCorTemp: TLabel
        Left = 519
        Top = 196
        Width = 99
        Height = 14
        Caption = 'Cor Temp. Atend.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDigitador: TLabel
        Left = 21
        Top = 219
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Digitador do Doc.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 128
        Top = 8
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 0
        OnExit = edtCodCliExit
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 624
        Top = 77
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 21
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 707
        Top = 77
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 22
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtProtoc: TEditFocus
        Tag = 99
        Left = 624
        Top = 169
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 32
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtDesCli: TEditFocus
        Left = 214
        Top = 8
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 36
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodGoc: TEditFocus
        Tag = 99
        Left = 624
        Top = 8
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 18
        OnExit = edtCodGocExit
        OnKeyPress = edtCodGocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGoc: TEditFocus
        Left = 697
        Top = 8
        Width = 300
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        TabOrder = 37
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesToc: TEditFocus
        Left = 697
        Top = 31
        Width = 300
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 38
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodToc: TEditFocus
        Tag = 99
        Left = 624
        Top = 31
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 19
        OnExit = edtCodTocExit
        OnKeyPress = edtCodTocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtOpeOco: TEditFocus
        Tag = 99
        Left = 128
        Top = 100
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 4
        OnExit = edtOpeOcoExit
        OnKeyPress = edtOpeOcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 128
        Top = 123
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 7
        OnExit = edtCodOpeExit
        OnKeyPress = edtCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesOpeOco: TEditFocus
        Left = 214
        Top = 100
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDesCodOpe: TEditFocus
        Left = 214
        Top = 123
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object cbStatus: TComboBoxFocus
        Left = 887
        Top = 77
        Width = 110
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 23
        Text = 'TODAS'
        Items.Strings = (
          'TODAS'
          'EM ABERTO'
          'CONCLU'#205'DA')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtAutDev: TEditFocus
        Tag = 99
        Left = 849
        Top = 100
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 26
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object btnCarrega: TBitBtnLocked
        Left = 686
        Top = 234
        Width = 156
        Height = 26
        Caption = 'Carregar ocorr'#234'ncias'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          000A000000160000001B000000170000000B0000000200000000000000010000
          00060000000B0000000F0000000C0000000600000001000000000000000F2616
          1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
          1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
          70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
          72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
          D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
          D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
          F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
          F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
          E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
          E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
          A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
          CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
          5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
          CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
          3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
          D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
          1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
          E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
          0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
          C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
          0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
          58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
          0000000000010000000400000006000000050000000200000000000000000000
          0001000000010000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 45
        OnClick = btnCarregaClick
      end
      object edtCodAti: TEditFocus
        Tag = 99
        Left = 128
        Top = 31
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 1
        OnExit = edtCodAtiExit
        OnKeyPress = edtCodAtiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAti: TEditFocus
        Left = 214
        Top = 31
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 39
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodGat: TEditFocus
        Tag = 99
        Left = 128
        Top = 54
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodGatExit
        OnKeyPress = edtCodGatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesGat: TEditFocus
        Left = 214
        Top = 54
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 40
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomCid: TEditFocus
        Left = 214
        Top = 77
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 41
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEstado: TEditFocus
        Left = 469
        Top = 77
        Width = 25
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 42
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCid: TEditFocus
        Tag = 99
        Left = 128
        Top = 77
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 3
        OnExit = edtCodCidExit
        OnKeyPress = edtCodCidKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object mskDtaIniAg: TMaskEditFocus
        Tag = 99
        Left = 624
        Top = 100
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 24
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFinAg: TMaskEditFocus
        Tag = 99
        Left = 707
        Top = 100
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 25
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 128
        Top = 146
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 10
        OnExit = edtCodDepExit
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesDep: TEditFocus
        Left = 214
        Top = 146
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 43
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesCoc: TEditFocus
        Left = 697
        Top = 54
        Width = 300
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 46
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCoc: TEditFocus
        Tag = 99
        Left = 624
        Top = 54
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 20
        OnExit = edtCodCocExit
        OnKeyPress = edtCodCocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtCodCat: TEditFocus
        Tag = 99
        Left = 624
        Top = 146
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 6
        TabOrder = 30
        OnExit = edtCodCatExit
        OnKeyPress = edtCodCatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesCat: TEditFocus
        Left = 697
        Top = 146
        Width = 300
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 31
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodQua: TEditFocus
        Tag = 99
        Left = 128
        Top = 169
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 11
        OnExit = edtCodQuaExit
        OnKeyPress = edtCodQuaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesQua: TEditFocus
        Left = 214
        Top = 169
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 44
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaIniFlx: TMaskEditFocus
        Tag = 99
        Left = 624
        Top = 123
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 27
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFinFlx: TMaskEditFocus
        Tag = 99
        Left = 707
        Top = 123
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 28
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtEntrCD: TEditFocus
        Tag = 99
        Left = 906
        Top = 123
        Width = 25
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 29
        Text = 'N'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object edtNumeroDocumento: TEditFocus
        Tag = 99
        Left = 128
        Top = 192
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspecieDocumento: TEditFocus
        Tag = 99
        Left = 270
        Top = 192
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object BtnExibirCalendario: TBitBtnLocked
        Left = 842
        Top = 234
        Width = 156
        Height = 26
        Caption = 'Exibir Modo Calend'#225'rio'
        TabOrder = 47
        OnClick = BtnExibirCalendarioClick
      end
      object edtAssunto: TEditFocus
        Tag = 99
        Left = 849
        Top = 169
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 128
        Top = 238
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 16
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmp: TEditFocus
        Left = 214
        Top = 238
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 17
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodTea: TEditFocus
        Tag = 99
        Left = 624
        Top = 191
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 6
        TabOrder = 34
        OnExit = edtCodTeaExit
        OnKeyPress = edtCodTeaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesTea: TEditFocus
        Left = 697
        Top = 191
        Width = 300
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 35
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodDig: TEditFocus
        Tag = 99
        Left = 128
        Top = 215
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
        OnExit = edtCodDigExit
        OnKeyPress = edtCodDigKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomDig: TEditFocus
        Left = 214
        Top = 215
        Width = 280
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object cxIncluirHistoricoOpeOrig: TcxCheckBox
        Left = 416
        Top = 100
        Hint = 'Pesquisar operador de origem no hist'#243'rico das ocorr'#234'ncias'
        Caption = 'Pesq. hist'#243'rico'
        TabOrder = 6
      end
      object cxIncluirHistoricoOpeDest: TcxCheckBox
        Left = 416
        Top = 122
        Hint = 'Pesquisar operador de destino no hist'#243'rico das ocorr'#234'ncias'
        Caption = 'Pesq. hist'#243'rico'
        TabOrder = 9
      end
    end
    object pnlHistorico: TPanel
      Left = 1
      Top = 411
      Width = 1016
      Height = 251
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlHistorico'
      ShowCaption = False
      TabOrder = 1
      object Label8: TLabel
        Left = 0
        Top = 231
        Width = 1016
        Height = 20
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Passe o mouse sobre a coluna ou pressione enter para ver o hist'#243 +
          'rico completo'
        Layout = tlCenter
        ExplicitLeft = 2
        ExplicitTop = 155
        ExplicitWidth = 1014
      end
      object lblQtdOcoAbe: TLabel
        Left = 0
        Top = 217
        Width = 1016
        Height = 14
        Align = alBottom
        Caption = 'lblQtdOcoAbe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 75
      end
      object cxPageControl: TcxPageControl
        Left = 0
        Top = 0
        Width = 1016
        Height = 217
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = cxTabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 213
        ClientRectLeft = 4
        ClientRectRight = 1012
        ClientRectTop = 25
        object cxTabSheet1: TcxTabSheet
          Caption = 'Hist'#243'rico'
          ImageIndex = 0
          object cxGridCitel: TcxGridCitel
            Left = 0
            Top = 0
            Width = 1008
            Height = 188
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxTableViewHisOco: TcxGridDBTableViewCitel
              OnMouseMove = cxTableViewHisOcoMouseMove
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = cxTableViewHisOcoCustomDrawCell
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = '<Nenhum hist'#243'rico dispon'#237'vel>'
              OptionsView.GroupByBox = False
              Zebra = True
              Destaque = False
              CorZebra = clMoneyGreen
              object HisOcoColumnSTATUS: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'STATUS'
                Visible = False
                MinWidth = 210
                Width = 210
              end
              object HisOcoColumnDESCRI: TcxGridDBColumn
                Caption = 'Hist.'
                DataBinding.FieldName = 'DESCRI'
                Options.FilteringFilteredItemsList = False
                Options.AutoWidthSizable = False
                Width = 32
              end
              object HisOcoColumnDTAINC: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DTAINC'
                Width = 61
              end
              object HisOcoColumnHORINC: TcxGridDBColumn
                Caption = 'Hora'
                DataBinding.FieldName = 'HORINC'
                Width = 57
              end
              object HisOcoColumnOPEORI: TcxGridDBColumn
                Caption = 'Operador origem'
                DataBinding.FieldName = 'OPEORI'
                Width = 113
              end
              object HisOcoColumnOPEDES: TcxGridDBColumn
                Caption = 'Operador destino'
                DataBinding.FieldName = 'OPEDES'
                Width = 121
              end
              object HisOcoColumnNUMDOC: TcxGridDBColumn
                Caption = 'Documento'
                DataBinding.FieldName = 'NUMDOC'
                Width = 104
              end
              object HisOcoColumnTIPOCO: TcxGridDBColumn
                Caption = 'Tipo ocorr'#234'ncia'
                DataBinding.FieldName = 'TIPOCO'
                Width = 146
              end
              object HisOcoColumnCODSIT: TcxGridDBColumn
                Caption = 'Situa'#231#227'o'
                DataBinding.FieldName = 'CODSIT'
                Width = 129
              end
              object HisOcoColumnOBSERV: TcxGridDBColumn
                Caption = 'Hist'#243'rico Simplificado'
                DataBinding.FieldName = 'OBSERV'
                Width = 225
              end
              object HisOcoColumnCODCOC: TcxGridDBColumn
                Caption = 'Compl. Ocorr'#234'ncia'
                DataBinding.FieldName = 'CODCOC'
              end
            end
            object cxGridCitelLevel1: TcxGridLevel
              GridView = cxTableViewHisOco
            end
          end
        end
        object tbsOcoPar: TcxTabSheet
          Caption = 'Participantes'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxgOcoPar: TcxGridCitel
            Left = 0
            Top = 0
            Width = 1008
            Height = 188
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgOcoParDBTableViewCitel: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = True
              Destaque = True
              CorZebra = clMoneyGreen
              object cxgOcoParDBTableViewCitelColumn1: TcxGridDBColumn
                Caption = 'Nome'
                DataBinding.FieldName = 'PAR_NOMPAR'
                Width = 219
              end
              object cxgOcoParDBTableViewCitelColumn2: TcxGridDBColumn
                Caption = 'Fun'#231#227'o'
                DataBinding.FieldName = 'PAR_FUNPAR'
                Width = 164
              end
              object cxgOcoParDBTableViewCitelColumn3: TcxGridDBColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'PAR_EMPRES'
                Width = 135
              end
              object cxgOcoParDBTableViewCitelColumn4: TcxGridDBColumn
                Caption = 'Observa'#231#227'o'
                DataBinding.FieldName = 'PAR_OBSPAR'
                Width = 283
              end
            end
            object cxgOcoParLevel1: TcxGridLevel
              GridView = cxgOcoParDBTableViewCitel
            end
          end
        end
      end
    end
    object splDivisor: TcxSplitter
      Left = 1
      Top = 391
      Width = 1016
      Height = 5
      Cursor = crVSplit
      AlignSplitter = salBottom
    end
    object pnlBotoesInferiores: TPanel
      Left = 1
      Top = 662
      Width = 1016
      Height = 1
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 4
      Visible = False
    end
    object btnVisualizacaoFiltros: TBitBtnLocked
      Left = 1
      Top = 266
      Width = 1016
      Height = 15
      Align = alTop
      Caption = '<< Recolher Filtros >>'
      TabOrder = 5
      OnClick = btnVisualizacaoFiltrosClick
    end
    object btnVisualizacaoHistorico: TBitBtnLocked
      Left = 1
      Top = 396
      Width = 1016
      Height = 15
      Align = alBottom
      Caption = '<< Recolher Hist'#243'rico >>'
      TabOrder = 6
      OnClick = btnVisualizacaoHistoricoClick
    end
    object pnlCalendarioGeral: TPanel
      Left = 121
      Top = 254
      Width = 681
      Height = 119
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 7
      object Splitter2: TSplitter
        Left = 344
        Top = 35
        Width = 5
        Height = 83
        Align = alRight
        ExplicitLeft = 449
      end
      object pnlMenuCalendario: TPanel
        Left = 1
        Top = 1
        Width = 679
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnMesAnt: TBitBtnLocked
          Left = 151
          Top = 7
          Width = 25
          Height = 21
          Caption = '<'
          TabOrder = 0
          OnClick = btnMesAntClick
        end
        object btnMesProx: TBitBtnLocked
          Left = 241
          Top = 7
          Width = 25
          Height = 21
          Caption = '>'
          TabOrder = 1
          OnClick = btnMesProxClick
        end
        object btnSelecionarMes: TBitBtnLocked
          Left = 176
          Top = 7
          Width = 65
          Height = 21
          Caption = 'M'#234's'
          TabOrder = 2
        end
        object btnSelecionarAno: TBitBtnLocked
          Left = 42
          Top = 7
          Width = 65
          Height = 21
          Caption = 'Ano'
          TabOrder = 3
        end
        object btnAnoAnt: TBitBtnLocked
          Left = 16
          Top = 7
          Width = 25
          Height = 21
          Caption = '<'
          TabOrder = 4
          OnClick = btnAnoAntClick
        end
        object btnAnoProx: TBitBtnLocked
          Left = 108
          Top = 7
          Width = 25
          Height = 21
          Caption = '>'
          TabOrder = 5
          OnClick = btnAnoProxClick
        end
        object chkexibirFds: TCheckBox
          Left = 272
          Top = 9
          Width = 238
          Height = 17
          Caption = 'Exibir Finais de Semana'
          TabOrder = 6
          OnClick = chkexibirFdsClick
        end
        object CheckBoxExibicaoCalendario: TCheckBox
          Left = 568
          Top = 11
          Width = 183
          Height = 17
          Caption = 'Modo Exibicao Calendario'
          TabOrder = 7
          Visible = False
          OnClick = chkexibirFdsClick
        end
        object btnCarregaDadosCalendario: TBitBtnLocked
          Left = 516
          Top = 4
          Width = 156
          Height = 26
          Caption = 'Carregar ocorr'#234'ncias'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000020000
            000A000000160000001B000000170000000B0000000200000000000000010000
            00060000000B0000000F0000000C0000000600000001000000000000000F2616
            1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
            1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
            70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
            72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
            D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
            D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
            F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
            F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
            E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
            E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
            A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
            CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
            5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
            CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
            3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
            D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
            1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
            E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
            0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
            C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
            0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
            58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
            0000000000010000000400000006000000050000000200000000000000000000
            0001000000010000000100000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 8
          OnClick = btnCarregaDadosCalendarioClick
        end
        object edtDiaCalendarioSelecionado: TEditFocus
          Left = 435
          Top = 11
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          TabOrder = 9
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlCalendario: TPanel
        Left = 1
        Top = 35
        Width = 343
        Height = 83
        Align = alClient
        Color = clActiveCaption
        ParentBackground = False
        TabOrder = 1
        OnResize = pnlCalendarioResize
        object edtTamanhoDetalhamento: TEditFocus
          Left = 165
          Top = 6
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          TabOrder = 0
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkFiltrosExpandido: TCheckBox
          Left = 304
          Top = 32
          Width = 97
          Height = 17
          Caption = 'chkFiltrosExpandido'
          TabOrder = 1
        end
        object chkHistoricoExpandido: TCheckBox
          Left = 304
          Top = 8
          Width = 97
          Height = 17
          Caption = 'chkHistoricoExpandido'
          TabOrder = 2
        end
      end
      object pnlDetalhamento: TPanel
        Left = 349
        Top = 35
        Width = 331
        Height = 83
        Align = alRight
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        OnResize = pnlDetalhamentoResize
        object pnlTotalAgendamentos: TPanel
          Left = 1
          Top = 59
          Width = 329
          Height = 23
          Align = alBottom
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object pnlTitAgendamentos: TPanel
          Left = 1
          Top = 1
          Width = 329
          Height = 23
          Align = alTop
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblTitAgendamentos: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 321
            Height = 18
            Align = alClient
            Alignment = taCenter
            Caption = 'Agendamentos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 85
            ExplicitHeight = 14
          end
        end
        object ListViewCalendario: TListView
          Left = 1
          Top = 24
          Width = 329
          Height = 35
          Align = alClient
          Columns = <>
          Ctl3D = False
          HideSelection = False
          MultiSelect = True
          GroupView = True
          ReadOnly = True
          RowSelect = True
          ShowWorkAreas = True
          TabOrder = 2
          ViewStyle = vsReport
          OnAdvancedCustomDrawItem = ListViewCalendarioAdvancedCustomDrawItem
          OnClick = ListViewCalendarioClick
          OnDblClick = ListViewCalendarioDblClick
          OnExit = ListViewCalendarioExit
          OnKeyUp = ListViewCalendarioKeyUp
          OnMouseDown = ListViewCalendarioMouseDown
          OnSelectItem = ListViewCalendarioSelectItem
        end
      end
    end
  end
  object pnlBotoesAgregados: TFlowPanel [4]
    Left = 0
    Top = 664
    Width = 1018
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 116
      Height = 24
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAbrirOcorrencia: TBitBtnLocked
      Left = 116
      Top = 0
      Width = 137
      Height = 24
      Hint = 'Abrir Ocorr'#234'ncia'
      Align = alLeft
      Caption = 'Abrir Ocorr'#234'ncia [F1]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6
        A4C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFE
        FCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBC2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
        FBC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFAF5FEFCFBFEFAF5FEFAF5FE
        FCFBFEFAF5FEFAF5FEFCFBFEFAF5FEFAF5C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFA
        F5C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FE
        F7F0FEF7F0FEF7F0FEF7F0FEF7F0FEF7F0C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FEF3E9FEF7F0FEF7F0FEF3E9FEF7F0FEF7
        F0C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FEF3E9FEF3E9FEF3E9FE
        F3E9FEF3E9FEF3E9FEF3E9FEF3E9FEF3E9C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFF0E2FFF0E2FEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEE
        DEC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FFEEDEFFF0E2FEF3E9FF
        EEDEFFF0E2DDCFC2DDCFC2DDCFC2DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEEDEFFEEDEFFEEDEFFEEDEFFEEDEFFEEDEC3B4A8C3B4A8C3B4A8C3B4
        A8C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FFEEDEFFEAD7FFEEDEFFEAD7FF
        EAD7FFEEDEB0A296B0A296B0A296B0A296C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEAD7FFEAD7FFEAD7FFEAD7FFEAD7C9B9ACFEFAF5FEF7F0E6DAD9C2A6
        A4FF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4FFEAD7FFE6D0FFEAD7FFE6D0FF
        EAD7C5B5A9FEFAF5DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C2A6A4FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0C9B9ACDDCFC2C2A6A4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2
        A6A4C2A6A4C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAbrirOcorrenciaClick
    end
    object btnHistorico: TBitBtnLocked
      Left = 253
      Top = 0
      Width = 112
      Height = 24
      Align = alLeft
      Caption = 'Gerar Fluxo [F2]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF5F5D5D5F5D5D5F5D5D5F5D5D5F5D5D5F5D5DFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5F5C5C5F5D5DB7B7B8A1A09F90
        8C84928A809C918FAFA0A15F5D5D5F5D5DFF00FFFF00FFFF00FFFF00FFFF00FF
        5F5D5DCFCED09F9F9D918F80BCBBA6A1A7BF8390C2C1BCAA928979907E79C2A9
        AA5F5D5DFF00FFFF00FFFF00FF5F5D5DD5D3D4417841427D3CFAEDD3FCDDB895
        A1ED3D59F2FFE7CEFFFFFAAFADA087746CC9A9AA5F5D5DFF00FFFF00FF5F5D5D
        639263046B0B046B0B7AA054F2CA8EF4BD7BF3AD68EDB476FBE7BBFFFFFCACAA
        9C9578745F5D5DFF00FF5F5D5D81AF84046B0B38D46543E278046B0B96C077FE
        F2BDF7D79FEEB87FEEBD81F4D09DFCFBED887A6BC9A1A15F5D5D447047046B0B
        26BD462CC44F34CE5D34C75C046B0B93C17DFCF8C9FFEDB4FCC282EFA966FFE3
        BFB8B1A3AD8B865F5D5D046B0B046B0B09741123BB4125B644046B0B046B0B04
        6B0B6B6C639EA1849C8765C08A5795A1ED909ABD9D7E765F5D5D5F5D5DD5CFCA
        046B0B1BAB331DAA35046B0BFCFCCC8F8F7E1A1C1D2223211A1C1DA67F523D59
        F26679BCA5867A5F5D5D5F5D5DDEDDDD046B0B16A32917A72D599E5CFFFFE6F4
        F4CBB5B59A1A1C1DA9A183FFD593FFE0ACBFBC9FB48F8F5F5D5D5F5D5DE1E0E2
        9DA487046B0B16AA29046B0BACCEADFFFFEFFFFFE3CFCFB21A1C1D877359FCF8
        D1958C7DC9A1A45F5D5DFF00FF5F5D5DD1CECB6D935B046B0B16A729046B0B60
        A4649FC79DB1D3B0A5BB908E8E7FBFC0A5A189875F5D5DFF00FFFF00FF5F5D5C
        D3D4D5BDB8B4789D65046B0B046B0B046B0B046B0B046B0B80B57DD4D5B59C8C
        87CAAAAA5F5D5DFF00FFFF00FFFF00FF5F5D5DCBCBCEC4BFBCC1B6A5E0D3C0D5
        DAD7C0D4DCE0DCCBB5B1A1AD9C99C1A7A75F5D5DFF00FFFF00FFFF00FFFF00FF
        FF00FF5F5D5D5F5D5DB8BABBB6B4B1B5AFA7B6ADA4B1A7A4B2A5A65F5D5D5F5D
        5DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF605E5E5F5D5D5F
        5D5D5F5D5D5F5D5D605E5EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnHistoricoClick
    end
    object btnFinalizar: TBitBtnLocked
      Left = 365
      Top = 0
      Width = 95
      Height = 24
      Hint = 'Finalizar essa ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Finalizar [F3]'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D008D6E8D00A856A800C837C800E41B
        E400F509F500FC02FC00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FE02FE00FD03FD00FC05FC00FB09FB00FA0DFA00F814F800F129F400E940
        F000E15AEC00D977E600D191E100C9AEDB00C1C1DB00B9D4DE00B3D7E500AFD9
        EA00AFDDEF00B0E0F200B2E3F400B3E5F600B4E7F700B5E8F800B3E8F800B1E7
        F800AFE7F800A9E5F800A3E3F8009CE0F80096DEF8008FDBF8008DDAF8008AD8
        F90086D6F90081D5F8007DD4F7007AD4F60079D2F40078D0F40077CDF20074CC
        F1006FCBEE006AC9EB0066C8EA0063C6E7005FC3E40059BEE00053BBDD004DB9
        D90047B7D80041B5D70039B2D70034AED60030ABD5002BA9D40027A7D30023A5
        D10020A3CF001FA0CC001E9FCC001C9DCA001A9AC8001998C6001494C500108F
        C0000F8BBC000E87B8000D83B4000B81B3000C7EAE000C7DAE009E9E9E9E9E9E
        9E9E9E9E9E9E9E9E9E9E9E9E9EFBEEEAECF1ED9E9E9E9E9E9E9E9E9EFAF9E4DA
        DCDFE5E7EE9E9E9E9E9E9E9EF8F6E3D9DFE4EBE0DBE79E9E9E9E9E9EF6F2DDD5
        D8EAFCE8DCDBF49E9E9E9E9EF2EFD5CFD4E8FFE9DFDCF49E9E9E9E9EF0EDCBCF
        CFD4F8E6DBE0F49E9E9E9E9EF4EDEBE9EAEAE7E3DAD9F49E9E9E9E9EF5EBF1EE
        EEF2EDE7DBE3F89E9E9E9E9EF5EBFCF2DDECF2FBF8ECF99E9E9E9E9E9EFFFFF7
        DDDDEEFEFCF99E9E9E9E9E9E9E9EFDFC9EF0F9FFFE9E9E9E9E9E9E9E9E9EECFB
        9E9E9EFFFF9E9E9E9E9E9E9E9E9EF9E4F79EFFFB9E9E9E9E9E9E9E9E9E9E9EF3
        E5E8EEFD9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnFinalizarClick
    end
    object btnAltSituacao: TBitBtnLocked
      Left = 460
      Top = 0
      Width = 117
      Height = 24
      Hint = 'Alterar situa'#231#227'o da ocorr'#234'ncia'
      Align = alLeft
      Caption = 'Alt. Situa'#231#227'o [F4]'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00010000000A0D0A0865251A17EC5A4238EC1A13105C00000007000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0009130E0C6968554CFEC9AA97FFC8AA97FF584037EA0000000E000000000000
        0000000000000000000000000001000000060000000B0000000D000000101812
        1069776358FED8BBAAFFD8BBA8FFDCC9BCFF5C433AEC0000000D000000020000
        00060000000A0000000D01010119271C1788422D25D84B332BFF3D2921E6836E
        63FEDCC1B2FFDCC2B0FFEAD7CCFF917B71FE1F16145F00000005000000068060
        54BDC3A396FFCCB5ADFF7A6057FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
        B8FFDFC7B7FFE9DACFFF9B857BFF95827AEC000000100000000100000008B78A
        79FFF6F0ECFFAB9991FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
        BDFFE2CEBFFFA08A80FFBDAFA7FFCDB7AEFF0000000D0000000000000008B98F
        7EFFF5EFEBFF8D7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
        BFFFD1B9ABFF82675DFFEDE6E0FFB89182FF0000000C0000000000000007BE93
        81FFD3B6A9FF8B6F63FFB7A299FFAE9286FFCDAFA2FFAA8E82FFAF9B92FFE6D1
        C3FFE6D2C7FF7E6459FFF1E9E4FFAE806FFF0000000B0000000000000007C197
        86FFF7F3F0FF9D857AFFC7B8B0FFD5B8ABFFF8F1EDFFEAE2DDFF71574DFFE7D4
        C6FFD2C0B8FF8C746AFFF4ECE8FFB18473FF0000000B0000000000000006C59C
        8BFFFBF7F5FFF8F2EEFFF9F2EEFFD9BCAFFFF6F0ECFFA99891FF937C72FFEEE0
        D8FFB09C92FFB9A9A2FFF7F0ECFFB58877FF0000000A0000000000000006C9A0
        8FFFDCC1B5FFDCC0B3FFDCC0B3FFDABEB2FF9D8175FF8F7A72FFCABAB2FFB6A2
        97FF9C8073FFD6B8AEFFDABCB1FFB88D7BFF0000000A0000000000000005CCA4
        93FFFDF9F8FFFBF6F4FFFBF7F4FFDBC0B5FFAC958AFF987D6FFFA58E85FFB79C
        90FFF6F0EDFFFAF5F2FFFBF6F3FFBC907FFF000000090000000000000005CFA8
        97FFFDFAF9FFFBF7F5FFFCF7F5FFDFC5B8FFFAF6F3FFFAF5F3FFF9F5F3FFDDC3
        B6FFFCF7F5FFFBF7F4FFFBF7F4FFC09584FF000000080000000000000004C38A
        5BFFE6C79EFFD6A771FFD6A56FFFB67948FFD5A26AFFD49F69FFD49E65FFB474
        43FFD39961FFD2985FFFD1965EFFB37240FF000000080000000000000004C58E
        5EFFF2DBB5FFF2DAB3FFF0D7B0FFC6966BFFEFD4AAFFEFD2A7FFEECFA4FFBE89
        5BFFEBCB9CFFEAC99AFFEAC696FFB67744FF000000070000000000000002936A
        48BFC68E60FFC58D5FFFC48C5CFFC38A5BFFC28958FFC08756FFC08554FFBE83
        52FFBD8150FFBB7F4DFFBA7E4CFF895C36C10000000400000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnAltSituacaoClick
    end
    object btnArquivos: TBitBtnLocked
      Left = 577
      Top = 0
      Width = 96
      Height = 24
      Hint = 'Anexar arquivos a essa ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Anexos [F7]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6
        A4C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFE
        FCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBC2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
        FBC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFAF5FEFCFBFEFAF5FEFAF5FE
        FCFBFEFAF5FEFAF5FEFCFBFEFAF5FEFAF5C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFA
        F5C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FE
        F7F0FEF7F0FEF7F0FEF7F0FEF7F0FEF7F0C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FEF3E9FEF7F0FEF7F0FEF3E9FEF7F0FEF7
        F0C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FEF3E9FEF3E9FEF3E9FE
        F3E9FEF3E9FEF3E9FEF3E9FEF3E9FEF3E9C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFF0E2FFF0E2FEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEE
        DEC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FFEEDEFFF0E2FEF3E9FF
        EEDEFFF0E2DDCFC2DDCFC2DDCFC2DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEEDEFFEEDEFFEEDEFFEEDEFFEEDEFFEEDEC3B4A8C3B4A8C3B4A8C3B4
        A8C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FFEEDEFFEAD7FFEEDEFFEAD7FF
        EAD7FFEEDEB0A296B0A296B0A296B0A296C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEAD7FFEAD7FFEAD7FFEAD7FFEAD7C9B9ACFEFAF5FEF7F0E6DAD9C2A6
        A4FF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4FFEAD7FFE6D0FFEAD7FFE6D0FF
        EAD7C5B5A9FEFAF5DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C2A6A4FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0C9B9ACDDCFC2C2A6A4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2
        A6A4C2A6A4C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnArquivosClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 673
      Top = 0
      Width = 96
      Height = 24
      Hint = 'Imprimir a ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Imprimir [F8]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6C6A6AAAA7A7A19F9F6C6A6A6C
        6A6A6C6A6AE5E3E36C6A6A6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FFFF00FF
        6C6A6ADAD9D9A19F9FA19F9FA19F9F3736363535356C6D6DBFBFBFE1E2E2B7B6
        B66C6A6A6C6A6A6C6A6AFF00FF6C6A6AD4D3D3CACACA8E8C8C8E8C8C8E8C8C3C
        3B3B0A090A0707070B0B0B0707077A7A7ABBBBBB6C6A6AFF00FF6C6A6ACACACA
        CACACA8E8C8CD7D4D4CECBCBBFBCBCB1AFAFA3A0A08886865E5B5C0707070909
        090808086C6A6A7673736C6A6ACACACA8E8C8CEFEEEEFFFEFEFBFAFAE3E0E1DE
        DEDEDEDDDDCFCECEBDBCBCADABAB8B89895856567A78787573736C6A6A8E8C8C
        FFFFFFFEFCFCFAFAFAD5D4D5989193A09899B2ABACC4C0C1D7D7D7D8D8D8C7C6
        C6B7B6B6918F8F6C6969FF00FF6C6A6A6C6A6AEDEBEBB1A6A77A6F728A838896
        92959690919D97989A93959E9899BBBABAD1D1D1C2C2C26C6A6AFF00FFFF00FF
        FF00FF6C6A6ABB897FA7876D8B6F647D67606F62657973798F8B8EA9A3A4CBCA
        CAC1C1C16C6A6AFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFE3B4FFD39FE9
        B281C99973BA916CBD8281807D7E6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFBD8281FFE0B8FFD3A7FFD09DFFCE90FFC688BD8281FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC08683FFE7CFFFE0C0FFD9B2FF
        D3A5FFD099BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFBD8281FEEBD8FFE6CCFFDEBDFFD8B1FED3A4BD8281FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFFFF2FFFFF2FFEBD8FFE5CAFF
        E1BDF3C7A7BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        BD8281BD8281BD8281FBEFE2FBE3CFFBDDC2BD8281FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281BD8281BD
        8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnImprimirClick
    end
    object btnCadCli: TBitBtnLocked
      Left = 769
      Top = 0
      Width = 121
      Height = 24
      Align = alLeft
      Caption = 'Cad. Clientes [F9]'
      TabOrder = 7
      OnClick = btnCadCliClick
    end
    object btnHisDeb: TBitBtnLocked
      Left = 890
      Top = 0
      Width = 115
      Height = 24
      Align = alLeft
      Caption = 'Conta Corrente [F11]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = btnHisDebClick
    end
    object btnConsumiveis: TBitBtnLocked
      Left = 0
      Top = 24
      Width = 171
      Height = 24
      Align = alLeft
      Caption = 'Oferta de Consum'#237'veis [F12]'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFDFDFDFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCFCFCFEFE
        FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDCDC4C1C8B1A9C6AFA7C6AFA7C6
        AFA7C6AFA7C6AFA7C7B0A8C7B4ADE8E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBCFBAB3F9F2EFF9F2EFF9F2EFDECAC2F9F2EFF9F2EFF9F2EFFAF4F2CDBA
        B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBD2B9B0EADBD4DDC8BFEADBD4DD
        C8BFF7EEE9DDC8BFDDC8BFF9F2EFD0B9B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBC5A499DDC8BFDDC8BFDDC8BFD0B4AADDC8BFDDC8BFDDC8BFDECAC2D0B9
        B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBD3BAB1F7EEE9F7EEE9F7EEE9DD
        C8BFF7EEE9F7EEE9F7EEE9F9F2EFD1BAB2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBD4BAB2EADBD4DDC8BFEADBD4DDC8BFF7EEE9DDC8BFDDC8BFF9F2EFD1BA
        B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBC6A69BDDC8BFDDC8BFDDC8BFD0
        B4AADDC8BFDDC8BFDDC8BFDECAC2D2BBB3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBD5BCB3F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F9F2EFD2BC
        B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBD5BDB4EADBD4EADBD4DDC8BFDD
        C8BFDDC8BFDDC8BFDDC8BFF9F2EFD3BDB5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBD6BDB5F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F9F2EFD3BD
        B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBD7BFB6EADBD4EADBD4DDC8BFDD
        C8BFDDC8BFDDC8BFDDC8BFF9F2EFD4BFB7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBD8C1B8F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F7EEE9F9F2EFD5C1
        B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBC5A47ECCA777CCA777CCA777CC
        A777CCA777CCA777CCA777CFAD82D8C7B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FDFDFDD5BA99EACEA8EACEA8EACEA8EACEA8EACEA8EACEA8EACEA8EDD5B5DACA
        B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8CDC1DFCEB7DFCEB7DFCEB7DF
        CEB7DFCEB7DFCEB7DFCEB7DECDB9E9E6E3FFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      WordWrap = True
      OnClick = btnConsumiveisClick
    end
    object btnResFin: TBitBtnLocked
      Left = 171
      Top = 24
      Width = 150
      Height = 24
      Align = alLeft
      Caption = 'Resumo Financeiro [Ctrl+F1]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = btnResFinClick
    end
    object btnImpBol: TBitBtnLocked
      Left = 321
      Top = 24
      Width = 147
      Height = 24
      Align = alLeft
      Caption = 'Impress'#227'o Boleto [Ctrl+F2]'
      TabOrder = 11
      OnClick = btnImpBolClick
    end
    object btnMarcarTodas: TBitBtnLocked
      Left = 468
      Top = 24
      Width = 96
      Height = 24
      Align = alLeft
      Caption = 'Marcar Todas'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = btnMarcarTodasClick
    end
    object btnDesmarcarTodas: TBitBtnLocked
      Left = 564
      Top = 24
      Width = 96
      Height = 24
      Hint = 'Anexar arquivos a essa ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Desmarcar Todas'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = btnDesmarcarTodasClick
    end
    object btnCadLead: TBitBtnLocked
      Left = 660
      Top = 24
      Width = 121
      Height = 24
      Align = alLeft
      Caption = 'Cad. Lead [Ctrl+F12]'
      TabOrder = 14
      OnClick = btnCadLeadClick
    end
    object btnCadFor: TBitBtnLocked
      Left = 781
      Top = 24
      Width = 121
      Height = 24
      Align = alLeft
      Caption = 'Cad. Fornecedores[F9]'
      TabOrder = 15
      OnClick = btnCadForClick
    end
    object btnCadProspecto: TBitBtnLocked
      Left = 0
      Top = 48
      Width = 121
      Height = 24
      Align = alLeft
      Caption = 'Cad. Prospecto [F9]'
      TabOrder = 16
      OnClick = btnCadProspectoClick
    end
    object btnAlterarAssunto: TBitBtnLocked
      Left = 121
      Top = 48
      Width = 134
      Height = 24
      Hint = 'Alterar assunto da ocorr'#234'ncia'
      Align = alLeft
      Caption = 'Alt. Assunto  [Ctrl+F10]'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      OnClick = btnAlterarAssuntoClick
    end
    object btnCfg: TBitBtnLocked
      Left = 255
      Top = 48
      Width = 89
      Height = 24
      Caption = 'Configurar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000900000012000000120000
        0009000000020000000000000000000000000000000000000000000000000000
        0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
        0F700000000C0000000B0000000C000000050000000100000000000000000000
        00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
        23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
        00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
        37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
        00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
        9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
        0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
        D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
        1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
        B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
        60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
        67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
        64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
        5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
        245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
        C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
        000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
        E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
        0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
        D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
        0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
        6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
        00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
        4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
        0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
        295F000000030000000300000003000000010000000000000000000000000000
        0000000000000000000000000000000000000000000100000002000000030000
        0001000000000000000000000000000000000000000000000000}
      TabOrder = 18
      OnClick = btnCfgClick
    end
    object btnSairBaixa: TBitBtnLocked
      AlignWithMargins = True
      Left = 344
      Top = 48
      Width = 116
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[ Esc ] Sair'
      TabOrder = 19
      OnClick = btnSairBaixaClick
    end
  end
  object dtsOcorrencias: TDataSource
    DataSet = cdsOcorrencias
    Left = 387
    Top = 190
  end
  object cdsOcorrencias: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspOcorrencias'
    Left = 423
    Top = 190
    object cdsOcorrenciasQTDITEMSEL: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'QTDITEMSEL'
    end
    object cdsOcorrenciasOCO_CODOCO: TStringField
      FieldName = 'OCO_CODOCO'
      Size = 8
    end
    object cdsOcorrenciasOCO_CODTOC: TStringField
      FieldName = 'OCO_CODTOC'
      Size = 5
    end
    object cdsOcorrenciasTOC_DESTOC: TStringField
      FieldName = 'TOC_DESTOC'
      Size = 40
    end
    object cdsOcorrenciasOCO_CODCLI: TStringField
      FieldName = 'OCO_CODCLI'
      Size = 8
    end
    object cdsOcorrenciasGOC_CODGOC: TStringField
      FieldName = 'GOC_CODGOC'
      Size = 5
    end
    object cdsOcorrenciasGOC_DESGOC: TStringField
      FieldName = 'GOC_DESGOC'
      Size = 40
    end
    object cdsOcorrenciasCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsOcorrenciasCLI_FONE01: TStringField
      FieldName = 'CLI_FONE01'
      OnGetText = cdsOcorrenciasCLI_FONE01GetText
    end
    object cdsOcorrenciasOCO_DTAINC: TDateField
      FieldName = 'OCO_DTAINC'
    end
    object cdsOcorrenciasOCO_HORINC: TTimeField
      FieldName = 'OCO_HORINC'
    end
    object cdsOcorrenciasOCO_DTACON: TDateField
      FieldName = 'OCO_DTACON'
    end
    object cdsOcorrenciasOCO_HORCON: TTimeField
      FieldName = 'OCO_HORCON'
    end
    object cdsOcorrenciasOCO_CODOPE: TStringField
      FieldName = 'OCO_CODOPE'
      Size = 3
    end
    object cdsOcorrenciasOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsOcorrenciasOCO_CODEMP: TStringField
      FieldName = 'OCO_CODEMP'
      Size = 3
    end
    object cdsOcorrenciasOCO_OPEOCO: TStringField
      FieldName = 'OCO_OPEOCO'
      Size = 3
    end
    object cdsOcorrenciasNOPEOCO: TStringField
      FieldName = 'NOPEOCO'
      Size = 30
    end
    object cdsOcorrenciasOCO_PROTOC: TStringField
      FieldName = 'OCO_PROTOC'
      Size = 22
    end
    object cdsOcorrenciasGER_CODADE: TStringField
      FieldName = 'GER_CODADE'
      Size = 8
    end
    object cdsOcorrenciasDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
    object cdsOcorrenciasFGO_VLRCON: TFloatField
      FieldName = 'FGO_VLRCON'
      DisplayFormat = '#,##0.00'
    end
    object cdsOcorrenciasOCO_CODCOC: TStringField
      FieldName = 'OCO_CODCOC'
      Size = 5
    end
    object cdsOcorrenciasCOC_DESCOC: TStringField
      FieldName = 'COC_DESCOC'
      Size = 40
    end
    object cdsOcorrenciasOCO_DESCRI: TBlobField
      FieldName = 'OCO_DESCRI'
    end
    object cdsOcorrenciasOCO_CODSIT: TStringField
      FieldName = 'OCO_CODSIT'
      Size = 3
    end
    object cdsOcorrenciasOCO_ESPDOC: TStringField
      FieldName = 'OCO_ESPDOC'
      Size = 6
    end
    object cdsOcorrenciasOCO_NUMDOC: TStringField
      FieldName = 'OCO_NUMDOC'
      Size = 12
    end
    object cdsOcorrenciasOCO_EMERGE: TStringField
      FieldName = 'OCO_EMERGE'
      Size = 1
    end
    object cdsOcorrenciasCLI_EMAIL_: TStringField
      FieldName = 'CLI_EMAIL_'
      Size = 255
    end
    object cdsOcorrenciasOPE_E_MAIL: TStringField
      FieldName = 'OPE_E_MAIL'
      Size = 100
    end
    object cdsOcorrenciasOCO_DTAAGE: TDateField
      FieldName = 'OCO_DTAAGE'
    end
    object cdsOcorrenciasOCO_HORAGE: TTimeField
      FieldName = 'OCO_HORAGE'
    end
    object cdsOcorrenciasOCO_DTALIM: TDateTimeField
      FieldName = 'OCO_DTALIM'
    end
    object cdsOcorrenciasFGO_STATUS: TLargeintField
      FieldName = 'FGO_STATUS'
    end
    object cdsOcorrenciasCLI_FANSOB: TStringField
      FieldName = 'CLI_FANSOB'
      Size = 60
    end
    object cdsOcorrenciasUSADEPS: TStringField
      FieldName = 'USADEPS'
      Size = 1
    end
    object cdsOcorrenciasSTATUSDEPS: TStringField
      FieldName = 'STATUSDEPS'
    end
    object cdsOcorrenciasAUTOINCREMFATGOR: TStringField
      FieldName = 'AUTOINCREMFATGOR'
    end
    object cdsOcorrenciasMOTBAI: TStringField
      FieldName = 'MOTBAI'
      Size = 300
    end
    object cdsOcorrenciasFGO_NUMFAT: TStringField
      FieldName = 'FGO_NUMFAT'
      Size = 12
    end
    object cdsOcorrenciasCAT_DESCRI: TStringField
      FieldName = 'CAT_DESCRI'
      Size = 60
    end
    object cdsOcorrenciasCAT_CORCAT: TStringField
      FieldName = 'CAT_CORCAT'
      Size = 10
    end
    object cdsOcorrenciasOCO_SEQLAG: TStringField
      FieldName = 'OCO_SEQLAG'
    end
    object cdsOcorrenciasCLI_CONTAT: TStringField
      FieldName = 'CLI_CONTAT'
      Size = 30
    end
    object cdsOcorrenciasNLEAD: TStringField
      FieldName = 'NLEAD'
    end
    object cdsOcorrenciasFGO_PREVIS: TDateField
      FieldName = 'FGO_PREVIS'
    end
    object cdsOcorrenciasCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
    end
    object cdsOcorrenciasOCO_ASSUNT: TStringField
      FieldName = 'OCO_ASSUNT'
      Size = 50
    end
    object cdsOcorrenciasFGO_CODVEN: TStringField
      FieldName = 'FGO_CODVEN'
    end
    object cdsOcorrenciasOCO_C_P_F_: TStringField
      FieldName = 'OCO_C_P_F_'
    end
    object cdsOcorrenciasSIT_DESSIT: TStringField
      FieldName = 'SIT_DESSIT'
    end
    object cdsOcorrenciasOCO_NOMFRM: TStringField
      FieldName = 'OCO_NOMFRM'
    end
    object cdsOcorrenciasOCO_PARCEL: TStringField
      FieldName = 'OCO_PARCEL'
    end
    object cdsOcorrenciasOCO_CODTEA: TStringField
      FieldName = 'OCO_CODTEA'
    end
    object cdsOcorrenciasTEA_DESCRI: TStringField
      FieldName = 'TEA_DESCRI'
    end
    object cdsOcorrenciasTEA_CORTEA: TStringField
      FieldName = 'TEA_CORTEA'
    end
    object cdsOcorrenciasQTD_OCOABE: TFloatField
      FieldName = 'QTD_OCOABE'
    end
    object cdsOcorrenciasQTD_OCOFEC: TFloatField
      FieldName = 'QTD_OCOFEC'
    end
    object cdsOcorrenciasFGOCLI: TStringField
      FieldName = 'FGOCLI'
      Size = 8
    end
  end
  object qryOcorrencias: TUniQuery
    Connection = frmModulo.Database
    Left = 324
    Top = 190
  end
  object dspOcorrencias: TUniDataSetProvider
    DataSet = qryOcorrencias
    Options = []
    Left = 356
    Top = 190
  end
  object imgButton: TImageList
    Left = 136
    Top = 314
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000884
      BD0031ADD60042B5DE0039B5D60021A5D60031ADD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000088CBD00108C
      C60063CEEF0084D6FF007BD6F7007BD6F70063C6E7005ABDE70031ADD6000000
      00000000000000000000000000000000000018427B00215AA500215AA500215A
      A500215AA500215AA500215AA500215AA5002152A5002152A5002152A5002152
      A5002152A50018428C0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001094C600189C
      CE006BCEEF008CDEFF007BD6F70063CEEF0042B5D60073CEF70084D6FF005ABD
      E70000000000000000000000000000000000215AA500316BAD006BA5D60084CE
      F70042A5E70042A5E70042A5E70039A5E700399CE700399CE700399CE700319C
      E700319CDE002973C60010294A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0021A5
      CE007BD6F7009CE7FF008CDEFF0042B5DE000884B50052BDDE007BD6F70084D6
      FF00189CCE00000000000000000000000000296BAD004A84BD004A8CC600B5E7
      FF006BBDEF0052B5EF0052ADEF004AADE7004AADE7004AADE70042A5E70042A5
      E70042A5E7003994D600184A8400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5CE0029AD
      D6009CE7FF00B5EFFF00A5E7FF0052BDDE00087BAD004ABDDE007BD6F7007BD6
      F700189CCE00000000000000000000000000296BB5006BA5D6003984C600ADDE
      F7009CDEF70063BDEF0063BDEF0063BDEF005AB5EF005AB5EF0052B5EF0052B5
      EF0052ADE7004AADE700296BB500000810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5D60031AD
      D600B5E7F700B5EFFF00B5EFFF00A5E7FF001094C6005AC6E70084D6FF0073CE
      F700189CCE000000000000000000000000003173BD008CC6E700529CD60084BD
      E700C6EFFF007BCEF70073CEF70073C6F7006BC6F7006BC6EF006BC6EF0063BD
      EF0063BDEF0063BDEF00428CCE0010294A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0031AD
      D60042B5D6004ABDDE0042B5DE0042B5DE005ABDE7006BCEEF0084D6FF008CDE
      FF00189CCE00000000000000000000000000317BBD00ADE7F70073CEEF005AA5
      D600DEF7FF00DEFFFF00DEF7FF00DEF7FF00DEF7FF00D6F7FF00D6F7FF00CEEF
      FF00C6EFFF00C6EFFF009CCEEF00215284000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D60021A5D60031ADD60031ADD60021A5CE0031ADD6005ABDE70084D6FF006BCE
      EF001094C6000000000000000000000000003984C600C6F7FF0094E7FF0063BD
      E7004A9CD6004A9CD6004A9CD6004A9CCE004A9CCE004A94CE004294CE004294
      CE003173B5003173B5002973B5002963A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D6000884B50021A5CE007BD6F70039B5D60021A5CE000884BD001094C60039B5
      D600108CC600000000000000000000000000398CC600CEF7FF00A5EFFF009CEF
      FF0094E7FF008CE7FF008CDEFF0084DEFF0084DEFF007BDEFF007BD6FF007BD6
      FF00296BB5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000087B
      AD00087BAD00189CC6007BD6F7007BD6F70031ADD600087BAD000884B500108C
      C60000000000000000000000000000000000398CCE00D6FFFF00ADF7FF00ADEF
      FF00A5EFFF00A5EFFF00BDF7FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00CEF7
      FF003184BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000884B5000884B5000000000021A5D600108CC600087BAD00087BAD000000
      0000000000000000000000000000000000003994CE00D6FFFF00B5F7FF00B5F7
      FF00B5F7FF00BDEFFF004A94CE00398CC600398CC600398CC600398CC6003984
      C600296394000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039B5D6000884BD00000000000000000000000000087BAD00087BAD000000
      0000000000000000000000000000000000004294CE00E7FFFF00E7FFFF00E7FF
      FF00D6F7FF00428CBD0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000108CC60063CEEF00189CC60000000000087BAD000884BD00000000000000
      00000000000000000000000000000000000031739C00429CD600429CD600429C
      D6004294CE001031420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000018A5CE0063C6E70052BDDE0031ADD6000884B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E07FFFFF00000000
      C01F000100000000C00F000100000000C007000100000000C007000000000000
      C007000000000000C007000000000000C007000000000000C007000700000000
      E00F000700000000F21F000700000000F39F01FF00000000F13F03FF00000000
      F83FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object cxHint: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Lucida Console'
    HintStyle.Font.Style = []
    Left = 269
    Top = 386
  end
  object popOcorrencias: TPopupMenu
    OnPopup = popOcorrenciasPopup
    Left = 271
    Top = 98
    object mnuAbrirOcorrencia: TMenuItem
      Caption = 'Abrir Ocorr'#234'ncia'
      OnClick = mnuAbrirOcorrenciaClick
    end
    object mnuEfetivarOrcamento: TMenuItem
      Caption = 'Efetivar em Pedido'
      ShortCut = 32881
      OnClick = mnuEfetivarOrcamentoClick
    end
    object mnuAlterarDocumento: TMenuItem
      Caption = 'Alterar Documento'
      ShortCut = 32882
      OnClick = mnuAlterarDocumentoClick
    end
    object mnuEnviarEmail: TMenuItem
      Caption = 'Enviar por E-mail'
      ShortCut = 32883
      OnClick = mnuEnviarEmailClick
    end
    object mnuGerarPDF: TMenuItem
      Caption = 'Gerar PDF'
      ShortCut = 32884
      OnClick = mnuGerarPDFClick
    end
    object mnuReimprimir: TMenuItem
      Caption = 'Reimprimir'
      ShortCut = 32885
      OnClick = mnuReimprimirClick
    end
    object mnuGerarVendaPerdida: TMenuItem
      Caption = 'Gerar Venda Perdida'
      ShortCut = 32886
      OnClick = mnuGerarVendaPerdidaClick
    end
    object mnuDesmembrar: TMenuItem
      Caption = 'Desmembrar'
      ShortCut = 32887
      OnClick = mnuDesmembrarClick
    end
    object mnuBaixar: TMenuItem
      Caption = 'Baixar (n'#227'o ser'#225' entregue)'
      ShortCut = 32888
      OnClick = mnuBaixarClick
    end
    object mnuAnaliseCreditoDEPS: TMenuItem
      Caption = 'Solicitar an'#225'lise de cr'#233'dito DEPS'
      OnClick = mnuAnaliseCreditoDEPSClick
    end
    object mnuAbrirLead: TMenuItem
      Caption = 'Abrir Cadastro do Lead'
      OnClick = mnuAbrirLeadClick
    end
    object mnuModificarCategoria: TMenuItem
      Caption = 'Modificar Categoria'
      OnClick = mnuModificarCategoriaClick
    end
    object mnuLimparSeparacao: TMenuItem
      Caption = 'Limpar Separa'#231#227'o'
      OnClick = mnuLimparSeparacaoClick
    end
    object mnuFaturarEmVendaNormal: TMenuItem
      Caption = 'Faturar em Venda Normal'
      OnClick = mnuFaturarEmVendaNormalClick
    end
    object mnuEnviarBoletoPorEmail: TMenuItem
      Caption = 'Enviar Boleto por E-mail'
      OnClick = mnuEnviarBolEmail
    end
  end
  object popPedido: TPopupMenu
    Left = 324
    Top = 98
    object mnuFatPedido: TMenuItem
      Caption = 'Pedido'
      Hint = 'frmFatVendas - PD'
    end
  end
  object popOrcamento: TPopupMenu
    Left = 376
    Top = 98
    object mnuFatOrcamento: TMenuItem
      Caption = 'Or'#231'amento'
      Hint = 'frmFatVendas - OR'
    end
  end
  object tmrSistemaDEPS: TTimer
    Enabled = False
    Interval = 12000
    OnTimer = tmrSistemaDEPSTimer
    Left = 802
    Top = 102
  end
  object PopVendaNormal: TPopupMenu
    Left = 512
    Top = 140
    object mnuFatVendaNormal: TMenuItem
      Caption = 'Venda Normal'
      Hint = 'FatVendaNormal - VN'
    end
  end
  object tmrAtualizarDados: TTimer
    Enabled = False
    Interval = 300
    OnTimer = tmrAtualizarDadosTimer
    Left = 801
    Top = 144
  end
end
