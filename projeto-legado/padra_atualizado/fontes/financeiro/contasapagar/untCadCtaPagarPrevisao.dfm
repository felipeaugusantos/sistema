inherited frmCadCtaPagarPrevisao: TfrmCadCtaPagarPrevisao
  Width = 854
  Height = 502
  Caption = 'Manuten'#231#227'o de Contas a Pagar Previs'#227'o'
  OnKeyUp = FormKeyUp
  ExplicitWidth = 854
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 431
    Width = 848
    ExplicitTop = 431
    ExplicitWidth = 848
    inherited FlwBotoes: TFlowPanel
      Width = 844
      ExplicitWidth = 844
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Caption = '[F10] &Confirmar'
        ExplicitWidth = 113
      end
      object btnAlterarVencimento: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 126
        Height = 22
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = '[F3] &Alterar Vencimento'
        TabOrder = 1
        OnClick = btnAlterarVencimentoClick
      end
      object btnConverterPrevisaoEmCTP: TBitBtnLocked
        Left = 239
        Top = 0
        Width = 362
        Height = 22
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 
          '[F4] &Converter a Previs'#227'o do Contas a Pagar selecionada em Desp' +
          'esa'
        TabOrder = 2
        OnClick = btnConverterPrevisaoEmCTPClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 768
      Caption = '&Sair'
      ExplicitLeft = 768
    end
  end
  inherited pnlStatus: TPanel
    Top = 457
    Width = 848
    ExplicitTop = 457
    ExplicitWidth = 848
    inherited pnlNomeForm: TPanel
      Left = 677
      ExplicitLeft = 677
    end
    inherited pnlInfo: TPanel
      Width = 677
      ExplicitWidth = 677
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 848
    Height = 79
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 50
      Top = 55
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 430
      Top = 55
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. Contabil:'
    end
    object Label3: TLabel
      Left = 62
      Top = 32
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 48
      Top = 8
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label15: TLabel
      Left = 209
      Top = 55
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object lbParcela: TLabel
      Left = 286
      Top = 55
      Width = 42
      Height = 14
      Caption = 'Parcela: '
    end
    object dbeNumDup: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 51
      Width = 94
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_NUMDUP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeParcel: TDBEditFocus
      Tag = 99
      Left = 491
      Top = 51
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VLRTOT'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 28
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODEMP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 5
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODFOR'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object dbeSerie: TDBEditFocus
      Tag = 99
      Left = 239
      Top = 51
      Width = 38
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_SERIE_'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBENOMFOR: TDBEditFocus
      Tag = 99
      Left = 181
      Top = 5
      Width = 395
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'FOR_NOMFOR'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBENOMEMP: TDBEditFocus
      Tag = 99
      Left = 181
      Top = 28
      Width = 395
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EMP_NOMEMP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 328
      Top = 51
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_PARCEL'
      DataSource = dtsTabela
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object cxGrid1: TcxGrid [3]
    Left = 0
    Top = 79
    Width = 848
    Height = 225
    Align = alClient
    TabOrder = 3
    object grdCtaPag: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = grdCtaPagCellDblClick
      OnCustomDrawCell = grdCtaPagCustomDrawCell
      DataController.DataSource = dtsTabela
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdCtaPagDTACAD: TcxGridDBColumn
        Caption = 'Dt. Cad.'
        DataBinding.FieldName = 'CTP_DTACAD'
        Options.Editing = False
      end
      object grdCtaPagCOMPET: TcxGridDBColumn
        Caption = 'Compet.'
        DataBinding.FieldName = 'CTP_COMPET'
        Options.Editing = False
      end
      object grdCtaPagVENCTO: TcxGridDBColumn
        Caption = 'Dt. Vencimento'
        DataBinding.FieldName = 'CTP_DTAVEN'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.OnValidate = grdCtaPagVENCTOPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPagVRLORI: TcxGridDBColumn
        Caption = 'Vr. Original'
        DataBinding.FieldName = 'CTP_VALDUP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPagVRLDES: TcxGridDBColumn
        Caption = 'Vr. Desconto'
        DataBinding.FieldName = 'CTP_DESSUJ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPaVRLJUR: TcxGridDBColumn
        Caption = 'Vr. Juros'
        DataBinding.FieldName = 'CTP_JURSUJ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPagVRLMUL: TcxGridDBColumn
        Caption = 'Vr. Multa'
        DataBinding.FieldName = 'CTP_MULSUJ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPagVLRTOT: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'VLRTOT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object grdCtaPagAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        Options.Editing = False
      end
      object grdCtaPagCONVERTER_DESPESA: TcxGridDBColumn
        DataBinding.FieldName = 'CONVERTER_DESPESA'
        Visible = False
      end
      object grdCtaPagCONVERTER_DATADECADASTRO: TcxGridDBColumn
        DataBinding.FieldName = 'CONVERTER_DATADECADASTRO'
        Visible = False
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = grdCtaPag
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 304
    Width = 848
    Height = 127
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label4: TLabel
      Left = 26
      Top = 55
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object Label7: TLabel
      Left = 26
      Top = 32
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Centro de Custo:'
    end
    object Label8: TLabel
      Left = 63
      Top = 8
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label6: TLabel
      Left = 62
      Top = 72
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object DBEditFocus1: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 51
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODCTA'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object DBEditFocus3: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 28
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODEVE'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBEditFocus4: TDBEditFocus
      Tag = 99
      Left = 109
      Top = 5
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTP_CODPOR'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBMemo1: TDBMemo
      Left = 109
      Top = 74
      Width = 467
      Height = 41
      DataField = 'CTP_HIST01'
      DataSource = dtsTabela
      ReadOnly = True
      TabOrder = 3
    end
    object DBEditFocus6: TDBEditFocus
      Tag = 99
      Left = 181
      Top = 5
      Width = 395
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'POR_NOMPOR'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBEditFocus7: TDBEditFocus
      Tag = 99
      Left = 181
      Top = 28
      Width = 395
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EVE_DESEVE'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object DBEditFocus8: TDBEditFocus
      Tag = 99
      Left = 181
      Top = 51
      Width = 395
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'CTA_DESCTA'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object Panel2: TPanel
      Left = 616
      Top = 8
      Width = 185
      Height = 105
      BevelOuter = bvNone
      TabOrder = 7
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 112
  end
  object dtsTabela: TDataSource
    Left = 568
    Top = 168
  end
end
