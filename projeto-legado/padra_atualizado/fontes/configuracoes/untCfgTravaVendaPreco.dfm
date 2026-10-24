inherited frmCfgTravaVendaPreco: TfrmCfgTravaVendaPreco
  Left = 296
  Top = 452
  Width = 426
  Height = 326
  ActiveControl = cmbCamTb1
  Caption = 'Configura'#231#245'es - Trava de Venda por Pre'#231'o'
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 418
    inherited btnSair: TBitBtn
      Left = 337
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
    Top = 283
    Width = 418
    inherited pnlNomeForm: TPanel
      Left = 247
    end
    inherited pnlInfo: TPanel
      Width = 247
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 418
    Height = 255
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label24: TLabel
      Left = 14
      Top = 110
      Width = 75
      Height = 14
      Caption = 'Op'#231#227'o de trava'
    end
    object ColorLabel27: TColorLabel
      Left = 51
      Top = 129
      Width = 245
      Height = 14
      Caption = '(1) Traval (2) Desconto M'#225'ximo (3) Margem M'#237'nima'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label25: TLabel
      Left = 14
      Top = 192
      Width = 146
      Height = 14
      Caption = 'Senha para libera'#231#227'o da trava'
    end
    object Label6: TLabel
      Left = 14
      Top = 150
      Width = 129
      Height = 14
      Caption = 'Trava de venda por pre'#231'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 51
      Top = 169
      Width = 240
      Height = 14
      Caption = '(1) Travar item a item (2) Travar no final da venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeTraDes: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 124
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TRADES'
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
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtSenLbd: TEditFocus
      Tag = 99
      Left = 14
      Top = 205
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
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 4
      Width = 401
      Height = 102
      Caption = 'Trava de valor de venda'
      TabOrder = 0
      object Label22: TLabel
        Left = 122
        Top = 19
        Width = 69
        Height = 14
        Caption = 'Fator Tabela 1'
      end
      object Label1: TLabel
        Left = 320
        Top = 19
        Width = 69
        Height = 14
        Caption = 'Fator Tabela 2'
      end
      object Label2: TLabel
        Left = 8
        Top = 19
        Width = 91
        Height = 14
        Caption = 'Campo Trava Tb. 1'
      end
      object Label5: TLabel
        Left = 208
        Top = 19
        Width = 91
        Height = 14
        Caption = 'Campo Trava Tb. 2'
      end
      object Label3: TLabel
        Left = 120
        Top = 59
        Width = 69
        Height = 14
        Caption = 'Fator Tabela 3'
      end
      object Label4: TLabel
        Left = 8
        Top = 59
        Width = 91
        Height = 14
        Caption = 'Campo Trava Tb. 3'
      end
      object Label7: TLabel
        Left = 208
        Top = 60
        Width = 91
        Height = 14
        Caption = 'Campo Trava Tb. 4'
      end
      object Label8: TLabel
        Left = 320
        Top = 60
        Width = 69
        Height = 14
        Caption = 'Fator Tabela 4'
      end
      object dbeTraFat: TDBEditFocus
        Tag = 99
        Left = 122
        Top = 35
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRAFAT'
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
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTraFa2: TDBEditFocus
        Tag = 99
        Left = 320
        Top = 35
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRAFA2'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object cmbCamTb1: TComboBoxFocus
        Left = 8
        Top = 35
        Width = 113
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 0
        Text = 'Pre'#231'o de Venda 1'
        Items.Strings = (
          'Pre'#231'o de Venda 1'
          'Pre'#231'o de Venda 2'
          'Pre'#231'o de Venda 3'
          'Pre'#231'o de Venda 4'
          'Pre'#231'o de Custo')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbCamTb2: TComboBoxFocus
        Left = 206
        Top = 36
        Width = 113
        Height = 20
        Style = csOwnerDrawFixed
        ItemHeight = 14
        ItemIndex = 0
        TabOrder = 2
        Text = 'Pre'#231'o de Venda 1'
        Items.Strings = (
          'Pre'#231'o de Venda 1'
          'Pre'#231'o de Venda 2'
          'Pre'#231'o de Venda 3'
          'Pre'#231'o de Venda 4'
          'Pre'#231'o de Custo'
          '')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTraFa3: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 75
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRAFA3'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object cmbCamTb3: TComboBoxFocus
        Left = 6
        Top = 76
        Width = 113
        Height = 20
        Style = csOwnerDrawFixed
        ItemHeight = 14
        ItemIndex = 0
        TabOrder = 4
        Text = 'Pre'#231'o de Venda 1'
        Items.Strings = (
          'Pre'#231'o de Venda 1'
          'Pre'#231'o de Venda 2'
          'Pre'#231'o de Venda 3'
          'Pre'#231'o de Venda 4'
          'Pre'#231'o de Custo'
          '')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbCamTb4: TComboBoxFocus
        Left = 206
        Top = 77
        Width = 113
        Height = 20
        Style = csOwnerDrawFixed
        ItemHeight = 14
        TabOrder = 6
        Items.Strings = (
          'Pre'#231'o de Venda 1'
          'Pre'#231'o de Venda 2'
          'Pre'#231'o de Venda 3'
          'Pre'#231'o de Venda 4'
          'Pre'#231'o de Custo')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTraFa4: TDBEditFocus
        Tag = 99
        Left = 320
        Top = 76
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CFG_TRAFA4'
        DataSource = frmModulo.dtsCadCfg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeTrVePr: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 164
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TRVEPR'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 160
  end
end
