inherited frmOutrasDespesasAposEntrada: TfrmOutrasDespesasAposEntrada
  Width = 1024
  Height = 768
  Caption = 'Digita'#231#227'o de Outras Despesas Ap'#243's Entrada de Mercadoria'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    TabOrder = 2
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnEfetivaOutrasDespesas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 166
        Height = 22
        Caption = '[F10 ] Efetivar Outras Despesas'
        Enabled = False
        TabOrder = 0
        OnClick = btnEfetivaOutrasDespesasClick
      end
      object btnManutencao: TBitBtnLocked
        Left = 166
        Top = 0
        Width = 192
        Height = 22
        Caption = '[ F9 ] Manuten'#231#227'o Outras Despesas'
        Enabled = False
        TabOrder = 1
        OnClick = btnManutencaoClick
      end
      object btnGuardar: TBitBtnLocked
        Left = 358
        Top = 0
        Width = 175
        Height = 22
        Caption = '[ F8 ] Salvar Para Efetivar Depois'
        Enabled = False
        TabOrder = 2
        OnClick = btnGuardarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 3
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
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 58
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 9
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Documento:'
      ParentShowHint = False
      ShowHint = False
    end
    object lblTip_fc: TLabel
      Left = 8
      Top = 33
      Width = 110
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Fornecedor:'
    end
    object Label14: TLabel
      Left = 239
      Top = 9
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label15: TLabel
      Left = 332
      Top = 9
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object edtNomFor: TEditFocus
      Left = 207
      Top = 29
      Width = 282
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 121
      Top = 5
      Width = 112
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtForCli: TEditFocus
      Tag = 99
      Left = 121
      Top = 29
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtForCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 282
      Top = 5
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 362
      Top = 5
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlOutrasDespesas: TPanel [3]
    Left = 0
    Top = 58
    Width = 1018
    Height = 617
    Align = alClient
    TabOrder = 4
  end
  object cxgDados: TcxGridCitel [4]
    Left = 0
    Top = 58
    Width = 1018
    Height = 617
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvDadosCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'VALOUT'
          Column = cxvDadosColumn3
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvDadosColumn1: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        MinWidth = 320
        Width = 321
      end
      object cxvDadosColumn2: TcxGridDBColumn
        AlternateCaption = 'HISTOR'
        Caption = 'Historico'
        DataBinding.FieldName = 'HISTOR'
        PropertiesClassName = 'TcxMemoProperties'
        MinWidth = 312
        Width = 312
      end
      object cxvDadosColumn3: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'VALOUT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 100
        Width = 107
      end
      object cxvDadosColumn4: TcxGridDBColumn
        Caption = 'Origem'
        DataBinding.FieldName = 'ORIGEM'
        MinWidth = 164
        Width = 164
      end
      object cxvDadosColumn5: TcxGridDBColumn
        Caption = 'Efetivado'
        DataBinding.FieldName = 'EFETIV'
        MinWidth = 52
        Width = 52
      end
      object cxvdadosOUT_EFETIV: TcxGridDBColumn
        DataBinding.FieldName = 'OUT_EFETIV'
        Visible = False
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 675
    Width = 1018
    Height = 20
    Align = alBottom
    ParentColor = True
    TabOrder = 5
    object Shape1: TShape
      Left = 8
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
    object Label2: TLabel
      Left = 23
      Top = 3
      Width = 162
      Height = 14
      Caption = 'Efetivado - Registro j'#225' foi lan'#231'ado'
    end
    object Shape2: TShape
      Left = 266
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clGreen
    end
    object Label3: TLabel
      Left = 281
      Top = 3
      Width = 362
      Height = 14
      Caption = 
        'Pendente - Registro ainda n'#227'o foi lan'#231'ado  e n'#227'o atualizou dados' +
        ' no Banco'
    end
  end
  object dtsDados: TDataSource
    Left = 576
    Top = 224
  end
end
