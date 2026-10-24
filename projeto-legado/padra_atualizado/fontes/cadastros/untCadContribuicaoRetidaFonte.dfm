inherited frmCadContribuicaoRetidaFonte: TfrmCadContribuicaoRetidaFonte
  Width = 546
  Height = 264
  Caption = 'Contribui'#231#227'o Retida na Fonte (F600)'
  OnDestroy = FormDestroy
  ExplicitWidth = 546
  ExplicitHeight = 264
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 191
    Width = 540
    ExplicitTop = 191
    ExplicitWidth = 540
    inherited FlwBotoes: TFlowPanel
      Width = 536
      ExplicitTop = 2
      ExplicitWidth = 536
    end
    inherited btnSair: TBitBtnLocked
      Left = 457
      ExplicitLeft = 457
    end
  end
  inherited pnlStatus: TPanel
    Top = 219
    Width = 540
    ExplicitTop = 219
    ExplicitWidth = 540
    inherited pnlNomeForm: TPanel
      Left = 193
      ExplicitLeft = 193
    end
    inherited pnlInfo: TPanel
      Width = 193
      ExplicitWidth = 193
    end
  end
  inherited pgcDados: TPageControl
    Width = 540
    Height = 191
    ExplicitWidth = 540
    ExplicitHeight = 191
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 532
      ExplicitHeight = 159
      object pnlGeral: TPanel
        Left = 0
        Top = 0
        Width = 532
        Height = 159
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 540
    Height = 191
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 71
      Height = 14
      Caption = 'Data Reten'#231#227'o'
    end
    object Label4: TLabel
      Left = 87
      Top = 8
      Width = 145
      Height = 14
      Caption = 'Indicador Natureza da Receita'
    end
    object Label15: TLabel
      Left = 8
      Top = 50
      Width = 61
      Height = 14
      Caption = 'C'#243'd. Receita'
    end
    object Label1: TLabel
      Left = 87
      Top = 50
      Width = 218
      Height = 14
      Caption = 'Indicador de Natureza da Reten'#231#227'o na Fonte:'
    end
    object Label7: TLabel
      Left = 8
      Top = 92
      Width = 103
      Height = 14
      Caption = 'Cnpj Fonte Pagadora:'
    end
    object Label10: TLabel
      Left = 170
      Top = 92
      Width = 201
      Height = 14
      Caption = 'Indicador da Condi'#231#227'o da Pessoa Jur'#237'dica'
    end
    object Label6: TLabel
      Left = 8
      Top = 134
      Width = 77
      Height = 14
      Caption = 'Base Reten'#231#227'o:'
    end
    object Label3: TLabel
      Left = 135
      Top = 134
      Width = 77
      Height = 14
      Caption = 'Valor Reten'#231#227'o:'
    end
    object Label8: TLabel
      Left = 263
      Top = 134
      Width = 102
      Height = 14
      Caption = 'Valor Reten'#231#227'o (Pis):'
    end
    object Label9: TLabel
      Left = 390
      Top = 134
      Width = 119
      Height = 14
      Caption = 'Valor Reten'#231#227'o (Cofins):'
    end
    object dbeIndNre: TDBLookupComboBoxFocus
      Tag = 99
      Left = 87
      Top = 22
      Width = 354
      Height = 22
      DataField = 'REF_INDNRE'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndNre
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeIndNRF: TDBLookupComboBoxFocus
      Tag = 99
      Left = 87
      Top = 64
      Width = 354
      Height = 22
      DataField = 'REF_INDNRF'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndNRF
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeIndCpj: TDBLookupComboBoxFocus
      Tag = 99
      Left = 170
      Top = 106
      Width = 271
      Height = 22
      DataField = 'REF_INDCPJ'
      DataSource = dtsTabela
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsIndCpj
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeBasRet: TDBEditFocus
      Tag = 99
      Left = 8
      Top = 150
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_BASRET'
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
    object dbeValRet: TDBEditFocus
      Tag = 99
      Left = 135
      Top = 150
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_VALRET'
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
    object dbeValRep: TDBEditFocus
      Tag = 99
      Left = 263
      Top = 150
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_VALREP'
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
    object dbeValRec: TDBEditFocus
      Tag = 99
      Left = 390
      Top = 150
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_VALREC'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaRet: TDBEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_DTARET'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodRec: TDBEditFocus
      Tag = 99
      Left = 8
      Top = 64
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_CODREC'
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
    object dbeCnpjFP: TDBEditFocus
      Tag = 99
      Left = 8
      Top = 106
      Width = 156
      Height = 22
      CharCase = ecUpperCase
      DataField = 'REF_CNPJFP'
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
  inherited ApplicationEvents: TApplicationEvents
    Left = 976
    Top = 224
  end
  object dtsTabela: TDataSource
    Left = 448
    Top = 10
  end
  object dtsIndNre: TDataSource
    Left = 340
    Top = 60
  end
  object dtsIndNRF: TDataSource
    Left = 396
    Top = 60
  end
  object dtsIndCpj: TDataSource
    Left = 460
    Top = 60
  end
end
