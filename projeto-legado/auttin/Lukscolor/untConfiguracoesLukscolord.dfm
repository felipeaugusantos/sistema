inherited frmConfiguracoesLukscolord: TfrmConfiguracoesLukscolord
  Left = 228
  Top = 141
  Width = 672
  Height = 520
  ActiveControl = nil
  Caption = 'Configura'#231#245'es - LuksColor'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 449
    Width = 664
    inherited btnSair: TBitBtn
      Left = 583
      TabOrder = 1
    end
    object btnGravarConf: TBitBtn
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      TabOrder = 0
      OnClick = btnGravarConfClick
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
    Top = 477
    Width = 664
    inherited pnlNomeForm: TPanel
      Left = 493
    end
    inherited pnlInfo: TPanel
      Width = 493
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 23
    Width = 664
    Height = 426
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 656
        Height = 394
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 9
          Top = 55
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label3: TLabel
          Left = 264
          Top = 55
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label20: TLabel
          Left = 141
          Top = 55
          Width = 45
          Height = 14
          Caption = 'LKD_PRE'
        end
        object Label4: TLabel
          Left = 44
          Top = 78
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
        end
        object Label5: TLabel
          Left = 95
          Top = 101
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos'
        end
        object chkUsaLkd: TCheckBox
          Tag = 99
          Left = 16
          Top = 30
          Width = 169
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraLkd: TEditFocus
          Tag = 99
          Left = 191
          Top = 51
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
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
        object edtFatLkd: TEditFocus
          Tag = 99
          Left = 297
          Top = 51
          Width = 57
          Height = 22
          CharCase = ecUpperCase
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
          Alignment = taLeftJustify
        end
        object edtNfmLkd: TEditFocus
          Tag = 99
          Left = 191
          Top = 74
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
          Alignment = taLeftJustify
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 197
          Top = 30
          Width = 116
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        inline fraTxtLkd: TfraDirectoryEditFocus
          Tag = 99
          Left = 191
          Top = 97
          Width = 314
          Height = 21
          TabOrder = 6
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
        object chkVenDin: TCheckBox
          Tag = 99
          Left = 360
          Top = 30
          Width = 137
          Height = 18
          Caption = 'Utilizar Venda Din'#226'mica'
          TabOrder = 2
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 664
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - LuksColor'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 20
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 583
    Top = 20
  end
end
