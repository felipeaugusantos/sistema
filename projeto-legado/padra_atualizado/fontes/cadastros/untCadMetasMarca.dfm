inherited frmCadMetasMarca: TfrmCadMetasMarca
  Left = 285
  Top = 248
  Height = 361
  Align = alClient
  Caption = #39
  OnKeyPress = FormKeyPress
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 280
    Height = 26
    TabOrder = 4
    ExplicitTop = 280
    ExplicitHeight = 26
    object Label3: TLabel [0]
      Left = 361
      Top = 6
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Percentual Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 636
      Height = 22
      ExplicitWidth = 636
      ExplicitHeight = 22
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
      Left = 638
      Top = 2
      Align = alRight
      TabOrder = 2
      Visible = False
      ExplicitLeft = 638
      ExplicitTop = 2
    end
    object edtTotPer: TEditFocus
      Tag = 99
      Left = 442
      Top = 3
      Width = 65
      Height = 20
      TabStop = False
      Alignment = taRightJustify
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
    TabOrder = 5
    Visible = False
    ExplicitTop = 306
  end
  inherited pnlHeader: TPanel
    TabOrder = 0
    Visible = False
  end
  inherited pnlTail: TPanel
    Top = 232
    Visible = True
    ExplicitTop = 232
    object Label4: TLabel
      Left = 36
      Top = 17
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 71
      Top = 13
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 120
      Top = 13
      Width = 260
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Height = 135
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    OnKeyPress = dbgConsultaKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODMAR'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAR_DESMAR'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o da Marca dos Produtos'
        Width = 359
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_PERMAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Percentual'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    TabOrder = 1
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
    Left = 560
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 592
    Top = 8
  end
  inherited qryConsulta: TUniQuery
    Left = 24
    Top = 8
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Options = [poAutoRefresh]
    Left = 56
    Top = 8
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    AfterPost = cdsConsultaAfterPost
    BeforeDelete = cdsConsultaBeforeDelete
    AfterScroll = cdsConsultaAfterScroll
    Left = 88
    Top = 8
    object cdsConsultaMET_CODMAR: TStringField
      FieldName = 'MET_CODMAR'
    end
    object cdsConsultaMET_PERMAR: TFloatField
      FieldName = 'MET_PERMAR'
      OnSetText = cdsConsultaMET_PERMARSetText
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaMET_CODEMP: TStringField
      FieldName = 'MET_CODEMP'
      Size = 3
    end
    object cdsConsultaMAR_DESMAR: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'MAR_DESMAR'
      LookupDataSet = qryCadMar
      LookupKeyFields = 'MAR_CODMAR'
      LookupResultField = 'MAR_DESMAR'
      KeyFields = 'MET_CODMAR'
      Size = 30
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
    object cdsConsultaTOT_PERMAR: TAggregateField
      FieldName = 'TOT_PERMAR'
      Active = True
      DisplayName = ''
      Expression = 'SUM(MET_PERMAR)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 120
    Top = 8
  end
  object qryCadMar: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT MAR_CODMAR, MAR_DESMAR FROM CADMAR')
    ReadOnly = True
    Constraints = <>
    Left = 152
    Top = 8
    object qryCadMarMAR_CODMAR: TStringField
      FieldName = 'MAR_CODMAR'
      FixedChar = True
      Size = 6
    end
    object qryCadMarMAR_DESMAR: TStringField
      FieldName = 'MAR_DESMAR'
      Required = True
      Size = 30
    end
  end
end
