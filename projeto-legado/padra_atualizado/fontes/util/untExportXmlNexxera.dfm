inherited frmExportXmlNexxera: TfrmExportXmlNexxera
  Left = 437
  Top = 299
  Width = 402
  Height = 390
  ActiveControl = mskDtaIni
  BorderIcons = [biSystemMenu]
  Caption = 'Exporta'#231#227'o do Arquivo Faturamento - Nexxera'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 402
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 321
    Width = 396
    TabOrder = 1
    ExplicitTop = 321
    ExplicitWidth = 396
    DesignSize = (
      396
      28)
    inherited btnSair: TBitBtnLocked
      Left = 314
      ExplicitLeft = 314
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 396
    Height = 313
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 394
      Height = 123
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lblDtaIni: TLabel
        Left = 8
        Top = 8
        Width = 66
        Height = 14
        Caption = 'Mes/Ano Ref.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCodEmp: TLabel
        Left = 8
        Top = 46
        Width = 42
        Height = 14
        Caption = 'Empresa'
      end
      object lbl1: TLabel
        Left = 8
        Top = 84
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 22
        Width = 67
        Height = 22
        EditMask = '99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 8
        Top = 60
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmp: TEditFocus
        Left = 79
        Top = 60
        Width = 306
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
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 8
        Top = 98
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 4
        OnExit = edtCodForExit
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 79
        Top = 98
        Width = 306
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
      object rdgCodIte: TRadioGroup
        Left = 79
        Top = 8
        Width = 306
        Height = 40
        Caption = 'Exportar nos Itens dos Documentos'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'C'#243'digo Citel'
          'C'#243'digo do Fabricante')
        TabOrder = 1
      end
    end
    object pnlMeio: TPanel
      Left = 1
      Top = 124
      Width = 394
      Height = 78
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lbl3: TLabel
        Left = 8
        Top = 1
        Width = 162
        Height = 14
        Caption = 'Clientes '#224' excluir da exporta'#231#227'o *'
      end
      object lbl4: TLabel
        Left = 8
        Top = 39
        Width = 188
        Height = 14
        Caption = 'Documentos '#224' excluir da exporta'#231#227'o **'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtNomCli: TEditFocus
        Left = 79
        Top = 15
        Width = 306
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 8
        Top = 15
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 1
        OnExit = edtCodCliExit
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDocExc: TEditFocus
        Tag = 99
        Left = 8
        Top = 53
        Width = 377
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        OnKeyPress = edtDocExcKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object pnlBase: TPanel
      Left = 1
      Top = 202
      Width = 394
      Height = 110
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lbl2: TLabel
        Left = 8
        Top = 39
        Width = 152
        Height = 14
        Caption = 'Parte Inicial do nome do arquivo'
      end
      object lblPatExp: TLabel
        Left = 8
        Top = 1
        Width = 75
        Height = 14
        Caption = 'Path de Destino'
      end
      object lblAlerta: TLabel
        Left = 8
        Top = 76
        Width = 240
        Height = 11
        Caption = '* Os clientes selecionados N'#195'O ir'#227'o sair no relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblAlerta2: TLabel
        Left = 8
        Top = 89
        Width = 257
        Height = 11
        Caption = '** Os documentos informados N'#195'O ir'#227'o sair no relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object edtNomArq: TEditFocus
        Left = 8
        Top = 53
        Width = 155
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      inline fraPatExp: TfraDirectoryEditFocus
        Left = 8
        Top = 15
        Width = 377
        Height = 24
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        inherited edtDirectory: TEditFocus
        end
      end
    end
  end
  object pgbProgresso: TProgressBar [3]
    Left = 0
    Top = 313
    Width = 396
    Height = 8
    Align = alBottom
    Smooth = True
    TabOrder = 3
  end
  inherited pnlStatus: TPanel
    Top = 349
    Width = 396
    TabOrder = 2
    ExplicitTop = 349
    ExplicitWidth = 396
    inherited pnlNomeForm: TPanel
      Left = 225
      ExplicitLeft = 225
    end
    inherited pnlInfo: TPanel
      Width = 225
      ExplicitWidth = 225
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 216
  end
end
