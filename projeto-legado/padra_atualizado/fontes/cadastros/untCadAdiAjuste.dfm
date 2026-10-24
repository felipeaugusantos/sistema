inherited frmCadAdiAjuste: TfrmCadAdiAjuste
  Width = 592
  Height = 215
  Caption = 'Informa'#231#245'es Adicionais da Apura'#231#227'o (E115)'
  ExplicitWidth = 592
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 142
    Width = 586
    ExplicitTop = 142
    ExplicitWidth = 586
    inherited FlwBotoes: TFlowPanel
      Width = 582
      ExplicitWidth = 582
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
      Left = 500
      Width = 78
      ExplicitLeft = 500
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 170
    Width = 586
    ExplicitTop = 170
    ExplicitWidth = 586
    inherited pnlNomeForm: TPanel
      Left = 399
      Width = 187
      ExplicitLeft = 399
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 399
      ExplicitWidth = 399
    end
  end
  inherited pgcDados: TPageControl
    Width = 586
    Height = 142
    Visible = False
    ExplicitWidth = 586
    ExplicitHeight = 142
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 578
      ExplicitHeight = 110
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 586
    Height = 142
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 15
      Top = 74
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 19
      Top = 18
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 30
      Top = 46
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajuste:'
    end
    object Label5: TLabel
      Left = 412
      Top = 19
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'M'#234's/Ano:'
    end
    object Label6: TLabel
      Left = 36
      Top = 103
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object dbeDesAju: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 71
      Width = 463
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APU_DESAJU'
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
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 15
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APU_CODEMP'
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
      Left = 139
      Top = 15
      Width = 267
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
    object dbeCodAju: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 43
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APU_CODAJU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      OnExit = dbeCodAjuExit
      OnKeyPress = dbeCodAjuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesAju: TEditFocus
      Left = 139
      Top = 43
      Width = 393
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
      TabOrder = 4
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
      Left = 463
      Top = 15
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APU_MESANO'
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
    object dbeValAju: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 99
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APU_VALAJU'
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
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 24
  end
  object dtsTabela: TDataSource
    Left = 416
    Top = 40
  end
end
