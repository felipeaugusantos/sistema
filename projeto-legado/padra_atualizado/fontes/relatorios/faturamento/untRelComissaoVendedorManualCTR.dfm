inherited frmRelComissaoVendedorManualCTR: TfrmRelComissaoVendedorManualCTR
  Left = 284
  Top = 108
  Width = 480
  Height = 620
  Caption = 'Relat'#243'rio de Comiss'#227'o por Vendedor Manual - Contas a Receber'
  OnDestroy = FormDestroy
  ExplicitWidth = 480
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 549
    Width = 474
    TabOrder = 3
    ExplicitTop = 549
    ExplicitWidth = 474
    inherited FlwBotoes: TFlowPanel
      Width = 393
      ExplicitTop = 2
      ExplicitWidth = 393
      inherited btnImprimir: TBitBtnLocked
        Anchors = [akLeft, akBottom]
      end
      inherited btnConfigurar: TBitBtnLocked
        Anchors = [akLeft, akBottom]
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 395
      ExplicitLeft = 395
    end
  end
  inherited pnlDados: TPanel
    Top = 297
    Width = 474
    Height = 252
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 297
    ExplicitWidth = 474
    ExplicitHeight = 252
    inherited gpbDestino: TGroupBox
      Left = 5
      Top = 74
      Width = 136
      Height = 40
      TabOrder = 4
      ExplicitLeft = 5
      ExplicitTop = 74
      ExplicitWidth = 136
      ExplicitHeight = 40
      inherited ColorLabel1: TColorLabel
        Left = 27
        Top = 18
        ExplicitLeft = 27
        ExplicitTop = 18
      end
      inherited edtDestino: TEditFocus
        Left = 6
        Top = 14
        ExplicitLeft = 6
        ExplicitTop = 14
      end
    end
    object rdgTipRel: TRadioGroup
      Left = 121
      Top = 3
      Width = 96
      Height = 71
      Caption = 'Tipo de Relat'#243'rio'
      ItemIndex = 0
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico'
        'Recibo')
      TabOrder = 1
      OnClick = rdgTipRelClick
    end
    object rdgComRes: TRadioGroup
      Left = 141
      Top = 74
      Width = 146
      Height = 40
      Caption = 'Op'#231#227'o Anal'#237'tico'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Completo'
        'Resumido')
      TabOrder = 5
    end
    object grbRecibo: TGroupBox
      Left = 5
      Top = 143
      Width = 455
      Height = 63
      Caption = 'Dados para o Recibo'
      Enabled = False
      TabOrder = 10
      object Label5: TLabel
        Left = 8
        Top = 18
        Width = 42
        Height = 14
        Caption = 'Hist'#243'rico'
      end
      object Label6: TLabel
        Left = 7
        Top = 40
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data do recibo'
      end
      object Label7: TLabel
        Left = 170
        Top = 40
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade vias'
      end
      object edtHisRec: TEditFocus
        Tag = 99
        Left = 56
        Top = 12
        Width = 391
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 80
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaRec: TMaskEditFocus
        Tag = 99
        Left = 83
        Top = 37
        Width = 81
        Height = 22
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtQtdVia: TEditFocus
        Tag = 99
        Left = 254
        Top = 37
        Width = 81
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
        TabOrder = 2
        Text = '2'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
    object rdgTpVendRep: TRadioGroup
      Left = 5
      Top = 3
      Width = 116
      Height = 71
      Caption = 'Tipo de Vendedor'
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Interno'
        'Repr. Ext. Loja'
        'Repr. Ext. Distrib.')
      TabOrder = 0
    end
    object rdgPerCom: TRadioGroup
      Left = 217
      Top = 3
      Width = 127
      Height = 71
      Caption = 'Utilizar % de comiss'#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Calculado na venda'
        'Cad. de operadores')
      TabOrder = 2
    end
    object chkConJur: TCheckBox
      Left = 5
      Top = 114
      Width = 161
      Height = 27
      Caption = 'Considerar juros cobrado para c'#225'lculo da comiss'#227'o?'
      Checked = True
      State = cbChecked
      TabOrder = 7
      WordWrap = True
    end
    object chkResumo: TCheckBox
      Left = 290
      Top = 109
      Width = 183
      Height = 40
      Caption = 'Imprimir resumo por vendedor e modalidade de recebimento'
      TabOrder = 9
      WordWrap = True
    end
    object rdgStatus: TRadioGroup
      Left = 287
      Top = 74
      Width = 173
      Height = 40
      Caption = 'Status Vendedor'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 6
    end
    object chkQueGer: TCheckBox
      Left = 157
      Top = 114
      Width = 132
      Height = 30
      Caption = 'Quebrar por Gerente'
      Enabled = False
      TabOrder = 8
      WordWrap = True
    end
    object pnlServico: TPanel
      Left = 0
      Top = 211
      Width = 474
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      object rdgServicos: TRadioGroup
        Left = 5
        Top = -1
        Width = 455
        Height = 33
        Caption = 'Notas de Servi'#231'os'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Somente Notas de Servi'#231'o'
          'Exceto Notas de Servi'#231'o'
          'Todas as Notas Fiscais')
        TabOrder = 0
      end
    end
    object rdgPosCom: TRadioGroup
      Left = 344
      Top = 3
      Width = 116
      Height = 71
      Caption = 'Posi'#231#227'o da Comiss'#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Todas'
        'Pendentes'
        'Baixadas')
      TabOrder = 3
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 474
    Height = 213
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 81
      Top = 2
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 77
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblVendedor: TLabel
      Left = 8
      Top = 121
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpVen: TShape
      Left = 89
      Top = 118
      Width = 5
      Height = 21
    end
    object lblOpcVen: TLabel
      Left = 8
      Top = 37
      Width = 97
      Height = 14
      Caption = 'Op'#231#227'o de Vendedor'
    end
    object lblDepartamento: TLabel
      Left = 8
      Top = 143
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento'
    end
    object lbl1: TLabel
      Left = 8
      Top = 99
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Gerente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpGer: TShape
      Left = 89
      Top = 97
      Width = 5
      Height = 21
    end
    object lbl2: TLabel
      Left = 8
      Top = 165
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object lbl3: TLabel
      Left = 8
      Top = 187
      Width = 67
      Height = 14
      Caption = 'Cliente Excluir'
    end
    object Label4: TLabel
      Left = 177
      Top = 2
      Width = 66
      Height = 14
      Caption = 'Data do Corte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 16
      Width = 70
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
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
      Left = 81
      Top = 16
      Width = 71
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      OnExit = mskDtaFinExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 89
      Top = 74
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 5
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
    object edtDesEmpresa: TEditFocus
      Left = 156
      Top = 74
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 97
      Top = 118
      Width = 57
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
      TabOrder = 9
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 156
      Top = 118
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgRelEmp: TRadioGroup
      Left = 247
      Top = 37
      Width = 215
      Height = 36
      Caption = 'Relacionar a Empresa com'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Movimenta'#231#227'o'
        'Vendedor')
      TabOrder = 4
    end
    object cbxVenRep: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 51
      Width = 232
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 0
      TabOrder = 3
      Text = '1- Vendedor'
      Items.Strings = (
        '1- Vendedor'
        '2- Participante 1'
        '3- Projetista 1'
        '4- Participante 2'
        '5- Projetista 2')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 89
      Top = 140
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 11
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
      Left = 156
      Top = 140
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGerente: TEditFocus
      Tag = 99
      Left = 97
      Top = 96
      Width = 57
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
      TabOrder = 7
      OnKeyPress = edtCodGerenteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGerente: TEditFocus
      Left = 156
      Top = 96
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 89
      Top = 162
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 13
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
    object edtDesCli: TEditFocus
      Left = 156
      Top = 162
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliExc: TEditFocus
      Tag = 99
      Left = 89
      Top = 184
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 15
      OnExit = edtCliExcExit
      OnKeyPress = edtCliExcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesExc: TEditFocus
      Left = 156
      Top = 184
      Width = 306
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaCor: TMaskEditFocus
      Tag = 99
      Left = 177
      Top = 16
      Width = 72
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pnlGerCom: TPanel [4]
    Left = 0
    Top = 213
    Width = 474
    Height = 84
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object gpbGravaComi: TGroupBox
      Left = 5
      Top = 0
      Width = 455
      Height = 79
      Caption = 'Gravar Contas a Pagar'
      TabOrder = 0
      object TLabel
        Left = 7
        Top = 56
        Width = 81
        Height = 14
        Caption = 'Data Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkGraCom: TCheckBox
        Left = 7
        Top = 15
        Width = 264
        Height = 17
        Caption = 'Gravar contas a pagar referente a comiss'#227'o'
        TabOrder = 0
        OnClick = chkGraComClick
      end
      object mskDtaVen: TMaskEditFocus
        Tag = 99
        Left = 94
        Top = 53
        Width = 70
        Height = 22
        Enabled = False
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 5
        Top = 30
        Width = 446
        Height = 22
        TabOrder = 1
        ExplicitLeft = 5
        ExplicitTop = 30
        ExplicitWidth = 446
        inherited lblPlaContas: TLabel
          Left = 1
          Width = 81
          Height = 14
          ExplicitLeft = 1
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 147
          Width = 297
          Height = 22
          ExplicitLeft = 147
          ExplicitWidth = 297
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 89
          Width = 57
          Height = 22
          Enabled = False
          ExplicitLeft = 89
          ExplicitWidth = 57
          ExplicitHeight = 22
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 575
    Width = 474
    TabOrder = 4
    ExplicitTop = 575
    ExplicitWidth = 474
    inherited pnlNomeForm: TPanel
      Left = 303
      TabOrder = 1
      ExplicitLeft = 303
    end
    inherited pnlInfo: TPanel
      Width = 303
      TabOrder = 0
      ExplicitWidth = 303
      inherited shpMultSel: TShape
        Left = 201
        ExplicitLeft = 201
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 528
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 592
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 560
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 528
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 688
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 656
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 592
  end
  inherited frxGen: TfrxUserDataSet
    Left = 624
  end
  inherited frxDesigner: TfrxDesigner
    Left = 656
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 688
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 104
  end
  object frxComVenCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40345.575240879640000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure mmoTotVenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComVenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalVendedor(rllValComVen.Text);  '
      'end;'
      ''
      'procedure DMPMemo6OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      '                             '
      'end.')
    OnUserFunction = frxComVenCTR_MUserFunction
    Left = 544
    Top = 208
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      BottomMargin = 4.497913761764029000
      OnBeforePrint = 'PComissaoOnBeforePrint'
      FontStyle = []
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1526.399999985190000000
        Child = frxComVenCTR_M.CHeader
        Condition = 'frxRelatorio."CTR_CODVEN"'
        ReprintOnNewPage = True
        object DMPCommand5: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1526.399999985190000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo6OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComAna: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          TruncOutboundText = False
        end
        object rllPerComAna: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 425.000000000000000000
        Width = 1526.399999985190000000
        Child = frxComVenCTR_M.CRecibo
        object Memo1: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object mmoTotVen: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'mmoTotVenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object rllValComVen: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllValComVenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 480.000000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [VENDEDOR]: ')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComVen: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 544.000000000000000000
        Width = 1526.399999985190000000
        Child = frxComVenCTR_M.CResumo
        object DMPMemo27: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1526.399999985190000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 493.000000000000000000
        Width = 1526.399999985190000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        AllowSplit = True
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComVenCTR_M.Page1
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 306.000000000000000000
        Width = 1526.399999985190000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object mmoVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 825.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]: [frxRelatorio."VENDEDOR"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DT REC.')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLIC.ORIGINAL')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL ORI')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTOS')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL REC')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A/P')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.399999985190000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComVenCTR_M.CPageHeader
        PrintChildIfInvisible = True
        object DMPMemo24: TfrxDMPMemoView
          Align = baCenter
          Left = 316.800000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand6: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#77'
        end
        object DMPMemo42: TfrxDMPMemoView
          Align = baCenter
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Align = baCenter
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER'
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPO]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 102.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 1372.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 153.000000000000000000
          Width = 1372.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1526.399999985190000000
        object rllPaginaAux: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
        object DMPCommand7: TfrxDMPCommand
          Left = 1267.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1526.399999985190000000
        object Subreport2: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComVenCTR_M.Page2
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.399999985190000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo25: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 408.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = -115.200000000000000000
          Top = 272.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 136.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 442.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 467.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.399999985190000000
        object DMPMemo21: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1526.399999985190000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object DMPMemo39: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1526.399999985190000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.399999985190000000
        object DMPMemo54: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxCabecalho: TfrxUserDataSet
    UserName = 'frxCabecalho'
    Fields.Strings = (
      'EMPRESA'
      'VENDEDOR'
      'PERIODO'
      'intVenDig')
    OnGetValue = frxCabecalhoGetValue
    Left = 560
    Top = 72
  end
  object frxComVenCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40344.510356076390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure mmoTotVenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComVenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalVendedor(rllValComVen.Text);  '
      'end;'
      ''
      'procedure Memo16OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComVenCTR_MUserFunction
    Left = 544
    Top = 160
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      PaperWidth = 240.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 298.582870000000000000
        Width = 869.291900000000000000
        Child = frxComVenCTR_J.CHeader
        Condition = 'frxRelatorio."CTR_CODVEN"'
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 869.291900000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Align = baClient
          Width = 869.291900000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 26.456710000000000000
          Top = 1.779530000000000000
          Width = 46.866141732283460000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 78.481880000000000000
          Top = 1.779530000000000000
          Width = 156.850440080000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 238.497650000000000000
          Top = 1.779530000000000000
          Width = 145.511845200000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'Memo16OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 387.000065910000000000
          Top = 1.779530000000000000
          Width = 93.278540000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 481.511845200000000000
          Top = 1.779530000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 549.543341260000000000
          Top = 1.779530000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 610.699010000000000000
          Top = 1.779530000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 671.244128660000000000
          Top = 1.779530000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllValComAna: TfrxMemoView
          Left = 743.206060000000000000
          Top = 1.779530000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 1.779530000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          ParentFont = False
        end
        object rllPerComAna: TfrxMemoView
          Left = 807.039890000000000000
          Top = 1.779530000000000000
          Width = 50.645640000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          ParentFont = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 430.866420000000000000
        Width = 869.291900000000000000
        Child = frxComVenCTR_J.CRecibo
        object Memo22: TfrxMemoView
          Left = 553.351020000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoValDes: TfrxMemoView
          Left = 614.478540000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoTotVen: TfrxMemoView
          Left = 674.842300000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          OnAfterData = 'mmoTotVenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object rllValComVen: TfrxMemoView
          Left = 746.867470000000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          OnAfterData = 'rllValComVenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 860.598493540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 485.207730000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 208.385685200000000000
          Top = 1.000000000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [VENDEDOR] : ')
          ParentFont = False
        end
        object rllPerComVen: TfrxMemoView
          Left = 812.598950000000000000
          Top = 1.000000000000000000
          Width = 50.645640000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.251968500000000000
        Top = 555.590910000000000000
        Width = 869.291900000000000000
        Child = frxComVenCTR_J.CResumo
        object Memo27: TfrxMemoView
          Left = 485.207730000000000000
          Top = 2.779530000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 553.351020000000000000
          Top = 2.779530000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 614.478540000000000000
          Top = 2.779530000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 674.842300000000000000
          Top = 2.779530000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 746.867470000000000000
          Top = 2.779530000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 208.385685200000000000
          Top = 3.559060000000000000
          Width = 272.126160000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 864.378023540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Left = 864.583180000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllPerComTot: TfrxMemoView
          Left = 812.598950000000000000
          Top = 2.779530000000000000
          Width = 50.645640000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 684.094930000000000000
        Width = 869.291900000000000000
        object Memo1: TfrxMemoView
          Left = 456.717810000000000000
          Top = 4.000000000000000000
          Width = 407.206370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 177.637910000000000000
        Top = 18.897650000000000000
        Width = 869.291900000000000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComVenCTR_J.CPageHeader
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 219.931170000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 751.899010000000000000
          Top = 37.795300000000000000
          Width = 109.984230000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 809.499010000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 673.436240000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 306.406680000000000000
          Top = 54.779529999999990000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoVENDEDOR: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 503.166050000000000000
          Top = 78.338590000000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 182.097960000000000000
          Top = 36.897650000000000000
          Width = 505.095980000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.889763780000000000
          Top = 174.944960000000000000
          Width = 861.732840000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 96.769016670000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 503.166050000000000000
          Top = 96.769016670000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 7.559060000000000000
          Top = 115.944960000000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 503.166050000000000000
          Top = 115.944960000000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[GERENTE]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 7.559060000000000000
          Top = 136.063080000000000000
          Width = 736.478850000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 736.478850000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 476.220780000000000000
        Width = 869.291900000000000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        AllowSplit = True
        Stretched = True
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComVenCTR_J.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 219.212740000000000000
        Width = 869.291900000000000000
        object rllPaginaAux: TfrxMemoView
          Left = 718.110700000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 325.039580000000000000
        Width = 869.291900000000000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object Memo35: TfrxMemoView
          Left = 3.875510000000000000
          Top = 2.779530000000022000
          Width = 518.400000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Top = 20.559060000000000000
          Width = 865.512370000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 26.456692910000000000
          Top = 22.559060000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEB.')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 78.440944880000000000
          Top = 22.559060000000000000
          Width = 127.974830000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 238.574803150000000000
          Top = 22.559060000000000000
          Width = 146.570130000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUP. ORIGINAL')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 387.000065910000000000
          Top = 22.559060000000000000
          Width = 52.081880000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 481.511845200000000000
          Top = 22.559060000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. ORI.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 549.543341260000000000
          Top = 22.559060000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 610.699010000000000000
          Top = 22.559060000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCON.')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 671.244128660000000000
          Top = 22.559060000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. REC.')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 743.206060000000000000
          Top = 22.559060000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1.000000000000000000
          Top = 22.338589999999950000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A/P')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 807.039890000000000000
          Top = 22.559060000000000000
          Width = 54.425189530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 642.520100000000000000
        Width = 869.291900000000000000
        object Subreport2: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComVenCTR_J.Page2
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 240.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.220780000000000000
        Top = 64.252010000000000000
        Width = 869.291900000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Left = 55.000000000000000000
          Top = 8.000000000000000000
          Width = 755.906000000000000000
          Height = 408.189240000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 330.905690000000000000
          Top = 340.598640000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 77.677180000000000000
          Top = 393.512060000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxUser."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 70.118120000000000000
          Top = 220.724490000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 85.236240000000000000
          Top = 57.133889999999990000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 81.456710000000000000
          Top = 113.826840000000000000
          Width = 702.992580000000000000
          Height = 90.708720000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 55.000000000000000000
          Top = 8.000000000000000000
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 869.291900000000000000
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 240.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 132.283550000000000000
        Width = 869.291900000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 622.866538390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 530.645703460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 443.716572050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 353.007910630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 153.448855510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 68.031540000000000000
        Width = 869.291900000000000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object Memo59: TfrxMemoView
          Left = 622.173588390000000000
          Width = 93.354330708661410000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 153.448981220000000000
          Top = 17.007874020000000000
          Width = 562.393937560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 529.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 443.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 352.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 152.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 173.858380000000000000
        Width = 869.291900000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo60: TfrxMemoView
          Left = 622.866538390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 530.645703460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 443.716572050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 353.007910630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 153.448855510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 869.291900000000000000
        object Memo6: TfrxMemoView
          Left = 153.448981220000000000
          Width = 562.393937560000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComVenSintCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41138.695582129600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 544
    Top = 320
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object RTComissao: TfrxReportTitle
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1238.400000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object frxCabecalhoPERIODO: TfrxDMPMemoView
          Align = baCenter
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object frxCabecalhoVENDEDOR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          TruncOutboundText = False
        end
        object frxCabecalhoEMPRESA: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object mmoTitRel: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object rllTipo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPO]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 102.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 119.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[GERENTE]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 493.000000000000000000
        Width = 1238.400000000000000000
        Child = frxComVenSintCTR_M.CResumo
        object DMPMemo30: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral : ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerCo2Tot: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object HeaderSintetico: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Width = 1238.400000000000000000
        ReprintOnNewPage = True
        object DMPMemo12: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.c/Imp')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object mmoVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.(A.V)')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.(A.P)')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.s/Imp')
          TruncOutboundText = False
        end
        object rllPerCo2Tit: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1238.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo5: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComVen: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_AVISTA"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_APRAZO"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALFAT"]')
          TruncOutboundText = False
        end
        object frxCabecalhofltTotAbe: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          TruncOutboundText = False
        end
        object rllPerComVen: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          TruncOutboundText = False
        end
        object rllPerCo2Ven: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          TruncOutboundText = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 1238.400000000000000000
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComVenSintCTR_M.Page1
        end
      end
      object rlbQuebra: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 289.000000000000000000
        Width = 1238.400000000000000000
        Condition = 'frxRelatorio."CODGER"'
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1219.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'GERENTE: [frxRelatorio."CODGER"]-[frxRelatorio."NOMGER"]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
      end
      object rlbGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1238.400000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Child = frxComVenSintCTR_M.rlbGrupoChild
        Stretched = True
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot2: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Total (Comiss'#227'o Vendedor): ')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerComTot2: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CTR_RECCOM">,0,0))' +
              ' * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerCo2Tot2: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CTR_RECCOM">,0,0))' +
              ' * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object rlbGrupoChild: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 442.000000000000000000
        Width = 1238.400000000000000000
        object rllValComGer: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxRelatorio."CTR_RECIPI">,0,0) * <frxRelatorio."PERGER">' +
              ')/100]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Total (Comiss'#227'o Gerente): ')
          TruncOutboundText = False
        end
        object rllPerComGer: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERGER"]')
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo9: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1238.400000000000000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object DMPMemo39: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1238.400000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo54: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxComVenSintCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41138.485024768510000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 544
    Top = 272
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.157700000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Width = 755.906000000000000000
          Height = 17.007874015748000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 381.732283460000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          ParentFont = False
        end
        object rllValComVen: TfrxMemoView
          Left = 451.520840000000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 1.889763780000000000
          Width = 162.519685040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 583.937007870000000000
          Top = 1.889763780000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_AVISTA"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 689.606299210000000000
          Top = 1.889763780000000000
          Width = 66.141732280000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_APRAZO"]')
          ParentFont = False
        end
        object frxGenfltValFat: TfrxMemoView
          Left = 162.519685040000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 13.228346460000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALFAT"]')
          ParentFont = False
        end
        object frxCabecalhofltTotAbe: TfrxMemoView
          Left = 236.220479760000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPerComVen: TfrxMemoView
          Left = 525.354330710000000000
          Top = 1.889763780000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 311.811030940000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllPerCo2Ven: TfrxMemoView
          Left = 646.299212600000000000
          Top = 1.889763780000000000
          Width = 43.464566930000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.251968500000000000
        Top = 502.677490000000000000
        Width = 755.906000000000000000
        Child = frxComVenSintCTR_J.CResumo
        object Memo30: TfrxMemoView
          Left = 381.732283460000000000
          Top = 7.559055120000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 451.520840000000000000
          Top = 7.559055120000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Top = 7.559055120000000000
          Width = 162.519685040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral: ')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 583.937007870000000000
          Top = 7.559055120000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 689.606299210000000000
          Top = 7.559055120000000000
          Width = 66.141732280000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 162.519685040000000000
          Top = 7.559055120000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 236.220479760000000000
          Top = 7.559055120000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          ParentFont = False
        end
        object rllPerComTot: TfrxMemoView
          Left = 525.354330710000000000
          Top = 7.559055120000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 3.559059999999990000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 25.677180000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo22: TfrxMemoView
          Left = 311.811030940000000000
          Top = 7.559055120000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllPerCo2Tot: TfrxMemoView
          Left = 646.299212600000000000
          Top = 7.559055120000000000
          Width = 43.464566930000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 631.181510000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          Left = 456.717810000000000000
          Top = 4.000000000000060000
          Width = 293.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 257.008040000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          Width = 755.906000000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object mmoVendedor: TfrxMemoView
          Top = 1.889763780000000000
          Width = 162.519685040000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 381.732283460000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. s/ Imp.')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 451.520840000000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 583.937007870000000000
          Top = 1.889763780000000000
          Width = 62.362204720000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.(A.V)')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 689.606299210000000000
          Top = 1.889763780000000000
          Width = 66.141732280000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.(A.P)')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 162.519685040000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 236.220479760000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 525.354330710000000000
          Top = 1.889763780000000000
          Width = 58.582677170000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 311.811030940000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. c/ Imp.')
          ParentFont = False
        end
        object rllPerCo2Tit: TfrxMemoView
          Left = 646.299212600000000000
          Top = 1.889763780000000000
          Width = 43.464566930000000000
          Height = 15.118107800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 177.637910000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 163.238220000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 627.174520000000000000
          Top = 37.795300000000000000
          Width = 117.543290000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 692.333580000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 556.270810000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 249.713730000000000000
          Top = 54.779530000000000000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoVENDEDOR: TfrxMemoView
          Left = 7.559055120000000000
          Top = 78.440940000000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 385.889756460000000000
          Top = 78.338590000000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 134.853835000000000000
          Top = 36.897650000000000000
          Width = 486.198330000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.889763780000000000
          Top = 173.842610000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559055120000000000
          Top = 96.769016670000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPO]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 385.889756460000000000
          Top = 96.769016670000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 7.559055120000000000
          Top = 115.944960000000000000
          Width = 373.643970000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 385.889756460000000000
          Top = 115.944960000000000000
          Width = 358.525850000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[GERENTE]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 7.559060000000000000
          Top = 136.063080000000000000
          Width = 736.478850000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 736.478850000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 589.606680000000000000
        Width = 755.906000000000000000
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComVenSintCTR_J.Page1
        end
      end
      object rlbQuebra: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 298.582870000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."CODGER"'
        object Memo51: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Width = 755.905633860000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'GERENTE: [frxRelatorio."CODGER"]-[frxRelatorio."NOMGER"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 381.732530000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'GroupFooterVendedorOnBeforePrint'
        Child = frxComVenSintCTR_J.rlbGrupoChild
        object Memo46: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 381.732283460000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          ParentFont = False
        end
        object rllValComTot2: TfrxMemoView
          Left = 451.520840000000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Top = 1.889763780000000000
          Width = 162.519685040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total (Comiss'#227'o Vendedores):')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 583.937007870000000000
          Top = 1.889763780000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 689.606299210000000000
          Top = 1.889763780000000000
          Width = 66.141732280000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 162.519685040000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 236.220479760000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          ParentFont = False
        end
        object rllPerComTot2: TfrxMemoView
          Left = 525.354330710000000000
          Top = 1.889763780000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 311.811030940000000000
          Top = 1.889763780000000000
          Width = 69.921259840000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllPerCo2Tot2: TfrxMemoView
          Left = 646.299212600000000000
          Top = 1.889763780000000000
          Width = 43.464566930000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object rlbGrupoChild: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 423.307360000000000000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object rllValComGer: TfrxMemoView
          Left = 451.520840000000000000
          Top = 1.889763780000000000
          Width = 73.700787400000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxRelatorio."CTR_RECIPI">,0,0) * <frxRelatorio."PERGER">' +
              ')/100]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Top = 1.889763780000000000
          Width = 162.519685040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total (Comiss'#227'o Gerente):')
          ParentFont = False
        end
        object rllPerComGer: TfrxMemoView
          Left = 525.354330710000000000
          Top = 1.889763780000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERGER"]')
          ParentFont = False
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 132.283550000000000000
        Width = 755.906000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo18: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 68.031540000000000000
        Width = 755.906000000000000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object Memo59: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Align = baCenter
          Left = 96.756031220000000000
          Top = 17.007874020000000000
          Width = 562.393937560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 173.858380000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo60: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo31: TfrxMemoView
          Align = baCenter
          Left = 96.756031220000000000
          Width = 562.393937560000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComVenCTRP_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40343.689554213000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;'
      '  PageHeader.Visible  := False;      '
      'end;'
      '  '
      'procedure CAfterReciboOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' PageHeader.Visible  := True;  '
      'end;'
      ''
      'procedure rllValComVenOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalVendedor(rllValComVen.Text);  '
      'end;'
      ''
      'procedure Memo16OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComVenCTR_MUserFunction
    Left = 544
    Top = 384
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 298.582870000000000000
        Width = 1084.725110000000000000
        Child = frxComVenCTRP_J.CHeader
        Condition = 'frxRelatorio."CTR_CODVEN"'
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 1084.725110000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Top = 1.220470000000000000
          Width = 1084.725110000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 77.267780000000000000
          Top = 1.000000000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 128.056710000000000000
          Top = 1.000000000000000000
          Width = 141.732283464566900000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 275.206370000000000000
          Top = 1.000000000000000000
          Width = 141.732283464566900000
          Height = 13.220470000000000000
          OnBeforePrint = 'Memo16OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 420.817440000000000000
          Top = 1.000000000000000000
          Width = 204.094439370000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 630.803093460000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 698.834589530000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 760.062935980000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 818.196786930000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllValComAna: TfrxMemoView
          Left = 953.417303310000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 1.000000000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          ParentFont = False
        end
        object rllPerComAna: TfrxMemoView
          Left = 1017.070849060000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 1.000000000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 886.410020000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          ParentFont = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 430.866420000000000000
        Width = 1084.725110000000000000
        Child = frxComVenCTRP_J.CRecibo
        object Memo22: TfrxMemoView
          Left = 698.834589530000000000
          Top = 2.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 760.062935980000000000
          Top = 2.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoTotVen: TfrxMemoView
          Left = 818.267672600000000000
          Top = 2.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object rllValComVen: TfrxMemoView
          Left = 953.574803150000000000
          Top = 2.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          OnAfterPrint = 'rllValComVenOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 18.500000000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 630.803093460000000000
          Top = 2.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 352.007825200000000000
          Top = 1.000000000000000000
          Width = 272.957480310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [VENDEDOR] : ')
          ParentFont = False
        end
        object rllPerComVen: TfrxMemoView
          Left = 1017.070849060000000000
          Top = 2.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 886.299256540000000000
          Top = 1.889763780000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,MDComissao,0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.251968500000000000
        Top = 593.386210000000000000
        Width = 1084.725110000000000000
        Child = frxComVenCTRP_J.CResumo
        object Memo27: TfrxMemoView
          Left = 630.803093460000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 698.834589530000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 760.062935980000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 818.267716540000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 953.574803149606300000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 352.007825200000000000
          Top = 0.779530000000000000
          Width = 272.957480310000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          ParentFont = False
        end
        object rllPerComTot: TfrxMemoView
          Left = 1017.070849060000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo64: TfrxMemoView
          Left = 886.299212600000000000
          Top = 1.133858270000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          ParentFont = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 725.669760000000000000
        Width = 1084.725110000000000000
        object Memo1: TfrxMemoView
          Left = 789.316450000000000000
          Top = 4.000000000000000000
          Width = 293.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 786.142240000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 177.637910000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComVenCTRP_J.CPageHeader
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 327.647775000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 937.095980000000000000
          Top = 37.795300000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 1028.711750000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 892.648980000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 414.123285000000000000
          Top = 54.779529999999990000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoVENDEDOR: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 532.384230000000000000
          Height = 17.007874020000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 544.740880000000000000
          Top = 78.338590000000000000
          Width = 536.163760000000000000
          Height = 17.007874020000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 151.861720000000000000
          Top = 36.897650000000000000
          Width = 781.001670000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER'
            '')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 173.944960000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 96.769016660000000000
          Width = 532.384230000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 544.740880000000000000
          Top = 96.769016660000000000
          Width = 536.163760000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 115.944960000000000000
          Width = 532.384230000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 544.740880000000000000
          Top = 115.944960000000000000
          Width = 536.163760000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[GERENTE]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 7.559060000000000000
          Top = 136.063080000000000000
          Width = 1072.857020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 1072.857020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 476.220780000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        Child = frxComVenCTRP_J.CAfterRecibo
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComVenCTRP_J.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 219.212740000000000000
        Width = 1084.725110000000000000
        object rllPaginaAux: TfrxMemoView
          Left = 937.323440000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 325.039580000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object Memo35: TfrxMemoView
          Left = 3.875510000000000000
          Top = 2.779530000000022000
          Width = 518.400000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Top = 22.677180000000000000
          Width = 1084.725110000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 77.267762910000000000
          Top = 24.677180000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEB.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 128.015774880000000000
          Top = 24.677180000000000000
          Width = 63.722820000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 275.283523150000000000
          Top = 24.677180000000000000
          Width = 89.877180000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUP. ORIGINAL')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 420.693015910000000000
          Top = 24.677180000000000000
          Width = 123.892950000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 630.913515200000000000
          Top = 24.677180000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. ORI.')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 698.945011260000000000
          Top = 24.677180000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 760.100680000000000000
          Top = 24.677180000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCON.')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 818.307208660000000000
          Top = 24.677180000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. REC.')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 953.300680000000000000
          Top = 24.677180000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 1.000000000000000000
          Top = 24.456709999999990000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A/P')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 1016.914040000000000000
          Top = 24.677180000000020000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 26.456710000000000000
          Top = 24.677180000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADAST.')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 886.410020000000000000
          Top = 24.566929130000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. s/Imp.')
          ParentFont = False
        end
      end
      object CAfterRecibo: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 517.795610000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'CAfterReciboOnAfterPrint'
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 680.315400000000000000
        Width = 1084.725110000000000000
        object Subreport2: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComVenCTRP_J.Page2
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.220780000000000000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Width = 755.906000000000000000
          Height = 408.189240000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 275.905690000000000000
          Top = 332.598640000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 22.677180000000000000
          Top = 385.512060000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxUser."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 15.118120000000000000
          Top = 212.724490000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 49.133889999999990000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 26.456710000000000000
          Top = 105.826840000000000000
          Width = 702.992580000000000000
          Height = 90.708720000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 136.063080000000000000
        Width = 1084.725110000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo7: TfrxMemoView
          Left = 261.165354330000000000
          Width = 195.779527560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 456.566926690000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 551.055118110000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 641.763779530000000000
          Width = 85.417320390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 44.598425200000000000
        Top = 68.031540000000010000
        Width = 1084.725110000000000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object Memo8: TfrxMemoView
          Left = 261.165586220000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 261.165354330000000000
          Top = 15.897650000000000000
          Width = 566.173467560000000000
          Height = 28.724409450000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 460.346456690000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 547.275588110000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 637.984249530000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 177.637910000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo10: TfrxMemoView
          Left = 261.165354330709000000
          Width = 195.779527560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 456.566926690000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 547.275588110000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 637.984249530000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 24.566929130000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Memo4: TfrxMemoView
          Left = 261.165586220000000000
          Width = 566.173467560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComVenCTRP_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40343.690159317100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComVenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalVendedor(rllValComVen.Text);  '
      'end;'
      ''
      'procedure DMPMemo6OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComVenCTR_MUserFunction
    Left = 544
    Top = 432
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComVenCTRP_M.CHeader
        Condition = 'frxRelatorio."CTR_CODVEN"'
        ReprintOnNewPage = True
        object DMPCommand6: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo6OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComAna: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          TruncOutboundText = False
        end
        object rllPerComAna: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          TruncOutboundText = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComVenCTRP_M.CRecibo
        object Memo1: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object mmoTotVen: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object rllValComVen: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllValComVenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [VENDEDOR]: ')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComVen: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,MDComissao,0)]')
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 527.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComVenCTRP_M.CResumo
        object DMPMemo27: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 646.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 476.000000000000000000
        Width = 1526.400000000000000000
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComVenCTRP_M.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1526.400000000000000000
        object rllPaginaAux: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object DMPCommand7: TfrxDMPCommand
          Left = 1507.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComVenCTRP_M.CPageHeader
        object DMPMemo41: TfrxDMPMemoView
          Align = baCenter
          Left = 316.800000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
        object DMPMemo52: TfrxDMPMemoView
          Align = baCenter
          Left = 556.799999999999900000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Align = baCenter
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [VENDEDOR] - CONTAS A RECEBER')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[GERENTE]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 306.000000000000000000
        Width = 1526.400000000000000000
        object mmoVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVendedorOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]: [frxRelatorio."VENDEDOR"]')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA CAD.')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLIC.ORIGINAL')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL ORI')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTOS')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL REC')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A/P')
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA REC.')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.s/Imp')
          TruncOutboundText = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 612.000000000000000000
        Width = 1526.400000000000000000
        object Subreport2: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComVenCTRP_M.Page2
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo31: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 408.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = -115.200000000000000000
          Top = 272.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 136.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 442.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 467.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo3: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR VENDEDOR E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1526.400000000000000000
        Condition = 'frxResumo."RMO_NOMVEN"'
        object DMPMemo4: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDEDOR: [frxResumo."RMO_NOMVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo34: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO VENDEDOR:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxUser: TfrxUserDataSet
    UserName = 'frxUser'
    OnCheckEOF = frxUserCheckEOF
    OnFirst = frxUserFirst
    OnNext = frxUserNext
    OnPrior = frxUserPrior
    Fields.Strings = (
      'DTAREC'
      'VALREC'
      'NOMREC'
      'NOMASS'
      'HISREC'
      'CIDREC'
      'NROVIA'
      'VLREXT')
    OnGetValue = frxUserGetValue
    Left = 528
    Top = 72
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    ProviderName = 'dspRelatorio'
    Left = 624
    Top = 104
  end
  object dspRelatorio: TUniDataSetProvider
    DataSet = frmModuloSPR.qryRelatorio
    Options = []
    Left = 592
    Top = 104
  end
  object frxResumo: TfrxDBDataset
    Description = 'Dados do resumo'
    UserName = 'frxResumo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 560
    Top = 104
  end
end
