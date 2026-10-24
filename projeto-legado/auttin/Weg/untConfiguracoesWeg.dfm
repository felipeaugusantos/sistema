inherited frmConfiguracoesWeg: TfrmConfiguracoesWeg
  Width = 665
  Height = 408
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es Weg'
  Position = poMainFormCenter
  ExplicitWidth = 665
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 340
    Width = 659
    ExplicitTop = 340
    ExplicitWidth = 659
    DesignSize = (
      659
      28)
    inherited btnSair: TBitBtnLocked
      Left = 576
      ExplicitLeft = 576
    end
    object btnGravarConf: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
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
      TabOrder = 1
      OnClick = btnGravarConfClick
    end
    object btnRestaurar: TBitBtnLocked
      Left = 82
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Restaurar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      Visible = False
      OnClick = btnRestaurarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 368
    Width = 659
    ExplicitTop = 368
    ExplicitWidth = 659
    inherited pnlNomeForm: TPanel
      Left = 488
      ExplicitLeft = 488
    end
    inherited pnlInfo: TPanel
      Width = 488
      ExplicitWidth = 488
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 659
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Weg'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 23
    Width = 659
    Height = 317
    ActivePage = tbsConfCampos
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgcDadosChange
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      object Label2: TLabel
        Left = 23
        Top = 69
        Width = 128
        Height = 14
        Alignment = taRightJustify
        Caption = 'Trava para valor de venda'
      end
      object Label20: TLabel
        Left = 163
        Top = 69
        Width = 49
        Height = 14
        Caption = 'WEG_PRE'
      end
      object Label3: TLabel
        Left = 286
        Top = 69
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator'
      end
      object Label4: TLabel
        Left = 68
        Top = 93
        Width = 142
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
      end
      object Label5: TLabel
        Left = 33
        Top = 166
        Width = 145
        Height = 14
        Alignment = taRightJustify
        Caption = 'Path para arquivo de f'#243'rmulas'
      end
      object Label1: TLabel
        Left = 189
        Top = 166
        Width = 24
        Height = 14
        Caption = 'WEG'
      end
      object Label7: TLabel
        Left = 83
        Top = 119
        Width = 129
        Height = 14
        Alignment = taRightJustify
        Caption = 'Despesas Operacionais %'
      end
      object Label22: TLabel
        Left = 6
        Top = 144
        Width = 209
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
      end
      object chkUsaWeg: TCheckBox
        Tag = 99
        Left = 8
        Top = 29
        Width = 175
        Height = 18
        Caption = 'Utilizar essa tinta de m'#225'quina'
        TabOrder = 0
      end
      object edtTraWeg: TEditFocus
        Tag = 99
        Left = 219
        Top = 65
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFatWeg: TEditFocus
        Tag = 99
        Left = 319
        Top = 65
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtNfmWeg: TEditFocus
        Tag = 99
        Left = 219
        Top = 89
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesOpe: TEditFocus
        Tag = 99
        Left = 219
        Top = 113
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtApreve: TEditFocus
        Tag = 99
        Left = 219
        Top = 138
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      inline fraPatWeg: TfraDirectoryEditFocus
        Left = 219
        Top = 163
        TabOrder = 6
        Width = 318
        Height = 24
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        inherited edtDirectory: TEditFocus
        end
      end
      object chkUsaFor: TCheckBox
        Tag = 99
        Left = 191
        Top = 30
        Width = 175
        Height = 18
        Caption = 'Utilizar Formula'#231#227'o'
        TabOrder = 7
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 184
    Top = 24
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 24
  end
end
