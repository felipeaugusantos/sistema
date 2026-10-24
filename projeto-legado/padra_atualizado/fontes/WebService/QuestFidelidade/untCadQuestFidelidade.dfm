inherited frmCadQuestFidelidade: TfrmCadQuestFidelidade
  Width = 511
  Height = 605
  Caption = 'Pr'#233' Cadastro Quest Fidelidade'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 511
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 532
    Width = 505
    ExplicitTop = 532
    ExplicitWidth = 505
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 0
      Align = alNone
      TabOrder = 2
      Visible = False
      ExplicitLeft = 79
      ExplicitTop = 2
      ExplicitWidth = 0
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 425
      ExplicitLeft = 425
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
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
      OnClick = btnConfirmaDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 560
    Width = 505
    ExplicitTop = 560
    ExplicitWidth = 505
    inherited pnlNomeForm: TPanel
      Left = 334
      ExplicitLeft = 334
    end
    inherited pnlInfo: TPanel
      Width = 334
      ExplicitWidth = 334
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 505
    Height = 532
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object pnlQuest: TPanel
      Left = 1
      Top = 93
      Width = 503
      Height = 438
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 15
        Width = 94
        Height = 14
        Caption = 'Pontos Dispon'#237'veis:'
      end
      object Label2: TLabel
        Left = 30
        Top = 48
        Width = 80
        Height = 14
        Caption = 'Valor Dispon'#237'vel:'
      end
      object lblQuestPontos: TLabel
        Left = 116
        Top = 15
        Width = 85
        Height = 14
        Caption = 'lblQuestPontos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblQuestValor: TLabel
        Left = 116
        Top = 48
        Width = 74
        Height = 14
        Caption = 'lblQuestValor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 14
        Top = 93
        Width = 103
        Height = 14
        Caption = 'Hist'#243'rico de Compras'
      end
      object Label6: TLabel
        Left = 14
        Top = 264
        Width = 70
        Height = 14
        Caption = 'Ofertas Ativas'
      end
      object memHistoricoQuest: TMemo
        Left = 14
        Top = 110
        Width = 347
        Height = 148
        TabStop = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object memOfertasQuest: TMemo
        Left = 14
        Top = 281
        Width = 347
        Height = 148
        TabStop = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 503
      Height = 92
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblDocumento: TLabel
        Left = 8
        Top = 22
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = '1-CNPJ / 2-CPF:'
      end
      object lblEmail: TLabel
        Left = 57
        Top = 70
        Width = 27
        Height = 14
        Alignment = taRightJustify
        Caption = 'Email:'
      end
      object lblNome: TLabel
        Left = 54
        Top = 46
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object lblTelefone: TLabel
        Left = 278
        Top = 22
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Celular:'
      end
      object edtCgcCpf: TEditFocus
        Tag = 99
        Left = 86
        Top = 14
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtEmail: TEditFocus
        Tag = 99
        Left = 86
        Top = 62
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecLowerCase
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNome: TEditFocus
        Tag = 99
        Left = 86
        Top = 38
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumCgc: TMaskEditC_G_C_
        Tag = 99
        Left = 128
        Top = 14
        Width = 136
        Height = 22
        EditMask = '999.999.999-99;0;'
        MaxLength = 14
        TabOrder = 1
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtTelefone: TMaskEditTelefone
        Tag = 99
        Left = 316
        Top = 14
        Width = 176
        Height = 22
        EditMask = '!\(99\)9999-9999;0;_'
        MaxLength = 13
        TabOrder = 2
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
        Pais = opcBrasil
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 56
  end
end
