inherited frmCadApuIpiAjuste: TfrmCadApuIpiAjuste
  Width = 593
  Height = 267
  Caption = 'Ajustes Fiscais - Apura'#231#227'o de IPI (E530)'
  OnDestroy = FormDestroy
  ExplicitWidth = 593
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 194
    Width = 587
    ExplicitTop = 194
    ExplicitWidth = 587
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitTop = 2
      ExplicitWidth = 583
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 22
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 22
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 22
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 22
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 22
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 22
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 501
      Width = 78
      ExplicitLeft = 501
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 222
    Width = 587
    ExplicitTop = 222
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 400
      Width = 187
      ExplicitLeft = 400
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 400
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 194
    Visible = False
    ExplicitWidth = 587
    ExplicitHeight = 194
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 579
      ExplicitHeight = 162
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 587
    Height = 194
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 17
      Top = 158
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Resumida'
    end
    object Label3: TLabel
      Left = 56
      Top = 18
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
    end
    object Label5: TLabel
      Left = 441
      Top = 19
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'M'#234's/Ano:'
    end
    object Label1: TLabel
      Left = 54
      Top = 46
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Indicador'
    end
    object Label4: TLabel
      Left = 17
      Top = 130
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'm. Documento'
    end
    object Label6: TLabel
      Left = 17
      Top = 74
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Ajuste'
    end
    object Label8: TLabel
      Left = 233
      Top = 102
      Width = 145
      Height = 14
      Alignment = taRightJustify
      Caption = 'Indicador da Origem do Docto.'
    end
    object Label7: TLabel
      Left = 25
      Top = 102
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do Ajuste'
    end
    object dbeDesAju: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 155
      Width = 457
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IPI_DESAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 15
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IPI_CODEMP'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = dbeCodEmpExit
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 148
      Top = 15
      Width = 287
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object dbeMesAno: TDBEditFocus
      Tag = 99
      Left = 492
      Top = 15
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IPI_MESANO'
      DataSource = dtsTabela
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
      TipoTexto = ttAlfanumerico
    end
    object dbeIndAju: TDBLookupComboBoxFocus
      Tag = 99
      Left = 104
      Top = 43
      Width = 177
      Height = 22
      DataField = 'IPI_INDAJU'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndAju
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 127
      Width = 230
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IPI_NUMDOC'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAju: TDBLookupComboBoxFocus
      Tag = 99
      Left = 104
      Top = 71
      Width = 457
      Height = 22
      DataField = 'IPI_CODAJU'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsCodAju
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeIndDoc: TDBLookupComboBoxFocus
      Tag = 99
      Left = 384
      Top = 99
      Width = 177
      Height = 22
      DataField = 'IPI_INDDOC'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndDoc
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeValAju: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 99
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IPI_VALAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 24
  end
  object dtsTabela: TDataSource
    Left = 192
  end
  object dtsIndAju: TDataSource
    Left = 284
    Top = 4
  end
  object dtsCodAju: TDataSource
    Left = 340
    Top = 4
  end
  object dtsIndDoc: TDataSource
    Left = 404
    Top = 4
  end
end
