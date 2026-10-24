inherited frmExpArqSer: TfrmExpArqSer
  Left = 426
  Top = 421
  Width = 359
  Height = 193
  BorderStyle = bsNone
  Caption = 'frmExpArqSer'
  Position = poMainFormCenter
  ExplicitWidth = 359
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 151
    Width = 359
    Height = 26
    ExplicitTop = 151
    ExplicitWidth = 359
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 278
      Height = 22
      ExplicitWidth = 278
      ExplicitHeight = 22
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
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
    inherited btnSair: TBitBtnLocked
      Left = 280
      Top = 2
      Align = alRight
      ExplicitLeft = 280
      ExplicitTop = 2
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 359
    Height = 151
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
    TabOrder = 2
    object lblPathRem: TLabel
      Left = 13
      Top = 34
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
    object lblNomArq: TLabel
      Left = 12
      Top = 58
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
    object lblPeriodo: TLabel
      Left = 30
      Top = 81
      Width = 67
      Height = 14
      Caption = 'Periodicidade:'
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
      Width = 355
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Gera'#231#227'o de Arquivo para Serasa'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
    end
    object edtNomArquivo: TEditFocus
      Left = 101
      Top = 54
      Width = 247
      Height = 23
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
      Text = 'relato.txt'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraPathRemessa: TfraDirectoryEditFocus
      Left = 100
      Top = 29
      Width = 248
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 100
      ExplicitTop = 29
      ExplicitWidth = 248
      ExplicitHeight = 24
      inherited edtDirectory: TEditFocus
        Width = 223
        Height = 22
        ExplicitWidth = 223
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 225
        Height = 24
        ExplicitLeft = 225
        ExplicitHeight = 24
      end
    end
    object rdgTipArq: TRadioGroup
      Left = 10
      Top = 103
      Width = 338
      Height = 40
      Caption = 'Tipo de registro'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Inclus'#245'es'
        'Exclus'#245'es')
      TabOrder = 3
    end
    object cmbPeriodo: TComboBoxFocus
      Left = 101
      Top = 78
      Width = 247
      Height = 22
      TabOrder = 2
      Items.Strings = (
        'Di'#225'rio'
        'Semanal'
        'Quinzenal'
        'Mensal')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 177
    Width = 359
    ExplicitTop = 177
    ExplicitWidth = 359
    inherited pnlNomeForm: TPanel
      Left = 188
      ExplicitLeft = 188
    end
    inherited pnlInfo: TPanel
      Width = 188
      ExplicitWidth = 188
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 96
  end
end
