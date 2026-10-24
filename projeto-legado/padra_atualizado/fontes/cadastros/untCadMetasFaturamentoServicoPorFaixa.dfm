inherited frmCadMetasFaturamentoServicoPorFaixa: TfrmCadMetasFaturamentoServicoPorFaixa
  Left = 0
  Top = 0
  Width = 1021
  Height = 547
  Caption = 'Cadastro de Metas de Faturamento de Servi'#231'o Por Faixa'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1021
  ExplicitHeight = 547
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 464
    Width = 1005
    TabOrder = 5
    ExplicitTop = 464
    ExplicitWidth = 1005
    inherited FlwBotoes: TFlowPanel
      Width = 1001
      ExplicitWidth = 1001
      object btnConfirmar: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 359
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 3
        OnClick = btnCopiarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1009
      ExplicitLeft = 1009
    end
  end
  inherited pnlHeader: TPanel
    Width = 1005
    Height = 33
    ParentColor = False
    TabOrder = 0
    ExplicitWidth = 1005
    ExplicitHeight = 33
    object Label3: TLabel
      Left = 160
      Top = 10
      Width = 55
      Height = 14
      Caption = 'Empresa: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 3
      Top = 10
      Width = 97
      Height = 14
      Caption = 'Per'#237'odo Atual de: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMesAnoOrigem: TPanel
      Left = 751
      Top = 0
      Width = 254
      Height = 33
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      TabStop = True
      Visible = False
      object Label1: TLabel
        Left = 5
        Top = 10
        Width = 188
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Copiar metas do Per'#237'odo de Origem:'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 196
        Top = 6
        Width = 53
        Height = 22
        EditMask = '99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 261
      Top = 6
      Width = 221
      Height = 21
      Alignment = taLeftJustify
      Enabled = False
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 217
      Top = 6
      Width = 42
      Height = 21
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 6
      Width = 54
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      OnKeyPress = mskDtaAtualKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlTail: TPanel
    Top = 407
    Width = 1005
    Height = 57
    ParentColor = False
    TabOrder = 4
    OnEnter = pnlTailEnter
    OnExit = pnlTailExit
    ExplicitTop = 407
    ExplicitWidth = 1005
    ExplicitHeight = 57
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 113
    Width = 1005
    Height = 294
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MSF_CODOPE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        ReadOnly = True
        Title.Caption = 'Nome do Operador'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_FUNCAO'
        ReadOnly = True
        Title.Caption = 'Fun'#231#227'o'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSF_VLRSER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor do Servi'#231'o'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSF_VLRADI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Adicional'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSF_VLRSPM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Super Meta'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSF_PERSPM'
        Title.Alignment = taRightJustify
        Title.Caption = '% Super Meta'
        Width = 115
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 33
    Width = 1005
    TabOrder = 1
    ExplicitTop = 33
    ExplicitWidth = 1005
    inherited lblPesquisa: TLabel
      Top = 12
      Width = 68
      Height = 13
      ExplicitTop = 12
      ExplicitWidth = 68
      ExplicitHeight = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      Height = 13
      ExplicitTop = 12
      ExplicitHeight = 13
    end
    inherited edtData: TMaskEditFocus
      Height = 21
      ExplicitHeight = 21
    end
    inherited edtNumero: TEditFocus
      Height = 21
      ExplicitHeight = 21
    end
    inherited edtString: TEditFocus
      Height = 21
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 492
    Width = 1005
    TabOrder = 6
    ExplicitTop = 492
    ExplicitWidth = 1005
    inherited pnlNomeForm: TPanel
      Left = 720
      Width = 285
      ExplicitLeft = 720
      ExplicitWidth = 285
    end
    inherited pnlInfo: TPanel
      Width = 720
      ExplicitWidth = 720
    end
  end
  object pnlDadosAdicionais: TPanel [7]
    Left = 0
    Top = 73
    Width = 1005
    Height = 40
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label4: TLabel
      Left = 16
      Top = 9
      Width = 208
      Height = 13
      Caption = 'Valor M'#237'nimo para Pagamento de Adicional: '
    end
    object Label5: TLabel
      Left = 360
      Top = 9
      Width = 235
      Height = 13
      Caption = 'Valor para Meta Adicional Gerebte/Sub-Gerente: '
    end
    object edtValorPagamentoAdicional: TEditFocus
      Left = 224
      Top = 6
      Width = 100
      Height = 21
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
      EditFormat = '#,####0.00'
    end
    object edtValorAdicionalGerenteSubGerente: TEditFocus
      Left = 596
      Top = 6
      Width = 100
      Height = 21
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
      EditFormat = '#,####0.00'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 912
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
    Top = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 360
  end
  inherited qryConsulta: TUniQuery
    Left = 56
    Top = 360
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 88
    Top = 360
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 120
    Top = 360
    object cdsConsultaMSF_CODOPE: TStringField
      FieldName = 'MSF_CODOPE'
    end
    object cdsConsultaOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
    end
    object cdsConsultaOPE_FUNCAO: TStringField
      FieldName = 'OPE_FUNCAO'
    end
    object cdsConsultaMSF_VLRSER: TFloatField
      FieldName = 'MSF_VLRSER'
    end
    object cdsConsultaMSF_VLRADI: TFloatField
      FieldName = 'MSF_VLRADI'
    end
    object cdsConsultaMSF_VLRSPM: TFloatField
      FieldName = 'MSF_VLRSPM'
    end
    object cdsConsultaMSF_PERSPM: TFloatField
      FieldName = 'MSF_PERSPM'
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaMSF_CODEMP: TStringField
      FieldName = 'MSF_CODEMP'
    end
    object cdsConsultaMSF_MESANO: TStringField
      FieldName = 'MSF_MESANO'
    end
    object cdsConsultaMSF_VLRMIN: TFloatField
      FieldName = 'MSF_VLRMIN'
    end
    object cdsConsultaMSF_VLRMGS: TFloatField
      FieldName = 'MSF_VLRMGS'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 152
    Top = 360
  end
end
