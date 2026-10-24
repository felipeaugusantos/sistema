inherited frmAltGlobalServico: TfrmAltGlobalServico
  Width = 688
  Height = 436
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Global do Valor de Servi'#231'o'
  Position = poMainFormCenter
  ExplicitWidth = 688
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 365
    Width = 682
    Height = 26
    TabOrder = 1
    ExplicitTop = 365
    ExplicitWidth = 688
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 159
      Width = 444
      Height = 22
      TabOrder = 3
      ExplicitLeft = 159
      ExplicitWidth = 450
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 603
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 609
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
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
      OnClick = btnConfirmaClick
    end
    object btnLimparBusca: TBitBtnLocked
      Left = 79
      Top = 2
      Width = 80
      Height = 22
      Align = alLeft
      Caption = 'Limpar Busca'
      TabOrder = 1
      OnClick = btnLimparBuscaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 682
    TabOrder = 2
    ExplicitTop = 391
    ExplicitWidth = 688
    inherited pnlNomeForm: TPanel
      Left = 511
      ExplicitLeft = 517
    end
    inherited pnlInfo: TPanel
      Width = 511
      ExplicitWidth = 517
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 682
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 688
    object dbgGrid: TDBGridCitel
      Left = 0
      Top = 145
      Width = 682
      Height = 214
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'SER_DESSER'
          Title.Caption = 'Servi'#231'o'
          Width = 245
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SER_VALSER'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Servi'#231'o Ant.'
          Width = 99
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SER_VALNOV'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Servi'#231'o Novo'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SER_VALCUS'
          Title.Caption = 'Vlr. Custo Ant.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SER_CUSNOV'
          Title.Caption = 'Vlr. Custo Novo'
          Width = 100
          Visible = True
        end>
    end
    object pnlSuperior: TPanel
      Left = 0
      Top = 0
      Width = 682
      Height = 145
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 688
      object lbl2: TLabel
        Left = 26
        Top = 16
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Servi'#231'o:'
      end
      object lblValEnt: TLabel
        Left = 216
        Top = 96
        Width = 186
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator para aplicar no Valor de Entrega:'
      end
      object Label1: TLabel
        Left = 33
        Top = 41
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo:'
      end
      object Label2: TLabel
        Left = 21
        Top = 68
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label3: TLabel
        Left = 33
        Top = 94
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object lblValCus: TLabel
        Left = 225
        Top = 119
        Width = 177
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator para aplicar no Valor do Custo:'
      end
      object edtCodSer: TEditFocus
        Tag = 99
        Left = 67
        Top = 12
        Width = 40
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodSerKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesSer: TEditFocus
        Left = 113
        Top = 12
        Width = 367
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValNov: TEditFocus
        Tag = 99
        Left = 408
        Top = 93
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 10
        TabOrder = 4
        OnEnter = edtValNovEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
      end
      object edtValPesq: TEditFocus
        Tag = 99
        Left = 67
        Top = 91
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 10
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
      end
      object edtDesGru: TEditFocus
        Left = 113
        Top = 37
        Width = 367
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSelect = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodGru: TEditFocus
        Tag = 99
        Left = 67
        Top = 37
        Width = 40
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 1
        OnKeyPress = edtCodGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomEmp: TEditFocus
        Left = 113
        Top = 65
        Width = 367
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 67
        Top = 64
        Width = 40
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
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
      object edtValCus: TEditFocus
        Tag = 99
        Left = 408
        Top = 116
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 10
        TabOrder = 5
        OnEnter = edtValCusEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
      end
    end
  end
  object pgbStatus: TProgressBar [3]
    Left = 0
    Top = 359
    Width = 682
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
    ExplicitWidth = 688
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 400
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 400
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 400
  end
end
