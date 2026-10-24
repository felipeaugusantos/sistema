inherited frmCfgTravaVendaCliente: TfrmCfgTravaVendaCliente
  Left = 197
  Top = 285
  Width = 519
  Height = 399
  ActiveControl = dbeTraScl
  Caption = 'Configura'#231#245'es - Trava de Venda por Cliente'
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 511
    inherited btnSair: TBitBtn
      Left = 430
      TabOrder = 1
    end
    object btnGravar: TBitBtn
      Left = 3
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      TabOrder = 0
      OnClick = btnGravarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 511
    inherited pnlNomeForm: TPanel
      Left = 340
    end
    inherited pnlInfo: TPanel
      Width = 340
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 511
    Height = 328
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label9: TLabel
      Left = 14
      Top = 14
      Width = 205
      Height = 14
      Caption = 'Travar atrav'#233's da situa'#231#227'o Ativo / Inativo?'
    end
    object ColorLabel23: TColorLabel
      Left = 56
      Top = 35
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeTraScl: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 28
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TRASCL'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 14
      Top = 55
      Width = 233
      Height = 141
      TabOrder = 1
      object Label10: TLabel
        Left = 14
        Top = 14
        Width = 195
        Height = 14
        Caption = 'N'#250'mero m'#225'ximo de dias que n'#227'o compra'
      end
      object Label11: TLabel
        Left = 14
        Top = 56
        Width = 78
        Height = 14
        Caption = 'Op'#231#227'o de Trava'
      end
      object Label12: TLabel
        Left = 14
        Top = 98
        Width = 139
        Height = 14
        Caption = 'Senha de libera'#231#227'o da Trava'
      end
      object ColorLabel24: TColorLabel
        Left = 63
        Top = 77
        Width = 136
        Height = 14
        Caption = '(A)visa (T)rava (N)'#227'o Avisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object dbeDianco: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 28
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_DIANCO'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTranco: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 70
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRANCO'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtSenNco: TEditFocus
        Tag = 99
        Left = 14
        Top = 111
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
    object GroupBox2: TGroupBox
      Left = 266
      Top = 55
      Width = 233
      Height = 141
      TabOrder = 2
      object Label14: TLabel
        Left = 14
        Top = 14
        Width = 118
        Height = 14
        Caption = 'Atraso M'#225'ximo Permitido'
      end
      object Label15: TLabel
        Left = 14
        Top = 56
        Width = 78
        Height = 14
        Caption = 'Op'#231#227'o de Trava'
      end
      object Label16: TLabel
        Left = 14
        Top = 98
        Width = 139
        Height = 14
        Caption = 'Senha de libera'#231#227'o da Trava'
      end
      object ColorLabel25: TColorLabel
        Left = 63
        Top = 77
        Width = 136
        Height = 14
        Caption = '(A)visa (T)rava (N)'#227'o Avisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object dbeAtrMax: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 28
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_ATRMAX'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTraMax: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 70
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRAMAX'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtSenMax: TEditFocus
        Tag = 99
        Left = 14
        Top = 111
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
    object GroupBox3: TGroupBox
      Left = 14
      Top = 208
      Width = 233
      Height = 102
      TabOrder = 3
      object Label19: TLabel
        Left = 14
        Top = 14
        Width = 79
        Height = 14
        Caption = 'Limite de Cr'#233'dito'
      end
      object ColorLabel26: TColorLabel
        Left = 63
        Top = 35
        Width = 136
        Height = 14
        Caption = '(A)visa (T)rava (N)'#227'o Avisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object Label17: TLabel
        Left = 14
        Top = 58
        Width = 139
        Height = 14
        Caption = 'Senha de libera'#231#227'o da Trava'
      end
      object dbeLimiSn: TDBEditFocus
        Tag = 99
        Left = 14
        Top = 28
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_LIMISN'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtSenLim: TEditFocus
        Tag = 99
        Left = 14
        Top = 72
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 72
  end
end
