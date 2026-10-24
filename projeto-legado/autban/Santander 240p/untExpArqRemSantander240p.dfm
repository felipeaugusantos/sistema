inherited frmExpArqRemSantander240p: TfrmExpArqRemSantander240p
  Left = 292
  Top = 236
  Width = 367
  Height = 174
  BorderStyle = bsNone
  Caption = 'frmExpArqRemSantander240p'
  Position = poMainFormCenter
  ExplicitWidth = 367
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 128
    Width = 367
    Height = 30
    TabOrder = 1
    ExplicitTop = 128
    ExplicitWidth = 367
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Left = 90
      Width = 198
      Height = 26
      TabOrder = 2
      ExplicitLeft = 90
      ExplicitWidth = 198
      ExplicitHeight = 26
    end
    inherited btnSair: TBitBtnLocked
      Left = 288
      Top = 2
      Height = 26
      Align = alRight
      ExplicitLeft = 288
      ExplicitTop = 2
      ExplicitHeight = 26
    end
    object btnGerar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 88
      Height = 26
      Align = alLeft
      Caption = '&Gerar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        92635DA46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769FF00FFFF00FFFF00FFFF00FF92635DFCF3DEFFEED5FFEED5FFEED5FF
        EED5FEEBD1FEEBD1FEEBD1FEEBD1F7EDD0A46769FF00FFFF00FFFF00FFFF00FF
        92635DF7EAD8FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82F2E2
        C7A46769FF00FFFF00FFFF00FFFF00FF92635DF8EFDEFAE9D5FAE7D4FAE7D3F8
        E6D1F8E6D0F8E6D0F8E6D0F8E6D0F0E2C9A46769FF00FFFF00FFFF00FFFF00FF
        92635DEAE2D4FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82E1D3
        BAA46769FF00FFFF00FFFF00FFFF00FF987468AA9F95A69A92A59991A5998EA4
        978BA39689A19587A19384A19183A49381986B65FF00FFFF00FF8C38168C3816
        8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
        168C38168C38168C38168C3816FF00FFA77568E0E9EAE17545E17545E17545E1
        7545E17545E17545E17545E17545D7D8CAA46769FF00FF8B35128C38158C3816
        8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
        168C38168C38168C3816FF00FFFF00FFB17E6BD7B09CD1AF9ED1AF9ECEAA97CC
        A995CCA793CBA591CAA590CAA38BD4A78CA46769FF00FFFF00FFFF00FFFF00FF
        BB846EFFFFFFFFE3C1FFE2C0FFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFFC
        EFA46769FF00FFFF00FFFF00FFFF00FFC58C70FFFFFFFEBD82FEBD82FEBD82FE
        BD82FEBD82FEBD82FEBD82FEBD82FBF6E9A46769FF00FFFF00FFFF00FFFF00FF
        CB9173FFFFFFFEFFFFFEFFFFFEFEFEFEFBFAFBFAF7FBF8F6FAF7F3F8F4F0FCFA
        F0A46769FF00FFFF00FFFF00FFFF00FFD49876FFFFFFFEBD82FEBD82FEBD82FE
        BD82FEBD82FEBD82FEBD82FEBD82FFFCF4A46769FF00FFFF00FFFF00FFFF00FF
        D49876FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFAFFFF
        FFA46769FF00FFFF00FFFF00FFFF00FFD49876CF8E68CF8E68CF8E68CF8E68CF
        8E68CF8E68CF8E68CF8E68CF8E68CF8E68A46769FF00FFFF00FF}
      ParentFont = False
      TabOrder = 0
      OnClick = btnGerarClick
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 367
    Height = 128
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object lblNomArq: TLabel
      Left = 13
      Top = 79
      Width = 85
      Height = 14
      Caption = 'Nome do Arquivo:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblPathRem: TLabel
      Left = 15
      Top = 57
      Width = 84
      Height = 14
      Caption = 'Path p/ Remessa:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 56
      Top = 36
      Width = 44
      Height = 14
      Caption = 'Portador:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 363
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Gera'#231#227'o de Arquivo Remessa [033]'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object edtNomArquivo: TEditFocus
      Left = 103
      Top = 76
      Width = 247
      Height = 19
      Alignment = taLeftJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Left = 103
      Top = 29
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 146
      Top = 29
      Width = 203
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
    inline fraPathRemessa: TfraDirectoryEditFocus
      Left = 103
      Top = 52
      Width = 247
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 4
      ExplicitLeft = 103
      ExplicitTop = 52
      ExplicitWidth = 247
      ExplicitHeight = 24
      inherited edtDirectory: TEditFocus
        Width = 222
        Height = 22
        ExplicitWidth = 222
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 224
        Height = 24
        ExplicitLeft = 224
        ExplicitHeight = 24
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 158
    Width = 367
    TabOrder = 2
    ExplicitTop = 158
    ExplicitWidth = 367
    inherited pnlNomeForm: TPanel
      Left = 196
      ExplicitLeft = 196
    end
    inherited pnlInfo: TPanel
      Width = 196
      ExplicitWidth = 196
    end
  end
end
