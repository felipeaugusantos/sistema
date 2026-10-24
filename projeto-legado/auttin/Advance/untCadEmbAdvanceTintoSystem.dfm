inherited frmCadEmbAdvanceTintoSystem: TfrmCadEmbAdvanceTintoSystem
  Width = 615
  Height = 159
  Caption = 'Cadastro de Embalagens - Advance TintoSystem'
  ExplicitWidth = 615
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 609
    TabOrder = 2
    ExplicitTop = 87
    ExplicitWidth = 609
    DesignSize = (
      609
      28)
    inherited btnSair: TBitBtnLocked
      Left = 533
      ExplicitLeft = 533
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 609
    Height = 87
    TabOrder = 1
    ExplicitWidth = 609
    ExplicitHeight = 87
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 601
      ExplicitHeight = 55
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 609
    Height = 87
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object lblEmbalagem: TLabel
      Left = 47
      Top = 21
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblProduto: TLabel
      Left = 166
      Top = 21
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblUnidade: TLabel
      Left = 41
      Top = 50
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object dbeCodEmb: TDBEditFocus
      Tag = 99
      Left = 89
      Top = 18
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_CODEMB'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 224
      Top = 18
      Width = 329
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtUniDescri: TEditFocus
      Left = 160
      Top = 46
      Width = 342
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUniUni: TEditFocus
      Left = 496
      Top = 46
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodUni: TDBEditFocus
      Tag = 99
      Left = 89
      Top = 46
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'EMB_CODUNI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      OnExit = dbeCodUniExit
      OnKeyPress = dbeCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 609
    TabOrder = 3
    ExplicitTop = 115
    ExplicitWidth = 609
    inherited pnlNomeForm: TPanel
      Left = 262
      TabOrder = 1
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      TabOrder = 0
      ExplicitWidth = 262
    end
  end
end
