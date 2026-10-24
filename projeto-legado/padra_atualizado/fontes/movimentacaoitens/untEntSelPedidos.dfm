inherited frmEntSelPedidos: TfrmEntSelPedidos
  Left = 278
  Top = 227
  Width = 936
  Height = 553
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Pedidos'
  ExplicitWidth = 936
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 472
    Width = 920
    Height = 26
    ExplicitTop = 472
    ExplicitWidth = 920
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 816
      Height = 22
      ExplicitWidth = 816
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMostrarItensPend: TBitBtnLocked
        Left = 100
        Top = 0
        Width = 175
        Height = 22
        Caption = '[ F11 ] Mostrar itens pendentes'
        TabOrder = 1
        OnClick = btnMostrarItensPendClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 818
      Top = 2
      Width = 100
      Align = alRight
      ExplicitLeft = 818
      ExplicitTop = 2
      ExplicitWidth = 100
    end
  end
  inherited pnlStatus: TPanel
    Top = 498
    Width = 920
    ExplicitTop = 498
    ExplicitWidth = 920
    inherited pnlNomeForm: TPanel
      Left = 749
      ExplicitLeft = 749
    end
    inherited pnlInfo: TPanel
      Width = 749
      ExplicitWidth = 749
    end
  end
  inherited pnlHeader: TPanel
    Width = 920
    Height = 32
    Caption = 'SELE'#199#195'O DE PEDIDOS'
    Font.Height = -11
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 920
    ExplicitHeight = 32
  end
  inherited pnlTail: TPanel
    Top = 403
    Width = 920
    Height = 69
    Visible = True
    ExplicitTop = 403
    ExplicitWidth = 920
    ExplicitHeight = 69
    object Panel1: TPanel
      Left = 0
      Top = 1
      Width = 920
      Height = 32
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 6
        Top = 9
        Width = 51
        Height = 14
        Caption = 'Doc. Orig.:'
      end
      object Label5: TLabel
        Left = 212
        Top = 9
        Width = 65
        Height = 14
        Caption = 'Emp. Destino:'
      end
      object lblDtaLib: TLabel
        Left = 350
        Top = 9
        Width = 78
        Height = 14
        Caption = 'Data de Confer.:'
      end
      object lbl1: TLabel
        Left = 590
        Top = 9
        Width = 50
        Height = 14
        Caption = 'CNPJ/CPF:'
      end
      object edtDocOrig: TEditFocus
        Left = 62
        Top = 5
        Width = 131
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtEmpDes: TEditFocus
        Left = 284
        Top = 5
        Width = 51
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
      object edtDtaLib: TEditFocus
        Left = 431
        Top = 5
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCgcCpf: TEditFocus
        Left = 648
        Top = 5
        Width = 137
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    end
    object pnlDadosInformativos: TPanel
      Left = 0
      Top = 33
      Width = 920
      Height = 36
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label6: TLabel
        Left = 6
        Top = 11
        Width = 109
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pedidos Selecionados:'
      end
      object Label21: TLabel
        Left = 653
        Top = 11
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Geral:'
      end
      object Label2: TLabel
        Left = 227
        Top = 11
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Itens:'
      end
      object Label4: TLabel
        Left = 520
        Top = 11
        Width = 38
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total IPI:'
      end
      object Label1: TLabel
        Left = 379
        Top = 11
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Sub.:'
      end
      object edtPedSel: TEditFocus
        Left = 118
        Top = 7
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taCenter
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotIte: TEditFocus
        Left = 284
        Top = 7
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotIpi: TEditFocus
        Left = 563
        Top = 7
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotGer: TEditFocus
        Left = 711
        Top = 7
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotSub: TEditFocus
        Left = 431
        Top = 7
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  inherited pnlPesquisa: TPanel
    Top = 32
    Width = 920
    ExplicitTop = 32
    ExplicitWidth = 920
  end
  inherited dbgConsulta: TcxGridCitel
    Top = 72
    Width = 920
    Height = 331
    ExplicitTop = 72
    ExplicitWidth = 920
    ExplicitHeight = 331
    inherited dbgConsultaDados: TcxGridDBTableViewCitel
      OnCustomDrawCell = dbgConsultaDadosCustomDrawCell
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object dbgConsultaDadosPCG_MARDES: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'PCG_MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'M'
        Properties.ValueUnchecked = 'D'
        Visible = False
        Options.Editing = False
        Width = 34
      end
      object dbgConsultaDadosPCG_NUMPED: TcxGridDBColumn
        Caption = 'No.Ped.'
        DataBinding.FieldName = 'PCG_NUMPED'
        Options.Editing = False
        Width = 90
      end
      object dbgConsultaDadosPCG_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'PCG_CODEMP'
        Options.Editing = False
        Width = 30
      end
      object dbgConsultaDadosPCG_NUMFAT: TcxGridDBColumn
        Caption = 'Nota Fiscal'
        DataBinding.FieldName = 'PCG_NUMFAT'
        Options.Editing = False
        Width = 90
      end
      object dbgConsultaDadosPCG_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Forn.'
        DataBinding.FieldName = 'PCG_CODFOR'
        Options.Editing = False
        Width = 62
      end
      object dbgConsultaDadosFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.Editing = False
        Width = 141
      end
      object dbgConsultaDadosPCG_DTAPED: TcxGridDBColumn
        Caption = 'Dta. Pedido'
        DataBinding.FieldName = 'PCG_DTAPED'
        Options.Editing = False
        Width = 66
      end
      object dbgConsultaDadosPCG_TOTITE: TcxGridDBColumn
        Caption = 'Total Itens'
        DataBinding.FieldName = 'PCG_TOTITE'
        Options.Editing = False
        Width = 62
      end
      object dbgConsultaDadosPCG_TOTSUB: TcxGridDBColumn
        Caption = 'Total Sub.'
        DataBinding.FieldName = 'PCG_TOTSUB'
        Options.Editing = False
        Width = 56
      end
      object dbgConsultaDadosPCG_TOTIPI: TcxGridDBColumn
        Caption = 'Total IPI'
        DataBinding.FieldName = 'PCG_TOTIPI'
        Options.Editing = False
        Width = 51
      end
      object dbgConsultaDadosPCG_TOTFRE: TcxGridDBColumn
        Caption = 'Total Frete'
        DataBinding.FieldName = 'PCG_TOTFRE'
        Options.Editing = False
        Width = 59
      end
      object dbgConsultaDadosPCG_TOTACE: TcxGridDBColumn
        Caption = 'D.Aces.'
        DataBinding.FieldName = 'PCG_TOTACE'
        Options.Editing = False
      end
      object dbgConsultaDadosPCG_TOTGER: TcxGridDBColumn
        Caption = 'Total Geral'
        DataBinding.FieldName = 'PCG_TOTGER'
        Options.Editing = False
        Width = 63
      end
      object dbgConsultaDadosPCG_DTAENT: TcxGridDBColumn
        Caption = 'Dta Entrega'
        DataBinding.FieldName = 'PCG_DTAENT'
        Options.Editing = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 296
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    StoreDefs = True
    AfterPost = cdsConsultaAfterPost
    object cdsConsultaTOTITE: TAggregateField
      FieldName = 'TOT_TOTITE'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MAR_TOTITE)'
    end
    object cdsConsultaTOTGER: TAggregateField
      FieldName = 'TOT_TOTGER'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MAR_TOTGER)'
    end
    object cdsConsultaTOTIPI: TAggregateField
      FieldName = 'TOT_TOTIPI'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MAR_TOTIPI)'
    end
    object cdsConsultaTOTSUB: TAggregateField
      FieldName = 'TOT_TOTSUB'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MAR_TOTSUB)'
    end
  end
end
