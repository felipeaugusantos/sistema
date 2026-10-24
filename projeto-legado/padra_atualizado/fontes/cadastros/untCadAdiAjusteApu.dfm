inherited frmCadAdiAjusteApu: TfrmCadAdiAjusteApu
  Width = 593
  Height = 239
  Caption = 'Informa'#231#245'es Adicionais dos Ajustes da Apura'#231#227'o (E112)'
  OnDestroy = FormDestroy
  ExplicitWidth = 593
  ExplicitHeight = 239
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 166
    Width = 587
    ExplicitTop = 166
    ExplicitWidth = 552
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitTop = 2
      ExplicitWidth = 548
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
      ExplicitLeft = 466
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 194
    Width = 587
    ExplicitTop = 194
    ExplicitWidth = 552
    inherited pnlNomeForm: TPanel
      Left = 400
      Width = 187
      ExplicitLeft = 365
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 365
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 166
    Visible = False
    ExplicitWidth = 552
    ExplicitHeight = 166
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 544
      ExplicitHeight = 134
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 587
    Height = 166
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 552
    object Label2: TLabel
      Left = 17
      Top = 102
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
      Left = 352
      Top = 74
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Indicador'
    end
    object Label4: TLabel
      Left = 34
      Top = 130
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Complemento'
    end
    object Label6: TLabel
      Left = 22
      Top = 46
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc. Arrec. Est.'
    end
    object Label7: TLabel
      Left = 12
      Top = 74
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Processo'
    end
    object dbeDesAju: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 99
      Width = 457
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_DESAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
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
      DataField = 'AJU_CODEMP'
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
      DataField = 'AJU_MESANO'
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
    object dblIndOri: TDBLookupComboBoxFocus
      Tag = 99
      Left = 402
      Top = 71
      Width = 159
      Height = 22
      DataField = 'AJU_INDORI'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndOri
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeComple: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 127
      Width = 457
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_COMPLE'
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
    object dbeNumDAE: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 43
      Width = 457
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_NUMDAE'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumPAV: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 71
      Width = 242
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_NUMPAV'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 24
  end
  object dtsTabela: TDataSource
    Left = 352
  end
  object dtsIndOri: TDataSource
    Left = 444
    Top = 4
  end
end
