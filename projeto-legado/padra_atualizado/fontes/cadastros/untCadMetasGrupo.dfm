inherited frmCadMetasGrupo: TfrmCadMetasGrupo
  Left = 285
  Top = 248
  Width = 900
  Height = 361
  Align = alClient
  Caption = #39
  OnKeyPress = FormKeyPress
  ExplicitWidth = 900
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 278
    Width = 884
    TabOrder = 4
    ExplicitTop = 278
    ExplicitWidth = 884
    object Label3: TLabel [0]
      Left = 528
      Top = 6
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Percentual Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 361
    end
    inherited FlwBotoes: TFlowPanel
      Width = 363
      Align = alLeft
      ExplicitWidth = 363
      inherited btnMudaOrdem: TBitBtnLocked
        Visible = False
      end
      inherited btnPesquisar: TBitBtnLocked
        Visible = False
      end
      object btnExcluir: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 106
        Height = 22
        Caption = '&Excluir grupo'
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
        TabOrder = 2
        TabStop = False
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 804
      Top = 2
      TabOrder = 2
      Visible = False
      ExplicitLeft = 804
      ExplicitTop = 2
    end
    object edtTotPer: TEditFocus
      Tag = 99
      Left = 609
      Top = 3
      Width = 65
      Height = 20
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited pnlStatus: TPanel
    Top = 306
    Width = 884
    TabOrder = 5
    Visible = False
    ExplicitTop = 306
    ExplicitWidth = 884
    inherited pnlNomeForm: TPanel
      Left = 713
      ExplicitLeft = 713
    end
    inherited pnlInfo: TPanel
      Width = 713
      ExplicitWidth = 713
    end
  end
  inherited pnlHeader: TPanel
    Width = 884
    TabOrder = 0
    Visible = False
    ExplicitWidth = 884
  end
  inherited pnlTail: TPanel
    Top = 230
    Width = 884
    Visible = True
    ExplicitTop = 230
    ExplicitWidth = 884
    object Label9: TLabel
      Left = 6
      Top = 17
      Width = 62
      Height = 14
      Caption = 'Linha/Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 622
      Top = 17
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Percentual:'
    end
    object lblMarGru: TLabel
      Left = 759
      Top = 17
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 71
      Top = 13
      Width = 48
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 120
      Top = 13
      Width = 260
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPerGru: TEditFocus
      Tag = 99
      Left = 678
      Top = 13
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
      EditFormat = '#,##0.00'
    end
    object rdgDefineLinhaGrupo: TRadioGroup
      Left = 386
      Top = 4
      Width = 231
      Height = 38
      Caption = ' Definir Linha/Grupo por '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Valor Faturamento'
        'Margem')
      TabOrder = 2
      OnClick = rdgDefineLinhaGrupoClick
    end
    object edtMarGru: TEditFocus
      Tag = 99
      Left = 802
      Top = 13
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 884
    Height = 133
    TabOrder = 2
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODGRU'
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GRU_DESGRU'
        Title.Caption = 'Descri'#231#227'o de Linha/Grupo de Produtos'
        Width = 359
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DescrDefLinGru'
        Title.Caption = ' Definir Linha/Grupo por '
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_PERGRU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Percentual'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_MARGRU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Margem%'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 884
    TabOrder = 1
    ExplicitWidth = 884
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 160
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 152
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Options = [poAutoRefresh]
    Left = 144
    Top = 152
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    AfterPost = cdsConsultaAfterPost
    BeforeDelete = cdsConsultaBeforeDelete
    AfterScroll = cdsConsultaAfterScroll
    OnCalcFields = cdsConsultaCalcFields
    Left = 176
    Top = 152
    object cdsConsultaMET_CODGRU: TStringField
      FieldName = 'MET_CODGRU'
      EditMask = '999.999;0;'
    end
    object cdsConsultaMET_PERGRU: TFloatField
      FieldName = 'MET_PERGRU'
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaMET_CODEMP: TStringField
      FieldName = 'MET_CODEMP'
      Size = 3
    end
    object cdsConsultaGRU_DESGRU: TStringField
      FieldKind = fkLookup
      FieldName = 'GRU_DESGRU'
      LookupDataSet = qryCadGru
      LookupKeyFields = 'GRU_CODGRU'
      LookupResultField = 'GRU_DESGRU'
      KeyFields = 'MET_CODGRU'
      Lookup = True
    end
    object cdsConsultaMET_MESANO: TStringField
      FieldName = 'MET_MESANO'
      Size = 8
    end
    object cdsConsultaMET_CODVEN: TStringField
      FieldName = 'MET_CODVEN'
      Size = 3
    end
    object cdsConsultaDescrDefLinGru: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescrDefLinGru'
      Calculated = True
    end
    object cdsConsultaMET_MARGRU: TFloatField
      FieldName = 'MET_MARGRU'
    end
    object cdsConsultaMET_DEFTIP: TStringField
      FieldName = 'MET_DEFTIP'
      Size = 1
    end
    object cdsConsultaTOT_PERGRU: TAggregateField
      FieldName = 'TOT_PERGRU'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MET_PERGRU)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 208
    Top = 152
  end
  object qryCadGru: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT GRU_CODGRU, GRU_DESGRU FROM CADGRU')
    ReadOnly = True
    Constraints = <>
    Left = 248
    Top = 152
    object qryCadGruGRU_CODGRU: TStringField
      FieldName = 'GRU_CODGRU'
    end
    object qryCadGruGRU_DESGRU: TStringField
      FieldName = 'GRU_DESGRU'
    end
  end
end
