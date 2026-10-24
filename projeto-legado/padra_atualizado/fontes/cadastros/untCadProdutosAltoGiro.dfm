inherited frmCadProdutosAltoGiro: TfrmCadProdutosAltoGiro
  Width = 570
  Height = 215
  Caption = 'Produtos especiais para trava de estoque por alto giro'
  ExplicitWidth = 570
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 142
    Width = 564
    ExplicitTop = 142
    ExplicitWidth = 564
    inherited FlwBotoes: TFlowPanel
      Width = 560
      ExplicitTop = 2
      ExplicitWidth = 560
      inherited btnPesquisa: TBitBtnLocked
        Width = 80
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 478
      ExplicitLeft = 478
    end
  end
  inherited pnlStatus: TPanel
    Top = 170
    Width = 564
    ExplicitTop = 170
    ExplicitWidth = 564
    inherited pnlNomeForm: TPanel
      Left = 217
      ExplicitLeft = 217
    end
    inherited pnlInfo: TPanel
      Width = 217
      ExplicitWidth = 217
    end
  end
  inherited pgcDados: TPageControl
    Width = 564
    Height = 142
    ExplicitWidth = 564
    ExplicitHeight = 142
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 556
      ExplicitHeight = 110
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 564
    Height = 142
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object lblUniCom: TLabel
      Left = 54
      Top = 24
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label1: TLabel
      Left = 49
      Top = 52
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lbl5: TLabel
      Left = 45
      Top = 80
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label43: TLabel
      Left = 7
      Top = 108
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do Cadastro:'
    end
    object Label2: TLabel
      Left = 174
      Top = 108
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hora do cadastro:'
    end
    object edtCodIte: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 21
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ESP_CODITE'
      DataSource = dtsProEsp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 158
      Top = 21
      Width = 398
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 49
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ESP_CODEMP'
      DataSource = dtsProEsp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 158
      Top = 49
      Width = 398
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeOpeAlt: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 77
      Width = 60
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ESP_CODOPE'
      DataSource = dtsProEsp
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 158
      Top = 77
      Width = 398
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeDtCadastro: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 105
      Width = 60
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ESP_DTACAD'
      DataSource = dtsProEsp
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHrCadastro: TDBEditFocus
      Tag = 99
      Left = 265
      Top = 105
      Width = 60
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ESP_HORCAD'
      DataSource = dtsProEsp
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 39
  end
  object dtsProEsp: TDataSource
    Left = 352
    Top = 8
  end
end
