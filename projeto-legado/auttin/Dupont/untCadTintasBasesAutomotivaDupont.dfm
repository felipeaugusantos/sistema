inherited frmCadTintasBasesAutomotivaDupont: TfrmCadTintasBasesAutomotivaDupont
  Left = 309
  Top = 189
  Width = 599
  Height = 204
  Caption = 'frmCadTintasBasesAutomotivaDupont'
  ExplicitWidth = 599
  ExplicitHeight = 204
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 132
    Width = 593
    ExplicitTop = 132
    ExplicitWidth = 593
    DesignSize = (
      593
      28)
    inherited btnSair: TBitBtnLocked
      Left = 516
      ExplicitLeft = 516
    end
    object btnReplicaItem: TBitBtnLocked
      Left = 442
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Repl. Item'
      TabOrder = 7
      Visible = False
      OnClick = btnReplicaItemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 160
    Width = 593
    ExplicitTop = 160
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 246
      ExplicitLeft = 246
    end
    inherited pnlInfo: TPanel
      Width = 246
      ExplicitWidth = 246
    end
  end
  inherited pgcDados: TPageControl
    Width = 593
    Height = 132
    ExplicitWidth = 593
    ExplicitHeight = 132
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 585
      ExplicitHeight = 100
    end
  end
  inherited pnlCampos: TPanel
    Width = 593
    Height = 132
    ExplicitWidth = 593
    ExplicitHeight = 132
    inherited lblDescricao: TLabel
      Left = 259
      ExplicitLeft = 259
    end
    inherited lblCodigoItem: TLabel
      Top = 86
      ExplicitTop = 86
    end
    inherited lblPrecoCusto: TLabel
      Top = 108
      ExplicitTop = 108
    end
    inherited lblMargem: TLabel
      Top = 108
      ExplicitTop = 108
    end
    inherited lblPrecoVenda: TLabel
      Top = 108
      ExplicitTop = 108
    end
    inherited btnRestPreco: TSpeedButton
      Top = 83
      ExplicitTop = 83
    end
    object lblLinha: TLabel [9]
      Left = 358
      Top = 64
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTipo: TLabel [10]
      Left = 49
      Top = 64
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCodEmp: TLabel [11]
      Left = 164
      Top = 20
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    inherited edtDescricaoItem: TEdit
      Top = 82
      TabOrder = 8
      ExplicitTop = 82
    end
    inherited dbeDescricao: TDBEditFocus
      Left = 315
      ExplicitLeft = 315
    end
    inherited dbeEmbalagem: TDBEditFocus
      Width = 73
      ExplicitWidth = 73
    end
    inherited dbePesoEspecifico: TDBEditFocus
      ReadOnly = True
      TabOrder = 4
    end
    inherited dbeCodigoItem: TDBEditFocus
      Top = 82
      TabOrder = 7
      ExplicitTop = 82
    end
    inherited dbePrecoCusto: TDBEditFocus
      Top = 104
      TabOrder = 9
      ExplicitTop = 104
    end
    inherited dbeMargem: TDBEditFocus
      Top = 104
      TabOrder = 10
      ExplicitTop = 104
    end
    inherited dbePrecoVenda: TDBEditFocus
      Top = 104
      TabOrder = 11
      ExplicitTop = 104
    end
    object dbeLinha: TDBEditFocus
      Tag = 99
      Left = 391
      Top = 60
      Width = 98
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_LINHA_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      OnKeyPress = dbeLinhaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipo: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 60
      Width = 98
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_TIPO__'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      OnKeyPress = dbeTipoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkPesGra: TDBCheckBox
      Left = 160
      Top = 40
      Width = 105
      Height = 17
      Caption = 'Peso em gramas?'
      DataField = 'BAS_PESGRA'
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeCodEmp: TDBEditFocus
      Left = 211
      Top = 16
      Width = 39
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 65524
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 435
    Top = 65524
  end
end
