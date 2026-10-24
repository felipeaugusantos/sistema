inherited frmConfigLALUR: TfrmConfigLALUR
  Width = 650
  Height = 471
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#245'es do LALUR/LACS'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 650
  ExplicitHeight = 471
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 398
    Width = 644
    TabOrder = 1
    ExplicitTop = 398
    ExplicitWidth = 644
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 563
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 563
    end
    inherited btnSair: TBitBtnLocked
      Left = 560
      ExplicitLeft = 560
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Gravar'
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 426
    Width = 644
    TabOrder = 2
    ExplicitTop = 426
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 473
      ExplicitLeft = 473
    end
    inherited pnlInfo: TPanel
      Width = 473
      ExplicitWidth = 473
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 644
    Height = 398
    ActivePage = tbsPrejFiscais
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    object tbsPrejFiscais: TTabSheet
      Caption = 'Prej. Fiscais Operac.'
      object Label36: TLabel
        Left = 20
        Top = 16
        Width = 193
        Height = 14
        Caption = 'Conta de preju'#237'zos fiscais operacionais:'
      end
      object Label1: TLabel
        Left = 20
        Top = 72
        Width = 275
        Height = 14
        Caption = 'Hist'#243'rico da compensa'#231#227'o do preju'#237'zo fiscal operacional:'
      end
      object Label2: TLabel
        Left = 20
        Top = 144
        Width = 282
        Height = 14
        Caption = 'Hist'#243'rico da transfer'#234'ncia para preju'#237'zo fiscal operacional:'
      end
      object Label3: TLabel
        Left = 20
        Top = 216
        Width = 253
        Height = 14
        Caption = 'Hist'#243'rico da apura'#231#227'o do preju'#237'zo fiscal operacional:'
      end
      object Label4: TLabel
        Left = 20
        Top = 288
        Width = 217
        Height = 14
        Caption = 'Conta da compensa'#231#227'o do ajuste na parte A:'
      end
      object dbeConPfo: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 33
        Width = 109
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CONPFO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeConPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtConPfo: TEditFocus
        Left = 131
        Top = 33
        Width = 335
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object dbeHcoPfo: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 89
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HCOPFO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHtrPfo: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 161
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HTRPFO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHapPfo: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 233
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HAPPFO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtCcaPfo: TEditFocus
        Left = 82
        Top = 305
        Width = 384
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCcaPfo: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 305
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CCAPFO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        OnKeyPress = dbeCcaPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object memHcoPfo: TDBMemoFocus
        Left = 82
        Top = 89
        Width = 384
        Height = 44
        DataField = 'CFG_HDOPFO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object memHtrPfo: TDBMemoFocus
        Left = 82
        Top = 161
        Width = 384
        Height = 44
        DataField = 'CFG_HDRPFO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object memHapPfo: TDBMemoFocus
        Left = 82
        Top = 233
        Width = 384
        Height = 44
        DataField = 'CFG_HDPPFO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsPrejFiscaisN: TTabSheet
      Caption = 'Prej. Fiscais N'#227'o Operac.'
      ImageIndex = 2
      object Label7: TLabel
        Left = 20
        Top = 16
        Width = 214
        Height = 14
        Caption = 'Conta de preju'#237'zos fiscais n'#227'o operacionais:'
      end
      object Label8: TLabel
        Left = 20
        Top = 72
        Width = 296
        Height = 14
        Caption = 'Hist'#243'rico da compensa'#231#227'o do preju'#237'zo fiscal n'#227'o operacional:'
      end
      object Label9: TLabel
        Left = 20
        Top = 136
        Width = 303
        Height = 14
        Caption = 'Hist'#243'rico da transfer'#234'ncia para preju'#237'zo fiscal n'#227'o operacional:'
      end
      object Label10: TLabel
        Left = 20
        Top = 208
        Width = 274
        Height = 14
        Caption = 'Hist'#243'rico da apura'#231#227'o do preju'#237'zo fiscal n'#227'o operacional:'
      end
      object Label11: TLabel
        Left = 20
        Top = 280
        Width = 217
        Height = 14
        Caption = 'Conta da compensa'#231#227'o do ajusta na parte A:'
      end
      object dbeConPno: TDBEditFocus
        Tag = 99
        Left = 16
        Top = 33
        Width = 109
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CONPNO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeConPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtConPno: TEditFocus
        Left = 131
        Top = 33
        Width = 335
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object dbeHcoPno: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 89
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HCOPNO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHtrPno: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 153
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HTRPNO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHapPno: TDBEditFocus
        Tag = 99
        Left = 16
        Top = 225
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HAPPNO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtCcaPno: TEditFocus
        Left = 82
        Top = 297
        Width = 384
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCcaPno: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 297
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CCAPNO'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        OnKeyPress = dbeCcaPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object memHcoPno: TDBMemoFocus
        Left = 82
        Top = 89
        Width = 384
        Height = 44
        DataField = 'CFG_HDOPNO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object memHtrPno: TDBMemoFocus
        Left = 82
        Top = 153
        Width = 384
        Height = 44
        DataField = 'CFG_HDRPNO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object memHapPno: TDBMemoFocus
        Left = 82
        Top = 225
        Width = 384
        Height = 44
        DataField = 'CFG_HDPPNO'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsContSocial: TTabSheet
      Caption = 'Cont. Social s/ Lucro'
      ImageIndex = 1
      object Label5: TLabel
        Left = 20
        Top = 16
        Width = 257
        Height = 14
        Caption = 'Natureza da adi'#231#227'o contribui'#231#227'o social sobre o lucro:'
      end
      object Label6: TLabel
        Left = 20
        Top = 72
        Width = 267
        Height = 14
        Caption = 'Hist'#243'rico do ajuste da contribui'#231#227'o social sobre o lucro:'
      end
      object dbeNatCsl: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 33
        Width = 109
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_NATCSL'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeNatCslKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtNatCsl: TEditFocus
        Left = 131
        Top = 33
        Width = 335
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
      object dbeHstCsl: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 89
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HSTCSL'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object memHstCsl: TDBMemoFocus
        Left = 82
        Top = 89
        Width = 384
        Height = 44
        DataField = 'CFG_HDTCSL'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsBaseCalcNeg: TTabSheet
      Caption = 'Base de C'#225'lc. Negativa CSL'
      ImageIndex = 3
      object Label12: TLabel
        Left = 20
        Top = 16
        Width = 192
        Height = 14
        Caption = 'Conta da base c'#225'lculo negativa da CSL:'
      end
      object Label13: TLabel
        Left = 20
        Top = 72
        Width = 307
        Height = 14
        Caption = 'Hist'#243'rico da compensa'#231#227'o da base de c'#225'lculo negativa da CSL:'
      end
      object Label14: TLabel
        Left = 20
        Top = 136
        Width = 285
        Height = 14
        Caption = 'Hist'#243'rico da apura'#231#227'o da base de c'#225'lculo negativa da CSL:'
      end
      object Label15: TLabel
        Left = 20
        Top = 208
        Width = 217
        Height = 14
        Caption = 'Conta da compensa'#231#227'o do ajusta na parte A:'
      end
      object dbeConCnc: TDBEditFocus
        Tag = 99
        Left = 16
        Top = 33
        Width = 109
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CONCNC'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeConCncKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtConCnc: TEditFocus
        Left = 131
        Top = 33
        Width = 335
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object dbeHcoCnc: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 89
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HCOCNC'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHapCnc: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 153
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_HAPCNC'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        OnKeyPress = dbeHcoPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtCcaCnc: TEditFocus
        Left = 82
        Top = 225
        Width = 384
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
      object dbeCcaCnc: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 225
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_CCACNC'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnKeyPress = dbeCcaPfoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object memHcoCnc: TDBMemoFocus
        Left = 82
        Top = 89
        Width = 384
        Height = 44
        DataField = 'CFG_HDOCNC'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object memHapCnc: TDBMemoFocus
        Left = 82
        Top = 153
        Width = 384
        Height = 44
        DataField = 'CFG_HDPCNC'
        DataSource = dtsConfig
        MaxLength = 40
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object tbsPagamentos: TTabSheet
      Caption = 'Pagamentos'
      ImageIndex = 4
      object Label16: TLabel
        Left = 20
        Top = 16
        Width = 209
        Height = 14
        Caption = 'Conta para pagamentos realizados do IRPJ:'
      end
      object Label17: TLabel
        Left = 20
        Top = 72
        Width = 200
        Height = 14
        Caption = 'Conta para pagamentos realizados CSLL:'
      end
      object dbeConIrp: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 33
        Width = 109
        Height = 22
        DataField = 'CFG_CONIRP'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeConIrpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtConIrp: TEditFocus
        Left = 131
        Top = 33
        Width = 335
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object dbeConCsl: TDBEditFocus
        Tag = 99
        Left = 20
        Top = 89
        Width = 109
        Height = 22
        DataField = 'CFG_CONCSL'
        DataSource = dtsConfig
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeConIrpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtConCsl: TEditFocus
        Left = 131
        Top = 89
        Width = 335
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
    end
  end
  object dtsConfig: TDataSource
    Left = 560
    Top = 72
  end
end
