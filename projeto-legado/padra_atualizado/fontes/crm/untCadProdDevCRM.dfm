inherited frmCadProdDevCRM: TfrmCadProdDevCRM
  Width = 624
  Height = 425
  AutoSize = True
  Caption = 'Produtos Devolu'#231#227'o - CRM'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 624
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 618
    ExplicitTop = 380
    ExplicitWidth = 618
    DesignSize = (
      618
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  inherited pnlStatus: TPanel
    Top = 380
    Width = 618
    ExplicitTop = 380
    ExplicitWidth = 618
    inherited pnlNomeForm: TPanel
      Left = 447
      ExplicitLeft = 447
    end
    inherited pnlInfo: TPanel
      Width = 447
      ExplicitWidth = 447
    end
  end
  inherited pgcDados: TPageControl
    Width = 618
    Height = 380
    ExplicitWidth = 618
    ExplicitHeight = 380
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 610
      ExplicitHeight = 348
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 618
    Height = 380
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 616
      Height = 103
      Align = alTop
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        616
        103)
      object Label1: TLabel
        Left = 24
        Top = 18
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object Label2: TLabel
        Left = 6
        Top = 41
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label4: TLabel
        Left = 30
        Top = 63
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motivo:'
      end
      object lblGarantia: TLabel
        Left = 16
        Top = 82
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Garantia:'
      end
      object clrLblGarantia: TColorLabel
        Left = 137
        Top = 82
        Width = 58
        Height = 14
        Caption = '(S)im (N)'#227'o '
        CorDestaque = clRed
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 66
        Top = 8
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Tag = 99
        Left = 132
        Top = 8
        Width = 467
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        MaxLength = 87
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
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 66
        Top = 31
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
        ParentFont = False
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
      object edtDesMot: TEditFocus
        Tag = 99
        Left = 132
        Top = 54
        Width = 281
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        MaxLength = 87
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
      object edtCodMot: TEditFocus
        Tag = 99
        Left = 66
        Top = 54
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 3
        OnKeyPress = edtCodMotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtGarant: TEditFocus
        Tag = 99
        Left = 66
        Top = 77
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttAlfanumerico
      end
      object btnAdicionar: TBitBtnLocked
        Left = 433
        Top = 75
        Width = 80
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnAdicionarClick
      end
      object btnCancelaItem: TBitBtnLocked
        Left = 519
        Top = 76
        Width = 80
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnCancelaItemClick
      end
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 306
      Width = 616
      Height = 44
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        616
        44)
      object Label3: TLabel
        Left = 8
        Top = 2
        Width = 118
        Height = 14
        Caption = 'Descri'#231#227'o do Produto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 356
        Top = 2
        Width = 59
        Height = 14
        Caption = 'Refer'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 484
        Top = 2
        Width = 44
        Height = 14
        Caption = 'Unidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cxDBLabel1: TcxDBLabel
        Left = 7
        Top = 19
        DataBinding.DataField = 'DESITE'
        DataBinding.DataSource = dtsProdutos
        ParentFont = False
        Style.BorderStyle = ebsOffice11
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -11
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Height = 21
        Width = 338
      end
      object cxDBLabel2: TcxDBLabel
        Left = 356
        Top = 19
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'REFERE'
        DataBinding.DataSource = dtsProdutos
        ParentFont = False
        Style.BorderStyle = ebsOffice11
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -11
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Height = 21
        Width = 119
      end
      object cxDBLabel3: TcxDBLabel
        Left = 484
        Top = 19
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'DESUNI'
        DataBinding.DataSource = dtsProdutos
        ParentFont = False
        Style.BorderStyle = ebsOffice11
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -11
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Height = 21
        Width = 115
      end
    end
    object pnlBotoesEnt: TPanel
      Left = 1
      Top = 350
      Width = 616
      Height = 29
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object chkGerarColeta: TCheckBox
        Left = 284
        Top = 4
        Width = 192
        Height = 21
        Caption = 'Gerar coleta para a devolu'#231#227'o?'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object btnConfirma: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 111
        Height = 25
        Align = alLeft
        Caption = '[ F10 ] Fechamento'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnCancelarEntrada: TBitBtnLocked
        Left = 503
        Top = 2
        Width = 111
        Height = 25
        Align = alRight
        Caption = '[ Esc ] Cancelar'
        TabOrder = 3
        OnClick = btnCancelarEntradaClick
      end
      object btnDevTotal: TBitBtnLocked
        Left = 113
        Top = 2
        Width = 142
        Height = 25
        Align = alLeft
        Caption = '[ F6 ] Devolu'#231#227'o Total'
        Enabled = False
        TabOrder = 1
        OnClick = btnDevTotalClick
      end
    end
    object pnlProdutos: TPanel
      Left = 1
      Top = 104
      Width = 616
      Height = 202
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object dbgProdutos: TcxGrid
        Left = 1
        Top = 1
        Width = 614
        Height = 200
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgProdutosDBTableView1: TcxGridDBTableView
          OnKeyDown = dbgProdutosDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsProdutos
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.HideSelection = True
          OptionsSelection.InvertSelect = False
          OptionsView.GroupByBox = False
          object dbgProdutosDBTableView1CODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Width = 63
          end
          object dbgProdutosDBTableView1DESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Width = 100
          end
          object dbgProdutosDBTableView1SIGUNI: TcxGridDBColumn
            Caption = 'UN'
            DataBinding.FieldName = 'SIGUNI'
          end
          object dbgProdutosDBTableView1QTDITE: TcxGridDBColumn
            Caption = 'Qtd.'
            DataBinding.FieldName = 'QTDITE'
            Width = 41
          end
          object dbgProdutosDBTableView1DESMOT: TcxGridDBColumn
            Caption = 'Motivo'
            DataBinding.FieldName = 'DESMOT'
            Width = 79
          end
          object dbgProdutosDBTableView1DOCULT: TcxGridDBColumn
            Caption = 'Doc. Selecionado'
            DataBinding.FieldName = 'DOCULT'
            Width = 92
          end
          object dbgProdutosDBTableView1DTAULT: TcxGridDBColumn
            Caption = 'Data Doc. Selec.'
            DataBinding.FieldName = 'DTAULT'
            Width = 92
          end
          object dbgProdutosDBTableView1VENULT: TcxGridDBColumn
            Caption = 'Vendedor Doc. Selec.'
            DataBinding.FieldName = 'VENULT'
            Width = 115
          end
        end
        object dbgProdutosLevel1: TcxGridLevel
          GridView = dbgProdutosDBTableView1
        end
      end
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 168
    Top = 144
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsProdutosAfterScroll
    Left = 200
    Top = 144
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 10
    end
    object cdsProdutosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsProdutosCODMOT: TStringField
      FieldName = 'CODMOT'
      Size = 3
    end
    object cdsProdutosDESMOT: TStringField
      FieldName = 'DESMOT'
      Size = 40
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsProdutosSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsProdutosDOCULT: TStringField
      FieldName = 'DOCULT'
      Size = 15
    end
    object cdsProdutosDTAULT: TDateField
      FieldName = 'DTAULT'
    end
    object cdsProdutosVENULT: TStringField
      FieldName = 'VENULT'
      Size = 30
    end
    object cdsProdutosREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsProdutosDESUNI: TStringField
      FieldName = 'DESUNI'
      Size = 15
    end
    object cdsProdutosESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsProdutosNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsProdutosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsProdutosQTDORI: TFloatField
      FieldName = 'QTDORI'
    end
    object cdsProdutosFORCLI: TStringField
      FieldName = 'FORCLI'
      Size = 8
    end
    object cdsProdutosTIP_FC: TStringField
      FieldName = 'TIP_FC'
      Size = 1
    end
    object cdsProdutosSERIE_: TStringField
      FieldName = 'SERIE_'
      Size = 3
    end
    object cdsProdutosUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsProdutosGARANT: TStringField
      FieldName = 'GARANT'
      Size = 1
    end
    object cdsProdutosSEQORI: TStringField
      FieldName = 'SEQORI'
    end
  end
end
